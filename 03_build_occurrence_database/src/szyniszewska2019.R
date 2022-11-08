# script arguments ----
#
thisDataset <- "Szyniszewska2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "9273536.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Cassava brown streak disease (CBSD) is currently the most devastating cassava disease in eastern, central and southern Africa affecting a staple crop for over 700 million people on the continent. A major outbreak of CBSD in 2004 near Kampala rapidly spread across Uganda. In the following years, similar CBSD outbreaks were noted in countries across eastern and central Africa, and now the disease poses a threat to West Africa including Nigeria - the biggest cassava producer in the world. A comprehensive dataset with 7,627 locations, annually and consistently sampled between 2004 and 2017 was collated from historic paper and electronic records stored in Uganda. The survey comprises multiple variables including data for incidence and symptom severity of CBSD and abundance of the whitefly vector (Bemisia tabaci). This dataset provides a unique basis to characterize the epidemiology and dynamics of CBSD spread in order to inform disease surveillance and management. We also describe methods used to integrate and verify extensive field records for surveys typical of emerging epidemics in subsistence crops. ",
           url = "https://doi.org/10.1038/s41597-019-0334-9",
           type = "static",
           licence = "CC-BY-4.0",
           bibliography = bib,
           download_date = "2021-12-17",
           contact = "see corresponding author",
           disclosed = "yes",
           update = TRUE)


# read dataset ----
#
data_A <- read_csv(paste0(thisPath, "DATASET_A.csv"))
data_B <- read_csv(paste0(thisPath, "DATASET_B.csv"))


# manage ontology ---
#


# harmonise data ----
#
temp <- bind_rows(data_A, data_B) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = longitude,
    y = latitude,
    geometry = NA,
    date = mdy(date),
    year = year,
    month = month(date),
    day = day(date),
    country = "Uganda",
    irrigated = NA,
    area = field_size_m2,
    presence = TRUE,
    externalID = as.character(id),
    externalValue = "cassava",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
