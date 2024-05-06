# ----
# geography : Sub-Saharan Africa and Carribean
# period    : 2000, 2005, 2010, 2015, 1016, 2020
# typology  :
#   - cover  : various
#   - use    : vegetated
# features  : 43433
# data type : point
# sample    : _INSERT
# doi/url   : https://doi.org/10.5194/essd-13-3767-2021
# license   : _INSERT
# disclosed : _INSERT
# authors   : Steffen Ehrmann
# date      : 2024-04-17
# status    : done
# comment   : -
# ----

thisDataset <- "szantoi2021"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr_wip, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "dataset931968.bib"))

data_path_cmpr <- paste0(dir_input, "ALL_DATA_KLC_2.zip")
unzip(zipfile = data_path_cmpr, exdir = dir_input)
unzip(zipfile = paste0(dir_input, "ValidationData.zip"), exdir = dir_input)

files <- list.files(path =  paste0(dir_input, "/ValidationData/"),
                    pattern = ".shp$", full.names = TRUE)

data <-  map(.x = files, .f = function(ix){
  region <- str_split(tail(str_split(ix, "/")[[1]], 1), "[.]")[[1]][1]
  st_read(dsn = ix) |>
    st_make_valid() |>
    st_transform(crs = "EPSG:4326") |>
    mutate(region = region, .before = 1)
}) |>
  bind_rows()


message(" --> normalizing data")
data <- data |>
  bind_cols(st_coordinates(data)) |>
  st_drop_geometry() |>
  mutate(obsID = row_number(), .before = 1)

other <- data |>
  select(obsID, region)

schema_szantoi2021 <-
  setFormat(header = 1L) |>
  setIDVar(name = "datasetID", value = thisDataset) |>
  setIDVar(name = "obsID", type = "i", columns = 1) |>
  setIDVar(name = "open", type = "l", value = TRUE) |>
  setIDVar(name = "type", value = "point") |>
  setIDVar(name = "x", type = "n", columns = 15) |>
  setIDVar(name = "y", type = "n", columns = 16) |>
  setIDVar(name = "epsg", value = "4326") |>
  setIDVar(name = "date", columns = c(3:14), rows = 1, split = "(\\d+)") |>
  setIDVar(name = "irrigated", type = "l", value = FALSE) |>
  setIDVar(name = "present", type = "l", value = TRUE) |>
  setIDVar(name = "sample_type", value = "visual interpretation") |>
  setIDVar(name = "collector", value = "expert") |>
  setIDVar(name = "purpose", value = "validation") |>
  setObsVar(name = "concept", type = "c", columns = c(3:14), top = 1)

temp <- reorganise(schema = schema_szantoi2021, input = data) |>
  filter(!is.na(concept))


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "Natural resources are increasingly being threatened in the world. Threats to biodiversity and human well-being pose enormous challenges to many vulnerable areas. Effective monitoring and protection of sites with strategic conservation importance require timely monitoring with special focus on certain land cover classes which are especially vulnerable. Larger ecological zones and wildlife corridors warrant monitoring as well, as these areas have an even higher degree of pressure and habitat loss as they are not “protected” compared to Protected Areas (i.e. National Parks). To address such a need, a satellite-imagery-based monitoring workflow to cover at-risk areas was developed. During the program's first phase, a total of 560 442 km2 area in sub-Saharan Africa was covered. In this update we remapped some of the areas with the latest satellite images available, and in addition we added some new areas to be mapped. Thus, in this version we updated and mapped an additional 852 025km2 in the Caribbean, African and Pacific regions with up to 32 land cover classes. Medium to high spatial resolution satellite imagery was used to generate dense time series data from which the thematic land cover maps were derived. Each map and change map were fully verified and validated by an independent team to achieve our strict data quality requirements. Further details regarding the sites selection, mapping and validation procedures are described in the corresponding publication: Szantoi, Zoltan; Brink, Andreas; Lupi, Andrea (2021): An update and beyond: key landscapes for conservation land cover and change monitoring, thematic and validation datasets for the African, Caribbean and Pacific region (in review, Earth System Science Data/).",
           homepage = "https://doi.pangaea.de/10.1594/PANGAEA.931968",
           date = ymd("2022-10-18"),
           license = "https://creativecommons.org/licenses/by/4.0/",
           ontology = path_onto_odb)

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = path_onto_odb)

out <- list(harmonised = out, extra = other)


message(" --> writing output")
saveRDS(object = out, file = paste0(dir_occurr_wip, "output/", thisDataset, ".rds"))
saveBIB(object = bib, file = paste0(dir_occurr_wip, "references.bib"))

beep(sound = 10)
message("\n     ... done")
