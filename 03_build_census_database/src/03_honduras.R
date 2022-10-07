# script arguments ----
#
thisNation <- "Honduras"
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
# regTable(nation = "Honduras",
#          level = 2,
#          subset = "coffee",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "LAC.zip|Coffee 3.1.3.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Honduras",
#          level = 2,
#          subset = "coffee",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|Coffee 3.1.3.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Honduras",
#          level = 1,
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 1992,
#          end = 2010,
#          archive = "LAC.zip|Honduras_2017.10.18.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Honduras",
#          level = 1,
#          subset = "annualCrops",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2007,
#          end = 2008,
#          archive = "LAC.zip|CULT ANUAL.pdf",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Honduras",
#          level = 1,
#          subset = "permCrops",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2007,
#          end = 2008,
#          archive = "LAC.zip|CULT PERM.pdf",
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


