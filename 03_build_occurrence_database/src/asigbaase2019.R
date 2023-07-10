# script arguments ----
#
thisDataset <- "Asigbaase2019"
description <- "Cocoa agroforestry systems have the potential to conserve biodiversity and provide environmental or ecological benefits at various nested scales ranging from the plot to ecoregion. While integrating organic practices into cocoa agroforestry may further enhance these potentials, empirical and robust data to support this claim is lacking, and mechanisms for biodiversity conservation and the provision of environmental and ecological benefits are poorly understood. A field study was conducted in the Eastern Region of Ghana to evaluate the potential of organic cocoa agroforests to conserve native floristic diversity in comparison with conventional cocoa agroforests. Shade tree species richness, Shannon, Simpson’s reciprocal and Margalef diversity indices were estimated from 84 organic and conventional cocoa agroforestry plots. Species importance value index, a measure of how dominant a species is in a given ecosystem, and conservation status were used to evaluate the conservation potential of shade trees on studied cocoa farms. Organic farms recorded higher mean shade tree species richness (5.10 ± 0.38) compared to conventional farms (3.48 ± 0.39). Similarly, mean Shannon diversity index, Simpson’s reciprocal diversity index and Margalef diversity index were significantly higher on organic farms compared to conventional farms. According to the importance value index, fruit and native shade tree species were the most important on both organic and conventional farms for all the cocoa age groups but more so on organic farms. Organic farms maintained 14 native tree species facing a conservation issue compared to 10 on conventional cocoa farms. The results suggest that diversified organic cocoa farms can serve as reservoirs of native tree species, including those currently facing conservation concerns thereby providing support and contributing to the conservation of tree species in the landscape."
url <- "https://doi.org/10.1371/journal.pone.0210557 https://" # doi, in case this exists and download url separated by empty space
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1371_journal.pone.0210557.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("30-10-2020"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = FALSE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(path = paste0(thisPath, "COORDINATES.xlsx"))


# harmonise data ----
#

temp <- data %>%
  mutate(Longitude = as.numeric(str_remove(Longitude, "[A-Z]")),
         Latitude = as.numeric(str_remove(Latitude, "[A-Z]")))

temp <- temp %>%
  separate_rows(month, sep = "_") %>%
  mutate(month = as.numeric(month)) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA, # year 2016 month "4_5_6_7_8"
    externalID = NA_character_,
    externalValue = "cocoa beans",
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
