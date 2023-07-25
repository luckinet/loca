# script arguments ----
#
thisNation <- "Niger"

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
## countryStat ----
schema_ner_00 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_ner_01 <- schema_ner_00 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "ner",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2000,
         end = 2011,
         schema = schema_ner_01,
         archive = "158SPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD010&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ner_02 <- schema_ner_00 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "ner",
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2000,
         end = 2011,
         schema = schema_ner_02,
         archive = "158SPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD015&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ner_03 <- schema_ner_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 6)

regTable(nation = "ner",
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1996,
         end = 2002,
         schema = schema_ner_03,
         archive = "158SPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD016&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ner_04 <- schema_ner_00 %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "ner",
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1970,
         end = 2010,
         schema = schema_ner_04,
         archive = "158SPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD035&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD035&tr=-2",
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

