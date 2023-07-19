# script arguments ----
#
thisDataset <- "deSousa2020"
description <- "A panel of fully genotyped 400 wheat lines derived from genebank accessions in two managed fields in the Ethiopian highlands in 2012 and 2013 were evaluated. We collected phenotypic data and farmer evaluation data in this trial. For the decentralized trial, we distributed a subset of 41 genotypes as packaged sets containing incomplete blocks of three genotypes, plus one commercial variety for each farmer, following the “tricot” citizen science approach. We distributed these packages to 1,165 farmers who planted them on their farms across three regions of Ethiopia. Analyzing data from the centralized and decentralized trials in a side-by-side comparison, we evaluated if our approach can increase genetic gain in marginal crop production environments unlocking the full potential of genomics assisted breeding. For the full replication workflow please visit the GitHub repository (https://github.com/agrobioinfoservices/tricot-genomic)."
url <- "https://doi.org/ https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/OEZGVP"
licence <- "CC BY-NC-SA 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Sousa_cita.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-05-30"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(paste0(thisPath, "dataverse_files/5_AllFiles_DecentralizedBreeding_DurumWheat.xlsx"), sheet = 4)


# harmonise data ----
#
temp <- data %>%
  distinct(year, lat, lon, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Ethiopia",
    x = lon,
    y = lat,
    geometry = NA,
    epsg = 4326,
    area = plot_size,
    date = NA,
    # year = year,
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = "wheat",
    irrigated = FALSE,
    presence = FALSE,
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
