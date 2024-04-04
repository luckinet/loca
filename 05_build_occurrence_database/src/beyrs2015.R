# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.2737/RDS-2015-0029
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : forest, temperate
# ----

thisDataset <- "Beyrs2015"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

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

# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, "Data/MoquahRNA_GPS_Stand_points.csv")
data <- read_csv(file = data_path)


message(" --> normalizing data")
# temp <- data %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "areal",
#     country = "United States",
#     x = Longitude.decimal,
#     y = Latitude.decimal,
#     geometry = NA,
#     epsg = 4326,
#     area = 1206,
#     date = NA,
#     # year = "1979_1980_1981_1982_1983_1984_1985_1986_1987_1988_1989_1990_1991_1992_1993_1994_1995_1996_1997_1998_1999_2000_2001_2002_2003_2004_2005_2006_2007_2008_2009_2010_2011_2012_2013_2014",
#     externalID = as.character(Stand_ID),
#     externalValue = "Naturally Regenerating Forest",
#     irrigated = FALSE,
#     presence = FALSE,
#     sample_type = "field",
#     collector = "expert",
#     purpose = "monitoring") %>%
#   separate_rows(year, sep = "_") %>%
#   mutate(year = as.numeric(year)) %>%
#   select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
#          externalID, externalValue, irrigated, presence,
#          sample_type, collector, purpose, everything())

data <- data %>%
  mutate(obsID = row_number(), .before = 1)

other <- data %>%
  select(obsID, _INSERT)

schema_INSERT <-
  setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
            na_values = _INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "externalID", columns = _INSERT) %>%
  setIDVar(name = "open", type = "l", value = _INSERT) %>%
  setIDVar(name = "type", value = _INSERT) %>%
  setIDVar(name = "x", type = "n", columns = _INSERT) %>%
  setIDVar(name = "y", type = "n", columns = _INSERT) %>%
  setIDVar(name = "geometry", columns = _INSERT) %>%
  setIDVar(name = "date", columns = _INSERT) %>%
  setIDVar(name = "irrigated", type = "l", value = _INSERT) %>%
  setIDVar(name = "present", type = "l", value = _INSERT) %>%
  setIDVar(name = "sample_type", value = _INSERT) %>%
  setIDVar(name = "collector", value = _INSERT) %>%
  setIDVar(name = "purpose", value = _INSERT) %>%
  setObsVar(name = "concept", type = "c", columns = _INSERT)

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "Vegetation measurements were made on a sets of three (3) plots in each of twelve (12) stands located within the Moquah Barrens Research Natural Area in Bayfield County, Wisconsin. The plots were established and the first set of measurements were made in 1979. In 1996, all thirty-six plots were relocated and remeasured. Each of the twelve selected stands represented major forest types and age classes in the research natural area. The stands were classified into 5 vegetation types (jack pine, oak-pine, aspen-oak-birch complex, aspen, and open (pine savanna)). Sampled trees had their species and diameter at breast height (DBH) recorded. Two sets of progressively smaller plots were nested in the tree plots to count saplings, shrubs, and herbs. For saplings, species and DBH were recorded; for shrubs, species and number of individuals were recorded; for herbs, species and percent ground cover were recorded. During the springs of 2012-2014, 3 trips were taken by a U.S. Forest Service and University of Wisconsin-Madison research team to re-locate the center points associated with each stand and establish GPS coordinates. All vegetation stand locations were originally estimated within a GIS using the 1980 report by Dunn and Stearns. Only three of the twelve center points were successfully re-located. Points were not located due to loss of the wooden stakes used to mark the center points. Estimated or actual GPS locations are provided for future use.",
           homepage = "https://doi.org/10.2737/RDS-2015-0029",
           date = ymd("2022-01-14"),
           license = _INSERT,
           ontology = path_onto_odb)

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = path_onto_odb)

out <- list(harmonised = out, extra = other)


message(" --> writing output")
saveRDS(object = out, file = paste0(dir_occurr, "output/", thisDataset, ".rds"))
saveBIB(object = bib, file = paste0(dir_occurr, "references.bib"))

beep(sound = 10)
message("\n     ... done")
