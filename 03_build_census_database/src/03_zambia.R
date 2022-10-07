# script arguments ----
#
thisNation <- "Zambia"
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
## countrySTAT ----
schema_zmb_00 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_zmb_01 <- schema_zmb_00 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "zmb",
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2000,
         end = 2004,
         schema = schema_zmb_01,
         archive = "251SPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD015&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_zmb_02 <- schema_zmb_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 6)

regTable(nation = "zmb",
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2000,
         end = 2015,
         schema = schema_zmb_02,
         archive = "251SPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD016&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_zmb_03 <- schema_zmb_00 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "zmb",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2000,
         end = 2015,
         schema = schema_zmb_03,
         archive = "251SPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD010&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_zmb_04 <- schema_zmb_00 %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "zmb",
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2000,
         end = 2008,
         schema = schema_zmb_04,
         archive = "251SPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD035&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD035&tr=-2",
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


