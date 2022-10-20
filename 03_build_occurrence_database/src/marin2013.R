# script arguments ----
#
thisDataset <- "Marin2013"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "This study evaluated the effects of climate change on sugarcane yield, water use efficiency, and irrigation needs in southern Brazil, based on downscaled outputs of two general circulation models (PRECIS and CSIRO) and a sugarcane growth model. For three harvest cycles every year, the DSSAT/CANEGRO model was used to simulate the baseline and four future climate scenarios for stalk yield for the 2050s. The model was calibrated for the main cultivar currently grown in Brazil based on five field experiments under several soil and climate conditions. The sensitivity of simulated stalk fresh mass (SFM) to air temperature, CO2 concentration [CO2] and rainfall was also analyzed. Simulated SFM responses to [CO2], air temperature and rainfall variations were consistent with the literature. There were increases in simulated SFM and water usage efficiency (WUE) for all scenarios. On average, for the current sugarcane area in the State of São Paulo, SFM would increase 24 % and WUE 34 % for rainfed sugarcane. The WUE rise is relevant because of the current concern about water supply in southern Brazil. Considering the current technological improvement rate, projected yields for 2050 ranged from 96 to 129 tha−1, which are respectively 15 and 59 % higher than the current state average yield."
url <- "https://doi.org/10.1007/s10584-012-0561-y"
license <- "CC BY 2.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1007_s10584-012-0561-y-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2022-10-20",
           type = "static",
           licence = license,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#

data <- read_excel(path = paste0(thisPath, "Table 1 Sources of experimental data used and climate characteristics of each site.xlsx"))


# harmonise data ----
#

temp <- data %>%
  separate(Site, into = c("Name", "CoordsSouth", "CoordsWest", "elev"), sep = ",") %>%
  separate_rows(`Planting and harvest dates`, sep = "and") %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = CoordsSouth,
    y = CoordsWest,
    geometry = NA,
    date = mdy(trimws(`Planting and harvest dates`)),
    country = "Brazil",
    irrigated = Treatments,
    area = NA_real_,
    presence = F,
    externalID = NA_character_,
    externalValue = "maize",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
