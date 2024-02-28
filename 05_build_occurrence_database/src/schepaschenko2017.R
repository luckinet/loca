thisDataset <- "schepaschenko2017"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "Schepaschenko-etal_2017.bib"))

data_path <- paste0(input_dir, "Biomass_plot_DB.tab")
data <- read_tsv(file = data_path,
                 skip = 54)


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)

other <- data %>%
  select(obsID, _INSERT)

schema__INSERT <-
  setFormat(header = 1L) %>%
  setFormat(decimal = _INSERT, thousand = _INSERT, na_values = _INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "externalID", columns = _INSERT) %>%
  setIDVar(name = "open", type = "l", value = TRUE) %>%
  setIDVar(name = "type", value = "point") %>%
  setIDVar(name = "x", type = "n", columns = _INSERT) %>% #Longitude
  setIDVar(name = "y", type = "n", columns = _INSERT) %>% #Latitude
  setIDVar(name = "epsg", value = "4326") %>%
  setIDVar(name = "geometry", columns = _INSERT) %>%
  setIDVar(name = "date", columns = _INSERT) %>% #`Date (Year of measurements)`
  setIDVar(name = "irrigated", type = "l", value = FALSE) %>%
  setIDVar(name = "present", type = "l", value = TRUE) %>%
  setIDVar(name = "sample_type", value = "field") %>%
  setIDVar(name = "collector", value = "expert") %>%
  setIDVar(name = "purpose", value = "study") %>%
  setObsVar(name = "concept", type = "c", columns = _INSERT) #`ID (Unique record ID)`, Origin

temp <- reorganise(schema = schema__INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "The most comprehensive dataset of in situ destructive sampling measurements of forest biomass in Eurasia have been compiled from a combination of experiments undertaken by the authors and from scientific publications. Biomass is reported as four components: live trees (stem, bark, branches, foliage, roots); understory (above- and below ground); green forest floor (above- and below ground); and coarse woody debris (snags, logs, dead branches of living trees and dead roots), consisting of 10,351 unique records of sample plots and 9,613 sample trees from ca 1,200 experiments for the period 1930–2014 where there is overlap between these two datasets. The dataset also contains other forest stand parameters such as tree species composition, average age, tree height, growing stock volume, etc., when available. Such a dataset can be used for the development of models of biomass structure, biomass extension factors, change detection in biomass structure, investigations into biodiversity and species distribution and the biodiversity-productivity relationship, as well as the assessment of the carbon pool and its dynamics, among many others.",
           homepage = "https://doi.org/10.1038/sdata.2017.70",
           date = ymd("2021-12-17"),
           license = "https://creativecommons.org/licenses/by/4.0/",
           ontology = odb_onto_path)

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = odb_onto_path)


message(" --> writing output")
saveRDS(object = out, file = paste0(occurr_dir, "output/", thisDataset, ".rds"))
saveRDS(object = other, file = paste0(occurr_dir, "output/", thisDataset, "_extra.rds"))
saveBIB(object = bib, file = paste0(occurr_dir, "references.bib"))

beep(sound = 10)
message("\n     ... done")
