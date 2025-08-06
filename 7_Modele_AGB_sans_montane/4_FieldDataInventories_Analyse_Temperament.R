rm(list=ls())
gc()

# Initialisation ----------------------------------------------------------

pkgs = c("future","sysfonts", "showtext","rio","foreach", "doParallel","lidR", "terra", "sf", "tidyverse", "BIOMASS")

to_install = !pkgs %in% installed.packages() ; if(any(to_install)) {install.packages(pkgs[to_install])} ; inst = lapply(pkgs, library, character.only = TRUE) # load them

path0 = "E:/Arthur/OneDrive2/R/DoctoratGIS/OriginalDataFiles/Pauline_trees_Africa/"

setwd(path0)

# Loading raw data -------------------------------------------------------------------------

CoFor_raw = rio::import(paste0(path0,"cofortraits.csv"),
                    sep = ';', dec = ',', encoding = "unknown") %>%
  as_tibble() %>%
  tidyr::separate(Species, into = c("genus", "species"), sep = " ") %>%
  filter(!is.na(id_taxon_name))

FieldInventories = rio::import(
  paste0(path0, "trees_final_arthur.csv"),
  sep = ",",
  dec = "."
) %>% 
  as_tibble() %>%
  dplyr::select(plot = PLT_trois_bis, dbh = DBH, fam = family.y, genus = genus.y, species = species.y) %>%
  mutate(species.full = paste(genus, species),
         G = pi*(0.01*dbh/2)^2 # Pour chaque arbre, calcul de sa surface terrière
  ) 


# Fonctions ---------------------------------------------------------------

# Fonction pour extraire le tempérament des espèces, genre et familly dans la base de données CoFor (entrée de la fonction, sans modification de noms de colonnes dans la base de données CoFor initiale ; en cas de bug par modification de la base de données, ajuster les noms de colonnes)

