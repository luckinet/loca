# script arguments ----
#
thisDataset <- "deSousa2020"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Sousa_cita.bib"))

regDataset(name = thisDataset,
           description = "A panel of fully genotyped 400 wheat lines derived from genebank accessions in two managed fields in the Ethiopian highlands in 2012 and 2013 were evaluated. We collected phenotypic data and farmer evaluation data in this trial. For the decentralized trial, we distributed a subset of 41 genotypes as packaged sets containing incomplete blocks of three genotypes, plus one commercial variety for each farmer, following the “tricot” citizen science approach. We distributed these packages to 1,165 farmers who planted them on their farms across three regions of Ethiopia. Analyzing data from the centralized and decentralized trials in a side-by-side comparison, we evaluated if our approach can increase genetic gain in marginal crop production environments unlocking the full potential of genomics assisted breeding. For the full replication workflow please visit the GitHub repository (https://github.com/agrobioinfoservices/tricot-genomic). ",
           url = "https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/OEZGVP",
           download_date = "2022-05-30",
           type = "static",
           licence = "CC BY-NC-SA 4.0",
           contact = "see corresponding author",
           disclosed = "",
           bibliography = bib,
           update = TRUE)


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
    x = lon,
    y = lat,
    geometry = NA,
    year = year,
    month = NA_real_,
    day = NA_integer_,
    country = "Ethiopia",
    irrigated = F,
    area = plot_size,
    presence = F,
    externalID = NA_character_,
    externalValue = "wheat",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
