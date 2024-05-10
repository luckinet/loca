# ----
# geography : Denmark
# period    : 2008 - 2024
# typology  :
#   - cover  : _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# sample    : _INSERT
# doi/url   : https://landbrugsgeodata.fvm.dk/
# license   : _INSERT
# disclosed : _INSERT
# authors   : Steffen Ehrmann
# date      : 2024-04-29
# status    : validate, normalize, done
# comment   : due to the size of the data, I have to deviate from the default outline of this script.
# ----

thisDataset <- "lpisDenmark"
message("\n---- ", thisDataset, " ----")

message(" --> handling metadata")
dir_input <- paste0(dir_occurr_wip, "input/", thisDataset, "/")

new_reference(object = paste0(dir_input, _INSERT),
              file = paste0(dir_occurr_wip, "references.bib"))

new_source(name = thisDataset,
           description = _INSERT,
           homepage = "https://landbrugsgeodata.fvm.dk/",
           date = ymd("2024-04-29"),
           license = _INSERT,
           ontology = path_onto_odb)


message(" --> handling data")
files <- list.files(dir_input, pattern = "zip")
prevNr <- 0

for(i in seq_along(files)){

  subset <- str_split(files[i], "[.]")[[1]][1]
  theDate <- str_split(subset, "_")[[1]][2]
  file.remove(list.files(paste0(dir_input, "temp"), full.names = T))

  message(" ---- year ", theDate, " ----")
  message("   --> reading in data")
  unzip(exdir = paste0(dir_input, "temp"), zipfile = paste0(dir_input, subset, ".zip"))

  inData <- st_read(dsn = list.files(paste0(dir_input, "temp/"), pattern = "shp", full.names = TRUE), options = "ENCODING=ISO-8859-1") |>
    st_transform(crs = 4326) |>
    st_make_valid()

  coords <- inData |>
    st_centroid() |>
    st_coordinates()

  data <- inData |>
    bind_cols(coords) |>
    mutate(date = theDate) |>
    mutate(obsID = row_number()+prevNr, .before = 1)
  prevNr <- prevNr + dim(data)[1]

  other <- data |>
    select(obsID, _INSERT)

  geom <- data |>
    select(obsID, geometry)

  message("   --> normalizing data")
  temp <- data |>
    mutate(open = TRUE,
           type = "areal",
           present = TRUE,
           sample_type = ,
           collector = ,
           purpose = ) |>
    select(datasetID, obsID, externalID = , open, type, x = , y = , date = , present, sample_type, collector, purpose, concept = )


  message("   --> harmonizing with ontology")
  out <- matchOntology(table = temp,
                       columns = "concept",
                       colsAsClass = FALSE,
                       dataseries = thisDataset,
                       ontology = path_onto_odb)

  out <- list(harmonised = out, extra = other)

  message("   --> writing output")
  saveRDS(object = out, file = paste0(dir_occurr_wip, "output/", thisDataset, "_", theDate, ".rds"))
  st_write(obj = geom, dsn = paste0(dir_occurr_wip, "output/", thisDataset, "_", theDate, ".gpkg"))
}

beep(sound = 10)
message("\n     ... done")


# schema_INSERT <-
#   setIDVar(name = "datasetID", value = thisDataset) |>
#   setIDVar(name = "obsID", type = "i", columns = 1) |>
#   setIDVar(name = "externalID", columns = _INSERT) |>
#   setIDVar(name = "open", type = "l", value = TRUE) |>
#   setIDVar(name = "type", value = "areal") |>
#   setIDVar(name = "x", type = "n", columns = _INSERT) |>
#   setIDVar(name = "y", type = "n", columns = _INSERT) |>
#   setIDVar(name = "date", columns = _INSERT) |>
#   setIDVar(name = "present", type = "l", value = TRUE) |>
#   setIDVar(name = "sample_type", value = _INSERT) |>
#   setIDVar(name = "collector", value = _INSERT) |>
#   setIDVar(name = "purpose", value = _INSERT) |>
#   setObsVar(name = "concept", type = "c", columns = _INSERT)



