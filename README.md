# LUCKINet overall computation algorithm (LOCA)

## Introduction

LOCA is our first attempt at a generalized modelling pipeline to allocate land-use statistics into a map. LUCKINet distinguishes itself from similar projects by our focus on temporal, spatial and thematic consistency. This readme provides all basics and instructions to re-run a LOCA model (such as *luts* or *gpw*) and explains how you can set up your own modules or a new model-run to contribute to or build on this effort.

First of all, what does model or model-run mean and which role do modules play? LOCA is organized in a modular fashion and each model is a particular combination of modules and/or input data based on which the allocation is done. A model-run, in contrast, is a particular set of parameters characterizing the model, for example the spatial or temporal extent or subsets of the data. Modules comprise any self-contained, functionally similar part of the modelling pipeline. A module should have clearly defined input and output data so that it can be readily run based on the input and downstream applications can themselves readily run based on its output. As such, a module could be replaced by an updated or more sophisticated version that solves the same problem.

## Contribute

LOCA is designed in a way to make it easy for anybody that understands `R` and `git` to contribute. The aim of LUCKINet is to create not only yet another set of maps, but to also facilitate a community of users and producers of maps surrounding land use that keep both data and methods up to date.

Due to the short-term perspective based on which science is run, a single project usually doesn't - out of its own strength - have the viability to support the enterprise we aim at, so emancipating and enabling the community is an important contribution LUCKINet tries to achieve.

Iterating through many configurations, we found the setup described in the following sections useful. The beauty of this setup is that both, creating a totally new repository according to the same rules, forking it, or contributing to our original repository, leads to a common workflow across the whole *LOCA-verse* with as simple a "hack" as changing the model name in the `_boot.R` script (*TODO: after finishing everything, check again whether that is true*).

## The Environment

A LOCA model requires some initial model-specific files... (*TODO: make this an archive that can be downloaded and insert the link below at "create new project"*)

-   `_boot.R`
-   `_functions.R`
-   `_licenses.R`
-   `_snippets.R`
-   `README.md` (this file)
-   `LICENSE`
-   `loca.Rproj`
-   `.gitignore`
-   and the directory `_profile` which includes a `00_template.R` file to setup model runs
-   (we are additionally using directories `_admin` and `_misc` to store other files, not directly related to the modelling pipeline, but those are git-ignored)

... whereas functionally similar tasks are carried out in modules, which require

-   `00_main.R`
-   potentially `00_template.R`, a script template that documents how a repeated task is carried out in a standardized way
-   `_TASK-XX.R`, scripts that are created to handle the tasks at hand in this module
-   a documentation file (\_MODULENAME.md) containing progress and open tasks, they can be stored in another location if it contains embargoed information (see `loca->_boot.R->dir_docs`)
-   `README.md`, describing the rationale of the module and how to use the template
-   `LICENSE`
-   `.gitignore`
-   (we are additionally using directories `_pub` and `_misc` to store publications and other files if needed and `_data` to store the module specific input and output data, but those are git-ignored)

You can either fork/clone the repositories you find here (including [luckinet/loca](https://github.com/luckinet/loca) and the modules you want to contribute to), or 

1.  create a new project,
2.  copy the [initial files]() into it, 
3.  build the model profile by modifying `_profile/00_template.R` as needed and store it as `MODELNAME.R`,
4.  run `_boot.R` in it's entirety.
5.  clone the module repositories you want to use into the root directory (i.e., where also `_boot.R` is located), or create them yourself based on the above module files, if you want to design a new module. Having them inside the root directory allows fully hierarchical, uncomplicated use of paths.

Various models can be defined in parallel and can make use of the same modules and thus input resources.

## The initial setup

There are a range of external dataset files that are at the basis of each model, regardless of the scope of the specific model. Those initial files set the standards, so to speak, used throughout a model. Just like modules, those could be replaced by other files to set other standards, as long as those other standards fulfill the downstream requirements of the modules in use.

### GADM

As the land-use data we allocate are typically reported as areal data, they are typically either explicitly or implicitly related to the territorial units of the reporting nation. As territorial basis, we currently use the [GADM version 3.6](https://gadm.org/download_world36.html) database in six separate layers in geopackage format (`gadm36_levels_gpkg.zip`).

### ESA-CCI landcover

To allocate land-use data into a map, we require a map basis that contains (land cover) classes to which the land-use information can sensibly be associated. As there is currently only the ESA-CCI landcover initiative available as landcover time-series, we make use of this.

*TODO: this still needs mention of where a table that relates the landcover groups to crops should be stored and processed.*

### UN geoscheme

To group nations meaningfully, we use the [United Nations geoscheme](https://unstats.un.org/unsd/methodology/m49/overview/), which is well agreed upon and used widely (`UNSD — Methodology.csv`).

## The pipeline

After downloading the initial files and modules, everything else is - mostly automatically - bootstrapped from here. Specific downloads and routines for processing the files are to be found in each respective module. The `00_main.R` file coordinates all tasks in the pipeline of a module, meta data and documentation can be accessed in the header here.

### design principles

#### Interoperability

The data one module produces need to be compatible with the downstream modules that make use of the data. To ensure this, each module comes with a script that contains tests that check all the upstream data for compatibility. After inserting a new module, this can be tested with the function `.check_compatibility()` (*TODO: still need to write that*).

#### Meta data

Meta data are recorded directly in the location, typically in the header, of the script where the data are used. This header consists of two sections, the first concerns itself with "our" meta data, e.g., information about the script such as `title`,  `license`,  `authors` and `version`, and others. The second section is module specific and thus contains different information for each module, which are described in the respective module-specific `README.md`.
