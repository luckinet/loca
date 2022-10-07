# script arguments ----
#
thisNation <- "Nigeria"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("countrySTAT", "agCensus")
gs <- c("gadm")


# register geometries ----
#


# register census tables ----
#
# countrystat ----
schema_nga_00 <-
  setIDVar(name = "al2", columns = 4) %>%
  setIDVar(name = "year", columns = 5) %>%
  setIDVar(name = "commodities", columns = 2)

schema_nga_01 <- schema_nga_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 6)

regTable(nation = "nga",
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1995,
         end = 2012,
         schema = schema_nga_01,
         archive = "159SPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=NGA&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_nga_02 <- schema_nga_00 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "nga",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1995,
         end = 2012,
         schema = schema_nga_02,
         archive = "159SPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=NGA&tr=21",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_nga_03 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Nigeria") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_nga_04 <- schema_nga_03 %>%
  setObsVar(name = "planted", unit = "ha", columns = 6,
            key = 3, value = "Area sown") %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6,
            key = 3, value = "Area Harvested")

regTable(nation = "nga",
         level = 1,
         subset = "plantedHarvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_nga_04,
         begin = 1995,
         end = 2017,
         archive = "D3S_18068359945866645835594090130523560210.xlsx",
         archiveLink = "http://nigeria.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://nigeria.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_nga_05 <- schema_nga_03 %>%
  setFilter(rows = .find("Live..", col = 3)) %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "nga",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_nga_05,
         begin = 2000,
         end = 2010,
         archive = "D3S_36052193455802116654692282592282918066.xlsx",
         archiveLink = "http://nigeria.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://nigeria.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# agCensus ----
# schema_agCensus1 <- makeSchema()
#
# regTable(nation = "Nigeria",
#          level = 3,
#          subset = "Forestry",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2000,
#          end = 2018,
#          archive = "NGA.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          subset = "Forestry",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2000,
#          end = 2018,
#          archive = "NGA.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "nigeria.zip|NigeriaOtherCrops.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          subset = "cottonSeed",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2009,
#          end = 2011,
#          archive = "nigeria.zip|MergeAreaProduction.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          subset = "cottonSeed",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2009,
#          end = 2011,
#          archive = "nigeria.zip|MergeAreaProduction.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          subset = "cottonSeed",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2009,
#          end = 2011,
#          archive = "nigeria.zip|MergeAreaProduction.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          subset = "cottonSeed",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2009,
#          end = 2011,
#          archive = "nigeria.zip|MergeAreaProduction.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "nigeria.zip|NASS-2011",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          subset = "sugarCane",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1999,
#          end = 2010,
#          archive = "nigeria.zip|NASS-2011",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          subset = "oilPalm",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "nigeria.zip|NASS-2011",
#          update = myUpdate)


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

# normTable(pattern = ds[2],
#           al1 = thisNation,
#           outType = "rds",
#           update = updateTables)
