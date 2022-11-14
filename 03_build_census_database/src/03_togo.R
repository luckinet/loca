# script arguments ----
#
thisNation <- "Togo"
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
schema_tgo_00 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_tgo_01 <- schema_tgo_00 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "tgo",
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2001,
         end = 2010,
         schema = schema_tgo_01,
         archive = "217SPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=TGO&ta=217SPD015&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=TGO&ta=217SPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_tgo_02 <- schema_tgo_00 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "tgo",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2001,
         end = 2011,
         schema = schema_tgo_02,
         archive = "217SPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=TGO&ta=217SPD010&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=TGO&ta=217SPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_tgo_03 <-
  setIDVar(name = "al1", value = "Togo") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3)

schema_tgo_04 <- schema_tgo_03 %>%
  setObsVar(name = "planted", unit = "ha", columns = 4)

regTable(nation = "tgo",
         level = 1,
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_tgo_04,
         begin = 2001,
         end = 2014,
         archive = "217CPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=TGO&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_tgo_05 <- schema_tgo_03 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 4)

regTable(nation = "tgo",
         level = 1,
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_tgo_05,
         begin = 2001,
         end = 2017,
         archive = "217CPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=TGO&ta=217CPD015&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=TGO&ta=217CPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_tgo_06 <- schema_tgo_03 %>%
  setObsVar(name = "production", unit = "t", columns = 4)

regTable(nation = "tgo",
         level = 1,
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_tgo_06,
         begin = 2001,
         end = 2017,
         archive = "217CPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=TGO&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_tgo_07 <- schema_tgo_03 %>%
  setObsVar(name = "headcount", unit = "n", columns = 4)

regTable(nation = "tgo",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_tgo_07,
         begin = 2000,
         end = 2014,
         archive = "217CPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=TGO&ta=217CPD035&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=TGO&ta=217CPD035&tr=-2",
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

