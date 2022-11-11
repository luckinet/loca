# script arguments ----
#
thisNation <- "Rwanda"
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
schema_rwa_01 <-
  setIDVar(name = "al3", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5) %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "rwa",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 2007,
         end = 2009,
         schema = schema_rwa_01,
         archive = "184SPD110.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=RWA&ta=184SPD110&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=RWA&ta=184SPD110&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_rwa_02 <-
  setIDVar(name = "al3", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5) %>%
  setIDVar(name = "season", columns = 7) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 8)

regTable(nation = "rwa",
         level = 3,
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_rwa_02,
         begin = 2007,
         end = 2010,
         archive = "184MIN001.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=RWA&ta=184MIN001&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=RWA&ta=184MIN001&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_rwa_03 <-
  setIDVar(name = "al1", value = "Rwanda") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3)

schema_rwa_04 <- schema_rwa_03 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 4)

regTable(nation = "rwa",
         level = 1,
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_rwa_04,
         begin = 2002,
         end = 2013,
         archive = "184CPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD015&tr=-2",
         updateFrequency = "daily",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_rwa_05 <- schema_rwa_03 %>%
  setObsVar(name = "production", unit = "t", columns = 4)

regTable(nation = "rwa",
         level = 1,
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_rwa_05,
         begin = 2002,
         end = 2013,
         archive = "184CPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=RWA&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_rwa_06 <- schema_rwa_03 %>%
  setObsVar(name = "planted", unit = "ha", columns = 4)

regTable(nation = "rwa",
         level = 1,
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_rwa_06,
         begin = 2002,
         end = 2013,
         archive = "184CPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD016&tr=-2",
         updateFrequency = "daily",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_rwa_07 <- schema_rwa_03 %>%
  setObsVar(name = "headcount", unit = "n", columns = 4)

regTable(nation = "rwa",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_rwa_07,
         begin = 1999,
         end = 2012,
         archive = "184CPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD035&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD035&tr=-2",
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


