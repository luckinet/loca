# script arguments ----
#
thisDataset <- "Feng2022"
description <- "Multispecies tree planting has long been applied in forestry and landscape restoration in the hope of providing better timber production and ecosystem services; however, a systematic assessment of its effectiveness is lacking. We compiled a global dataset of matched single-species and multispecies plantations to evaluate the impact of multispecies planting on stand growth. Average tree height, diameter at breast height, and aboveground biomass were 5.4, 6.8, and 25.5% higher, respectively, in multispecies stands compared with single-species stands. These positive effects were mainly the result of interspecific complementarity and were modulated by differences in leaf morphology and leaf life span, stand age, planting density, and temperature. Our results have implications for designing afforestation and reforestation strategies and bridging experimental studies of biodiversity–ecosystem functioning relationships with real-world practices."
url <- "https://doi.org/10.1126/science.abm6363 https://"
licence <- ""


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "csp_376_.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-05-31"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


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


# harmonise data ----
#
temp <- data %>%
  distinct(Year, Lat, Lon, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = Lon,
    y = Lat,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste0(Year,"-01-01")),
    externalID = NA_character_,
    externalValue = "Woody plantation",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "meta study",
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
