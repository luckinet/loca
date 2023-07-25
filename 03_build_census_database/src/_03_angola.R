# script arguments ----
#
thisNation <- "Angola"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE

# register dataseries ----
#

ds <- c("countrySTAT", "agCensus", "spam", "worldBank")
gs <- c("gadm", "spam", "agCensus")


# register geometries ----
#
# agCensus----
# regGeometry(nation = "Angola",
#             gSeries = gs[2],
#             level = 3,
#             nameCol = "NAME2_",
#             archive = "angola.zip|afr_ad1.shp",
#             archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
#             updateFrequency = "notPlanned",
#             update = updateTables)
#
# regGeometry(nation = "Angola",
#             gSeries = gs[2],
#             level = 2,
#             nameCol = "NAME1_",
#             archive = "angola.zip|afr_ad2.shp",
#             archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
#             updateFrequency = "notPlanned",
#             update = updateTables)

# register census tables ----
#
# countrySTAT ----
schema_ago_00 <-
  setIDVar(name = "al2", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3)

schema_ago_01 <- schema_ago_00 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "ago",
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2001,
         end = 2014,
         schema = schema_ago_01,
         archive = "007SPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD015&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ago_02 <- schema_ago_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 6)

regTable(nation = "ago",
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2001,
         end = 2014,
         schema = schema_ago_02,
         archive = "007SPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD016&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ago_03 <- schema_ago_00 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "ago",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2001,
         end = 2014,
         schema = schema_ago_03,
         archive = "007SPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD010&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "ago",
         subset = "prodAnimalFeed",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2001,
         end = 2009,
         schema = schema_ago_03,
         archive = "007SPD025.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD025&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD025&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ago_04 <- schema_ago_00 %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "ago",
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2005,
         end = 2013,
         schema = schema_ago_04,
         archive = "007SPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD035&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD035&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ago_05 <- schema_ago_00 %>%
  setObsVar(name = "production seeds", unit = "t", columns = 6)

regTable(nation = "ago",
         subset = "prodSeeds",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2001,
         end = 2012,
         schema = schema_ago_05,
         archive = "007SPD020.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD020&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD020&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


# new countrySTAT ----
schema_ago_06 <- setCluster (id = "al1", left = 1, top = 6) %>%
  setIDVar(name = "al1", value = "Angola") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_ago_07 <- schema_ago_06 %>%
  setObsVar(name = "planted", unit = "ha", columns = 6,
            key = 3, value = "Area sown")%>%
  setObsVar(name = "harvested", unit = "ha", columns = 6,
            key = 3, value = "Area Harvested")

regTable(nation = "ago",
         level = 1,
         subset = "plantedHarvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ago_07,
         begin = 2002,
         end = 2015,
         archive = "D3S_74775277060499247506914652101975304319.xlsx",
         archiveLink = "http://angola.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ago_08 <- schema_ago_06 %>%
  setFilter(rows = .find("^(01).*", col = 4)) %>%
  setObsVar(name = "production", unit = "t", columns = 6,
            key = 3, value = "Production quantity") %>%
  setObsVar(name = "production seeds", unit = "t", columns = 6,
            key = 3, value = "Seeds quantity")

regTable(nation = "ago",
         level = 1,
         subset = "prodAndSeeds",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ago_08,
         begin = 2001,
         end = 2015,
         archive = "D3S_52070384980890289555543361154639173281.xlsx",
         archiveLink = "http://angola.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://angola.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# agCensus----
# schema_agCensus1 <- makeSchema()
#
# regTable(nation = "Angola",
#          level = 2,
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 1967,
#          end = 1968,
#          archive = "angola.zip|angola_1968_level2_harvProdYield.csv",
#          update = myUpdate,
#          overwrite = myoverwrite)

# spam----
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Angola",
#          level = 2,
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = ,
#          begin = 2009,
#          end = 2011,
#          archive = "angola.zip|level2_2009-2011_HarvArea.csv",
#          update = myUpdate,
#          overwrite = myoverwrite)
#
# regTable(nation = "Angola",
#          level = 2,
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = ,
#          begin = 2009,
#          end = 2011,
#          archive = "angola.zip|level2_2009-2011_prod.csv",
#          update = myUpdate,
#          overwrite = myoverwrite)
#
# regTable(nation = "Angola",
#          level = 2,
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = ,
#          begin = 1999,
#          end = 2012,
#          archive = "angola.zip|level2_1999-2012_ProdHarvAreaYield.csv",
#          update = myUpdate,
#          overwrite = myoverwrite)

# worldBank----
# schema_worldBank1 <- makeSchema()
#
# regTable(nation = "Angola",
#          level = 1,
#          subset = "forest",
#          dSeries = ds[4],
#          gSeries = gs[3],
#          schema = ,
#          begin = 1990,
#          end = 2016,
#          archive = "angola.zip|level1.forest.1990-2016.csv",
#          update = myUpdate)


# harmonise commodities ----
#
for(i in seq_along(ds)){

  tibble(new = get_variable(variable = "commodities", dataseries = ds[i])) %>%
    match_ontology(table = ., columns = "new", dataseries = ds[i], ontology = ontoDir)

}


# normalise geometries ----
#
# normGeometry(pattern = gs[3],
#              al1 = thisNation,
#              outType = "gpkg",
#              update = updateTables)


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
#
# normTable(pattern = ds[3],
#           al1 = thisNation,
#           outType = "rds",
#           update = updateTables)
#
# normTable(pattern = ds[4],
#           al1 = thisNation,
#           outType = "rds",
#           update = updateTables)
