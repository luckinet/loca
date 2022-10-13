# script arguments ----
#
thisDataset <- "Ledo2019"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "A global, unified dataset on Soil Organic Carbon (SOC) changes under perennial crops has not existed till now. We present a global, harmonised database on SOC change resulting from perennial crop cultivation. It contains information about 1605 paired-comparison empirical values (some of which are aggregated data) from 180 different peer-reviewed studies, 709 sites, on 58 different perennial crop types, from 32 countries in temperate, tropical and boreal areas; including species used for food, bioenergy and bio-products. The database also contains information on climate, soil characteristics, management and topography. This is the first such global compilation and will act as a baseline for SOC changes in perennial crops. It will be key to supporting global modelling of land use and carbon cycle feedbacks, and supporting agricultural policy development."
url <- "https://doi.org/10.6084/m9.figshare.7637210.v2, https://doi.org/10.1038/s41597-019-0062-1"
license <- "CC BY 4.0"

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "7637210.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2022-01-19",
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xls(path = paste0(thisPath, "SOC perennials DATABASE.xls"), sheet = 5, skip = 1)

# manage ontology ---
#

onto <- read_csv2(paste0(thisPath, "ontology_ledo2019.csv"))
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



luckiOnto <- new_concept(new = c("jatropha seed", "bahiagrass", "signalgrass", "annatto", "annona fruits", "acerola fruit", "lychee fruit"),
                         broader = c("_01", "_0501", "_0501", "_1402", "_06", "_06", "_06"),
                         class = "commodity",
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
  distinct(Longitud, Latitud, CROP_current, year_measure, .keep_all = T) %>%
  separate_rows(CROP_current, sep = "-") %>%
  mutate(
    fid = row_number(),
    x = Longitud,
    y = Latitud,
    geometry = NA,
    type = "point",
    area = NA_real_,
    presence = T,
    date = ymd(paste(year_measure, "-01-01")),
    datasetID = thisDataset,
    irrigated = NA_character_,
    externalID = as.character(ID),
    country = country,
    externalValue = CROP_current,
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
