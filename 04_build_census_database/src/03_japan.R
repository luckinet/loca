# ----
# geography : _INSERT
# period    : _INSERT
# dataseries: _INSERT
# variables :
#   - land      : _INSERT
#   - crops     : _INSERT
#   - livestock : _INSERT
#   - technology: _INSERT
#   - social    : _INSERT
# sampling  : survey, census
# spatial   : _INSERT
# authors   : Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisNation <- "Japan"

# 1. dataseries ----
#
ds <- c("soumu")
gs <- c("gadm36", "nlftp")

regDataseries(name = ds[],
              description = _INSERT,
              homepage = _INSERT,
              version = _INSERT,
              licence_link = _INSERT)

# regDataseries(name = ds[1],
#               description = "Statistics Bureau of Japan",
#               homepage = "http://www.stat.go.jp/english/index.html",
#               licence_link = "unknown",
#               licence_path = "not available",
#               update = updateTables)
#
# regDataseries(name = gs[2],
#               description = "National Land Numerical Information",
#               homepage = "nlftp.mlit.go.jp",
#               licence_link = "unknown",
#               licence_path = "not available",
#               update = updateTables)

# 2. geometries ----
#
regGeometry(nation = !!thisNation,
            gSeries = gs[],
            label = list(al_ = ""),
            archive = "|",
            archiveLink = _INSERT,
            downloadDate = _INSERT,
            updateFrequency = _INSERT)

## nlftp ----
# regGeometry(nation = "Japan",
#             gSeries = gs[2],
#             level = 3,
#             nameCol = "N003_01|N003_02|N00_03",
#             archive = "japan.zip|N03-19_190101.shp",
#             archiveLink = "http://nlftp.mlit.go.jp/ksj-e/gml/cgi-bin/download.php",
#             nextUpdate = "unknown",
#             updateFrequency = "notPlanned",
#             update = updateTables)

normGeometry(pattern = gs[],
             beep = 10)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  ### soumu----
  # schema_jpn_l2_01 <-
  #   setIDVar(name = "al1", columns = 3) %>%
  #   setIDVar(name = "year", columns = 1) %>%
  #   setIDVar(name = "commodities", columns = c(4, 6), rows = 1) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(4, 6))
  #
  # regTable(nation = "jpn",
  #          level = 1,
  #          subset= "ProductionTeaApple",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_jpn_l2_01,
  #          begin = 1955,
  #          end = 2017,
  #          archive = "japan.zip|adm1_Production_RiceTeaApple.csv",
  #          archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
  #          updateFrequency = "not planned",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_jpn_l2_02 <- schema_jpn_l2_01 %>%
  #   setIDVar(name = "commodities", columns = c(4, 6, 8, 10, 12, 14, 16, 18, 20, 22), rows = 1) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(4, 6, 8, 10, 12, 14, 16, 18, 20, 22))
  #
  # regTable(nation = "jpn",
  #          level = 1,
  #          subset= "Production",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_jpn_l2_02,
  #          begin = 1955,
  #          end = 2017,
  #          archive = "japan.zip|adm1_Production.csv",
  #          archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
  #          updateFrequency = "not planned",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_jpn_l2_03 <-
  #   setIDVar(name = "al1", columns = 3) %>%
  #   setIDVar(name = "year", columns = 1) %>%
  #   setIDVar(name = "commodities", columns = c(4, 6), rows = 1) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(4, 6))
  #
  # regTable(nation = "jpn",
  #          level = 1,
  #          subset= "PlantedTeaApple",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_jpn_l2_03,
  #          begin = 1955,
  #          end = 2017,
  #          archive = "japan.zip|adm1_PlantedArea_VegetablesFruitsTeaApple.csv",
  #          archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
  #          updateFrequency = "not planned",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_jpn_l2_04 <-schema_jpn_l2_03 %>%
  #   setIDVar(name = "commodities", columns = c(4, 6, 8, 10, 12, 14, 16, 18, 20, 22), rows = 1) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(4, 6, 8, 10, 12, 14, 16, 18, 20, 22))
  #
  # regTable(nation = "jpn",
  #          level = 1,
  #          subset= "PlantedArea",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_jpn_l2_04,
  #          begin = 1955,
  #          end = 2017,
  #          archive = "japan.zip|adm1_PlantedArea.csv",
  #          archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
  #          updateFrequency = "not planned",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_jpn_l2_04 <- setCluster(id = "commodities", left = 1, top = 3) %>%
  #   setFilter(rows = .find("Japan", col = 1), invert = TRUE) %>%
  #   setFormat(thousand = ",") %>%
  #   setIDVar(name = "al2", columns = 1) %>%
  #   setIDVar(name = "year", columns = c(2:47), rows = 3) %>%
  #   setIDVar(name = "commodities", columns = 1, rows = 1)
  #
  # schema_jpn_l2_04_01 <- schema_jpn_l2_04 %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2:47))
  #
  # regTable(nation = "jpn",
  #          level = 2,
  #          subset = "wheatArea",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_jpn_l2_04_01,
  #          begin = 1958,
  #          end = 2003,
  #          archive = "japan.zip|WheatJapan.xls",
  #          archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
  #          updateFrequency = "not planned",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "jpn",
  #          level = 2,
  #          subset = "soybeanArea",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_jpn_l2_04_01,
  #          begin = 1958,
  #          end = 2003,
  #          archive = "japan.zip|SoyJapanSorted.xlsx",
  #          archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
  #          updateFrequency = "not planned",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "jpn",
  #          level = 2,
  #          subset = "riceArea",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_jpn_l2_04_01,
  #          begin = 1958,
  #          end = 2003,
  #          archive = "japan.zip|RiceJapanSorted.xls",
  #          archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
  #          updateFrequency = "not planned",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_jpn_l2_04_02 <- schema_jpn_l2_04 %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = c(2:47))
  #
  # regTable(nation = "jpn",
  #          level = 2,
  #          subset = "wheatYield",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_jpn_l2_04_02,
  #          begin = 1958,
  #          end = 2003,
  #          archive = "japan.zip|WheatJapan.xls",
  #          archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
  #          updateFrequency = "not planned",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "jpn",
  #          level = 2,
  #          subset = "riceYield",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_jpn_l2_04_02,
  #          begin = 1958,
  #          end = 2003,
  #          archive = "japan.zip|RiceJapanSorted.xls",
  #          archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
  #          updateFrequency = "not planned",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_jpn_l2_04_03 <- schema_jpn_l2_04 %>%
  #   setObsVar(name = "production", unit = "t", columns = c(2:47))
  #
  # regTable(nation = "jpn",
  #          level = 2,
  #          subset = "wheatProd",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_jpn_l2_04_03,
  #          begin = 1958,
  #          end = 2003,
  #          archive = "japan.zip|WheatJapan.xls",
  #          archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
  #          updateFrequency = "not planned",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "jpn",
  #          level = 2,
  #          subset = "soybeanProd",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_jpn_l2_04_03,
  #          begin = 1958,
  #          end = 2003,
  #          archive = "japan.zip|SoyJapanSorted.xlsx",
  #          archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
  #          updateFrequency = "not planned",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "jpn",
  #          level = 2,
  #          subset = "riceProd",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_jpn_l2_04_03,
  #          begin = 1958,
  #          end = 2003,
  #          archive = "japan.zip|RiceJapanSorted.xls",
  #          archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
  #          updateFrequency = "not planned",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_jpn_l2_04_04 <-schema_jpn_l2_04_02 %>%
  #   setIDVar(name = "year", columns = c(2:47), rows = 2) %>%
  #   setIDVar(name = "commodities", value = "soybean")
  #
  # regTable(nation = "jpn",
  #          level = 2,
  #          subset = "soybeanYield",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_jpn_l2_04_04,
  #          begin = 1958,
  #          end = 2003,
  #          archive = "japan.zip|SoyJapanSorted.xlsx",
  #          archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
  #          updateFrequency = "not planned",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)

  schema_crops <- setCluster(id = _INSERT) %>%
    setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
              na_values = _INSERT) %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "") %>%
    setIDVar(name = "crop", ) %>%
    setObsVar(name = "hectares_harvested", ) %>%
    setObsVar(name = "tons_produced", ) %>%
    setObsVar(name = "kiloPerHectare_yield", )

  regTable(nation = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_crops,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           downloadDate = ymd(_INSERT),
           updateFrequency = _INSERT,
           metadataLink = _INSERT,
           metadataPath = _INSERT,
           overwrite = TRUE)

  normTable(pattern = ds[],
            ontoMatch = "crop",
            beep = 10)
}

