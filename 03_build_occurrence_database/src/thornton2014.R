# script arguments ----
#
thisDataset <- "Thornton2014"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "1264.bib"))

regDataset(name = thisDataset,
           description = "This data set provides the concentrations of soil microbial biomass carbon (C), nitrogen (N) and phosphorus (P), soil organic carbon, total nitrogen, and total phosphorus at biome and global scales. The data were compiled from a comprehensive survey of publications from the late 1970s to 2012 and include 3,422 data points from 315 papers. These data are from soil samples collected primarily at 0-15 cm depth with some from 0-30 cm. In addition, data were compiled for soil microbial biomass concentrations from soil profile samples to depths of 100 cm. Sampling site latitude and longitude were available for the majority of the samples that enabled assembling additional soil properties, site characteristics, vegetation distributions, biomes, and long-term climate data from several global sources of soil, land-cover, and climate data. These site attributes are included with the microbial biomass data. This data set contains two *.csv files of the soil microbial biomass C, N, P data. The first provides all compiled results emphasizing the full spatial extent of the data, while the second is a subset that provides only data from a series of profile samples emphasizing the vertical distribution of microbial biomass concentrations. There is a companion file, also in .csv format, of the references for the surveyed publications. A reference_number relates the data to the respective publication. The concentrations of soil microbial biomass, in combination with other soil databases, were used to estimate the global storage of soil microbial biomass C and N in 0-30 cm and 0-100 cm soil profiles. These storage estimates were combined with a spatial map of 12 major biomes (boreal forest, temperate coniferous forest, temperate broadleaf forest, tropical and subtropical forests, mixed forest, grassland, shrub, tundra, desert, natural wetland, cropland, and pasture) at 0.05-degree by 0.5-degree spatial resolution. The biome map and six estimates of C and N storage and C:N ration in soil microbial biomass are provided in a single netCDF format file. ",
           url = "https://doi.org/10.3334/ORNLDAAC/1264",
           download_date = "2022-01-07",
           type = "static",
           licence = ,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "GLOBAL_MICROBIAL_BIOMASS_C_N_P_1264/data/Soil_Microbial_Biomass_C_N_P_spatial.csv"))


# manage ontology ---
#

temp <- data %>%
  filter(row_number() != 1) %>%
  mutate(landuse = if_else(Biome == "Cropland", if_else(!is.na(Vegetation), Vegetation, Biome), Biome))

matches <- tibble(new = unique(temp$landuse),
                  old = c(""))



# harmonise data ----
#
dates <- as.data.frame(str_split_fixed(data$Date, ",", n = 2)) %>% rename(year = V1, month.day = V2)
dates.months <- as.data.frame(str_split_fixed(dates$year, " ", n = 2))
dates.months <- dates.months[dates.months == ""] <- NA

year <- str_split_fixed(dates$year, "-", n = 2)






temp <- temp %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = Longitude,
    y = Latitude,
    year = ,
    month = ,
    day = ,
    country = Country,
    irrigated = FALSE,
    area = NA_real_,
    presence = TRUE,
    externalID = NA_character_,
    externalValue = if_else(Biome == "Cropland", if_else(!is.na(Vegetation), Vegetation, Biome), Biome),
    LC1_orig = Biome,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = , # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp, type = "in-situ point") %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
