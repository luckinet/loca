# script arguments ----
#
thisNation <- "Uruguay"
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
# spam ----
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Uruguay",
#          level = 2,
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2003,
#          end = 2011,
#          archive = "LAC.zip|DIEA-Anuario-2012web.xlsx",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Uruguay",
#          level = 2,
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2011,
#          end = 2011,
#          archive = "LAC.zip|censo2011.xlsx",
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
# not needed


# normalise census tables ----
#
normTable(pattern = ds[1],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)

