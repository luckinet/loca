# script arguments ----
#
thisDataset <- "Schooley2005"
description <- "This is data for perennial plant vegetation canopy cover measured from all SMES study plots, fall 1995. The purpose of this data is to provide ground-truth data for comparison with low-level aerial photographs of each study plot. Three, 29 meter lines were measured along three of six rows of the permanent vegetation measurement quadrats. Each line was measured at 10cm resolution for intercepts of perennial plant live canopy cover, and for bare ground. 10cm resolution is comparable to the resolution of the aerial photos. All plants were identified to the species level. These line-intercept measurements are taken once every ten years, at the same time that low-level aerial photographs are taken. These data will be compared to both decadal air photos, and annual measures of vegetation from one-meter2 quadrats on each plot to provide information on vegetation change over time relative to the various animal exclosure treatments."
url <- "https://doi.org/ https://jornada.nmsu.edu/content/smes-vegetation-line-intercept-data"
licence <- ""


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
           description = description,
           url = url,
           download_date = ymd("2022-06-01"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "JornadaStudy_086_smes_plant_cover_line_data.csv"), skip = 26)


# harmonise data ----
#
temp <- data %>%
  distinct(POINT_X, POINT_Y, date, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "United States of America",
    x = POINT_X,
    y = POINT_Y,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = year(mdy(date)),
    # month = month(mdy(date)),
    # day = day(mdy(date)),
    externalID = NA_character_,
    externalValue = site,
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
