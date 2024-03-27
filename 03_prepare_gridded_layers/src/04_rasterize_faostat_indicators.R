# ----
# title        : rasterize faostat indicators
# authors      : Steffen Ehrmann
# version      : 0.4.0
# date         : 2024-03-27
# description  : This script builds rasters of all sort of national level
#                socio-economic indicator variables from FAOstat by downscaling
#                them to a 1km² grid.
# documentation: -
# ----
message("\n---- rasterise FAOstat indicators (at 1km²) ----")
# array <- as.integer(Sys.getenv('SLURM_ARRAY_TASK_ID'))
# targetYears <- targetYears[array]

# 1. make paths ----
#
if(!testDirectoryExists(paste0(dataDir,"processed/FAOSTAT_indicators"))){
  dir.create(paste0(dataDir,"processed/FAOSTAT_indicators"))
}

# 2. load data ----
#
message(" --> pull input files")
inFiles <- list.files(path = paste0(dataDir, "original/"))
if(!"FAOSTAT_indicators" %in% inFiles){
  untar(exdir = paste0(dataDir, "original/FAOSTAT_indicators"), tarfile = paste0(dataDir, "original/faostat_20220223.tar.xz"))
}
targetFiles <- list.files(path = paste0(dataDir, "original/FAOSTAT_indicators"), full.names = TRUE)
targetYears <- 1992:2019

# 3. data processing ----
#
## set up a template (for resolution and extent)
out <- list()

message(" --> extract indicators ...")
for(i in seq_along(targetFiles)){

  temp <- read_csv(file = targetFiles[i]) %>%
    arrange(Year) %>%
    filter(!Area %in% c("China", "USSR", "Yugoslav SFR")) %>%
    mutate(unit = case_when(
      Area == "Bolivia (Plurinational State of)" ~ "Bolivia",
      Area == "Brunei Darussalam" ~ "Brunei",
      Area == "China, mainland" ~ "China",
      Area == "China, Taiwan Province of" ~ "Taiwan",
      Area == "Congo" ~ "Republic of Congo",
      Area == "Czechia" ~ "Czech Republic",
      Area == "Czechoslovakia" ~ "Czech Republic",
      Area == "Ethiopia PDR" ~ "Ethiopia",
      Area == "French Polynesia" ~ "French Polynesia",
      Area == "Iran (Islamic Republic of)" ~ "Iran",
      Area == "North Macedonia" ~ "Macedonia",
      Area == "Republic of Korea" ~ "South Korea",
      Area == "Republic of Moldova" ~ "Moldova",
      Area == "Russian Federation" ~ "Russia",
      Area == "Syrian Arab Republic" ~ "Syria",
      Area == "United Kingdom of Great Britain and Northern Ireland" ~ "United Kingdom",
      Area == "United Republic of Tanzania" ~ "Tanzania",
      Area == "United States of America" ~ "United States",
      Area == "Venezuela (Bolivarian Republic of)" ~ "Venezuela",
      Area == "Viet Nam" ~ "Vietnam"),
      unit = if_else(!is.na(unit), unit, Area))

  if(str_detect(string = targetFiles[i], pattern = "Annual population")){

    temp <- temp %>%
      pivot_wider(id_cols = c(unit, Item, `Item Code`, Year),
                  names_from = Element,
                  values_from = Value) %>%
      mutate(Value = round(`Rural population` / `Total Population - Both sexes` * 100))

  } else if(str_detect(string = targetFiles[i], pattern = "Livestock Patterns")){

    temp <- temp %>%
      filter(`Element Code` == 7213)

  }

  # select the items that shall be mapped
  if(str_detect(string = targetFiles[i], pattern = "SDG Indicators", negate = TRUE)){

    temp <- temp %>%
      filter(`Item Code` %in% c(3102, 3103, 3104, 1107, 1126, 866, 1057, 1016,
                                1096, 1110, 976, 946, 1034, 6671, 6611, 1357, 3010))

  } else {

    temp <- temp %>%
      filter(`Item Code (SDG)` %in% c("SN_ITK_DEFC", "AG_PRD_AGVAS", "ER_H2O_STRESS", "AG_LND_FRSTBIOP")) %>%
      mutate(Value = as.numeric(Value))

  }

  # define usable names
  metrics <- unique(temp$Item)
  metricName <- case_when(metrics == "Nutrient nitrogen N (total)" ~ "NutrientNitrogenN",
                          metrics == "Nutrient phosphate P2O5 (total)" ~ "NutrientPhosphateP2O5",
                          metrics == "Nutrient potash K2O (total)" ~ "NutrientPotashK2O",
                          metrics == "Asses" ~ "lsuHaAsses",
                          metrics == "Camels" ~ "lsuHaCamels",
                          metrics == "Cattle" ~ "lsuHaCattle",
                          metrics == "Chickens" ~ "lsuHaChicken",
                          metrics == "Goats" ~ "lsuHaGoats",
                          metrics == "Horses" ~ "lsuHaHorses",
                          metrics == "Mules" ~ "lsuHaMules",
                          metrics == "Sheep" ~ "lsuHaSheep",
                          metrics == "Buffaloes" ~ "lsuHaBuffaloes",
                          metrics == "Pigs" ~ "lsuHaPigs",
                          metrics == "Agriculture area under organic agric." ~ "propAgrOrg",
                          metrics == "Agriculture area actually irrigated" ~ "propAgrIrr",
                          metrics == "Pesticides (total)" ~ "pesticideDensity",
                          metrics == "Population - Est. & Proj." ~ "propPopRur",
                          metrics == "6.4.2 Level of water stress: freshwater withdrawal as a proportion of available freshwater resources (%)" ~ "propFreshwaterWithdr",
                          metrics == "15.2.1 Above-ground biomass stock in forest (tonnes per hectare)" ~ "agBiomassDensity",
                          metrics == "2.1.1 Prevalence of undernourishment (%)" ~ "propUndernurish",
                          metrics == "2.a.1 Agriculture value added share of GDP (%)" ~ "propAgrValueAdded")

  for(j in seq_along(metrics)){

    message("   ...'", metricName[j], "'")

    thisMetric <- temp %>%
      filter(Item == metrics[j]) %>%
      filter(Year %in% targetYears)

    if(dim(thisMetric)[1] == 0){
      next
    }

    thisMetric <- thisMetric %>%
      pivot_wider(id_cols = unit, values_from = Value, names_from = Year) %>%
      full_join(countries %>% select(unit, ahID), thisMetric, by = "unit") %>%
      select(-unit)

    for(k in targetYears){

      if(!as.character(k) %in% names(thisMetric)){
        next
      }

      message("     ...'", k, "'")

      reclass <- thisMetric %>%
        select(ahID, val = as.character(k)) %>%
        mutate(ahID = as.numeric(ahID),
               val = replace_na(val, -99))

      # out <- c(out, setNames(object = list(reclass), nm = paste0(metricName[j], " - ", k)))

      classify(x = rast(x = paste0(dataDir, "processed/GADM/GADM_simple-level1_20190000.tif")),
               rcl = reclass,
               filename = paste0(dataDir, "processed/FAOSTAT_indicators/FAOSTAT_indicators-", metricName, "_", k, "0000_1km.tif"),
               filetype = "GTiff",
               gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"),
               overwrite = TRUE)
    }

    # beep(sound = 2)
  }

  # beep(sound = 10)
}

# 4. write output ----
#
write_rds(x = _INSERT, file = _INSERT)

# beep(sound = 10)
message("\n     ... done")
