# script arguments ----
#
thisDataset <- "Wood2016"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "This data package includes felled tree biomass by tree component for four hardwood species of the central Appalachians sampled on the Fernow Experimental Forest (FEF), West Virginia. A total of 88 trees were sampled from plots within two different watersheds on the FEF. Hardwood species sampled include Acer rubrum, Betula lenta, Liriodendron tulipifera, and Prunus serotina, all of which were measured in the summer of 1991 and 1992. Data include tree height, diameter, as well as green and dry weight of tree stem, top, small branches, large branches, and leaves."
url <- "https://doi.org/10.2737/RDS-2016-0016"
license <- ""

# reference ----
#
bib <- ris_reader(paste0(thisPath, "Wood2016_Citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           type = "study",
           licence = licence,
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "felled_tree_biomass.csv"))
loc <- read_csv(paste0(thisPath, "watershed_plot_locations.csv"))
colnames(loc) <- tolower(colnames(loc))

data <- left_join(data, loc, by = "plot")


# harmonise data ----
#
# transform coordinates
temp <- st_as_sf(data, coords= c("easting nad83 zone 17n (meters)", "northing nad83 zone 17n (meters)"), crs= st_crs(32167)) %>%
  st_transform(., crs = 4326)

temp <- temp %>%
  distinct(year, geometry, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2],
    date = ymd(paste0(year, "-01-01")),
    presence = F,
    type = "point",
    area = NA,
    geometry = geometry,
    country = NA_character_,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = "Naturally Regenerating Forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study" ,
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
