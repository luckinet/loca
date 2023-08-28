# script arguments ----
#
thisNation <- "Burundi"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("countrySTAT")
gs <- c("gadm")


# register dataseries ----
#
regDataseries(name = ds[],
              description = "",
              homepage = "",
              licence_link = "",
              licence_path = "",
              update = updateTables)


# register geometries ----
#
regGeometry(nation = !!thisNation, # or any other "class = value" combination from the gazetteer
            gSeries = gs[],
            level = 2,
            nameCol = "",
            archive = "|",
            archiveLink = "",
            nextUpdate = "",
            updateFrequency = "",
            update = updateTables)


# register census tables ----
#
## crops ----
if(build_crops){

  ### countryStat ----
  #following table has been manually edditied: "." have been removed from values
  #and when ever needed "0" has been added to point out the number is thousand,
  #not hundred. # In the original table when a number was recorder like "2.08" it
  #means it is 2080, according to comparison with the rest of the data for that
  #specific commodity.
  schema_bdi_01 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "bdi",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2000,
           end = 2014,
           schema = schema_bdi_01,
           archive = "029SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029SPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029SPD010&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_bdi_02 <-
    setIDVar(name = "al1", value = "Burundi") %>%
    setIDVar(name = "year", columns = 3)

  schema_bdi_03 <- schema_bdi_02 %>%
    setFilter(rows = .find("Canne..", col = 2)) %>%
    setIDVar(name = "commodities", columns = 2) %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "prodSugar",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_03,
           begin = 2000,
           end = 2011,
           archive = "029ANCICAN001.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCICAN001&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCICAN001&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_bdi_04 <- schema_bdi_02 %>%
    setIDVar(name = "commodities", value = "palm oil") %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "prodPalmOil",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_04,
           begin = 2000,
           end = 2011,
           archive = "029ANCIPA001.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCIPA001&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCIPA001&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_bdi_05 <- schema_bdi_02 %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", value = "palm oil tree") %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "plantPalmOil",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_05,
           begin = 2000,
           end = 2011,
           archive = "029ANCIPA002.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCIPA002&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCIPA002&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_bdi_06 <- schema_bdi_02 %>%
    setIDVar(name = "commodities", value = "green tea") %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "prodGreenTea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_06,
           begin = 2000,
           end = 2011,
           archive = "029ANCITH001.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH001&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH001&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_bdi_07 <- schema_bdi_02 %>%
    setIDVar(name = "commodities", value = "dry tea") %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "prodDryTea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_07,
           begin = 2000,
           end = 2011,
           archive = "029ANCITH003.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH003&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH003&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_bdi_08 <- schema_bdi_02 %>%
    setFilter(rows = .find("totale..", col = 2)) %>%
    setIDVar(name = "commodities", value = "tea") %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "plantTeaIndustrialBlocks",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_08,
           begin = 2000,
           end = 2011,
           archive = "029ANCITH006.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH006&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH006&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_bdi_09 <- schema_bdi_02 %>%
    setFilter(rows = .find("Total", col = 2)) %>%
    setIDVar(name = "commodities", value = "tea") %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "plantTea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_09,
           begin = 2000,
           end = 2011,
           archive = "029ANCITH007.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH007&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH007&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_bdi_10 <- schema_bdi_02 %>%
    setFilter(rows = .find("Total", col = 2)) %>%
    setIDVar(name = "commodities", value = "green leaf tea") %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "prodGreenLeafTea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_10,
           begin = 2000,
           end = 2011,
           archive = "029ANCITH008.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH008&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH008&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "bdi",
           level = 1,
           subset = "prodTeaBlocks",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_10,
           begin = 2000,
           end = 2011,
           archive = "029ANCITH009.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH009&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH009&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_bdi_12 <-
    setIDVar(name = "al1", value = "Burundi") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_bdi_13 <- schema_bdi_12 %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_13,
           begin = 2000,
           end = 2015,
           archive = "029CPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD010&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "bdi",
           level = 1,
           subset = "prodSugarCotton",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_13,
           begin = 2000,
           end = 2015,
           archive = "029CPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD015&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD015&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_bdi_14 <- schema_bdi_12 %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_14,
           begin = 2000,
           end = 2015,
           archive = "029CPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD016&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_bdi_16 <- schema_bdi_14 %>%
    setFilter(rows = .find("Total", col = 3)) %>%
    setIDVar(name = "commodities", value = "tea")

  regTable(nation = "bdi",
           level = 1,
           subset = "plantTea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_16,
           begin = 2000,
           end = 2015,
           archive = "029ISP002.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ISP002&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ISP002&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_bdi_17 <- schema_bdi_16 %>%
    setIDVar(name = "commodities", value = "cotton")

  regTable(nation = "bdi",
           level = 1,
           subset = "plantCotton",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_17,
           begin = 2000,
           end = 2015,
           archive = "029ISP001.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ISP001&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ISP001&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## livestock ----
if(build_livestock){

  ### countryStat ----
  schema_bdi_15 <- schema_bdi_12 %>%
    setObsVar(name = "headcount", unit = "n", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_15,
           begin = 2000,
           end = 2014,
           archive = "029CPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD035&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD035&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## landuse ----
if(build_landuse){

  ### countryStat ----
  # table has different types of forest lands, which are not distinguishable in
  # the ontology, therefore I am taking the Total areas.
  schema_bdi_11 <- schema_bdi_02 %>%
    setFilter(rows = .find("TOTAL", col = 2)) %>%
    setIDVar(name = "commodities", value = "forest land") %>%
    setObsVar(name = "area", unit = "ha", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "forestArea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_11,
           begin = 2001,
           end = 2011,
           archive = "029ANSYL001.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANSYL001&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANSYL001&tr=-2",
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

#### delete this section after finalising script


# normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg",
#              update = updateTables)

normGeometry(pattern = gs[],
             outType = "gpkg",
             update = updateTables)


# normalise census tables ----
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
