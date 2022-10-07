# script arguments ----
#
thisNation <- "Zimbabwe"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("faoDatalab")
gs <- c("gadm")


# register geometries ----
#


# register census tables ----
#
## faoDatalab ----
schema_zwe_01 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 7) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 10,
            key = 9, value = "Harvested Area") %>%
  setObsVar(name = "production", unit = "t", columns = 10,
            key = 9, value = "Production")

regTable(nation = "zwe",
         level = 2,
         subset = "harvestProd",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_zwe_01,
         begin = 2012,
         end = 2015,
         archive = "Zimbabwe - Sub-National Level 1.csv",
         archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Zimbabwe%20-%20Sub-National%20Level%201.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Zimbabwe.pdf",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


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


