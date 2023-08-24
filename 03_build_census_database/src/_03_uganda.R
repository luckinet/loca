# script arguments ----
#
thisNation <- "Uganda"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("countryStat")
gs <- c("gadm36")


# 1. register dataseries ----
#


# 2. register geometries ----
#


# 3. register census tables ----
#
## crops ----
if(build_crops){

  ### countrystat ----
  schema_uga_01 <-
    setIDVar(name = "al4", columns = 2) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "beans") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 4, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 4, value = "Production Total (Total_cod_5)")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdBeans",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_01,
           begin = 2008,
           end = 2008,
           archive = "226MCR030.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR030&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR030&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_uga_02 <-
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "cowPea") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 2, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 2, value = "Production Total")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdCowPea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_02,
           begin = 2008,
           end = 2008,
           archive = "226MCR019.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR019&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR019&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_uga_03 <-
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "maize") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 2, value = "Area (Total)") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 2, value = "Production(Total)")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdMaize",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_03,
           begin = 2008,
           end = 2008,
           archive = "226MCR011.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR011&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR011&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_uga_04 <-
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "millet") %>%
    setObsVar(name = "planted1", unit = "ha", columns = 5,
              key = 2, value = "Area01") %>%
    setObsVar(name = "planted2", unit = "ha", columns = 5,
              key = 2, value = "Area02") %>%
    setObsVar(name = "planted3", unit = "ha", columns = 5,
              key = 2, value = "Area03") %>%
    setObsVar(name = "production1", unit = "t", columns = 5,
              key = 2, value =  "Production01") %>%
    setObsVar(name = "production2", unit = "t", columns = 5,
              key = 2, value =  "Production02") %>%
    setObsVar(name = "production3", unit = "t", columns = 5,
              key = 2, value =  "Production (Second season)")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdMillet",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_04,
           begin = 2008,
           end = 2008,
           archive = "226MCR012.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR012&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR012&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_uga_05 <-
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "potatoSweet") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 2, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 2, value = "Production Total")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdPotatoSweet",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_05,
           begin = 2008,
           end = 2008,
           archive = "226MCR013.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR013&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR013&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_uga_06 <-
    setIDVar(name = "al4", columns = 2) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "potato Irish") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 4, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 4, value = "Production Total")

  regTable(nation - "uga",
           level = 4,
           subset = "plantProdPotatoIrish",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_06,
           begin = 2008,
           end = 2008,
           archive = "226MCR014.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR014&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR014&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_uga_07 <-
    setIDVar(name = "al4", columns = 2) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "cassava") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 4, value = "Area (Total)") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 4, value = "Production Total")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdCassava",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_07,
           begin = 2008,
           end = 2008,
           archive = "226MCR015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR015&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR015&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_uga_08 <-
    setIDVar(name = "al4", columns = 2) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "banana Sweet") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 4, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 4, value = "Production Total")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdBananaSweet",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_08,
           begin = 2008,
           end = 2008,
           archive = "226MCR016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR016&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_uga_09 <-
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "pigeon Pea") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 2, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 2, value = "Production Total")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdPigeonPea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_09,
           begin = 2008,
           end = 2008,
           archive = "226MCR018.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR018&tr=-2",
           updateFrequency = "annuallu",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR018&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_uga_10 <-
    setIDVar(name = "al4", columns = 2) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "peas") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 4, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 4, value = "Production Total")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdPeas",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_10,
           begin = 2008,
           end = 2008,
           archive = "226MCR017.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR017&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR017&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_uga_11 <-
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "sorghum") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 2, value = "Area") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 2, value = "Production")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdSorghum",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_11,
           begin = 2008,
           end = 2008,
           archive = "226MCR010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR010&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_uga_12 <-
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "bananaBeer") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 2, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 2, value = "Production Total")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdBananaBeer",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_12,
           begin = 2008,
           end = 2008,
           archive = "226MCR006.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR006&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR006&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_uga_13 <-
    setFilter(rows = .find("Uganda", col = 1), invert = TRUE) %>%
    setIDVar(name = "al4", columns = 2) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "rice") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 3, value = "Total_cod_4") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 3, value = "Total_cod_5")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdRice",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_13,
           begin = 2008,
           end = 2008,
           archive = "226MCR009.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR009&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR009&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_uga_16 <- schema_uga_14 %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "uga",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_16,
           begin = 1980,
           end = 2014,
           archive = "226CPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## livestock ----
if(build_livestock){

}

## landuse ----
if(build_landuse){

  ### countrystat ----
  schema_uga_14 <-
    setIDVar(name = "al1", value = "Uganda") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_uga_15 <- schema_uga_14 %>%
    setObsVar(name = "headcount", unit = "n", columns = 4)

  regTable(nation = "uga",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_15,
           begin = 2003,
           end = 2012,
           archive = "226CPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)



  schema_uga_17 <-
    setIDVar(name = "al1", value = "Uganda") %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "camels") %>%
    setObsVar(name = "headcount", unit = "n", columns = 3,
              key = 2, value = "UGANDA")

  regTable(nation = "uga",
           level = 1,
           subset = "livestockCamels",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_17,
           begin = 2008,
           end = 2008,
           archive = "226M08007.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226M08007&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226M08007&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_uga_18 <-
    setFilter(rows = .find("UGANDA", col = 4)) %>%
    setIDVar(name = "al1", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", columns = 2) %>%
    setObsVar(name = "beehives", unit = "n", columns = 5)

  regTable(nation = "uga",
           level = 1,
           subset = "beehives",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_18,
           begin = 2008,
           end = 2008,
           archive = "226M08005.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226M08005&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226M08005&tr=-22",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}


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
#
# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script


# 4. normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg",
#              update = updateTables)

normGeometry(pattern = gs[],
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
#           outType = "rds",
#           update = updateTables)

normTable(pattern = ds[],
          ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)

