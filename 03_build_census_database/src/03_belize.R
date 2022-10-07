# script arguments ----
#
thisNation <- "Belize"
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
# meta_spam97 <- makeSchema(
#   #No period shown
#   list(clusters = list(top = 1, left = NULL, width = NULL, height = NULL,
#                        id = NULL),
#        variables = list(territories =
#                           list(type = "id", name = "al",
#                                row = NULL, col = c(al2 = 4), rel = FALSE),
#                         commodities =
#                           list(type = "id", name = NULL,
#                                row = 1, col = c(7:49), rel = FALSE),
#                         harvested =
#                           list(type = "values", unit = "ha", factor = 1,
#                                row = NULL, col = c(7:49), rel = FALSE,
#                                key = "Element", value = "Harvested Area"))))
#
# regTable(nation = "Belize",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = meta_spam97,
#          begin = 2005,
#          end = 2005,
#          archive = "LAC.zip|stat_area_2005.csv",
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
# normTable(pattern = ds[1],
#           al1 = thisNation,
#           outType = "rds",
#           update = updateTables)


