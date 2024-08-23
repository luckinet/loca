# LUCKINet overall computation algorithm (LOCA)

## initial files

A loca model requires some basic model-specific files...

-   `_boot.R`
-   `_functions.R`
-   `_snippets.R`
-   `_profile_template.R`
-   `README.md` (this file)
-   `LICENSE`
-   `loca.Rproj`
-   `.gitignore`

... whereas functionally similar tasks are carried out in modules, which require

-   `00_main.R`
-   potentially `00_template.R`, a script template that documents how a repeated task is carried out in a standardized way
-   `_TASK-XX.R`, scripts that are created to handle the tasks at hand in this module
-   a documentation file (\_MODULENAME.md) containing progress and open tasks, they can be stored in another location (see `loca->_boot.R->dir_docs`)
-   `README.md`, describing the rationale of the module and how to use the template
-   `LICENSE`
-   `_MODULENAME.Rproj`
-   `.gitignore`

## setup

1.  create new project,
2.  copy the initial files into it, (TODO: make this an archive that can be downloaded)
3.  modify `_profile_template.R` as needed by adapting all `_INSERT` values and store it as `_profile_{MODELNAME}.R`,
4.  change the first variable in `_boot.R` (`model_name`) to `{MODELNAME}` and adapt the version value to something sensible,
5.  run `_boot.R` in it's entirety.
6.  copy module-specific files into the respective directories (or create them yourself, if you design up a new module)
7.  create git repositories for the modules you want to publish

Various models can be defined in parallel and can make use of the same modules and input resources.

## download basic input files

### GADM

### ESA-CCI landcover

### UN geoscheme


## run the pipeline

After downloading the *initial files*, everything else is bootstrapped from here. Specific downloads and routines for processing the files are to be found in each respective module. The `00_main.R` file coordinates all tasks in the pipeline of a module, meta data and documentation can be accessed in the header here.

## design principles

### module interaction

The data one module produces need to be compatible mostly with the downstream modules that make use of the data. To ensure this, each module comes with a script that contains tests that check all the upstream data for compatibility. After inserting a new module, this can be tested with the function `.check_compatibility().R` (TODO: still need to write that).
