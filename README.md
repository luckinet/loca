# LUCKINet universal computation algorithm (LUCA)

This is the main directory for LUCA, the pipeline that builds the LUCKINet land use time-series. This pipeline is, after specifying the model-parameters, fully automatic and reproducible at any time, and can either be run on a single machine, or on a dedicated high-performance cluster, for better speed performance.

Each folder here contains one module that carries out a particular delimitable set of tasks, or the data used here. The scripts are sorted into the folder 'bin' and 'src'. The first folder contains the main script that calls the scripts in the latter folder for sub-tasks.

The whole pipeline is started with the scripts *01_boot_framework.R* and *02_boot_functions.R*, which are, however, not started directly, but from the main scripts in each module.

What follows is a low-level description of the modules, where a more detailed description of the respective modules can be found in the respective directories.

## 00_data

## 01_setup_framework

This module has the purpose of preparing all data that are required for a specific model run, such as setting up a model-specific profile containing all parameters for the model-run and preparing all input data for the spatial and temporal subset.

## 02_build_ontology

## 03 build_census_database

## 03_build_occurrence_database

## 03_prepare_gridded_layers

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
