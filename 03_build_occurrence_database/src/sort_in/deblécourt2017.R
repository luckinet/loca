# script arguments ----
#
thisDataset <- "deBlécourt2017"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "soil-3-123-2017.bib"))

regDataset(name = thisDataset,
           description = "Presently, the lack of data on soil organic carbon (SOC) stocks in relation to land-use types and biophysical characteristics prevents reliable estimates of ecosystem carbon stocks in montane landscapes of mainland SE Asia. Our study, conducted in a 10000ha landscape in Xishuangbanna, SW China, aimed at assessing the spatial variability in SOC concentrations and stocks, as well as the relationships of SOC with land-use types, soil properties, vegetation characteristics and topographical attributes at three spatial scales: (1) land-use types within a landscape (10000ha), (2) sampling plots (1ha) nested within land-use types (plot distances ranging between 0.5 and 12km), and (3) subplots (10m radius) nested within sampling plots. We sampled 27 one-hectare plots – 10 plots in mature forests, 11 plots in regenerating or highly disturbed forests, and 6 plots in open land including tea plantations and grasslands. We used a sampling design with a hierarchical structure. The landscape was first classified according to land-use types. Within each land-use type, sampling plots were randomly selected, and within each plot we sampled within nine subplots. SOC concentrations and stocks did not differ significantly across the four land-use types. However, within the open-land category, SOC concentrations and stocks in grasslands were higher than in tea plantations (P<0.01 for 0–0.15m, P=0.05 for 0.15–0.30m, P=0.06 for 0–0.9m depth). The SOC stocks to a depth of 0.9m were 177.6±19.6 (SE) MgCha−1 in tea plantations, 199.5±14.8MgCha−1 in regenerating or highly disturbed forests, 228.6±19.7MgCha−1 in mature forests, and 236.2±13.7MgCha−1 in grasslands. In this montane landscape, variability within plots accounted for more than 50% of the overall variance in SOC stocks to a depth of 0.9m and the topsoil SOC concentrations. The relationships of SOC concentrations and stocks with land-use types, soil properties, vegetation characteristics, and topographical attributes varied across spatial scales. Variability in SOC within plots was determined by litter layer carbon stocks (P<0.01 for 0–0.15m and P=0.03 for 0.15–0.30 and 0–0.9m depth) and slope (P≤0.01 for 0–0.15, 0.15–0.30, and 0–0.9m depth) in open land, and by litter layer carbon stocks (P<0.001 for 0–0.15, 0.15–0.30 and 0–0.9m depth) and tree basal area (P<0.001 for 0–0.15m and P=0.01 for 0–0.9m depth) in forests. Variability in SOC among plots in open land was related to the differences in SOC concentrations and stocks between grasslands and tea plantations. In forests, the variability in SOC among plots was associated with elevation (P<0.01 for 0–0.15m and P=0.09 for 0–0.9m depth). The scale-dependent relationships between SOC and its controlling factors demonstrate that studies that aim to investigate the land-use effects on SOC need an appropriate sampling design reflecting the controlling factors of SOC so that land-use effects will not be masked by the variability between and within sampling plots.",
           url = "https://doi.org/10.5194/soil-3-123-2017",
           download_date = "2021-12-03",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Blecourt_data_SOIL.xlsx"), sheet = 2)


# manage ontology ---
#
matches <- tibble(new = c(unique(data$LAND_USE)),
                  old = c("Forest land", "Grass crops", "Undisturbed Forest", "tea"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)

# harmonise data ----
#

temp <- data %>%
  st_as_sf(coords = c("UTM_E", "UTM_N"), crs = "+proj=utm +zone=47R") %>%
  st_transform(4326) %>%
  mutate(
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2],) %>%
  as_tibble()

temp <- temp %>%
  mutate(
    x = x,
    y = y,
    year = "2010_2011",
    datasetID = thisDataset,
    country = "China",
    irrigated = FALSE,
    externalID = NA_character_,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    externalValue = LAND_USE,
    presence = TRUE,
    type = "point",
    area = NA_real_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  mutate(fid = row_number(),
         date = ymd(paste0(year, "-01-01"))) %>%
  select(datasetID, fid, country, x, y, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

# write output ----
#
validateFormat(object = temp, type = "in-situ point") %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
