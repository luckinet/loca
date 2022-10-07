# script arguments ----
#
thisNation <- "Japan"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("soumu")
gs <- c("gadm", "nlftp")


regDataseries(name = gs[2],
              description = "National Land Numerical Information",
              homepage = "nlftp.mlit.go.jp",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)

regDataseries(name = ds[1],
              description = "Statistics Bureau of Japan",
              homepage = "http://www.stat.go.jp/english/index.html",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)


# register geometries ----
#
# nlftp ----
regGeometry(nation = "Japan",
            gSeries = gs[2],
            level = 3,
            nameCol = "N003_01|N003_02|N00_03",
            archive = "japan.zip|N03-19_190101.shp",
            archiveLink = "http://nlftp.mlit.go.jp/ksj-e/gml/cgi-bin/download.php",
            nextUpdate = "unknown",
            updateFrequency = "notPlanned",
            update = updateTables)


# 3. register census tables ----
#
# soumu----
schema_jpn_l2_00 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", value = "forest area") %>%
  setObsVar(name = "area", unit = "ha", columns = 4)

regTable(nation = "jpn",
         level = 3,
         subset= "forest",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_jpn_l2_00,
         begin = 1980,
         end = 2015,
         archive = "japan.zip|forest.csv",
         archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_jpn_l2_01 <-
  setIDVar(name = "al1", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(4, 6), rows = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(4, 6))

regTable(nation = "jpn",
         level = 1,
         subset= "ProductionTeaApple",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_jpn_l2_01,
         begin = 1955,
         end = 2017,
         archive = "japan.zip|adm1_Production_RiceTeaApple.csv",
         archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_jpn_l2_02 <- schema_jpn_l2_01 %>%
  setIDVar(name = "commodities", columns = c(4, 6, 8, 10, 12, 14, 16, 18, 20, 22), rows = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(4, 6, 8, 10, 12, 14, 16, 18, 20, 22))

regTable(nation = "jpn",
         level = 1,
         subset= "Production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_jpn_l2_02,
         begin = 1955,
         end = 2017,
         archive = "japan.zip|adm1_Production.csv",
         archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_jpn_l2_03 <-
  setIDVar(name = "al1", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(4, 6), rows = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(4, 6))

regTable(nation = "jpn",
         level = 1,
         subset= "PlantedTeaApple",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_jpn_l2_03,
         begin = 1955,
         end = 2017,
         archive = "japan.zip|adm1_PlantedArea_VegetablesFruitsTeaApple.csv",
         archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_jpn_l2_04 <-schema_jpn_l2_03 %>%
  setIDVar(name = "commodities", columns = c(4, 6, 8, 10, 12, 14, 16, 18, 20, 22), rows = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(4, 6, 8, 10, 12, 14, 16, 18, 20, 22))

regTable(nation = "jpn",
         level = 1,
         subset= "PlantedArea",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_jpn_l2_04,
         begin = 1955,
         end = 2017,
         archive = "japan.zip|adm1_PlantedArea.csv",
         archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_jpn_l2_04 <- setCluster(id = "commodities", left = 1, top = 3) %>%
  setFilter(rows = .find("Japan", col = 1), invert = TRUE) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:47), rows = 3) %>%
  setIDVar(name = "commodities", columns = 1, rows = 1)

schema_jpn_l2_04_01 <- schema_jpn_l2_04 %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:47))

regTable(nation = "jpn",
         level = 2,
         subset = "wheatArea",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_jpn_l2_04_01,
         begin = 1958,
         end = 2003,
         archive = "japan.zip|WheatJapan.xls",
         archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "jpn",
         level = 2,
         subset = "soybeanArea",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_jpn_l2_04_01,
         begin = 1958,
         end = 2003,
         archive = "japan.zip|SoyJapanSorted.xlsx",
         archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "jpn",
         level = 2,
         subset = "riceArea",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_jpn_l2_04_01,
         begin = 1958,
         end = 2003,
         archive = "japan.zip|RiceJapanSorted.xls",
         archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_jpn_l2_04_02 <- schema_jpn_l2_04 %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = c(2:47))

regTable(nation = "jpn",
         level = 2,
         subset = "wheatYield",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_jpn_l2_04_02,
         begin = 1958,
         end = 2003,
         archive = "japan.zip|WheatJapan.xls",
         archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "jpn",
         level = 2,
         subset = "riceYield",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_jpn_l2_04_02,
         begin = 1958,
         end = 2003,
         archive = "japan.zip|RiceJapanSorted.xls",
         archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_jpn_l2_04_03 <- schema_jpn_l2_04 %>%
  setObsVar(name = "production", unit = "t", columns = c(2:47))

regTable(nation = "jpn",
         level = 2,
         subset = "wheatProd",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_jpn_l2_04_03,
         begin = 1958,
         end = 2003,
         archive = "japan.zip|WheatJapan.xls",
         archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "jpn",
         level = 2,
         subset = "soybeanProd",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_jpn_l2_04_03,
         begin = 1958,
         end = 2003,
         archive = "japan.zip|SoyJapanSorted.xlsx",
         archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "jpn",
         level = 2,
         subset = "riceProd",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_jpn_l2_04_03,
         begin = 1958,
         end = 2003,
         archive = "japan.zip|RiceJapanSorted.xls",
         archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_jpn_l2_04_04 <-schema_jpn_l2_04_02 %>%
  setIDVar(name = "year", columns = c(2:47), rows = 2) %>%
  setIDVar(name = "commodities", value = "soybean")

regTable(nation = "jpn",
         level = 2,
         subset = "soybeanYield",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_jpn_l2_04_04,
         begin = 1958,
         end = 2003,
         archive = "japan.zip|SoyJapanSorted.xlsx",
         archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
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

