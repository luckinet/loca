# script arguments ----
#
thisDataset <- "Ledig2019"
description <- "In October 1969 and 1970, cones were collected from Pinus rigida trees in the 30 areas in the northeastern United States and an additional area in Quebec, Canada. Seedlings from these areas (also referred to as provenances) were grown and then transplanted into six common gardens in Korea, New Jersey, Nebraska, Connecticut, and two in Massachusetts in 1974. Multiple stands were sampled from each provenance and considered replicates for the provenances. There were a total of 372 trees in 62 stands sampled. Trees were sampled at various times between 1975 and 2008, as funding and time allowed. Survival and growth were measured as standard indicators of environmental adaptation. Precocity, fecundity, seed mass, and seed number were measured as characteristics that may be associated with dispersal into and occupation of deglaciated terrain. Strobili, catkin, and cone numbers were characterized in great detail for the U.S. gardens. Snow damage, frost burn and susceptibility to various insects and diseases were noted as they are important to survival and reproduction. This data publication contains measurements from Ledig et al. (2015) summarized by seed source and plantation. Data, which varies across gardens, include measurements such as average tree height, calculated average inside bark volume, tree survival and percentage of trees bearing live cones, strobili, closed cones, sweetfern rust galls, etc. There are also some additional post-2008 measurements from the Korean garden such as length of seed wings, seed mass, and branch angle."
url <- "https://doi.org/10.2737/RDS-2015-0040 https://"
licence <- ""


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
           description = description ,
           url = url,
           download_date = ymd("2021-01-19"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Data/PitchPine_CommonGarden_data2.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(year= "1975_1976_1977_1978_1979_1980_1981_1982_1983_1984_1985_1986_1987_1988_1989_1990_1991_1992_1993_1994_1995_1996_1997_1998_1999_2000_2001_2002_2003_2004_2005_2006_2007_2008") %>%
  separate_rows(year, sep = "_") %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "USA",
    x = `Longitude (°W)`,
    y = `Latitude (°N)`,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste0(year, "-01-01")),
    externalID = as.character(Code),
    externalValue = "Planted Forest",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = FALSE,
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
