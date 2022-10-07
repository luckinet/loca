# script arguments ----
#
thisDataset <- "Ploton2020"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_s41597-020-0561-0-citation.ris")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Forest biomass is key in Earth carbon cycle and climate system, and thus under intense scrutiny in the context of international climate change mitigation initiatives (e.g. REDD+). In tropical forests, the spatial distribution of aboveground biomass (AGB) remains, however, highly uncertain. There is increasing recognition that progress is strongly limited by the lack of field observations over large and remote areas. Here, we introduce the Congo basin Forests AGB (CoFor-AGB) dataset that contains AGB estimations and associated uncertainty for 59,857 1-km pixels aggregated from nearly 100,000 ha of in situ forest management inventories for the 2000 – early 2010s period in five central African countries. A comprehensive error propagation scheme suggests that the uncertainty on AGB estimations derived from c. 0.5-ha inventory plots (8.6–15.0%) is only moderately higher than the error obtained from scientific sampling plots (8.3%). CoFor-AGB provides the first large scale view of forest AGB spatial variation from field data in central Africa, the second largest continuous tropical forest domain of the world.",
           url = "https://doi.org/10.1038/s41597-020-0561-0",
           download_date = "2022-01-08",
           type = "static",
           licence = "CC BY 4.0",
           contact = "p.ploton@gmail.com",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "COFOR_plot_v-01-2020.xlsx"), sheet = 2)


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
    x = lon,
    y = lat,
    luckinetID = 1122,
    year = NA_real_,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = Country,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = NA_character_,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 3395) %>%
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
