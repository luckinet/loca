# script arguments ----
#
thisNation <- "Colombia"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("UNODC", "spam")
gs <- c("gadm", "spam")


# register geometries ----
#


# register census tables ----
#
# UNOCD----
schema_col_01 <-
  setFormat(thousand = ".") %>%
  setFilter(rows = .find("Total..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:11)) %>%
  setIDVar(name = "commodities", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:11))

regTable(nation = "col",
         level = 2,
         subset = "plantedCoca",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_col_01,
         begin = 2010,
         end = 2019,
         archive = "Colombia_Monitoreo_Cultivos_Ilicitos_2019.pdf|p.166",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Colombia/Colombia_Monitoreo_Cultivos_Ilicitos_2019.pdf",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Colombia",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_col_02 <-
  setFormat(thousand = ".") %>%
  setFilter(rows = c(26:29), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:7)) %>%
  setIDVar(name = "commodities", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:7))

regTable(nation = "col",
         level = 2,
         subset = "plantedCoca",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_col_02,
         begin = 2004,
         end = 2009,
         archive = "Colombia-Censo-2009-web.pdf|p.16",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Colombia/Colombia-Censo-2009-web.pdf",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Colombia",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_col_03 <-
  setFilter(rows = c(24:29), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:6)) %>%
  setIDVar(name = "commodities", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:6))

regTable(nation = "col",
         level = 2,
         subset = "plantedCoca",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_col_03,
         begin = 1999,
         end = 2004,
         archive = "Part3_Colombia.pdf|p.17",
         archiveLink = "https://www.unodc.org/pdf/andean/Part3_Colombia.pdf",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Colombia",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# Trying to set the schema to put down for al1 "total" from the table to make it work.
# tried to use cluster argument to make it work. still no success
schema_col_04 <- #setCluster(id = "al1", left = 1, top = 2) %>%
  setIDVar(name = "al1", value = "Colombia") %>%
  setIDVar(name = "year", rows = 1, columns = c(2:12)) %>%
  setIDVar(name = "commodities", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:12))

regTable(nation = "col",
         level = 1,
         subset = "plantedCoca",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_col_04,
         begin = 1994,
         end = 2004,
         archive = "Andean-coca-June05.pdf|p.101",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Andean-coca-June05.pdf",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Colombia",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_col_05 <-
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:16)) %>%
  setIDVar(name = "commodities", value = "poppy") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:16))

regTable(nation = "col",
         level = 2,
         subset = "plantedPoppy",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_col_05,
         begin = 2002,
         end = 2016,
         archive = "Poppy crops in Colombia, by department, in hectares, 2002 – 2016.csv", # can't find the pdf document containing this data
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Colombia",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Colombia",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# spam----
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Colombia",
#          level = 3,
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2007,
#          end = 2014,
#          archive = "LAC.zip|produccionagricola.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Colombia",
#          level = 2,
#          subset = "sesame",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 1987,
#          end = 2012,
#          archive = "LAC.zip|anexos_ena_2010.xls",
#          update = myUpdate)
#
# regTable(nation = "Colombia",
#          level = 2,
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|anexos_ena_2010.xls",
#          update = myUpdate)
#
# regTable(nation = "Colombia",
#          level = 2,
#          subset = "forest",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|anexos_ena_2010.xls",
#          update = myUpdate)
#
# regTable(nation = "Colombia",
#          level = 1,
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2000,
#          end = 2012,
#          archive = "LAC.zip|Colombia_Irrigated_Rainfed.xlsx",
#          update = myUpdate)


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

# normTable(pattern = ds[2],
#           al1 = thisNation,
#           outType = "rds",
#           update = updateTables)


