# script arguments ----
#
thisDataset <- "Teixeira2015"
description <- "Crop species exhibit an astounding capacity for environmental adaptation, but genetic bottlenecks resulting from intense selection for adaptation and productivity can lead to a genetically vulnerable crop. Improving the genetic resiliency of temperate maize depends upon the use of tropical germplasm, which harbors a rich source of natural allelic diversity. Here, the adaptation process was studied in a tropical maize population subjected to 10 recurrent generations of directional selection for early flowering in a single temperate environment in Iowa, USA. We evaluated the response to this selection across a geographical range spanning from 43.05° (WI) to 18.00° (PR) latitude. The capacity for an all-tropical maize population to become adapted to a temperate environment was revealed in a marked fashion: on average, families from generation 10 flowered 20 days earlier than families in generation 0, with a nine-day separation between the latest generation 10 family and the earliest generation 0 family. Results suggest that adaptation was primarily due to selection on genetic main effects tailored to temperature-dependent plasticity in flowering time. Genotype-by-environment interactions represented a relatively small component of the phenotypic variation in flowering time, but were sufficient to produce a signature of localized adaptation that radiated latitudinally, in partial association with daylength and temperature, from the original location of selection. Furthermore, the original population exhibited a maladaptive syndrome including excessive ear and plant heights along with later flowering; this was reduced in frequency by selection for flowering time."
url <- "https://doi.org/10.1038/hdy.2014.90 https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_hdy.2014.90-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-04-13"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "teixeira_etal_rawdata.csv"), skip = 51)


# harmonise data ----
#
temp <- data %>%
  distinct(lat, lon, pd, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = lat,
    y = lon,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = dmy(pd),
    externalID = NA_character_,
    externalValue = "maize",
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
