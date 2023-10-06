# script arguments ----
#
thisDataset <- "Beyrs2015"
description <- "Vegetation measurements were made on a sets of three (3) plots in each of twelve (12) stands located within the Moquah Barrens Research Natural Area in Bayfield County, Wisconsin. The plots were established and the first set of measurements were made in 1979. In 1996, all thirty-six plots were relocated and remeasured. Each of the twelve selected stands represented major forest types and age classes in the research natural area. The stands were classified into 5 vegetation types (jack pine, oak-pine, aspen-oak-birch complex, aspen, and open (pine savanna)). Sampled trees had their species and diameter at breast height (DBH) recorded. Two sets of progressively smaller plots were nested in the tree plots to count saplings, shrubs, and herbs. For saplings, species and DBH were recorded; for shrubs, species and number of individuals were recorded; for herbs, species and percent ground cover were recorded. During the springs of 2012-2014, 3 trips were taken by a U.S. Forest Service and University of Wisconsin-Madison research team to re-locate the center points associated with each stand and establish GPS coordinates. All vegetation stand locations were originally estimated within a GIS using the 1980 report by Dunn and Stearns. Only three of the twelve center points were successfully re-located. Points were not located due to loss of the wooden stakes used to mark the center points. Estimated or actual GPS locations are provided for future use."
url <- "https://doi.org/10.2737/RDS-2015-0029 https://"
licence <- ""


# reference ----
#
bib <- bibentry(
  bibtype = "misc",
  title = "Measurements from twelve permanent vegetation plots in the Moquah Barrens Research Natural Area: 1979 and 1996",
  author = as.person("BJ Jr. Beyrs [aut], Albert J. Beck [aut], David J. Rugg [aut]"),
  year = "2015",
  organization = "Forest Service Research Data Archive",
  address = "Fort Collins, CO",
  doi = "https://doi.org/10.2737/RDS-2015-0029",
  url = "https://www.fs.usda.gov/rds/archive/Catalog/RDS-2015-0029",
  type = "data set"
)

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-14"),
           type = "static",
           licence = licence,
           contact = "see corresponding authors",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Data/MoquahRNA_GPS_Stand_points.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "United States",
    x = Longitude.decimal,
    y = Latitude.decimal,
    geometry = NA,
    epsg = 4326,
    area = 1206,
    date = NA,
    # year = "1979_1980_1981_1982_1983_1984_1985_1986_1987_1988_1989_1990_1991_1992_1993_1994_1995_1996_1997_1998_1999_2000_2001_2002_2003_2004_2005_2006_2007_2008_2009_2010_2011_2012_2013_2014",
    externalID = as.character(Stand_ID),
    externalValue = "Naturally Regenerating Forest",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring") %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year)) %>%
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
