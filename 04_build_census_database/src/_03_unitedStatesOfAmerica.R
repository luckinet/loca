# script arguments ----
#
# source(paste0(mdl0301, "src/03_preprocess_usda.R"))
thisNation <- "United States of America"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("usda")
gs <- c("gadm36")


# 1. register dataseries ----
#
regDataseries(name = "usda",
              description = "US Dept. of Agriculture",
              homepage = "https://www.nass.usda.gov/Quick_Stats/Lite/index.php",
              licence_link = "unknown",
              licence_path = "unknown",
              update = updateTables)


# 2. register geometries ----
#


# 3. register census and survey tables ----
#
## crops ----
if(build_crops){

  ### usda ----
  schema_l3_usda_00 <-
    setFormat(na_values = "(D)") %>%
    setFormat(thousand = ",") %>%
    setIDVar(name = "al2", columns = 18) %>%
    setIDVar(name = "al3", columns = 23) %>%
    setIDVar(name = "year", columns = 32) %>%
    setIDVar(name = "commodities", columns = 5)

  # Acres to hectares, BU of wheat to metric tonnes, yield of bu/ac to kg/ha
  # Converting US units:
  # https://grains.org/markets-tools-data/tools/converting-grain-units/
  # https://www.extension.iastate.edu/agdm/wholefarm/html/c6-80.html
  # https://www.foodbankcny.org/assets/Documents/Fruit-conversion-chart.pdf
  # https://www.agric.gov.ab.ca/app19/calc/crop/bushel2tonne.jsp
  schema_l3_usda_00_01 <- schema_l3_usda_00 %>%
    setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA PLANTED") %>%
    setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA HARVESTED") %>%
    setObsVar(name = "production", unit = "t", factor = 0.0272155, columns = 39,
              key = 9, value = "PRODUCTION") %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 67.25, columns = 39,
              key = 9, value = "YIELD")

  regTable(nation = "usa",
           level = 3,
           subset = "surveyWheat",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_01,
           begin = 1908,
           end = 2007,
           archive = "qs.crops_20220129.txt.gz|usda_wheat_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting LB to metric tons, acres to hectares, Lb/acre to kg/ha
  schema_l3_usda_00_02 <- schema_l3_usda_00 %>%
    setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA BEARING") %>%
    setObsVar(name = "production", unit = "t", factor = 0.000453592, columns = 39,
              key = 9, value = "PRODUCTION") %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 1.12085, columns = 39,
              key = 9, value = "YIELD")

  regTable(nation = "usa",
           level = 3,
           subset = "surveyPecans",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_02,
           begin = 2015,
           end = 2020,
           archive = "qs.crops_20220129.txt.gz|usda_pecans_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting acres to ha,  US tonnes to metric tonnes, US tonnes/acre to kg/ha
  schema_l3_usda_00_03 <- schema_l3_usda_00 %>%
    setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA PLANTED") %>%
    setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA HARVESTED") %>%
    setObsVar(name = "production", unit = "t", factor = 0.907185, columns = 39,
              key = 9, value = "PRODUCTION") %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 2241.7, columns = 39,
              key = 9, value = "YIELD")

  regTable(nation = "usa",
           level = 3,
           subset = "surveyFieldCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_03,
           begin = 1918,
           end = 2018,
           archive = "qs.crops_20220129.txt.gz|usda_tons_crops_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 3,
           subset = "surveyCornSorghum02",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_03,
           begin = 1910,
           end = 2020,
           archive = "qs.crops_20220129.txt.gz|usda_corn_sorghum_l3_part02.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 3,
           subset = "surveyPeas",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_03,
           begin = 1968,
           end = 2013,
           archive = "qs.crops_20220129.txt.gz|usda_peas_crops_l3_part01.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Acres to ha, 480 Lb bales to metric tonnes, LB/acre to kg/ha
  schema_l3_usda_00_04 <- schema_l3_usda_00 %>%
    setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA PLANTED") %>%
    setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA HARVESTED") %>%
    setObsVar(name = "production", unit = "t", factor = 0.217724, columns = 39,
              key = 9, value = "PRODUCTION") %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 1.12085, columns = 39,
              key = 9, value = "YIELD")

  regTable(nation = "usa",
           level = 3,
           subset = "surveyCotton",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_04,
           begin = 1919,
           end = 2020,
           archive = "qs.crops_20220129.txt.gz|usda_cotton_crops_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting acres to hectares and LB to tonnes, LB/acre to kg/ha
  schema_l3_usda_00_05 <- schema_l3_usda_00 %>%
    setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA PLANTED") %>%
    setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA HARVESTED") %>%
    setObsVar(name = "production", unit = "t", factor = 0.000453592, columns = 39,
              key = 9, value = "PRODUCTION") %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 1.12085, columns = 39,
              key = 9, value = "YIELD")

  regTable(nation = "usa",
           level = 3,
           subset = "surveyCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_05,
           begin = 1915,
           end = 2020,
           archive = "qs.crops_20220129.txt.gz|usda_LB_crops_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting BU (for corn/sorghum) to tonnes and BU/acre to kg/ha
  schema_l3_usda_00_06 <- schema_l3_usda_00 %>%
    setObsVar(name = "production", unit = "t", factor = 0.0254, columns = 39,
              key = 9, value = "PRODUCTION") %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 62.77, columns = 39,
              key = 9, value = "YIELD")

  regTable(nation = "usa",
           level = 3,
           subset = "surveyCornSorghum",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_06,
           begin = 1910,
           end = 2020,
           archive = "qs.crops_20220129.txt.gz|usda_corn_sorghum_l3_part01.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting acres to ha, CWT to tonnes, LB/acre to kg/ha
  schema_l3_usda_00_07 <- schema_l3_usda_00 %>%
    setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA PLANTED") %>%
    setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA HARVESTED") %>%
    setObsVar(name = "production", unit = "t", factor = 0.0508023, columns = 39,
              key = 9, value = "PRODUCTION") %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 1.12085, columns = 39,
              key = 9, value = "YIELD")

  regTable(nation = "usa",
           level = 3,
           subset = "surveyCrops02",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_07,
           begin = 1938,
           end = 2020,
           archive = "qs.crops_20220129.txt.gz|usda_CWT_crops_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(level = 3,
           subset = "surveyPeas02",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_07,
           begin = 1999,
           end = 2020,
           archive = "qs.crops_20220129.txt.gz|usda_peas_crops_l3_part02.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting US tonnes to metric tonnes.
  schema_l3_usda_00_08 <- schema_l3_usda_00 %>%
    setObsVar(name = "production", unit = "t", factor = 0.907185, columns = 39)

  regTable(nation = "usa",
           level = 3,
           subset = "surveyPeachesProd",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_08,
           begin = 2003,
           end = 2012,
           archive = "qs.crops_20220129.txt.gz|usda_peaches_TONS_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 3,
           subset = "censusFieldCrops02",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_08,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20220129.txt.gz|usda_census_field_crops_prod_tons_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 3,
           subset = "censusFruitProd",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_08,
           begin = 1997,
           end = 2012,
           archive = "qs.crops_20220129.txt.gz|usda_census_friut_prod_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting BU/acre to kg/acre: in this case a bushel of peach equals: 48 - 52 lb
  # https://www.foodbankcny.org/assets/Documents/Fruit-conversion-chart.pdf
  # Factor in the schema is based on 1 lb/acre X 50 (average of a peach bushel)
  schema_l3_usda_00_09 <- schema_l3_usda_00 %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 56.0426, columns = 39)

  regTable(nation = "usa",
           level = 3,
           subset = "surveyPeachesYield",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_09,
           begin = 1997,
           end = 2009,
           archive = "qs.crops_20220129.txt.gz|usda_peaches_BU_ACRE_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting pounds to metric tonnes
  schema_l3_usda_00_10 <- schema_l3_usda_00 %>%
    setObsVar(name = "production", unit = "t", factor = 0.000453592, columns = 39)

  regTable(nation = "usa",
           level = 3,
           subset = "surveyPeachesProd02",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_10,
           begin = 1992,
           end = 2002,
           archive = "qs.crops_20220129.txt.gz|usda_peaches_LB_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  # Converting acres to ha, BU (for barley) to tonnes, BU/acre to kg/ha, not sure about Bu/acre to kg/ha
  schema_l3_usda_00_11 <- schema_l3_usda_00 %>%
    setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA PLANTED") %>%
    setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA HARVESTED") %>%
    setObsVar(name = "production", unit = "t", factor = 0.021772, columns = 39,
              key = 9, value = "PRODUCTION") %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 53.7997837, columns = 39,
              key = 9, value = "YIELD")

  regTable(nation = "usa",
           level = 3,
           subset = "surveyBarley",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_11,
           begin = 1915,
           end = 2021,
           archive = "qs.crops_20220129.txt.gz|usda_BU_barley_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting acres to ha, BU (for oats) to tonnes, BU/acre to kg/ha -
  schema_l3_usda_00_12 <- schema_l3_usda_00 %>%
    setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA PLANTED") %>%
    setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA HARVESTED") %>%
    setObsVar(name = "production", unit = "t", factor = 0.015, columns = 39,
              key = 9, value = "PRODUCTION") %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 37.065807, columns = 39,
              key = 9, value = "YIELD")

  regTable(nation = "usa",
           level = 3,
           subset = "surveyOats",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_12,
           begin = 1915,
           end = 2021,
           archive = "qs.crops_20220129.txt.gz|usda_BU_oats_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting acres to ha, BU (for Rye/Flaxseed) to tonnes, BU/acre to kg/ha
  schema_l3_usda_00_13 <- schema_l3_usda_00 %>%
    setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA PLANTED") %>%
    setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA HARVESTED") %>%
    setObsVar(name = "production", unit = "t", factor = 0.025, columns = 39,
              key = 9, value = "PRODUCTION") %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 61.776345, columns = 39,
              key = 9, value = "YIELD")

  regTable(nation = "usa",
           level = 3,
           subset = "surveyRyeFlaxseed",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_13,
           begin = 1919,
           end = 2020,
           archive = "qs.crops_20220129.txt.gz|usda_BU_ryeFlaxseed_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting acres to ha, BU (for soybean) to tonnes, BU/acre to kg/ha
  schema_l3_usda_00_14 <- schema_l3_usda_00 %>%
    setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA PLANTED") %>%
    setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA HARVESTED") %>%
    setObsVar(name = "production", unit = "t", factor = 0.027, columns = 39,
              key = 9, value = "PRODUCTION") %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 66.718453, columns = 39,
              key = 9, value = "YIELD")

  regTable(nation = "usa",
           level = 3,
           subset = "surveySoybeans",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_14,
           begin = 1927,
           end = 2020,
           archive = "qs.crops_20220129.txt.gz|usda_BU_soybeans_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting LB to tonnes, BU/acre (apples) to kg/ha bushel per apples = 42 - 48 lbs.
  schema_l3_usda_00_15 <- schema_l3_usda_00 %>%
    setObsVar(name = "production", unit = "t", factor = 0.0204117, columns = 39,
              key = 9, value = "PRODUCTION") %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 50.4383, columns = 39,
              key = 9, value = "YIELD")

  regTable(nation = "usa",
           level = 3,
           subset = "surveyApples",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_15,
           begin = 1972,
           end = 2012,
           archive = "qs.crops_20220129.txt.gz|usda_apples_crops_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting acres to ha, US tonnes to metric tonnes
  schema_l3_usda_00_16 <- schema_l3_usda_00 %>%
    setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA HARVESTED") %>%
    setObsVar(name = "production", unit = "t", factor = 0.907185, columns = 39,
              key = 9, value = "PRODUCTION")

  regTable(nation = "usa",
           level = 3,
           subset = "censusCorn",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_16,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20220129.txt.gz|usda_census_corn_acres_tons_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 3,
           subset = "censusHay",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_16,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20220129.txt.gz|usda_census_hay_acres_tons_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting Bu for corn to metric tonnes
  schema_l3_usda_00_17 <- schema_l3_usda_00 %>%
    setObsVar(name = "production", unit = "t", factor = 0.0254, columns = 39,
              key = 9, value = "PRODUCTION")

  regTable(nation = "usa",
           level = 3,
           subset = "censusCornProd",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_17,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20220129.txt.gz|usda_census_corn_BU_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting bales of cotton to tonnes, acre to ha
  schema_l3_usda_00_18 <- schema_l3_usda_00 %>%
    setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA HARVESTED") %>%
    setObsVar(name = "production", unit = "t", factor = 0.217724, columns = 39,
              key = 9, value = "PRODUCTION")

  regTable(nation = "usa",
           level = 3,
           subset = "censusCotton",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_18,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20220129.txt.gz|usda_census_cotton_acres_bales_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting acre to ha
  schema_l3_usda_00_19 <- schema_l3_usda_00 %>%
    setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39)

  regTable(nation = "usa",
           level = 3,
           subset = "censusFieldCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_19,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20220129.txt.gz|usda_census_field_crops_ACRES_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 3,
           subset = "censusVeg",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_19,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20220129.txt.gz|usda_census_veg_harv_ACRES_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 3,
           subset = "censusFruitHarv",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_19,
           begin = 1997,
           end = 2012,
           archive = "qs.crops_20220129.txt.gz|usda_census_friut_harv_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting acre to ha
  schema_l3_usda_00_20 <- schema_l3_usda_00 %>%
    setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA HARVESTED") %>%
    setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA IN PRODUCTION")

  regTable(nation = "usa",
           level = 3,
           subset = "censusHorti",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_20,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20220129.txt.gz|usda_census_horti_acres_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting sqft to ha
  schema_l3_usda_00_21 <- schema_l3_usda_00 %>%
    setObsVar(name = "planted", unit = "ha", factor = 0.0000092903, columns = 39,
              key = 9, value = "AREA IN PRODUCTION")

  regTable(nation = "usa",
           level = 3,
           subset = "censusHorti02",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_21,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20220129.txt.gz|usda_census_horti_sqft_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting acres to ha and LB to tonnes
  schema_l3_usda_00_22 <- schema_l3_usda_00 %>%
    setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA HARVESTED") %>%
    setObsVar(name = "production", unit = "t", factor = 0.000453592, columns = 39,
              key = 9, value = "PRODUCTION")

  regTable(nation = "usa",
           level = 3,
           subset = "censusMint",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_22,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20220129.txt.gz|usda_census_mint_prod_harv_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting BU of wheat to tonnes and acres to ha
  schema_l3_usda_00_23 <- schema_l3_usda_00 %>%
    setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
              key = 9, value = "AREA HARVESTED") %>%
    setObsVar(name = "production", unit = "t", factor = 0.027, columns = 39,
              key = 9, value = "PRODUCTION")

  regTable(nation = "usa",
           level = 3,
           subset = "censusWheat",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_23,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20220129.txt.gz|usda_census_wheat_harve_prod_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting LB to tonnes
  schema_l3_usda_00_24 <- schema_l3_usda_00 %>%
    setObsVar(name = "production", unit = "t", factor = 0.000453592, columns = 39,
              key = 9, value = "PRODUCTION")

  regTable(nation = "usa",
           level = 3,
           subset = "censusGingerCornProd",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_24,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20220129.txt.gz|usda_census_wheat_harve_prod_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 3,
           subset = "censusFieldCropsProd02",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_24,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20220129.txt.gz|usa_2_censusVegYield_2002_2018_usda.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting CWT to tonnes
  schema_l3_usda_00_25 <- schema_l3_usda_00 %>%
    setObsVar(name = "production", unit = "t", factor = 0.0508023, columns = 39,
              key = 9, value = "PRODUCTION")

  regTable(nation = "usa",
           level = 3,
           subset = "censusPotatoProd",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_25,
           begin = 1997,
           end = 2002,
           archive = "qs.crops_20220129.txt.gz|usda_census_veg_prod_CWT_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 3,
           subset = "censusFieldCropsProd",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_25,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20220129.txt.gz|usda_census_veg_prod_CWT_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # Converting acre to ha
  schema_l3_usda_00_26 <- schema_l3_usda_00 %>%
    setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39)

  regTable(nation = "usa",
           level = 3,
           subset = "censusFruitPlant",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_l3_usda_00_26,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20220129.txt.gz|usda_census_friut_plant_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  # schema_l2_usda_00 <-
  #   setFormat(na_values = "(D)") %>%
  #   setFormat(thousand = ",") %>%
  #   setIDVar(name = "al2", columns = 18) %>%
  #   setIDVar(name = "year", columns = 32) %>%
  #   setIDVar(name = "commodities", columns = 5)
  #
  # # Converting acres to ha, LB to tonnes, LB/acre to kg/ha
  # schema_l2_usda_00_01 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA BEARING") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.000453592, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 1.12, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyApples",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_01,
  #          begin = 2007,
  #          end = 2020,
  #          archive = "qs.crops_20220129.txt.gz|usda_apples_allother_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting BU of apples/acre to kg/ha - 42 -48 lb per bushel
  # schema_l2_usda_00_02 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 50.4383, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyApplesYield",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_02,
  #          begin = 1999,
  #          end = 2009,
  #          archive = "qs.crops_20220129.txt.gz|usda_apples_yield_BU_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, 480LB bales of cotton to tonnes, lb/acre to kg/ha
  # schema_l2_usda_00_03 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA PLANTED") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.217724, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 538.009, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyCotton",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_03,
  #          begin = 1900,
  #          end = 2021,
  #          archive = "qs.crops_20220129.txt.gz|usda_cotton_survey_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting US tonnes to metric tonnes
  # schema_l2_usda_00_04 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.907185, columns = 39,
  #             key = 9, value = "PRODUCTION")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyCottonSeed",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_04,
  #          begin = 1900,
  #          end = 2021,
  #          archive = "qs.crops_20220129.txt.gz|usda_cottonSeed_survey_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "censusVegPro",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_04,
  #          begin = 2008,
  #          end = 2016,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_tons_prod_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, LB to metric tonnes, Lb/acre to kg/ha
  # schema_l2_usda_00_05 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA PLANTED") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.000453592, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 1.12, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyFieldCrops",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_05,
  #          begin = 1900,
  #          end = 2022,
  #          archive = "qs.crops_20220129.txt.gz|usda_field_crops_LB_survey_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting CWT to metric tonnes
  # schema_l2_usda_00_06 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.0508023, columns = 39,
  #             key = 9, value = "PRODUCTION")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyFieldCrops02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_06,
  #          begin = 1900,
  #          end = 2021,
  #          archive = "qs.crops_20220129.txt.gz|usda_field_crops_CWT_survey_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "censusVegProd03",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_06,
  #          begin = 1997,
  #          end = 2019,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_CWT_prod_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, Us tonns to metric tonnes, ton/acre to kg/ha
  # schema_l2_usda_00_07 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA PLANTED") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.907185, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 2241.7, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyFieldCrops03",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_07,
  #          begin = 1909,
  #          end = 2021,
  #          archive = "qs.crops_20220129.txt.gz|usda_field_crops_tons_survey_l2",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, LB to tonnes, Lb/acre to kg/ha
  # schema_l2_usda_00_08 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA BEARING") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.000453592, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 1.12, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyFruit",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_08,
  #          begin = 1978,
  #          end = 2021,
  #          archive = "qs.crops_20220129.txt.gz|usda_fruits_acres_LB_survey.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, cwt to tonnes, cwt/acre to kg/ha
  # schema_l2_usda_00_09 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA BEARING") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.0508023, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 125.535, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyVeg",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_09,
  #          begin = 1900,
  #          end = 2021,
  #          archive = "qs.crops_20220129.txt.gz|usda_vegetables_cwt_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, US tonne to tonnes, Us tonnes/acre to kg/ha
  # schema_l2_usda_00_10 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA BEARING") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.907185, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 2471.05, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyVeg02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_10,
  #          begin = 1900,
  #          end = 2020,
  #          archive = "qs.crops_20220129.txt.gz|usda_vegetables_tons_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, LB to tonnes, LB/acre to kg/ha
  # schema_l2_usda_00_11 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.000453592, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 1.12085, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyGinger",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_11,
  #          begin = 1953,
  #          end = 2008,
  #          archive = "qs.crops_20220129.txt.gz|usda_vegetables_gignger_root_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting cwt to tonnes, cwt/acre to kg/ha
  # schema_l2_usda_00_12 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.0508023, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 125.535, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyStrawberry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_12,
  #          begin = 1998,
  #          end = 2008,
  #          archive = "qs.crops_20220129.txt.gz|usda_strawbery_CWT_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, US tonne to tonnes, Us tonnes/acre to kg/ha
  # schema_l2_usda_00_13 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA BEARING") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.907185, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 2471.05, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyStrawberry02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_13,
  #          begin = 1998,
  #          end = 2020,
  #          archive = "qs.crops_20220129.txt.gz|usda_strawbery_TONS_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Factor in the schema is based on 1 lb/acre X 50 (average of a peach bushel)
  # schema_l2_usda_00_14 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 56.0426, columns = 39)
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyPeachesYield",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_14,
  #          begin = 1997,
  #          end = 2009,
  #          archive = "qs.crops_20220129.txt.gz|usda_peaches_yield_BU_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, US tonne to tonnes, Us tonnes/acre to kg/ha
  # schema_l2_usda_00_15 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA BEARING") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.907185, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 2471.05, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyPeaches",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_15,
  #          begin = 2003,
  #          end = 2021,
  #          archive = "qs.crops_20220129.txt.gz|usda_peaches_allother_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting  LB to tonnes
  # schema_l2_usda_00_16 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.000453592, columns = 39,
  #             key = 9, value = "PRODUCTION")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyPeachesProd",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_16,
  #          begin = 1992,
  #          end = 2002,
  #          archive = "qs.crops_20220129.txt.gz|usda_peaches_LB_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "censusVegProd02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_16,
  #          begin = 1997,
  #          end = 2019,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_LB_prod_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "puertoRicoFruit02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_16,
  #          begin = 2018,
  #          end = 2018,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_fruit_puertoLB_02.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting sq ft to hectares, LB to tons, LB/sq ft to kg/ha
  # schema_l2_usda_00_17 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.0000092903, columns = 39,
  #             key = 9, value = "AREA FILLED") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.0000092903, columns = 39,
  #             key = 9, value = "AREA IN PRODUCTION") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.000453592, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 48824.3, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyMushrooms",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_17,
  #          begin = 2010,
  #          end = 2021,
  #          archive = "qs.crops_20220129.txt.gz|usda_horticulture_survey.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # converting US tonns to Metric tons, tons/acres to kg/ha
  # schema_l2_usda_00_18 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.907185, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 2471.05, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyFruitProd",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_18,
  #          begin = 1996,
  #          end = 2022,
  #          archive = "qs.crops_20220129.txt.gz|usda_fruits_tons_survey.csv`",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to hectares, LB to tons, LB/acres to kg/ha
  # schema_l2_usda_00_19 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA BEARING") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.000453592, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 1.12085, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyCoffee",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_19,
  #          begin = 1946,
  #          end = 2021,
  #          archive = "qs.crops_20220129.txt.gz|usda_coffee_LB_survey.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to hectares
  # schema_l2_usda_00_20 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "censusVegHarv",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_20,
  #          begin = 1997,
  #          end = 2021,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_acres_harv_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting cwt/acre to kg/ha
  # schema_l2_usda_00_21 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "yield", unit = "ha", factor = 125.535, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "censusVegYield",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_21,
  #          begin = 2002,
  #          end = 2018,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_CWT-ACRE_yield_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # # Converting Cuerdas to hectares, CWT to tons
  # schema_l2_usda_00_22 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "harvested", unit = "ha", factor =  0.393, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.0508023, columns = 39,
  #             key = 9, value = "PRODUCTION")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "puertoRicoCrops",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_22,
  #          begin = 2018,
  #          end = 2018,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_field_crops_puerto_01.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "puertoRicoCrops03",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_24,
  #          begin = 2018,
  #          end = 2018,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_field_crops_puerto_03.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting Cuerdas to hectares, US tonnes to tons
  # schema_l2_usda_00_23 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "harvested", unit = "ha", factor =  0.393, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.907185, columns = 39,
  #             key = 9, value = "PRODUCTION")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "puertoRicoCrops02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_23,
  #          begin = 2018,
  #          end = 2018,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_field_crops_puerto_02.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "puertoRicoFruit",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_23,
  #          begin = 2018,
  #          end = 2018,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_fruit_puerto_01.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting Cuerdas to hectares, CWT to tons
  # schema_l2_usda_00_24 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "harvested", unit = "ha", factor =  0.393, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.000453592, columns = 39,
  #             key = 9, value = "PRODUCTION")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "puertoRicoCrops04",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_24,
  #          begin = 2018,
  #          end = 2018,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_field_crops_puerto_04.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting Cuerdas to hectares
  # schema_l2_usda_00_25 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor =  0.393, columns = 39)
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "puertoRicoFruitPlant",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_25,
  #          begin = 2018,
  #          end = 2018,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_fruit_puerto_plant_01.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "puertoRicoHorti",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_25,
  #          begin = 2018,
  #          end = 2018,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_horti_puerto01.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting sq ft to hectares
  # schema_l2_usda_00_26 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor =  0.0000092903, columns = 39)
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "puertoRicoHorti02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_26,
  #          begin = 2018,
  #          end = 2018,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_horti_puerto02.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, LB to tonnes
  # schema_l2_usda_00_27 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.000453592, columns = 39,
  #             key = 9, value = "PRODUCTION")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "puertoRicoVeg",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_27,
  #          begin = 2018,
  #          end = 2018,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_veg_puerto_01.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, CWT to tonnes
  # schema_l2_usda_00_28 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.907185, columns = 39,
  #             key = 9, value = "PRODUCTION")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "puertoRicoVeg02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_28,
  #          begin = 2018,
  #          end = 2018,
  #          archive = "qs.crops_20220129.txt.gz|usda_census_veg_puerto_01.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to hectares, LB to tons, LB/acres to kg/ha
  # schema_l2_usda_00_29 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.000453592, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 1.12085, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "puertoRicoCoffee",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_29,
  #          begin = 2003,
  #          end = 2010,
  #          archive = "qs.crops_20220129.txt.gz|usda_coffee_puerto_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, BU (for barley) to tonnes, BU/acre to kg/ha, not sure about Bu/acre to kg/ha
  # schema_l2_usda_00_30 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA PLANTED") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.021772, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 53.8009, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyBarley",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_30,
  #          begin = 1900,
  #          end = 2021,
  #          archive = "qs.crops_20220129.txt.gz|usda_field_crops_BU_barley_survey_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, BU (for corn sorghum) to tonnes, BU/acre to kg/ha, not sure about Bu/acre to kg/ha
  # schema_l2_usda_00_30 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA PLANTED") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.0254, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 62.77, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyCornSorg",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_30,
  #          begin = 1900,
  #          end = 2021,
  #          archive = "qs.crops_20220129.txt.gz|usda_field_crops_BU_cornSorg_survey_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, BU (for millet) to tonnes, BU/acre to kg/ha, not sure about Bu/acre to kg/ha
  # schema_l2_usda_00_31 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA PLANTED") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.02, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 67.25, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyMillet",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_31,
  #          begin = 1999,
  #          end = 2021,
  #          archive = "qs.crops_20220129.txt.gz|usda_field_crops_BU_millet_survey_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, BU (for oats) to tonnes, BU/acre to kg/ha,
  # schema_l2_usda_00_32 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA PLANTED") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.015, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 67.25, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyOats",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_32,
  #          begin = 1900,
  #          end = 2021,
  #          archive = "qs.crops_20220129.txt.gz|usda_field_crops_BU_oats_survey_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Converting acres to ha, BU (for soybean, wheat) to tonnes, BU/acre to kg/ha,
  # schema_l2_usda_00_33 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA PLANTED") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.0272155, columns = 39,
  #             key = 9, value = "PRODUCTION") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 67.25, columns = 39,
  #             key = 9, value = "YIELD")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveySoyWheat",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_33,
  #          begin = 1900,
  #          end = 2022,
  #          archive = "qs.crops_20220129.txt.gz|usda_field_crops_BU_soyWheat_survey_l2.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # #Converting acres to ha
  # schema_l2_usda_00_34 <- schema_l2_usda_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA PLANTED") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.4046856422, columns = 39,
  #             key = 9, value = "AREA HARVESTED")
  #
  # regTable(nation = "usa",
  #          level = 2,
  #          subset = "surveyFieldCropsTot",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_l2_usda_00_34,
  #          begin = 1997,
  #          end = 2020,
  #          archive = "qs.crops_20220129.txt.gz|FIELD_CROPS_TOTAL_ONLY.csv",
  #          archiveLink = "https://quickstats.nass.usda.gov/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
}

## livestock ----
if(build_livestock){

  ### usda ----
  # the value for cattle is the one that gives total number.
  schema_liv_usda_00 <-
    setFormat(na_values = "(D)") %>%
    setFormat(thousand = ",") %>%
    setIDVar(name = "al2", columns = 18) %>%
    setIDVar(name = "year", columns = 32) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "headcount", unit = "n", columns = 39)

  regTable(nation = "usa",
           level = 2,
           subset = "cattle",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_liv_l2_usda_00,
           begin = 1900,
           end = 2021,
           archive = "qs.animals_products_20220129.txt.gz|usda_cattle_l2.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 2,
           subset = "goats",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_liv_l2_usda_00,
           begin = 1997,
           end = 2017,
           archive = "qs.animals_products_20220129.txt.gz|usda_goats_l2.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 2,
           subset = "hogs",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_liv_l2_usda_00,
           begin = 1900,
           end = 2021,
           archive = "qs.animals_products_20220129.txt.gz|usda_hogs_l2.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 2,
           subset = "sheep",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_liv_l2_usda_00,
           begin = 1920,
           end = 2021,
           archive = "qs.animals_products_20220129.txt.gz|usda_sheep_l2.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_liv_usda_01 <-
    setFormat(na_values = "(D)") %>%
    setFormat(thousand = ",") %>%
    setIDVar(name = "al2", columns = 18) %>%
    setIDVar(name = "al3", columns = 23) %>%
    setIDVar(name = "year", columns = 32) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "headcount", unit = "n", columns = 39)

  regTable(nation = "usa",
           level = 3,
           subset = "cattle",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_liv_l2_usda_01,
           begin = 1920,
           end = 2021,
           archive = "qs.animals_products_20220129.txt.gz|usda_cattle_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 3,
           subset = "goats",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_liv_l2_usda_01,
           begin = 2002,
           end = 2017,
           archive = "qs.animals_products_20220129.txt.gz|usda_goats_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 3,
           subset = "hogs",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_liv_l2_usda_01,
           begin = 1900,
           end = 2021,
           archive = "qs.animals_products_20220129.txt.gz|usda_hogs_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 3,
           subset = "sheep",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_liv_l2_usda_01,
           begin = 1920,
           end = 2021,
           archive = "qs.animals_products_20220129.txt.gz|usda_sheep_l3.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_liv_usda_02 <- schema_liv_usda_01 %>%
    setIDVar(name = "al3", columns = 24)

  regTable(nation = "usa",
           level = 3,
           subset = "cattlePuertoRico",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_liv_l2_usda_02,
           begin = 2018,
           end = 2018,
           archive = "qs.animals_products_20220129.txt.gz|usda_cattle_PuertoRico.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 3,
           subset = "goatPuertoRico",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_liv_l2_usda_02,
           begin = 2018,
           end = 2018,
           archive = "qs.animals_products_20220129.txt.gz|usda_goats_PuertoRico.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "usa",
           level = 3,
           subset = "hogsPuertoRico",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_liv_l2_usda_02,
           begin = 2018,
           end = 2018,
           archive = "qs.animals_products_20220129.txt.gz|usda_hogs_PuertoRico.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_liv_usda_03 <- schema_liv_usda_02 %>%
    setIDVar(name = "commodities", columns = 6)

  regTable(nation = "usa",
           level = 3,
           subset = "livestockOtherPuertoRico",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_liv_l2_usda_03,
           begin = 2018,
           end = 2018,
           archive = "qs.animals_products_20220129.txt.gz|usda_livestockOther_PuertoRico.csv",
           archiveLink = "https://quickstats.nass.usda.gov/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.nass.usda.gov/Quick_Stats/index.php",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  #### test schemas

  # myRoot <- paste0(dataDir, "censusDB/adb_tables/stage2/")
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

  #### delete this section after finalising script

}

## landuse ----
if(build_landuse){

}

# 4. normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              al1 = thisNation,
#              outType = "gpkg",
#              update = updateTables)

normGeometry(pattern = gs[],
             # al1 = thisNation,
             outType = "gpkg",
             update = updateTables)


# 5. normalise census tables ----
#
## in case the output shall be examined before writing into the DB
# testing <- normTable(nation = thisNation,
#                      update = FALSE,
#                      keepOrig = TRUE)
#
# only needed if FAO datasets have not been integrated before
# normTable(pattern = "fao",
#           al1 = thisNation,
#           outType = "rds",
#           update = updateTables)

normTable(pattern = ds[],
          # al1 = thisNation,
          ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)

