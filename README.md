# LUCKINet overall computation algorithm (LOCA)

## Introduction

COMING SOON ...

## Contribute

LOCA is designed in a way to make it easy for anybody that understands `R` and `git`(hub) to contribute. The aim of LUCKINet early on was to create not only yet another set of maps, but to also facilitate a community of users and producers of maps surrounding land use that keep both data and methods up to date. Due to the way science is run, a single project usually doesn't have the viability to support such an enterprise out of its own strength, so emancipating and enabling the community is an important contribution LUCKINet tries to achieve. By following the simple steps outlined below, you can contribute to this. LOCA is organized in a modular fashion, which means that 
- functionally similar tasks are carried out together in a module and
- a module can in principle be replaced by a newer or more sophisticated version.

Iterating through many configurations, we found the setup described in the following sections useful. The beauty of this setup is that by both, creating a totally new repository according to the same rules, forking it, or contributing to our original repository, the design principles ensure a common workflow across the whole *"LOCA-verse"* with as simple a "hack" as *changing a path in the `_boot.R` script* (TODO: after finishing everything, check again whether that is true).

### initial files

A loca model requires some basic model-specific files... (TODO: make this an archive that can be downloaded)

-   `_boot.R`
-   `_functions.R`
-   `_licenses.R`
-   `_profile.R`
-   `_snippets.R`
-   `README.md` (this file)
-   `LICENSE`
-   `loca.Rproj`
-   `.gitignore`
-   and the directory `_profile` which includes a `00_template.R` file to setup model runs
-   (we are additionally using directories `_admin` and `_misc` to store other files, not directly related to the modelling pipeline, but those are gitignored)

... whereas functionally similar tasks are carried out in modules, which require

-   `00_main.R`
-   potentially `00_template.R`, a script template that documents how a repeated task is carried out in a standardized way
-   `_TASK-XX.R`, scripts that are created to handle the tasks at hand in this module
-   a documentation file (\_MODULENAME.md) containing progress and open tasks, they can be stored in another location if it contains embargoed information (see `loca->_boot.R->dir_docs`)
-   `README.md`, describing the rationale of the module and how to use the template
-   `LICENSE`
-   `.gitignore`
-   (we are additionally using directories `_pub` and `_misc` to store publications and other files if needed and `_data` to store the module specific input and output data, but those are gitignored)

### setup (if you start a new repository)

1.  create new project,
2.  copy the initial files into it, 
3.  modify `00_template.R` as needed by adapting all `_INSERT` values and store it as `{MODELNAME}.R`,
4.  change the variables in `_profile.R` (`model_name`) to `{MODELNAME}` and adapt the version value to something sensible,
5.  run `_boot.R` in it's entirety.
6.  clone the module repositories you want to use into the root directory (i.e., where also `_boot.R` is located), or create them yourself based on the above files, if you want to design a new module. Having them inside the root directory allows fully hierarchical, uncomplicated use of paths.

Various models can be defined in parallel and can make use of the same modules and input resources.

### download basic input files

#### GADM

#### ESA-CCI landcover

#### UN geoscheme


### run the pipeline

After downloading the *initial files*, everything else is bootstrapped from here. Specific downloads and routines for processing the files are to be found in each respective module. The `00_main.R` file coordinates all tasks in the pipeline of a module, meta data and documentation can be accessed in the header here.

### design principles

#### module interaction

The data one module produces need to be compatible mostly with the downstream modules that make use of the data. To ensure this, each module comes with a script that contains tests that check all the upstream data for compatibility. After inserting a new module, this can be tested with the function `.check_compatibility().R` (TODO: still need to write that).
