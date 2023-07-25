# script arguments ----
#
thisNation <- "Cuba"
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
# regTable(nation = "Cuba",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agricultura en Cifras Cuba 2010.xlsx",
#          update = myUpdate)


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


