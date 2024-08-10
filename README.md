# LUCKINet overall computation algorithm (LOCA)

## initial files

A loca model requires some basic model-specific files

-   `_boot.R`
-   `_functions.R`
-   `_snippets.R`
-   `_profile_template.R`
-   `README.md` (this file)
-   `.gitignore`

Each module requires additionally

-   a script template with a set of documentation fields
-   a documentation file (\_MODULENAME.md) describing the rationale of the module and how to use the template, they can be stored in another location (see `_boot.R->dir_docs`)

## setup

1.  create new project,
2.  copy the initial files into it, (TODO: make this an archive that can be downloaded)
3.  modify `_profile_template.R` as needed by adapting all `_INSERT` values and store it as `_profile_{MODELNAME}.R`,
4.  change the first variable in `_boot.R` (`model_name`) to `{MODELNAME}` and adapt the version value to something sensible,
5.  run `_boot.R` in it's entirety.
6.  copy module-specific files into the respective directories (or create them yourself, if you design up a new module)

Various models can be defined in parallel and can make use of the same input resources.

## download basic input files

### GADM

### ESA-CCI landcover

### UN geoscheme


## run the pipeline

After downloading the basic input files, everything else is bootstrapped from here. Specific downloads and routines for processing the files are to be found in each respective module. The `00_main.R` file coordinates all tasks in the pipeline of a module, meta data and documentation can be accessed in the header here.

## design principles

### module interaction

For modules to interact, ...
