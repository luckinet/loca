# script arguments ----
#
thisDataset <- "Wood2016"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "Wood2016_Citation.ris")) #.ris file needs check

regDataset(name = thisDataset,
           description = "This data package includes felled tree biomass by tree component for four hardwood species of the central Appalachians sampled on the Fernow Experimental Forest (FEF), West Virginia. A total of 88 trees were sampled from plots within two different watersheds on the FEF. Hardwood species sampled include Acer rubrum, Betula lenta, Liriodendron tulipifera, and Prunus serotina, all of which were measured in the summer of 1991 and 1992. Data include tree height, diameter, as well as green and dry weight of tree stem, top, small branches, large branches, and leaves.",
           url = "https://doi.org/10.2737/RDS-2016-0016",
           type = "study",
           licence = "",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "felled_tree_biomass.csv"))
loc <- read_csv(paste0(thisPath, "watershed_plot_locations.csv")) # these coordinates are not in Appalachian Mountains


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
# transform coordinates
coordinates(loc) <- c("Northing NAD83 zone 17N (meters)", "Easting NAD83 zone 17N (meters)")
proj4string(loc) <- CRS("+init=epsg:32167") # NAD83 zone 17N
CRS.new <- CRS("+init=epsg:4326") # WGS 84

loc.trans <- as.data.frame(spTransform(loc, CRS.new))
loc.trans <- loc.trans %>% rename(lat = Northing.NAD83.zone.17N..meters., long =  Easting.NAD83.zone.17N..meters.)

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    x = ,
    y = ,
    year = ,
    month = ,
    day = ,
    country = NA_character_,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = ,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = , # "field", "visual interpretation", "experience", "meta study" or "modelled"
    collector = , # "expert", "citizen scientist" or "student"
    purpose = , # "monitoring", "validation", "study" or "map development"
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
