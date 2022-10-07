# script arguments ----
#
allFiles <- selectCols <- NULL


# set paths ----
#
incomingDir <- paste0(DBDir, "incoming/per_dataseries/eurostat/")
if(!testDirectoryExists(incomingDir)){
  dir.create(incomingDir)
}


# load metadata ----
#
# to the ontology
animals <- get_eurostat_dic(dictname = "animals") %>%
  rename(animals = code_name, new_animals = full_name)
crops <- get_eurostat_dic(dictname = "crops") %>%
  rename(crops = code_name, new_crops = full_name)

# to the gazetteer
geo <- get_eurostat_dic(dictname = "geo") %>%
  rename(geo = code_name, new_geo = full_name)

# other variables
arable <- get_eurostat_dic(dictname = "arable") %>%
  rename(arable = code_name, new_arable = full_name)
units <- get_eurostat_dic(dictname = "unit") %>%
  rename(unit = code_name, new_unit = full_name)
strucpro <- get_eurostat_dic(dictname = "strucpro") %>%
  rename(strucpro = code_name, new_strucpro = full_name)
hatchitm <- get_eurostat_dic(dictname = "hatchitm") %>%
  rename(hatchitm = code_name, new_hatchitm = full_name)
indic_co <- get_eurostat_dic(dictname = "indic_co") %>%
  rename(indic_co = code_name, new_indic_co = full_name)
indic_fo <- get_eurostat_dic(dictname = "indic_fo") %>%
  rename(indic_fo = code_name, new_indic_fo = full_name)
areaprot <- get_eurostat_dic(dictname = "areaprot") %>%
  rename(areaprot = code_name, new_areaprot = full_name)
landcover <- get_eurostat_dic(dictname = "landcover") %>%
  rename(landcover = code_name, new_landcover = full_name)
landuse <- get_eurostat_dic(dictname = "landuse") %>%
  rename(landuse = code_name, new_landuse = full_name)
crop_pro <- get_eurostat_dic(dictname = "crop_pro") %>%
  rename(crop_pro = code_name, new_crop_pro = full_name)
la <- get_eurostat_dic(dictname = "la") %>%
  rename(la = code_name, new_la = full_name)
density <- get_eurostat_dic(dictname = "density") %>%
  rename(density = code_name, new_density = full_name)
age <- get_eurostat_dic(dictname = "age") %>%
  rename(age = code_name, new_age = full_name)
fruitvar <- get_eurostat_dic(dictname = "fruitvar") %>%
  rename(fruitvar = code_name, new_fruitvar = full_name)
agrarea <- get_eurostat_dic(dictname = "agrarea") %>%
  rename(agrarea = code_name, new_agrarea = full_name)
variable <- get_eurostat_dic(dictname = "variable") %>%
  rename(variable = code_name, new_variable = full_name)
croparea <- get_eurostat_dic(dictname = "croparea") %>%
  rename(croparea = code_name, new_croparea = full_name)
freq <- get_eurostat_dic(dictname = "freq") %>%
  rename(freq = code_name, new_freq = full_name)
lsu <- get_eurostat_dic(dictname = "lsu") %>%
  rename(lsu = code_name, new_lsu = full_name)
farmtype <- get_eurostat_dic(dictname = "farmtype") %>%
  rename(farmtype = code_name, new_farmtype = full_name)
so_eur <- get_eurostat_dic(dictname = "so_eur") %>%
  rename(so_eur = code_name, new_so_eur = full_name)
indic_ef <- get_eurostat_dic(dictname = "indic_ef") %>%
  rename(indic_ef = code_name, new_indic_ef = full_name)


# load data ----
#
allInput <- list.files(incomingDir, pattern = "tsv.gz")

