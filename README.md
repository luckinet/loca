# LUCKINet universal computation algorithm (LUCA)

This is the main directory for LUCA, the pipeline that builds the LUCKINet land use time-series. This pipeline is, after specifying the model-parameters, fully automatic and reproducible at any time, and can either be run on a single machine, or on a dedicated high-performance cluster, for better speed performance.

Each folder here contains one module that carries out a particular delimitable set of tasks. Within each module, the scripts are sorted into the folders 'bin' and 'src'. The first folder contains the main script that calls the scripts in the latter folder for sub-tasks.

The whole pipeline is started with the scripts *01_boot_framework.R* and *02_boot_functions.R*, which are, however, not started directly, but from the main scripts in each module.

What follows is a low-level description of the modules, where a more detailed description of the respective modules can be found in the respective directories.

## 00_data

This directory is not a module per se, but contains all input and output data. These are, first of all, a *census* database and an *occurrence* database (built and described in detail in modules 3.1 and 3.2). An *input* and *processed* directory are the place where all incoming (spatial) data are placed and all standardized gridded data (prepared in module 3.3) are kept, respectively. The directory *tables* contains all data that are not explicitly spatial and which are ready for analyses (such as the land use ontology). Finally, the directory *model_run* contains all (tentative) data that become available during a model run, and also the final outputs.

## 01_setup_framework

This module has the purpose of preparing all data that are required for a specific model run, such as setting up a model-specific profile containing all parameters for the model-run, optionally building tiles, in case the spatial extent would be too large otherwise and ...

## 02_build_ontology

This module contains code to create the LUCKINet land use ontology and the LUCKINet gazetteer. The former contains all harmonized landcover, land use and agricultural commodity concepts, and mappings from other ontologies and vocabularies to our ontology, the latter contains all territorial units and their hierarchical order as well as mappings from external data-sets to our gazetteer.

## 03_build_census_database

This module creates the areal census database of land use and agricultural commodity statistics. All concepts are harmonized with the LUCKINet land use ontology and territorial concepts are harmonized with the LUCKINet gazetteer. Scripts are organised mostly per nation, except when data are part of a regional or global data-series, such as from the FAO. Validity checks are carried out and a Quality Flag is constructed.

## 03_build_occurrence_database

This module creates the occurrence database of land use and agricultural commodity statistics. All concepts are harmonized with the LUCKINet land use ontology. There is a script per data-set that organizes the data into a standardized table. Validity checks are carried out and a Quality Flag is constructed.

## 03_prepare_gridded_layers

This module prepares the gridded layers. All pre and post-processing steps for a spatial dataset are stored in a more or less standardized script. After carrying out the overall dataset specific steps, the script subsets the tentative global rasters to the spatial subset required for the current model run. Both steps are, however, only carried out, if the respective raster(s) are not yet already available in the expected place.  

## 04_suitability_modelling

## 05_build_initial_landuse

## 06_allocation_modelling

## 07_output_validation

Contains sub-modules that access the data and evaluate or validate them, for instance to assess data availability, validity and consistency. This concerns mostly the final data product, and checks that are similar to unit-tests are part of each module, making sure that the intermediate data produced by a module correspond to the data required by a downstream module.

## 08_visualisation

# Further Links

LUCKINet\@github: <https://github.com/luckinet>

LUCKINet\@zenodo: <https://zenodo.org/communities/luckinet/?page=1&size=20>

LUCKINet\@pangeae:

LUCKINet\@idiv: <https://www.idiv.de/luckinet/>

GeoKur\@TU-Dresden: <https://geokur.geo.tu-dresden.de/>

Spatial Ecology: <http://spatial-ecology.net/dokuwiki/doku.php>
