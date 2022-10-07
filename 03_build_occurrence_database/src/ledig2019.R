# script arguments ----
#
thisDataset <- "Ledig2019"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibentry(
  bibtype = "Misc",
  title = "Common garden data on dispersal adaptations and postglacial migration in pitch pine",
  Institution = "Forest Service Research Data Archive",
  address = "Fort Collins, CO",
  year = 2019,
  doi = "https://doi.org/10.2737/RDS-2015-0040",
  author = c(
    person(c("F. Thomas", "Ledig")),
    person(c("Peter E.", "Smouse")),
    person(c(" John L.", "Hom"))
  )
)

regDataset(name = thisDataset,
           description = "In October 1969 and 1970, cones were collected from Pinus rigida trees in the 30 areas in the northeastern United States and an additional area in Quebec, Canada. Seedlings from these areas (also referred to as provenances) were grown and then transplanted into six common gardens in Korea, New Jersey, Nebraska, Connecticut, and two in Massachusetts in 1974. Multiple stands were sampled from each provenance and considered replicates for the provenances. There were a total of 372 trees in 62 stands sampled. Trees were sampled at various times between 1975 and 2008, as funding and time allowed. Survival and growth were measured as standard indicators of environmental adaptation. Precocity, fecundity, seed mass, and seed number were measured as characteristics that may be associated with dispersal into and occupation of deglaciated terrain. Strobili, catkin, and cone numbers were characterized in great detail for the U.S. gardens. Snow damage, frost burn and susceptibility to various insects and diseases were noted as they are important to survival and reproduction. This data publication contains measurements from Ledig et al. (2015) summarized by seed source and plantation. Data, which varies across gardens, include measurements such as average tree height, calculated average inside bark volume, tree survival and percentage of trees bearing live cones, strobili, closed cones, sweetfern rust galls, etc. There are also some additional post-2008 measurements from the Korean garden such as length of seed wings, seed mass, and branch angle.",
           url = "https://doi.org/10.2737/RDS-2015-0040",
           download_date = "2021-01-19",
           type = "static",
           licence = NA_character_,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Data/PitchPine_CommonGarden_data2.csv"))
data <- data %>% mutate(year= c("1975_1976_1977_1978_1979_1980_1981_1982_1983_1984_1985_1986_1987_1988_1989_1990_1991_1992_1993_1994_1995_1996_1997_1998_1999_2000_2001_2002_2003_2004_2005_2006_2007_2008"))
data <- separate_rows(data, year, sep = "_")


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
temp <- data %>%
  mutate(
    fid = row_number(),
    x = `Longitude (°W)`,
    y = `Latitude (°N)`,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = "USA",
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = "Planted Forest",
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

