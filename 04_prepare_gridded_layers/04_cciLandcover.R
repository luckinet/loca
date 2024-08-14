# ----
# title       : prepare gridded layers - ESA CCI landcover
# description : This is the script for harmonizing the ESA CCI landcover dataset
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-MM-DD
# version     : 0.0.0
# status      : find data, update, inventarize, validate, normalize, done
# comment     : file.edit(paste0(dir_docs, "/documentation/03_prepare_gridded_layers.md"))
# ----
# doi/url     : _INSERT
# license     : _INSERT
# resolution  : _INSERT
# years       : _INSERT
# variables   : _INSERT
# ----

thisDataset <- "cciLandcover"
message("\n---- ", thisDataset, " ----")

thisDir <- .get_path(module = "grid", data = thisDataset)

message(" --> handling metadata")
regDataseries(name = thisDataset,
              description = _INSERT,
              homepage = _INSERT,
              version = _INSERT,
              licence_link = _INSERT,
              reference = read.bib(paste0(thisDir, "_INSERT.bib")))

message(" --> handling data")
theseFiles <- list.files(path = thisDir, pattern = "_10as.tif")

for(i in seq_along(theseFiles)){

        thisFile <- paste0(thisDir, theseFiles[i])

        # crop to model extent
        thisDir_mdl <- str_replace(thisFile, ".tif", paste0("_", model_info$tag, ".tif"))
        if(!testFileExists(x = thisDir_mdl, access = "rw")){

                message(" ---- layer ", theseFiles[i], " ----")
                crop(x = rast(thisFile), y = rast(path_modelregion),
                     snap = "out",
                     filename = thisDir_mdl,
                     overwrite = TRUE,
                     filetype = "GTiff",
                     datatype = datatype(rast(thisFile)),
                     gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

        }

        # extract urban pixels and resample to 30as
        thisDir_mdl_urban <- str_replace(thisDir_mdl, "_10as", paste0("_urban_30as"))
        if(!testFileExists(x = thisDir_mdl_urban, access = "rw")){

                ifel(test = rast(thisDir_mdl) %in% c(190), 1, 0) |>
                        resample(y = rast(path_modelregion),
                                 method = "sum",
                                 filename = thisDir_mdl_urban,
                                 overwrite = TRUE,
                                 filetype = "GTiff",
                                 datatype = datatype(rast(thisFile)),
                                 gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

        }

        # extract water pixels and resample to 30as
        thisDir_mdl_water <- str_replace(thisDir_mdl, "_10as", paste0("_water_30as"))
        if(!testFileExists(x = thisDir_mdl_water, access = "rw")){

                ifel(test = rast(thisDir_mdl) %in% c(210, 220), 1, 0) |>
                        resample(y = rast(path_modelregion),
                                 method = "sum",
                                 filename = thisDir_mdl_water,
                                 overwrite = TRUE,
                                 filetype = "GTiff",
                                 datatype = datatype(rast(thisFile)),
                                 gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

        }

        # extract bare pixels and resample to 30as
        thisDir_mdl_bare <- str_replace(thisDir_mdl, "_10as", paste0("_bare_30as"))
        if(!testFileExists(x = thisDir_mdl_bare, access = "rw")){

                ifel(test = rast(thisDir_mdl) %in% c(140, 200, 201, 202), 1, 0) |>
                        resample(y = rast(path_modelregion),
                                 method = "sum",
                                 filename = thisDir_mdl_bare,
                                 overwrite = TRUE,
                                 filetype = "GTiff",
                                 datatype = datatype(rast(thisFile)),
                                 gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

        }
}

beep(sound = 10)
message("\n     ... done")

# ### esa cci land cover ----
# luckiOnto <- new_source(name = "esalc",
#                         date = Sys.Date(),
#                         version = "2.1.1",
#                         description = "The CCI-LC project delivers consistent global LC maps at 300 m spatial resolution on an annual basis from 1992 to 2020 The Coordinate Reference System used for the global land cover database is a geographic coordinate system (GCS) based on the World Geodetic System 84 (WGS84) reference ellipsoid.",
#                         homepage = "https://maps.elie.ucl.ac.be/CCI/viewer/index.php",
#                         ontology = luckiOnto)
#
# esalcID <- tribble(
#         ~label, ~description,
#         "10", "Cropland, rainfed",
#         "11", "Herbaceous cover",
#         "12", "Tree or shrub cover",
#         "20", "Cropland, irrigated or post‐flooding",
#         "30", "Mosaic cropland (>50%) / natural vegetation (tree, shrub, herbaceous cover) (<50%)",
#         "40", "Mosaic natural vegetation (tree, shrub, herbaceous cover) (>50%) / cropland (<50%)",
#         "50", "Tree cover, broadleaved, evergreen, closed to open (>15%)",
#         "60", "Tree cover, broadleaved, deciduous, closed to open (>15%)",
#         "61", "Tree cover, broadleaved, deciduous, closed (>40%)",
#         "62", "Tree cover, broadleaved, deciduous, open (15‐40%)",
#         "70", "Tree cover, needleleaved, evergreen, closed to open (>15%)",
#         "71", "Tree cover, needleleaved, evergreen, closed (>40%)",
#         "72", "Tree cover, needleleaved, evergreen, open (15‐40%)",
#         "80", "Tree cover, needleleaved, deciduous, closed to open (>15%)",
#         "81", "Tree cover, needleleaved, deciduous, closed (>40%)",
#         "82", "Tree cover, needleleaved, deciduous, open (15‐40%)",
#         "90", "Tree cover, mixed leaf type (broadleaved and needleleaved)",
#         "100", "Mosaic tree and shrub (>50%) / herbaceous cover (<50%)",
#         "110", "Mosaic herbaceous cover (>50%) / tree and shrub (<50%)",
#         "120", "Shrubland",
#         "121", "Evergreen shrubland",
#         "122", "Deciduous shrubland",
#         "130", "Grassland",
#         "140", "Lichens and mosses",
#         "150", "Sparse vegetation (tree, shrub, herbaceous cover) (<15%)",
#         "151", "Sparse tree (<15%)",
#         "152", "Sparse shrub (<15%)",
#         "153", "Sparse herbaceous cover (<15%)",
#         "160", "Tree cover, flooded, fresh or brakish water",
#         "170", "Tree cover, flooded, saline water",
#         "180", "Shrub or herbaceous cover, flooded, fresh/saline/brakish water",
#         "190", "Urban areas",
#         "200", "Bare areas",
#         "201", "Consolidated bare areas",
#         "202", "Unconsolidated bare areas",
#         "210", "Water bodies",
#         "220", "Permanent snow and ice"
# )

