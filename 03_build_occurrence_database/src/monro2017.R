# script arguments ----
#
thisDataset <- "Monro2017"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1744742949.bib"))

regDataset(name = thisDataset,
           description = "Effective vegetation classification schemes identify the processes determining species assemblages and support the management of protected areas. They can also provide a framework for ecological research. In the tropics, elevation-based classifications dominate over alternatives such as river catchments. Given the existence of floristic data for many localities, we ask how useful floristic data are for developing classification schemes in species-rich tropical landscapes and whether floristic data provide support for classification by river catchment. We analyzed the distribution of vascular plant species within 141 plots across an elevation gradient of 130 to 3200 m asl within La Amistad National Park. We tested the hypothesis that river catchment, combined with elevation, explains much of the variation in species composition. We found that annual mean temperature, elevation, and river catchment variables best explained the variation within local species communities. However, only plots in high-elevation oak forest and Páramo were distinct from those in low- and mid-elevation zones. Beta diversity did not significantly differ in plots grouped by elevation zones, except for low-elevation forest, although it did differ between river catchments. None of the analyses identified discrete vegetation assemblages within mid-elevation (700–2600 m asl) plots. Our analysis supports the hypothesis that river catchment can be an alternative means for classifying tropical forest assemblages in conservation settings.",
           url = "https://doi.org/10.1111/btp.12470",
           download_date = "2022-01-11",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "no",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Data matrix.xlsx"), sheet = 4)

# harmonise data ----
#

temp <- data %>%
  mutate(
    year = "2003_2004_2005_2006_2007_2008_2009") %>%
  separate_rows(year, sep = "_") %>%
  mutate(
    fid = row_number(),
    x = LONG,
    y = LAT,
    geometry = NA,
    area = 7853.98,
    type = "areal",
    presence = F,
    year = as.numeric(year),
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    country = PAIS,
    irrigated = F,
    externalID = as.character(PLOT_ID),
    externalValue = "Undisturbed Forest",
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
