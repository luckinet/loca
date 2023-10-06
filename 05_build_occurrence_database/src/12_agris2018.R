# script arguments ----
#
thisDataset <- "agris2018"
description <- "This point feature class contains the locations of all 87 experimental forests, ranges and watersheds, including cooperating experimental areas."
url <- "https://doi.org/ https://data.amerigeoss.org/tl/dataset/experimental-forest-and-range-locations-feature-layer"
licence <- ""

# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "agrisexport.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("28-10-2020"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Experimental_Forest_and_Range_Locations__Feature_Layer_.csv"))


# harmonise data ----
#
temp <- data %>%
  rowwise() %>%
  mutate(
    year = paste0(seq(from = ESTABLISHED, to = year(Sys.Date()), 1), collapse = "_") # check if the to year is still correct
  )

temp <- temp %>%
  separate_rows(year, sep = "_") %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "USA",
    x = X,
    y = Y,
    geometry = NA,
    epsg = 4326,
    area = HECTARES * 10000,
    date = ymd(paste0(year, "-01-01")),
    externalID = as.character(OBJECTID),
    externalValue = TYPE,
    irrigated = NA,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "map development") %>%
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
