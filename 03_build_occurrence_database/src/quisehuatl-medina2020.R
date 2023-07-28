# script arguments ----
#
thisDataset <- "Quisehuatl-Medina2020"
description <- "Domestic livestock influence patterns of secondary succession across forest ecosystems. However, the effects of cattle on the regeneration of tropical dry forests (TDF) in Mexico are poorly understood, largely because it is difficult to locate forests that are not grazed by cattle or other livestock. We describe changes in forest composition and structure along a successional chronosequence of TDF stands with and without cattle (chronic grazing or exclusion from grazing for ~ 8 year). Forest stands were grouped into five successional stages, ranging from recently abandoned to mature forest, for a total of 2.7 ha of the sampled area. The absence of cattle increased woody plant (tree and shrub) density and species richness, particularly in mid-successional and mature forest stands. Species diversity and evenness were generally greater in sites where cattle were removed and cattle grazing in early successional stands reduced establishment and/or recruitment of new individuals and species. Removal of cattle from forest stands undergoing succession appears to facilitate a progressive and non-linear change of forest structure and compositional attributes associated with rapid recovery, while cattle browsing acts as a chronic disturbance factor that compromises the resilience and structural and functional integrity of the TDF in northwestern Mexico. These results are important for the conservation, management, and restoration of Neotropical dry forests."
url <- "https://doi.org/10.1111/btp.12748 https://"
licence <- ""


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1744742952.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-08"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Quisehuatl_et_al_Removal_of_cattle_accelerates_TDF_succession_Plantdata.xlsx"))


# harmonise data ----
#
temp <- data %>%
  distinct(Longitude, Latitude, Date, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Mexico",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = year(Date),
    # month = month(Date),
    # day = day(Date),
    externalID = NA_character_,
    externalValue = Cattle,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
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

# matches <- tibble(new = unique(data$Cattle),
#                   old = c("Grazing Woodland", "Naturally Regenerating Forest"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
