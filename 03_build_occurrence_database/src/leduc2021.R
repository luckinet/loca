# script arguments ----
#
thisDataset <- "Leduc2021"
description <- "A poor longleaf site in Rapides Parish, Louisiana was direct-seeded in 1965 and then thinned in 1974 using several different levels of thinning that ranged from thinning to 3000 trees per acre to thinning to 500 trees per acre as well as a treatment that included cutting all trees in strips. The data included in this publication contain tree measurements collected after thinning and repeated every 5 or more years until the study was closed, which resulted in the following data collection years: 1979, 1984, 1989, 2002, and 2009. Measurements include approximate age of stand and diameter at breast height for every tree in each plot. Also included for a subset of trees each year is: height to base of live crown, tree height, crown class, bark thickness in two directions, and height of trees to 4 different outside bark diameters (2, 4, 6, and 8 inches)."
url <- "https://doi.org/10.2737/RDS-2021-0048 https://"
licence <- ""


# reference ----
#
bib <- bibentry(
  title = "Precommercial thinning direct-seeded longleaf pine data on a poor site",
  bibtype = "Misc",
  year = 2021,
  doi = "https://doi.org/10.2737/RDS-2021-0048",
  institution = "Forest Service Research Data Archive",
  author = c(
    person(c("Daniel J.", "Leduc")),
    person(c("Richard E.", "Lohrey"))),
  address = "Fort Collins, CO")

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-19"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Data/study331.csv"))


# harmonise data ----
#
temp <- data %>%
  distinct(latitude, longitude, year, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "United States of America",
    x = longitude,
    y = latitude,
    geometry = NA,
    epsg = 4326,
    area = 1000,
    date = NA,
    externalID = NA_character_,
    externalValue = "Planted Forest",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
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
