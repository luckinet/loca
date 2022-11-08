# script arguments ----
#
thisDataset <- "Surendra2021"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "The majority of Earth’s tropical forests have been selectively logged; some on repeated occasions. Selective logging is known to affect forest structure, composition and function in various ways, but how such effects vary with logging frequency and across forest types remains unclear. In the Andaman Archipelago in India, we examined adult and pole-sized trees in baseline (unlogged since 1990s), once-logged (logged between 2007 and 2014) and twice-logged (logged in early 1990s and between 2007 and 2014) evergreen and deciduous forests, and tested whether higher logging frequency was associated with lower canopy cover, tree density, tree diversity, aboveground carbon stocks and divergence in species composition, including increased relative abundances of deciduous species in these forests. While once-logged evergreen and deciduous forests were similar to their respective baselines for most attributes assessed, and twice-logged evergreen forests had 22–24% lower adult tree density and diversity, twice-logged deciduous forests had 17–50% lower canopy cover, pole density, adult species diversity and above-ground carbon stocks, and 12% higher deciduous fractions compared to the baselines. Collectively our results reveal lasting impacts of repeated selective logging, even at relative low intensity, on tree communities and carbon storage. These impacts can potentially be mitigated by reducing logging frequency and retaining unlogged patches in logged landscapes, but management must also incorporate heterogeneity in responses and recovery across different forest types. In the Andaman Islands, all forests may require more than 15–25 years between logging events, with deciduous forests potentially requiring more stringent extraction limits compared to evergreen forests."
url <- "https://doi.org/10.1016/j.foreco.2020.118791"
license <- ""

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "S0378112720315607.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2022-01-13",
           type = "static",
           licence = licence,
           contact = "akshaysurendra1@gmail.com",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "plot_characteristics.csv"))


# harmonise data ----
#

temp <- data %>%
  mutate(year = "2017_2018") %>%
  separate_rows(year, sep = "_") %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    x = longitude,
    y = latitude,
    date = ymd(paste0(year, "-01-01")),
    country = "India",
    irrigated = F,
    externalID = plotID,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    type = "areal",
    area = 50*10,
    presence = F,
    geometry = NA,
    externalValue = "Naturally regenerating forest",
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
