# ----
# title       : prepare gridded layers - _INESRT
# description : This is the script for hamonizing _INSERT
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann, Ruben Remelgado
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

thisDataset <- "soilGrids"
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
theseFiles <- list.files(path = thisDir, pattern = "_30as.tif")

for(i in seq_along(theseFiles)){

  thisFile <- paste0(thisDir, theseFiles[i])

  # crop to model extent
  thisDir_mdl <- str_replace(thisFile, ".tif", paste0("_", model_info$tag, ".tif"))
  if(!testFileExists(x = thisDir_mdl, access = "rw")){

    message(" ---- layer ", theseFiles[i], " ----")
    crop(x = rast(thisFile), y = rast(x = path_modelregion),
         snap = "out",
         filename = thisDir_mdl,
         overwrite = TRUE,
         filetype = "GTiff",
         datatype = datatype(rast(thisFile)),
         gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

  }

}

beep(sound = 10)
message("\n     ... done")
