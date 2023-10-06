# script arguments ----
#
thisDataset <- "Faye2019"
description <- "Uncovering the genomic basis of climate adaptation in traditional crop varieties can provide insight into plant evolution and facilitate breeding for climate resilience. In the African cereal sorghum (Sorghum bicolor L. [Moench]), the genomic basis of adaptation to the semiarid Sahelian zone versus the subhumid Soudanian zone is largely unknown. To address this issue, we characterized a large panel of 421 georeferenced sorghum landrace accessions from Senegal and adjacent locations at 213,916 single-nucleotide polymorphisms (SNPs) using genotyping-by-sequencing. Seven subpopulations distributed along the north-south precipitation gradient were identified. Redundancy analysis found that climate variables explained up to 8% of SNP variation, with climate collinear with space explaining most of this variation (6%). Genome scans of nucleotide diversity suggest positive selection on chromosome 2, 4, 5, 7, and 10 in durra sorghums, with successive adaptation during diffusion along the Sahel. Putative selective sweeps were identified, several of which colocalize with stay-green drought tolerance (Stg) loci, and a priori candidate genes for photoperiodic flowering and inflorescence morphology. Genome-wide association studies of photoperiod sensitivity and panicle compactness identified 35 and 13 associations that colocalize with a priori candidate genes, respectively. Climate-associated SNPs colocalize with Stg3a, Stg1, Stg2, and Ma6 and have allelic distribution consistent with adaptation across Sahelian and Soudanian zones. Taken together, the findings suggest an oligogenic basis of adaptation to Sahelian versus Soudanian climates, underpinned by variation in conserved floral regulatory pathways and other systems that are less understood in cereals."
url <- "https://doi.org/10.1002/ece3.5187 https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_204577589.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2020-10-23"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = FALSE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "SSG_collection_passportData.xlsx"))


# harmonise data ----
#
temp <- data %>%
  na.omit(Latitude, Longitude) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Senegal",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = dmy("01-01-1976"),
    externalID = Sample_ID,
    externalValue = "sorghum",
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
