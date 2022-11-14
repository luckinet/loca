# script arguments ----
#
thisDataset <- "Anderson-Teixeira2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1939917099.bib"))

regDataset(name = thisDataset,
           description = "Abstract Forests play an influential role in the global carbon (C) cycle, storing roughly half of terrestrial C and annually exchanging with the atmosphere more than five times the carbon dioxide (CO2) emitted by anthropogenic activities. Yet, scaling up from field-based measurements of forest C stocks and fluxes to understand global scale C cycling and its climate sensitivity remains an important challenge. Tens of thousands of forest C measurements have been made, but these data have yet to be integrated into a single database that makes them accessible for integrated analyses. Here we present an open-access global Forest Carbon database (ForC) containing previously published records of field-based measurements of ecosystem-level C stocks and annual fluxes, along with disturbance history and methodological information. ForC expands upon the previously published tropical portion of this database, TropForC (https://doi.org/10.5061/dryad.t516f), now including 17,367 records (previously 3,568) representing 2,731 plots (previously 845) in 826 geographically distinct areas. The database covers all forested biogeographic and climate zones, represents forest stands of all ages, and currently includes data collected between 1934 and 2015. We expect that ForC will prove useful for macroecological analyses of forest C cycling, for evaluation of model predictions or remote sensing products, for quantifying the contribution of forests to the global C cycle, and for supporting international efforts to inventory forest carbon and greenhouse gas exchange. A dynamic version of ForC is maintained at on GitHub (https://GitHub.com/forc-db), and we encourage the research community to collaborate in updating, correcting, expanding, and utilizing this database. ForC is an open access database, and we encourage use of the data for scientific research and education purposes. Data may not be used for commercial purposes without written permission of the database PI. Any publications using ForC data should cite this publication and Anderson-Teixeira et al. (2016a) (see Metadata S1). No other copyright or cost restrictions are associated with the use of this data set.",
           url = "https://esajournals.onlinelibrary.wiley.com/doi/abs/10.1002/ecy.2229",
           type = "static",
           licence = "",
           bibliography = bib,
           download_date = "2021-12-22",
           contact = "see corresponding author",
           disclosed = "yes",
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "FoC_global.xlsx"))

# manage ontology ---
#
matches <- tibble(new = c(unique(data$...8)),
                  old = c("Forests"))


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
  mutate(x = lon,
         y = lat,
         fid = row_number(),
         day = NA_integer_,
         month = NA_real_,
         irrigated = FALSE,
         datasetID = thisDataset,
         geometry = NA,
         externalID = NA_character_,
         externalValue = `...8`,
         presence = TRUE,
         area = NA_real_,
         type = "point",
         LC1_orig = NA_character_,
         LC2_orig = NA_character_,
         LC3_orig = NA_character_,
         sample_type = "field",
         collector = "expert",
         purpose = "study",
         epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")

