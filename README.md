# Region-specific forest structure pathways reveal climate effects on old-growth tropical forest biomass

Code for the paper titled: Region-specific forest structure pathways reveal climate effects on old-growth tropical forest biomass

**Depoortere, et al 2026**

## Data and code availability

Raw tree-by-tree data are not included due to confidentiality agreements (ForestPlots.net, GFBI). See manuscript for full Data and Code Availability statement.

## How to cite

If you use this code, please cite the associated manuscript:

Depoortere, P. et al. (in preparation). Region-specific forest structure pathways reveal climate effects on old-growth tropical forest biomass.

A citable Zenodo DOI for this repository will be added upon publication.

## License

All rights reserved. See LICENSE file for details.

## Contact

For questions regarding reuse, collaboration, or data access, please contact the corresponding author: Pauline Depoortere (depoort.p@gmail.com)

---

# README - AGB / forest-structure models

---

## ORDER OF THE ANALYSIS (read this first)

The analysis runs in two stages:

1. The MODEL folders (`7_Modele_*`, `7_Modeles_bis_*`, `7_Modele_pantrop`) fit the models and save their results as `end_*.csv` tables.
2. The FIGURE folder (`8_Graph`) reads those `end_*.csv` tables and produces the figures and result tables of the paper.

So you always run a model folder first, then the `8_Graph` scripts.

---

## 1. MODEL FOLDERS (`7_Modele_*`, `7_Modeles_bis_*`, `7_Modele_pantrop`)

### What the code does

This code runs all the models of the study, following its structure-explicit pathway modelling framework (see Methods): it fits the indirect, residual direct, and total relationships linking the environmental variables, the forest structural attributes (BA, DBHqm, SD, WDba) and aboveground biomass (AGB). Spatial autocorrelation is handled with Moran's Eigenvector Maps (MEMs). Results are saved as tables, which are then turned into the figures of the paper.

> **Note** — `bestMEM_*.csv`: the pre-selected MEMs (the spatial variables the models need). The MEMs are selected from each model's residuals, so they depend on which plots (coordinates) are included AND on the climate dataset used. Each folder, each climate dataset, and each model therefore has its own `bestMEM_*` file — this is why there are so many.

### Region models

The model folders combine two things: the type of model, and the robustness checks (see Methods).

**Type of model:**

- `7_Modele_AGB_*` : runs all the models of the study, following its structure-explicit pathway modelling framework: it fits the indirect, residual direct, and total relationships linking the environmental variables, the forest structural attributes
- `7_Modeles_bis_*` : run the second part of the models

Together they make up the full pathway analysis.

**Robustness checks (suffix on the folder name):**

- `sans_montane` : main analysis, montane forests (elevation 1000 m and above) excluded.
- `sans_montane_AVECOUTLIERS` : sensitivity analysis, the extreme (outlier) plots kept instead of trimmed (the main analysis trims the upper/lower 3% of stem density and 2% of AGB).

> **Note** — This gives **4 folders** for the region-level analyses.

Inside each region-level folder, the models are fitted at different scales (one `.Rmd` script each):

- **Region by region** (Central America, South America, Africa, Asia, Oceania):
  - `7_Modele_AGB_*` : `MEMs.Rmd` / `MEMs_AVECOUTLIERS.Rmd`
  - `7_Modeles_bis_*` : `MEMs_bis.Rmd` / `MEMs_bis_AVECOUTLIERS.Rmd`
- **Africa only, controlling for the percentage of pioneer species** (see Methods):
  - `7_Modele_AGB_*` : `MEMs_Africa.Rmd`
  - `7_Modeles_bis_*` : `MEMs_Africa_bis.Rmd`

> **Note** — The AVECOUTLIERS folders contain only the region-by-region script (see Methods).

### Input files (already provided in each model folder)

- `Pantropical_..._SOIL.csv` : the plot dataset (anonymized: plot IDs replaced by codes, coordinates removed), with the structural attributes and the environmental variables. In the AVECOUTLIERS folders this file is `Pantropical_..._SOIL_AVECOUTLIERS.csv` (same data, with the outlier plots kept).
- `pourc_pionnier_Af.csv` : percentage of pioneer species per plot, used as a successional-stage proxy by the Africa script (from the CoForTraits database).
- `bestMEM_*.csv` : the pre-selected MEMs (the spatial variables the models need).

### Output files (created when you run the models)

- `end_*.csv` : the model result tables (coefficients, R-squared, RMSE). These are the input of the `8_Graph` folder (see below).

### Pantropical models

Another folder, `7_Modele_pantrop`, holds the same analysis run at the pantropical scale (all plots pooled), providing for the CHELSA climate source (`MEM_CHELSA_Pan.Rmd`, see Methods).

- **Input**: `Pantropical_..._SOIL.csv` and `bestMEM_*_CHELSA_pan.csv`: the pre-selected MEMs (spatial variables) for the pantropical, CHELSA models (7 files).
- **Output**: Extended Data Table 4

### How to run the models

Open a script (`.Rmd`) in RStudio, set the working directory to its folder, and run it from the section called "Importation" onward.

The first part of each script builds the spatial variables (MEMs) from the plot coordinates. Because those coordinates are not shared (see Data availability), this part cannot be re-run; this is why the `bestMEM_*.csv` files are provided ready-made. Everything from "Importation" onward reproduces the models from the provided files.

To reproduce the full analysis, each region-level script must be run once per climate dataset. The scripts are set up for WorldClim (file names ending in `_WC`); to use another dataset, replace `_WC` with that dataset's tag in the imported and exported file names and in the "source" tag. Available climate datasets:

`WC` (WorldClim), `CHELSA`, `ERA5`, `CRU`, `TC` (TerraClimate), `MODIS_CHIRPS`, `MODIS_IMERG`

