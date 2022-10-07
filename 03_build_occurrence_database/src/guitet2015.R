# script arguments ----
#
thisDataset <- "Guitet2015"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "10.1371_journal.pone.0138456.bib"))

regDataset(name = thisDataset,
           description = "Precise mapping of above-ground biomass (AGB) is a major challenge for the success of REDD+ processes in tropical rainforest. The usual mapping methods are based on two hypotheses: a large and long-ranged spatial autocorrelation and a strong environment influence at the regional scale. However, there are no studies of the spatial structure of AGB at the landscapes scale to support these assumptions. We studied spatial variation in AGB at various scales using two large forest inventories conducted in French Guiana. The dataset comprised 2507 plots (0.4 to 0.5 ha) of undisturbed rainforest distributed over the whole region. After checking the uncertainties of estimates obtained from these data, we used half of the dataset to develop explicit predictive models including spatial and environmental effects and tested the accuracy of the resulting maps according to their resolution using the rest of the data. Forest inventories provided accurate AGB estimates at the plot scale, for a mean of 325 Mg.ha-1. They revealed high local variability combined with a weak autocorrelation up to distances of no more than10 km. Environmental variables accounted for a minor part of spatial variation. Accuracy of the best model including spatial effects was 90 Mg.ha-1 at plot scale but coarse graining up to 2-km resolution allowed mapping AGB with accuracy lower than 50 Mg.ha-1. Whatever the resolution, no agreement was found with available pan-tropical reference maps at all resolutions. We concluded that the combined weak autocorrelation and weak environmental effect limit AGB maps accuracy in rainforest, and that a trade-off has to be found between spatial resolution and effective accuracy until adequate “wall-to-wall” remote sensing signals provide reliable AGB predictions. Waiting for this, using large forest inventories with low sampling rate (<0.5%) may be an efficient way to increase the global coverage of AGB maps with acceptable accuracy at kilometric resolution. ",
           url = "https://doi.org/10.5061/dryad.38578",
           download_date = "2022-01-25",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Guitet_etal_2016_Dryad_v1/DataAGB.xlsx"), sheet = 6)
data <- data %>%
  mutate(Xutm = as.numeric(Xutm),
         Yutm = as.numeric(Yutm))


# manage ontology ---
#

# harmonise data ----
#
# coordinates
data <- SpatialPointsDataFrame(data[, c("Xutm", "Yutm")], data, proj4string =  CRS("+init=epsg:32622")) %>%
  as.data.frame(spTransform(., CRSobj = CRS("+init=epsg:4326")))

temp <- data %>%
  mutate(
    x = Xutm.1,
    y = Yutm.1,
    geometry = NA,
    year = "1974_1975_1976_1977_1978_1979_1980_1981_1982_1983_1984_1985_1986_1987_1988_1989_1990_1991_1992_1993_1994_1995_1996_1997_1998_1999_2000_2001_2002_2003_2004_2005_2006_2007_2008_2009_2010_2011_2012",
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    country = "French Guiana",
    irrigated = F,
    externalID = ID,
    externalValue = "Undisturbed Forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    presence = FALSE,
    area = as.numeric(Area..ha.) * 10000,
    type = "point",
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year),
         fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")


