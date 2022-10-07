# script arguments ----
#
thisDataset <- "Feng2022"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "csp_376_.bib"))

regDataset(name = thisDataset,
           description = "Multispecies tree planting has long been applied in forestry and landscape restoration in the hope of providing better timber production and ecosystem services; however, a systematic assessment of its effectiveness is lacking. We compiled a global dataset of matched single-species and multispecies plantations to evaluate the impact of multispecies planting on stand growth. Average tree height, diameter at breast height, and aboveground biomass were 5.4, 6.8, and 25.5% higher, respectively, in multispecies stands compared with single-species stands. These positive effects were mainly the result of interspecific complementarity and were modulated by differences in leaf morphology and leaf life span, stand age, planting density, and temperature. Our results have implications for designing afforestation and reforestation strategies and bridging experimental studies of biodiversity–ecosystem functioning relationships with real-world practices.",
           url = "https://doi.org/10.1126/science.abm6363",
           download_date = "2022-05-31",
           type = "static",
           licence = "",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
sheet1 <- excel_sheets(paste0(thisPath, "science.abm6363_data_s1_and_s2/science.abm6363_data_s1.xlsx"))[3:5]
data1 <- lapply(setNames(sheet1, sheet1),
                    function(x) read_excel(paste0(thisPath, "science.abm6363_data_s1_and_s2/science.abm6363_data_s1.xlsx"), sheet=x))
data1 <- bind_rows(data1, .id="Sheet")

sheet2 <- excel_sheets(paste0(thisPath, "science.abm6363_data_s1_and_s2/science.abm6363_data_s2.xlsx"))[3:5]
data2 <- lapply(setNames(sheet2, sheet2),
                function(x) read_excel(paste0(thisPath, "science.abm6363_data_s1_and_s2/science.abm6363_data_s2.xlsx"), sheet=x))
data2 <- bind_rows(data2, .id="Sheet") %>%
  mutate_if(is.POSIXct, as.numeric)

data <- bind_rows(data1, data2)

# manage ontology ---
#
newConcepts <- tibble(label = ,
                      class = ,
                      description = ,
                      match = ,
                      certainty = )

luckiOnto <- new_source(name = thisDataset,
                        description = "",
                        homepage = "",
                        license = "",
                        ontology = luckiOnto)

# in case new harmonised concepts appear here (avoid if possible)
# luckiOnto <- new_concept(new = , broader = , class = , description = ,
#                          ontology = luckiOnto)

luckiOnto <- new_mapping(new = newConcepts$new,
                         target = newConcepts %>% select(class, desription, ...),
                         source = thisDataset,
                         description = newConcepts$description,
                         match = newConcepts$match,
                         certainty = newConcepts$certainty,
                         ontology = luckiOnto, matchDir = paste0(DBDir, "concepts/"))


# harmonise data ----
#

temp <- data %>%
  distinct(Year, Lat, Lon, Species, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = Lon,
    y = Lat,
    geometry = NA,
    date = ymd(paste0(Year,"-01-01")),
    country = NA_character_,
    irrigated = F,
    area = NA_real_,
    presence = T,
    externalID = NA_character_,
    externalValue = , # make ontology with column species
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "meta study",
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
