# script arguments ----
#
thisNation <- "Dominican Republic"
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
# regTable(nation = "Dominican Republic",
#          level = 2,
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2010,
#          end = 2014,
#          archive = "LAC.zip|2.14-Producci├│n-Anual-por-Regional-2010-2014..xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Dominican Republic",
#          level = 2,
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2010,
#          end = 2014,
#          archive = "LAC.zip|Superficie Cosechada Anual por Regional, 2010-2014.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Dominican Republic",
#          level = 2,
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2010,
#          end = 2014,
#          archive = "LAC.zip|Superficie Sembrada Anual por Regional, 2010-2014.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Dominican Republic",
#          level = 2,
#          subset = "bajoAmbiente",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2009,
#          end = 2014,
#          archive = "LAC.zip|superficie_cultivada_bajo_ambiente_protegido__2009-2014.xlsx",
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



