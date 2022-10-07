# script arguments ----
#
thisDataset <- "Ibanez2020"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_16000706129.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Species abundance distributions (SADs) characterise the distribution of individuals among species. SADs have rarely been explored on islands and the ecological processes shaping SADs are still not fully understood. Notably, the relative importance of disturbance regime in shaping plant SADs remains poorly known. We investigate the relative importance of disturbance regime and island geography on the shape of SADs. We computed SADs for local tree communities in 1-ha forest plots on 20 tropical islands in the Indo-Pacific region. We used generalized linear models to analyse how the shape parameter of the gambin SAD model was related to the number of trees and the number of species. Regression analyses were also used to investigate how the shape of SADs, the number of trees and the number of species were related to cyclone disturbance (power dissipation index) and geography (island area and isolation), with direct and indirect (i.e. through the number of trees and species) effects assessed using variance partitioning. Cyclone disturbance was the best predictor of the shape of SADs, with higher power dissipation index producing more lognormal-like distributions. This effect was mostly due to cyclones increasing the number of trees and decreasing the number of species. Island area affected the shape of SADs through its effect on the number of species, and larger islands were associated with higher species richness and more logseries-like distributions. The effect of cyclones was stronger on smaller islands. Our results illustrate that disturbances can affect SADs in complex ways; directly and indirectly by impacting the number of species and individuals in communities, and these effects may be moderated by island-specific characteristics, such as island area or isolation. Our results therefore suggest that multiple, interacting processes shape SADs and that studying SADs has the potential to contribute important new insights to the field of island biogeography.",
           url = "https://doi.org/10.1111/oik.07501",
           download_date = "2022-01-22",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "DATA_OIKOS.csv"))


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
    x = Long,
    y = Lat,
    year = NA_real_,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = NA_character_,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = "Undisturbed Forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
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
