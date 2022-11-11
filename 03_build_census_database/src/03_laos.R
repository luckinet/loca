# script arguments ----
#
thisNation <- "Laos"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("faoDatalab", "UNODC")
gs <- c("gadm")


# register geometries ----
#


# register census tables ----
#
## faoDatalab ----
schema_lao_01 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = c(6, 5), merge = "-") %>%
  setObsVar(name = "harvested", unit = "ha", columns = 10,
            key = 11, value = "Hectares") %>%
  setObsVar(name = "production", unit = "t", columns = 10,
            key = 11, value = "Metric Tonnes")

regTable(narion = "lao",
         level = 2,
         subset = "prodHarvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_lao_01,
         begin = 2009,
         end = 2018,
         archive = "Laos - Sub-National Level 1.csv",
         archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Laos%20-%20Sub-National%20Level%201.csvhttp://www.fao.org/datalab/website/web/sites/default/files/2020-10/Laos%20-%20Sub-National%20Level%201.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Laos.pdf",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## UNODC ----
schema_lao_02 <- setCluster(id = "al1", left = 1, top = 3) %>%
  setIDVar(name = "al1", value = "Laos") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", value = "poppy") %>%
  setObsVar(name = "planted", unit = "ha", columns = 2)

regTable(nation = "lao",
         level = 1,
         subset = "plantedOpium",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_lao_02,
         begin = 1992,
         end = 2015,
         archive = "Southeast_Asia_Opium_Survey_2015_web.pdf|p.17",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/sea/Southeast_Asia_Opium_Survey_2015_web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_lao_03 <- setCluster(id = "commodities", left = 1, top = 3) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", rows = 3, columns = c(2:10)) %>%
  setIDVar(name = "commodities", value = "poppy") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:10))

regTable(nation = "lao",
         level = 2,
         subset = "plantedOpium",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_lao_03,
         begin = 1992,
         end = 2015,
         archive = "cultivation_opium_laos_lvl2_1992_2015.csv", # can't find the original pdf file containing this data
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Lao%20PDR",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_lao_04 <-
  setFormat(decimal = ",") %>%
  setIDVar(name = "al2", columns = 2) %>%
  setIDVar(name = "al3", columns = 4) %>%
  setIDVar(name = "year", value = "2002") %>%
  setIDVar(name = "commodities", value = "poppy") %>%
  setObsVar(name = "planted", unit = "ha", columns = 6) %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = 7) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = 9)

regTable(nation = "lao",
         level = 3,
         subset = "planYieldProdOpuim",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_lao_04,
         begin = 2002,
         end = 2002,
         archive = "prod_yield_culti_laos_lvl3_2002.csv", # can't find the original pdf file containing this data
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Lao%20PDR",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_lao_05 <- setCluster(id = "al1", left = 1, top = 4) %>%
  setIDVar(name = "al1", value = "Laos") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", value = "opium") %>%
  setObsVar(name = "production", unit = "t", columns = 2)

regTable(nation = "lao",
         level = 1,
         subset = "productionOpium",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_lao_05,
         begin = 1992,
         end = 2015,
         archive = "production_opium_laos_lvl1.csv", # can't find the original pdf file containing this data
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Lao%20PDR",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite  = overwriteTables)


schema_lao_06 <- setCluster(id = "commodities", left = 1, top = 2) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", rows = 2, columns = c(2:7)) %>%
  setIDVar(name = "commodities", value = "opium") %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:7))

regTable(nation = "lao",
         level = 2,
         subset = "productionOpium",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_lao_06,
         begin = 1992,
         end = 2002,
         archive = "production_opium_laos_lvl2_1992_2002.csv", # can't find the original pdf file containing this data
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Lao%20PDR",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_lao_07 <- setCluster(id = "al1", left = 1, top = 3) %>%
  setIDVar(name = "al1", value = "Laos") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", value = "opium") %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = 2)

regTable(nation = "lao",
         level = 1,
         subset = "yieldOpium",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_lao_07,
         begin = 1992,
         end = 2005,
         archive = "yield_opium_laos_lvl1_1992_2005.csv",
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Lao%20PDR",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "unknown",
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

normTable(pattern = ds[2],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)