# this should contain the following tables:
#
# name              description                                                 NUTS lvl  years
# agr_r_animal      Animal populations by NUTS 2 regions                        2         1977 - today
# apro_ec_poula     Poultry - annual data                                       1         1967 - today
# apro_cpnhr        Crop production by NUTS 2 regions                           2         2000 - today
# apro_cpnhr_h      Crop production by NUTS 2 regions - historical data         2         1975 - 1999
# for_area          Area of wooded land                                         1         1990 - 2020
# for_profnc        Protective functions of forests                             1         1990 - 2015
# for_protect       Protected forests                                           1         1990 - 2015
# lan_lcv_art       Land covered by artificial surfaces by NUTS 2 regions       2         2009 - 2018
# lan_lcv_fao       Land cover for FAO Forest categories by NUTS 2 regions      2         2009 - 2018
# lan_lcv_ovw       Land cover overview by NUTS 2 regions                       2         2009 - 2018
# lan_use_ovw       Land use overview by NUTS 2 regions                         2         2009 - 2018
# cpc_agmain        Candidate countries and potential candidates: agricultural  ?         2005 - 2019
# enpe_apro_cpnh1   ENP-East Crop production                                    1         2005 - 2020
# enpe_apro_mt_ls   ---: Livestock                                              1         2005 - 2020
# enpe_ef_lus_main  ---: Main farm land use                                     1         2005 - 2021
# enpr_agmain       ---: agricultural - historical data                         1         2005 - 2019
# enps_apro_cpnh1   ENP-South Crop production                                   1         2005 - 2020
# enps_apro_mt_ls   ---: Livestock                                              1         2005 - 2020
# enps_ef_lus_main  ---: Main farm land use                                     1         2005 - 2020
# med_ag2           ---: Crop production - historical data                      1         2005 - 2019
# med_ag33          ---: Livestock - historical data                            1         2005 - 2018
# med_ag34          ---: Poultry farming - historical data                      1         2005 - 2018
# med_en62          ---: Forest and irrigated land - historical data            1         2005 - 2019
# orch_apples1      Apple and pears trees (area in ha)                          2         2002 - 2017
# orch_grapes1      Table grape vines (area in ha)                              2         2012 - 2017
# orch_olives1      Olive trees (area in ha)                                    2         2012 - 2017
# orch_oranges1     Orange, lemon and small citrus fruit trees (area in ha)     2         2002 - 2017
# orch_peach1       Peach and apricot trees (area in ha)                        2         2012 - 2017
# ef_lu_ovcropaa    Farmland: number of farms and areas                         2         1990 - 2007
# ef_ls_ovaareg     Livestock: number of farms and heads                        2         1990 - 2007
# ef_lu_ofirrig     Irrigation: number of farms, areas                          2         1990 - 2007
# ef_lu_ofsetasid   Fallow land and set-aside land: number of farms and areas   1         1990 - 2007
# ef_oluaareg       Land use: number of farms and areas                         2         2005 - 2013
# ef_olsaareg       Livestock: number of farms and heads                        2         2005 - 2013
# ef_lus_main       Main farm land use by NUTS 2 regions                        2         2013 - 2016
# ef_lsk_main       Main livestock indicators                                   2         2013 - 2016
# ef_lus_allcrops   Crops by classes of utilised agricultural area              2         2013 - 2016
# ef_lus_spare      Special areas and other farmland                            2         2013 - 2016


