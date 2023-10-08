# author and date of creation ----
#
# Steffen Ehrmann, 23.02.2022


# script description ----
#
# This script builds rasters of all sort of national level socio-economic
# indicator variables from FAOstat by downscaling them to a 1km² grid.
message("\n---- prepare the basic spatial files to build gridded layers ----")

library(luckiTools)
library(terra)
library(sf)
library(stars)
library(tidyverse)
library(checkmate)
library(gdalUtils)


# set paths ----
#
projDir <- select_path(idivnb283 = "/media/se87kuhe/external1/projekte/LUCKINet/",
                       default = "/gpfs1/data/idiv_meyer/01_projects/LUCKINet/")
dataDir <- select_path(idivnb283 = paste0(projDir, "01_data/"),
                       default = "/gpfs1/data/idiv_meyer/00_data/")
modlDir <- paste0(projDir, "02_data_processing/01_prepare_gridded_layers/")


# script arguments ----
#
# make sure paths have been set
assertDirectoryExists(x = dataDir)


# load data ----
#
geom <- st_read(dsn = paste0(dataDir, "original/gadm36_levels.gpkg"), layer = "level0")
template <- rast(xmin = -180, xmax = 180, ymin = -90, ymax = 90, ncols = 43200, nrows = 21600)


# data processing ----
#
# 1. simplify geometries
temp <- st_cast(geom, "POLYGON") %>%
  st_simplify(preserveTopology = TRUE, dTolerance = 500)
message("simplify: OK")

getMemoryUse()

temp2 <- temp %>%
  group_by(NAME_0) %>%
  summarise()
message("aggregate: OK")

getMemoryUse()

temp2 <- temp2[!st_is_empty(temp2), , drop = FALSE]
temp2 %>% st_cast("MULTIPOLYGON") %>%
  full_join(countries, by = c("NAME_0" = "unit")) %>%
  filter(!is.na(ahID)) %>%
  filter(!st_is_empty(geom)) %>%
  arrange(ahID) %>%
  st_write(dsn = paste0(dataDir, "processed/GADM/GADM_simple-level1_20190000.gpkg"), delete_layer = TRUE)

# 2. rasterise simplified geometries
gdalUtils::gdal_rasterize(src_datasource = paste0(dataDir, "processed/GADM/GADM_simple-level1_20190000.gpkg"),
                          dst_filename = paste0(dataDir, "processed/GADM/GADM_simple-level1_20190000.tif"),
                          a = "ahID",
                          at = TRUE, te = c(-180, -90, 180, 90), tr = res(template),
                          co = c("COMPRESS=DEFLATE", "ZLEVEL=9"))


# write output ----
#

# beep(sound = 10)
message("\n     ... done")
