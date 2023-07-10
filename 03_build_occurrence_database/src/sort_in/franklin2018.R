# script arguments ----
#
thisDataset <- "Franklin2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "franklin2018.bib"))

regDataset(name = thisDataset,
           description = "Geographical Ecology of Dry Forest Tree Communities in the West Indies",
           url = "https://doi.org/10.6086/D1ZH32",
           download_date = "2022-01-21",
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "WestIndiesSDTF_environment_572sites_with_descriptions.csv"), skip = 28)


# harmonise data ----
#
a <- seq(from = 1969, to = 2016, by = 1) # time period of study

temp <- data %>%
  distinct(lat, long, .keep_all = TRUE) %>%
  mutate(
    x = long,
    y = lat,
    year = paste(a, collapse = "_"),
    country = case_when(TDF_raw.country == "Bahamas" ~ "Commonwealth of The Bahamas",
                                  TDF_raw.country == "Cuba" ~ "Cuba",
                                  TDF_raw.country == "Florida" ~ "United States",
                                  TDF_raw.country == "Guadeloupe" ~ "France",
                                  TDF_raw.country == "hispaniola" | TDF_raw.country ==  "Hispaniola" ~ "Dominican Republic",
                                  TDF_raw.country == "Jamaica" ~ "Jamaica",
                                  TDF_raw.country == "Martinique" ~ "France",
                                  TDF_raw.country == "mona" | TDF_raw.country == "puertorico" ~ "Puerto Rico",
                                  TDF_raw.country == "Providencia" ~ "Colombia",
                                  TDF_raw.country == "stlucia" ~ "Saint Lucia",
                                  TDF_raw.country == "usvi" ~ "United States"),
    datasetID = thisDataset,
    irrigated = NA_character_,
    externalID = TDF_raw.plot_id,
    externalValue = "Forests",
    presence = FALSE,
    area = NA_real_,
    type = "point",
    geometry = NA,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  mutate(
    fid = row_number(),
    date = ymd(paste0(year, "-01-01"))) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")

