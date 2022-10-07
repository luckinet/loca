# script arguments ----
#
thisNation <- "Cameroon"
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
schema_cmr_00 <-
  setIDVar(name = "al1", value = "Cameroon") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_cmr_01 <- schema_cmr_00 %>%
  setFilter(rows = .find("Live animals", col = 3)) %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "cmr",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_cmr_01,
         begin = 1972,
         end = 2012,
         archive = "D3S_13560733286226780367962256534287463659.xlsx",
         archiveLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_cmr_02 <- schema_cmr_00 %>%
  setFilter(rows = .find("^(01.*)", col = 4)) %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "cmr",
         level = 1,
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_cmr_02,
         begin = 1998, # values for crops only appear from 1998 till 2013. From 1972 there is only values for meat production
         end = 2013,
         archive = "D3S_33201134027644764608945955567209261075.xlsx",
         archiveLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_cmr_03 <- schema_cmr_00 %>%
  setCluster (id = "al1", left = 1, top = 5) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "cmr",
         level = 1,
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_cmr_03,
         begin = 1998,
         end = 2011,
         archive = "D3S_29933140404043573946251569470594162607.xlsx",
         archiveLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
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

