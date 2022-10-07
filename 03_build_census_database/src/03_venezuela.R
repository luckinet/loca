# script arguments ----
#
thisNation <- "Venezuela"
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
# regTable(nation = "Venezuela",
#          level = 3,
#          dSeries = ds[1],
#          gSeries = gs[1],
#          variable = c("production"),
#          schema = ,
#          begin = 2008,
#          end = 2008,
#          archive = "LAC.zip|Venezuela_level2_2016.04.20_UWS.xlsx",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Venezuela",
#          level = 3,
#          dSeries = ds[1],
#          gSeries = gs[1],
#          variable = c("planted_area"),
#          schema = ,
#          begin = 2008,
#          end = 2008,
#          archive = "LAC.zip|Venezuela_level2_2016.04.20_UWS.xlsx",
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
#
normTable(pattern = ds[1],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)