CoFor.UniqueTemperament = function(CoFor, subdivision = 2){
  
  taxo = CoFor %>%
    distinct(species.full, Genus, Family)
  
  db = CoFor %>%
    filter(trait_concept_name == 'tempérament (guilde de régénération)') %>% 
    dplyr::select(species.full, attributed_category_with_thesaurus, SampleValueMRM) %>%
    mutate(SampleValueMRM = case_when(SampleValueMRM == "" ~ attributed_category_with_thesaurus, TRUE ~ SampleValueMRM)) %>%
    dplyr::select(species.full, Temperament = SampleValueMRM) %>%
    mutate(Temperament = case_when(
      Temperament %in% c("catégorie inconnue", "tolérante à l'ombrage", "héliophile non pionnière", "pionnière") ~ Temperament,
      TRUE ~ "other"
    )) %>%
    group_by(species.full, Temperament) %>%
    summarize(count = n()) %>%
    ungroup() %>%
    pivot_wider(names_from = Temperament, values_from = count, values_fill = list(count = 0)) %>%
    left_join(taxo, by = "species.full") %>%
    mutate(n_subdiv = subdivision)
    
  
  if(!'other' %in% colnames(db)){
    db <- db %>%
      mutate(a = `catégorie inconnue`,
             b = `tolérante à l'ombrage`,
             c = `héliophile non pionnière`,
             d = `pionnière`,
             e = 0)
  } else {
    db <- db %>%
      mutate(a = `catégorie inconnue`,
             b = `tolérante à l'ombrage`,
             c = `héliophile non pionnière`,
             d = `pionnière`,
             e = `other`)
  }
  
  if (subdivision == 2){
    
    db <- db %>%
      mutate(max_temp = case_when(
        a > b & a > c & a > d ~ "catégorie inconnue",
        b >= a & b >= c & b > d ~ "tolérante à l'ombrage",
        c > b & c >= d & c >= a ~ "héliophile",
        d >= c & d >= a & d > b ~ "héliophile",
        b == d & c > 0 ~ "héliophile",
        b == d & (a >= 0 | e >= 0) ~ "no-consensus",
        b == 0 & d == 0 & c == 0 & (a >= 0 | e >= 0) ~ "no-consensus",
        
        TRUE ~ "need check"
      )) %>%
      dplyr::select(-a, -b, -c, -d, -e)
    
  } else if (subdivision == 3){
    
    db <- db %>%
      mutate(max_temp = case_when(
        a > b & a > c & a > d ~ "catégorie inconnue",
        b >= a & b >= c & b > d ~ "tolérante à l'ombrage",
        c > b & c >= d & c >= a ~ "héliophile non pionnière",
        d > c & d >= a & d > b ~ "héliophile",
        b == d & c > 0 ~ "héliophile",
        c == d & d > 0 ~ "héliophile non pionnière",
        b == d & (a >= 0 | e >= 0) ~ "no-consensus",
        b == 0 & d == 0 & c == 0 & (a >= 0 | e >= 0) ~ "no-consensus",
        
        TRUE ~ "need check"
      )) %>%
      dplyr::select(-a, -b, -c, -d, -e)
    
  } else {db = "Subdivision doit être égal à 2 ou 3 (integer)"}
  
  return (db)
}
CoFor.UniqueTemperament_genus_consensus = function(CoFor.Temp, subdivision = 2){
  
  db <- CoFor.Temp %>%
    group_by(Genus) %>%
    summarize(
      `catégorie inconnue` = sum(max_temp == "catégorie inconnue"),
      `tolérante à l'ombrage` = sum(max_temp == "tolérante à l'ombrage"),
      `héliophile non pionnière` = sum(max_temp == "héliophile non pionnière"),
      pionnière = sum(max_temp == "héliophile" | max_temp == "pionnière"),
      other = sum(max_temp == "no-consensus" | max_temp == "need check"),
      .groups = 'drop'
    ) %>%
    mutate(
      a = `catégorie inconnue`,
      b = `tolérante à l'ombrage`,
      c = `héliophile non pionnière`,
      d = pionnière,
      e = other
    )
  
  # Fonction pour déterminer max_temp
  get_max_temp <- function(a, b, c, d, e, subdivision) {
    if (subdivision == 2) {
      case_when(
        a > b & a > c & a > d ~ "catégorie inconnue",
        b >= a & b >= c & b > d ~ "tolérante à l'ombrage",
        (c > b & c >= d & c >= a) | (d >= c & d >= a & d > b) ~ "héliophile",
        b == d & c > 0 ~ "héliophile",
        b == d & (a > 0 | e > 0) ~ "no-consensus",
        b == 0 & d == 0 & c == 0 & (a > 0 | e > 0) ~ "no-consensus",
        TRUE ~ "need check"
      )
    } else if (subdivision == 3) {
      case_when(
        a > b & a > c & a > d ~ "catégorie inconnue",
        b >= a & b >= c & b > d ~ "tolérante à l'ombrage",
        c > b & c >= d & c >= a ~ "héliophile non pionnière",
        d > c & d >= a & d > b ~ "héliophile",
        b == d & c > 0 ~ "héliophile non pionnière",
        c == d & d > 0 ~ "héliophile non pionnière",
        b == d & (a > 0 | e > 0) ~ "no-consensus",
        b == 0 & d == 0 & c == 0 & (a > 0 | e > 0) ~ "no-consensus",
        TRUE ~ "need check"
      )
    } else {
      "Subdivision doit être égal à 2 ou 3 (integer)"
    }
  }
  
  # Appliquer la fonction pour les deux subdivisions
  db <- db %>%
    mutate(
      max_temp = case_when(
        subdivision == 2 ~ get_max_temp(a, b, c, d, e, 2),
        subdivision == 3 ~ get_max_temp(a, b, c, d, e, 3),
        TRUE ~ "Subdivision doit être égal à 2 ou 3 (integer)"
      )
    )
  
  # Sélectionner les colonnes finales
  db <- db %>%
    dplyr::select(Genus, `catégorie inconnue`, `tolérante à l'ombrage`, `héliophile non pionnière`, pionnière, other,
           max_temp)
  
  return (db)
}
CoFor.UniqueTemperament_family_consensus = function(CoFor.Temp, subdivision = 2){
  
  db <- CoFor.Temp %>%
    group_by(Family) %>%
    summarize(
      `catégorie inconnue` = sum(max_temp == "catégorie inconnue"),
      `tolérante à l'ombrage` = sum(max_temp == "tolérante à l'ombrage"),
      `héliophile non pionnière` = sum(max_temp == "héliophile non pionnière"),
      pionnière = sum(max_temp == "héliophile" | max_temp == "pionnière"),
      other = sum(max_temp == "no-consensus" | max_temp == "need check"),
      .groups = 'drop'
    ) %>%
    mutate(
      a = `catégorie inconnue`,
      b = `tolérante à l'ombrage`,
      c = `héliophile non pionnière`,
      d = pionnière,
      e = other
    )
  
  # Fonction pour déterminer max_temp
  get_max_temp <- function(a, b, c, d, e, subdivision) {
    if (subdivision == 2) {
      case_when(
        a > b & a > c & a > d ~ "catégorie inconnue",
        b >= a & b >= c & b > d ~ "tolérante à l'ombrage",
        (c > b & c >= d & c >= a) | (d >= c & d >= a & d > b) ~ "héliophile",
        b == d & c > 0 ~ "héliophile",
        b == d & (a > 0 | e > 0) ~ "no-consensus",
        b == 0 & d == 0 & c == 0 & (a > 0 | e > 0) ~ "no-consensus",
        TRUE ~ "need check"
      )
    } else if (subdivision == 3) {
      case_when(
        a > b & a > c & a > d ~ "catégorie inconnue",
        b >= a & b >= c & b > d ~ "tolérante à l'ombrage",
        c > b & c >= d & c >= a ~ "héliophile non pionnière",
        d > c & d >= a & d > b ~ "héliophile",
        b == d & c > 0 ~ "héliophile non pionnière",
        c == d & d > 0 ~ "héliophile non pionnière",
        b == d & (a > 0 | e > 0) ~ "no-consensus",
        b == 0 & d == 0 & c == 0 & (a > 0 | e > 0) ~ "no-consensus",
        TRUE ~ "need check"
      )
    } else {
      "Subdivision doit être égal à 2 ou 3 (integer)"
    }
  }
  
  # Appliquer la fonction pour les deux subdivisions
  db <- db %>%
    mutate(
      max_temp = case_when(
        subdivision == 2 ~ get_max_temp(a, b, c, d, e, 2),
        subdivision == 3 ~ get_max_temp(a, b, c, d, e, 3),
        TRUE ~ "Subdivision doit être égal à 2 ou 3 (integer)"
      )
    )
  
  # Sélectionner les colonnes finales
  db <- db %>%
    dplyr::select(Family, `catégorie inconnue`, `tolérante à l'ombrage`, `héliophile non pionnière`, pionnière, other,
                  max_temp)
  
  return (db)
}

