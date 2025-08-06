rm(list=ls()) 

#Packages
library(data.table)
library(ggplot2)
library(plyr)
library(ggpubr)
library(sjPlot)
library(ggeffects) 

#Directory
setwd("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/8_Graph")

data<-fread("Pantropical_dataset_2023plots_V2_N_55_1_SOIL.csv")


data<-data[!elevation.y>=1000]
data<-data[!is.na(Bio1_WC)]

pion<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/pourc_pionnier_Af.csv")

result <- merge(data, pion[, .(plot, Proportion)], by.x = "PLT_trois_bis", by.y = "plot", all.x = TRUE)
result[is.na(Proportion)&Continent=="Africa",uniqueN(PLT_trois_bis)]#28 plots ont pas

result<-result[!(Continent == "Africa" & is.na(Proportion))]
data<-result[!elevation.y>=1000]

data[,DBHqm2:=DBHqm]
data[,BA2:=BA]

data[,WDba2:=WDba]
###########################################################################################################################

bestMEM_DBHqmAf<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_DBHqmAf_WC_af.csv")
bestMEM_DBHqmAf[,Proportion:=NULL]

bestMEM_DBHqmOc<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_DBHqmOc_WC.csv")

bestMEM_DBHqmSA<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_DBHqmSA_WC.csv")

bestMEM_DBHqmAs<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_DBHqmAs_WC.csv")

bestMEM_DBHqmNA<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_DBHqmNA_WC.csv")

bestMEM_DBHqm<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_DBHqm_WC_pan.csv")


bestMEM_BAAf<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_BAAf_WC_af.csv")
bestMEM_BAAf[,Proportion:=NULL]

bestMEM_BAOc<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_BAOc_WC.csv")

bestMEM_BASA<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_BASA_WC.csv")

bestMEM_BAAs<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_BAAs_WC.csv")

bestMEM_BANA<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_BANA_WC.csv")

bestMEM_BA<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_BA_WC_pan.csv")


bestMEM_WDbaAf<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_WDbaAf_WC_af.csv")
bestMEM_WDbaAf[,Proportion:=NULL]

bestMEM_WDbaOc<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_WDbaOc_WC.csv")

bestMEM_WDbaSA<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_WDbaSA_WC.csv")

bestMEM_WDbaAs<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_WDbaAs_WC.csv")

bestMEM_WDbaNA<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_WDbaNA_WC.csv")

bestMEM_WDba<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modele_AGB_sans_montane/bestMEM_WDba_WC_pan.csv")


bestMEM_SDAf<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modeles_bis_sans_montane/bestMEM_SDAf_WC_af.csv")
bestMEM_SDAf[,Proportion:=NULL]

bestMEM_SDOc<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modeles_bis_sans_montane/bestMEM_SDOc_WC.csv")

bestMEM_SDSA<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modeles_bis_sans_montane/bestMEM_SDSA_WC.csv")

bestMEM_SDAs<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modeles_bis_sans_montane/bestMEM_SDAs_WC.csv")

bestMEM_SDNA<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modeles_bis_sans_montane/bestMEM_SDNA_WC.csv")

bestMEM_SD<-fread("C:/Users/u237004/Documents/1_Boulot_SC/2_Papier Pan/Work/MM/7_Modeles_bis_sans_montane/bestMEM_SD_WC_pan.csv")


#1) DBHqm stand ######################################################################################################################################################


