# script arguments ----
#
thisNation <- ""
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("agriwanet")
gs <- c("gadm")

regDataseries(name = ds[1],
              description = "Agricultural Restructuring, Water Scarcity and the Adaptation to Climate Change in Central Asia",
              homepage = "https://doi.org/10.7802/2008",
              licence_link = "CC BY 4.0",
              licence_path = "not available",
              update = updateTables)

# 2. register geometries ----
#


# 3. register census tables ----
#
schema_agriwanet1 <-
  setIDVar(name = "al1", columns = 1) %>%
  setIDVar(name = "al2", columns = 2) %>%
  setIDVar(name = "year", columns = 4) %>%
  setIDVar(name = "commodities", columns = c(20:34), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 1000, columns = c(20:34),
            key = 3, value = "all farms (not applic case) (10)")

regTable(level = 2,
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_agriwanet1,
         begin = 1992,
         end = 2015,
         archive = "agriwanet_data_en_V1.0.csv",
         archiveLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
         metadataPath = "agriwanet_codebook_en.pdf",
         update = updateTables,
         overwrite = overwriteTables)

schema_agriwanet2 <-
  setIDVar(name = "al1", columns = 1) %>%
  setIDVar(name = "al2", columns = 2) %>%
  setIDVar(name = "year", columns = 4) %>%
  setIDVar(name = "commodities", columns = c(35:49), rows = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 1000, columns = c(35:49),
            key = 3, value = "all farms (not applic case) (10)")

regTable(level = 2,
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_agriwanet2,
         begin = 1992,
         end = 2015,
         archive = "agriwanet_data_en_V1.0.csv",
         archiveLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
         metadataPath = "agriwanet_codebook_en.pdf",
         update = updateTables,
         overwrite = overwriteTables)

schema_agriwanet3 <-
  setIDVar(name = "al1", columns = 1) %>%
  setIDVar(name = "al2", columns = 2) %>%
  setIDVar(name = "year", columns = 4) %>%
  setIDVar(name = "commodities", columns = c(50:53), rows = 1) %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = c(50:53),
            key = 3, value = "all farms (not applic case) (10)")

regTable(level = 2,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_agriwanet3,
         begin = 1992,
         end = 2015,
         archive = "agriwanet_data_en_V1.0.csv",
         archiveLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
         metadataPath = "agriwanet_codebook_en.pdf",
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
          outType = "rds",
          update = updateTables)
