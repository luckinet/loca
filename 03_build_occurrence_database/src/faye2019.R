# script arguments ----
#
thisDataset <- "Faye2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "pericles_204577589.ris"))

regDataset(name = thisDataset,
           description = "Uncovering the genomic basis of climate adaptation in traditional crop varieties can provide insight into plant evolution and facilitate breeding for climate resilience. In the African cereal sorghum (Sorghum bicolor L. [Moench]), the genomic basis of adaptation to the semiarid Sahelian zone versus the subhumid Soudanian zone is largely unknown. To address this issue, we characterized a large panel of 421 georeferenced sorghum landrace accessions from Senegal and adjacent locations at 213,916 single-nucleotide polymorphisms (SNPs) using genotyping-by-sequencing. Seven subpopulations distributed along the north-south precipitation gradient were identified. Redundancy analysis found that climate variables explained up to 8% of SNP variation, with climate collinear with space explaining most of this variation (6%). Genome scans of nucleotide diversity suggest positive selection on chromosome 2, 4, 5, 7, and 10 in durra sorghums, with successive adaptation during diffusion along the Sahel. Putative selective sweeps were identified, several of which colocalize with stay-green drought tolerance (Stg) loci, and a priori candidate genes for photoperiodic flowering and inflorescence morphology. Genome-wide association studies of photoperiod sensitivity and panicle compactness identified 35 and 13 associations that colocalize with a priori candidate genes, respectively. Climate-associated SNPs colocalize with Stg3a, Stg1, Stg2, and Ma6 and have allelic distribution consistent with adaptation across Sahelian and Soudanian zones. Taken together, the findings suggest an oligogenic basis of adaptation to Sahelian versus Soudanian climates, underpinned by variation in conserved floral regulatory pathways and other systems that are less understood in cereals.",
           url = "https://doi.org/10.1002/ece3.5187",
           download_date = "2020-10-23",
           type = "static",
           licence = "",
           contact = "see corresponding author",
           disclosed = "no",
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#

data <- read_excel(paste0(thisPath, "SSG_collection_passportData.xlsx"))



# harmonise data ----
#
# carry out optional corrections and validations ...


# ... and then reshape the input data into the harmonised format
temp <- data %>%
  na.omit(Latitude, Longitude) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    year = 1976,
    month = NA_real_,
    day = NA_integer_,
    country = "Senegal",
    irrigated = F,
    area = NA_real_,
    presence = F,
    externalID = Sample_ID,
    externalValue = "sorghum",
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
