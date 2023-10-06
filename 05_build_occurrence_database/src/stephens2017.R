# script arguments ----
#
thisDataset <- "Stephens2017"
description <- "This data publication contains tabular data with measurements of tree and shrub data for a set of transects located in the Greenhorn Mountains, Sequoia National Forest in California. The transects represent a systematic timber inventory collected across a large mixed-conifer and ponderosa pine dominated landscape by the U.S. Forest Service in 1911. Trees were tallied by species and diameter within 20 x 400 meter strips that spanned the center of quarter-quarter sections (QQs) delineated by the Public Land Survey System. Shrub cover was determined using an ocular estimate and recorded qualitatively by species. Tabular data specifically include cover estimates for Chamaebatia foliolosa and an estimate for all other species as a whole; basal area for the following live trees ≥ 30.5 centimeters (cm) at diameter at breast height (dbh): Abies concolor, Calocedrus decurrens, Pinus lambertiana, Pinus ponderosa, and all conifer trees; as well as density of live conifer trees in three different dbh classes. Also included in this publication are scans of the original data collection sheets recorded in 1911."
url <- "https://doi.org/10.2737/RDS-2017-0064 https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- bibentry(
  bibtype = "Misc",
  title = "Timber survey data from 1911 in the Greenhorn Mountains, Sequoia National Forest",
  author = c(
    person("Scott L." ,"Stephens",  role = "aut", email = "fsrda@fs.fed.us"),
    person("Jamie M.", "Lydersen",  role = "aut"),
    person("Brandon M.", "Collins",  role = "aut"),
    person("Danny L.", "Fry",  role = "aut"),
    person("Marc D.", "Meyer",  role = "aut")),
  doi = "https://doi.org/10.2737/RDS-2017-0064",
  publisher = "Forest Service Research Data Archive",
  address = "Fort Collins, CO",
  year = 2017
)

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd(),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Data/Kern1911_TransectData.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = "United States of America",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = 1911,
    externalID = Lot_id,
    externalValue = NA_character_,
    irrigated = NA,
    presence = NA,
    sample_type = "field",
    collector = "expert",
    purpose = NA_character_) %>%
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
