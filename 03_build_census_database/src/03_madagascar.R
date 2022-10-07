# script arguments ----
#
thisNation <- "Madagascar"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("countrySTAT")
gs <- c("gadm")


# register geometries ----
#


# register census tables ----
#
# countrySTAT----
schema_mdg_01 <- setCluster(id = "al1", left = 1, top = 4) %>%
  setIDVar(name = "al1", value = "Madagascar") %>%
  setIDVar(name = "al2", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 7) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 8)

regTable(nation = "mdg",
         level = 2,
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_01,
         begin = 1964,
         end = 1986,
         archive = "D3S_64447202218806652856166856495301933616.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mdg_02 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Madagascar") %>%
  setIDVar(name = "al4", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 7) %>%
  setObsVar(name = "production", unit = "t", columns = 8,
            key = 11, value = "ton") %>%
  setObsVar(name = "planted", unit = "ha", columns = 8,
            key = 11, value = "Ha")

regTable(nation = "mdg",
         level = 4,
         subset = "prodPlan",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_02,
         begin = 2009,
         end = 2009,
         archive = "D3S_90674278993076353238958707605935270416.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mdg_03 <- setCluster(id = "al1", left = 1, top = 4) %>%
  setIDVar(name = "al1", value = "Madagascar") %>%
  setIDVar(name = "al2", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 7) %>%
  setObsVar(name = "production", unit = "t", columns = 8)

regTable(nation = "mdg",
         level = 2,
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_03,
         begin = 1964,
         end = 1986,
         archive = "D3S_56243535853101845546695163161899719705.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mdg_04 <- setCluster(id = "al1",  left = 1, top = 4) %>%
  setIDVar(name = "al1", value = "Madagascar") %>%
  setIDVar(name = "al3", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 7) %>%
  setObsVar(name = "production", unit = "t", columns = 8)

regTable(nation = "mdg",
         level = 3,
         subset = "produOther",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_04,
         begin = 2012,
         end = 2015,
         archive = "D3S_69161223103187681656425352443316296374.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# table is not registered, because geometries are level 5, which is not registered too
# schema_mdg_05 <- setCluster(id = "al1", left = 1, top = 4) %>%
#   setIDVar(name = "al1", value = "Madagascar") %>%
#   setIDVar(name = "al4", columns = 7) %>%
#   setIDVar(name = "year", columns = 1) %>%
#   setIDVar(name = "commodities", columns = 5) %>%
#   setObsVar(name = "production", unit = "t", columns = 8)
#
# regTable(nation = "mdg",
#          level = 5,
#          subset = "produSugarcane",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = schema_mdg_05,
#          begin = 1974,
#          end = 2016,
#          archive = "D3S_69897740550557345037453757881787160018.xlsx",
#          archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
#          updateFrequency = "unknown",
#          nextUpdate = "unknown",
#          metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)


schema_mdg_06 <- setCluster(id = "al1", left = 1, top = 4) %>%
  setIDVar(name = "al1", value = "Madagascar") %>%
  setIDVar(name = "al4", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 7) %>%
  setObsVar(name = "production", unit = "t", columns = 8)

regTable(nation = "mdg",
         level = 4,
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_06,
         begin = 2005,
         end = 2005,
         archive = "D3S_64550167087486273416409038358197674790.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mdg_07 <- setCluster(id = "commodities", left = 1, top = 4) %>%
  setIDVar(name = "al3", columns = 3) %>%
  setIDVar(name = "al4", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", value = "maize") %>%
  setObsVar(name = "production", unit = "t", columns = 8)

regTable(nation = "mdg",
         level = 4,
         subset = "prodCorn",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_07,
         begin = 1993,
         end = 1999,
         archive = "D3S_2209040883653499635201010819365329327.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mdg_08 <- setCluster(id = "commodities", left = 1, top = 5) %>%
  setIDVar(name = "al3", columns = 3) %>%
  setIDVar(name = "al4", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", value = "maize") %>%
  setObsVar(name = "planted", unit = "ha", columns = 8)

regTable(nation = "mdg",
         level = 4,
         subset = "plantedCorn",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_08,
         begin = 1993,
         end = 1999,
         archive = "D3S_53236967799045296118166719066459221351.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mdg_09 <- setCluster(id = "al1", left = 1, top = 4) %>%
  setIDVar(name = "al1", value = "Madagascar") %>%
  setIDVar(name = "al3", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 7) %>%
  setObsVar(name = "production", unit = "t", columns = 8)

regTable(nation = "mdg",
         level = 3,
         subset = "prodRice",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_09,
         begin = 2005,
         end = 2015,
         archive = "D3S_69093813980769613567730207623041333933.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mdg_10 <- setCluster(id = "al1", left = 1, top = 4) %>%
  setIDVar(name = "al1", value = "Madagascar") %>%
  setIDVar(name = "al3", columns = 7) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5) %>%
  setObsVar(name = "headcount", unit = "n", columns = 8)

regTable(nation = "mdg",
         level = 3,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_10,
         begin = 2001,
         end = 2011,
         archive = "D3S_32688635813502157228252815877542769026.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mdg_11 <- setCluster(id = "al1", left = 1, top = 4) %>%
  setIDVar(name = "al1", value = "Madagascar") %>%
  setIDVar(name = "al4", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 7) %>%
  setObsVar(name = "headcount", unit = "n", columns = 10)

regTable(nation = "mdg",
         level = 4,
         subset = "cattle",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_11,
         begin = 2005,
         end = 2005,
         archive = "D3S_39116713278667949858222495511498067186.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mdg",
         level = 4,
         subset = "pig",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_11,
         begin = 2005,
         end = 2005,
         archive = "D3S_91328084517343533575926590442843060311.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mdg_12 <- setCluster(id = "commodities", left = 1, top = 5) %>%
  setIDVar(name = "al3", columns = 3) %>%
  setIDVar(name = "al4", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", value = "cassava") %>%
  setObsVar(name = "production", unit = "t", columns = 8)

regTable(nation = "mdg",
         level = 4,
         subset = "prodCassava",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_12,
         begin = 1991,
         end = 1999,
         archive = "D3S_64323403588591749304889734404410682082.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mdg_13 <- setCluster(id = "commodities", left = 1, top = 5) %>%
  setIDVar(name = "al3", columns = 3) %>%
  setIDVar(name = "al4", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", value = "Sweet potatoes") %>%
  setObsVar(name = "production", unit = "t", columns = 8)

regTable(nation = "mdg",
         level = 4,
         subset = "prodPotatoSweet",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_13,
         begin = 1993,
         end = 1999,
         archive = "D3S_24607441580531584646795471104708030468.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mdg_14 <- setCluster(id = "commodities", left = 1, top = 5) %>%
  setIDVar(name = "al3", columns = 3) %>%
  setIDVar(name = "al4", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", value = "Sweet potatoes") %>%
  setObsVar(name = "planted", unit = "ha", columns = 8)

regTable(nation = "mdg",
         level = 4,
         subset = "planPotatoSweet",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_14,
         begin = 1993,
         end = 1999,
         archive = "D3S_16987491657371657307271353806247405972.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mdg_15 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setFilter(rows = .find("Madagascar", col = 3), invert = TRUE) %>%
  setIDVar(name = "al1", value = "Madagascar") %>%
  setIDVar(name = "al3", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5) %>%
  setObsVar(name = "area", unit = "ha", columns = 6)

regTable(nation = "mdg",
         level = 3,
         subset = "forestArea",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_15,
         begin = 1990,
         end = 2013,
         archive = "D3S_16053360586544061987204659261297125058.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mdg_16 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Madagascar") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 7) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 8)

regTable(nation = "mdg",
         level = 1,
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_16,
         begin = 2000,
         end = 2011,
         archive = "D3S_28097412657599123237112416345720099629.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mdg_17 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Madagascar") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 7) %>%
  setObsVar(name = "production", unit = "t", columns = 8)

regTable(nation = "mdg",
         level = 1,
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_17,
         begin = 2000,
         end = 2015,
         archive = "D3S_31975385462921452156966460605287658352.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mdg",
         level = 1,
         subset = "productionOthers",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mdg_17,
         begin = 2000,
         end = 2010,
         archive = "D3S_73070711206484549165884078528559759933.xlsx",
         archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


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

