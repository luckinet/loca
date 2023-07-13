# script arguments ----
#
thisDataset <- "biodivInternational"
description <- "Studying temporal changes in genetic diversity depends upon the availability of comparable time series data. Plant genetic resource collections provide snapshots of the diversity that existed at the time of collecting and provide a baseline against which to compare subsequent observations."
url <- "https://doi.org/10.1007/s10722-015-0231-9 https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1007_s10722-015-0231-9-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2020-10-27"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "export_1603813703.csv")) %>%
  bind_rows(read_csv(paste0(thisPath, "export_1603813923.csv"))) %>%
  bind_rows(read_csv(paste0(thisPath, "export_1603813979.csv")))


# pre-process data ----
#
temp <- data %>%
  select(-End_Date) %>%
  separate(Start_Date, sep = "/", into = c("year", "month")) %>%
  mutate(month = replace(month, is.na(month), "01"))

data <- data %>%
  select(-Start_Date) %>%
  separate(End_Date, sep = "/", into = c("year", "month")) %>%
  mutate(month = replace(month, is.na(month), "01")) %>%
  bind_rows(temp)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = tolower(Country_Name),
    x = LONGITUDEdecimal,
    y = LATITUDEdecimal,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = paste0(year, "-", month, "-01"),
    externalID = as.character(ID_SUB_MISSION),
    externalValue = Speciestype,
    irrigated = NA,
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

# newConcepts <- tibble(target = c("VEGETABLES", "Tree orchards", "Leguminous crops",
#                                  NA, "Spice crops", "Planted Forest",
#                                  "Oilseed crops", "Roots and Tubers", "Leguminous crops",
#                                  "CEREALS", NA, "Grass crops",
#                                  "Fibre crops", "Heterogeneous semi-natural areas", "Spice crops",
#                                  NA, NA, NA,
#                                  "Grass crops", "Herbaceous associations", "cocoa beans",
#                                  NA, "Other fodder crops", "FRUIT",
#                                  "Tree orchards", "SUGAR CROPS", "Medicinal crops",
#                                  NA, NA, NA),
#                       new = unique(data$Speciestype),
#                       class = c("group", "land-use", "class",
#                                 NA, "class", "land-use",
#                                 "class", "class", "class",
#                                 "group", NA, "class",
#                                 "class", "landcover", "class",
#                                 NA, NA, NA,
#                                 "class", "landcover", "commodity",
#                                 NA, "class", "group",
#                                 "class", "group", "class",
#                                 NA, NA, NA),
#                       description = NA,
#                       match = "close",
#                       certainty = 3)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
