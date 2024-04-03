# ----
# geography : Egypt
# period    : _INSERT
# dataseries: Central Agency for Public Moblisation and Statistics (http://www.capmas.gov.eg)
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

thisNation <- "Egypt"

# 1. dataseries ----
#
ds <- c("capmas")
gs <- c("gadm36", "capmas")

regDataseries(name = ds[],
              description = _INSERT,
              homepage = _INSERT,
              version = _INSERT,
              licence_link = _INSERT)

# regDataseries(name = ds[1],
#               description = "Central Agency for Public Moblisation and Statistics",
#               homepage = "http://www.capmas.gov.eg",
#               notes = "data are public domain",
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

## capmas ----
# regGeometry(nation = "Egypt",
#             gSeries = gs[2],
#             level = 1,
#             nameCol = "Name_0",
#             archive = "gadm36_EGY_shp.zip|gadm36_EGY_0.shp",
#             archiveLink = "", #find out link
#             updateFrequency = "unknown",
#             update = updateTables)
#
# regGeometry(nation = "Egypt",
#             gSeries = gs[2],
#             level = 2,
#             nameCol = "Name_1",
#             archive = "gadm36_EGY_shp.zip|gadm36_EGY_1.shp",
#             archiveLink = "", #find out link
#             updateFrequency = "unknown",
#             update = updateTables)
#
# regGeometry(nation = "Egypt",
#             gSeries = gs[2],
#             level = 3,
#             nameCol = "Name_2",
#             archive = "gadm36_EGY_shp.zip|gadm36_EGY_2.shp",
#             archiveLink = "", #find out link
#             updateFrequency = "unknown",
#             update = updateTables)

normGeometry(pattern = gs[],
             beep = 10)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  ### capmas ----
  # schema_egy_06 <- setCluster(id = "al1", left = 1, top = 9, height = 20) %>%
  #   setIDVar(name = "al1", value = "Egypt") %>%
  #   setIDVar(name = "year", columns = c(2:15), rows = 8) %>%
  #   setIDVar(name = "commodities", columns = 1) %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 1000, columns = c(3, 5, 7, 9, 11, 15)) %>%
  #   setObsVar(name = "production", unit = "t", factor = 1000, columns = c(2, 4, 6, 8, 10, 12, 14))
  #
  # regTable(natio = "egy",
  #          level = 1,
  #          subset = "VEGETABLES",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          begin = 2001,
  #          end = 2007,
  #          schema = schema_egy_06,
  #          archive = "statistical year book 2009.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          nextUpdate = "unknown",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_egy_07 <- schema_egy_06 %>%
  #   setCluster(id = "al1", left = 1, top = 5, height = 7) %>%
  #   setIDVar(name = "year", columns = c(2:15), rows = 4)
  #
  # regTable(nation = "egy",
  #          level = 1,
  #          subset = "NILE CROPS",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          begin = 2001,
  #          end = 2007,
  #          schema = schema_egy_07,
  #          archive = "statistical year book 2009.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          nextUpdate = "unknown",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_egy_08 <- setCluster(id = "al1", left = 1, top = 5, height = 12) %>%
  #   setIDVar(name = "al1", value = "Egypt") %>%
  #   setIDVar(name = "year", columns = c(2:17), rows = 4) %>%
  #   setIDVar(name = "commodities", columns = 1) %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 1000, columns = c(3, 5, 7, 9, 11, 15, 17)) %>%
  #   setObsVar(name = "production", unit = "t", factor = 1000, columns = c(2, 4, 6, 8, 10, 12, 14, 16))
  #
  # regTable(nation = "egy",
  #          level = 1,
  #          subset = "SUMMER CROPS",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          begin = 2001,
  #          end = 2008,
  #          schema = schema_egy_08,
  #          archive = "statistical year book 2009.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          nextUpdate = "unknown",
  #          metadataLink = "unknown",
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

  ### capmas ----
  # schema_egy_01 <-
  #   setFilter(rows = .find("Total", col = 10), invert = TRUE) %>%
  #   setIDVar(name = "al2", columns = 10) %>%
  #   setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=governorates ).*") %>%
  #   setIDVar(name = "commodities", columns = c(1:8), rows = 2) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = c(1:8))
  #
  # regTable(natoin = "egy",
  #          level = 2,
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          begin = 2012,
  #          end = 2012,
  #          schema = schema_egy_01 ,
  #          archive = "livestock_2012.pdf|p.15",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          nextUpdate = "unknown",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_egy_02 <-
  #   setFilter(rows = .find("Total", col = 4), invert = TRUE) %>%
  #   setIDVar(name = "al2", columns = 4) %>%
  #   setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=in ).*") %>%
  #   setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=of ).*(?= heads)") %>%
  #   setObsVar(name = "headcount", unit = "n", columns = 5)
  #
  # regTable(natoin = "egy",
  #          level = 2,
  #          subset = "cattle",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          begin = 2012,
  #          end = 2012,
  #          schema = schema_egy_02,
  #          archive = "livestock_2012.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          nextUpdate = "unknown",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_egy_03 <-
  #   setFilter(rows = .find("Total", col = 6), invert = TRUE) %>%
  #   setIDVar(name = "al2", columns = 6) %>%
  #   setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=in ).*(?= \\()") %>%
  #   setIDVar(name = "commodities", columns = c(1:5), rows = 2) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = c(1:5))
  #
  # regTable(natoin = "egy",
  #          level = 2,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          begin = 2012,
  #          end = 2012,
  #          schema = schema_egy_03,
  #          archive = "livestock_2012.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          nextUpdate = "unknown",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Is it acceptable here to use "number", instead of "headcount" or this table needs to be discarded
  # schema_egy_04 <-
  #   setFilter(rows = .find("Total", col = 7), invert = TRUE) %>%
  #   setIDVar(name = "al2", columns = 7) %>%
  #   setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=in ).*") %>%
  #   setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=of ).*(?= and)") %>%
  #   setObsVar(name = "number", unit = "n", columns = 9, top = 2)
  #
  # regTable(natoin = "egy",
  #          level = 2,
  #          subset = "hives",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          begin = 2012,
  #          end = 2012,
  #          schema = schema_egy_04,
  #          archive = "livestock_2012.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          nextUpdate = "unknown",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_egy_05 <- setCluster(id = "al1", left = 1, top = 3, height = 6) %>%
  #   setIDVar(name = "al1", value = "Egypt") %>%
  #   setIDVar(name = "year", columns = c(2:9), rows = 3) %>%
  #   setIDVar(name = "commodities", columns = 1) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = c(2:9))
  #
  # regTable(nation = "egy",
  #          level = 1,
  #          subset = "LIVESTOCK",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          begin = 2000,
  #          end = 2007,
  #          schema = schema_egy_05,
  #          archive = "statistical year book 2009.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          nextUpdate = "unknown",
  #          metadataLink = "unknown",
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
