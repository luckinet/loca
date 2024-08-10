# LUCKINet overall computation algorithm (LOCA)

## initial files

A loca model require some basic model-specific files

- `_boot.R`
- `_functions.R`
- `_snippets.R`
- `_profile_template.R`
- `README.md` (this file)
- `.gitignore`

Each module requires additionally

- a script template with a set of documentation fields
- a documentation file (_MODULENAME.md) describing the rationale of the module and how to use the template


1. create new project,
2. copy the initial files into it,
3. modify `_profile_template.R` as needed by adapting all `_INSERT` values and store it as `_profile_{MODELNAME}.R`,
4. change the first variable in `_boot.R` to `{MODELNAME}` and adapt the version value to something sensible,
5. run `_boot.R` in it's entirety.
6. copy module files into the respective directories (or create them yourself, if you set up a new module)

Various models can be defined in parallel and can make use of the same input resources.

## module interaction

For modules to interact, ...

## download basic input files

### GADM

### ESA-CCI landcover
