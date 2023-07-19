# script arguments ----
#
thisDataset <- "Glato2017"
description <- "Sub-Saharan agriculture has been identified as vulnerable to ongoing climate change. Adaptation of agriculture has been suggested as a way to maintain productivity. Better knowledge of intra-specific diversity of varieties is prerequisites for the successful management of such adaptation. Among crops, root and tubers play important roles in food security and economic growth for the most vulnerable populations in Africa. Here, we focus on the sweet potato. The Sweet potato (Ipomoea batatas) was domesticated in Central and South America and was later introduced into Africa and is now cultivated throughout tropical Africa. We evaluated its diversity in West Africa by sampling a region extending from the coastal area of Togo to the northern Sahelian region of Senegal that represents a range of climatic conditions. Using 12 microsatellite markers, we evaluated 132 varieties along this gradient. Phenotypic data from field trials conducted in three seasons was also obtained. Genetic diversity in West Africa was found to be 18% lower than in America. Genetic diversity in West Africa is structured into five groups, with some groups found in very specific climatic areas, e.g. under a tropical humid climate, or under a Sahelian climate. We also observed genetic groups that occur in a wider range of climates. The genetic groups were also associated with morphological differentiation, mainly the shape of the leaves and the color of the stem or root. This particular structure of diversity along a climatic gradient with association to phenotypic variability can be used for conservation strategies. If such structure is proved to be associated with specific climatic adaptation, it will also allow developing strategies to adapt agriculture to ongoing climate variation in West Africa."
url <- "https://doi.org/10.1371/journal.pone.0177697 https://"
licence <- "CC BY 4.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "5045563.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-06-02"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(path = paste0(thisPath, "Extraction_data.xlsx"))


# pre-process data ----
#
chd = substr(data$Latitude, 4, 4)[1]
chm = substr(data$Latitude, 7, 7)[1]
chs = substr(data$Latitude, 12, 12)[1]

data$Latitude <- str_remove(string = data$Latitude, "[A-Z]")
data$Longitude <- str_remove(string = data$Longitude, "[A-Z]")


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = case_when(Country == "SENEGAL" ~ "Senegal",
                        Country == "TOGO" ~ "Togo"),
    x =  as.numeric(char2dms(paste0(data$Longitude, 'W'), chd = chd, chm = chm, chs = chs)),
    y = as.numeric(char2dms(paste0(data$Latitude, 'N'), chd = chd, chm = chm, chs = chs)),
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = case_when(Country == "SENEGAL" ~ 2014,
    #                  Country == "TOGO" ~ 2012),
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = "sweet potato",
    irrigated = FALSE,
    presence = FALSE,
    sample_type ="field" ,
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
