# script arguments ----
#
thisDataset <- "Chain-Guadarrama2017"
description <- "Quantifying relationships between plant functional traits and abiotic gradients is valuable for evaluating potential responses of forest communities to climate change. However, the trajectories of change expected to occur in tropical forest functional characteristics as a function of future climate variation are largely unknown. We modeled community level trait values of Costa Rican rain forests as a function of current and future climate, and quantified potential changes in functional composition."
url <- "https://doi.org/10.1111/ecog.02637 https://"
license <- "CC0 1.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_1600058741.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-08-10"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir,
           notes = "time period imprecise")


# read dataset ----
#
data <- read_delim(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "observed CWM traits.csv"), delim = ";", n_max = 127)


# harmonise data ----
#
temp <- data %>%
  distinct(lat, long, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Costa Rica",
    x = long,
    y = lat,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = PLOT,
    externalValue = "Undisturbed Forest",
    irrigated = NA,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated, presence,
         sample_type, collector, purpose, everything())


# harmonize with ontology ----
#
new_source(name = thisDataset,
           description = description,
           homepage = url,
           date = Sys.Date(),
           license = licence,
           ontology = ontoDir)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
