# script arguments ----
#
thisNation <- "Guatemala"
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
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "sugarCane",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2011,
#          end = 2012,
#          archive = "LAC.zip|Guatemala_Production_2012.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "sugarCane",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2012,
#          end = 2013,
#          archive = "LAC.zip|Guatemala_Production_2013.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "rice",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2011,
#          end = 2012,
#          archive = "LAC.zip|Guatemala_Production_2012.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "rice",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2012,
#          end = 2013,
#          archive = "LAC.zip|Guatemala_Production_2013.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "teaCitronele",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2011,
#          end = 2012,
#          archive = "LAC.zip|Guatemala_Production_2012.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "teaCitronele",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2012,
#          end = 2013,
#          archive = "LAC.zip|Guatemala_Production_2013.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "forest",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2011,
#          end = 2012,
#          archive = "LAC.zip|Guatemala_Production_2012.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "forest",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2012,
#          end = 2013,
#          archive = "LAC.zip|Guatemala_Production_2013.xls",
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



