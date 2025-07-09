# Climate effects on tropical forest aboveground biomass are overshadowed by region-specific structural interactions

This repository contains R and JavaScript code used for the analyses presented in the manuscript *"Climate effects on tropical forest aboveground biomass are overshadowed by region-specific structural interactions"*, currently under review at *Nature*.


## Overview

We performed a pantropical analysis of tropical moist forest structure and aboveground biomass (AGB) using 2,023 field inventory plots distributed across Central and South America, Africa, Asia, and Oceania. The study tests whether AGB variation is primarily governed by divergent environment–structure dynamics rather than direct environmental controls.


## Data collection and availability

Field-inventoried plots were rigorously selected from over 19,473 initial plots located between 23°N and 23°S through a stringent filtering process (see Extended Data Table 1). Forest inventories (tree-level data) were provided by ForestPlots.net (https://forestplots.net/); the Global Forest Biodiversity Initiative (GFBI, in collaboration with the Science-i web platform, https://www.gfbinitiative.org/), which includes long-term plot data from Panama; the AfriTRON (https://afritron.org/) and RAINFOR (https://rainfor.org/en/) networks; and direct contributions from principal investigators of tropical field plots. All data are based on standardized field measurements conducted by trained teams following established forest monitoring protocols.  No software was used to collect field inventory data.

⚠️ Tree-by-tree data from ForestPlots.net and the Global Forest Biodiversity Initiative (GFBI) are not publicly available due to data-sharing agreements that protect the intellectual property of contributing researchers and institutions. These networks require formal data requests and collaboration agreements to access full datasets. However, a summary dataset including plot-level structural attributes (without geographic coordinates) will be made publicly available upon publication at: https://github.com/paulinedep/Tropical-AGB-structural-interactions, following the approach used in previous large-scale analyses (e.g., Bialic-Murphy et al. 2024). See https://forestplots.net/en/publications#data for examples of similar data releases. 

Data from Panama used in this study are publicly available via permanent archives:
• Barro Colorado 50-ha plot: https://doi.org/10.15146/5xcp-0d46
• BCI plot taxonomy: https://doi.org/10.15146/R3FH61
• Panama 65 plot network: https://doi.org/10.15146/mdpr-pm59

All climatic data were retrieved from publicly available datasets via Google Earth Engine (https://earthengine.google.com) using custom JavaScript code, including ERA5-Land Monthly Aggregated (ECMWF climate reanalysis), TerraClimate, IMERG v6.0, CHIRPS v2.0, and MODIS MYD11A2 v6.1. Additional datasets from CHELSA v2.1 (https://chelsa-climate.org), WorldClim v2.1 (https://www.worldclim.org), and CRU TS 4.06 (https://crudata.uea.ac.uk/cru/data/hrg) were retrieved from their respective public websites.Topographic data (elevation and slope) at 30 m resolution from the Shuttle Radar Topography Mission (NASA SRTM Digital Elevation), and soil data at 250m resolution from the SoilGrids v2.0 system (OpenLandMap/SOL) were also retrieved and processed via Google Earth Engine. Full references and technical details of the environmental datasets used in this study are provided in the Methods section and Extended Data Table 11. 

⚠️ **Note**: the dataset currently provided is is entirely artificial and was generated for demonstration purposes only. It does not reflect any ecologically meaningful patterns.. The tree-level dataset is named demo.csv, and the plot-level dataset is named plot.csv.



## Data analysis:

All analyses were conducted in R (version 4.5.0), using a combination of open-source packages. Custom R scripts were developed for data preprocessing, statistical modeling, and figure generation.  Google Earth Engine was also used, with custom JavaScript code, to extract and process environmental data. 

⚠️ **Note**:The version of the code shared with editors and reviewers (either via private link at https://github.com/paulinedep/Tropical-AGB-structural-interactions or/and via a ZIP file) corresponds to the one used to generate the study’s results. While the code is functional and complete, a fully cleaned and documented version will be made publicly available upon publication t: https://github.com/paulinedep/Tropical-AGB-structural-interactions.

The code was developed and tested under:

- **R version**: 4.5.0  
- **Main R packages** used:
  - data.table
  - BIOMASS
  - httr2
  - sf
  - ggplot2
  - raster
  - ncdf4
  - broom
  - dotwhisker
  - dplyr
  - adespatial
  - spdep
  - vegan
  - textshape
  - janitor
  - and others listed within the scripts



## Code contents

The code is organized in the order of the workflow and can be executed sequentially.

1_Cleanage folder containing:

- GFBI_tree_level_TPL_NEWW.RMD: This script performs extensive cleaning and filtering of tropical forest inventory data at both the tree and plot levels.
All cleaning steps and the number of plots remaining at each step are summarized in Extended Data Table 1. The tropical moist broadleaf forest mask used in this analysis was extracted from the RESOLVE Ecoregions dataset available via Google Earth Engine.Comments indicating the number of plots removed at each cleaning step refer to the actual GFBI dataset and do not reflect the counts in the synthetic demonstration data (demo and plot).The same cleaning workflow was applied to the datasets provided by ForestPlots.net and PIs. Comments referring to the number of plots removed correspond to those real datasets, not to the synthetic demonstration files (demo and plot).

2_Calcule_var_rep:
- GFBI_resp_var_pantrop.RMD: This script harmonizes and merges data tables from different sources (ForestPlots.net, GFBI, and directly from PIs) and calculates structural attributes at the plot level.

3_Climate_data: 
- GEE.txt : An example of the code used to extract and process rasters of selected bioclimatic variables from the ERA5-Land climate source via Google Earth Engine (prior to importing into the R script). The raster outputs for all climate data sources are provided in the accompanying folders.
- Climate_data_New.RMD : This code extracts the values of selected bioclimatic variables for each plot from the raster layers generated via Google Earth Engine (GEE).

4_SOIL_TOPO:
- GEE.txt : Google Earth Engine (GEE) code used to extract soil and topographic variables for our plots. 
- Sol-topo.RMD : This code merges the plot-level dataset with the corresponding soil and topographic information for each plot previously extracted and processed from GEE. For demonstration purposes, however, all values are entirely randomly generated and do not reflect real environmental conditions.

7_MODELE_AGB_sans_montane:
-MEM_WC.RMD : This code corresponds to the structural causal modelling framework performed in the study (see Methods). It provides an example using the WorldClim climate source. The same analysis was repeated for each climate source, and results were produced accordingly. Additionally, all models were rerun with montane plots (>1000 m) excluded; illustrates the version with high-elevation plots removed.
- MEM_WC_Africa.RMD : This script follows the same structure as the MEM_WC.R script, but is applied specifically to the African subset, where we tested models that include the percentage of pioneer species as an additional predictor. For demonstration purposes, the percentage of pioneer species is randomly generated here. In the actual dataset, this variable was derived from the CoForTraits database (https://dataverse.cirad.fr/dataset.xhtml?persistentId=doi:10.18167/DVN1/Y2BIZK), which compiles trait data for Central African tree species. The two R scripts used to calculate this metric from the original data are provided as "4_FieldDataInventories_Analyse_Temperament.R" and "5_PlotsMetrics_Analyse_Temperament.R".

7_Modeles_bis_sans_montane: This file contains the same script as previously described, but extended to include the full sequence of models build for structural causal modelling.

8_Graph : This folder contains all the  scripts used to produce the figures and tables, including the mean_coef_and_rmse.R script, which should be run first to calculate the averaged relationships/coefficients (between climate and structural attribues/AGB) across climate sources.The tables generated by this script are subsequently used to produce the study's figures using the other scripts provided. The PCA.RMD code was used to perform the initial selection of the three bioclimatic variables included in the study.




## License

⚠️This code is shared confidentially with reviewers and editors for evaluation purposes only. It is not yet publicly licensed. A public release under an open license will follow upon publication.

---

Please contact [pauline.depoortere@uliege.be] for any questions or collaboration requests.
