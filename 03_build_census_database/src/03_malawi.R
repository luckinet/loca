# script arguments ----
#
thisNation <- "Malawi"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("countrySTAT")
gs <- c("gadm")


# register geometries ----
#


# register census tables ----
#
## countrystat ----
schema_mwi_00 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Malawi") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_mwi_01 <- schema_mwi_00 %>%
  setFilter(rows = .find("Live..", col = 3)) %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "mwi",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mwi_01,
         begin = 1975,
         end = 2015,
         archive = "D3S_35222218128324229028659037819008500474.xlsx",
         archiveLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mwi_02 <- schema_mwi_00 %>%
  setFilter(rows = .find("^(01..)", col = 4)) %>%
  setObsVar(name = "production", unit = "t", columns = 6,
            key = 3, value = "Production quantity") %>%
  setObsVar(name = "production seeds", unit = "t", columns = 6,
            key = 3, value = "Seeds quantity")

regTable(nation = "mwi",
         level = 1,
         subset = "prodAndProdSeeds",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mwi_02,
         begin = 1983,
         end = 2016,
         archive = "D3S_36347240044015309795312780492448875425.xlsx",
         archiveLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mwi_03 <- schema_mwi_00 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "mwi",
         level = 1,
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mwi_03,
         begin = 1983,
         end = 2013,
         archive = "D3S_50384267447891200108277099862048539897.xlsx",
         archiveLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
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

