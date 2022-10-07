# script arguments ----
#
thisNation <- "Ethiopia"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- FALSE
overwriteTables <- FALSE


# register dataseries ----
#
ds <- c("faoDatalab", "countrySTAT", "spam", "worldbank", "csa")
gs <- c("gadm", "spam")


# register geometries ----
#


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

# worldBank----
# regTable(nation = "Ethiopia",
#          level = 1,
#          subset= "forestry",
#          dSeries = ds[4],
#          gSeries = gs[2],
#          schema = ,
#          begin = 1993,
#          end = 2016,
#          archive = "ethiopia.zip|forests level 1 93-2016.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)

# csa ----
# regTable(nation = "Ethiopia",
#          level = 2,
#          dSeries = ds[5],
#          gSeries = gs[2],
#          schema = 209,
#          begin = 2000,
#          end = 2010,
#          archive = "ethiopia.zip|2003 AGRICULTURE.pdf_2004 agriculture-1.pdf_Section D -  Agriculture-1.pdf",
#          update = myUpdate,
#          overwrite = myOverwrite)
#OBS.: three files used for the creation of headcount. Files names divided by underline.

# spam----
# regTable(nation = "Ethiopia",
#          level = 3,
#          dSeries = ds[3],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2005,
#          end = 2007,
#          archive = "ethiopia.zip|prod.level3.2005-2007.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Ethiopia",
#          level = 3,
#          dSeries = ds[3],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2005,
#          end = 2007,
#          archive = "ethiopia.zip|Harvarea.level3.2005-2007.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Ethiopia",
#          level = 3,
#          dSeries = ds[3],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2011,
#          end = 2011,
#          archive = "ethiopia.zip|prodHarvarea.level3.2009.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Ethiopia",
#          level = 3,
#          dSeries = ds[3],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "ethiopia.zip|prodHarvarea.level3.2009.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Ethiopia",
#          level = 3,
#          dSeries = ds[3],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "ethiopia.zip|prodHarvarea.level3.2009.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Ethiopia",
#          level = 1,
#          dSeries = ds[3],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2013,
#          end = 2013,
#          archive = "ethiopia.zip|Main crops 2013 - Production.level1.harv.prod.yiedl.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Ethiopia",
#          level = 1,
#          dSeries = ds[3],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2001,
#          end = 2016,
#          archive = "ethiopia.zip|lvel1.yield.2001-2016.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)


# harmonise commodities ----
#
for(i in seq_along(ds)){

  tibble(new = get_variable(variable = "commodities", dataseries = ds[i])) %>%
    match_ontology(table = ., columns = "new", dataseries = ds[i], ontology = ontoDir)

}


# normalise geometries ----
#
# not needed


# normalise census tables ----
#
normTable(pattern = ds[1],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)

normTable(pattern = ds[2],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)

normTable(pattern = ds[3],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)

normTable(pattern = ds[4],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)

normTable(pattern = ds[5],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)
