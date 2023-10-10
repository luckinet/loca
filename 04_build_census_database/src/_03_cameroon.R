# script arguments ----
#
thisNation <- "Cameroon"

updateTables <- FALSE
overwriteTables <- FALSE

ds <- c("countrystat")
gs <- c("gadm36")


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
schema_cmr_00 <-
  setIDVar(name = "al1", value = "Cameroon") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

## crops ----
if(build_crops){

  ## countrystat ----
  schema_cmr_02 <- schema_cmr_00 %>%
    setFilter(rows = .find("^(01.*)", col = 4)) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "cmr",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_cmr_02,
           begin = 1998, # values for crops only appear from 1998 till 2013. From 1972 there is only values for meat production
           end = 2013,
           archive = "D3S_33201134027644764608945955567209261075.xlsx",
           archiveLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_cmr_03 <- schema_cmr_00 %>%
    setCluster (id = "al1", left = 1, top = 5) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "cmr",
           level = 1,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_cmr_03,
           begin = 1998,
           end = 2011,
           archive = "D3S_29933140404043573946251569470594162607.xlsx",
           archiveLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## livestock ----
if(build_livestock){

  ## countrystat ----
  schema_cmr_01 <- schema_cmr_00 %>%
    setFilter(rows = .find("Live animals", col = 3)) %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "cmr",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_cmr_01,
           begin = 1972,
           end = 2012,
           archive = "D3S_13560733286226780367962256534287463659.xlsx",
           archiveLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## landuse ----
if(build_landuse){

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

