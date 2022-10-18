# script arguments ----
#
thisDataset <- "Caughlin2016"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- ""
url <- "https://doi.org/10.5061/dryad.t6md2, https://doi.org/10.1002/eap.1436"
license <- ""


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1939558226.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2022-06-04",
           type = "static",
           licence = license,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#

data <- st_read(dsn = paste0(thisPath))


# harmonise data ----
#
x <- data %>%
  select(Name,geometry) %>%
  as_tibble()
temp <- data %>%
  st_make_valid() %>%
  mutate(area = st_area(.)) %>%
  st_centroid() %>%
  mutate(x = st_coordinates(.)[,1],
         y = st_coordinates(.)[,2]) %>%
  left_join(., x, by = "Name")


temp <- temp %>%
  mutate(date = "01-01-2008_01-01-2009_01-01-2010_01-01-2011_01-01-2012_01-12-2013_01-12-2014") %>%
  separate_rows(date, sep = "_") %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = x,
    y = y,
    geometry = geometry.y,
    date = dmy(date),
    country = "Panama",
    irrigated = F,
    area = as.numeric(area),
    presence = F,
    externalID = as.character(Name),
    externalValue = "Forests",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
