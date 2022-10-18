# script arguments ----
#
thisDataset <- "Kebede2019"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


description <- "Lepidopteran stemborers are a serious pest of maize in Africa. While farmers have adopted cultural control practices at the field scale, it is not clear how these practices affect stemborer infestation levels and how their efficacy is influenced by landscape context. The aim of this 3-year study was to assess the effect of field and landscape factors on maize stemborer infestation levels and maize productivity. Maize infestation levels, yield and biomass production were assessed in 33 farmer fields managed according to local practices. When considering field level factors only, plant density was positively related to stemborer infestation level. During high infestation events, length of tunnelling was positively associated with planting date and negatively with the botanical diversity of hedges. However, the proportion of maize crop in the surrounding landscape was strongly and positively associated with length of tunnelling at 100, 500, 1000 and 1500m radius, and overrode field level management factors when considered together. Maize grain yield was positively associated with plant density and soil phosphorus content, and not negatively associated with the length of tunnelling. Our findings highlight the need to consider a landscape approach for stemborer pest management, but also indicate that maize is tolerant to low and medium infestation levels of stemborers. "
url <- "https://doi.org/10.7910/DVN/C9Z4I4"
license <- "CC0 1.0"

# reference ----
#
bib <- ris_reader(paste0(thisPath, "doi 10.7910_DVN_C9Z4I4.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2020-07-28",
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#

data <- read_excel(path = paste0(thisPath, "Kebede et al. 2019a.xlsx"), sheet = 3)


# harmonise data ----
#

temp <- data %>%
  mutate(externalValue = case_when(CroppingSystem == "MaizeSol" ~ "maize",
                                   CroppingSystem == "BeanIntercrop" ~ "maize_bean")) %>%
  separate_rows(externalValue, sep = "_") %>%
  st_as_sf(., coords = c("Lon", "Lat"), crs = 32637) %>%
  st_transform(., crs = 4326) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2],
    geometry = geometry,
    date = as.Date(paste(Year, data$PlantingDate, 1, sep="-"), "%Y-%U-%u"),
    country = "Ethiopia",
    irrigated = F,
    area = PlotArea * 10000,
    presence = T,
    externalID = as.character(PlotID),
    externalValue = externalValue,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
