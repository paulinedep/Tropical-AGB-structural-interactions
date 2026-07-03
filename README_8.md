**Region-specific forest structure pathways reveal climate effects on old-growth tropical forest biomass**



**Code for the paper titled: Region-specific forest structure pathways reveal climate effects on old-growth tropical forest biomass**



**Depoortere, et al 2026**



**## Data and code availability**

Raw tree-by-tree data are not included due to confidentiality agreements 

(ForestPlots.net, GFBI). See manuscript for full Data and Code Availability statement.



**## How to cite**

If you use this code, please cite the associated manuscript:



Depoortere, P. et al. (in preparation). Region-specific forest structure 

pathways reveal climate effects on old-growth tropical forest biomass.



A citable Zenodo DOI for this repository will be added upon publication.



**## License**

All rights reserved. See LICENSE file for details.



**CONTACT**

For questions regarding reuse, collaboration, or data access, please 

contact the corresponding author: Pauline Depoortere (depoort.p@gmail.com)

**===============================================================================**

**README  -  AGB / forest-structure models**

**===============================================================================**



**ORDER OF THE ANALYSIS (read this first)**

**-------------------------------------------------------------------------------**

The analysis runs in two stages:

&#x20; 1. The MODEL folders (7\_Modele\_\*, 7\_Modeles\_bis\_\*, 7\_Modele\_pantrop) fit the

&#x20;    models and save their results as end\_\*.csv tables.

&#x20; 2. The FIGURE folder (8\_Graph) reads those end\_\*.csv tables and produces the

&#x20;    figures and result tables of the paper.



So you always run a model folder first, then the 8\_Graph scripts.



**===============================================================================**

1. **MODEL FOLDERS  (7\_Modele\_\*, 7\_Modeles\_bis\_\*, 7\_Modele\_pantrop)**

**===============================================================================**



**WHAT THE CODE DOES**

**-------------------------------------------------------------------------------**

This code runs all the models of the study, following its structure-explicit

pathway modelling Framework (see Methods): it fits the indirect, residual direct, and total

relationships linking the environmental variables, the forest structural

attributes (BA, DBHqm, SD, WDba) and aboveground biomass (AGB). Spatial

autocorrelation is handled with Moran's Eigenvector Maps (MEMs). Results are

saved as tables, which are then turned into the figures of the paper.



Note - \*\*bestMEM\_\*.csv:\*\* the pre-selected MEMs (the spatial variables the

models need). The MEMs are selected from each model's residuals, so they depend

on which plots (coordinates) are included AND on the climate dataset used. Each

folder, each climate dataset, and each model therefore has its own bestMEM\_\*

file - this is why there are so many.





**REGION MODELs**

**-------------------------------------------------------------------------------**



The model folders combine two things: the type of model, and the robustness

checks (see Methods).



Type of model:

&#x20; - **\*\*7\_Modele\_AGB\_\*\*\*  :** runs all the models of the study, following its structure-explicit

&#x20;                         pathway modelling framework: it fits the indirect, residual direct, and total

&#x20;                         relationships linking the environmental variables, the forest structural

&#x20;                         attributes

&#x20; - **\*\*7\_Modeles\_bis\_\*\*\* :** run the second part of the models



Together they make up the full pathway analysis.



Robustness checks (suffix on the folder name):

&#x20; - **\*\*sans\_montane\*\*     :** main analysis, montane forests (elevation 1000 m and

&#x20;                          above) excluded.

&#x20;   - **\*\*sans\_montane\_AVECOUTLIERS\*\* :** sensitivity analysis, the extreme (outlier) plots

&#x20;                                   kept instead of trimmed (the main analysis trims the

&#x20;                                   upper/lower 3% of stem density and 2% of AGB).



Note : This gives **4 folders** for the region-level analyses.



Inside each region-level folder, the models are fitted at different scales (one

.Rmd script each) :

&#x20; - **region by region** (Central America, South America, Africa, Asia, Oceania):

&#x20;       \*\*7\_Modele\_AGB\_\*\*\* : \*\*MEMs.Rmd  /  MEMs\_AVECOUTLIERS.Rmd\*\*

&#x20;       \*\*7\_Modeles\_bis\_\*\*\* : \*\*MEMs\_bis.Rmd /  MEMs\_bis\_AVECOUTLIERS.Rmd\*\*

&#x20; - **Africa only, controlling for the percentage of pioneer species** (see Methods):

&#x20;       \*\*7\_Modele\_AGB\_\*\*\* : \*\*MEMs\_Africa.Rmd

&#x20;       \*\*7\_Modeles\_bis\_\*\*\* : \*\*MEMs\_Africa\_bis.Rmd



