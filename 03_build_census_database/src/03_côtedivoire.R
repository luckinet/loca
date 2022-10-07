# script arguments ----
#
thisNation <- "Côte D'ivoire"
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
schema_civ_00 <-
  setIDVar(name = "al1", value = "Côte D'ivoire") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3)

schema_civ_01 <- schema_civ_00 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 4)

regTable(nation = "civ",
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 1,
         begin = 1990,
         end = 2011,
         schema = schema_civ_01,
         archive = "107CPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=CIV&tr=21",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_civ_02 <- schema_civ_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 4)

regTable(nation = "civ",
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 1,
         begin = 1990,
         end = 2011,
         schema = schema_civ_02,
         archive = "107CPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=CIV&tr=21",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# during normalisation I wrote "ignore" for commodity "coffee and tea", because in ontology I could not find term that has both
# Commodity "cooking bananas" is translated as "banana", because the table also has "plantain" as a commodity.
# Commodity "peanut butter" has been ignored.
schema_civ_03 <- schema_civ_00 %>%
  setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "commodities", columns = 5) %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "civ",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 1,
         begin = 1990,
         end = 2015,
         schema = schema_civ_03,
         archive = "D3S_48500900596605739428635404918425882889.xlsx",
         archiveLink = "http://cote-divoire.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://cote-divoire.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_civ_04 <- schema_civ_00 %>%
  setObsVar(name = "headcount", unit = "n", columns = 4)

regTable(nation = "civ",
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 1,
         begin = 1990,
         end = 2013,
         schema = schema_civ_04,
         archive = "107CPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=CIV&tr=21",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_civ_05 <-
  setIDVar(name = "al1", value = "Côte D'ivoire") %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 4) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = 5)

regTable(nation = "civ",
         level = 1,
         subset = "yield",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_civ_05,
         begin = 2006,
         end = 2006,
         archive = "107AAN063.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN063&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN063&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "civ",
         level = 1,
         subset = "yield",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_civ_05,
         begin = 2005,
         end = 2005,
         archive = "107AAN053.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN053&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN053&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_civ_06 <-
  setIDVar(name = "al1", value = "Côte D'ivoire") %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 6) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = 7)

regTable(nation = "civ",
         level = 1,
         subset = "yield",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_civ_06,
         begin = 2007,
         end = 2007,
         archive = "107AAN073.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN073&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN073&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "civ",
         level = 1,
         subset = "yield",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_civ_06,
         begin = 2008,
         end = 2008,
         archive = "107AAN083.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN083&tr=-2h",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN083&tr=-2",
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
