# script arguments ----
#
thisDataset <- "Beyrs2015"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

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
           description = "Vegetation measurements were made on a sets of three (3) plots in each of twelve (12) stands located within the Moquah Barrens Research Natural Area in Bayfield County, Wisconsin. The plots were established and the first set of measurements were made in 1979. In 1996, all thirty-six plots were relocated and remeasured. Each of the twelve selected stands represented major forest types and age classes in the research natural area. The stands were classified into 5 vegetation types (jack pine, oak-pine, aspen-oak-birch complex, aspen, and open (pine savanna)). Sampled trees had their species and diameter at breast height (DBH) recorded. Two sets of progressively smaller plots were nested in the tree plots to count saplings, shrubs, and herbs. For saplings, species and DBH were recorded; for shrubs, species and number of individuals were recorded; for herbs, species and percent ground cover were recorded. During the springs of 2012-2014, 3 trips were taken by a U.S. Forest Service and University of Wisconsin-Madison research team to re-locate the center points associated with each stand and establish GPS coordinates. All vegetation stand locations were originally estimated within a GIS using the 1980 report by Dunn and Stearns. Only three of the twelve center points were successfully re-located. Points were not located due to loss of the wooden stakes used to mark the center points. Estimated or actual GPS locations are provided for future use.",
           url = "https://doi.org/10.2737/RDS-2015-0029",
           download_date = "2022-01-14",
           type = "static",
           licence = "",
           contact = "see corresponding authors",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Data/MoquahRNA_GPS_Stand_points.csv"))



# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    x = Longitude.decimal,
    y = Latitude.decimal,
    year = "1979_1980_1981_1982_1983_1984_1985_1986_1987_1988_1989_1990_1991_1992_1993_1994_1995_1996_1997_1998_1999_2000_2001_2002_2003_2004_2005_2006_2007_2008_2009_2010_2011_2012_2013_2014",
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    country = "United States",
    irrigated = FALSE,
    externalID = as.character(Stand_ID),
    presence = FALSE,
    type = "areal",
    area = 1206,
    geometry = NA,
    externalValue = "Naturally Regenerating Forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year)) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")