Note : The AVECOUTLIERS folders contain only the region-by-region script (see Methods).





**============INPUT FILES (already provided in each model folder)================**



\- **\*\*Pantropical\_...\_SOIL.csv\*\* :** the plot dataset (anonymized: plot IDs replaced

&#x20;   by codes, coordinates removed), with the structural attributes and the

&#x20;   environmental variables. In the AVECOUTLIERS folders this file is

&#x20;   Pantropical\_...\_SOIL\_AVECOUTLIERS.csv (same data, with the outlier plots kept).

&#x20; - **\*\*pourc\_pionnier\_Af.csv\*\*    :** percentage of pioneer species per plot, used as a

&#x20;   successional-stage proxy by the Africa script (from the CoForTraits

&#x20;   database).

&#x20; - **\*\*bestMEM\_\*.csv\*\*            :** the pre-selected MEMs (the spatial variables the

&#x20;   models need).





**=============OUTPUT FILES (created when you run the models)===================**



&#x20; - **\*\*end\_\*.csv\*\* :** the model result tables (coefficients, R-squared, RMSE).

&#x20;   These are the input of the 8\_Graph folder (see below).



**Pantropical MODELs**

**-------------------------------------------------------------------------------**



Another folder, **\*\*7\_Modele\_pantrop\*\***, holds the same analysis run at the

pantropical scale (all plots pooled), providing for the CHELSA climate

source (\*\*MEM\_CHELSA\_Pan.Rmd\*\*, see Methods).

Input : Pantropical\_...\_SOIL.csv and bestMEM\_\*\_CHELSA\_pan.csv: the pre-selected MEMs (spatial variables)

for the pantropical, CHELSA models (7 files).

Output :  **Extended Data Table 4**





**HOW TO RUN THE MODELS**

**-------------------------------------------------------------------------------**

Open a script (.Rmd) in RStudio, set the working directory to its folder, and

run it from the section called "Importation" onward.



The first part of each script builds the spatial variables (MEMs) from the plot

coordinates. Because those coordinates are not shared (see Data availability),

this part cannot be re-run; this is why the bestMEM\_\*.csv files are provided

ready-made. Everything from "Importation" onward reproduces the models from the

provided files.



To reproduce the full analysis, each region-level script must be run once per

climate dataset. The scripts are set up for WorldClim (file names ending in \_WC);

to use another dataset, replace \_WC with that dataset's tag in the imported and

exported file names and in the "source" tag. Available climate datasets:

WC (WorldClim), CHELSA, ERA5, CRU, TC (TerraClimate),MODIS\_CHIRPS, MODIS\_IMERG

The corresponding bestMEM\_\*.csv files for every dataset are provided.

**If you don't want to re-run the models for every climate dataset, all the pre-computed end\_\*.csv result tables**

**are already available in the resulting\_end\_tabs subfolder — just copy-paste them out of that subfolder directly**

**into the corresponding 7\_Modele\_\* folder (the location the 8\_Graph scripts expect), and skip straight to 8\_Graph.**

(The pantropical script in 7\_Modele\_pantrop is already set up for CHELSA, so

there is no \_WC tag to replace there.)







**===============================================================================**

**2. 8\_Graph  -  FIGURES AND RESULT TABLES**

**===============================================================================**

**WHAT THE CODE DOES**

**-------------------------------------------------------------------------------**

This folder turns the model outputs into the figures and result tables of the

paper. The first script averages the model coefficients across the 7 climate

sources (see Methods); the other scripts read those averaged tables and build the figures

and the result tables.



Note   : to also run the sensitivity analyses -

&#x20;                       - OUTLIERS     : use the dedicated script.





Scripts (one description each):

**==============================\*\*ACP.Rmd\*\*===============================**



What it does : This script runs the PCA

&#x20;             ("ACP" = Analyse en Composantes Principales) ordination on the

&#x20;             scaled variables (vegan::rda), and a Ward's minimum-variance

&#x20;             hierarchical clustering (Ward.D2) on the plot scores from the

&#x20;             first PCA axes. This in order to select the environmental variables for the study (see Methods).

Run it after : nothing

Input  : the plot dataset (Pantropical\_...\_SOIL.csv), ACP-Choix\_WC.csv

&#x20;        (the candidate WorldClim + soil variables, "choix"), and

&#x20;        pourc\_pionnier\_Af.csv - all read directly from 8\_Graph.

Output : **Extended Data Figure 6**





**=========================\*\*mean\_coef\_and\_rmse.Rmd\*\*============================**

What it does : averages the model coefficients (and RMSE / R-squared) across the

&#x20;              7 climate sources, keeping only the values on which the majority

&#x20;              of sources agree (see Methods). It is the FIRST graph step: it

&#x20;              turns the raw model outputs into the averaged tables that the

&#x20;              other graph scripts read.

Run it after : the model scripts have been run for the 7 sources, so the

&#x20;              end\_\*.csv tables exist in 7\_Modele\_AGB\_sans\_montane

&#x20;              (MEMs.Rmd, MEMs\_Africa.Rmd) and 7\_Modeles\_bis\_sans\_montane

&#x20;              (MEMs\_bis.Rmd, MEMs\_Africa\_bis.Rmd).

Input  : end\_\*.csv (the per-source model result tables).

Output : mean\_coef\_\*.csv and rmse\_mean\_\*.csv (38 tables, written in 8\_Graph).

Note   : to also run the sensitivity analyses -

&#x20;                      - OUTLIERS     : use the dedicated script mean\_coef\_and\_rmse\_outliers.Rmd.



**========================\*\*DAG\_climate\_agreement.Rmd\*\*==========================**

What it does : draws, for each region, the structure-explicit pathway

&#x20;              diagrams of environment -> forest structure -> AGB, and the pie

&#x20;              charts showing how much the 7 climate sources

&#x20;              agree on the direction of the relationships (see Methods).

Run it after : mean\_coef\_and\_rmse.Rmd.

Input  : the plot dataset (Pantropical\_...\_SOIL.csv) and pourc\_pionnier\_Af.csv

&#x20;        from 7\_Modele\_AGB\_sans\_montane, plus the 38 mean\_coef\_\*/rmse\_mean\_\*

&#x20;        tables from 8\_Graph.

Output : **Extended Data Figure 9 to 17, Extended Data Figure 7 and 8 and Extended Tables 5 and 6**

**============================\*\*main\_result.Rmd\*\*================================**

What it does : builds the main result figure - the standardized coefficients of

&#x20;              the effects of climate on the structural attributes and of the

&#x20;              total effect of climate on AGB, shown as coloured circles for

&#x20;              each region (green = positive, red = negative, size = magnitude).

Run it after : mean\_coef\_and\_rmse.Rmd.

Input  : the plot dataset + pourc\_pionnier\_Af.csv from 7\_Modele\_AGB\_sans\_montane,

&#x20;        plus the 38 mean\_coef\_\*/rmse\_mean\_\* tables from 8\_Graph.

Output : **Figure 3 and Extended Data Figure 27**

Note   : to also run the sensitivity analyses -

&#x20;

&#x20;           - OUTLIERS     : use the dedicated script main\_result\_outliers.Rmd.



**============================\*\*tables\_total.Rmd\*\*===============================**

What it does : builds the result tables of the coefficients in raw, standardized

&#x20;              (per standard deviation) and % units, for the total contribution of

&#x20;              structural attributes to AGB (see Methods) and the total effect on AGB, for

&#x20;              every region.  + uncertainty associated with total environment–AGB relationships,

Run it after : mean\_coef\_and\_rmse.Rmd.

Input  : the plot dataset + pourc\_pionnier\_Af.csv from 7\_Modele\_AGB\_sans\_montane,

&#x20;        plus the 38 mean\_coef\_\*/rmse\_mean\_\* tables from 8\_Graph.

Output : **Extended Data Tables 7 to 10**



**=====================\*\*mean\_coef\_and\_rmse\_outliers.Rmd\*\*=======================**

What it does : same as mean\_coef\_and\_rmse.Rmd, for the OUTLIERS analysis (see Methods).

Run it after : the OUTLIERS model scripts have produced the end\_\*.csv in

&#x20;              7\_Modele\_AGB\_sans\_montane\_AVECOUTLIERS and

&#x20;              7\_Modeles\_bis\_sans\_montane\_AVECOUTLIERS.

Input  : end\_\*.csv from the \_AVECOUTLIERS model folders.

Output : mean\_coef\_\*.csv / rmse\_mean\_\*.csv (18 tables) written in 8\_Graph/outliers.



**========================\*\*main\_result\_outliers.Rmd\*\*===========================**

What it does : same as main\_result.Rmd, for the OUTLIERS analysis (see Methods).



Run it after : mean\_coef\_and\_rmse\_outliers.Rmd.

Input  : the AVECOUTLIERS dataset (Pantropical\_...\_SOIL\_AVECOUTLIERS.csv) from

&#x20;        7\_Modele\_AGB\_sans\_montane\_AVECOUTLIERS, plus the 18 mean\_coef\_\*/

&#x20;        rmse\_mean\_\* tables from 8\_Graph/outliers.

Output : **Extended Data Table 28**







