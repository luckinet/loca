# script arguments ----
#
thisNation <- "Republic of Congo"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("countrySTAT", "cnsee")
gs <- c("gadm")

regDataseries(name = ds[2],
              description = "Centre National de la Statistique et des Etudes Economiques",
              homepage = "http://www.cnsee.org/",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)


# register geometries ----
#


# register census tables ----
#
# countrystat ----
schema_cog_00 <-
  setIDVar(name = "al1", value = "Republic of Congo") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3)

schema_cog_01 <- schema_cog_00 %>%
  setObsVar(name = "production", unit = "t", columns = 4)

regTable(nation = "cog",
         level = 1,
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_cog_01,
         begin = 2001,
         end = 2010,
         archive = "046CPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD010&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_cog_02 <- schema_cog_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 4)

regTable(nation = "cog",
         level = 1,
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_cog_02,
         begin = 1985,
         end = 1996,
         archive = "046CPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD016&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_cog_03 <- schema_cog_00 %>%
  setObsVar(name = "headcount", unit = "n", columns = 4)

regTable(nation = "cog",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_cog_03,
         begin = 1988,
         end = 2010,
         archive = "046CPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD035&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD035&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## cnsee ----
schema_cog_04 <- setCluster(id = "al1", left = 5, top = 2) %>%
  setIDVar(name = "al1", value = "Republic of Congo") %>%
  setIDVar(name = "year", columns = c(5:9), rows = 2) %>%
  setIDVar(name = "commodities", value = "forest") %>%
  setObsVar(name = "area", unit = "ha", factor = 1000, columns = c(5:9))

regTable(nation = "cog",
         level = 1,
         subset = "forest",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_cog_04,
         begin = 2005,
         end = 2009,
         archive = "Annuaire Statistique du Congo 2009.pdf|p.307",
         archiveLink = "http://www.cnsee.org/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://www.cnsee.org/",
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

normTable(pattern = ds[2],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)

