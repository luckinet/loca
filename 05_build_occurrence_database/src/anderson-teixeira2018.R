# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.1002/ecy.2229
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : forest
# ----

thisDataset <- "Anderson-Teixeira2018"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "pericles_1939917099.bib"))

data_path <- paste0(dir_input, "FoC_global.xlsx")
data <- read_excel(path = data_path)


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)

other <- data %>%
  select(obsID, _INSERT)

schema_INSERT <-
  setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
            na_values = _INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "externalID", columns = _INSERT) %>%
  setIDVar(name = "open", type = "l", value = _INSERT) %>%
  setIDVar(name = "type", value = _INSERT) %>%
  setIDVar(name = "x", type = "n", columns = _INSERT) %>%
  setIDVar(name = "y", type = "n", columns = _INSERT) %>%
  setIDVar(name = "geometry", columns = _INSERT) %>%
  setIDVar(name = "date", columns = _INSERT) %>%
  setIDVar(name = "irrigated", type = "l", value = _INSERT) %>%
  setIDVar(name = "present", type = "l", value = _INSERT) %>%
  setIDVar(name = "sample_type", value = _INSERT) %>%
  setIDVar(name = "collector", value = _INSERT) %>%
  setIDVar(name = "purpose", value = _INSERT) %>%
  setObsVar(name = "concept", type = "c", columns = _INSERT)

# temp <- data %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "point",
#     country = NA_character_,
#     x = lon,
#     y = lat,
#     geometry = NA,
#     epsg = 4326,
#     area = NA_real_,
#     date = NA,
#     externalID = NA_character_,
#     externalValue = `...8`,
#     irrigated = FALSE,
#     presence = TRUE,
#     sample_type = "field",
#     collector = "expert",
#     purpose = "study") %>%
#   select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
#          externalID, externalValue, irrigated, presence,
#          sample_type, collector, purpose, everything())

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "Forests play an influential role in the global carbon (C) cycle, storing roughly half of terrestrial C and annually exchanging with the atmosphere more than five times the carbon dioxide (CO2) emitted by anthropogenic activities. Yet, scaling up from field-based measurements of forest C stocks and fluxes to understand global scale C cycling and its climate sensitivity remains an important challenge. Tens of thousands of forest C measurements have been made, but these data have yet to be integrated into a single database that makes them accessible for integrated analyses. Here we present an open-access global Forest Carbon database (ForC) containing previously published records of field-based measurements of ecosystem-level C stocks and annual fluxes, along with disturbance history and methodological information. ForC expands upon the previously published tropical portion of this database, TropForC (https://doi.org/10.5061/dryad.t516f), now including 17,367 records (previously 3,568) representing 2,731 plots (previously 845) in 826 geographically distinct areas. The database covers all forested biogeographic and climate zones, represents forest stands of all ages, and currently includes data collected between 1934 and 2015. We expect that ForC will prove useful for macroecological analyses of forest C cycling, for evaluation of model predictions or remote sensing products, for quantifying the contribution of forests to the global C cycle, and for supporting international efforts to inventory forest carbon and greenhouse gas exchange. A dynamic version of ForC is maintained at on GitHub (https://GitHub.com/forc-db), and we encourage the research community to collaborate in updating, correcting, expanding, and utilizing this database. ForC is an open access database, and we encourage use of the data for scientific research and education purposes. Data may not be used for commercial purposes without written permission of the database PI. Any publications using ForC data should cite this publication and Anderson-Teixeira et al. (2016a) (see Metadata S1). No other copyright or cost restrictions are associated with the use of this data set.",
           homepage = "https://doi.org/10.1002/ecy.2229",
           date = dmy("22-12-2021"),
           license = _INSERT,
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
