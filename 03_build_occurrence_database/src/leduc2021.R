# script arguments ----
#
thisDataset <- "Leduc2021"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibentry(
  title = "Precommercial thinning direct-seeded longleaf pine data on a poor site",
  bibtype = "Misc",
  year = 2021,
  doi = "https://doi.org/10.2737/RDS-2021-0048",
  institution = "Forest Service Research Data Archive",
  author = c(
    person(c("Daniel J.", "Leduc")),
    person(c("Richard E.", "Lohrey"))),
  address = "Fort Collins, CO")

regDataset(name = thisDataset,
           description = "A poor longleaf site in Rapides Parish, Louisiana was direct-seeded in 1965 and then thinned in 1974 using several different levels of thinning that ranged from thinning to 3000 trees per acre to thinning to 500 trees per acre as well as a treatment that included cutting all trees in strips. The data included in this publication contain tree measurements collected after thinning and repeated every 5 or more years until the study was closed, which resulted in the following data collection years: 1979, 1984, 1989, 2002, and 2009. Measurements include approximate age of stand and diameter at breast height for every tree in each plot. Also included for a subset of trees each year is: height to base of live crown, tree height, crown class, bark thickness in two directions, and height of trees to 4 different outside bark diameters (2, 4, 6, and 8 inches).",
           url = "https://doi.org/10.2737/RDS-2021-0048",
           download_date = "2022-01-19",
           type = "static",
           licence = NA_character_,
           contact = NA_character_,
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Data/study331.csv"))

# harmonise data ----
#
temp <- data %>%
  distinct(latitude, longitude, year, .keep_all = TRUE) %>%
  mutate(
    fid = row_number(),
    x = longitude,
    y = latitude,
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    country = "United States of America",
    irrigated = F,
    type = "areal",
    area = 1000,
    geometry = NA,
    presence = F,
    externalID = NA_character_,
    externalValue = "Planted Forest",
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
