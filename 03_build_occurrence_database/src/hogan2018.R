# script arguments ----
#
thisDataset <- "Hogan2018"
description <- "Selective logging remains a widespread practice in tropical forests, yet the long-term effects of timber harvest on juvenile tree (i.e., sapling) recruitment across the hundreds of species occurring in most tropical forests remain difficult to predict. This uncertainty could potentially exacerbate threats to some of the thousands of timber-valuable tree species in the Amazon. Our objective was to determine to what extent long-term responses of tree species regeneration in logged forests can be explained by their functional traits. We integrate functional trait data for 13 leaf, stem, and seed traits from 25 canopy tree species with a range of life histories, such as the pioneer Goupia glabra and the shade-tolerant Iryanthera hostmannii, together with over 30 yr of sapling monitoring in permanent plots spanning a gradient of harvest intensity at the Paracou Forest Disturbance Experiment (PFDE), French Guiana. We anticipated that more intensive logging would increase recruitment of pioneer species with higher specific leaf area, lower wood densities, and smaller seeds, due to the removal of canopy trees. We define a recruitment response metric to compare sapling regeneration to timber harvest intensity across species. Although not statistically significant, sapling recruitment decreased with logging intensity for eight of 23 species and these species tended to have large seeds and dense wood. A generalized linear mixed model fit using specific leaf area, seed mass, and twig density data explained about 45% of the variability in sapling dynamics. Effects of specific leaf area outweighed those of seed mass and wood density in explaining recruitment dynamics of the sapling community in response to increasing logging intensity. The most intense treatment at the PFDE, which includes stand thinning of non-timber-valuable adult trees and poison-girdling for competitive release, showed evidence of shifting community composition in sapling regeneration at the 30-yr mark, toward species with less dense wood, lighter seeds, and higher specific leaf area. Our results indicate that high-intensity logging can have lasting effects on stand regeneration dynamics and that functional traits can help simplify general trends of sapling recruitment for highly diverse logged tropical forests. "
url <- "https://doi.org/10.1002/eap.1776, https://doi.org/10.5061/dryad.0m27218"
license <- "CC0 1.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1939558228.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-22"),
           type = "satic",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Hogan2018.csv"))


# pre-process data ----
#
prep <- data %>%
  drop_na(X,Y) %>%
  separate(Placette, into = c("onto", "rest1", "rest2"))

data_sf <- st_as_sf(prep, coords = c("X", "Y"), crs = st_crs("EPSG:3313"))
data <- st_transform(data_sf,  crs = st_crs("EPSG:4326"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "French Guiana",
    x = st_coordinates(.)[1],
    y = st_coordinates(.)[2],
    geometry = geometry,
    epsg = 4326,
    area = NA_real_,
    date = "1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016", #  operating research site (17.8.2022) https://paracou.cirad.fr/website measurement times in README file
    externalID = as.character(ID),
    externalValue = onto,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(date, sep = " ") %>%
  mutate(
    fid = row_number(),
    date = ymd(paste0(date, "-01-01"))) %>%
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

# newConcepts <- tibble(target = c("Undisturbed Forest", "Naturally Regenerating Forest",
#                                  "Naturally Regenerating Forest", "Naturally Regenerating Forest",
#                                  "Naturally Regenerating Forest", "Undisturbed Forest",
#                                  "Naturally Regenerating Forest", "Naturally Regenerating Forest",
#                                  "Naturally Regenerating Forest", "Naturally Regenerating Forest",
#                                  "Undisturbed Forest", "Naturally Regenerating Forest"),
#                       new = unique(prep$onto),
#                       class = "land-use",
#                       description = NA,
#                       match = "close",
#                       certainty = 3)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
