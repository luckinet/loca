# script arguments ----
#
thisNation <- "Costa Rica"
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
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "rice",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2005,
#          end = 2010,
#          archive = "LAC.zip|rptAreaYProduccion_arroz.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset = "rice",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2009,
#          end = 2010,
#          archive = "LAC.zip|rptAreaYProduccion_arroz.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "rice",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "LAC.zip|rptAreaYProduccion_arroz.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "banana",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_banana.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "coffee",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_coffee.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "fruits",
#          dSeries = ds[1],
#          gSeries = gs[1]
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_fruits.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "tobacco",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_tobacco.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "sugarCane",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_sugarcane.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "rice",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_arroz.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "diverse",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_diverse.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "majorCrops",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_majorcrops.xls",
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