# Correction de la base de données CoFor pour correspondre aux nom --------

# Dans la base de données CoFor, créer un nouveau df qui contient les noms d'espèces uniques et leurs ID, et filtre les NA

taxo = correctTaxo(genus = CoFor_raw$genus , species = CoFor_raw$species, useCache = F, verbose = F) %>% as_tibble() #Récupère la base de données des noms de genre et d'espèce corrigée selon les standards Taxonomic Name Resolution Service (TNRS)

CoFor = CoFor_raw %>%
  mutate(genus = taxo$genusCorrected) %>% #Remplace le nom de genre initiale de la base de données par le nom de genre corrigé selon les standards TNRS
  mutate(species = taxo$speciesCorrected) %>%
  mutate(species.full = paste(genus, species))

# Identification des espèces observées sur le terrain qui ne matchent pas et celles qui sont présentes dans la base de données CoFor ------

FieldInventories = FieldInventories %>% 
  mutate(sp_in_CoFor = species.full %in% CoFor$species.full) 

liste_sp_out_CoFor = FieldInventories %>%
  filter(!sp_in_CoFor) %>%
  dplyr::select(species.full) %>% 
  unique()

liste_sp_in_CoFor =  FieldInventories %>%
  filter(sp_in_CoFor) %>%
  dplyr::select(species.full) %>% 
  unique()

# Plots functionnal metrics from CoForTraits ---------------------------

CoFor.Temp = CoFor.UniqueTemperament(CoFor, subdivision = 2) #Appliquer la fonction pour créer la DB de tempérament de CoForTraits pour les espèces
CoFor.Temp.3subdiv = CoFor.UniqueTemperament(CoFor, subdivision = 3) #Appliquer la fonction pour créer la DB de tempérament de CoForTraits pour les espèces

CoFor.Temp_genus_consensus = CoFor.UniqueTemperament_genus_consensus(CoFor.Temp, subdivision = 2) #Appliquer la fonction pour créer la DB de tempérament de CoForTraits pour le genre
CoFor.Temp_genus.3subdiv_consensus = CoFor.UniqueTemperament_genus_consensus(CoFor.Temp.3subdiv, subdivision = 3) #Appliquer la fonction pour créer la DB de tempérament de CoForTraits pour le genre

