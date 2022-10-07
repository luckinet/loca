# script arguments ----
#
thisDataset <- "Oweis2000"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1435064592.bib"))

regDataset(name = thisDataset,
           description = "In West Asia and North Africa, shortage of water limits wheat (Triticum aestivum L.) production. Current irrigation practices aim at maximizing grain yield, but achieve lower return for the water consumed. Maximizing water use efficiency (WUE) may be more suitable in areas where water, not land, is the most limiting factor. We examined the effects of various levels of supplemental irrigation (SI) (rainfed, 1/3 SI, 2/3 SI, full SI), N (0, 5, 10, 15 g N m−2), and sowing time (Nov., Dec., Jan.) on evapotranspiration (ET) and WUE of wheat. WUE was calculated for rain (WUEr), for total water (gross: rain + irrigation) (WUEg), and for SI water only (WUESI). ET ranged from 246 to 328 mm for rainfed crops, with grain yield ranging from 130 to 270 g m−2 and total dry matter from 380 to 1370 g m−2. Irrigated crops had ET of 304 to 485 mm, with grain yield of 170 to 500 g m−2. The degree to which water supply limits grain yield was indicated by the ratio of pre- to post-anthesis ET (2.1–2.4:1). The SI treatments significantly increased WUEg: from 0.77 to 0.83 to 0.92 kg m−3 in November and December sowings for 1/3 SI and from 0.77 to 0.92 kg m−3 in November sowing for 2/3 SI. The highest WUEg and WUESI were achieved at 1/3 to 2/3 SI. WUE was substantially improved by applying 5 and 10 g N m−2, with little increase for higher rates. Delaying sowing had a negative effect on WUE for both irrigation and rainfed conditions. In this rainfed Mediterranean environment, WUE can be substantially improved by adopting deficit SI to satisfy up to 2/3 of irrigation requirements, along with early sowing and appropriate levels of N.",
           url = "https://doi.org/10.2134/agronj2000.922231x",
           download_date = "2021-10-22",
           type = "static",
           licence = NA_character_,
           contact = "see corresponding author",
           disclosed = "no",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_delim(paste0(thisPath, "Oweis2000.csv"), delim = ";", trim_ws = T)


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
chd = substr(data$lat, 3, 3)[1]
chm = substr(data$lat, 6, 6)[1]

# transform coordinates

temp <- data %>%
  mutate(y = as.numeric(char2dms(paste0(data$lat,'N'), chd = chd, chm = chm,)),
         x = as.numeric(char2dms(paste0(data$long,'E'), chd = chd, chm = chm,)))

temp <- temp %>%
  mutate(
    fid = row_number(),
    luckinetID = 546,
    datasetID = thisDataset,
    month = NA_real_,
    day = NA_real_,
    country = "Syria",
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = sown,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
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
