# script arguments ----
#
thisDataset <- "Sharma1990"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "0378377490900484.bib"))

regDataset(name = thisDataset,
           description = "To evaluate the critical growth stage for irrigation scheduling of wheat (Triticum aestivum L.), a field experiment was conducted at Karnal, India during the winter season of 1986–87 and 1987–88 in a sodic soil with pH 9.2, and exchangeable sodium percent (esp) 38. An increase in the irrigation frequency resulted in greater relative growth rate, rooting density, productive tiller per meter and grain yield of wheat. The three irrigations given at crown root initiation, tillering and milk stage gave significantly higher grain yield as compared to other treatment with three irrigations. The evapotranspiration (et) of the crop increased as the crop season advanced and reached its peak from 60 to 90 days after sowing (das). Maximum water use efficiency (wue) was recorded when three irrigations were given at crown root initiation, tillering and milk stage rather than at other growth stages. Most of the et occurred from the 0–15 cm soil layer and increased from lower layers (15–30, 30–60, and 60–90 cm soil depth) with an increase in the irrigation frequency, however the total amount of et from all the layers was always greater under higher irrigation frequency.",
           url = "https://doi.org/10.1016/0378-3774(90)90048-4",
           download_date = "2022-01-13",
           type = "static",
           licence = NA_character_,
           contact = NA_character_,
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
data <- read_delim(paste0(thisPath, "Sharma1990.csv"), delim = ";", trim_ws = T)


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)
luckinetID = 282,


# harmonise data ----
#
chd = substr(data$lat, 3, 3)[1]
chm = substr(data$lat, 6, 6)[1]
chs = substr(data$lat, 8, 8)[1]

# transform coordinates
temp <- data %>%
  mutate(y = as.numeric(char2dms(paste0(data$lat,'N'), chd = chd, chm = chm, chs = chs)),
         x = as.numeric(char2dms(paste0(data$long,'E'), chd = chd, chm = chm, chs = chs)))

temp <- temp %>%
  mutate(
    month = NA_real_,
    day = NA_real_,
    irrigated = NA_real_,
    country = "India",
    externalID = ID,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    datasetID = thisDataset,
    externalValue = commo,
    fid = seq_along(externalID)) %>%
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
