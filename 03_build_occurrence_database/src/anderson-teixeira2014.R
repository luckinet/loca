# script arguments ----
#
thisDataset <- "Anderson-Teixeira2014"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "pericles_1365248621.ris"))

regDataset(name = thisDataset,
           description = "Global change is impacting forests worldwide, threatening biodiversity and ecosystem services including climate regulation. Understanding how forests respond is critical to forest conservation and climate protection. This review describes an international network of 59 long-term forest dynamics research sites (CTFS-ForestGEO) useful for characterizing forest responses to global change. Within very large plots (median size 25 ha), all stems ≥1 cm diameter are identified to species, mapped, and regularly recensused according to standardized protocols. CTFS-ForestGEO spans 25°S–61°N latitude, is generally representative of the range of bioclimatic, edaphic, and topographic conditions experienced by forests worldwide, and is the only forest monitoring network that applies a standardized protocol to each of the world's major forest biomes. Supplementary standardized measurements at subsets of the sites provide additional information on plants, animals, and ecosystem and environmental variables. CTFS-ForestGEO sites are experiencing multifaceted anthropogenic global change pressures including warming (average 0.61 °C), changes in precipitation (up to ±30% change), atmospheric deposition of nitrogen and sulfur compounds (up to 3.8 g N m−2 yr−1 and 3.1 g S m−2 yr−1), and forest fragmentation in the surrounding landscape (up to 88% reduced tree cover within 5 km). The broad suite of measurements made at CTFS-ForestGEO sites makes it possible to investigate the complex ways in which global change is impacting forest dynamics. Ongoing research across the CTFS-ForestGEO network is yielding insights into how and why the forests are changing, and continued monitoring will provide vital contributions to understanding worldwide forest diversity and dynamics in an era of global change.",
           url = "https://doi.org/10.1111/gcb.12712",
           download_date = "2022-01-30",
           type = "dynamic",
           licence = "",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
load(file = (paste0(thisPath, "luquillo_tree6_1ha.rda")))
data <- luquillo_tree6_1ha

# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    x = gx,
    y = gy,
    year = year(ExactDate),
    month = month(ExactDate),
    day = day(ExactDate),
    datasetID = thisDataset,
    country = NA_character_,
    irrigated = F,
    presence = FALSE,
    type = "point",
    area = NA_real_,
    geometry = NA,
    externalID = as.character(treeID),
    externalValue = "Naturally Regenerating Forest", # clarificatian: luckinetID missing: "The sites are generally in old-growth or mature secondary forests and are commonly among the most intact, biodiverse, and well-protected forests within their region. They are subjected to a range of natural disturbances (Table 1), and a number of sites have experienced significant natural disturbances in recent years (e.g., fire at Yosemite, typhoons at Palanan). In addition, most sites have experienced some level of anthropogenic disturbance (discussed below; Table S5)."
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