The corresponding `bestMEM_*.csv` files for every dataset are provided.

> If you don't want to re-run the models for every climate dataset, all the pre-computed `end_*.csv` result tables are already available in the `resulting_end_tabs` subfolder — just copy-paste them out of that subfolder directly into the corresponding `7_Modele_*` folder (the location the `8_Graph` scripts expect), and skip straight to `8_Graph`.

(The pantropical script in `7_Modele_pantrop` is already set up for CHELSA, so there is no `_WC` tag to replace there.)

---

## 2. `8_Graph` - FIGURES AND RESULT TABLES

### What the code does

This folder turns the model outputs into the figures and result tables of the paper. The first script averages the model coefficients across the 7 climate sources (see Methods); the other scripts read those averaged tables and build the figures and the result tables.

> **Note** — to also run the sensitivity analyses: **OUTLIERS** — use the dedicated script.

### Scripts (one description each)

#### `ACP.Rmd`

- **What it does**: This script runs the PCA ("ACP" = Analyse en Composantes Principales) ordination on the scaled variables (`vegan::rda`), and a Ward's minimum-variance hierarchical clustering (Ward.D2) on the plot scores from the first PCA axes. This in order to select the environmental variables for the study (see Methods).
- **Run it after**: nothing
- **Input**: the plot dataset (`Pantropical_..._SOIL.csv`), `ACP-Choix_WC.csv` (the candidate WorldClim + soil variables, "choix"), and `pourc_pionnier_Af.csv` — all read directly from `8_Graph`.
- **Output**: Extended Data Figure 6

#### `mean_coef_and_rmse.Rmd`

- **What it does**: averages the model coefficients (and RMSE / R-squared) across the 7 climate sources, keeping only the values on which the majority of sources agree (see Methods). It is the FIRST graph step: it turns the raw model outputs into the averaged tables that the other graph scripts read.
- **Run it after**: the model scripts have been run for the 7 sources, so the `end_*.csv` tables exist in `7_Modele_AGB_sans_montane` (`MEMs.Rmd`, `MEMs_Africa.Rmd`) and `7_Modeles_bis_sans_montane` (`MEMs_bis.Rmd`, `MEMs_Africa_bis.Rmd`).
- **Input**: `end_*.csv` (the per-source model result tables).
- **Output**: `mean_coef_*.csv` and `rmse_mean_*.csv` (38 tables, written in `8_Graph`).
- **Note**: to also run the sensitivity analyses — OUTLIERS — use the dedicated script `mean_coef_and_rmse_outliers.Rmd`.

#### `DAG_climate_agreement.Rmd`

- **What it does**: draws, for each region, the structure-explicit pathway diagrams of environment → forest structure → AGB, and the pie charts showing how much the 7 climate sources agree on the direction of the relationships (see Methods).
- **Run it after**: `mean_coef_and_rmse.Rmd`.
- **Input**: the plot dataset (`Pantropical_..._SOIL.csv`) and `pourc_pionnier_Af.csv` from `7_Modele_AGB_sans_montane`, plus the 38 `mean_coef_*`/`rmse_mean_*` tables from `8_Graph`.
- **Output**: Extended Data Figure 9 to 17, Extended Data Figure 7 and 8 and Extended Tables 5 and 6

#### `main_result.Rmd`

- **What it does**: builds the main result figure — the standardized coefficients of the effects of climate on the structural attributes and of the total effect of climate on AGB, shown as coloured circles for each region (green = positive, red = negative, size = magnitude).
- **Run it after**: `mean_coef_and_rmse.Rmd`.
- **Input**: the plot dataset + `pourc_pionnier_Af.csv` from `7_Modele_AGB_sans_montane`, plus the 38 `mean_coef_*`/`rmse_mean_*` tables from `8_Graph`.
- **Output**: Figure 3 and Extended Data Figure 27
- **Note**: to also run the sensitivity analyses — OUTLIERS — use the dedicated script `main_result_outliers.Rmd`.

#### `tables_total.Rmd`

- **What it does**: builds the result tables of the coefficients in raw, standardized (per standard deviation) and % units, for the total contribution of structural attributes to AGB (see Methods) and the total effect on AGB, for every region, plus uncertainty associated with total environment–AGB relationships.
- **Run it after**: `mean_coef_and_rmse.Rmd`.
- **Input**: the plot dataset + `pourc_pionnier_Af.csv` from `7_Modele_AGB_sans_montane`, plus the 38 `mean_coef_*`/`rmse_mean_*` tables from `8_Graph`.
- **Output**: Extended Data Tables 7 to 10

#### `mean_coef_and_rmse_outliers.Rmd`

- **What it does**: same as `mean_coef_and_rmse.Rmd`, for the OUTLIERS analysis (see Methods).
- **Run it after**: the OUTLIERS model scripts have produced the `end_*.csv` in `7_Modele_AGB_sans_montane_AVECOUTLIERS` and `7_Modeles_bis_sans_montane_AVECOUTLIERS`.
- **Input**: `end_*.csv` from the `_AVECOUTLIERS` model folders.
- **Output**: `mean_coef_*.csv` / `rmse_mean_*.csv` (18 tables) written in `8_Graph/outliers`.

#### `main_result_outliers.Rmd`

- **What it does**: same as `main_result.Rmd`, for the OUTLIERS analysis (see Methods).
- **Run it after**: `mean_coef_and_rmse_outliers.Rmd`.
- **Input**: the AVECOUTLIERS dataset (`Pantropical_..._SOIL_AVECOUTLIERS.csv`) from `7_Modele_AGB_sans_montane_AVECOUTLIERS`, plus the 18 `mean_coef_*`/`rmse_mean_*` tables from `8_Graph/outliers`.
- **Output**: Extended Data Table 28
