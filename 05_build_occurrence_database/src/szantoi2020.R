# ----
# geography : Sub-Saharan Africa
# period    : 2000, 2015 - 2017
# typology  :
#   - cover  : various
#   - dynamic: -
#   - use    : vegetated
# features  : 35927
# data type : point
# doi/url   : https://doi.org/10.5194/essd-2020-77
# authors   : Steffen Ehrmann
# date      : 2024-04-17
# status    : done
# comment   : -
# ----

thisDataset <- "szantoi2020"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "dataset914261.bib"))


data_path_cmpr <- paste0(input_dir, "ALL_DATA.zip")
unzip(exdir = input_dir, zipfile = data_path_cmpr)

files <- list.files(path = paste0(input_dir, "ALL_DATA/validationData_Sub-Sahara_Africa/"),
                    pattern = ".shp$", full.names = TRUE)

data <-  map(.x = files, .f = function(ix){
  region <- tail(str_split(ix, "/")[[1]], 1)
  st_read(dsn = ix) %>%
    mutate(region = region, .before = 3)
}) %>%
  bind_rows()


message(" --> normalizing data")
data <- data %>%
  st_drop_geometry() %>%
  mutate(obsID = row_number(), .before = 1)

other <- data %>%
  select(obsID, region, reliable)

schema_szantoi2020 <-
  setFormat(header = 1L) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "open", type = "l", value = TRUE) %>%
  setIDVar(name = "type", value = "point") %>%
  setIDVar(name = "x", type = "n", columns = 2) %>%
  setIDVar(name = "y", type = "n", columns = 3) %>%
  setIDVar(name = "epsg", value = "4326") %>%
  setIDVar(name = "date", columns = c(5:8), rows = 1, split = "(\\d+)") %>%
  setIDVar(name = "irrigated", type = "l", value = FALSE) %>%
  setIDVar(name = "present", type = "l", value = TRUE) %>%
  setIDVar(name = "sample_type", value = "field") %>%
  setIDVar(name = "collector", value = "expert") %>%
  setIDVar(name = "purpose", value = "study") %>%
  setObsVar(name = "concept", type = "c", columns = c(5:8), top = 1)

temp <- reorganise(schema = schema_szantoi2020, input = data) %>%
  filter(!is.na(concept))


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "Threats to biodiversity pose an enormous challenge for Africa. Mounting social and economic demands on natural resources increasingly threaten key areas for conservation. Effective protection of sites of strategic conservation importance requires timely and highly detailed geospatial monitoring. Larger ecological zones and wildlife corridors warrant monitoring as well, as these areas have an even higher degree of pressure and habitat loss. To address this, a satellite imagery based15 monitoring workflow to cover at-risk areas at various details was developed. During the program’s first phase, a total of 560,442km2 area in Sub-Saharan Africa was covered, from which 153,665km2 were mapped with 8 land cover classes while 406,776km2 were mapped with up to 32 classes. Satellite imagery was used to generate dense time series data from which thematic land cover maps were derived. Each map and change map were fully verified and validated by an independent team to achieve our strict data quality requirements. The independent validation datasets for each KLCs are also described and 20 presented here (The complete dataset available at Szantoi et al., 2020A https://doi.pangaea.de/10.1594/PANGAEA.914261, and a demonstration dataset at Szantoi et al., 2020B https://doi.pangaea.de/10.1594/PANGAEA.915849).",
           homepage = "https://doi.pangaea.de/10.1594/PANGAEA.914261",
           date = ymd("2021-09-14"),
           license = "https://creativecommons.org/licenses/by/4.0/",
           ontology = path_onto_odb)

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = path_onto_odb)

out <- list(harmonised = out, extra = other)


message(" --> writing output")
saveRDS(object = out, file = paste0(dir_occurr, "output/", thisDataset, ".rds"))
saveBIB(object = bib, file = paste0(dir_occurr, "references.bib"))

beep(sound = 10)
message("\n     ... done")
