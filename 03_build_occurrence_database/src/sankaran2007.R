# script arguments ----
#
thisDataset <- "Sankaran2007"
description <- "This data set includes the soil and vegetation characteristics, herbivore estimates, and precipitation measurement data for the 854 sites described and analyzed in Sankaran et al., 2005. Savannas are globally important ecosystems of great significance to human economies. In these biomes, which are characterized by the co-dominance of trees and grasses, woody cover is a chief determinant of ecosystem properties. The availability of resources (water, nutrients) and disturbance regimes (fire, herbivory) are thought to be important in regulating woody cover but perceptions differ on which of these are the primary drivers of savanna structure. Analyses of data from 854 sites across Africa (Figure 1) showed that maximum woody cover in savannas receiving a mean annual precipitation (MAP) of less than approximately 650 mm is constrained by, and increases linearly with, MAP. These arid and semi-arid savannas may be considered stable systems in which water constrains woody cover and permits grasses to coexist, while fire, herbivory and soil properties interact to reduce woody cover below the MAP-controlled upper bound. Above a MAP of approximately 650 mm, savannas are unstable systems in which MAP is sufficient for woody canopy closure, and disturbances (fire, herbivory) are required for the coexistence of trees and grass. These results provide insights into the nature of African savannas and suggest that future changes in precipitation may considerably affect their distribution and dynamics (Sankaran et al., 2005). This data set includes the site characteristics and measurement data for the 854 sites described and analyzed in Sankaran et al., 2005. The data are provided in two formats, *.xls and *.csv. See the data format section below for more information."
url <- "http://dx.doi.org/10.3334/ORNLDAAC/850 https://"
licence <- ""


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "850.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-13"),
           type = "static",
           licence = licence,
           contact = NA_character_,
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "gv_aws_850/data/woody_cover_20070206.csv"))
data <- data[-c(1),]


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = Country,
    x = Long,
    y = Lat,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = Site_Description,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
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
