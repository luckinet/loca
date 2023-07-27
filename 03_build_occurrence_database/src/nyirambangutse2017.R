# script arguments ----
#
thisDataset <- "Nyirambangutse2017"
description <- "As a result of different types of disturbance, forests are a mixture of stands at different stages of ecological succession. Successional stage is likely to influence forest productivity and carbon storage, linking the degree of forest disturbance to the global carbon cycle and climate. Although tropical montane forests are an important part of tropical forest ecosystems (ca. 8 %, elevation >1000 m a.s.l.), there are still significant knowledge gaps regarding the carbon dynamics and stocks of these forests, and how these differ between early (ES) and late successional (LS) stages. This study examines the carbon (C) stock, relative growth rate (RGR) and net primary production (NPP) of ES and LS forest stands in an Afromontane tropical rainforest using data from inventories of quantitatively important ecosystem compartments in fifteen 0.5 ha plots in Nyungwe National Park in Rwanda."
url <- "https://doi.org/10.5194/bg-14-1285-2017, https://doi.org/10.5061/dryad.b5b4h"
license <- "CC BY 3.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "bg-14-1285-2017.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-10"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Data package Nyirambangutse et al 2017.xlsx"), sheet = 1)
times <-read_xlsx(paste0(thisPath, "Data package Nyirambangutse et al 2017.xlsx"), sheet = 2)


# pre-process data ----
#
times <- times %>% distinct(`Date I`, `Date II`, `Plot no`)

data <- left_join(data, times, by = "Plot no")
data1 <- data %>%
  select(-`Date I`) %>%
  rename(Date = `Date II`)
temp <- data %>%
  select(- `Date II`) %>%
  rename(Date = `Date I`)
data <- bind_rows(data1, temp)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Rwanda",
    x = Long,
    y = Lat,
    geometry = NA,
    epsg = 4326,
    area = Size * 10000,
    date = ymd(Date),
    externalID = NA_character_,
    externalValue = "Forests",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring") %>%
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
