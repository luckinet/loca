# script arguments ----
#
thisDataset <- "Gallagher2017"
description <- "This data publication contains pre- and post-treatment fuel loading data for 22 prescribed burns (RxBs) and 4 wildfires from 2012-2015 in the New Jersey Pinelands, specifically in Ocean and Burlington Counties. The data include: forest floor loading, shrub loading, forest census data, and canopy fuels via a profiling light detection and ranging (LiDAR) system for both before and after fuel reduction treatments. These data were collected as part of a Joint Fire Science Program project designed to collect landscape-scale fuels data before and after prescribed fires to quantify consumption, collect data for the parameterization and evaluation of computational flow-dynamics models for simulating fire behavior, and synthesize data for the evaluation of fuels treatment effectiveness. Data are available as either a Microsoft Access database file or as individual comma-delimited ASCII text files."
url <- "https://doi.org/10.2737/RDS-2017-0061 https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(thisPath, "citation-321084560.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-25"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "/Data/CSV/PLOT_SAMPLE_LOC.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "United States",
    x = LONG,
    y = LAT,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year ="2014_2015",
    externalID = ID,
    externalValue = "Naturally regenerating forest",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  mutate(
    fid = row_number(),
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
