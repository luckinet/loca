# script arguments ----
#
thisNation <- "Kenya"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("countrySTAT", "agCensus", "spam")
gs <- c("gadm", "agCensus", "spam")

# register geometries ----
#
# agCensus ----
# regGeometry(gSeries = gs[2],
#             level = 3,
#             nameCol = "NAME2_",
#             archive = "angola.zip|afr_ad1.shp",
#             archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
#             nextUpdate = "unknown",
#             updateFrequency = "notPlanned",
#             update = TRUE)
#
# regGeometry(gSeries = gs[2],
#             level = 2,
#             nameCol = "NAME1_",
#             archive = "angola.zip|afr_ad2.shp",
#             archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
#             nextUpdate = "unknown",
#             updateFrequency = "notPlanned",
#             update = TRUE)


# register census tables ----
#
# Tables that have level 2 and 3 have gemetries that were actual before 2010, they can be found in agCensus.
# agCensus geometries need to be registered.
# Gadm geometries contain the updated administrative boundaries, which were applied after 2010.

# countrystat ----
schema_ken_00 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_ken_01 <- schema_ken_00 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "ken",
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[2],
         level = 2,
         begin = 2006,
         end = 2008,
         schema = schema_ken_01,
         archive = "114SPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=KEN&ta=114SPD015&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=KEN&ta=114SPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ken_02 <- schema_ken_00 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "ken",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[2],
         level = 2,
         begin = 2006,
         end = 2008,
         schema = schema_ken_02,
         archive = "114SPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=KEN&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=KEN&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_ken_03 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Kenya") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_ken_04 <- schema_ken_03 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6,
            key = 3, value = "Area Harvested") %>%
  setObsVar(name = "planted", unit = "ha", columns = 6,
            key = 3, value = "Area sown")

regTable(nation = "ken",
         subset = "harvestedPlanted",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 1,
         begin = 2001,
         end = 2013,
         schema = schema_ken_04,
         archive = "D3S_62065387851102482797729027739141358167.xlsx",
         archiveLink = "http://kenya.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://kenya.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_ken_05 <- schema_ken_03 %>%
  setFilter(rows = .find("^(01.)", col = 4)) %>%
  setObsVar(name = "production", unit = "t", columns = 6,
            key = 3, value = "Production quantity") %>%
  setObsVar(name = "production seeds", unit = "t", columns = 6,
            key = 3, value = "Seeds quantity")

regTable(nation = "ken",
         level = 1,
         subset = "prodAndProdSeeds",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ken_05,
         begin = 2001,
         end = 2013,
         archive = "D3S_25597083389488464538871539034222710277.xlsx",
         archiveLink = "http://kenya.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://kenya.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_ken_06 <-
  setIDVar(name = "al2", columns = 4) %>%
  setIDVar(name = "al3", columns = 6) %>%
  setIDVar(name = "year", value = "2009") %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = 7)

regTable(nation = "ken",
         level = 3,
         subset = "livestockCattle",
         dSeries = ds[1],
         gSeries = gs[2],
         schema = schema_ken_06,
         begin = 2009,
         end = 2009,
         archive = "114AAC020.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=KEN&ta=114AAC020&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=KEN&ta=114AAC020&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_ken_07 <-
  setIDVar(name = "al1", value = "Kenya") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3)

schema_ken_08 <- schema_ken_07 %>%
  setObsVar(name = "headcount", unit = "n", columns = 4)

regTable(nation = "ken",
         level = 1,
         subset = "livetsock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ken_08,
         begin = 2000,
         end = 2013,
         archive = "114CPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=KEN&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=KEN&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ken_09 <- schema_ken_07 %>%
  setObsVar(name = "area", unit = "ha", factor = 1000, columns = 4)

regTable(nation = "ken",
         level = 1,
         subset = "landUse",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ken_09,
         begin = 2007,
         end = 2007,
         archive = "114CLI010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=KEN&ta=114CLI010&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=KEN&ta=114CLI010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# agCensus----
# schema_agCensus1 <- makeSchema()
#
# regTable(nation = "Kenya",
#          level = 3,
#          subset = "wheat",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_agCensus1,
#          begin = 1964,
#          end = 2008,
#          archive = "kenya.zip|Kenya_Subnational_ProdHarvArea-1964-2008.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Kenya",
#          level = 3,
#          subset = "maize",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_agCensus1,
#          begin = 1964,
#          end = 2008,
#          archive = "kenya.zip|Kenya_Subnational_Maize_ProdHarvArea-1964-2008.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Kenya",
#          level = 3,
#          subset = "rice",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_agCensus1,
#          begin = 1964,
#          end = 2008,
#          archive = "kenya.zip|Kenya_Subnational_Rice_ProdHarvArea-1964-2008.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# schema_agCensus2 <- makeSchema()
#
# regTable(nation = "Kenya",
#          level = 2,
#          subset = "maize",
#          dSeries = ds[2]
#          gSeries = gs[2],
#          schema = schema_agCensus2,
#          begin = 2005,
#          end = 2008,
#          archive = "kenya.zip|Maize_Kenya_Prod_2005-2008.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Kenya",
#          level = 2,
#          subset = "rice",
#          dSeries = ds[2],
#          gSeries = gs[2]
#          schema = schema_agCensus2,
#          begin = 2005,
#          end = 2008,
#          archive = "kenya.zip|Rice_Kenya_ProdHarvArea_2005-2008.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Kenya",
#          level = 2,
#          subset = "wheat",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_agCensus2,
#          begin = 2005,
#          end = 2008,
#          archive = "kenya.zip|Wheat_Kenya_ProdHarvArea_2005-2008.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)

# spam----
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Kenya",
#          level = 2,
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = schema_spam1,
#          begin = 2006,
#          end = 2008,
#          archive = "kenya.zip|2006-2008_harvArea_level2.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Kenya",
#          level = 2,
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = schema_spam1,
#          begin = 2006,
#          end = 2008,
#          archive = "kenya.zip|2006-2008_prod_level2.csv",
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
# normGeometry(nation = thisNation,
#              pattern = gs[2],
#              outType = "gpkg",
#              update = updateTables)


# normalise census tables ----
#
normTable(pattern = ds[1],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)