mems <- bestMEM_DBHqmAf[, c( 10:ncol(bestMEM_DBHqmAf)), with = FALSE]
tab <- data[Continent=="Africa",.(SD)]
tab2<-cbind(tab,data[Continent=="Africa",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("DBHqm2 ~",  env_formula, "+", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabAf=cbind(bestMEM_DBHqmAf[, 1, drop = FALSE],tab2,mems)

DBHqm_F_Af=lm(model_formula, data=tabAf)
summary(DBHqm_F_Af)
tabAf=tabAf[,Continent:="Africa"]

mems <- bestMEM_DBHqmNA[, c( 10:ncol(bestMEM_DBHqmNA)), with = FALSE]
tab <-  data[Continent=="North America",.(SD)]
tab2<-cbind(tab,data[Continent=="North America",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("DBHqm2 ~",   env_formula, "+", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabNA=cbind(bestMEM_DBHqmNA[, 1, drop = FALSE],tab2,mems)

DBHqm_F_NA=lm(model_formula, data=tabNA)
summary(DBHqm_F_NA)
tabNA=tabNA[,Continent:="North America"]

mems <- bestMEM_DBHqmSA[, c( 10:ncol(bestMEM_DBHqmSA)), with = FALSE]
tab <-  data[Continent=="South America",.(SD)]
tab2<-cbind(tab,data[Continent=="South America",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("DBHqm2 ~",   env_formula, " +", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabSA=cbind(bestMEM_DBHqmSA[, 1, drop = FALSE],tab2,mems)

DBHqm_F_SA=lm(model_formula, data=tabSA)
summary(DBHqm_F_SA)
tabSA=tabSA[,Continent:="South America"]

mems <- bestMEM_DBHqmOc[, c( 10:ncol(bestMEM_DBHqmOc)), with = FALSE]
tab <- data[Continent=="Oceania",.(SD)]
tab2<-cbind(tab,data[Continent=="Oceania",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("DBHqm2 ~",   env_formula, " +", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabOc=cbind(bestMEM_DBHqmOc[, 1, drop = FALSE],tab2,mems)

DBHqm_F_Oc=lm(model_formula, data=tabOc)
summary(DBHqm_F_Oc)
tabOc=tabOc[,Continent:="Oceania"]

mems <- bestMEM_DBHqmAs[, c( 10:ncol(bestMEM_DBHqmAs)), with = FALSE]
tab <-  data[Continent=="Eurasia",.(SD)]
tab2<-cbind(tab,data[Continent=="Eurasia",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("DBHqm2 ~",   env_formula, " +", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabAs=cbind(bestMEM_DBHqmAs[, 1, drop = FALSE],tab2,mems)

DBHqm_F_As=lm(model_formula, data=tabAs)
summary(DBHqm_F_As)
tabAs=tabAs[,Continent:="Eurasia"]



##Bio1###############################################################################################################################################################

get_linetype <- function(model) {
  coef_summary <- summary(model)$coefficients
  if ("Bio1_un" %in% rownames(coef_summary)) {
    pval <- coef_summary["Bio1_un", "Pr(>|t|)"]
    if (!is.na(pval) && pval < 0.05) {
      return("longdash")
    }
  }
  return("solid")
}
# Obtention des prédictions pour la variable 'Bio1' pour chaque modèle
pred_Af <- ggpredict(DBHqm_F_Af, terms = "Bio1_un")
pred_SA <- ggpredict(DBHqm_F_SA, terms = "Bio1_un")
pred_As <- ggpredict(DBHqm_F_As, terms = "Bio1_un")
pred_Oc <- ggpredict(DBHqm_F_Oc, terms = "Bio1_un")
pred_NA <- ggpredict(DBHqm_F_NA, terms = "Bio1_un")

# Ajout d'une colonne pour identifier le modèle (Afrique ou Amérique du Sud)
pred_Af$model <- "Africa"
pred_SA$model <- "South America"
pred_As$model <- "Eurasia"
pred_Oc$model <- "Oceania"
pred_NA$model <- "North America"

# Combinaison des prédictions dans un seul data frame
pred_data <- rbind(pred_Af, pred_SA,pred_Oc,pred_As,pred_NA)



# Ajout du linetype basé sur la significativité
linetype_df <- data.frame(
  model = c("Africa", "South America", "Eurasia", "Oceania", "North America"),
  linetype = c(
    get_linetype(DBHqm_F_Af),
    get_linetype(DBHqm_F_SA),
    get_linetype(DBHqm_F_As),
    get_linetype(DBHqm_F_Oc),
    get_linetype(DBHqm_F_NA)
  )
)

# Fusion avec les prédictions
pred_data <- merge(pred_data, linetype_df, by = "model")


dbh_a <- ggplot() +
  # Points observés
  geom_point(data = tabAf, aes(x = Bio1_un, y = DBHqm2), color = "cyan4", size = 2, alpha = 0.1) +
  geom_point(data = tabSA, aes(x = Bio1_un, y = DBHqm2), color = "darkorange", size = 2, alpha = 0.1) +
  geom_point(data = tabOc, aes(x = Bio1_un, y = DBHqm2), color = "skyblue1", size = 2, alpha = 0.1) +
  geom_point(data = tabAs, aes(x = Bio1_un, y = DBHqm2), color = "mediumorchid3", size = 2, alpha = 0.1) +
  geom_point(data = tabNA, aes(x = Bio1_un, y = DBHqm2), color = "goldenrod1", size = 2, alpha = 0.1) +
  
  # Lignes de régression avec linetype conditionnel
  geom_line(data = pred_data, aes(x = x, y = predicted, color = model, linetype = linetype), size = 1.5) +
  
  theme_test() +
  theme(legend.position = "none", text = element_text(size = 15)) +
  
  scale_color_manual(values = c("Africa" = "cyan4", "Eurasia" = "mediumorchid3", 
                                "North America" = "goldenrod1", "Oceania" = "skyblue1", 
                                "South America" = "darkorange")) +
  
  labs(x = "Mean annual temperature (°C)", y = "Mean quadratic\ndiameter (cm)", color = "Continent") +
  ggtitle("")
dbh_a




##Bio12###############################################################################################################################################################

get_linetype <- function(model) {
  coef_summary <- summary(model)$coefficients
  if ("Bio12_un" %in% rownames(coef_summary)) {
    pval <- coef_summary["Bio12_un", "Pr(>|t|)"]
    if (!is.na(pval) && pval < 0.05) {
      return("longdash")
    }
  }
  return("solid")
}
# Obtention des prédictions pour la variable 'Bio12' pour chaque modèle
pred_Af <- ggpredict(DBHqm_F_Af, terms = "Bio12_un")
pred_SA <- ggpredict(DBHqm_F_SA, terms = "Bio12_un")
pred_As <- ggpredict(DBHqm_F_As, terms = "Bio12_un")
pred_Oc <- ggpredict(DBHqm_F_Oc, terms = "Bio12_un")
pred_NA <- ggpredict(DBHqm_F_NA, terms = "Bio12_un")

# Ajout d'une colonne pour identifier le modèle (Afrique ou Amérique du Sud)
pred_Af$model <- "Africa"
pred_SA$model <- "South America"
pred_As$model <- "Eurasia"
pred_Oc$model <- "Oceania"
pred_NA$model <- "North America"

# Combinaison des prédictions dans un seul data frame
pred_data <- rbind(pred_Af, pred_SA,pred_Oc,pred_As,pred_NA)



# Ajout du linetype basé sur la significativité
linetype_df <- data.frame(
  model = c("Africa", "South America", "Eurasia", "Oceania", "North America"),
  linetype = c(
    get_linetype(DBHqm_F_Af),
    get_linetype(DBHqm_F_SA),
    get_linetype(DBHqm_F_As),
    get_linetype(DBHqm_F_Oc),
    get_linetype(DBHqm_F_NA)
  )
)

# Fusion avec les prédictions
pred_data <- merge(pred_data, linetype_df, by = "model")


dbh_b <- ggplot() +
  # Points observés
  geom_point(data = tabAf, aes(x = Bio12_un, y = DBHqm2), color = "cyan4", size = 2, alpha = 0.1) +
  geom_point(data = tabSA, aes(x = Bio12_un, y = DBHqm2), color = "darkorange", size = 2, alpha = 0.1) +
  geom_point(data = tabOc, aes(x = Bio12_un, y = DBHqm2), color = "skyblue1", size = 2, alpha = 0.1) +
  geom_point(data = tabAs, aes(x = Bio12_un, y = DBHqm2), color = "mediumorchid3", size = 2, alpha = 0.1) +
  geom_point(data = tabNA, aes(x = Bio12_un, y = DBHqm2), color = "goldenrod1", size = 2, alpha = 0.1) +
  
  # Lignes de régression avec linetype conditionnel
  geom_line(data = pred_data, aes(x = x, y = predicted, color = model, linetype = linetype), size = 1.5) +
  
  theme_test() +
  theme(legend.position = "none", text = element_text(size = 15)) +
  
  scale_color_manual(values = c("Africa" = "cyan4", "Eurasia" = "mediumorchid3", 
                                "North America" = "goldenrod1", "Oceania" = "skyblue1", 
                                "South America" = "darkorange")) +
  
  labs(x = "Total annual precipitation (mm)", y = "Mean quadratic\ndiameter (cm)", color = "Continent") +
  ggtitle("")
dbh_b



##Bio15###############################################################################################################################################################

get_linetype <- function(model) {
  coef_summary <- summary(model)$coefficients
  if ("Bio15_un" %in% rownames(coef_summary)) {
    pval <- coef_summary["Bio15_un", "Pr(>|t|)"]
    if (!is.na(pval) && pval < 0.05) {
      return("longdash")
    }
  }
  return("solid")
}
# Obtention des prédictions pour la variable 'Bio15' pour chaque modèle
pred_Af <- ggpredict(DBHqm_F_Af, terms = "Bio15_un")
pred_SA <- ggpredict(DBHqm_F_SA, terms = "Bio15_un")
pred_As <- ggpredict(DBHqm_F_As, terms = "Bio15_un")
pred_Oc <- ggpredict(DBHqm_F_Oc, terms = "Bio15_un")
pred_NA <- ggpredict(DBHqm_F_NA, terms = "Bio15_un")

# Ajout d'une colonne pour identifier le modèle (Afrique ou Amérique du Sud)
pred_Af$model <- "Africa"
pred_SA$model <- "South America"
pred_As$model <- "Eurasia"
pred_Oc$model <- "Oceania"
pred_NA$model <- "North America"

# Combinaison des prédictions dans un seul data frame
pred_data <- rbind(pred_Af, pred_SA,pred_Oc,pred_As,pred_NA)



# Ajout du linetype basé sur la significativité
linetype_df <- data.frame(
  model = c("Africa", "South America", "Eurasia", "Oceania", "North America"),
  linetype = c(
    get_linetype(DBHqm_F_Af),
    get_linetype(DBHqm_F_SA),
    get_linetype(DBHqm_F_As),
    get_linetype(DBHqm_F_Oc),
    get_linetype(DBHqm_F_NA)
  )
)

# Fusion avec les prédictions
pred_data <- merge(pred_data, linetype_df, by = "model")


dbh_c <- ggplot() +
  # Points observés
  geom_point(data = tabAf, aes(x = Bio15_un, y = DBHqm2), color = "cyan4", size = 2, alpha = 0.1) +
  geom_point(data = tabSA, aes(x = Bio15_un, y = DBHqm2), color = "darkorange", size = 2, alpha = 0.1) +
  geom_point(data = tabOc, aes(x = Bio15_un, y = DBHqm2), color = "skyblue1", size = 2, alpha = 0.1) +
  geom_point(data = tabAs, aes(x = Bio15_un, y = DBHqm2), color = "mediumorchid3", size = 2, alpha = 0.1) +
  geom_point(data = tabNA, aes(x = Bio15_un, y = DBHqm2), color = "goldenrod1", size = 2, alpha = 0.1) +
  
  # Lignes de régression avec linetype conditionnel
  geom_line(data = pred_data, aes(x = x, y = predicted, color = model, linetype = linetype), size = 1.5) +
  
  theme_test() +
  theme(legend.position = "none", text = element_text(size = 15)) +
  
  scale_color_manual(values = c("Africa" = "cyan4", "Eurasia" = "mediumorchid3", 
                                "North America" = "goldenrod1", "Oceania" = "skyblue1", 
                                "South America" = "darkorange")) +
  
  labs(x = "Precipitation seasonality (%)", y = "Mean quadratic\ndiameter (cm)", color = "Continent") +
  ggtitle("")
dbh_c






#2) BA stand ######################################################################################################################################################


mems <- bestMEM_BAAf[, c( 11:ncol(bestMEM_BAAf)), with = FALSE]
tab <- data[Continent=="Africa",.(SD,DBHqm)]
tab2<-cbind(tab,data[Continent=="Africa",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("BA2 ~",  env_formula, "+", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabAf=cbind(bestMEM_BAAf[, 1, drop = FALSE],tab2,mems)

BA_F_Af=lm(model_formula, data=tabAf)
summary(BA_F_Af)
tabAf=tabAf[,Continent:="Africa"]

mems <- bestMEM_BANA[, c( 11:ncol(bestMEM_BANA)), with = FALSE]
tab <-  data[Continent=="North America",.(SD,DBHqm)]
tab2<-cbind(tab,data[Continent=="North America",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("BA2 ~",   env_formula, "+", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabNA=cbind(bestMEM_BANA[, 1, drop = FALSE],tab2,mems)

BA_F_NA=lm(model_formula, data=tabNA)
summary(BA_F_NA)
tabNA=tabNA[,Continent:="North America"]


tab <-  data[Continent=="South America",.(SD,DBHqm)]
tab2<-cbind(tab,data[Continent=="South America",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("BA2 ~",   env_formula)
model_formula <- as.formula(full_formula)

tabSA=cbind(bestMEM_BASA[, 1, drop = FALSE],tab2)

BA_F_SA=lm(model_formula, data=tabSA)
summary(BA_F_SA)
tabSA=tabSA[,Continent:="South America"]

mems <- bestMEM_BAOc[, c( 11:ncol(bestMEM_BAOc)), with = FALSE]
tab <- data[Continent=="Oceania",.(SD,DBHqm)]
tab2<-cbind(tab,data[Continent=="Oceania",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("BA2 ~",   env_formula, "+", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabOc=cbind(bestMEM_BAOc[, 1, drop = FALSE],tab2,mems)

BA_F_Oc=lm(model_formula, data=tabOc)
summary(BA_F_Oc)
tabOc=tabOc[,Continent:="Oceania"]

mems <- bestMEM_BAAs[, c( 11:ncol(bestMEM_BAAs)), with = FALSE]
tab <-  data[Continent=="Eurasia",.(SD,DBHqm)]
tab2<-cbind(tab,data[Continent=="Eurasia",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("BA2 ~",   env_formula, " +", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabAs=cbind(bestMEM_BAAs[, 1, drop = FALSE],tab2,mems)

BA_F_As=lm(model_formula, data=tabAs)
summary(BA_F_As)
tabAs=tabAs[,Continent:="Eurasia"]

##Bio1###############################################################################################################################################################

get_linetype <- function(model) {
  coef_summary <- summary(model)$coefficients
  if ("Bio1_un" %in% rownames(coef_summary)) {
    pval <- coef_summary["Bio1_un", "Pr(>|t|)"]
    if (!is.na(pval) && pval < 0.05) {
      return("longdash")
    }
  }
  return("solid")
}


# Obtention des prédictions pour la variable 'Bio1' pour chaque modèle
pred_Af <- ggpredict(BA_F_Af, terms = "Bio1_un")
pred_SA <- ggpredict(BA_F_SA, terms = "Bio1_un")
pred_As <- ggpredict(BA_F_As, terms = "Bio1_un")
pred_Oc <- ggpredict(BA_F_Oc, terms = "Bio1_un")
pred_NA <- ggpredict(BA_F_NA, terms = "Bio1_un")

# Ajout d'une colonne pour identifier le modèle (Afrique ou Amérique du Sud)
pred_Af$model <- "Africa"
pred_SA$model <- "South America"
pred_As$model <- "Eurasia"
pred_Oc$model <- "Oceania"
pred_NA$model <- "North America"

# Combinaison des prédictions dans un seul data frame
pred_data <- rbind(pred_Af, pred_SA,pred_Oc,pred_As,pred_NA)



# Ajout du linetype basé sur la significativité
linetype_df <- data.frame(
  model = c("Africa", "South America", "Eurasia", "Oceania", "North America"),
  linetype = c(
    get_linetype(BA_F_Af),
    get_linetype(BA_F_SA),
    get_linetype(BA_F_As),
    get_linetype(BA_F_Oc),
    get_linetype(BA_F_NA)
  )
)

# Fusion avec les prédictions
pred_data <- merge(pred_data, linetype_df, by = "model")


ba_a <- ggplot() +
  # Points observés
  geom_point(data = tabAf, aes(x = Bio1_un, y = BA2), color = "cyan4", size = 2, alpha = 0.1) +
  geom_point(data = tabSA, aes(x = Bio1_un, y = BA2), color = "darkorange", size = 2, alpha = 0.1) +
  geom_point(data = tabOc, aes(x = Bio1_un, y = BA2), color = "skyblue1", size = 2, alpha = 0.1) +
  geom_point(data = tabAs, aes(x = Bio1_un, y = BA2), color = "mediumorchid3", size = 2, alpha = 0.1) +
  geom_point(data = tabNA, aes(x = Bio1_un, y = BA2), color = "goldenrod1", size = 2, alpha = 0.1) +
  
  # Lignes de régression avec linetype conditionnel
  geom_line(data = pred_data, aes(x = x, y = predicted, color = model, linetype = linetype), size = 1.5) +
  
  theme_test() +
  theme(legend.position = "none", text = element_text(size = 15)) +
  
  scale_color_manual(values = c("Africa" = "cyan4", "Eurasia" = "mediumorchid3", 
                                "North America" = "goldenrod1", "Oceania" = "skyblue1", 
                                "South America" = "darkorange")) +
  
  labs(x = "Mean annual temperature (°C)", y = expression("Basal area (m"^2~"ha"^{-1}*")"), color = "Continent") +
  ggtitle("")
ba_a




##Bio12###############################################################################################################################################################

get_linetype <- function(model) {
  coef_summary <- summary(model)$coefficients
  if ("Bio12_un" %in% rownames(coef_summary)) {
    pval <- coef_summary["Bio12_un", "Pr(>|t|)"]
    if (!is.na(pval) && pval < 0.05) {
      return("longdash")
    }
  }
  return("solid")
}


# Obtention des prédictions pour la variable 'Bio12' pour chaque modèle
pred_Af <- ggpredict(BA_F_Af, terms = "Bio12_un")
pred_SA <- ggpredict(BA_F_SA, terms = "Bio12_un")
pred_As <- ggpredict(BA_F_As, terms = "Bio12_un")
pred_Oc <- ggpredict(BA_F_Oc, terms = "Bio12_un")
pred_NA <- ggpredict(BA_F_NA, terms = "Bio12_un")

# Ajout d'une colonne pour identifier le modèle (Afrique ou Amérique du Sud)
pred_Af$model <- "Africa"
pred_SA$model <- "South America"
pred_As$model <- "Eurasia"
pred_Oc$model <- "Oceania"
pred_NA$model <- "North America"

# Combinaison des prédictions dans un seul data frame
pred_data <- rbind(pred_Af, pred_SA,pred_Oc,pred_As,pred_NA)



# Ajout du linetype basé sur la significativité
linetype_df <- data.frame(
  model = c("Africa", "South America", "Eurasia", "Oceania", "North America"),
  linetype = c(
    get_linetype(BA_F_Af),
    get_linetype(BA_F_SA),
    get_linetype(BA_F_As),
    get_linetype(BA_F_Oc),
    get_linetype(BA_F_NA)
  )
)

# Fusion avec les prédictions
pred_data <- merge(pred_data, linetype_df, by = "model")


ba_b <- ggplot() +
  # Points observés
  geom_point(data = tabAf, aes(x = Bio12_un, y = BA2), color = "cyan4", size = 2, alpha = 0.1) +
  geom_point(data = tabSA, aes(x = Bio12_un, y = BA2), color = "darkorange", size = 2, alpha = 0.1) +
  geom_point(data = tabOc, aes(x = Bio12_un, y = BA2), color = "skyblue1", size = 2, alpha = 0.1) +
  geom_point(data = tabAs, aes(x = Bio12_un, y = BA2), color = "mediumorchid3", size = 2, alpha = 0.1) +
  geom_point(data = tabNA, aes(x = Bio12_un, y = BA2), color = "goldenrod1", size = 2, alpha = 0.1) +
  
  # Lignes de régression avec linetype conditionnel
  geom_line(data = pred_data, aes(x = x, y = predicted, color = model, linetype = linetype), size = 1.5) +
  
  theme_test() +
  theme(legend.position = "none", text = element_text(size = 15)) +
  
  scale_color_manual(values = c("Africa" = "cyan4", "Eurasia" = "mediumorchid3", 
                                "North America" = "goldenrod1", "Oceania" = "skyblue1", 
                                "South America" = "darkorange")) +
  
  labs(x = "Total annual precipitation (mm)", y =expression("Basal area (m"^2~"ha"^{-1}*")"), color = "Continent") +
  ggtitle("")
ba_b



##Bio15###############################################################################################################################################################

get_linetype <- function(model) {
  coef_summary <- summary(model)$coefficients
  if ("Bio15_un" %in% rownames(coef_summary)) {
    pval <- coef_summary["Bio15_un", "Pr(>|t|)"]
    if (!is.na(pval) && pval < 0.05) {
      return("longdash")
    }
  }
  return("solid")
}


# Obtention des prédictions pour la variable 'Bio15' pour chaque modèle
pred_Af <- ggpredict(BA_F_Af, terms = "Bio15_un")
pred_SA <- ggpredict(BA_F_SA, terms = "Bio15_un")
pred_As <- ggpredict(BA_F_As, terms = "Bio15_un")
pred_Oc <- ggpredict(BA_F_Oc, terms = "Bio15_un")
pred_NA <- ggpredict(BA_F_NA, terms = "Bio15_un")

# Ajout d'une colonne pour identifier le modèle (Afrique ou Amérique du Sud)
pred_Af$model <- "Africa"
pred_SA$model <- "South America"
pred_As$model <- "Eurasia"
pred_Oc$model <- "Oceania"
pred_NA$model <- "North America"

# Combinaison des prédictions dans un seul data frame
pred_data <- rbind(pred_Af, pred_SA,pred_Oc,pred_As,pred_NA)



# Ajout du linetype basé sur la significativité
linetype_df <- data.frame(
  model = c("Africa", "South America", "Eurasia", "Oceania", "North America"),
  linetype = c(
    get_linetype(BA_F_Af),
    get_linetype(BA_F_SA),
    get_linetype(BA_F_As),
    get_linetype(BA_F_Oc),
    get_linetype(BA_F_NA)
  )
)

# Fusion avec les prédictions
pred_data <- merge(pred_data, linetype_df, by = "model")


ba_c <- ggplot() +
  # Points observés
  geom_point(data = tabAf, aes(x = Bio15_un, y = BA2), color = "cyan4", size = 2, alpha = 0.1) +
  geom_point(data = tabSA, aes(x = Bio15_un, y = BA2), color = "darkorange", size = 2, alpha = 0.1) +
  geom_point(data = tabOc, aes(x = Bio15_un, y = BA2), color = "skyblue1", size = 2, alpha = 0.1) +
  geom_point(data = tabAs, aes(x = Bio15_un, y = BA2), color = "mediumorchid3", size = 2, alpha = 0.1) +
  geom_point(data = tabNA, aes(x = Bio15_un, y = BA2), color = "goldenrod1", size = 2, alpha = 0.1) +
  
  # Lignes de régression avec linetype conditionnel
  geom_line(data = pred_data, aes(x = x, y = predicted, color = model, linetype = linetype), size = 1.5) +
  
  theme_test() +
  theme(legend.position = "none", text = element_text(size = 15)) +
  
  scale_color_manual(values = c("Africa" = "cyan4", "Eurasia" = "mediumorchid3", 
                                "North America" = "goldenrod1", "Oceania" = "skyblue1", 
                                "South America" = "darkorange")) +
  
  labs(x = "Precipitation seasonality (%)", y = expression("Basal area (m"^2~"ha"^{-1}*")"), color = "Continent") +
  ggtitle("")
ba_c






#3) WDba stand ######################################################################################################################################################


mems <- bestMEM_WDbaAf[, c( 10:ncol(bestMEM_WDbaAf)), with = FALSE]
tab <- data[Continent=="Africa",.(BA)]
tab2<-cbind(tab,data[Continent=="Africa",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("WDba2 ~",  env_formula, "+", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabAf=cbind(bestMEM_WDbaAf[, 1, drop = FALSE],tab2,mems)

WDba_F_Af=lm(model_formula, data=tabAf)
summary(WDba_F_Af)
tabAf=tabAf[,Continent:="Africa"]

mems <- bestMEM_WDbaNA[, c( 10:ncol(bestMEM_WDbaNA)), with = FALSE]
tab <-  data[Continent=="North America",.(BA)]
tab2<-cbind(tab,data[Continent=="North America",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("WDba2 ~",   env_formula, "+", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabNA=cbind(bestMEM_WDbaNA[, 1, drop = FALSE],tab2,mems)

WDba_F_NA=lm(model_formula, data=tabNA)
summary(WDba_F_NA)
tabNA=tabNA[,Continent:="North America"]

mems <- bestMEM_WDbaSA[, c( 10:ncol(bestMEM_WDbaSA)), with = FALSE]
tab <-  data[Continent=="South America",.(BA)]
tab2<-cbind(tab,data[Continent=="South America",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("WDba2 ~",   env_formula, " +", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabSA=cbind(bestMEM_WDbaSA[, 1, drop = FALSE],tab2,mems)

WDba_F_SA=lm(model_formula, data=tabSA)
summary(WDba_F_SA)
tabSA=tabSA[,Continent:="South America"]

mems <- bestMEM_WDbaOc[, c( 10:ncol(bestMEM_WDbaOc)), with = FALSE]
tab <- data[Continent=="Oceania",.(BA)]
tab2<-cbind(tab,data[Continent=="Oceania",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("WDba2 ~",   env_formula, " +", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabOc=cbind(bestMEM_WDbaOc[, 1, drop = FALSE],tab2,mems)

WDba_F_Oc=lm(model_formula, data=tabOc)
summary(WDba_F_Oc)
tabOc=tabOc[,Continent:="Oceania"]

mems <- bestMEM_WDbaAs[, c( 10:ncol(bestMEM_WDbaAs)), with = FALSE]
tab <-  data[Continent=="Eurasia",.(BA)]
tab2<-cbind(tab,data[Continent=="Eurasia",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("WDba2 ~",   env_formula, " +", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabAs=cbind(bestMEM_WDbaAs[, 1, drop = FALSE],tab2,mems)

WDba_F_As=lm(model_formula, data=tabAs)
summary(WDba_F_As)
tabAs=tabAs[,Continent:="Eurasia"]



##Bio1###############################################################################################################################################################

get_linetype <- function(model) {
  coef_summary <- summary(model)$coefficients
  if ("Bio1_un" %in% rownames(coef_summary)) {
    pval <- coef_summary["Bio1_un", "Pr(>|t|)"]
    if (!is.na(pval) && pval < 0.05) {
      return("longdash")
    }
  }
  return("solid")
}
# Obtention des prédictions pour la variable 'Bio1' pour chaque modèle
pred_Af <- ggpredict(WDba_F_Af, terms = "Bio1_un")
pred_SA <- ggpredict(WDba_F_SA, terms = "Bio1_un")
pred_As <- ggpredict(WDba_F_As, terms = "Bio1_un")
pred_Oc <- ggpredict(WDba_F_Oc, terms = "Bio1_un")
pred_NA <- ggpredict(WDba_F_NA, terms = "Bio1_un")

# Ajout d'une colonne pour identifier le modèle (Afrique ou Amérique du Sud)
pred_Af$model <- "Africa"
pred_SA$model <- "South America"
pred_As$model <- "Eurasia"
pred_Oc$model <- "Oceania"
pred_NA$model <- "North America"

# Combinaison des prédictions dans un seul data frame
pred_data <- rbind(pred_Af, pred_SA,pred_Oc,pred_As,pred_NA)



# Ajout du linetype basé sur la significativité
linetype_df <- data.frame(
  model = c("Africa", "South America", "Eurasia", "Oceania", "North America"),
  linetype = c(
    get_linetype(WDba_F_Af),
    get_linetype(WDba_F_SA),
    get_linetype(WDba_F_As),
    get_linetype(WDba_F_Oc),
    get_linetype(WDba_F_NA)
  )
)

# Fusion avec les prédictions
pred_data <- merge(pred_data, linetype_df, by = "model")


wd_a <- ggplot() +
  # Points observés
  geom_point(data = tabAf, aes(x = Bio1_un, y = WDba2), color = "cyan4", size = 2, alpha = 0.1) +
  geom_point(data = tabSA, aes(x = Bio1_un, y = WDba2), color = "darkorange", size = 2, alpha = 0.1) +
  geom_point(data = tabOc, aes(x = Bio1_un, y = WDba2), color = "skyblue1", size = 2, alpha = 0.1) +
  geom_point(data = tabAs, aes(x = Bio1_un, y = WDba2), color = "mediumorchid3", size = 2, alpha = 0.1) +
  geom_point(data = tabNA, aes(x = Bio1_un, y = WDba2), color = "goldenrod1", size = 2, alpha = 0.1) +
  
  # Lignes de régression avec linetype conditionnel
  geom_line(data = pred_data, aes(x = x, y = predicted, color = model, linetype = linetype), size = 1.5) +
  
  theme_test() +
  theme(legend.position = "none", text = element_text(size = 15)) +
  
  scale_color_manual(values = c("Africa" = "cyan4", "Eurasia" = "mediumorchid3", 
                                "North America" = "goldenrod1", "Oceania" = "skyblue1", 
                                "South America" = "darkorange")) +
  
  labs(x = "Mean annual temperature (°C)", y = expression("Wood density weighted\n by basala area (g cm"^{-3}*")"), color = "Continent") +
  ggtitle("")
wd_a




##Bio12###############################################################################################################################################################

get_linetype <- function(model) {
  coef_summary <- summary(model)$coefficients
  if ("Bio12_un" %in% rownames(coef_summary)) {
    pval <- coef_summary["Bio12_un", "Pr(>|t|)"]
    if (!is.na(pval) && pval < 0.05) {
      return("longdash")
    }
  }
  return("solid")
}
# Obtention des prédictions pour la variable 'Bio12' pour chaque modèle
pred_Af <- ggpredict(WDba_F_Af, terms = "Bio12_un")
pred_SA <- ggpredict(WDba_F_SA, terms = "Bio12_un")
pred_As <- ggpredict(WDba_F_As, terms = "Bio12_un")
pred_Oc <- ggpredict(WDba_F_Oc, terms = "Bio12_un")
pred_NA <- ggpredict(WDba_F_NA, terms = "Bio12_un")

# Ajout d'une colonne pour identifier le modèle (Afrique ou Amérique du Sud)
pred_Af$model <- "Africa"
pred_SA$model <- "South America"
pred_As$model <- "Eurasia"
pred_Oc$model <- "Oceania"
pred_NA$model <- "North America"

# Combinaison des prédictions dans un seul data frame
pred_data <- rbind(pred_Af, pred_SA,pred_Oc,pred_As,pred_NA)



# Ajout du linetype basé sur la significativité
linetype_df <- data.frame(
  model = c("Africa", "South America", "Eurasia", "Oceania", "North America"),
  linetype = c(
    get_linetype(WDba_F_Af),
    get_linetype(WDba_F_SA),
    get_linetype(WDba_F_As),
    get_linetype(WDba_F_Oc),
    get_linetype(WDba_F_NA)
  )
)

# Fusion avec les prédictions
pred_data <- merge(pred_data, linetype_df, by = "model")


wd_b <- ggplot() +
  # Points observés
  geom_point(data = tabAf, aes(x = Bio12_un, y = WDba2), color = "cyan4", size = 2, alpha = 0.1) +
  geom_point(data = tabSA, aes(x = Bio12_un, y = WDba2), color = "darkorange", size = 2, alpha = 0.1) +
  geom_point(data = tabOc, aes(x = Bio12_un, y = WDba2), color = "skyblue1", size = 2, alpha = 0.1) +
  geom_point(data = tabAs, aes(x = Bio12_un, y = WDba2), color = "mediumorchid3", size = 2, alpha = 0.1) +
  geom_point(data = tabNA, aes(x = Bio12_un, y = WDba2), color = "goldenrod1", size = 2, alpha = 0.1) +
  
  # Lignes de régression avec linetype conditionnel
  geom_line(data = pred_data, aes(x = x, y = predicted, color = model, linetype = linetype), size = 1.5) +
  
  theme_test() +
  theme(legend.position = "none", text = element_text(size = 15)) +
  
  scale_color_manual(values = c("Africa" = "cyan4", "Eurasia" = "mediumorchid3", 
                                "North America" = "goldenrod1", "Oceania" = "skyblue1", 
                                "South America" = "darkorange")) +
  
  labs(x = "Total annual precipitation (mm)", y = expression("Wood density weighted\n by basala area (g cm"^{-3}*")"), color = "Continent") +
  ggtitle("")
wd_b



##Bio15###############################################################################################################################################################

get_linetype <- function(model) {
  coef_summary <- summary(model)$coefficients
  if ("Bio15_un" %in% rownames(coef_summary)) {
    pval <- coef_summary["Bio15_un", "Pr(>|t|)"]
    if (!is.na(pval) && pval < 0.05) {
      return("longdash")
    }
  }
  return("solid")
}
# Obtention des prédictions pour la variable 'Bio15' pour chaque modèle
pred_Af <- ggpredict(WDba_F_Af, terms = "Bio15_un")
pred_SA <- ggpredict(WDba_F_SA, terms = "Bio15_un")
pred_As <- ggpredict(WDba_F_As, terms = "Bio15_un")
pred_Oc <- ggpredict(WDba_F_Oc, terms = "Bio15_un")
pred_NA <- ggpredict(WDba_F_NA, terms = "Bio15_un")

# Ajout d'une colonne pour identifier le modèle (Afrique ou Amérique du Sud)
pred_Af$model <- "Africa"
pred_SA$model <- "South America"
pred_As$model <- "Eurasia"
pred_Oc$model <- "Oceania"
pred_NA$model <- "North America"

# Combinaison des prédictions dans un seul data frame
pred_data <- rbind(pred_Af, pred_SA,pred_Oc,pred_As,pred_NA)



# Ajout du linetype basé sur la significativité
linetype_df <- data.frame(
  model = c("Africa", "South America", "Eurasia", "Oceania", "North America"),
  linetype = c(
    get_linetype(WDba_F_Af),
    get_linetype(WDba_F_SA),
    get_linetype(WDba_F_As),
    get_linetype(WDba_F_Oc),
    get_linetype(WDba_F_NA)
  )
)

# Fusion avec les prédictions
pred_data <- merge(pred_data, linetype_df, by = "model")


wd_c <- ggplot() +
  # Points observés
  geom_point(data = tabAf, aes(x = Bio15_un, y = WDba2), color = "cyan4", size = 2, alpha = 0.1) +
  geom_point(data = tabSA, aes(x = Bio15_un, y = WDba2), color = "darkorange", size = 2, alpha = 0.1) +
  geom_point(data = tabOc, aes(x = Bio15_un, y = WDba2), color = "skyblue1", size = 2, alpha = 0.1) +
  geom_point(data = tabAs, aes(x = Bio15_un, y = WDba2), color = "mediumorchid3", size = 2, alpha = 0.1) +
  geom_point(data = tabNA, aes(x = Bio15_un, y = WDba2), color = "goldenrod1", size = 2, alpha = 0.1) +
  
  # Lignes de régression avec linetype conditionnel
  geom_line(data = pred_data, aes(x = x, y = predicted, color = model, linetype = linetype), size = 1.5) +
  
  theme_test() +
  theme(legend.position = "none", text = element_text(size = 15)) +
  
  scale_color_manual(values = c("Africa" = "cyan4", "Eurasia" = "mediumorchid3", 
                                "North America" = "goldenrod1", "Oceania" = "skyblue1", 
                                "South America" = "darkorange")) +
  
  labs(x = "Precipitation seasonality (%)", y = expression("Wood density weighted\n by basala area (g cm"^{-3}*")"), color = "Continent") +
  ggtitle("")
wd_c






#4) SD stand ######################################################################################################################################################



mems <- bestMEM_SDAf[, c( 9:ncol(bestMEM_SDAf)), with = FALSE]

tab2<-cbind(data[Continent=="Africa",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("SD ~",  env_formula, "+", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabAf=cbind(bestMEM_SDAf[, 1, drop = FALSE],tab2,mems)

SD_F_Af=lm(model_formula, data=tabAf)
summary(SD_F_Af)
tabAf=tabAf[,Continent:="Africa"]

mems <- bestMEM_SDNA[, c( 9:ncol(bestMEM_SDNA)), with = FALSE]

tab2<-cbind(data[Continent=="North America",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("SD ~",   env_formula, "+", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabNA=cbind(bestMEM_SDNA[, 1, drop = FALSE],tab2,mems)

SD_F_NA=lm(model_formula, data=tabNA)
summary(SD_F_NA)
tabNA=tabNA[,Continent:="North America"]

mems <- bestMEM_SDSA[, c( 9:ncol(bestMEM_SDSA)), with = FALSE]

tab2<-cbind(data[Continent=="South America",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("SD ~",   env_formula, " +", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabSA=cbind(bestMEM_SDSA[, 1, drop = FALSE],tab2,mems)

SD_F_SA=lm(model_formula, data=tabSA)
summary(SD_F_SA)
tabSA=tabSA[,Continent:="South America"]

mems <- bestMEM_SDOc[, c( 9:ncol(bestMEM_SDOc)), with = FALSE]

tab2<-cbind(data[Continent=="Oceania",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("SD ~",   env_formula, " +", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabOc=cbind(bestMEM_SDOc[, 1, drop = FALSE],tab2,mems)

SD_F_Oc=lm(model_formula, data=tabOc)
summary(SD_F_Oc)
tabOc=tabOc[,Continent:="Oceania"]

mems <- bestMEM_SDAs[, c( 9:ncol(bestMEM_SDAs)), with = FALSE]

tab2<-cbind(data[Continent=="Eurasia",.(Bio1_un=Bio1_WC,Bio12_un=Bio12_WC,Bio15_un=Bio15_WC,slope_un=slope,sand_un=sand,ph_un=ph,org_un=org)])
env_vars<-names(tab2)
MEM_vars <-names(mems)
env_formula <- paste(env_vars, collapse = " + ")
full_formula <- paste("SD ~",   env_formula, " +", paste(MEM_vars, collapse = " + "))
model_formula <- as.formula(full_formula)

tabAs=cbind(bestMEM_SDAs[, 1, drop = FALSE],tab2,mems)

SD_F_As=lm(model_formula, data=tabAs)
summary(SD_F_As)
tabAs=tabAs[,Continent:="Eurasia"]



##Bio1###############################################################################################################################################################

get_linetype <- function(model) {
  coef_summary <- summary(model)$coefficients
  if ("Bio1_un" %in% rownames(coef_summary)) {
    pval <- coef_summary["Bio1_un", "Pr(>|t|)"]
    if (!is.na(pval) && pval < 0.05) {
      return("longdash")
    }
  }
  return("solid")
}
# Obtention des prédictions pour la variable 'Bio1' pour chaque modèle
pred_Af <- ggpredict(SD_F_Af, terms = "Bio1_un")
pred_SA <- ggpredict(SD_F_SA, terms = "Bio1_un")
pred_As <- ggpredict(SD_F_As, terms = "Bio1_un")
pred_Oc <- ggpredict(SD_F_Oc, terms = "Bio1_un")
pred_NA <- ggpredict(SD_F_NA, terms = "Bio1_un")

# Ajout d'une colonne pour identifier le modèle (Afrique ou Amérique du Sud)
pred_Af$model <- "Africa"
pred_SA$model <- "South America"
pred_As$model <- "Eurasia"
pred_Oc$model <- "Oceania"
pred_NA$model <- "North America"

# Combinaison des prédictions dans un seul data frame
pred_data <- rbind(pred_Af, pred_SA,pred_Oc,pred_As,pred_NA)



# Ajout du linetype basé sur la significativité
linetype_df <- data.frame(
  model = c("Africa", "South America", "Eurasia", "Oceania", "North America"),
  linetype = c(
    get_linetype(SD_F_Af),
    get_linetype(SD_F_SA),
    get_linetype(SD_F_As),
    get_linetype(SD_F_Oc),
    get_linetype(SD_F_NA)
  )
)

# Fusion avec les prédictions
pred_data <- merge(pred_data, linetype_df, by = "model")


sd_a <- ggplot() +
  # Points observés
  geom_point(data = tabAf, aes(x = Bio1_un, y = SD), color = "cyan4", size = 2, alpha = 0.1) +
  geom_point(data = tabSA, aes(x = Bio1_un, y = SD), color = "darkorange", size = 2, alpha = 0.1) +
  geom_point(data = tabOc, aes(x = Bio1_un, y = SD), color = "skyblue1", size = 2, alpha = 0.1) +
  geom_point(data = tabAs, aes(x = Bio1_un, y = SD), color = "mediumorchid3", size = 2, alpha = 0.1) +
  geom_point(data = tabNA, aes(x = Bio1_un, y = SD), color = "goldenrod1", size = 2, alpha = 0.1) +
  
  # Lignes de régression avec linetype conditionnel
  geom_line(data = pred_data, aes(x = x, y = predicted, color = model, linetype = linetype), size = 1.5) +
  
  theme_test() +
  theme(legend.position = "none", text = element_text(size = 15)) +
  
  scale_color_manual(values = c("Africa" = "cyan4", "Eurasia" = "mediumorchid3", 
                                "North America" = "goldenrod1", "Oceania" = "skyblue1", 
                                "South America" = "darkorange")) +
  
  labs(x = "Mean annual temperature (°C)", y = expression("Number of stems ha"^{-1}*""), color = "Continent") +
  ggtitle("")
sd_a




##Bio12###############################################################################################################################################################

get_linetype <- function(model) {
  coef_summary <- summary(model)$coefficients
  if ("Bio12_un" %in% rownames(coef_summary)) {
    pval <- coef_summary["Bio12_un", "Pr(>|t|)"]
    if (!is.na(pval) && pval < 0.05) {
      return("longdash")
    }
  }
  return("solid")
}
# Obtention des prédictions pour la variable 'Bio12' pour chaque modèle
pred_Af <- ggpredict(SD_F_Af, terms = "Bio12_un")
pred_SA <- ggpredict(SD_F_SA, terms = "Bio12_un")
pred_As <- ggpredict(SD_F_As, terms = "Bio12_un")
pred_Oc <- ggpredict(SD_F_Oc, terms = "Bio12_un")
pred_NA <- ggpredict(SD_F_NA, terms = "Bio12_un")

# Ajout d'une colonne pour identifier le modèle (Afrique ou Amérique du Sud)
pred_Af$model <- "Africa"
pred_SA$model <- "South America"
pred_As$model <- "Eurasia"
pred_Oc$model <- "Oceania"
pred_NA$model <- "North America"

# Combinaison des prédictions dans un seul data frame
pred_data <- rbind(pred_Af, pred_SA,pred_Oc,pred_As,pred_NA)



# Ajout du linetype basé sur la significativité
linetype_df <- data.frame(
  model = c("Africa", "South America", "Eurasia", "Oceania", "North America"),
  linetype = c(
    get_linetype(SD_F_Af),
    get_linetype(SD_F_SA),
    get_linetype(SD_F_As),
    get_linetype(SD_F_Oc),
    get_linetype(SD_F_NA)
  )
)

# Fusion avec les prédictions
pred_data <- merge(pred_data, linetype_df, by = "model")


sd_b <- ggplot() +
  # Points observés
  geom_point(data = tabAf, aes(x = Bio12_un, y = SD), color = "cyan4", size = 2, alpha = 0.1) +
  geom_point(data = tabSA, aes(x = Bio12_un, y = SD), color = "darkorange", size = 2, alpha = 0.1) +
  geom_point(data = tabOc, aes(x = Bio12_un, y = SD), color = "skyblue1", size = 2, alpha = 0.1) +
  geom_point(data = tabAs, aes(x = Bio12_un, y = SD), color = "mediumorchid3", size = 2, alpha = 0.1) +
  geom_point(data = tabNA, aes(x = Bio12_un, y = SD), color = "goldenrod1", size = 2, alpha = 0.1) +
  
  # Lignes de régression avec linetype conditionnel
  geom_line(data = pred_data, aes(x = x, y = predicted, color = model, linetype = linetype), size = 1.5) +
  
  theme_test() +
  theme(legend.position = "none", text = element_text(size = 15)) +
  
  scale_color_manual(values = c("Africa" = "cyan4", "Eurasia" = "mediumorchid3", 
                                "North America" = "goldenrod1", "Oceania" = "skyblue1", 
                                "South America" = "darkorange")) +
  
  labs(x = "Total annual precipitation (mm)", y = expression("Number of stems ha"^{-1}*""), color = "Continent") +
  ggtitle("")
sd_b



##Bio15###############################################################################################################################################################

get_linetype <- function(model) {
  coef_summary <- summary(model)$coefficients
  if ("Bio15_un" %in% rownames(coef_summary)) {
    pval <- coef_summary["Bio15_un", "Pr(>|t|)"]
    if (!is.na(pval) && pval < 0.05) {
      return("longdash")
    }
  }
  return("solid")
}
# Obtention des prédictions pour la variable 'Bio15' pour chaque modèle
pred_Af <- ggpredict(SD_F_Af, terms = "Bio15_un")
pred_SA <- ggpredict(SD_F_SA, terms = "Bio15_un")
pred_As <- ggpredict(SD_F_As, terms = "Bio15_un")
pred_Oc <- ggpredict(SD_F_Oc, terms = "Bio15_un")
pred_NA <- ggpredict(SD_F_NA, terms = "Bio15_un")

# Ajout d'une colonne pour identifier le modèle (Afrique ou Amérique du Sud)
pred_Af$model <- "Africa"
pred_SA$model <- "South America"
pred_As$model <- "Eurasia"
pred_Oc$model <- "Oceania"
pred_NA$model <- "North America"

# Combinaison des prédictions dans un seul data frame
pred_data <- rbind(pred_Af, pred_SA,pred_Oc,pred_As,pred_NA)



# Ajout du linetype basé sur la significativité
linetype_df <- data.frame(
  model = c("Africa", "South America", "Eurasia", "Oceania", "North America"),
  linetype = c(
    get_linetype(SD_F_Af),
    get_linetype(SD_F_SA),
    get_linetype(SD_F_As),
    get_linetype(SD_F_Oc),
    get_linetype(SD_F_NA)
  )
)

# Fusion avec les prédictions
pred_data <- merge(pred_data, linetype_df, by = "model")


sd_c <- ggplot() +
  # Points observés
  geom_point(data = tabAf, aes(x = Bio15_un, y = SD), color = "cyan4", size = 2, alpha = 0.1) +
  geom_point(data = tabSA, aes(x = Bio15_un, y = SD), color = "darkorange", size = 2, alpha = 0.1) +
  geom_point(data = tabOc, aes(x = Bio15_un, y = SD), color = "skyblue1", size = 2, alpha = 0.1) +
  geom_point(data = tabAs, aes(x = Bio15_un, y = SD), color = "mediumorchid3", size = 2, alpha = 0.1) +
  geom_point(data = tabNA, aes(x = Bio15_un, y = SD), color = "goldenrod1", size = 2, alpha = 0.1) +
  
  # Lignes de régression avec linetype conditionnel
  geom_line(data = pred_data, aes(x = x, y = predicted, color = model, linetype = linetype), size = 1.5) +
  
  theme_test() +
  theme(legend.position = "none", text = element_text(size = 15)) +
  
  scale_color_manual(values = c("Africa" = "cyan4", "Eurasia" = "mediumorchid3", 
                                "North America" = "goldenrod1", "Oceania" = "skyblue1", 
                                "South America" = "darkorange")) +
  
  labs(x = "Precipitation seasonality (%)", y = expression("Number of stems ha"^{-1}*""), color = "Continent") +
  ggtitle("")
sd_c

library(gridExtra)

grid.arrange(dbh_a, dbh_b, dbh_c, 
             ba_a, ba_b, ba_c,
             sd_a, sd_b, sd_c, 
             wd_a, wd_b, wd_c,
             nrow =3 )
