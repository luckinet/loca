# script arguments ----
#
thisDataset <- "Fyfe2015"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "PBM_results.ris"))

regDataset(name = thisDataset,
           description = "In supplement to: Fyfe, RM et al. (2015): From forest to farmland: pollen-inferred land cover change across Europe using the pseudobiomization approach. Global Change Biology, 21(3), 1197-1212, https://doi.org/10.1111/gcb.12776",
           url = "https://doi.org/10.1594/PANGAEA.853942",
           download_date = "2022-01-21",
           type = "static",
           licence = "CC-BY-3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_tsv(paste0(thisPath, "PBM_results.tab"), skip = 1006)


# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    x = ,
    y = ,
    year = ,
    month = ,
    day = ,
    datasetID = thisDataset,
    country = NA_character_,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = ,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "", # "field", "visual interpretation" or "experience"
    collector = "", # "expert", "citizen scientist" or "student"
    purpose = "", # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%   # see https://epsg.io for other codes
  select(fid, datasetID, x, y, epsg, country, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())

assertNames(x = names(temp),
            must.include = c("fid", "datasetID", "x", "y", "epsg", "country",
                             "year", "month", "day", "irrigated", "externalID",
                             "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                             "sample_type", "collector", "purpose"))


# write output ----
#
saveDataset(object = temp, dataset = thisDataset)


