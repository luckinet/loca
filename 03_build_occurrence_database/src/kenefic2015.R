# script arguments ----
#
thisDataset <- "Kenefic2015"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibentry(
  bibtype = "Misc",
  title = "Overstory tree and regeneration data from the Silvicultural Effects on Composition, Structure, and Growth study at Penobscot Experimental Forest (2nd Edition)",
  year = "2015",
  doi = "https://doi.org/10.2737/RDS-2012-0008-2",
  institution = "Forest Service Research Data Archive",
  author = c(
    person(c("Laura S.", "Kenefic")),
    person(c("Nicole S.", "Rogers")),
    person(c("Joshua J.", "Puhlick")),
    person(c("Justin D.", "Waskiewicz")),
    person(c("John C.", "Brissette"))))

regDataset(name = thisDataset,
           description = "This data publication contains overstory tree measurements, regeneration data, and permanent sample plot location information collected between 1952 and 2014 under the study plan: FS-NRS-07-08-01 Study Plan: Silvicultural effects on composition, structure and growth of northern conifers in the Acadian Forest Region: Revision of the Compartment Management Study on the Penobscot Experimental Forest (see Methodology citation section). Data are available in six data sets. 1) Overstory tree measurement data include tree species, condition code (e.g., merchantability status and cause of mortality, if applicable), and diameter at breast height (dbh), 1952 to 2014. 2) Regeneration data include tree seedling species, presence, and count by height class, 1964 to 2014. 3) Spatial location data include location of a subsample of trees, 2000 to 2014. 4) Height and crown measurement data include tree height, height to crown base, and crown radii for a subsample of trees, 2000 to 2014. 5) Understory vegetation data include percent cover by substrate and non-tree vegetation categories, 2000 to 2014. 6) Permanent plot location data include the geospatial coordinates for permanent sample plots.",
           url = "https://doi.org/10.2737/RDS-2012-0008-2",
           download_date = "2022-01-22",
           type = "static",
           licence = NA_character_,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Data/PEF_CompartmentStudy_PlotLocationsData.csv"))


# manage ontology ---
#


# harmonise data ----
#
temp <- data %>%
  drop_na(LONGITUDE, LATITUDE) %>%
  st_as_sf(., coords = c("LONGITUDE","LATITUDE"), crs = st_crs("EPSG:26919")) %>%
  st_transform(., crs = "EPSG:4326")


temp <- temp %>%
  mutate(
    fid = row_number(),
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2],
    year = "1952_1953_1954_1955_1956_1957_1958_1959_1960_1961_1962_1963_1964_1965_1966_1967_1968_1969_1970_1971_1972_1973_1974_1975_1976_1977_1978_1979_1980_1981_1982_1983_1984_1985_1986_1987_1988_1989_1990_1991_1992_1993_1994_1995_1996_1997_1998_1999_2000_2001_2002_2003_2004_2005_2006_2007_2008_2009_2010_2011_2012_2013_2014",
    datasetID = thisDataset,
    country = "USA",
    irrigated = F,
    presence = F,
    area = NA_real_,
    type = "point",
    geometry = geometry,
    externalID = as.character(PLOTNUMBER),
    externalValue = "Planted Forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  mutate(
    fid = row_number(),
    date = ymd(paste0(year, "-01-01"))) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
