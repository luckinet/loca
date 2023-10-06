# script arguments ----
#
thisDataset <- "Drakos2020"
description <- "The agINFRA project (www.aginfra.eu) was a European Commission funded project under the 7th Framework Programme that aimed to introduce agricultural scientific communities to the vision of open and participatory data-intensive science. agINFRA has now evolved into the European hub for data-powered research on agriculture, food and the environment, serving the research community through multiple roles. Working on enhancing the interoperability between heterogeneous data sources, the agINFRA project has left a set of grid- and cloud- based services that can be reused by future initiatives and adopted by existing ones, in order to facilitate the dissemination of agricultural research, educational and other types of data. On top of that, agINFRA provided a set of domain-specific recommendations for the publication of agri-food research outcomes. This paper discusses the concept of the agINFRA project and presents its major outcomes, as adopted by existing initiatives activated in the context of agricultural research and education."
url <- "https://doi.org/10.12688/f1000research.6349.1 https://"
licence <- "CC BY 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "bibtex-7112.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd(),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "data_points.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = NA_character_,
    x = NA_real_,
    y = NA_real_,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = NA_character_,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = NA,
    sample_type = NA_character_,
    collector = NA_character_,
    purpose = NA_character_) %>%
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
