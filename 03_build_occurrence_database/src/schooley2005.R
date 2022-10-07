# script arguments ----
#
thisDataset <- "Schooley2005"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bib <- bibentry(
  bibtype = "Misc",
  title = "SMES Vegetation Line Intercept Data",
  year = "2015",
  url = "https://jornada.nmsu.edu/content/smes-vegetation-line-intercept-data",
  institution = "Jornada",
  author = c(person(c("Robert L.", "Schooley"))))

regDataset(name = thisDataset,
           description = "This is data for perennial plant vegetation canopy cover measured from all SMES study plots, fall 1995. The purpose of this data is to provide ground-truth data for comparison with low-level aerial photographs of each study plot. Three, 29 meter lines were measured along three of six rows of the permanent vegetation measurement quadrats. Each line was measured at 10cm resolution for intercepts of perennial plant live canopy cover, and for bare ground. 10cm resolution is comparable to the resolution of the aerial photos. All plants were identified to the species level. These line-intercept measurements are taken once every ten years, at the same time that low-level aerial photographs are taken. These data will be compared to both decadal air photos, and annual measures of vegetation from one-meter2 quadrats on each plot to provide information on vegetation change over time relative to the various animal exclosure treatments.",
           url = "https://jornada.nmsu.edu/content/smes-vegetation-line-intercept-data",
           download_date = "2022-06-01",
           type = "static",
           licence = "",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#

data <- read_csv(file = paste0(thisPath, "JornadaStudy_086_smes_plant_cover_line_data.csv"), skip = 26)


# manage ontology ---
#
matches <- tibble(new = c(unique(data$site)),
                  old = c("Herbaceous associations", "Shrubland"))

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
  distinct(POINT_X, POINT_Y, date, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = POINT_X,
    y = POINT_Y,
    geometry = NA,
    year = year(mdy(date)),
    month = month(mdy(date)),
    day = day(mdy(date)),
    country = "United States of America",
    irrigated = F,
    area = NA_real_,
    presence = T,
    externalID = NA_character_,
    externalValue = site,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
