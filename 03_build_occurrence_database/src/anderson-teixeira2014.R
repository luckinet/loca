# script arguments ----
#
thisDataset <- "Anderson-Teixeira2014"
description <- "Global change is impacting forests worldwide, threatening biodiversity and ecosystem services including climate regulation. Understanding how forests respond is critical to forest conservation and climate protection. This review describes an international network of 59 long-term forest dynamics research sites (CTFS-ForestGEO) useful for characterizing forest responses to global change. Within very large plots (median size 25 ha), all stems ≥1 cm diameter are identified to species, mapped, and regularly recensused according to standardized protocols. CTFS-ForestGEO spans 25°S–61°N latitude, is generally representative of the range of bioclimatic, edaphic, and topographic conditions experienced by forests worldwide, and is the only forest monitoring network that applies a standardized protocol to each of the world's major forest biomes. Supplementary standardized measurements at subsets of the sites provide additional information on plants, animals, and ecosystem and environmental variables. CTFS-ForestGEO sites are experiencing multifaceted anthropogenic global change pressures including warming (average 0.61 °C), changes in precipitation (up to ±30% change), atmospheric deposition of nitrogen and sulfur compounds (up to 3.8 g N m−2 yr−1 and 3.1 g S m−2 yr−1), and forest fragmentation in the surrounding landscape (up to 88% reduced tree cover within 5 km). The broad suite of measurements made at CTFS-ForestGEO sites makes it possible to investigate the complex ways in which global change is impacting forest dynamics. Ongoing research across the CTFS-ForestGEO network is yielding insights into how and why the forests are changing, and continued monitoring will provide vital contributions to understanding worldwide forest diversity and dynamics in an era of global change."
url <- "https://doi.org/10.1111/gcb.12712 https://" # doi, in case this exists and download url separated by empty space
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(thisPath, "pericles_1365248621.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("30-01-2022"),
           type = "dynamic",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
load(file = (paste0(thisPath, "luquillo_tree6_1ha.rda")))
data <- luquillo_tree6_1ha


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = gx,
    y = gy,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = year(ExactDate),
    # month = month(ExactDate),
    # day = day(ExactDate),
    externalID = as.character(treeID),
    externalValue = "Naturally Regenerating Forest", # clarificatian: "The sites are generally in old-growth or mature secondary forests and are commonly among the most intact, biodiverse, and well-protected forests within their region. They are subjected to a range of natural disturbances (Table 1), and a number of sites have experienced significant natural disturbances in recent years (e.g., fire at Yosemite, typhoons at Palanan). In addition, most sites have experienced some level of anthropogenic disturbance (discussed below; Table S5)."
    irrigated = FALSE,
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
