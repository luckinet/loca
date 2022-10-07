# script arguments ----
#
thisNation <- "Gabon"
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
# countrystat ----
schema_gab_01 <- setCluster(id = "al1", left = 1, top = 4) %>%
  setIDVar(name = "al1", value = "Gabon") %>%
  setIDVar(name = "al3", columns = 7) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5) %>%
  setObsVar(name = "production", unit = "t", columns = 10, factor = 0.001)

regTable(nation = "gab",
         level = 3,
         subset = "prodBanana",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gab_01,
         begin = 2017,
         end = 2017,
         archive = "D3S_8457400501264228087190576087673488452.xlsx",
         archiveLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://gabon.countrystat.org/search-and-visualize-data/en",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "gab",
         level = 3,
         subset = "prodCassava",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gab_01,
         begin = 2017,
         end = 2017,
         archive = "D3S_65765297683544622395831926883574866218.xlsx",
         archiveLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_gab_02 <- setCluster(id = "al1", left = 1, top = 4) %>%
  setIDVar(name = "al1", value = "Gabon") %>%
  setIDVar(name = "al2", columns = 7) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5) %>%
  setObsVar(name = "headcount", unit = "n", columns = 8)

regTable(nation = "gab",
         level = 2,
         subset = "livestockSheep",
         dSeries = ds[1],
         gSeries = gs[2],
         schema = schema_gab_02,
         begin = 2016,
         end = 2016,
         archive = "D3S_57648567727655310905327383039455470511.xlsx",
         archiveLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "gab",
         level = 2,
         subset = "livestockCattle",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gab_02,
         begin = 2016,
         end = 2016,
         archive = "D3S_23325858178721846295138541247501227448.xlsx",
         archiveLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "gab",
         level = 2,
         subset = "livestockGoats",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gab_02,
         begin = 2016,
         end = 2016,
         archive = "D3S_69779645070170687227615176335215745700.xlsx",
         archiveLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_gab_03 <-
  setIDVar(name = "al1", value = "Gabon") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3) %>%
  setObsVar(name = "production", unit = "t", columns = 4)

regTable(nation = "gab",
         level = 1,
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gab_03,
         begin = 1985,
         end = 2005,
         archive = "074CPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GAB&ta=074CPD010&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GAB&ta=074CPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "gab",
         level = 1,
         subset = "prodCashCrops",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gab_03,
         begin = 1985,
         end = 2005,
         archive = "089MPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GAB&ta=089MPD010&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GAB&ta=089MPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_gab_04 <- schema_gab_03 %>%
  setIDVar(name = "commodities", columns = 4)

regTable(nation = "gab",
         level = 1,
         subset = "prodVeggies",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gab_04,
         begin = 1985,
         end = 2005,
         archive = "089MPD011.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GAB&ta=089MPD011&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GAB&ta=089MPD011&tr=-2",
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

