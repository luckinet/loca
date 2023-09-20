# script arguments ----
#
thisDataset <- "Lauenroth2019"
description <- "This data package was produced by researchers working on the Shortgrass Steppe Long Term Ecological Research (SGS-LTER) Project, administered at Colorado State University. Long-term datasets and background information (proposals, reports, photographs, etc.) on the SGS-LTER project are contained in a comprehensive project collection within the Digital Collections of Colorado (http://digitool.library.colostate.edu/R/?func=collections&collection_id=...). The data table and associated metadata document, which is generated in Ecological Metadata Language, may be available through other repositories serving the ecological research community and represent components of the larger SGS-LTER project collection. Six sites approximately 6 km apart were selected at the Central Plains Experimental Range in 1997. Within each site, there was a pair of adjacent ungrazed and moderately summer grazed (40-60% removal of annual aboveground production by cattle) locations. Grazed locations had been grazed from 1939 to present and ungrazed locations had been protected from 1991 to present by the establishment of exclosures. Within grazed and ungrazed locations, all tillers and root crowns of B. gracilis were removed from two treatment plots (3 m x 3 m) with all other vegetation undisturbed. Two control plots were established adjacent to the treatment plots. Plant density was measured annually by species in a fixed 1m x 1m quadrat in the center of treatment and control plots. For clonal species, an individual plant was defined as a group of tillers connected by a crown Coffin & Lauenroth 1988, Fair et al. 1999). Seedlings were counted as separate individuals. In the same quadrat, basal cover by species, bare soil, and litter were estimated annually using a point frame. A total of 40 points were read from four locations halfway between the center point and corners of the 1m x 1m quadrat. Density was measured from 1998 to 2005 and cover from 1997 to 2006. All measurements were taken in late June/early July."
url <- "https://doi.org/10.6073/pasta/d0272af6e402fe1fe0c5d218b06cfdcb https://"
license <- "Creative Commons Attribution"




# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "agrisexport.txt"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("1-06-2022"),
           type = "static",
           licence = license,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)

# read dataset ----
#
data <- read_delim(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "BOGRRmvlDnsty.txt"))


# harmonise data ----
#
temp <- data %>%
  distinct(Longitude, Latitude, Date, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "USA",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = 9,
    date = mdy(Date),
    externalID = NA_character_,
    externalValue = Treatment_Control,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring") %>%
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
