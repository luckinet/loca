# script arguments ----
#
thisDataset <- "Oldfield2019"
description <- "Resilient, productive soils are necessary to sustainably intensify agriculture to increase yields while minimizing environmental harm. To conserve and regenerate productive soils, the need to maintain and build soil organic matter (SOM) has received considerable attention. Although SOM is considered key to soil health, its relationship with yield is contested because of local-scale differences in soils, climate, and farming systems. There is a need to quantify this relationship to set a general framework for how soil management could potentially contribute to the goals of sustainable intensification. We developed a quantitative model exploring how SOM relates to crop yield potential of maize and wheat in light of co-varying factors of management, soil type, and climate. We found that yields of these two crops are on average greater with higher concentrations of SOC (soil organic carbon). However, yield increases level off at ∼20% SOC. Nevertheless, approximately two-thirds of the world's cultivated maize and wheat lands currently have SOC contents of less than 20%. Using this regression relationship developed from published empirical data, we then estimated how an increase in SOC concentrations up to regionally specific targets could potentially help reduce reliance on nitrogen (N) fertilizer and help close global yield gaps. Potential N fertilizer reductions associated with increasing SOC amount to 70% and 5% of global N fertilizer inputs across maize and wheat fields, respectively. Potential yield increases of 10±11% (mean±SD) for maize and 23±37% for wheat amount to 32% of the projected yield gap for maize and 60% of that for wheat. Our analysis provides a global-level prediction for relating SOC to crop yields. Further work employing similar approaches to regional and local data, coupled with experimental work to disentangle causative effects of SOC on yield and vice versa, is needed to provide practical prescriptions to incentivize soil management for sustainable intensification."
url <- "https://doi.org/10.5194/soil-5-15-2019 https://"
licence <- "CC BY 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "soil-5-15-2019.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-13"),
           type = "static",
           licence = licence,
           contact = "emily.oldfield@yale.edu",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "resource_map_doi_10_5063_F19W0CQ5/data/Oldfield_et_al_Database.xlsx"))


# harmonise data ----
#
temp <- data %>%
  distinct(longitude, latitude, crop, `year of study`, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = longitude,
    y = latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = `year of study`,
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = crop,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = case_when(irigation == 1 ~ TRUE,
                          irigation == 0 ~ FALSE,
                          TRUE ~ FALSE),
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

