# script arguments ----
#
thisDataset <- "Nyirambangutse2017"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "bg-14-1285-2017.bib"))

regDataset(name = thisDataset,
           description = "As a result of different types of disturbance, forests are a mixture of stands at different stages of ecological succession. Successional stage is likely to influence forest productivity and carbon storage, linking the degree of forest disturbance to the global carbon cycle and climate. Although tropical montane forests are an important part of tropical forest ecosystems (ca. 8 %, elevation >1000 m a.s.l.), there are still significant knowledge gaps regarding the carbon dynamics and stocks of these forests, and how these differ between early (ES) and late successional (LS) stages. This study examines the carbon (C) stock, relative growth rate (RGR) and net primary production (NPP) of ES and LS forest stands in an Afromontane tropical rainforest using data from inventories of quantitatively important ecosystem compartments in fifteen 0.5 ha plots in Nyungwe National Park in Rwanda.",
           url = "https://doi.org/10.5194/bg-14-1285-2017",
           download_date = "2022-01-10",
           type = "static",
           licence = "CC BY 3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Data package Nyirambangutse et al 2017.xlsx"), sheet = 1)
times <-read_xlsx(paste0(thisPath, "Data package Nyirambangutse et al 2017.xlsx"), sheet = 2)


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


# harmonise data ----
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

temp <- data %>%
  mutate(
    fid = row_number(),
    x = Long,
    y = Lat,
    luckinetID = 1125,
    year = year(Date),
    month = month(Date),
    day = day(Date),
    datasetID = thisDataset,
    country = "Rwanda",
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = NA_character_,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())

# before preparing data for storage, test that all required variables are available
assertNames(x = names(temp),
            must.include = c("datasetID", "fid", "country", "x", "y", "epsg",
                             "year", "month", "day", "irrigated",
                             "externalID", "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                             "sample_type", "collector", "purpose"))


# write output ----
#
saveDataset(object = temp, dataset = thisDataset)
