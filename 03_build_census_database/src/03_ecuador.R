# script arguments ----
#
thisNation <- "Ecuador"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- FALSE
overwriteTables <- FALSE


# register dataseries ----
#
ds <- c("spam")
gs <- c("spam")


# register geometries ----
#


# register census tables ----
#


# spam----
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "permanentCrop",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "LAC.zip|bdd_espac_2009.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "permanentCrop",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|bdd_espac_2010.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "permanentCrop",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2011,
#          end = 2011,
#          archive = "LAC.zip|bdd_espac_2011.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "tempCrop",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "LAC.zip|bdd_espac_2009.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "tempCrop",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|bdd_espac_2010.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "tempCrop",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2011,
#          end = 2011,
#          archive = "LAC.zip|bdd_espac_2011.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "forest",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "LAC.zip|bdd_espac_2009.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "forest",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|bdd_espac_2010.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "forest",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2011,
#          end = 2011,
#          archive = "LAC.zip|bdd_espac_2011.zip",
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
# normTable(pattern = ds[1],
#           al1 = thisNation,
#           outType = "rds",
#           update = updateTables)

