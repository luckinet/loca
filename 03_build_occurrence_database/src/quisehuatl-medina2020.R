# script arguments ----
#
thisDataset <- "Quisehuatl-Medina2020"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1744742952.bib"))

regDataset(name = thisDataset,
           description = "Domestic livestock influence patterns of secondary succession across forest ecosystems. However, the effects of cattle on the regeneration of tropical dry forests (TDF) in Mexico are poorly understood, largely because it is difficult to locate forests that are not grazed by cattle or other livestock. We describe changes in forest composition and structure along a successional chronosequence of TDF stands with and without cattle (chronic grazing or exclusion from grazing for ~ 8 year). Forest stands were grouped into five successional stages, ranging from recently abandoned to mature forest, for a total of 2.7 ha of the sampled area. The absence of cattle increased woody plant (tree and shrub) density and species richness, particularly in mid-successional and mature forest stands. Species diversity and evenness were generally greater in sites where cattle were removed and cattle grazing in early successional stands reduced establishment and/or recruitment of new individuals and species. Removal of cattle from forest stands undergoing succession appears to facilitate a progressive and non-linear change of forest structure and compositional attributes associated with rapid recovery, while cattle browsing acts as a chronic disturbance factor that compromises the resilience and structural and functional integrity of the TDF in northwestern Mexico. These results are important for the conservation, management, and restoration of Neotropical dry forests.",
           url = "https://doi.org/10.1111/btp.12748",
           download_date = "2022-01-08",
           type = "static",
           licence = NA,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Quisehuatl_et_al_Removal_of_cattle_accelerates_TDF_succession_Plantdata.xlsx"))


# manage ontology ---
#
matches <- tibble(new = unique(data$Cattle),
                  old = c("Grazing Woodland", "Naturally Regenerating Forest"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#
temp <- data %>%
  distinct(Longitude, Latitude, Date, .keep_all = TRUE) %>%
  mutate(
    fid = row_number(),
    geometry = NA,
    type = "point",
    x = Longitude,
    y = Latitude,
    year = year(Date),
    month = month(Date),
    day = day(Date),
    area = NA_real_,
    datasetID = thisDataset,
    country = "Mexico",
    irrigated = F,
    presence = TRUE,
    externalID = NA_character_,
    externalValue = Cattle,
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

