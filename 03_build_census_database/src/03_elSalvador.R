# script arguments ----
#
thisNation <- "El Salvador"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("faoDatalab", "spam")
gs <- c("gadm", "spam")


# register geometries ----
#


# register census tables ----
#
# faoDatalab ----
schema_slv_01 <-
  setIDVar(name = "al2",columns = 3 ) %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 6) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 10,
            key = 11, value = "Hectares") %>%
  setObsVar(name = "production", unit = "t", columns = 10,
            key = 11, value = "Metric Tonnes")

regTable(nation = "slv",
         level = 2,
         subset = "crops",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_slv_01,
         begin = 2010,
         end = 2017,
         archive = "El Salvador - Sub-National Level 2.csv",
         archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/El%20Salvador%20-%20Sub-National%20Level%202.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20El%20Salvador.pdf",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# the following table does not have a proper regions, we do not have geometries for them
# regTable(nation = "slv",
#         level = 2,
#         subset = "crops",
#         dSeries = ds[1],
#         gSeries = "",
#         schema = schema_slv_faoDatalab_01,
#         begin = 2010,
#         end = 2017,
#         archive = "El Salvador - Sub-National Level 1.csv",
#         archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/El%20Salvador%20-%20Sub-National%20Level%201.csv",
#         updateFrequency = "annually",
#         nextUpdate = "unknown",
#         metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20El%20Salvador.pdf",
#         metadataPath = "unknown",
#         update = updateTables,
#         overwrite = overwriteTables)


# spam----
# schema_spam1 <- makeSchema()
#
# regTable(nation = "El Salvador",
#          level = 2,
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2006,
#          end = 2007,
#          archive = "LAC.zip|anuario de estadsticas agropecuarios 06-07.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "El Salvador",
#          level = 2,
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2009,
#          end = 2010,
#          archive = "LAC.zip|anuario estadstico 2009-2010.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "El Salvador",
#          level = 2,
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "LAC.zip|anuario de estadisticas agropecuarias 2010-2011.xlsx",
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



