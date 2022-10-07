# script arguments ----
#
thisNation <- "Chile"
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
# regTable(nation = "Chile",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2003,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "fruits",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "fruits",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2012,
#          end = 2015,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "ARICA Y PARINACOTA",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "atacama",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "coquimbo",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "araucania",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "o`higgins",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "valparaiso",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "biobio",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "maule",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "rmSantiago",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2012,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2014,
#          end = 2015,
#          archive = "LAC.zip",
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



