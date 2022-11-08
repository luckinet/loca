# script arguments ----
#
thisNation <- "Nicaragua"
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
# regTable(nation = "Nicaragua",
#          level = 3,
#          subset= "maize",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "LAC.zip|Ma├нz y Frijol ciclo 2010-2011 (CIAT).xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Nicaragua",
#          level = 3,
#          subset= "beans",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "LAC.zip|Ma├нz y Frijol ciclo 2010-2011 (CIAT).xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Nicaragua",
#          level = 3,
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2001,
#          end = 2001,
#          archive = "LAC.zip|nicaragua granos municipios 2001.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Nicaragua",
#          level = 2,
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "LAC.zip|Informe Final IV Cenagro.xlsx",
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
