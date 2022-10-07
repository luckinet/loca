# script arguments ----
#
thisDataset <- "Jung2016"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "5241250.bib"))

regDataset(name = thisDataset,
           description = "Land-use change is the single biggest driver of biodiversity loss in the tropics. Biodiversity models can be useful tools to inform policymakers and conservationists of the likely response of species to anthropogenic pressures, including land-use change. However, such models generalize biodiversity responses across wide areas and many taxa, potentially missing important characteristics of particular sites or clades. Comparisons of biodiversity models with independently collected field data can help us understand the local factors that mediate broad-scale responses. We collected independent bird occurrence and abundance data along two elevational transects in Mount Kilimanjaro, Tanzania and the Taita Hills, Kenya. We estimated the local response to land use and compared our estimates with modelled local responses based on a large database of many different taxa across Africa. To identify the local factors mediating responses to land use, we compared environmental and species assemblage information between sites in the independent and African-wide datasets. Bird species richness and abundance responses to land use in the independent data followed similar trends as suggested by the African-wide biodiversity model, however the land-use classification was too coarse to capture fully the variability introduced by local agricultural management practices. A comparison of assemblage characteristics showed that the sites on Kilimanjaro and the Taita Hills had higher proportions of forest specialists in croplands compared to the Africa-wide average. Local human population density, forest cover and vegetation greenness also differed significantly between the independent and Africa-wide datasets. Biodiversity models including those variables performed better, particularly in croplands, but still could not accurately predict the magnitude of local species responses to most land uses, probably because local features of the land management are still missed. Overall, our study demonstrates that local factors mediate biodiversity responses to land use and cautions against applying biodiversity models to local contexts without prior knowledge of which factors are locally relevant.",
           url = "https://doi.org/10.6084/m9.figshare.5241250.v1",
           download_date = "2022-05-30",
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#

data <- read_excel(paste0(thisPath, "SiteData.xls"))



# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
 x <- unique(paste(data$Landuse, data$LU_Info, sep = "_"))
 x1 <- as.data.frame(x)
 x1 <- x1 %>% separate_rows(x, sep =  ",")

 #write_csv(as.data.frame(x1), paste0(thisPath, "Jung_ontology.csv"))

matches <- read_csv(file = paste0(thisPath, "Jung_ontology.csv"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close", # in most cases that should be "close", see ?newMapping
             source = thisDataset,
             certainty = 3) # value from 1:3


# harmonise data ----
#
# carry out optional corrections and validations ...
temp <- data %>% select(-DateFirst) %>%
  separate(DateSecond, into = c("day", "month"))
temp1 <- data %>% select(-DateSecond) %>%
  separate(DateFirst, into = c("day", "month"))

temp <- bind_rows(temp, temp1)
temp$month <- str_remove(temp$month, "0")

temp <- temp %>%
    mutate(
    datasetID = thisDataset,
    type = "point",
    x = Long,
    y = Lat,
    geometry = NA,
    year = 2014,
    month = as.numeric(month),
    day = as.integer(day),
    country = NA_character_,
    irrigated = F,
    area = F,
    presence = T,
    externalID = NA_character_,
    externalValue = paste(Landuse, LU_Info, sep = "_"),
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(externalValue, sep =",") %>%
  mutate(fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
