# script arguments ----
#
thisDataset <- "Vieilledent2016"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_13652745104.bib"))

regDataset(name = thisDataset,
           description = "Recent studies have underlined the importance of climatic variables in determining tree height and biomass in tropical forests. Nonetheless, the effects of climate on tropical forest carbon stocks remain uncertain. In particular, the application of process-based dynamic global vegetation models has led to contrasting conclusions regarding the potential impact of climate change on tropical forest carbon storage. Using a correlative approach based on a bioclimatic envelope model and data from 1771 forest plots inventoried during the period 1996–2013 in Madagascar over a large climatic gradient, we show that temperature seasonality, annual precipitation and mean annual temperature are key variables in determining forest above-ground carbon density. Taking into account the explicative climate variables, we obtained an accurate (R2 = 70% and RMSE = 40 Mg ha−1) forest carbon map for Madagascar at 250 m resolution for the year 2010. This national map was more accurate than previously published global carbon maps (R2 ≤ 26% and RMSE ≥ 63 Mg ha−1). Combining our model with the climatic projections for Madagascar from 7 IPCC CMIP5 global climate models following the RCP 8.5, we forecast an average forest carbon stock loss of 17% (range: 7–24%) by the year 2080. For comparison, a spatially homogeneous deforestation of 0.5% per year on the same period would lead to a loss of 30% of the forest carbon stock. Synthesis. Our study shows that climate change is likely to induce a decrease in tropical forest carbon stocks. This loss could be due to a decrease in the average tree size and to shifts in tree species distribution, with the selection of small-statured species. In Madagascar, climate-induced carbon emissions might be, at least, of the same order of magnitude as emissions associated with anthropogenic deforestation.",
           url = "https://doi.org/10.1111/1365-2745.12548",
           type = "static",
           licence = "",
           bibliography = bib,
           download_date = "2021-12-17",
           contact = "see corresponding author",
           disclosed = "yes",
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "ACD.csv"))


# harmonise data ----
#

temp <- data %>%
  separate(DATE, c("month", "year")) %>%
  mutate(
    x = LON,
    y = LAT,
    date = ymd(paste0(year,"-", month, "-01")),
    country = "Madagascar",
    irrigated = F,
    externalID = PLOT_ID,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    type = "point",
    presence = F,
    area = NA_real_,
    geometry = NA,
    epsg = 4326,
    datasetID = thisDataset,
    externalValue = "Forests",
    fid = row_number()) %>%
    select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


  # write output ----
  #
  validateFormat(object = temp) %>%
    saveDataset(dataset = thisDataset)
  write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

  message("\n---- done ----")
