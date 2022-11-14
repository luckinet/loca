# script arguments ----
#
thisNation <- "Australia"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("abs", "spam", "agCensus")
gs <- c("gadm", "spam", "agCensus")


# register dataseries ----
#
regDataseries(name = ds[1],
              description = "Australia Bureau of Statistics",
              homepage = "https://data.gov.au/organisations/org-dga-693e2449-3c31-468b-a0ab-d27a8af64856",
              licence_link = "https://creativecommons.org/licenses/by/3.0/au/",
              licence_path = "unknown",
              update = updateTables)


# register geometries ----
#


# register census tables ----
#
## abs ----
schema_abs_00 <- setCluster(id = "al1", left = 31, top = 10, height = 17) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al1", value = "Australia") %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", columns = c(31:135), rows = 6) %>%
  setIDVar(name = "commodities", columns = 1, rows = 3, split = ".*(?= for)")

schema_abs_00_01 <- schema_abs_00 %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(31:135),
            key = 2, value = "ha") %>%
  setObsVar(name = "production", unit = "t", columns = c(31:135),
            key = 2, value = "tonnes")

# table has data from 1861, but tables with values before 1900 are not accepted.
regTable(nation = "aus",
         level = 2,
         subset = "harvProdWheat",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_abs_00_01,
         begin = 1900,
         end = 2004,
         archive = "WheatAustraliaRaw.xls",
         archiveLink = "https://www.abs.gov.au/statistics",
         updateFrequency = "yearly",
         nextUpdate = "unknown",
         metadataLink = "https://www.abs.gov.au/statistics",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_abs_00_02 <- schema_abs_00 %>%
  setIDVar(name = "year", columns = c(31:134), rows = 6) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(31:134),
            key = 2, value = "ha") %>%
  setObsVar(name = "production", unit = "t", columns = c(31:134),
            key = 2, value = "tonnes")

# table has data from 1861, but tables with values before 1900 are not accepted.
regTable(nation = "aus",
         level = 2,
         subset = "harvProdOat",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_abs_00_02,
         begin = 1900,
         end = 2003,
         archive = "AUS_historical.xls",
         archiveLink = "https://www.abs.gov.au/statistics",
         updateFrequency = "yearly",
         nextUpdate = "unknown",
         metadataLink = "https://www.abs.gov.au/statistics",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "aus",
         level = 2,
         subset = "harvProdBarley",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_abs_00_02,
         begin = 1900,
         end = 2003,
         archive = "AUS_historical.xls",
         archiveLink = "https://www.abs.gov.au/statistics",
         updateFrequency = "yearly",
         nextUpdate = "unknown",
         metadataLink = "https://www.abs.gov.au/statistics",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "aus",
         level = 2,
         subset = "harvProdMaize",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_abs_00_02,
         begin = 1900,
         end = 2003,
         archive = "AUS_historical.xls",
         archiveLink = "https://www.abs.gov.au/statistics",
         updateFrequency = "yearly",
         nextUpdate = "unknown",
         metadataLink = "https://www.abs.gov.au/statistics",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "aus",
         level = 2,
         subset = "harvProdPotato",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_abs_00_02,
         begin = 1900,
         end = 2003,
         archive = "AUS_historical.xls",
         archiveLink = "https://www.abs.gov.au/statistics",
         updateFrequency = "yearly",
         nextUpdate = "unknown",
         metadataLink = "https://www.abs.gov.au/statistics",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_abs_01 <- setCluster(id = "al1", left = 19, top = 7, height = 10) %>%
  setFilter(rows = .find("Australia", col = 1), invert = TRUE) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al1", value = "Australia") %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", columns = c(19:122), rows = 6) %>%
  setIDVar(name = "commodities", columns = 1, rows = 3, split = ".*(?= no)") %>%
  setObsVar(name = "headcount", unit = "n", columns = c(19:122))

regTable(nation = "aus",
         level = 2,
         subset = "cattle",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_abs_01,
         begin = 1900,
         end = 2003,
         archive = "AUS_historical.xls",
         archiveLink = "https://www.abs.gov.au/statistics",
         updateFrequency = "yearly",
         nextUpdate = "unknown",
         metadataLink = "https://www.abs.gov.au/statistics",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "aus",
         level = 2,
         subset = "sheep",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_abs_01,
         begin = 1900,
         end = 2003,
         archive = "AUS_historical.xls",
         archiveLink = "https://www.abs.gov.au/statistics",
         updateFrequency = "yearly",
         nextUpdate = "unknown",
         metadataLink = "https://www.abs.gov.au/statistics",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "aus",
         level = 2,
         subset = "pig",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_abs_01,
         begin = 1900,
         end = 2003,
         archive = "AUS_historical.xls",
         archiveLink = "https://www.abs.gov.au/statistics",
         updateFrequency = "yearly",
         nextUpdate = "unknown",
         metadataLink = "https://www.abs.gov.au/statistics",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "aus",
         level = 2,
         subset = "horse",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_abs_01,
         begin = 1900,
         end = 2003,
         archive = "AUS_historical.xls",
         archiveLink = "https://www.abs.gov.au/statistics",
         updateFrequency = "yearly",
         nextUpdate = "unknown",
         metadataLink = "https://www.abs.gov.au/statistics",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# spam----
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Australia",
#          level = 1,
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|Australia_level1_areaProdYieldHeadcount_2013-2014.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "victoria",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_victoria.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "victoria",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_victoria.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "australianCapitalTerritory",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_australianCapitalTerritory.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "australianCapitalTerritory",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_australianCapitalTerritory.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "newWales",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_newWales.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "newWales",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_newWales.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "northernTerritory",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_northernTerritory.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "northernTerritory",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_northernTerritory.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "queensland",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_queensland.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "queensland",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_queensland.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "southAustralia",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_southAustralia.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "southAustralia",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_southAustralia.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "tasmania",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_tasmania.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "tasmania",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_tasmania.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "westernAustralia",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_westernAustralia.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "westernAustralia",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_westernAustralia.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# # agCensus ----
# schema_agCensus1 <- makeSchema()
#
# regTable(nation = "Australia",
#          level = 2,
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = ,
#          begin = 2006,
#          end = 2006,
#          archive = "australia.zip|Australia_Area_2006.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 2,
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = ,
#          begin = 2007,
#          end = 2007,
#          archive = "australia.zip|Australia_Area_2007.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 2,
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = ,
#          begin = 2008,
#          end = 2008,
#          archive = "australia.zip|Australia_Area__Prod_2008.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "australia.zip|Australia_level3_area_2009.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "australia.zip|Australia_level3_prod_2009.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "australia.zip|Australia_level3_area_2010.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "australia.zip|Australia_level3_prod_2010.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 2,
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = ,
#          begin = 2006,
#          end = 2006,
#          archive = "australia.zip"|"Australia_Prod_2006.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 2,
#          subset = "fuits&others",
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = ,
#          begin = 2007,
#          end = 2007,
#          archive = "australia.zip"|"Australia_Prod_2007.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 2,
#          subset = "fuits&others",
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = ,
#          begin = 2008,
#          end = 2008,
#          archive = "australia.zip"|"Australia_Prod_2008.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 2,
#          subset = "fuits&others",
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "australia.zip"|"Australia_Prod_2009.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 2,
#          subset = "fuits&others",
#          dSeries = ds[3],
#          gSeries = gs[3],
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "australia.zip"|"Australia_Prod_2010.csv",
#          update = updateTables,
#          overwrite = overwriteTables)


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

# normTable(pattern = ds[3],
#           al1 = thisNation,
#           outType = "rds",
#           update = updateTables)
