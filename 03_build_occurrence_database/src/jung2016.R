# script arguments ----
#
thisDataset <- "Jung2016"
description <- "Land-use change is the single biggest driver of biodiversity loss in the tropics. Biodiversity models can be useful tools to inform policymakers and conservationists of the likely response of species to anthropogenic pressures, including land-use change. However, such models generalize biodiversity responses across wide areas and many taxa, potentially missing important characteristics of particular sites or clades. Comparisons of biodiversity models with independently collected field data can help us understand the local factors that mediate broad-scale responses. We collected independent bird occurrence and abundance data along two elevational transects in Mount Kilimanjaro, Tanzania and the Taita Hills, Kenya. We estimated the local response to land use and compared our estimates with modelled local responses based on a large database of many different taxa across Africa. To identify the local factors mediating responses to land use, we compared environmental and species assemblage information between sites in the independent and African-wide datasets. Bird species richness and abundance responses to land use in the independent data followed similar trends as suggested by the African-wide biodiversity model, however the land-use classification was too coarse to capture fully the variability introduced by local agricultural management practices. A comparison of assemblage characteristics showed that the sites on Kilimanjaro and the Taita Hills had higher proportions of forest specialists in croplands compared to the Africa-wide average. Local human population density, forest cover and vegetation greenness also differed significantly between the independent and Africa-wide datasets. Biodiversity models including those variables performed better, particularly in croplands, but still could not accurately predict the magnitude of local species responses to most land uses, probably because local features of the land management are still missed. Overall, our study demonstrates that local factors mediate biodiversity responses to land use and cautions against applying biodiversity models to local contexts without prior knowledge of which factors are locally relevant."
url <- "https://doi.org/10.6084/m9.figshare.5241250.v1 https://"
licence <- "CC BY 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "5241250.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-05-30"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "SiteData.xls"))


# pre-process data ----
#
x <- unique(paste(data$Landuse, data$LU_Info, sep = "_"))
x1 <- as.data.frame(x)
x1 <- x1 %>%
  separate_rows(x, sep =  ",")

temp <- data %>% select(-DateFirst) %>%
  separate(DateSecond, into = c("day", "month"))
temp1 <- data %>% select(-DateSecond) %>%
  separate(DateFirst, into = c("day", "month"))

data <- bind_rows(temp, temp1)
data$month <- str_remove(temp$month, "0")


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = Long,
    y = Lat,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = 2014,
    # month = as.numeric(month),
    # day = as.integer(day),
    externalID = NA_character_,
    externalValue = paste(Landuse, LU_Info, sep = "_"),
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(externalValue, sep =",") %>%
  mutate(fid = row_number()) %>%
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

# matches <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Jung_ontology.csv"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
