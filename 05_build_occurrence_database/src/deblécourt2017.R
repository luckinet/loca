# script arguments ----
#
thisDataset <- "deBlécourt2017"
description <- "Presently, the lack of data on soil organic carbon (SOC) stocks in relation to land-use types and biophysical characteristics prevents reliable estimates of ecosystem carbon stocks in montane landscapes of mainland SE Asia. Our study, conducted in a 10000ha landscape in Xishuangbanna, SW China, aimed at assessing the spatial variability in SOC concentrations and stocks, as well as the relationships of SOC with land-use types, soil properties, vegetation characteristics and topographical attributes at three spatial scales: (1) land-use types within a landscape (10000ha), (2) sampling plots (1ha) nested within land-use types (plot distances ranging between 0.5 and 12km), and (3) subplots (10m radius) nested within sampling plots. We sampled 27 one-hectare plots – 10 plots in mature forests, 11 plots in regenerating or highly disturbed forests, and 6 plots in open land including tea plantations and grasslands. We used a sampling design with a hierarchical structure. The landscape was first classified according to land-use types. Within each land-use type, sampling plots were randomly selected, and within each plot we sampled within nine subplots. SOC concentrations and stocks did not differ significantly across the four land-use types. However, within the open-land category, SOC concentrations and stocks in grasslands were higher than in tea plantations (P<0.01 for 0–0.15m, P=0.05 for 0.15–0.30m, P=0.06 for 0–0.9m depth). The SOC stocks to a depth of 0.9m were 177.6±19.6 (SE) MgCha−1 in tea plantations, 199.5±14.8MgCha−1 in regenerating or highly disturbed forests, 228.6±19.7MgCha−1 in mature forests, and 236.2±13.7MgCha−1 in grasslands. In this montane landscape, variability within plots accounted for more than 50% of the overall variance in SOC stocks to a depth of 0.9m and the topsoil SOC concentrations. The relationships of SOC concentrations and stocks with land-use types, soil properties, vegetation characteristics, and topographical attributes varied across spatial scales. Variability in SOC within plots was determined by litter layer carbon stocks (P<0.01 for 0–0.15m and P=0.03 for 0.15–0.30 and 0–0.9m depth) and slope (P≤0.01 for 0–0.15, 0.15–0.30, and 0–0.9m depth) in open land, and by litter layer carbon stocks (P<0.001 for 0–0.15, 0.15–0.30 and 0–0.9m depth) and tree basal area (P<0.001 for 0–0.15m and P=0.01 for 0–0.9m depth) in forests. Variability in SOC among plots in open land was related to the differences in SOC concentrations and stocks between grasslands and tea plantations. In forests, the variability in SOC among plots was associated with elevation (P<0.01 for 0–0.15m and P=0.09 for 0–0.9m depth). The scale-dependent relationships between SOC and its controlling factors demonstrate that studies that aim to investigate the land-use effects on SOC need an appropriate sampling design reflecting the controlling factors of SOC so that land-use effects will not be masked by the variability between and within sampling plots."
url <- "https://doi.org/10.5194/soil-3-123-2017 https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "soil-3-123-2017.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-12-03"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Blecourt_data_SOIL.xlsx"), sheet = 2)


# harmonise data ----
#
data <- data %>%
  st_as_sf(coords = c("UTM_E", "UTM_N"), crs = "+proj=utm +zone=47R") %>%
  st_transform(4326) %>%
  mutate(
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2],) %>%
  as_tibble()

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "China",
    x = x,
    y = y,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    year = "2010_2011",
    externalID = NA_character_,
    externalValue = LAND_USE,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  mutate(fid = row_number(),
         date = ymd(paste0(year, "-01-01"))) %>%
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

# matches <- tibble(new = c(unique(data$LAND_USE)),
#                   old = c("Forest land", "Grass crops", "Undisturbed Forest", "tea"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
