# script arguments ----
#
thisDataset <- "Asigbaase2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1371_journal.pone.0210557.ris"))

regDataset(name = thisDataset,
           description = "Cocoa agroforestry systems have the potential to conserve biodiversity and provide environmental or ecological benefits at various nested scales ranging from the plot to ecoregion. While integrating organic practices into cocoa agroforestry may further enhance these potentials, empirical and robust data to support this claim is lacking, and mechanisms for biodiversity conservation and the provision of environmental and ecological benefits are poorly understood. A field study was conducted in the Eastern Region of Ghana to evaluate the potential of organic cocoa agroforests to conserve native floristic diversity in comparison with conventional cocoa agroforests. Shade tree species richness, Shannon, Simpson’s reciprocal and Margalef diversity indices were estimated from 84 organic and conventional cocoa agroforestry plots. Species importance value index, a measure of how dominant a species is in a given ecosystem, and conservation status were used to evaluate the conservation potential of shade trees on studied cocoa farms. Organic farms recorded higher mean shade tree species richness (5.10 ± 0.38) compared to conventional farms (3.48 ± 0.39). Similarly, mean Shannon diversity index, Simpson’s reciprocal diversity index and Margalef diversity index were significantly higher on organic farms compared to conventional farms. According to the importance value index, fruit and native shade tree species were the most important on both organic and conventional farms for all the cocoa age groups but more so on organic farms. Organic farms maintained 14 native tree species facing a conservation issue compared to 10 on conventional cocoa farms. The results suggest that diversified organic cocoa farms can serve as reservoirs of native tree species, including those currently facing conservation concerns thereby providing support and contributing to the conservation of tree species in the landscape.",
           url = "https://doi.org/10.1371/journal.pone.0210557",
           download_date = "2020-10-30",
           type = "static",
           licence = "",
           contact = "see corresponding author",
           disclosed = "no",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_excel(path = paste0(thisPath, "COORDINATES.xlsx"))

# harmonise data ----
#
temp <- data %>% mutate(Longitude = as.numeric(str_remove(Longitude, "[A-Z]")),
                        Latitude = as.numeric(str_remove(Latitude, "[A-Z]")))


temp <- temp %>%
  mutate(
    datasetID = thisDataset,
    type = "point",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    year = 2016,
    month = "4_5_6_7_8",
    day = NA_integer_,
    country = NA_character_,
    irrigated = F,
    area = NA_real_,
    presence = F,
    externalID = NA_character_,
    externalValue = "cocoa beans",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(month, sep = "_") %>%
  mutate(month = as.numeric(month),
        fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
