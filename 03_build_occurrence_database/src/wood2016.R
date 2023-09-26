# script arguments ----
#
thisDataset <- "Wood2016"
description <- "This data package includes felled tree biomass by tree component for four hardwood species of the central Appalachians sampled on the Fernow Experimental Forest (FEF), West Virginia. A total of 88 trees were sampled from plots within two different watersheds on the FEF. Hardwood species sampled include Acer rubrum, Betula lenta, Liriodendron tulipifera, and Prunus serotina, all of which were measured in the summer of 1991 and 1992. Data include tree height, diameter, as well as green and dry weight of tree stem, top, small branches, large branches, and leaves."
url <- "https://doi.org/10.2737/RDS-2016-0016 https://"
license <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Wood2016_Citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd(),
           type = "study",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "felled_tree_biomass.csv"))
loc <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "watershed_plot_locations.csv"))
colnames(loc) <- tolower(colnames(loc))


# pre-process data ----
#
data <- left_join(data, loc, by = "plot")

data <- st_as_sf(data, coords= c("easting nad83 zone 17n (meters)", "northing nad83 zone 17n (meters)"), crs= st_crs(32167)) %>%
  st_transform(., crs = 4326)


# harmonise data ----
#
temp <- data %>%
  distinct(year, geometry, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2],
    geometry = geometry,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste0(year, "-01-01")),
    externalID = NA_character_,
    externalValue = "Naturally Regenerating Forest",
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
