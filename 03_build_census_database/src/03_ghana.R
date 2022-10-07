# script arguments ----
#
thisNation <- "Ghana"
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
schema_gha_00 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_gha_01 <- schema_gha_00 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "gha",
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2000,
         end = 2011,
         schema = schema_gha_01,
         archive = "081SPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GHA&ta=081SPD015&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GHA&ta=081SPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_gha_02 <- schema_gha_00 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "gha",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2000,
         end = 2014,
         schema = schema_gha_02,
         archive = "081SPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GHA&ta=081SPD010&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GHA&ta=081SPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_gha_03 <-
  setIDVar(name = "al1", value = "Ghana") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3)

schema_gha_04 <- schema_gha_03 %>%
  setObsVar(name = "planted", unit = "ha", columns = 4)

regTable(nation = "gha",
         level = 1,
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gha_04,
         begin = 2000,
         end = 2013,
         archive = "081CPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GHA&ta=081CPD016&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GHA&ta=081CPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_gha_05 <- schema_gha_03 %>%
  setObsVar(name = "headcount", unit = "n", columns = 4)

regTable(nation = "gha",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gha_05,
         begin = 2000,
         end = 2014,
         archive = "081CPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GHA&ta=081CPD035&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GHA&ta=081CPD035&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_gha_06 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Ghana") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5) %>%
  setObsVar(name = "planted", unit = "ha", columns = 6,
            key = 3, value = "Area sown") %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6,
            key = 3, value = "Area Harvested")

regTable(nation = "gha",
         level = 1,
         subset = "plantHarvest",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gha_06,
         begin = 2000,
         end = 2015,
         archive = "D3S_61223869755777817475090755630404562896.xlsx",
         archiveLink = "http://ghana.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://ghana.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


# The years are recoreded per agriculture season: 1947/48, 1948/49.
schema_gha_07 <- schema_gha_00 %>%
  setIDVar(name = "commodities", value = "cocoa") %>%
  setObsVar(name = "production", unit = "t", columns = 4)

regTable(nation = "gha",
         subset = "prodCocoa",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1948,
         end = 2008,
         schema = schema_gha_07,
         archive = "081SPD033.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GHA&ta=081SPD033&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GHA&ta=081SPD033&tr=-2",
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