CoFor.Temp_family_consensus = CoFor.UniqueTemperament_family_consensus(CoFor.Temp, subdivision = 2) #Appliquer la fonction pour créer la DB de tempérament de CoForTraits pour le genre
CoFor.Temp_family.3subdiv_consensus = CoFor.UniqueTemperament_family_consensus(CoFor.Temp.3subdiv, subdivision = 3) #Appliquer la fonction pour créer la DB de tempérament de CoForTraits pour le genre


#Récupère le tempérament des espèces, genre ou famille qui sont présentes dans la base de données CoFor
Field.Temp.sp = CoFor.Temp %>%
  filter(species.full %in% FieldInventories$species.full)

Field.Temp.genus = CoFor.Temp_genus_consensus %>%
  filter(Genus %in% FieldInventories$genus)

Field.Temp.fam = CoFor.Temp_family_consensus %>%
  filter(Family %in% FieldInventories$fam)

Field.Temp.sp.3subdiv = CoFor.Temp.3subdiv %>%
  filter(species.full %in% FieldInventories$species.full)

Field.Temp.genus.3subdiv = CoFor.Temp_genus.3subdiv_consensus %>%
  filter(Genus %in% FieldInventories$genus)

Field.Temp.fam.3subdiv = CoFor.Temp_family.3subdiv_consensus %>%
  filter(Family %in% FieldInventories$fam)

# Injecter dans les données de terrain le tempérament

FieldInventories = FieldInventories %>% 
  left_join(Field.Temp.sp %>% dplyr::select(species.full, Temperament.sp = max_temp)) %>%
  left_join(Field.Temp.genus %>% dplyr::select(genus = Genus, Temperament.genus = max_temp)) %>%
  left_join(Field.Temp.fam %>% dplyr::select(fam = Family, Temperament.fam = max_temp)) %>%
  
  left_join(Field.Temp.sp.3subdiv %>% dplyr::select(species.full, Temperament.sp.3subdiv = max_temp)) %>%
  left_join(Field.Temp.genus.3subdiv %>% dplyr::select(genus = Genus, Temperament.genus.3subdiv = max_temp)) %>%
  left_join(Field.Temp.fam.3subdiv %>% dplyr::select(fam = Family, Temperament.fam.3subdiv = max_temp)) %>%
  
  mutate(Temperament = if_else(!is.na(Temperament.sp), Temperament.sp,
                               if_else(!is.na(Temperament.genus), Temperament.genus,
                                       if_else(!is.na(Temperament.fam), Temperament.fam, NA_character_))),
         level_Temperament = if_else(!is.na(Temperament.sp), "species",
                                     if_else(!is.na(Temperament.genus), "genus",
                                             if_else(!is.na(Temperament.fam), "family", NA_character_)))) %>%
  
  mutate(Temperament.3subdiv = if_else(!is.na(Temperament.sp.3subdiv), Temperament.sp.3subdiv,
                               if_else(!is.na(Temperament.genus.3subdiv), Temperament.genus.3subdiv,
                                       if_else(!is.na(Temperament.fam.3subdiv), Temperament.fam.3subdiv, NA_character_))),
         level_Temperament.3subdiv = if_else(!is.na(Temperament.sp.3subdiv), "species",
                                     if_else(!is.na(Temperament.genus.3subdiv), "genus",
                                             if_else(!is.na(Temperament.fam.3subdiv), "family", NA_character_)))) %>%
  
  dplyr::select(-Temperament.sp, -Temperament.genus, -Temperament.fam,-Temperament.sp.3subdiv, -Temperament.genus.3subdiv, -Temperament.fam.3subdiv) %>%
  
  mutate(
    Temperament = replace_na(Temperament, "Inconnu"),
    level_Temperament = replace_na(level_Temperament, "Inconnu"),
    Temperament.3subdiv = replace_na(Temperament.3subdiv, "Inconnu"),
    level_Temperament.3subdiv = replace_na(level_Temperament.3subdiv, "Inconnu")
  )

rio::export(
  FieldInventories,
  paste0(path0, "trees_final_with_temperament.csv"),
  sep = ",",
  dec = "."
)

