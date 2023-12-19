# script arguments ----
#
thisDataset <- "Anderson-Teixeira2018"
description <- "Forests play an influential role in the global carbon (C) cycle, storing roughly half of terrestrial C and annually exchanging with the atmosphere more than five times the carbon dioxide (CO2) emitted by anthropogenic activities. Yet, scaling up from field-based measurements of forest C stocks and fluxes to understand global scale C cycling and its climate sensitivity remains an important challenge. Tens of thousands of forest C measurements have been made, but these data have yet to be integrated into a single database that makes them accessible for integrated analyses. Here we present an open-access global Forest Carbon database (ForC) containing previously published records of field-based measurements of ecosystem-level C stocks and annual fluxes, along with disturbance history and methodological information. ForC expands upon the previously published tropical portion of this database, TropForC (https://doi.org/10.5061/dryad.t516f), now including 17,367 records (previously 3,568) representing 2,731 plots (previously 845) in 826 geographically distinct areas. The database covers all forested biogeographic and climate zones, represents forest stands of all ages, and currently includes data collected between 1934 and 2015. We expect that ForC will prove useful for macroecological analyses of forest C cycling, for evaluation of model predictions or remote sensing products, for quantifying the contribution of forests to the global C cycle, and for supporting international efforts to inventory forest carbon and greenhouse gas exchange. A dynamic version of ForC is maintained at on GitHub (https://GitHub.com/forc-db), and we encourage the research community to collaborate in updating, correcting, expanding, and utilizing this database. ForC is an open access database, and we encourage use of the data for scientific research and education purposes. Data may not be used for commercial purposes without written permission of the database PI. Any publications using ForC data should cite this publication and Anderson-Teixeira et al. (2016a) (see Metadata S1). No other copyright or cost restrictions are associated with the use of this data set."
url <- "https://doi.org/10.1002/ecy.2229 https://" # doi, in case this exists and download url separated by empty space
licence <- ""


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_1939917099.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("22-12-2021"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "FoC_global.xlsx"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = lon,
    y = lat,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = `...8`,
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
