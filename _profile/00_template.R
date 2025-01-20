# ----
# title       : _MODULENAME
# description : _INSERT
# license     : _LICENSE
# authors     : _AUTHORNAMES
# date        : YYYY-MM-DD
# version     : 0.0.0
# status      : ...
# comment     : file.edit(paste0(dir_docs, "/documentation/01_setup_profile.md"))
# ----

# adapt the version, whenever changes are made on this file
model_version <- "0.0.0"

# set authors ----
#
authors <- list(cre = _INSERT,
                aut = list(_MODULENAME = _INSERT),
                ctb = list(_MODULENAME = _INSERT))

# set license ----
#
license <- list(model = licenses$_INSERT,
                data = licenses$_INSERT)

# set model dimensions ----
#
par <- list(years = c(_INSERT:_INSERT),
            extent = c(xmin = _WGS84, xmax = _WGS84, ymin = _WGS84, ymax = _WGS84),
            pixel_size = c(xres = _INSERT, yres = _INSERT),
            tile_size = c(_INSERT, _INSERT))

# set modules ----
#
modules <- list(_MODULENAME = paste0(dir_proj, _INSERT),
                _MODULENAME = paste0(dir_proj, _INSERT),
                ...)

# determine domains to model ----
#
domains <- list(crops = _INSERT,
                landuse = _INSERT,
                livestock = _INSERT,
                ...)

# set sub-modules ----
#
submodules <- list(_MODULENAME = list(_SUBMODULE = _INSERT),
                   ...)

# create pipeline directories ----
#
.create_directories(root = dir_proj, modules = modules)

# write output ----
#
.write_profile(path = paste0(dir_proj, "_profile/", model_name, "_", model_version, ".rds"),
               name = model_name,
               version = model_version,
               authors = authors,
               license = license,
               parameters = par,
               modules = modules,
               domains = domains,
               submodules = submodules)

model_info <- readRDS(file = getOption("loca_profile"))

# write ODD description file ----
#
.write_odd()

# clean up ----
#
rm(list = c("authors", "domains", "license", "modules", "submodules", "par", "path_profile"))

# other, manual code snippets ----
#



