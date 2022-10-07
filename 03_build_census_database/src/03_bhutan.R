# script arguments ----
#
thisNation <- "Bhutan"
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
schema_btn_00 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_btn_01 <- schema_btn_00 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "btn",
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2000,
         end = 2012,
         schema = schema_btn_01,
         archive = "018SPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD015&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_btn_02 <- schema_btn_00 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "btn",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2000,
         end = 2012,
         schema = schema_btn_02,
         archive = "018SPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD010&tr=-2",
         updateFrequency = "daily",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_btn_03 <- schema_btn_00 %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "btn",
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin=  2000,
         end = 2012,
         schema = schema_btn_03,
         archive = "018SPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD035&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD035&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_btn_04 <-
  setIDVar(name = "al1", value = "Bhutan") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3) %>%
  setObsVar(name = "planted", unit = "ha", columns = 4)

regTable(nation = "btn",
         level = 1,
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_btn_04,
         begin = 2005,
         end = 2013,
         archive = "018CPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BTN&ta=018CPD016&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BTN&ta=018CPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_btn_05 <-
  setIDVar(name = "al1", value = "Bhutan") %>%
  setIDVar(name = "year", value = "2010") %>%
  setIDVar(name = "commodities", columns = 3) %>%
  setObsVar(name = "area", unit = "ha", factor = 1000, columns = 4)

regTable(nation = "btn",
         subset = "landUse",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 1,
         begin = 2010,
         end = 2010,
         schema = schema_btn_05,
         archive = "018CLI010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BTN&ta=018CLI010&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BTN&ta=018CLI010&tr=-2",
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