if(build_livestock){
  ## livestock ----

  ### soumu----
  # schema_jpn_l2_00 <-
  #   setIDVar(name = "al2", columns = 3) %>%
  #   setIDVar(name = "year", columns = 1) %>%
  #   setIDVar(name = "commodities", value = "forest area") %>%
  #   setObsVar(name = "area", unit = "ha", columns = 4)
  #
  # regTable(nation = "jpn",
  #          level = 3,
  #          subset= "forest",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_jpn_l2_00,
  #          begin = 1980,
  #          end = 2015,
  #          archive = "japan.zip|forest.csv",
  #          archiveLink = "https://dashboard.e-stat.go.jp/en/dataSearch",
  #          updateFrequency = "not planned",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://www.e-stat.go.jp/en/stat-search?page=1&alpha=1",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)

  schema_livestock <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "") %>%
    setIDVar(name = "animal", )  %>%
    setObsVar(name = "number_heads", )

  regTable(nation = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_livestock,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           downloadDate = ymd(_INSERT),
           updateFrequency = _INSERT,
           metadataLink = _INSERT,
           metadataPath = _INSERT,
           overwrite = TRUE)

  normTable(pattern = ds[],
            ontoMatch = "animal",
            beep = 10)
}

if(build_landuse){
  ## landuse ----

  schema_landuse <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "landuse", ) %>%
    setObsVar(name = "hectares_covered", )

  regTable(nation = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_landuse,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           downloadDate = ymd(_INSERT),
           updateFrequency = _INSERT,
           metadataLink = _INSERT,
           metadataPath = _INSERT,
           overwrite = TRUE)

  normTable(pattern = ds[],
            ontoMatch = "landuse",
            beep = 10)
}

#### test schemas
#
# myRoot <- paste0(census_dir, "tables/stage2/")
# myFile <- ""
# input <- read_csv(file = paste0(myRoot, myFile),
#                   col_names = FALSE,
#                   col_types = cols(.default = "c"))
#
# schema <-
# validateSchema(schema = schema, input = input)
#
# output <- reorganise(input = input, schema = schema)
#
# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script
