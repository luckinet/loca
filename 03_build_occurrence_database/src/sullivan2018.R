# script arguments ----
#
thisDataset <- "Sullivan2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_2041210x9.bib"))

regDataset(name = thisDataset,
           description = "Quantifying the relationship between tree diameter and height is a key component of efforts to estimate biomass and carbon stocks in tropical forests. Although substantial site-to-site variation in height–diameter allometries has been documented, the time consuming nature of measuring all tree heights in an inventory plot means that most studies do not include height, or else use generic pan-tropical or regional allometric equations to estimate height. Using a pan-tropical dataset of 73 plots where at least 150 trees had in-field ground-based height measurements, we examined how the number of trees sampled affects the performance of locally derived height–diameter allometries, and evaluated the performance of different methods for sampling trees for height measurement. Using cross-validation, we found that allometries constructed with just 20 locally measured values could often predict tree height with lower error than regional or climate-based allometries (mean reduction in prediction error = 0.46 m). The predictive performance of locally derived allometries improved with sample size, but with diminishing returns in performance gains when more than 40 trees were sampled. Estimates of stand-level biomass produced using local allometries to estimate tree height show no over- or under-estimation bias when compared with biomass estimates using field measured heights. We evaluated five strategies to sample trees for height measurement, and found that sampling strategies that included measuring the heights of the ten largest diameter trees in a plot outperformed (in terms of resulting in local height–diameter models with low height prediction error) entirely random or diameter size-class stratified approaches. Our results indicate that even limited sampling of heights can be used to refine height–diameter allometries. We recommend aiming for a conservative threshold of sampling 50 trees per location for height measurement, and including the ten trees with the largest diameter in this sample.",
           url = "https://doi.org/10.1111/2041-210X.12962",
           download_date = "2022-01-13",
           type = "static",
           licence = "CC BY 4.0",
           contact = "m.j.sullivan@leeds.ac.uk",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "forestPlots_Sullivan.xlsx"), sheet = 3)
year <- read_xlsx(paste0(thisPath, "forestPlots_Sullivan.xlsx"), sheet = 4) %>% mutate (ID = `Sample unit ID`)

data <- left_join(data, year, by = "ID")


# harmonise data ----
#
temp <- data %>%
  separate_rows(`Years of censuses in which height data used in this paper were collected`, sep = ",") %>%
  distinct(Latitude, Longitude, `Years of censuses in which height data used in this paper were collected`, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    year = as.numeric(`Years of censuses in which height data used in this paper were collected`),
    month = NA_real_,
    day = NA_integer_,
    country = NA_character_,
    irrigated = F,
    externalID = as.character(ID),
    externalValue = "Forests",
    presence = F,
    area = NA_real_,
    type = "point",
    geometry = NA,
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
