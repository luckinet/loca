# script arguments ----
#
thisDataset <- "Wei2018"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "Reliable data on biomass produced by lignocellulosic bioenergy crops are essential to identify sustainable bioenergy sources. Field studies have been performed for decades on bioenergy crops, but only a small proportion of the available data is used to explore future land use scenarios including bioenergy crops. A global dataset of biomass production for key lignocellulosic bioenergy crops is thus needed to disentangle the factors impacting biomass production in different regions. Such dataset will be also useful to develop and assess bioenergy crop modelling in integrated assessment socio-economic models and global vegetation models. Here, we compiled and described a global biomass yield dataset based on field measurements. We extracted 5,088 entries of data from 257 published studies for five main lingocellulosic bioenergy crops: eucalypt, Miscanthus, poplar, switchgrass, and willow. Data are from 355 geographic sites in 31 countries around the world. We also documented the species, plantation practices, climate conditions, soil property, and managements. Our dataset can be used to identify productive bioenergy species over a large range of environments."
url <- "https://figshare.com/collections/_/3951967, https://doi.org/10.1038/sdata.2018.169"
license <- ""

# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_sdata.2018.169-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2022-01-13",
           type = "static",
           licence = licence,
           contact = "wei.li@lsce.ipsl.fr",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ---
#
data <- read_excel(paste0(thisPath, "Field_sites_180329_sub.xlsx"))

# preprocess ---
#
prep <- data %>% separate_rows(Crop_type, sep = "[+]")


# manage ontology ---
#
onto <- read_csv(paste0(thisPath, "ontology_Wei2018.csv"))

newConcepts <- tibble(target = onto$target,
                      new = onto$new,
                      class = onto$class,
                      description = NA,
                      match = "close",
                      certainty = onto$certainty)

luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        date = Sys.Date(),
                        homepage = url,
                        license = license,
                        ontology = luckiOnto)


luckiOnto <- new_concept(new = c("big cordgrass", "paraserianthes", "facaltaria",
                                 "dalbergia", "gliricidia", "pinus",
                                 "casuarina", "sand reed", "big bluestem",
                                 "indian grass", "arundo", "topinambur",
                                 "cynara", "brome grass", "festuca",
                                 "eastern gamagrass", "flat pea", "sudan grass",
                                 "alder", "napier grass", "guinea grass",
                                 "bermuda grass", "flaccid grass", "Virginia fanpetals",
                                 "panic grass", "saccharum", "cocksfoot grass",
                                 "milkvetch"),
                         broader = c("_0101", "_0301", "_0102",
                                     "_0102", "_0102", "_0102",
                                     "_0102", "_0101", "_0101",
                                     "_0101", "_0101", "_1301",
                                     "_0101", "_0101", "_0101",
                                     "_0101", "_0101", "_0101",
                                     "_0102", "_0101", "_0101",
                                     "_0101", "_0101", "_0101",
                                     "_0101", "_0101", "_0101",
                                     "_0101"),
                         class = c("commodity"),
                         description = NA,
                          ontology = luckiOnto)

luckiOnto <- new_mapping(new = newConcepts$new,
                         target = get_concept(x = newConcepts %>% select(label = target), ontology = luckiOnto),
                         source = thisDataset,
                         description = newConcepts$description,
                         match = newConcepts$match,
                         certainty = newConcepts$certainty,
                         ontology = luckiOnto, matchDir = paste0(occurrenceDBDir, "01_concepts/"))


# harmonise data ----
#

temp <- data %>%
  separate_rows(Crop_type, sep = "[+]") %>%
  distinct(Latitude, Longitude, Crop_type, Harvest_year) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    date = ymd(paste(Harvest_year, "-01-01")),
    country = NA_character_,
    irrigated = NA,
    area = NA_real_,
    presence = T,
    externalID = NA_character_,
    externalValue = Crop_type,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "meta study",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  drop_na(date) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")

