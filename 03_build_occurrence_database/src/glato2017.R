# script arguments ----
#
thisDataset <- "Glato2017"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "5045563.ris"))

regDataset(name = thisDataset,
           description = "Sub-Saharan agriculture has been identified as vulnerable to ongoing climate change. Adaptation of agriculture has been suggested as a way to maintain productivity. Better knowledge of intra-specific diversity of varieties is prerequisites for the successful management of such adaptation. Among crops, root and tubers play important roles in food security and economic growth for the most vulnerable populations in Africa. Here, we focus on the sweet potato. The Sweet potato (Ipomoea batatas) was domesticated in Central and South America and was later introduced into Africa and is now cultivated throughout tropical Africa. We evaluated its diversity in West Africa by sampling a region extending from the coastal area of Togo to the northern Sahelian region of Senegal that represents a range of climatic conditions. Using 12 microsatellite markers, we evaluated 132 varieties along this gradient. Phenotypic data from field trials conducted in three seasons was also obtained. Genetic diversity in West Africa was found to be 18% lower than in America. Genetic diversity in West Africa is structured into five groups, with some groups found in very specific climatic areas, e.g. under a tropical humid climate, or under a Sahelian climate. We also observed genetic groups that occur in a wider range of climates. The genetic groups were also associated with morphological differentiation, mainly the shape of the leaves and the color of the stem or root. This particular structure of diversity along a climatic gradient with association to phenotypic variability can be used for conservation strategies. If such structure is proved to be associated with specific climatic adaptation, it will also allow developing strategies to adapt agriculture to ongoing climate variation in West Africa.",
           url = "https://doi.org/10.1371/journal.pone.0177697",
           download_date = "2022-06-02",
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)
# read dataset ----
#

data <- read_excel(path = paste0(thisPath, "Extraction_data.xlsx"))


# harmonise data ----
#

chd = substr(data$Latitude, 4, 4)[1]
chm = substr(data$Latitude, 7, 7)[1]
chs = substr(data$Latitude, 12, 12)[1]

data$Latitude <- str_remove(string = data$Latitude, "[A-Z]")
data$Longitude <- str_remove(string = data$Longitude, "[A-Z]")

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x =  as.numeric(char2dms(paste0(data$Longitude, 'W'), chd = chd, chm = chm, chs = chs)),
    y = as.numeric(char2dms(paste0(data$Latitude, 'N'), chd = chd, chm = chm, chs = chs)),
    geometry = NA,
    year = case_when(Country == "SENEGAL" ~ 2014,
                     Country == "TOGO" ~ 2012),
    month = NA_real_,
    day = NA_integer_,
    country = case_when(Country == "SENEGAL" ~ "Senegal",
                        Country == "TOGO" ~ "Togo"),
    irrigated = F,
    area = NA_real_,
    presence = F,
    externalID = NA_character_,
    externalValue = "sweet potato",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type ="field" ,
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
