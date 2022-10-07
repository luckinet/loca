# script arguments ----
#
thisDataset <- "Wei2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_sdata.2018.169-citation.ris"))

regDataset(name = thisDataset,
           description = "Reliable data on biomass produced by lignocellulosic bioenergy crops are essential to identify sustainable bioenergy sources. Field studies have been performed for decades on bioenergy crops, but only a small proportion of the available data is used to explore future land use scenarios including bioenergy crops. A global dataset of biomass production for key lignocellulosic bioenergy crops is thus needed to disentangle the factors impacting biomass production in different regions. Such dataset will be also useful to develop and assess bioenergy crop modelling in integrated assessment socio-economic models and global vegetation models. Here, we compiled and described a global biomass yield dataset based on field measurements. We extracted 5,088 entries of data from 257 published studies for five main lingocellulosic bioenergy crops: eucalypt, Miscanthus, poplar, switchgrass, and willow. Data are from 355 geographic sites in 31 countries around the world. We also documented the species, plantation practices, climate conditions, soil property, and managements. Our dataset can be used to identify productive bioenergy species over a large range of environments.",
           url = "https://figshare.com/collections/_/3951967, https://doi.org/10.1038/sdata.2018.169",
           download_date = "2022-01-13",
           type = "static",
           licence = NA_character_,
           contact = "wei.li@lsce.ipsl.fr",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_excel(paste0(thisPath, "Field_sites_180329_sub.xlsx"))


# harmonise data ----
#
temp <- data %>%
  rename(x = unique("Longitude"),
         y = unique("Latitude"),
         country = Country,
         irrigated = Irrigation) %>%
  mutate(
    month = NA_real_,
    day = NA_real_,
    year = Year,
    externalID = row_number(),
    externalValue = Crop_type,
    externalLC = NA_character_,
    sample_type = "expert, field",
    datasetID = thisDataset,
    fid = externalID,
    precision = 1 / 10 ^ max(c(nchar(str_split(x, "[.]")[[1]][2]),
                               nchar(str_split(y, "[.]")[[1]][2]))))

# extra tibble to parse Crop with Luckinet ID
allConcepts <- readRDS(file = paste0(dataDir, "run/global_0.1.0/tables/ids_all_global_0.1.0.rds"))

match <- data %>%
  select(Crop_type) %>%
  distinct() %>%
  mutate(term = tolower(Crop_type)) %>%
  left_join(allConcepts, by = c("term"))

new <- match %>%
  filter(is.na(luckinetID)) %>%
  mutate(luckinetID = c())

tobinnambur: 1861
grasswheat: 282

match <- match %>%
  filter(!is.na(luckinetID)) %>%
  bind_rows(new) %>%
  select(term, luckinetID)

## join tibble
data <- temp %>%
  mutate(term = tolower(Crop)) %>%
  left_join(., match, by = "term")


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
