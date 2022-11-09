# script arguments ----
#
thisDataset <- "Stevens2011"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "pericles_1939917092.ris"))

regDataset(name = thisDataset,
           description = "This data set consists of vascular plant and bryophyte species composition and plant and soil biogeochemical data from 153 acid grasslands located in the Atlantic biogeographic region of Europe. Data were collected between 2002 and 2007. The grasslands all belong to the Violion caninae association and were managed by grazing or cutting but had not received fertilizer inputs. These data provide plant composition from five randomly located 2 × 2 m quadrats at each site with all vascular plants and bryophytes identified to species level with cover estimates for each species. Topsoil and subsoil were collected in each quadrat, and data are provided for pH, metal concentrations, nitrate and ammonium concentrations, total carbon and N, and Olsen extractable phosphorus. Aboveground plant tissues were collected for three species (Rhytidiadelphus squarrosus, Galium saxatile, and Agrostis capillaris), and data are provided for percentage N, carbon, and phosphorus. These data have already been used in a number of research papers focusing on the impacts of atmospheric N deposition on grassland plant community and biogeochemistry. The unique data set presented here provides the opportunity to test theories about the effect of environmental variation on plant communities, biogeochemistry, and plant–soil interactions, as well as spatial ecology and biogeography.",
           url = "https://doi.org/10.6084/m9.figshare.c.3304065.v1",
           download_date = "2022-06-08", # YYYY-MM-DD
           type = "static",
           licence = "",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#

data <- read_csv(file = paste0(thisPath, "environmentaldata.csv"))
data[,34:43] <- NULL


# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
matches <- tibble(new = c(unique(paste(data$`Mangement type`, data$`Grazing intensity`, sep = "_"))),
                  old = c("Grass crops", "Temporary grazing", "Temporary grazing", "Permanent grazing", "Herbaceous associations"))


getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = c(3, 3, 2, 3, 3))


# harmonise data ----
#

temp <- data %>%
  dplyr::mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    year = `Survey year`,
    month = NA_real_,
    day = NA_integer_,
    country = Country,
    irrigated = F,
    area = 4,
    presence = T,
    externalID = NA_character_,
    externalValue = paste(data$`Mangement type`, data$`Grazing intensity`, sep = "_"),
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
