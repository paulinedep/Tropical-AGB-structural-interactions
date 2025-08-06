rm(list=ls())
gc()

# Initialisation ----------------------------------------------------------

pkgs = c("future", "showtext","rio","foreach", "doParallel","lidR", "terra", "sf", "tidyverse")

to_install = !pkgs %in% installed.packages() ; if(any(to_install)) {install.packages(pkgs[to_install])} ; inst = lapply(pkgs, library, character.only = TRUE) # load them

path0 = "E:/Arthur/OneDrive2/R/DoctoratGIS/OriginalDataFiles/Pauline_trees_Africa/"

setwd(path0)

# Loading raw data -------------------------------------------------------------------------

FieldInventories = rio::import(
  paste0(path0, "trees_final_with_temperament.csv"),
  sep = ",",
  dec = "."
) %>% 
  as_tibble()

# Fonctions ---------------------------------------------------------------
# Fonction pour quantifier la proportion de tempérament par plot
# Possibilité de choisir le nombre de subdivision des tempéraments : 2 ou 3, et le type de pondération : surface terrière (G) ou individus (ind)

Temperament.by.plot = function(FieldInventories,subdivision = 2, pond.rel_chr = "ind.rel") { # Fonction pour quantifier le tempérament des espèces par parcelles
  
  #Le nombre de subdivision ({subdivision}) permet de choisir si on veut inclure les héliophiles non pionniers demandeurs de lumière dans la catégorie héliophile, ou la garder dans une catégorie séparées (3 subdivision)
  #La pondération pour le calcul de la proportion de tempérament ({pond.rel_chr}) permet de choisir si on souhaite calculer une proportion en fonction du nombre d'individus observés par plot (pond.rel_chr = "ind.rel") ou si on souhaite pondérer par la surface terrière (pond.rel_chr = "G.rel)
  # --> Il est nécessaire d'avoir une colonne qui représente la surface terrière proportionnelle au plot de chaque observation (G_arbre / sum(G_arbre du plot)), ou la proportion que représente un individus (1/ sum(observations / plots))
  # Ici il est choisit d'ignorer les arbres qui ont été catégorisé comme 'Inconnu' ; c'est à dire ceux qui sont absents de la base de données CoForTraits, mais également ceux dont on n'a pas pu déterminer le tempérament dans la base de données CoForTraits
  
  if (!(pond.rel_chr %in% c('G.rel', 'ind.rel'))) {
    stop("pond.rel_chr doit être 'G.rel' ou 'ind.rel', selon le type de propotion : relative à un individu ou à la surface terrière (G) par rapport au reste de la parcelle")
  }
  
  if(pond.rel_chr == "G.rel"){
    
    G = "G"
    
    if (!G %in% names(FieldInventories)) {
      stop("Une colonne nommée 'G' doit être présente et contenir la surface terrière individuel d'un arbre")
    }
  }
  
  pond.rel = sym(pond.rel_chr) #Transforme la chaîne de caractère en un symbole qui représente un objet de l'environnement
  
  if (subdivision == 2) { 
    
    Temp.By.Plot = FieldInventories %>%
      filter(Temperament %in% c("héliophile" , "tolérante à l'ombrage")) %>%
      group_by(plot) %>%
      mutate(
        G.rel = G / sum(G, na.rm = TRUE),
        ind.rel = 1/n()
      ) %>%
      ungroup() %>%
      group_by(plot, Temperament) %>%
      summarise(Proportion = sum(!!pond.rel, na.rm = TRUE) * 100, .groups = 'drop') %>% #On  utilise '!!' avant le symbole pour pouvoir le call dans les fonctions
      mutate(
        Type_Proportion = pond.rel_chr,
        Type_subdivision = 2
      )
    
  } else if (subdivision == 3) {
    
    Temp.By.Plot = FieldInventories %>%
      filter(Temperament.3subdiv %in% c("héliophile" , "tolérante à l'ombrage", "héliophile non pionnière")) %>%
      group_by(plot) %>%
      mutate(
        G.rel = G / sum(G, na.rm = TRUE),
        ind.rel = 1/n()
      ) %>%
      ungroup() %>%
      group_by(plot, Temperament.3subdiv) %>%
      summarise(Proportion = sum(!!pond.rel, na.rm = TRUE) * 100, .groups = 'drop') %>%
      dplyr::select(Temperament = Temperament.3subdiv, everything()) %>%
      mutate(
        Type_Proportion = pond.rel_chr,
        Type_subdivision = 3
      ) 
      
  } else { Temp.By.Plot = "Subdivision doit être égal à 2 ou 3 (integer)" }
  
  return(Temp.By.Plot)
}

# Quantification du tempérament par parcelle sans distinction des catégories de hauteur ou de diamètre ----

# Combinaison des résultats dans un seul tibble
PlotsMetrics_Temperament_all <- Temperament.by.plot(FieldInventories, subdivision = 2, pond.rel_chr = 'G.rel') %>%
  bind_rows(Temperament.by.plot(FieldInventories, subdivision = 2, pond.rel_chr = 'ind.rel')) %>%
  bind_rows(Temperament.by.plot(FieldInventories, subdivision = 3, pond.rel_chr = 'G.rel')) %>%
  bind_rows(Temperament.by.plot(FieldInventories, subdivision = 3, pond.rel_chr = 'ind.rel'))

PlotsMetrics_3subdiv_ind.rel = PlotsMetrics_Temperament_all %>%
  filter(Type_Proportion == "ind.rel", Type_subdivision == 3)

length(unique(PlotsMetrics_3subdiv_ind.rel$plot))

tmp2 = rio::import(
  paste0(path0, "trees_final_arthur.csv"),
  sep = ",",
  dec = "."
)

length(unique(tmp2$PLT_trois_bis))
length(unique(FieldInventories$plot))

plot1 = unique(FieldInventories$plot)
plot2 = unique(PlotsMetrics_Temperament_all$plot)

lost = plot1[!plot1 %in% plot2]

info_lost = FieldInventories %>%
  filter(plot %in% lost)

sp_no_in_cofor = info_lost %>%
  group_by(plot) %>%
  summarise(unique_species = unique(species.full))
  

rio::export(
  PlotsMetrics_3subdiv_ind.rel,
  paste0(path0, "plot_metrics_temperament_final_ind.rel_3subdiv.csv"),
  sep = ",",
  dec = "."
)

rio::export(
  PlotsMetrics_Temperament_all,
  paste0(path0, "plot_metrics_temperament_final.csv"),
  sep = ",",
  dec = "."
)


# Graphique pour comparer l'influence du choix de la métrique relative : G ou ind ----

data_graph <- PlotsMetrics_Temperament_all %>%
  mutate(
    measure = paste(Temperament, Type_subdivision, sep = " - Subdivision "),
  ) 
  

p1 = ggplot(data_graph, aes(x = Type_Proportion, y = Proportion, fill = Type_Proportion)) +
  geom_boxplot() +
  facet_wrap(~measure, scales = "free") +
  theme_light() +
  labs(
    title = "Comparaison de l'influence de la pondération par plot :relative au nombre d'individus \n(ind.rel) ou à la surface terrière (G.rel) sur la proportion de tempérament par plot",
    y = "Proportion tempérament",
    x = ""
  ) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5)
  )

ggsave(paste0(path0, "Temperament_influence_pondérationPlots_boxplots.svg"), plot = p1, width = 15, height = 10, device = "svg")


