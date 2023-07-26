# script arguments ----
#
thisNation <- "Ethiopia"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("faoDatalab", "countrySTAT", "csa")
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
# faoDatalab ----
schema_eth_01 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 6) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 10,
            key = 11, value = "Hectares") %>%
  setObsVar(name = "production", unit = "t", columns = 10,
            key = 11, value = "Metric Tonnes")

regTable(nation = "eth",
         level = 2,
         subset = "productionHarvested",
         dSeries = ds[1],
         gSeries = "gadm",
         schema = schema_eth_01,
         begin = 2007,
         end = 2018,
         archive = "Ethiopia - Sub-National Level 1.csv",
         archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Ethiopia%20-%20Sub-National%20Level%201.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Ethiopia.pdf",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


# new countrySTAT ----
schema_eth_02 <- setCluster (id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Ethiopia") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_eth_03 <- schema_eth_02 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "eth",
         level = 1,
         subset = "harvested",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_eth_03,
         begin = 2001,
         end = 2012,
         archive = "D3S_13965499136371106974771720318823722561.xlsx",
         archiveLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_eth_04 <- schema_eth_02 %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "eth",
         level = 1,
         subset = "livestockFemale",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_eth_04,
         begin = 2001,
         end = 2012,
         archive = "D3S_31356853048140928389096807767536393185.xlsx",
         archiveLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_eth_05 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Ethiopia") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3) %>%
  setObsVar(name = "area", unit = "ha", factor = 1000, columns = 6)

regTable(nation = "eth",
         level = 1,
         subset = "landUse",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_eth_05,
         begin = 2001,
         end = 2012,
         archive = "D3S_14746020610584912317797721515709421344.xlsx",
         archiveLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_eth_06 <- schema_eth_02 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "eth",
         level = 1,
         subset = "production",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_eth_06,
         begin = 2001,
         end = 2010,
         archive = "D3S_12880669803077121117116692195004375319.xlsx",
         archiveLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


# csa ----
# regTable(nation = "Ethiopia",
#          level = 2,
#          dSeries = ds[5],
#          gSeries = "spam",
#          schema = 209,
#          begin = 2000,
#          end = 2010,
#          archive = "ethiopia.zip|2003 AGRICULTURE.pdf_2004 agriculture-1.pdf_Section D -  Agriculture-1.pdf",
#          update = myUpdate,
#          overwrite = myOverwrite)
#OBS.: three files used for the creation of headcount. Files names divided by underline.


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