# data processing ----
#
for(i in seq_along(allInput)){

  theInput <- allInput[i]
  theName <- str_split(theInput, pattern = "[.]")[[1]][1]
  theName <- str_replace_all(theName, "_", "")
  temp <- read_tsv(paste0(incomingDir, theInput))

  targetCols <- colnames(temp)[1]
  targetCols <- str_split(string = targetCols, pattern = "\\\\")[[1]][1]
  targetCols <- str_split(targetCols, ",")[[1]]

  temp <- temp %>%
    separate(col = 1, into = targetCols, sep = ",") %>%
    filter(!str_detect(string = geo, pattern = "EU"))

  selectCols <- NULL

  # go through all possible column names of interest and join the respective
  # look-up-table (or write to the ontology/gazetteer)
  if("animals" %in% colnames(temp)){
    temp <- temp %>%
      left_join(animals, by = "animals")
    # animals -> luckiOnto
    selectCols <- c(selectCols, "animals", "new_animals")
  }

  if("crops" %in% colnames(temp)){
    temp <- temp %>%
      left_join(crops, by = "crops")
    # crops -> luckiOnto
    selectCols <- c(selectCols, "crops", "new_crops")
  }

  if("indic_fo" %in% colnames(temp)){
    temp <- temp %>%
      left_join(indic_fo, by = "indic_fo")
    # indic_fo -> luckiOnto
    selectCols <- c(selectCols, "indic_fo", "new_indic_fo")
  }

  if("indic_co" %in% colnames(temp)){
    temp <- temp %>%
      left_join(indic_co, by = "indic_co")
    # indic_co -> luckiOnto
    selectCols <- c(selectCols, "indic_co", "new_indic_co")
  }

  if("indic_ef" %in% colnames(temp)){
    temp <- temp %>%
      left_join(indic_ef, by = "indic_ef")
    # indic_ef -> luckiOnto
    selectCols <- c(selectCols, "indic_ef", "new_indic_ef")
  }

  if("landcover" %in% colnames(temp)){
    temp <- temp %>%
      left_join(landcover, by = "landcover")
    # landcover -> luckiOnto
    selectCols <- c(selectCols, "landcover", "new_landcover")
  }

  if("landuse" %in% colnames(temp)){
    temp <- temp %>%
      left_join(landuse, by = "landuse")
    # landuse -> luckiOnto
    selectCols <- c(selectCols, "landuse", "new_landuse")
  }

  if("crop_pro" %in% colnames(temp)){
    temp <- temp %>%
      left_join(crop_pro, by = "crop_pro")
    # crop_pro -> luckiOnto
    selectCols <- c(selectCols, "crop_pro", "new_crop_pro")
  }

  if("fruitvar" %in% colnames(temp)){
    temp <- temp %>%
      left_join(fruitvar, by = "fruitvar")
    # fruitvar -> luckiOnto
    selectCols <- c(selectCols, "fruitvar", "new_fruitvar")
  }

  if("variable" %in% colnames(temp)){
    temp <- temp %>%
      left_join(variable, by = "variable")
    # variable -> luckiOnto
    selectCols <- c(selectCols, "variable", "new_variable")
  }

  if("geo" %in% colnames(temp)){
    temp <- temp %>%
      left_join(geo, by = "geo")
    # geo -> gazetteer
    selectCols <- c(selectCols, "geo", "new_geo")
  }

  if("unit" %in% colnames(temp)){
    temp <- temp %>%
      left_join(units, by = "unit")
    selectCols <- c(selectCols, "unit", "new_unit")
  }

  if("strucpro" %in% colnames(temp)){
    temp <- temp %>%
      left_join(strucpro, by = "strucpro")
    selectCols <- c(selectCols, "strucpro", "new_strucpro")
  }

  if("hatchitm" %in% colnames(temp)){
    temp <- temp %>%
      left_join(hatchitm, by = "hatchitm")
    selectCols <- c(selectCols, "hatchitm", "new_hatchitm")
  }

  if("areaprot" %in% colnames(temp)){
    temp <- temp %>%
      left_join(areaprot, by = "areaprot")
    selectCols <- c(selectCols, "areaprot", "new_areaprot")
  }

  if("la" %in% colnames(temp)){
    temp <- temp %>%
      left_join(la, by = "la")
    selectCols <- c(selectCols, "la", "new_la")
  }

  if("density" %in% colnames(temp)){
    temp <- temp %>%
      left_join(density, by = "density")
    selectCols <- c(selectCols, "density", "new_density")
  }

  if("age" %in% colnames(temp)){
    temp <- temp %>%
      left_join(age, by = "age")
    selectCols <- c(selectCols, "age", "new_age")
  }

  if("agrarea" %in% colnames(temp)){
    temp <- temp %>%
      left_join(agrarea, by = "agrarea")
    selectCols <- c(selectCols, "agrarea", "new_agrarea")
  }

  if("arable" %in% colnames(temp)){
    temp <- temp %>%
      left_join(arable, by = "arable")
    selectCols <- c(selectCols, "arable", "new_arable")
  }

  if("freq" %in% colnames(temp)){
    temp <- temp %>%
      left_join(freq, by = "freq")
    selectCols <- c(selectCols, "freq", "new_freq")
  }

  if("lsu" %in% colnames(temp)){
    temp <- temp %>%
      left_join(lsu, by = "lsu")
    selectCols <- c(selectCols, "lsu", "new_lsu")
  }

  if("farmtype" %in% colnames(temp)){
    temp <- temp %>%
      left_join(farmtype, by = "farmtype")
    selectCols <- c(selectCols, "farmtype", "new_farmtype")
  }

  if("so_eur" %in% colnames(temp)){
    temp <- temp %>%
      left_join(so_eur, by = "so_eur")
    selectCols <- c(selectCols, "so_eur", "new_so_eur")
  }

  temp <- temp %>%
    select(all_of(selectCols), everything()) %>%
    mutate(ah_level = if_else(nchar(geo) == 2, 1, if_else(nchar(geo) == 3, 2, 3)))

  maxLvl <- max(temp$ah_level)
  rngYears <- range(as.numeric(colnames(temp)), na.rm = TRUE)

  temp <- temp %>%
    filter(ah_level == maxLvl) %>%
    select(-ah_level)

  # handle some special cases (they are so special!)
  if(theInput == "cpc_agmain.tsv.gz"){
    temp <- temp %>%
      mutate(indic_key = case_when(str_detect(string = new_indic_co, pattern = "Crop production \\(harvested production\\):(.?)*") ~ "crop_production",
                                   str_detect(string = new_indic_co, pattern = "Livestock \\(December\\):(.?)*") ~ "livestock",
                                   str_detect(string = new_indic_co, pattern = "(.?)*\\(Thousand hectare\\)") ~ "area",
                                   TRUE ~ "other")) %>%
      select(indic_co, new_indic_co, indic_key, everything())

  } else if(theInput == "enpr_agmain.tsv.gz"){
    temp <- temp %>%
      mutate(indic_key = case_when(str_detect(string = new_indic_co, pattern = "Crop production \\(harvested production\\):(.?)*") ~ "crop_production",
                                   str_detect(string = new_indic_co, pattern = "Livestock \\(December\\):(.?)*") ~ "livestock",
                                   str_detect(string = new_indic_co, pattern = "(.?)*\\(Thousand hectare\\)") ~ "area",
                                   TRUE ~ "other")) %>%
      select(indic_co, new_indic_co, indic_key, everything())
  }

  if(dim(temp)[1] != 0){
    write_csv(x = temp, file = paste0(DBDir, "adb_tables/stage2/", "eur_", maxLvl, "_", theName, "_", rngYears[1], "_", rngYears[2], "_eurostat.csv"), na = "NA")
  }

}


# write output ----
#
