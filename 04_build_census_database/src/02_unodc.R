# ----
# geography : Global
# period    : 1990 - 2020
# dataseries: United Nations Office on Drugs and Crime (https://www.unodc.org/unodc/en/crop-monitoring/index.html)
# variables :
#   - land      : -
#   - crops     : hectares_planted, tons_produced, kiloPerHectare_yield
#   - livestock : -
#   - technology: -
#   - social    : -
# sampling  : survey
# spatial   : GADM0, GADM1, GADM2, GADM3
# authors   : Steffen Ehrmann
# date      : 2024-03-27
# status    : validate, normalize, done
# comment   : only illicit crops
# ----

ds <- c("unodc")
gs <- c("gadm")


# 1. register dataseries ----
#
regDataseries(name = ds[1],
              description = "UNODC and Illicit Crop Monitoring",
              homepage = "https://www.unodc.org/unodc/en/crop-monitoring/index.html",
              licence_link = "unknown",
              licence_path = "not available")


# 2. register geometries ----
#


# 3. register census tables ----
#
if(build_crops){
  ## crops ----

  ### Afghanistan ----
  schema_afg_10 <-
    setFormat(thousand = ".") %>%
    setFilter(rows = .find("Total", col = 2, invert = TRUE)) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "al3", columns = 2) %>%
    setIDVar(name = "year", rows = 1, columns = c(3:18)) %>%
    setIDVar(name = "commodities", value = "poppy") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(3:18))

  regTable(nation = "afg",
           level = 3,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_afg_10,
           begin = 1994,
           end = 2009,
           archive = "Afgh-opiumsurvey2009_web.pdf|p.140-147",
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_afg_11 <- schema_afg_10 %>%
    setFormat(thousand = ",") %>%
    setIDVar(name = "year", rows = 1, columns = c(3:13)) %>%
    setObsVar(name = "planted", unit = "ha", columns = c(3:13))

  regTable(nation = "afg",
           level = 3,
           subset = "plantedPoppyTwo",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_afg_11,
           begin = 2010,
           end = 2020,
           archive = "20210503_Executive_summary_Opium_Survey_2020_SMALL.pdf|p.14-21",
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_afg_12 <-
    setFilter(rows = c(38:44), invert = TRUE) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", rows = 3, columns = c(2:15)) %>%
    setIDVar(name = "commodities", value = "poppy") %>%
    setObsVar(name = "production", unit = "t", columns = c(2:15))

  regTable(nation = "afg",
           level = 2,
           subset = "productionOpium",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_afg_12,
           begin = 2005,
           end = 2018,
           archive = "production_afgha_opium_2005_2018_lvl2.csv", # can't find the original pdf file containing this data
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_afg_13 <-
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "al3", columns = 2) %>%
    setIDVar(name = "year", value = "2001") %>%
    setIDVar(name = "commodities", value = "poppy") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5) %>%
    setObsVar(name = "yieldIrrigated", unit = "kg/ha", columns = 6) %>%
    setObsVar(name = "yieldRainFed", unit = "kg/ha", columns = 7) %>%
    setObsVar(name = "production", unit = "t", factor = 0.001, columns = 10)

  regTable(nation = "afg",
           level = 3,
           subset = "plantProdYield",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_afg_13,
           begin = 2001,
           end = 2001,
           archive = "production_afgha_opium_2001.csv", # can't find the original pdf file containing this data
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_afg_14 <- schema_afg_13 %>%
    setFormat(thousand = ",") %>%
    setFilter(rows = .find("...Result", col = 1), invert = TRUE) %>%
    setIDVar(name = "year", value = "2000") %>%
    setIDVar(name = "commodities", value = "poppy")

  regTable(nation = "afg",
           level = 3,
           subset = "plantProdYield",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_afg_14,
           begin = 2000,
           end = 2000,
           archive = "production_afgha_opium_2000.csv", # can't find the original pdf file containing this data
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Bolivia-----
  # Province "Caranavi" is a part of Nor Yungas in gadm database. I have translated it into Nor Yungas, as it is the only problem with the dataset.
  # In gadm Caranavi is level 4.
  schema_bol_unodc_01 <-
    setFormat(thousand = ".") %>%
    setFilter(rows = .find(pattern = "Total", invert = TRUE)) %>%
    setIDVar(name = "al3", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:12)) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:12))

  regTable(nation = "Bolivia",
           label = "al3",
           subset = "plantedCocaLaPaz",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bol_unodc_01,
           begin = 2009,
           end = 2019,
           archive = "Bolivia_Informe_Monitoreo_Coca_2019.pdf|p.39",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Bolivia/Bolivia_Informe_Monitoreo_Coca_2018_web.pdf",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_bol_unodc_02 <-
    setFormat(thousand = ".") %>%
    setFilter(rows = .find(pattern = "TOTAL", col = 1, invert = TRUE)) %>%
    setIDVar(name = "al3", columns = 1) %>%
    setIDVar(name = "al4", columns = 2) %>%
    setIDVar(name = "year", rows = 1, columns = c(3:9)) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(3:9))

  regTable(nation = "Bolivia",
           level = 4,
           subset = "plantedCocaLaPaz",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bol_unodc_02,
           begin = 2002,
           end = 2008,
           archive = "Bolivia_Coca_Survey_for2008_En.pdf.pdf|p.19",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Bolivia/Bolivia_Coca_Survey_for2008_En.pdf.pdf",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/documents/crop-monitoring/Bolivia/Bolivia_Coca_Survey_for2008_En.pdf.pdf",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_bol_unodc_03 <-
    setFormat(thousand = ".") %>%
    setFilter(rows = .find(pattern = "Total", col = 1, invert = TRUE)) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "al3", columns = 2) %>%
    setIDVar(name = "year", rows = 1, columns = c(3:13)) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(3:13))

  regTable(nation = "Bolivia",
           label = "al3",
           subset = "plantedCocaCochabambaBeni",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bol_unodc_03,
           begin = 2009,
           end = 2019,
           archive = "Bolivia_Informe_Monitoreo_Coca_2019.pdf|p.44",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Bolivia/Bolivia_Informe_Monitoreo_Coca_2018_web.pdf",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_bol_unodc_04 <-
    setFormat(thousand = ".") %>%
    setFilter(rows = .find(pattern = "..Total", col = 1, invert = TRUE)) %>%
    setIDVar(name = "al3", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:7)) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:7))

  regTable(nation = "Bolivia",
           label = "al3",
           subset = "plantedCocaCochabamba",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bol_unodc_04,
           begin = 2003,
           end = 2008,
           archive = "Bolivia_Coca_Survey_for2008_En.pdf.pdf|p.28",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Bolivia/Bolivia_Coca_Survey_for2008_En.pdf.pdf",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_bol_unodc_05 <-
    setFormat(thousand = ",") %>%
    setIDVar(name = "al1", value = "Bolivia") %>%
    setIDVar(name = "year", rows = 1, columns = c(2:12)) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:12))

  regTable(nation = "Bolivia",
           label = "al1",
           subset = "plantedCocaBolivia",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bol_unodc_05,
           begin = 1994,
           end = 2004,
           archive = "Andean-coca-June05.pdf|p.34",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Andean-coca-June05.pdf",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_bol_unodc_06 <-
    setFilter(rows = c(3:6)) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", columns = c(2:5), rows = 3) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", value = "coca") %>%
    setObsVar(name = "production", unit = "t", columns = c(2:5))

  regTable(nation = "Bolivia",
           label = "al2",
           subset = "productionCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bol_unodc_06,
           begin = 2010,
           end = 2013,
           archive = "production_bolivia_coca_lvl2_2012_2013_unit(mt).csv", # can't find the original pdf file containing this data
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_bol_unodc_07 <-
    setFilter(rows = .find(pattern = "Total..", col = 1, invert = TRUE)) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", value = "2014") %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", value = "coca") %>%
    setObsVar(name = "production", unit = "t", columns = 4) %>%
    setObsVar(name = "planted", unit = "ha", columns = 2) %>%
    setObsVar(name = "yield", unit = "kg/ha", columns = 3)

  regTable(nation = "Bolivia",
           label = "al2",
           subset = "productionCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bol_unodc_07,
           begin = 2014,
           end = 2014,
           archive = "production_bolivia_coca_lvl2_2014_unit(mt).csv", # can't find the original pdf file containing this data
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_bol_unodc_08 <-
    setFilter(rows = .find(pattern = "Bolivia", col = 1)) %>%
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "year", columns = c(2:12), rows = 1) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", value = "coca") %>%
    setObsVar(name = "production", unit = "t", columns = c(2:12))

  regTable(nation = "Bolivia",
           label = "al1",
           subset = "productionCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bol_unodc_08,
           begin = 1994,
           end = 2004,
           archive = "production_bolivia_peru_colombia_cocaine_lvl3_1994_2004_unit(mt).csv", # can't find the original pdf file containing this data
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Colombia----
  schema_col_01 <-
    setFormat(thousand = ".") %>%
    setFilter(rows = .find("Total..", col = 1), invert = TRUE) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:11)) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:11))

  regTable(nation = "col",
           level = 2,
           subset = "plantedCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_col_01,
           begin = 2010,
           end = 2019,
           archive = "Colombia_Monitoreo_Cultivos_Ilicitos_2019.pdf|p.166",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Colombia/Colombia_Monitoreo_Cultivos_Ilicitos_2019.pdf",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Colombia",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_col_02 <-
    setFormat(thousand = ".") %>%
    setFilter(rows = c(26:29), invert = TRUE) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:7)) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:7))

  regTable(nation = "col",
           level = 2,
           subset = "plantedCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_col_02,
           begin = 2004,
           end = 2009,
           archive = "Colombia-Censo-2009-web.pdf|p.16",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Colombia/Colombia-Censo-2009-web.pdf",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Colombia",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_col_03 <-
    setFilter(rows = c(24:29), invert = TRUE) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:6)) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:6))

  regTable(nation = "col",
           level = 2,
           subset = "plantedCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_col_03,
           begin = 1999,
           end = 2004,
           archive = "Part3_Colombia.pdf|p.17",
           archiveLink = "https://www.unodc.org/pdf/andean/Part3_Colombia.pdf",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Colombia",
           metadataPath = "unknown",
           overwrite = TRUE)

  # Trying to set the schema to put down for al1 "total" from the table to make it work.
  # tried to use cluster argument to make it work. still no success
  schema_col_04 <- #setCluster(id = "al1", left = 1, top = 2) %>%
    setIDVar(name = "al1", value = "Colombia") %>%
    setIDVar(name = "year", rows = 1, columns = c(2:12)) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:12))

  regTable(nation = "col",
           level = 1,
           subset = "plantedCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_col_04,
           begin = 1994,
           end = 2004,
           archive = "Andean-coca-June05.pdf|p.101",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Andean-coca-June05.pdf",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Colombia",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_col_05 <-
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:16)) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", value = "poppy") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:16))

  regTable(nation = "col",
           level = 2,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_col_05,
           begin = 2002,
           end = 2016,
           archive = "Poppy crops in Colombia, by department, in hectares, 2002 – 2016.csv", # can't find the pdf document containing this data
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Colombia",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Colombia",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Laos ----
  schema_lao_02 <- setCluster(id = "al1", left = 1, top = 3) %>%
    setIDVar(name = "al1", value = "Laos") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", value = "poppy") %>%
    setObsVar(name = "planted", unit = "ha", columns = 2)

  regTable(nation = "lao",
           level = 1,
           subset = "plantedOpium",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_lao_02,
           begin = 1992,
           end = 2015,
           archive = "Southeast_Asia_Opium_Survey_2015_web.pdf|p.17",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/sea/Southeast_Asia_Opium_Survey_2015_web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_lao_03 <- setCluster(id = "commodities", left = 1, top = 3) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", rows = 3, columns = c(2:10)) %>%
    setIDVar(name = "commodities", value = "poppy") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:10))

  regTable(nation = "lao",
           level = 2,
           subset = "plantedOpium",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_lao_03,
           begin = 1992,
           end = 2015,
           archive = "cultivation_opium_laos_lvl2_1992_2015.csv", # can't find the original pdf file containing this data
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Lao%20PDR",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_lao_04 <-
    setFormat(decimal = ",") %>%
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 4) %>%
    setIDVar(name = "year", value = "2002") %>%
    setIDVar(name = "commodities", value = "poppy") %>%
    setObsVar(name = "planted", unit = "ha", columns = 6) %>%
    setObsVar(name = "yield", unit = "kg/ha", columns = 7) %>%
    setObsVar(name = "production", unit = "t", factor = 0.001, columns = 9)

  regTable(nation = "lao",
           level = 3,
           subset = "planYieldProdOpuim",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_lao_04,
           begin = 2002,
           end = 2002,
           archive = "prod_yield_culti_laos_lvl3_2002.csv", # can't find the original pdf file containing this data
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Lao%20PDR",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_lao_05 <- setCluster(id = "al1", left = 1, top = 4) %>%
    setIDVar(name = "al1", value = "Laos") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", value = "opium") %>%
    setObsVar(name = "production", unit = "t", columns = 2)

  regTable(nation = "lao",
           level = 1,
           subset = "productionOpium",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_lao_05,
           begin = 1992,
           end = 2015,
           archive = "production_opium_laos_lvl1.csv", # can't find the original pdf file containing this data
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Lao%20PDR",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite  = TRUE)

  schema_lao_06 <- setCluster(id = "commodities", left = 1, top = 2) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", rows = 2, columns = c(2:7)) %>%
    setIDVar(name = "commodities", value = "opium") %>%
    setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:7))

  regTable(nation = "lao",
           level = 2,
           subset = "productionOpium",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_lao_06,
           begin = 1992,
           end = 2002,
           archive = "production_opium_laos_lvl2_1992_2002.csv", # can't find the original pdf file containing this data
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Lao%20PDR",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_lao_07 <- setCluster(id = "al1", left = 1, top = 3) %>%
    setIDVar(name = "al1", value = "Laos") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", value = "opium") %>%
    setObsVar(name = "yield", unit = "kg/ha", columns = 2)

  regTable(nation = "lao",
           level = 1,
           subset = "yieldOpium",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_lao_07,
           begin = 1992,
           end = 2005,
           archive = "yield_opium_laos_lvl1_1992_2005.csv",
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Lao%20PDR",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Morocco ----
  schema_mar_01 <-
    setFilter(rows = .find("Total", col = 1), invert = TRUE) %>%
    setIDVar(name = "al3", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2,4)) %>%
    setIDVar(name = "commodities", value = "cannabis") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2,4))

  regTable(nation = "mar",
           level = 3,
           subset = "plantedCanabis",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mar_01,
           begin = 2003,
           end = 2005,
           archive = "Morocco_survey_2005.pdf|p.10",
           archiveLink = "https://www.unodc.org/pdf/research/Morocco_survey_2005.pdf",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Morocco",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Myanmar ----
  schema_mmr_01 <-
    setFormat(thousand = ",") %>%
    setIDVar(name = "al1", value = "Myanmar") %>%
    setIDVar(name = "year", columns = c(1:17), rows = 1) %>%
    setIDVar(name = "commodities", value = "poppy") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(1:17))

  regTable(nation = "mmr",
           level = 1,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mmr_01,
           begin = 1990,
           end = 2006,
           archive = "Golden_triangle_2006.pdf|p.77",
           archiveLink = "https://www.unodc.org/pdf/research/Golden_triangle_2006.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_mmr_02 <-
    setFormat(thousand = ",") %>%
    setIDVar(name = "al1", value = "Myanmar") %>%
    setIDVar(name = "year", columns = c(1:14), rows = 1) %>%
    setIDVar(name = "commodities", value = "poppy") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(1:14))

  regTable(nation = "mmr",
           level = 1,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mmr_02,
           begin = 2007,
           end = 2020,
           archive = "Myanmar_Opium_survey_2020.pdf",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Myanmar/Myanmar_Opium_survey_2020.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_mmr_03 <-
    setFormat(thousand = ",") %>%
    setFilter(rows = .find("total", col = 1), invert = TRUE) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:3)) %>%
    setIDVar(name = "commodities", value = "poppy") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:3), relative = TRUE)

  regTable(nation = "mmr",
           level = 2,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mmr_03,
           begin = 2019,
           end = 2020,
           archive = "Myanmar_Opium_survey_2020.pdf|p.18",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Myanmar/Myanmar_Opium_survey_2020.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(nation = "mmr",
           level = 2,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mmr_03,
           begin = 2014,
           end = 2015,
           archive = "Southeast_Asia_Opium_Survey_2015_web.pdf|p.40",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/sea/Southeast_Asia_Opium_Survey_2015_web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(nation = "mmr",
           level = 2,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mmr_03,
           begin = 2012,
           end = 2013,
           archive = "SEA_Opium_Survey_2013_web.pdf|p.54",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/sea/SEA_Opium_Survey_2013_web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(nation = "mmr",
           level = 2,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mmr_03,
           begin = 2010,
           end = 2011,
           archive = "SouthEastAsia_2011_web.pdf|p.52",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/sea/SouthEastAsia_2011_web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_mmr_04 <- schema_mmr_03 %>%
    setFilter(rows = .find("Total", col = 1), invert = TRUE)

  regTable(nation = "mmr",
           level = 2,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mmr_04,
           begin = 2017,
           end = 2018,
           archive = "Myanmar_Opium_Survey_2018-web.pdf|p.22",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Myanmar/Myanmar_Opium_Survey_2018-web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(nation = "mmr",
           level = 2,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mmr_04,
           begin = 2005,
           end = 2006,
           archive = "Golden_triangle_2006.pdf|p.77",
           archiveLink = "https://www.unodc.org/pdf/research/Golden_triangle_2006.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(nation = "mmr",
           level = 2,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mmr_04,
           begin = 2004,
           end = 2005,
           archive = "Myanmar_opium-survey-2005.pdf|p.15",
           archiveLink = "https://www.unodc.org/pdf/Myanmar_opium-survey-2005.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_mmr_05 <- schema_mmr_03 %>%
    setFilter(rows = .find("Total", col = 1), invert = TRUE) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:4)) %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:4), relative = TRUE)

  regTable(nation = "mmr",
           level = 2,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mmr_05,
           begin = 2007,
           end = 2009,
           archive = "SEA_Opium_survey_2009.pdf|p.57",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/SEA_Opium_survey_2009.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_mmr_06 <-
    setFormat(thousand = ",") %>%
    setIDVar(name = "al1", value = "Myanmar") %>%
    setIDVar(name = "year", rows = 1, columns = c(1:14)) %>%
    setIDVar(name = "commodities", value = "poppy") %>%
    setObsVar(name = "production", unit = "t", columns = c(1:14))

  regTable(nation = "mmr",
           level = 1,
           subset = "productionPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mmr_06,
           begin = 1990,
           end = 2003,
           archive = "myanmar_opium_survey_2003.pdf|p.14",
           archiveLink = "https://www.unodc.org/pdf/publications/myanmar_opium_survey_2003.pdf",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_mmr_07 <-
    setIDVar(name = "al4", columns = 2) %>%
    setIDVar(name = "year", value = "2003") %>%
    setIDVar(name = "commodities", value = "poppy") %>%
    setObsVar(name = "planted", unit = "ha", columns = 3) %>%
    setObsVar(name = "yield", unit = "kg/ha", columns = 4) %>%
    setObsVar(name = "production", unit = "t", columns = 5)

  regTable(nation = "mmr",
           level = 4,
           subset = "plantYieldProdPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mmr_07,
           begin = 2003,
           end = 2003,
           archive = "myanmar_opium_survey_2003.pdf|p.43-44",
           archiveLink = "https://www.unodc.org/pdf/publications/myanmar_opium_survey_2003.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_mmr_08 <- setCluster(id = "al1", left = 1, top = 4) %>%
    setIDVar(name = "al1", value = "Myanmar") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", value = "opium") %>%
    setObsVar(name = "production", unit = "t", columns = 2)

  regTable(nation = "mmr",
           level = 1,
           subset = "productionOpium",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mmr_08,
           begin = 1990,
           end = 2015,
           archive = "production_opium_myanmar_lvl1_1990_2015.csv", # can't find the original pdf file containing this data
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanma",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_mmr_09 <- setCluster(id = "commodities", left = 1, top = 3) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:9), relative = TRUE) %>%
    setIDVar(name = "commodities", value = "opium") %>%
    setObsVar(name = "yield", unit = "kg/ha", columns = c(2:9), relative = TRUE)

  regTable(nation = "mmr",
           level = 2,
           subset = "yieldOpium",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mmr_09,
           begin = 2005,
           end = 2015,
           archive = "yield_opium_myanmar_lvl2_2005_2011_2015.csv", # can't find the original pdf file containing this data
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanma",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_mmr_10 <- setCluster(id = "commodities", left = 1, top = 3) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", rows = 3, columns = c(2:20)) %>%
    setIDVar(name = "commodities", value = "opium") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:20))

  regTable(nation = "mmr",
           level = 2,
           subset = "plantedOpium",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mmr_10,
           begin = 2002,
           end = 2020,
           archive = "cultivation_opium_myanmar_lvl2_2002_2020.csv", # can't find the original pdf file containing this data
           archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanma",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Peru ----
  schema_per_01 <- setCluster(id = "al1") %>%
    setFormat(thousand = ".") %>%
    setIDVar(name = "al1", value = "Peru") %>%
    setIDVar(name = "year", rows = 1, columns = c(2:12)) %>%
    setIDVar(name = "commodities", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:12), relative = TRUE)

  regTable(nation = "per",
           level = 1,
           subset = "plantCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_01,
           begin = 1994,
           end = 2004,
           archive = "Andean-coca-June05.pdf|p.193",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Andean-coca-June05.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)

  # Following two tables have Ene as geometry. Ene is a geo-political area of a rivervaley. Numbers for planted hectarse are very low there.
  schema_per_02 <-
    setFormat(thousand = ".") %>%
    setFilter(rows = .find("Total", col = 1), invert = TRUE) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:5)) %>%
    setIDVar(name = "commodities", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:5))

  regTable(nation = "per",
           level = 2,
           subset = "plantCocaApurimac",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_02,
           begin = 2001,
           end = 2004,
           archive = "Andean-coca-June05.pdf|p.207",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Andean-coca-June05.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_per_03 <-
    setFormat(thousand = ",") %>%
    setFilter(rows = .find("Total", col = 1)) %>%
    setIDVar(name = "al2", value = "Apurimac") %>%
    setIDVar(name = "year", rows = 1, columns = c(2:6)) %>%
    setIDVar(name = "commodities", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:6))

  regTable(nation = "per",
           level = 2,
           subset = "plantCocaApurimac",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_03,
           begin = 2002,
           end = 2006,
           archive = "peru_2006_sp_web.pdf|p.28",
           archiveLink = "https://www.unodc.org/pdf/research/icmp/peru_2006_sp_web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)

  # Data is level 4, from district Macusani - Inambari and Tambopata are river valeys in this district. It is not available in our gadm dataset.
  schema_per_04 <-
    setFormat(thousand = ".") %>%
    setFilter(rows = .find("..total", col = 1), invert = TRUE) %>%
    setIDVar(name = "al4", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:5)) %>%
    setIDVar(name = "commodities", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:5))

  regTable(nation = "per",
           level = 4,
           subset = "plantCocaInambariTambopata",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_04,
           begin = 2001,
           end = 2004,
           archive = "Andean-coca-June05.pdf|p.213",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Andean-coca-June05.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)


  schema_per_05 <-
    setIDVar(name = "al1", value = "Peru") %>%
    setIDVar(name = "year", rows = 1, columns = c(1:11)) %>%
    setIDVar(name = "commodities", value = "poppy") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(1:11))

  regTable(nation = "per",
           level = 1,
           subset = "plantPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_05,
           begin = 1994,
           end = 2004,
           archive = "Andean-coca-June05.pdf|p.243",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Andean-coca-June05.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)

  # Both La Convcion and Lares are in province La convencion, again river valeys.
  schema_per_06 <-
    setFilter(rows = .find("Total", col = 1)) %>%
    setFormat(thousand = ".") %>%
    setIDVar(name = "al3", value = "La Convencion") %>%
    setIDVar(name = "year", rows = 1, columns = c(2:5)) %>%
    setIDVar(name = "commodities", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:5))

  regTable(nation = "per",
           level = 3,
           subset = "plantLaConvencion",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_06,
           begin = 2001,
           end = 2004,
           archive = "Andean-coca-June05.pdf|p.211",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Andean-coca-June05.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)

  # Very detailed data, however, level 4 is not in our gadm dataset.
  schema_per_07 <-
    setFormat(thousand = ",") %>%
    setFilter(rows = .find("TOTAL..", col = 1), invert = TRUE) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "al3", columns = 2) %>%
    setIDVar(name = "al4", columns = 3) %>%
    setIDVar(name = "year", value = "2017") %>%
    setIDVar(name = "commodities", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "per",
           level = 4,
           subset = "plantedCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_07,
           begin = 2017,
           end = 2017,
           archive = "Peru_Monitoreo_de_Cultivos_de_Coca_2017_web.pdf|p.102-105",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Peru_Monitoreo_de_Cultivos_de_Coca_2017_web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_per_08 <- schema_per_07 %>%
    setIDVar(name = "year", value = "2016")

  regTable(nation = "per",
           level = 4,
           subset = "plantedCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_08,
           begin = 2016,
           end = 2016,
           archive = "Peru_Monitoreo_de_coca_2016_web.pdf|p.83-86",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Peru_Monitoreo_de_coca_2016_web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_per_09 <- schema_per_07 %>%
    setIDVar(name = "year", value = "2015")

  regTable(nation = "per",
           level = 4,
           subset = "plantedCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_09,
           begin = 2015,
           end = 2015,
           archive = "Peru_monitoreo_coca_2016.pdf|p.99-101",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Peru_monitoreo_coca_2016.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_per_10 <- schema_per_07 %>%
    setIDVar(name = "year", value = "2014")

  regTable(nation = "per",
           level = 4,
           subset = "plantedCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_10,
           begin = 2014,
           end = 2014,
           archive = "Peru_Informe_monitoreo_coca_2014_web.pdf|p.86-89",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Peru_Informe_monitoreo_coca_2014_web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_per_11 <- schema_per_07 %>%
    setIDVar(name = "year", value = "2013")

  regTable(nation = "per",
           level = 4,
           subset = "plantedCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_11,
           begin = 2013,
           end = 2013,
           archive = "Peru_Monitoreo_de_cultivos_de_coca_2013_web.pdf|p.73-75",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Peru_Monitoreo_de_cultivos_de_coca_2013_web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_per_12 <- schema_per_07 %>%
    setIDVar(name = "year", value = "2012")

  regTable(nation = "per",
           level = 4,
           subset = "plantedCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_12,
           begin = 2012,
           end = 2012,
           archive = "Peru_Monitoreo_de_Coca_2012_web.pdf|p.76-78",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Peru_Monitoreo_de_Coca_2012_web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_per_13 <- schema_per_07 %>%
    setIDVar(name = "year", value = "2011")

  regTable(nation = "per",
           level = 4,
           subset = "plantedCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_13,
           begin = 2011,
           end = 2011,
           archive = "Informe_cultivos_coca_2011_septiembre2012_web.pdf|p.63-65",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Informe_cultivos_coca_2011_septiembre2012_web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)


  schema_per_14 <-
    setFormat(thousand = ",") %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:3)) %>%
    setIDVar(name = "commodities", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:3))

  regTable(nation = "per",
           level = 2,
           subset = "plantCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_14,
           begin = 2009,
           end = 2010,
           archive = "Peru-cocasurvey2010_es.pdf|p.31",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Peru-cocasurvey2010_es.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_per_15 <- schema_per_14 %>%
    setFilter(rows = .find("Total", col = 1), invert = TRUE)

  regTable(nation = "per",
           level = 2,
           subset = "plantCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_15,
           begin = 2007,
           end = 2008,
           archive = "Peru_monitoreo_cultivos_coca_2008.pdf|p.29",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru_monitoreo_cultivos_coca_2008.pdff",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)


  schema_per_16 <-
    setFormat(thousand = ",") %>%
    setIDVar(name = "al1", value = "Peru") %>%
    setIDVar(name = "year", rows = 1, columns = c(2:12)) %>%
    setIDVar(name = "commodities", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:12))

  regTable(nation = "per",
           level = 1,
           subset = "plantCoca",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_16,
           begin = 1996,
           end = 2006,
           archive = "peru_2006_sp_web.pdf|p.10",
           archiveLink = "https://www.unodc.org/pdf/research/icmp/peru_2006_sp_web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)


  schema_per_17 <-
    setFilter(rows = .find("Total", col = 1)) %>%
    setFormat(thousand = ",") %>%
    setIDVar(name = "al3", value = "La Convencion") %>%
    setIDVar(name = "year", rows = 1, columns = c(2:6)) %>%
    setIDVar(name = "commodities", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:6))

  regTable(nation = "per",
           level = 3,
           subset = "plantLaConvencion",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_17,
           begin = 2002,
           end = 2006,
           archive = "peru_2006_sp_web.pdf|p.34",
           archiveLink = "https://www.unodc.org/pdf/research/icmp/peru_2006_sp_web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)


  schema_per_18 <-
    setFormat(thousand = ",") %>%
    setIDVar(name = "al4", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:6)) %>%
    setIDVar(name = "commodities", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:6))

  regTable(nation = "per",
           level = 4,
           subset = "plantCocaSanGaban",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_18,
           begin = 2002,
           end = 2006,
           archive = "peru_2006_sp_web.pdf|p.41",
           archiveLink = "https://www.unodc.org/pdf/research/icmp/peru_2006_sp_web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_per_19 <-
    setFormat(thousand = ",") %>%
    setFilter(rows = .find("Total", col = 1), invert = TRUE) %>%
    setIDVar(name = "al4", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:6)) %>%
    setIDVar(name = "commodities", value = "coca") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:6))

  regTable(nation = "per",
           level = 4,
           subset = "plantCocaInambariTambopata",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_per_19,
           begin = 2002,
           end = 2006,
           archive = "peru_2006_sp_web.pdf|p.43",
           archiveLink = "https://www.unodc.org/pdf/research/icmp/peru_2006_sp_web.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Thailand ----
  schema_tha_01 <- setCluster(id = "commodities", left = 1, top = 2) %>%
    setFilter(rows = .find("Total", col = 1), invert = TRUE) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:3), relative = TRUE) %>%
    setIDVar(name = "commodities", value = "poppy") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:3))

  regTable(nation = "tha",
           level = 2,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tha_01,
           begin = 2005,
           end = 2006,
           archive = "Golden_triangle_2006.pdf|p.138",
           archiveLink = "https://www.unodc.org/pdf/research/Golden_triangle_2006.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(nation = "tha",
           level = 2,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tha_01,
           begin = 2007,
           end = 2008,
           archive = "East_Asia_Opium_report_2008.pdf|p.119",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/East_Asia_Opium_report_2008.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html",
           metadataPath = "unknown",
           overwrite = TRUE)

}

if(build_livestock){
  ## livestock ----

}

if(build_landuse){
  ## landuse ----

}


#### test schemas

# myRoot <- paste0(census_dir, "/adb_tables/stage2/")
# myFile <- ""
# schema <-
#
# input <- read_csv(file = paste0(myRoot, myFile),
#                   col_names = FALSE,
#                   col_types = cols(.default = "c"))
#
# validateSchema(schema = schema, input = input)
#
# output <- reorganise(input = input, schema = schema)
#
# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script


# 4. normalise geometries ----
#
# not needed


# 5. normalise census tables ----
#
## in case the output shall be examined before writing into the DB
# testing <- normTable(nation = thisNation,
#                      update = FALSE,
#                      keepOrig = TRUE)

normTable(pattern = ds[],
          ontoMatch = ,
          outType = "rds")

