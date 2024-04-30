# script arguments ----
#
thisDataset <- "Grosso2013"
description <- "Difficulties in accessing high-quality data on trace gas fluxes and performance of bioenergy/bioproduct feedstocks limit the ability of researchers and others to address environmental impacts of agriculture and the potential to produce feedstocks. To address those needs, the GRACEnet (Greenhouse gas Reduction through Agricultural Carbon Enhancement network) and REAP (Renewable Energy Assessment Project) research programs were initiated by the USDA Agricultural Research Service (ARS). A major product of these programs is the creation of a database with greenhouse gas fluxes, soil carbon stocks, biomass yield, nutrient, and energy characteristics, and input data for modeling cropped and grazed systems. The data include site descriptors (e.g., weather, soil class, spatial attributes), experimental design (e.g., factors manipulated, measurements performed, plot layouts), management information (e.g., planting and harvesting schedules, fertilizer types and amounts, biomass harvested, grazing intensity), and measurements (e.g., soil C and N stocks, plant biomass amount and chemical composition). To promote standardization of data and ensure that experiments were fully described, sampling protocols and a spreadsheet-based data-entry template were developed. Data were first uploaded to a temporary database for checking and then were uploaded to the central database. A Web-accessible application allows for registered users to query and download data including measurement protocols. Separate portals have been provided for each project (GRACEnet and REAP) at nrrc.ars.usda.gov/slgracenet/\#/Home and nrrc.ars.usda.gov/slreap/\#/Home. The database architecture and data entry template have proven flexible and robust for describing a wide range of field experiments and thus appear suitable for other natural resource research projects."
url <- "https://doi.org/10.2134/jeq2013.03.0097 https://"
licence <- ""


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_1537253742.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2017-10-17"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "natres.xlsx"), sheet = 2)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = Country,
    x = `Longitude decimal deg`,
    y = `Latitude decimal deg`,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = Date,
    externalID = `Field ID`,
    externalValue = `Native Veg`,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = TRUE,
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

# matches <- tibble(new = c(unique(data$`Native Veg`)),
#                   old = c(NA,
#                           "Grass and fodder crops",
#                           "Grass and fodder crops",
#                           "Grass and fodder crops",
#                           "Forest land",
#                           "Grass and fodder crops",
#                           "Grass and fodder crops",
#                           "Grass and fodder crops",
#                           "Forest land",
#                           "Forest land",
#                           "Grass and fodder crops",
#                           "Unstocked Forest",
#                           "Grass and fodder crops",
#                           "alfalfa",
#                           "Grass and fodder crops",
#                           "Grass and fodder crops",
#                           "Grass and fodder crops",
#                           "Grass and fodder crops",
#                           "Grass and fodder crops",
#                           "Grass and fodder crops",
#                           "Forest land",
#                           "Forest land",
#                           "Grass and fodder crops",
#                           "Grass and fodder crops",
#                           "Forest land",
#                           "Grass and fodder crops"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
