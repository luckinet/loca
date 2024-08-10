# ----
# geography : Taiwan
# period    : _INSERT
# dataseries: Taiwan Council of Agriculture (http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx)
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

thisNation <- "Taiwan"

# 1. dataseries ----
#
ds <- c("tca")
gs <- c(_INSERT)

regDataseries(name = ds[],
              description = _INSERT,
              homepage = _INSERT,
              version = _INSERT,
              licence_link = _INSERT)

# regDataseries(name = "TCA",
#               description = "Taiwan Council of Agriculture",
#               homepage = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#               licence_link = "unknown",
#               licence_path = "unknown",
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

normGeometry(pattern = gs[],
             beep = 10)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  ### tca ----
  # schema_twn_01 <- setCluster(id = "al1", left = 2, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 18) %>%
  #   setIDVar(name = "commodities", columns = 10, rows = 3) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = 2) %>%
  #   setObsVar(name = "yield/unhulled rice", unit = "kg/ha", columns = 5) %>%
  #   setObsVar(name = "yield/brown rice", unit = "kg/ha", columns = 8) %>%
  #   setObsVar(name = "production/unhulled rice", unit = "t", columns = 12) %>%
  #   setObsVar(name = "production/brown rice", unit = "t", columns = 15)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceTotal",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_01,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceSubcategory01",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_01,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceSubcategory02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_01,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceSubcategory03",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_01,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceSubcategory04",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_01,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceSubcategory05",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_01,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_01_00 <- setCluster(id = "al1", left = 2, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 18) %>%
  #   setIDVar(name = "commodities", columns = 10, rows = 3) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = 2) %>%
  #   setObsVar(name = "yield/paddy rice", unit = "kg/ha", columns = 5) %>%
  #   setObsVar(name = "yield/brown rice", unit = "kg/ha", columns = 8) %>%
  #   setObsVar(name = "production/paddy rice", unit = "t", columns = 12) %>%
  #   setObsVar(name = "production/brown rice", unit = "t", columns = 15)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceTotal",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_01_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceSubcategory01",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_01_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceSubcategory02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_01_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceSubcategory03",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_01_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceSubcategory04",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_01_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceSubcategory05",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_01_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_02 <- setCluster(id = "al1", left = 2, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 19) %>%
  #   setIDVar(name = "commodities", columns = 11, rows = 3) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 2) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = 6) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = 11) %>%
  #   setObsVar(name = "production", unit = "t", columns = 15)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "feedCorn",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "foodCorn",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "sweetPotato",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "peanuts",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "radishes",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "carrots",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "cabbage",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "chineseMustard",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "tomato",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "watermelon",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "muskmelon",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "cantaloupe",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_02_00 <- schema_twn_02 %>%
  #   setCluster(id = "al1", left = 2, top = 12, height = 12)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "chineseCabbage",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "cabbage",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "cauliflower",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "watermelon",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "cantaloupe",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_02_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # the last commodity does not have yield, so I added one empty column
  # schema_twn_03 <- schema_twn_02 %>%
  #   setIDVar(name = "year", columns = 18) %>%
  #   setIDVar(name = "commodities", columns = c(2, 6, 11, 15), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 11, 15)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(3, 7, 12, 16)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 13, 19)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(5, 9, 14, 17))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "coarseGrain",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_03,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "coarseGrain02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_03,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_03_00 <- schema_twn_03 %>%
  #   setIDVar(name = "year", columns = 19) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 13, 17)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(5, 9, 14, 18))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "coarseGrain",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_03_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_04 <- setCluster(id = "commodities", left = c(6, 14), top = 14, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 18) %>%
  #   setIDVar(name = "commodities", columns = c(6, 14), rows = 5) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 14)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(3, 15)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 16)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(5, 17))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "sugar",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_04,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_04_00 <- setCluster(id = "al1", left = 2, top = 14, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 13) %>%
  #   setIDVar(name = "commodities", columns = c(2, 8), rows = 5) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 8)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(3, 9)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 10)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(5, 11))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "sugar",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_04_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # # In order for the schema to work, I add for there variables, empty columns, so that they will have NA values in the reorganized table.
  # schema_twn_05 <- setCluster(id = "commodities", left = c(2, 6, 11, 14, 17), top = 14, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 19) %>%
  #   setIDVar(name = "commodities", columns = c(2, 6, 11, 14, 17), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 10, 14, 10)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(3, 7, 11, 15, 17)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 12, 10, 10)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(5, 9, 13, 16, 18))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "specialCrops",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_05,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_05_00 <- schema_twn_05 %>%
  #   setIDVar(name = "year", columns = 20)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "specialCrops",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_05_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_06 <- setCluster(id = "commodities", left = c(3, 6, 10, 13), top = 14, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 15) %>%
  #   setIDVar(name = "commodities", columns = c(3, 6, 10, 13), rows = 7) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 9, 12)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(3, 6, 10, 13)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(4, 7, 11, 14))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables01",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_06,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_06_00 <- schema_twn_06 %>%
  #   setCluster(id = "commodities", left = c(3, 6, 10, 13), top = 12, height = 12) %>%
  #   setIDVar(name = "commodities", columns = c(3, 6, 10, 13), rows = 6)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables01",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_06_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_07 <- setCluster(id = "commodities", left =  c(3, 6, 11, 14), top = 14, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 18) %>%
  #   setIDVar(name = "commodities", columns = c(3, 6, 11, 14), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 10, 14)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(3, 6, 11, 15)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(19, 7, 12, 16)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(4, 8, 13, 17))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_07,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_07_00 <- schema_twn_07 %>%
  #   setCluster(id = "commodities", left =  c(2, 6, 11, 14), top = 13, height = 12) %>%
  #   setIDVar(name = "commodities", columns = c(2, 6, 11, 14), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 11, 14)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(3, 7, 12, 15)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 10, 16)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(5, 9, 13, 17))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_07_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables05",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_07_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Following schema is working, because schema_twn_07 does not have yield for ObsVar
  # schema_twn_07_01 <- schema_twn_07 %>%
  #   setCluster(id = "commodities", left =  c(2, 5, 10, 14), top = 14, height = 12) %>%
  #   setIDVar(name = "commodities", columns = c(2, 5, 10, 14), rows = 6) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(9, 7, 12, 16))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables05",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_07_01,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables06",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_07_01,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_08 <- setCluster(id = "al1", left = 2, top = 14, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 19) %>%
  #   setIDVar(name = "commodities", columns = c(2, 6, 11, 15), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 11, 15)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(3, 7, 12, 16)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 13, 17)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(5, 9, 14, 18))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables03",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_08,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables04",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_08,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables07",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_08,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_08_00 <- schema_twn_08 %>%
  #   setCluster(id = "al1", left = 2, top = 13, height = 12)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables03",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_08_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables04",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_08_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables07",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_08_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables08",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_08_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Last commoditie does not have yield values, so I put empty column in order for the reorganization to work.
  # schema_twn_08_01 <- schema_twn_08 %>%
  #   setCluster(id = "al1", left = 2, top = 13, height = 12) %>%
  #   setIDVar(name = "year", columns = 18) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 13, 19)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(5, 9, 14, 17))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables06",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_08_01,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # # Last commoditie does not have yield values, so I put empty column in order for the reorganization to work.
  # schema_twn_09 <- setCluster(id = "commodities", left = c(3, 7, 12, 16, 20), top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 22) %>%
  #   setIDVar(name = "commodities", columns = c(3, 7, 12, 16, 20), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 11, 15, 19)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(3, 7, 12, 16, 20)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 13, 17, 23)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(5, 9, 14, 18, 21))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables08",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_09,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_09_00 <- schema_twn_09 %>%
  #   setCluster(id = "commodities", left = c(2, 6, 11, 15, 18), top = 13, height = 12) %>%
  #   setIDVar(name = "commodities", columns = c(2, 6, 11, 15, 18), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 10, 15, 18)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(3, 7, 11, 16, 19)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 13, 12, 20)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(5, 9, 14, 17, 21))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables09",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_09_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_10 <- setCluster(id = "commodities", left = c(2, 6, 14), top = 14, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 18) %>%
  #   setIDVar(name = "commodities", columns = c(2, 6, 14), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 10)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(3, 7, 19)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 20)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(5, 9, 11))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables09",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_10,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_10_00 <- setCluster(id = "al1", left = 2, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 18) %>%
  #   setIDVar(name = "commodities", columns = c(2, 6), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 6)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(3, 7)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(5, 9))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables10",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_10_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_10_01 <- setCluster(id = "al1", left = 2, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 18) %>%
  #   setIDVar(name = "commodities", value = "shiitake") %>%
  #   setObsVar(name = "production", unit = "t", columns = 11)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "shiitake",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_10_01,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_11 <- setCluster(id = "al1", left = 7, top = 14, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 14) %>%
  #   setIDVar(name = "commodities", value = "bananas") %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 9) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = 10) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = 12) %>%
  #   setObsVar(name = "production", unit = "t", columns = 13)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "bananas",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_11,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_12 <- setCluster(id = "al1", left = 2, top = 14, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 17) %>%
  #   setIDVar(name = "commodities", columns = c(2, 10), rows = 6)%>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(4, 12)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(5, 13)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(7, 15)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(8, 16))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits01",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_12,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_12,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits03",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_12,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits05",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_12,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits06",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_12,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits07",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_12,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits09",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_12,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits10",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_12,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits11",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_12,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits12",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_12,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits13",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_12,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits14",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_12,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # The table does not have all Obs values for both variables
  # schema_twn_12_00 <- schema_twn_12 %>%
  #   setCluster(id = "commodities", left = c(4, 10), top = 14, height = 12) %>%
  #   setIDVar(name = "year", columns = 15) %>%
  #   setIDVar(name = "commodities", columns = c(4, 10), rows = 6) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(7, 16)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(8, 16))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits04",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_12_00,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_12_01 <- schema_twn_12 %>%
  #   setCluster(id = "commodities", left = c(2, 13), top = 14, height = 12) %>%
  #   setIDVar(name = "commodities", columns = c(2, 13), rows = 6)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits08",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_12_01,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # The table does not have all Obs values for both variables. I added empty columns
  # schema_twn_12_02 <- schema_twn_12 %>%
  #   setIDVar(name = "year", columns = 15) %>%
  #   setObsVar(name = "yield/per plant", unit = "kg/n", columns = c(6, 16)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(7, 17)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(8, 14))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits15",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_12_02,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_13 <- setCluster(id = "al1", left = 5, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 18) %>%
  #   setIDVar(name = "commodities", columns = c(5, 8, 12, 15), rows = 7) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(5, 8, 12, 15)) %>%
  #   setObsVar(name = "yield", unit = "n/ha", factor = 12, columns = c(6, 9, 13, 16)) %>%
  #   setObsVar(name = "production", unit = "n", factor = 12000, columns = c(7, 11, 14, 17))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowers01",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_13,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_13_00 <- schema_twn_13 %>%
  #   setCluster(id = "commodities", left = c(5, 9, 12, 15), top = 13, height = 12) %>%
  #   setIDVar(name = "commodities", columns = c(5, 9, 12, 15), rows = 7)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowers01",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_13_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_14 <- setCluster(id = "al1", left = 2, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 21) %>%
  #   setIDVar(name = "commodities", columns = c(2, 5, 8, 12, 15, 18), rows = 7) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 8, 12, 15, 18)) %>%
  #   setObsVar(name = "yield", unit = "n/ha", factor = 12, columns = c(3, 6, 9, 13, 16, 19)) %>%
  #   setObsVar(name = "production", unit = "n", factor = 12000, columns = c(4, 7, 10, 14, 17, 20))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowers02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_14,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowers02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_14,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # I assigned empty column for yield, for third commodity.
  # schema_twn_15 <- setCluster(id = "al1", left = 2, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 21) %>%
  #   setIDVar(name = "commodities", columns = c(2, 5, 8), rows = 7) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 8)) %>%
  #   setObsVar(name = "yield", unit = "n/ha", columns = c(3, 6, 10)) %>%
  #   setObsVar(name = "production", unit = "n", factor = 12000, columns = c(4, 7, 9))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowers03",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_15,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_16 <- setCluster(id = "al1", left = 11, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 21) %>%
  #   setIDVar(name = "commodities", columns = c(11, 14), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(11, 14)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(12, 15)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(13, 16))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowers04",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_16,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_16_00 <- setCluster(id = "al1", left = 11, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 21) %>%
  #   setIDVar(name = "commodities", columns = c(17, 19), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(17, 19))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowers05",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_16_00,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_17 <- setCluster(id = "al1", left = 2, top = 14, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 15) %>%
  #   setIDVar(name = "commodities", columns = c(2, 5, 9, 12), rows = 7) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 9, 12)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(3, 6, 10, 13)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(4, 7, 11, 14))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "forageCrops",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_17,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_18 <- setCluster(id = "al1", left = 2, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 12) %>%
  #   setIDVar(name = "commodities", columns = c(2, 5, 9), rows = 7) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 9)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(3, 7, 10)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(4, 8, 11))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "forageCrops",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_18,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_19 <- setCluster(id = "al1", left = 2, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 21) %>%
  #   setIDVar(name = "commodities", columns = c(2, 4, 6, 8, 10, 13, 15, 17, 19), rows = 7) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 4, 6, 8, 10, 13, 15, 17, 19)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(3, 5, 7, 9, 12, 14, 16, 18, 20))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "greenManureCrops",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_19,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_20 <- setCluster(id = "al1", left = 2, top = 14, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 19) %>%
  #   setIDVar(name = "commodities", columns = c(2, 4, 6, 8, 11, 13, 15, 17), rows = 8) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 4, 6, 8, 11, 13, 15, 17)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(3, 5, 7, 9, 12, 14, 16, 18))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "greenManureCrops02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_20,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_21 <- setCluster(id = "al1", left = 2, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 17) %>%
  #   setIDVar(name = "commodities", columns = c(2, 4, 6, 8, 11, 13, 15), rows = 7) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 4, 6, 8, 11, 13, 15)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(3, 5, 7, 9, 12, 14, 16))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "greenManureCrops01",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_21,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "greenManureCrops02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_21,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_22 <- setCluster(id = "al1", left = 2, top = 14, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 14) %>%
  #   setIDVar(name = "commodities", value = "total fruits") %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 2) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = 3) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = 4) %>%
  #   setObsVar(name = "production", unit = "t", columns = 5)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "totalFruits",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_22,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_22_00 <- schema_twn_22 %>%
  #   setCluster(id = "al1", left = 2, top = 11, height = 12) %>%
  #   setIDVar(name = "year", columns = 11)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "totalFruits",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_22_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_23 <- setCluster(id = "al1", left = 2, top = 11, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 11) %>%
  #   setIDVar(name = "commodities", columns = 7, rows = 3) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 7) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = 8) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = 9) %>%
  #   setObsVar(name = "production", unit = "t", columns = 10)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "bananas",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_23,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_24 <- setCluster(id = "al1", left = 2, top = 11, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 11) %>%
  #   setIDVar(name = "commodities", columns = c(2, 7), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 7)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(3, 8)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 9)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(5, 10))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits01",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_24,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_24,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits03",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_24,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits05",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_24,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits06",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_24,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits07",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_24,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits08",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_24,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits09",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_24,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits10",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_24,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits11",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_24,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits12",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_24,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits13",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_24,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_24_00 <- schema_twn_24 %>%
  #   setIDVar(name = "year", columns = 10) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 11)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(5, 9))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits04",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_24_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits14",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_24_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_25 <- setCluster(id = "al1", left = 2, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 18) %>%
  #   setIDVar(name = "commodities", value = "flowers total") %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 2)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowersTotal",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_25,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowersTotal",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_25,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_25_00 <- schema_twn_25 %>%
  #   setIDVar(name = "year", columns = 21) %>%
  #   setIDVar(name = "commodities", columns = c(2, 5), rows = 7) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(2, 5)) %>%
  #   setObsVar(name = "yield", unit = "n/ha", factor = 12, columns = c(3, 10)) %>%
  #   setObsVar(name = "production", unit = "n", factor = 12000, columns = c(4, 6))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowers03",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_25_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_25_01 <- schema_twn_25_00 %>%
  #   setIDVar(name = "commodities", columns = c(11, 14), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(11, 14)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(12, 15)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(13, 16))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowers04",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_25_01,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_25_02 <- setCluster(id = "al1", left = 2, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 21) %>%
  #   setIDVar(name = "commodities", columns = c(17, 19), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(17, 19))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowers05",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_25_02,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_25_03 <- schema_twn_25_00 %>%
  #   setIDVar(name = "commodities", value = "orchid") %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 7) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = 8) %>%
  #   setObsVar(name = "production", factor = 1000, unit = "bowls", columns = 9)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "orchid",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_25_03,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1999_2008_Agriculture.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_26 <- setCluster(id = "al1", left = 4, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 21) %>%
  #   setIDVar(name = "commodities", columns = 12, rows = 3) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = 4) %>%
  #   setObsVar(name = "yield/paddy rice", unit = "kg/ha", columns = 7) %>%
  #   setObsVar(name = "yield/brown rice", unit = "kg/ha", columns = 10) %>%
  #   setObsVar(name = "production/paddy rice", unit = "t", columns = 14) %>%
  #   setObsVar(name = "production/brown rice", unit = "t", columns = 17)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceTotal",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_26,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceSubcategory01",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_26,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceSubcategory02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_26,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceSubcategory03",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_26,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceSubcategory04",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_26,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "riceSubcategory05",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_26,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_27 <- setCluster(id = "al1", left = 4, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 22) %>%
  #   setIDVar(name = "commodities", columns = c(4, 8, 13, 17), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(4, 8, 13, 17)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(5, 9, 14, 18)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 10, 15, 19))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "coarseGrain01",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_27,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables03",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_27,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables04",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_27,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables07",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_27,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables08",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_27,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_27_00 <- schema_twn_27 %>%
  #   setIDVar(name = "year", columns = 21) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 10, 15, 22)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(7, 11, 16, 19))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "coarseGrain02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_27_00,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "specialCrops",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_27_00,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables06",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_27_00,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_28 <- setCluster(id = "al1", left = 4, top = 14, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 15) %>%
  #   setIDVar(name = "commodities", columns = c(4, 10), rows = 5) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(4, 10)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(5, 11)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 12)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(7, 13))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "sugar",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_28,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_29 <- setCluster(id = "commodities", left = c(5, 8, 12, 15), top = 12, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 18) %>%
  #   setIDVar(name = "commodities", columns = c(5, 8, 12, 15), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(4, 7, 11, 14)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(5, 8, 12, 15)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(6, 9, 13, 16))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables01",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_29,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_30 <- setCluster(id = "al1", left = 4, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 21) %>%
  #   setIDVar(name = "commodities", columns = c(4, 8, 13, 16), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(4, 8, 13, 16)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(5, 9, 14, 17)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 10, 12, 18)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(7, 11, 15, 19))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_30,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables05",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_30,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_31 <- setCluster(id = "al1", left = 4, top = 12, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 22) %>%
  #   setIDVar(name = "commodities", columns = 13, rows = 3) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 4) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = 8) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = 13) %>%
  #   setObsVar(name = "production", unit = "t", columns = 17)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "chineseCabbage",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_31,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "cabbage",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_31,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "cauliflower",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_31,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "watermelon",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_31,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "cantaloupe",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_31,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_32 <- setCluster(id = "commodities", left = c(4, 8, 15, 17, 20), top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 25) %>%
  #   setIDVar(name = "commodities", columns = c(4, 8, 15, 17, 20), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(4, 8, 12, 17, 20)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(5, 9, 13, 18, 21)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 10, 15, 26, 22)) %>%
  #   setObsVar(name = "production", unit = "t", columns =c(7, 11, 16, 19, 23))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables09",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_32,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_33 <- setCluster(id = "al1", left = 4, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 24) %>%
  #   setIDVar(name = "commodities", columns = c(4, 8), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(4, 8)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(5, 9)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 10)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(7, 11))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "vegetables10",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_33,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_34 <- setCluster(id = "al1", left = 4, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 24) %>%
  #   setIDVar(name = "commodities", value = "shiitake") %>%
  #   setObsVar(name = "production", unit = "t", columns = 16) %>%
  #   setObsVar(name = "production/wood-cultured", unit = "t", columns = 16) %>%
  #   setObsVar(name = "production/bag-cultures", unit = "t", columns = 19) %>%
  #   setObsVar(name = "production/golden musshroom", unit = "t", columns = 22)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "shiitake",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_34,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_35 <- setCluster(id = "al1", left = 4, top = 11, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 14) %>%
  #   setIDVar(name = "commodities", columns = c(4, 9), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(4, 9)) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(5, 10)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 11)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(7, 12))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits03",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits04",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits06",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits07",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits08",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits09",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits10",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits11",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits12",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits13",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits14",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_35_00 <- schema_twn_35 %>%
  #   setIDVar(name = "year", columns = 13) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 14)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(7, 11))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits05",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35_00,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "fruits15",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35_00,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_35_01 <- schema_twn_35 %>%
  #   setIDVar(name = "commodities", columns = 9, rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 9) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = 10) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = 11) %>%
  #   setObsVar(name = "production", unit = "t", columns = 12)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "bananas",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35_01,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_35_02 <- schema_twn_35 %>%
  #   setIDVar(name = "commodities", columns = 4, rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 4) %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = 5) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = 6) %>%
  #   setObsVar(name = "production", unit = "t", columns = 7)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "totalFruits",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_35_02,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_36 <- setCluster(id = "al1", left = 4, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 24) %>%
  #   setIDVar(name = "commodities", value = "flowers total") %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 4)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowersTotal",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_36,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_36_00 <- schema_twn_36 %>%
  #   setCluster(id = "commodities", left = c(7, 11, 14, 17, 20), top = 13, height = 12) %>%
  #   setIDVar(name = "commodities", columns = c(7, 11, 14, 17, 20), rows = 7) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(7, 10, 14, 17, 20)) %>%
  #   setObsVar(name = "yield", unit = "n/ha", factor = 12, columns = c(8, 11, 15, 18, 21)) %>%
  #   setObsVar(name = "production", unit = "n", factor = 12000, columns = c(9, 13, 16, 19, 22))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowers01",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_36_00,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_37 <- setCluster(id = "al1", left = 4, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 24) %>%
  #   setIDVar(name = "commodities", columns = c(4, 7, 10, 14, 17, 20), rows = 7) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(4, 7, 10, 14, 17, 20)) %>%
  #   setObsVar(name = "yield", unit = "n/ha", factor = 12, columns = c(5, 8, 11, 15, 18, 21)) %>%
  #   setObsVar(name = "production", unit = "n", factor = 12000, columns = c(6, 9, 12, 16, 19, 22))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowers02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_37,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_38 <- setCluster(id = "al1", left = 4, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 15) %>%
  #   setIDVar(name = "commodities", columns = c(4, 7, 11), rows = 7) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(4, 7, 11)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(5, 9, 12)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(6, 10, 13))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "forageCrops",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_38,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_39 <- setCluster(id = "al1", left = 4, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 20) %>%
  #   setIDVar(name = "commodities", columns = c(4, 6, 8, 10, 13, 15, 17), rows = 7) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(4, 6, 8, 10, 13, 15, 17)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(5, 7, 9, 12, 14, 16, 18))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "greenManureCrops",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_39,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "greenManureCrops02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_39,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_40 <- setCluster(id = "al1", left = 4, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 27) %>%
  #   setIDVar(name = "commodities", columns = c(4, 7), rows = 7) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(4, 7)) %>%
  #   setObsVar(name = "yield", unit = "n/ha", factor = 12, columns = c(5, 15)) %>%
  #   setObsVar(name = "production", unit = "n", factor = 12000, columns = c(6, 8))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowers03",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_40,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_40_00 <- schema_twn_40 %>%
  #   setIDVar(name = "commodities", columns = c(9, 16, 19), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(9, 16, 19)) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = c(10, 17, 20)) %>%
  #   setObsVar(name = "production", unit = "t", columns = c(11, 18, 21))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowers04",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_40_00,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_twn_41 <- setCluster(id = "al1", left = 9, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 27) %>%
  #   setIDVar(name = "commodities", columns = c(12, 22, 24), rows = 6) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = c(12, 22, 24))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "flowers05",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_41,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "2009_2018_Agriculture.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
#
#   schema_twn_42 <- setCluster(id = "year", left = 2, top = 25, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 18), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 18) %>%
#     setIDVar(name = "year", columns = 18, rows = 24) %>%
#     setIDVar(name = "commodities", columns = 10, rows = 3) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = 2) %>%
#     setObsVar(name = "yield/paddy rice", unit = "kg/ha", columns = 5) %>%
#     setObsVar(name = "yield/brown rice", unit = "kg/ha", columns = 8) %>%
#     setObsVar(name = "production/paddy rice", unit = "t", columns = 12) %>%
#     setObsVar(name = "production/brown rice", unit = "t", columns = 15)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_42_00 <- schema_twn_42 %>%
#     setFormat(thousand = ",")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_00,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_42_01 <- schema_twn_42 %>%
#     setCluster(id = "year", left = 2, top = 26, height = 31) %>%
#     setIDVar(name = "year", columns = 18, rows = 25)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_01,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_01,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_01,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_01,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_01,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_01,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_42_02 <- schema_twn_42 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 31) %>%
#     setIDVar(name = "year", columns = 18, rows = 26)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_02,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_02,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_02,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_02,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_02,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_02,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_42_03 <- schema_twn_42 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 31) %>%
#     setIDVar(name = "year", columns = 18, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_03,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_03,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_03,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_03,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_03,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_03,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_42_04 <- schema_twn_42 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 31) %>%
#     setIDVar(name = "year", columns = 18, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_04,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_04,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_04,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_04,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_04,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_04,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_04,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_04,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_04,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_04,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_04,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_42_04,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_43 <- setCluster(id = "year", left = 2, top = 25, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 19), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 19) %>%
#     setIDVar(name = "year", columns = 19, rows = 24) %>%
#     setIDVar(name = "commodities", columns = 11, rows = 3) %>%
#     setObsVar(name = "planted", unit = "ha", columns = 2) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = 6) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = 11) %>%
#     setObsVar(name = "production", unit = "t", columns = 15)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "feedCorn",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "foodCorn",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sweetPotato",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "peanuts",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "radishes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "carrots",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseMustard",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "tomato",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "muskmelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_43_00 <- schema_twn_43 %>%
#     setCluster(id = "year", left = 2, top = 26, height = 32) %>%
#     setIDVar(name = "year", columns = 19, rows = 25)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "feedCorn",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "foodCorn",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sweetPotato",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "peanuts",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "radishes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "carrots",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseMustard",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "tomato",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "muskmelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_43_01 <- schema_twn_43 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 31) %>%
#     setIDVar(name = "year", columns = 19, rows = 26)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "feedCorn",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "foodCorn",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sweetPotato",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "peanuts",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "feedCorn",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_01,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "foodCorn",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_01,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sweetPotato",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_01,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "peanuts",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_01,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_43_02 <- schema_twn_43 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 31) %>%
#     setIDVar(name = "year", columns = 19, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "radishes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "carrots",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseMustard",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "tomato",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "melons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "melons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "radishes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "carrots",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseMustard",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "tomato",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "feedCorn",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "foodCorn",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sweetPotatos",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "peanuts",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_02,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_43_03 <- schema_twn_43 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 31) %>%
#     setIDVar(name = "year", columns = 19, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "radishes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "carrots",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseMustard",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "tomato",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "melons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_03,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_03,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cauliflower",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_03,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_03,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_03,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_43_04 <- schema_twn_43 %>%
#     setCluster(id = "year", left = 2, top = 24, height = 31) %>%
#     setIDVar(name = "year", columns = 19, rows = 23)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_04,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_04,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cauliflower",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_04,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_04,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_04,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_04,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_04,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cauliflower",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_04,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_04,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_04,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_04,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_04,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cauliflower",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_04,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_04,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_43_04,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_44 <- setCluster(id = "year", left = 2, top = 25, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 18), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 18) %>%
#     setIDVar(name = "year", columns = 18, rows = 24) %>%
#     setIDVar(name = "commodities", columns = c(2, 6, 11, 15), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 11, 15)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(3, 7, 12, 16)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 13, 10)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(5, 9, 14, 17))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_44_00 <- setCluster(id = "commodities", left = c(6, 14), top = 26, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 18), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 18) %>%
#     setIDVar(name = "year", value = "1999") %>%
#     setIDVar(name = "commodities", columns = c(6, 14), rows = 5) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 14)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(3, 15)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 16)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(5, 17))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_00,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_44_01 <- schema_twn_44 %>%
#     setCluster(id = "year", left = 2, top = 26, height = 31) %>%
#     setIDVar(name = "year", columns = 18, rows = 25)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_01,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_44_02 <- schema_twn_44_00 %>%
#     setCluster(id = "commodities", left = c(6, 14), top = 27, height = 32) %>%
#     setIDVar(name = "year", value = "2000")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_02,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_44_03 <- schema_twn_44 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 31) %>%
#     setIDVar(name = "year", columns = 18, rows = 26)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_03,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_03,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_44_04 <- setCluster(id = "commodities", left = c(7, 15), top = 28, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 20), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 20) %>%
#     setIDVar(name = "year", value = "2001") %>%
#     setIDVar(name = "commodities", columns = c(7, 15), rows = 5) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 15)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(3, 16)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 17)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(5, 18))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_04,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_44_05 <- schema_twn_44_00 %>%
#     setCluster(id = "commodities", left = c(6, 14), top = 28, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 19), invert = TRUE) %>%
#     setFormat(thousand = ",") %>%
#     setIDVar(name = "al3", columns = 19) %>%
#     setIDVar(name = "year", value = "2002")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_05,
#            begin = 2002,
#            end = 2002,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_44_06 <- schema_twn_44 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 31) %>%
#     setIDVar(name = "year", columns = 18, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_06,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_06,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_44_07 <- schema_twn_44_00 %>%
#     setCluster(id = "commodities", left = c(6, 14), top = 29, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 19), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 19) %>%
#     setIDVar(name = "year", value = "2003")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_07,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_44_08 <- schema_twn_44 %>%
#     setFilter(rows = .find(".. Province", col = 19), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 19) %>%
#     setIDVar(name = "year", columns = 19, rows = 24) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 13, 17)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(5, 9, 14, 18))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_08,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_08,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_08,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_44_09 <- setCluster(id = "year", left = 2, top = 29, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 13), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 13) %>%
#     setIDVar(name = "year", columns = 13, rows = 28) %>%
#     setIDVar(name = "commodities", columns = c(2, 8), rows = 5) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 8)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(3, 9)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 10)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(5, 11))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_09,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_44_10 <- schema_twn_44 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 32) %>%
#     setIDVar(name = "year", columns = 18, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_10,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_44_11 <- schema_twn_44_09 %>%
#     setCluster(id = "year", left = 2, top = 26, height = 32) %>%
#     setIDVar(name = "year", columns = 13, rows = 25)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_11,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_11,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_11,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_44_12 <- schema_twn_44 %>%
#     setFilter(rows = .find(".. Province", col = 19), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 19) %>%
#     setIDVar(name = "year", columns = 19, rows = 24) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 13, 17)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(5, 9, 14, 18))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_12,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_12,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_12,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_12,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_12,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_12,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_12,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_12,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_12,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_44_13 <- schema_twn_44 %>%
#     setIDVar(name = "year", value = "2006")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_44_13,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_45 <- setCluster(id = "commodities", left = c(2, 6, 11, 14, 17), top = 26, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 19), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 19) %>%
#     setIDVar(name = "year", value = "1999") %>%
#     setIDVar(name = "commodities", columns = c(2, 6, 11, 14, 17), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 23, 14, 24)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(3, 7, 11, 15, 17)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 12, 21, 22)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(5, 9, 13, 16, 18))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_45,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_45_00 <- schema_twn_45 %>%
#     setCluster(id = "commodities", left = c(2, 6, 11, 14, 17), top = 27, height = 32) %>%
#     setIDVar(name = "year", value = "2000")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_45_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_45_01 <- schema_twn_45 %>%
#     setCluster(id = "commodities", left = c(2, 7, 12, 16, 19), top = 28, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 22), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 22) %>%
#     setIDVar(name = "year", value = "2000") %>%
#     setIDVar(name = "commodities", columns = c(2, 7, 12, 16, 19), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 7, 11, 16, 21)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(3, 8, 12, 17, 19)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 9, 13, 15, 21)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(5, 10, 14, 18, 20))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_45_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_45_02 <- setCluster(id = "commodities", left = c(2, 6, 11, 14, 17), top = 28, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 20), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 20) %>%
#     setIDVar(name = "year", value = "2002") %>%
#     setIDVar(name = "commodities", columns = c(2, 6, 11, 14, 17), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 10, 14, 10)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(3, 7, 11, 15, 17)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 12, 10, 10)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(5, 9, 13, 16, 18))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_45_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_45_03 <- schema_twn_45 %>%
#     setCluster(id = "commodities", left = c(2, 6, 11, 14, 17), top = 29, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 20), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 20) %>%
#     setIDVar(name = "year", value = "2003") %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 10, 14, 10)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 12, 10, 10))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_45_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_45_04 <- schema_twn_45_03 %>%
#     setIDVar(name = "year", value = "2004")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_45_04,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_45_05 <- schema_twn_45 %>%
#     setFilter(rows = .find(".. Province", col = 20), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 20) %>%
#     setIDVar(name = "year", value = "2006") %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 10, 14, 10)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 12, 10, 10))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_45_05,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_45_06 <- schema_twn_45_03 %>%
#     setIDVar(name = "year", value = "2007")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_45_06,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_45_07 <- schema_twn_45_03 %>%
#     setIDVar(name = "year", value = "2008")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_45_07,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_46 <- setCluster(id = "commodities", left = c(3, 6, 10, 13), top = 26, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 15), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 15) %>%
#     setIDVar(name = "year", value = "1999") %>%
#     setIDVar(name = "commodities", columns = c(3, 6, 10, 13), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 9, 12)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(3, 6, 10, 13)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(4, 7, 11, 14))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_46,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_46_00 <- schema_twn_46 %>%
#     setCluster(id = "commodities", left = c(3, 6, 10, 13), top = 27, height = 32) %>%
#     setIDVar(name = "year", value = "2000")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_46_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_46_01 <- schema_twn_46 %>%
#     setCluster(id = "commodities", left = c(3, 6, 10, 13), top = 28, height = 32) %>%
#     setIDVar(name = "year", value = "2001")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_46_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_46_02 <- schema_twn_46_01 %>%
#     setIDVar(name = "year", value = "2002")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_46_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_46_03 <- schema_twn_46 %>%
#     setCluster(id = "commodities", left = c(3, 6, 10, 13), top = 29, height = 32) %>%
#     setIDVar(name = "year", value = "2003")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_46_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_46_04 <- schema_twn_46_01 %>%
#     setIDVar(name = "commodities", columns = c(3, 6, 10, 13), rows = 6) %>%
#     setIDVar(name = "year", value = "2004")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_46_04,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_46_05 <- schema_twn_46 %>%
#     setCluster(id = "commodities", left = c(3, 6, 10, 13), top = 24, height = 32) %>%
#     setIDVar(name = "year", value = "2007") %>%
#     setIDVar(name = "commodities", columns = c(3, 6, 10, 13), rows = 6)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_46_05,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_46_06 <- schema_twn_46_05 %>%
#     setIDVar(name = "year", value = "2008")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_46_06,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_47 <- setCluster(id = "commodities", left =  c(3, 6, 11, 14), top = 26, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 18), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 18) %>%
#     setIDVar(name = "year", value = "1999") %>%
#     setIDVar(name = "commodities", columns = c(3, 6, 11, 14), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 10, 14)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(3, 6, 11, 15)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(19, 7, 12, 16)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(4, 8, 13, 17))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_47_00 <- schema_twn_47 %>%
#     setCluster(id = "commodities", left =  c(2, 5, 10, 14), top = 26, height = 32) %>%
#     setIDVar(name = "commodities", columns = c(2, 5, 10, 14), rows = 6)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_00,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_00,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_47_01 <- schema_twn_47 %>%
#     setCluster(id = "commodities", left =  c(3, 6, 11, 14), top = 27, height = 32) %>%
#     setIDVar(name = "year", value = "2000")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_01,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_47_02 <- schema_twn_47_00 %>%
#     setCluster(id = "commodities", left =  c(2, 5, 10, 14), top = 27, height = 32) %>%
#     setIDVar(name = "year", value = "2000") %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(9, 7, 12, 16))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_02,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_02,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_47_03 <- schema_twn_47_01 %>%
#     setCluster(id = "commodities", left =  c(3, 6, 11, 14), top = 28, height = 32) %>%
#     setIDVar(name = "year", value = "2001")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_03,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_47_04 <- schema_twn_47_02 %>%
#     setCluster(id = "commodities", left =  c(2, 5, 10, 14), top = 28, height = 32) %>%
#     setIDVar(name = "year", value = "2001")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_04,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_04,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_47_05 <- schema_twn_47_03 %>%
#     setIDVar(name = "year", value = "2002")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_05,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_47_06 <- schema_twn_47_04 %>%
#     setIDVar(name = "year", value = "2002")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_06,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_06,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_47_07 <- schema_twn_47_01 %>%
#     setCluster(id = "commodities", left =  c(3, 6, 11, 14), top = 29, height = 32) %>%
#     setIDVar(name = "year", value = "2003")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_07,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_47_08 <- schema_twn_47_02 %>%
#     setCluster(id = "commodities", left =  c(2, 5, 10, 14), top = 29, height = 32) %>%
#     setIDVar(name = "year", value = "2003")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_08,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_08,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_47_09 <- schema_twn_47 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 32) %>%
#     setIDVar(name = "year", columns = 18, rows = 28) %>%
#     setIDVar(name = "commodities", columns = c(2, 6, 11, 14), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 11, 14)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(3, 7, 12, 15)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 10, 16)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(5, 9, 13, 17))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_09,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_09,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_47_10 <- schema_twn_47_09 %>%
#     setCluster(id = "year", left = 2, top = 25, height = 32) %>%
#     setIDVar(name = "year", columns = 18, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_10,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_47_10 <- schema_twn_47_09 %>%
#     setCluster(id = "year", left = 2, top = 25, height = 32) %>%
#     setIDVar(name = "year", columns = 18, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_10,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_10,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_10,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_10,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_47_10,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_48 <- setCluster(id = "year", left = 2, top = 26, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 19), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 19) %>%
#     setIDVar(name = "year", columns = 19, rows = 25) %>%
#     setIDVar(name = "commodities", columns = c(2, 6, 11, 15), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 11, 15)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(3, 7, 12, 16)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 13, 17)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(5, 9, 14, 18))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_48_00 <- schema_twn_48 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 32) %>%
#     setIDVar(name = "year", columns = 19, rows = 26)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_48_01 <- schema_twn_48 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 32) %>%
#     setIDVar(name = "year", columns = 19, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_01,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_01,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_01,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_48_02 <- schema_twn_48 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 32) %>%
#     setIDVar(name = "year", columns = 19, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_02,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_02,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_02,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_02,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_02,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_02,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_02,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_48_03 <- schema_twn_48 %>%
#     setCluster(id = "year", left = 2, top = 25, height = 32) %>%
#     setIDVar(name = "year", columns = 19, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_03,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_03,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_03,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_48_03,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_49 <- setCluster(id = "commodities", left = c(3, 7, 12, 16, 20), top = 26, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 22), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 22) %>%
#     setIDVar(name = "year", value = "1999") %>%
#     setIDVar(name = "commodities", columns = c(3, 7, 12, 16, 20), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 11, 15, 19)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(3, 7, 12, 16, 20)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 13, 17, 23)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(5, 9, 14, 18, 21))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_49,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_49_00 <- schema_twn_49 %>%
#     setCluster(id = "commodities", left = c(3, 7, 12, 16, 20), top = 27, height = 32) %>%
#     setIDVar(name = "year", value = "2000")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_49_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_49_01 <- schema_twn_49 %>%
#     setCluster(id = "commodities", left = c(3, 7, 12, 16, 20), top = 28, height = 32) %>%
#     setIDVar(name = "year", value = "2001") %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 13, 17, 10))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_49_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_49_02 <- schema_twn_49_01 %>%
#     setIDVar(name = "year", value = "2002")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_49_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_49_03 <- schema_twn_49_01 %>%
#     setCluster(id = "commodities", left = c(3, 7, 12, 16, 20), top = 29, height = 32) %>%
#     setIDVar(name = "year", value = "2003")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_49_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_49_04 <- setCluster(id = "commodities", left = c(2, 6, 13, 15, 18), top = 29, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 22), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 22) %>%
#     setIDVar(name = "year", value = "2004") %>%
#     setIDVar(name = "commodities", columns = c(2, 6, 13, 15, 18), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 6, 10, 15, 18)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(3, 7, 11, 16, 19)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8, 13, 12, 20)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(5, 9, 14, 17, 21))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_49_04,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_49_05 <- schema_twn_49_04 %>%
#     setCluster(id = "commodities", left = c(2, 6, 13, 15, 18), top = 25, height = 32) %>%
#     setIDVar(name = "year", value = "2006")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_49_05,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_49_06 <- schema_twn_49_05 %>%
#     setIDVar(name = "year", value = "2007")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_49_06,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_49_07 <- schema_twn_49_05 %>%
#     setIDVar(name = "year", value = "2008")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_49_07,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_50 <- setCluster(id = "year", left = 2, top = 26, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 18), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 18) %>%
#     setIDVar(name = "year", columns = 18, rows = 25) %>%
#     setIDVar(name = "commodities", columns = c(2, 6), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 6)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(3, 7)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 8)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(5, 9))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_50,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_50_00 <- schema_twn_50 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 32) %>%
#     setIDVar(name = "year", columns = 18, rows = 26)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_50_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_50_01 <- schema_twn_50 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 32) %>%
#     setIDVar(name = "year", columns = 18, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_50_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_50_02 <- schema_twn_50_01 %>%
#     setIDVar(name = "year", value = "2002")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_50_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_50_03 <- schema_twn_50_01 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 32) %>%
#     setIDVar(name = "commodities", columns = c(2, 6), rows = 5) %>%
#     setIDVar(name = "year", columns = 18, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_50_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_50_04 <- schema_twn_50 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 32) %>%
#     setIDVar(name = "year", columns = 18, rows = 28) %>%
#     setIDVar(name = "commodities", columns = c(2, 6), rows = 6)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_50_04,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_50_05 <- schema_twn_50_04 %>%
#     setCluster(id = "year", left = 2, top = 25, height = 32) %>%
#     setIDVar(name = "year", columns = 18, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_50_05,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_50_05,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_50_05,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_51 <- setCluster(id = "year", left = 2, top = 26, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 14), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 14) %>%
#     setIDVar(name = "year", columns = 14, rows = 25) %>%
#     setIDVar(name = "commodities", value = "total fruits") %>%
#     setObsVar(name = "planted", unit = "ha", columns = 2) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = 3) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = 4) %>%
#     setObsVar(name = "production", unit = "t", columns = 5)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_51_00 <- schema_twn_51 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 32) %>%
#     setIDVar(name = "year",  columns = 14, rows = 26)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_51_01 <- schema_twn_51 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 16), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 16) %>%
#     setIDVar(name = "year", columns = 16, rows = 27) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = 5) %>%
#     setObsVar(name = "production", unit = "t", columns = 6)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_51_02 <- schema_twn_51_01 %>%
#     setFilter(rows = .find(".. Province", col = 15), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 15) %>%
#     setIDVar(name = "year", columns = 15, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_51_03 <- schema_twn_51_02 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 32) %>%
#     setIDVar(name = "year", columns = 15, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_51_04 <- schema_twn_51 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 11), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 11) %>%
#     setIDVar(name = "year", columns = 11, rows = 26)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_04,
#            begin = 2004,
#            end = 2004,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_51_05 <- setCluster(id = "year", left = 2, top = 23, height = 36) %>%
#     setFilter(rows = .find(".. Province", col = 13), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 13) %>%
#     setIDVar(name = "year", columns = 14, rows = 22) %>%
#     setIDVar(name = "commodities", value = "total fruits") %>%
#     setObsVar(name = "planted", unit = "ha", columns = 4) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = 5) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = 6) %>%
#     setObsVar(name = "production", unit = "t", columns = 7)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_05,
#            begin = 2005,
#            end = 2005,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_05,
#            begin = 2010,
#            end = 2010,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_05,
#            begin = 2011,
#            end = 2011,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_05,
#            begin = 2012,
#            end = 2012,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_05,
#            begin = 2013,
#            end = 2013,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_05,
#            begin = 2014,
#            end = 2014,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_05,
#            begin = 2015,
#            end = 2015,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_05,
#            begin = 2016,
#            end = 2016,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_05,
#            begin = 2017,
#            end = 2017,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_05,
#            begin = 2018,
#            end = 2018,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_51_06 <- schema_twn_51_04 %>%
#     setCluster(id = "year", left = 2, top = 23, height = 32) %>%
#     setIDVar(name = "year", columns = 11, rows = 22)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_06,
#            begin = 2006,
#            end = 2006,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_06,
#            begin = 2007,
#            end = 2007,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_06,
#            begin = 2008,
#            end = 2008,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_51_07 <- schema_twn_51_05 %>%
#     setIDVar(name = "year", columns = 13, rows = 22)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "totalFruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_51_07,
#            begin = 2009,
#            end = 2009,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_52 <- setCluster(id = "year", left = 7, top = 26, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 14), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 14) %>%
#     setIDVar(name = "year", value = "1999") %>%
#     setIDVar(name = "commodities", value = "bananas") %>%
#     setObsVar(name = "planted", unit = "ha", columns = 9) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = 10) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = 12) %>%
#     setObsVar(name = "production", unit = "t", columns = 13)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_52,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_52_00 <- schema_twn_52 %>%
#     setCluster(id = "year", left = 7, top = 27, height = 32) %>%
#     setIDVar(name = "year", columns = 14, rows = 26)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_52_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_52_01 <- setCluster(id = "year", left = 7, top = 28, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 16), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 16) %>%
#     setIDVar(name = "year", columns = 16, rows = 27) %>%
#     setIDVar(name = "commodities", value = "bananas") %>%
#     setObsVar(name = "planted", unit = "ha", columns = 10) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = 11) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = 13) %>%
#     setObsVar(name = "production", unit = "t", columns = 14)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_52_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_52_02 <- schema_twn_52_01 %>%
#     setFilter(rows = .find(".. Province", col = 15), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 15) %>%
#     setIDVar(name = "year", columns = 15, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_52_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_52_03 <- schema_twn_52_02 %>%
#     setCluster(id = "year", left = 7, top = 29, height = 32) %>%
#     setIDVar(name = "year", columns = 15, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_52_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_53 <- setCluster(id = "year", left = 2, top = 26, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 17), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 17) %>%
#     setIDVar(name = "year", columns = 17, rows = 25) %>%
#     setIDVar(name = "commodities", columns = c(2, 10), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(4, 12)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(5, 13)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(7, 15)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(8, 16))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_00 <- schema_twn_53 %>%
#     setCluster(id = "commodities", left = c(4, 10), top = 26, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 15), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 15) %>%
#     setIDVar(name = "year", value = "1999") %>%
#     setIDVar(name = "commodities", columns = c(4, 10), rows = 6) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(7, 16)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(8, 16))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_00,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_01 <- schema_twn_53 %>%
#     setCluster(id = "commodities", left = c(2, 13), top = 26, height = 32) %>%
#     setIDVar(name = "year", value = "1999") %>%
#     setIDVar(name = "commodities", columns = c(2, 13), rows = 6)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_01,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_02 <- schema_twn_53 %>%
#     setFilter(rows = .find(".. Province", col = 15), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 15) %>%
#     setIDVar(name = "year", columns = 15, rows = 15) %>%
#     setObsVar(name = "yield/per plant", unit = "kg/n", columns = c(6, 16)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(7, 17)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(8, 14))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_02,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_03 <- schema_twn_53 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 32) %>%
#     setIDVar(name = "year", value = "2000")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_03,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_03,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_03,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_03,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_03,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_03,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_03,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_03,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_03,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_03,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_03,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_03,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_03,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_04 <- schema_twn_53_00 %>%
#     setCluster(id = "commodities", left = c(4, 10), top = 27, height = 31) %>%
#     setIDVar(name = "year", value = "2000")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_04,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_05 <- schema_twn_53_01 %>%
#     setCluster(id = "commodities", left = c(2, 13), top = 27, height = 31) %>%
#     setIDVar(name = "year", value = "2000")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_05,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_06 <- schema_twn_53_02 %>%
#     setCluster(id = "commodities", left = c(2, 10), top = 27, height = 31) %>%
#     setIDVar(name = "year", value = "2000")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits16",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_06,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_07 <- schema_twn_53 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 18), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 18) %>%
#     setIDVar(name = "year", value = "2001")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_07,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_07,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_07,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_07,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_07,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_07,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_07,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_07,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_07,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_07,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_07,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_08 <- setCluster(id = "year", left = 2, top = 28, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 18), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 18) %>%
#     setIDVar(name = "year", value = "2001") %>%
#     setIDVar(name = "commodities", columns = 4, rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = 4) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = 5) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = 7) %>%
#     setObsVar(name = "production", unit = "t", columns = 8)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_08,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_09 <- setCluster(id = "year", left = 2, top = 28, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 18), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 18) %>%
#     setIDVar(name = "year", value = "2001") %>%
#     setIDVar(name = "commodities", columns = 10, rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = 12) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = 13)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_09,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_10 <- schema_twn_53_01 %>%
#     setCluster(id = "commodities", left = c(2, 13), top = 28, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 18), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 18) %>%
#     setIDVar(name = "year", value = "2001")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_10,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_11 <- schema_twn_53 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 32) %>%
#     setIDVar(name = "year", columns = 17, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits16",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits17",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            evel = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits16",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_11,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_12 <- schema_twn_53_00 %>%
#     setCluster(id = "commodities", left = c(4, 10), top = 28, height = 31) %>%
#     setIDVar(name = "year", value = "2002")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_12,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_13 <- schema_twn_53_01 %>%
#     setCluster(id = "commodities", left = c(2, 13), top = 28, height = 31) %>%
#     setIDVar(name = "year", value = "2002")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_13,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_14 <- schema_twn_53 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 32) %>%
#     setIDVar(name = "year", columns = 17, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_14,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_14,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_14,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_14,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_14,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_14,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_14,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_14,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_14,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_14,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_14,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_14,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_14,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits16",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_14,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_15 <- schema_twn_53_00 %>%
#     setCluster(id = "commodities", left = c(4, 10), top = 29, height = 31) %>%
#     setIDVar(name = "year", value = "2003")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_15,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_16 <- schema_twn_53_01 %>%
#     setCluster(id = "commodities", left = c(2, 13), top = 29, height = 31) %>%
#     setIDVar(name = "year", value = "2003")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_16,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_17 <- setCluster(id = "year", left = 2, top = 27, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 11), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 11) %>%
#     setIDVar(name = "year", columns = 11, rows = 26) %>%
#     setIDVar(name = "commodities", columns = c(2, 7), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 7)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(3, 8)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 9)) %>%
#     setObsVar(name = "production", unit = "n", columns = c(5, 10))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_17,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_17,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_17,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_17,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_17,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_17,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_17,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_17,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_17,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_17,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_17,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_17,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_18 <- schema_twn_53_17 %>%
#     setFilter(rows = .find(".. Province", col = 10), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 10) %>%
#     setIDVar(name = "year", columns = 10, rows = 26) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 6)) %>%
#     setObsVar(name = "production", unit = "n", columns = c(5, 9))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_18,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_18,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_19 <- schema_twn_53_17 %>%
#     setCluster(id = "year", left = 2, top = 23, height = 31) %>%
#     setIDVar(name = "year", columns = 11, rows = 22)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_19,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_20 <- schema_twn_53_18 %>%
#     setCluster(id = "year", left = 2, top = 23, height = 31) %>%
#     setIDVar(name = "year", columns = 10, rows = 22)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_20,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_20,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_20,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_20,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_20,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_20,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_21 <- schema_twn_53_17 %>%
#     setIDVar(name = "commodities", columns = 7, rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = 7) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = 8) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = 9) %>%
#     setObsVar(name = "production", unit = "n", columns = 10)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_21,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_53_22 <- schema_twn_53_21 %>%
#     setCluster(id = "year", left = 2, top = 23, height = 31) %>%
#     setIDVar(name = "year", columns = 11, rows = 22)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_22,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_22,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_53_22,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_54 <- setCluster(id = "year", left = 5, top = 25, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 18), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 18) %>%
#     setIDVar(name = "year", columns = 18, rows = 24) %>%
#     setIDVar(name = "commodities", columns = c(5, 8, 12, 15), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(5, 8, 12, 15)) %>%
#     setObsVar(name = "yield", unit = "n/ha", factor = 12, columns = c(6, 9, 13, 16)) %>%
#     setObsVar(name = "production", unit = "n", factor = 12000, columns = c(7, 11, 14, 17))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_54,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_54_00 <- schema_twn_54 %>%
#     setCluster(id = "year", left = 5, top = 27, height = 31) %>%
#     setIDVar(name = "year", columns = 18, rows = 26)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_54_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_54_01 <- schema_twn_54 %>%
#     setCluster(id = "year", left = 5, top = 28, height = 31) %>%
#     setIDVar(name = "year", columns = 18, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_54_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_54_01,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_54_02 <- schema_twn_54 %>%
#     setCluster(id = "year", left = 5, top = 29, height = 31) %>%
#     setIDVar(name = "year", columns = 18, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_54_02,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_54_03 <- schema_twn_54_02 %>%
#     setCluster(id = "commodities", left = c(5, 9, 12, 15), top = 29, height = 31) %>%
#     setIDVar(name = "year", value = "2004") %>%
#     setIDVar(name = "commodities", columns = c(5, 9, 12, 15), rows = 7)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_54_03,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_54_04 <- schema_twn_54_02 %>%
#     setCluster(id = "commodities", left = c(5, 9, 12, 15), top = 25, height = 31) %>%
#     setIDVar(name = "year", value = "2006") %>%
#     setIDVar(name = "commodities", columns = c(5, 9, 12, 15), rows = 7)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_54_04,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_54_05 <- schema_twn_54_04 %>%
#     setIDVar(name = "year", value = "2007")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_54_05,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_54_06 <- schema_twn_54_04 %>%
#     setIDVar(name = "year", value = "2008")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_54_06,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_55 <- setCluster(id = "year", left = 2, top = 25, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 21), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 21) %>%
#     setIDVar(name = "year", columns = 21, rows = 24) %>%
#     setIDVar(name = "commodities", columns = c(2, 5, 8, 12, 15, 18), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 8, 12, 15, 18)) %>%
#     setObsVar(name = "yield", unit = "n/ha", factor = 12, columns = c(3, 6, 9, 13, 16, 19)) %>%
#     setObsVar(name = "production", unit = "n", factor = 12000, columns = c(4, 7, 10, 14, 17, 20))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_55,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_55,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_55,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_55,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_55_00 <- schema_twn_55 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 26)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_55_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_55_01 <- schema_twn_55 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_55_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_55_01,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_55_02 <- schema_twn_55 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_55_02,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_55_02,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_56 <- setCluster(id = "year", left = 2, top = 25, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 21), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 21) %>%
#     setIDVar(name = "year", columns = 21, rows = 24) %>%
#     setIDVar(name = "commodities", columns = c(2, 5, 8), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 8)) %>%
#     setObsVar(name = "yield", unit = "n/ha", columns = c(3, 6, 10)) %>%
#     setObsVar(name = "production", unit = "n", factor = 12000, columns = c(4, 7, 9))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_00 <- schema_twn_56 %>%
#     setIDVar(name = "commodities", columns = c(11, 14), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(11, 14)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(12, 15)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(13, 16))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_00,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_00,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_00,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_00,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_01 <- setCluster(id = "year", left = 2, top = 25, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 21), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 21) %>%
#     setIDVar(name = "year", value = "1999") %>%
#     setIDVar(name = "commodities", columns = c(17, 19), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(17, 19))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_01,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_01,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_01,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_01,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_02 <- schema_twn_56 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 31) %>%
#     setIDVar(name = "year", value = "2000")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_02,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_03 <- schema_twn_56_00 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 31) %>%
#     setIDVar(name = "year", value = "2000")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_03,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_04 <- schema_twn_56_01 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_04,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_04,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_05 <- schema_twn_56 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 27) %>%
#     setIDVar(name = "commodities", columns = c(2, 5), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 5)) %>%
#     setObsVar(name = "yield", unit = "n/ha", factor = 12, columns = c(3, 10)) %>%
#     setObsVar(name = "production", unit = "n", factor = 12000, columns = c(4, 6))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_05,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_05,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_06 <- schema_twn_56 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 27) %>%
#     setIDVar(name = "commodities", value = "orchid") %>%
#     setObsVar(name = "planted", unit = "ha", columns = 7) %>%
#     setObsVar(name = "yield", unit = "bowl/ha", columns = 8) %>%
#     setObsVar(name = "production", unit = "bowls", factor = 1000, columns = 9)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_06,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_06,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_07 <- schema_twn_56_00 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 31) %>%
#     setIDVar(name = "year", value = "2000")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_07,
#            begin = 2000,
#            end = 2000,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_08 <- schema_twn_56_01 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 31) %>%
#     setIDVar(name = "year", value = "2001")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_08,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_09 <- schema_twn_56_05 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_09,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_09,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_10 <- schema_twn_56_06 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 31) %>%
#     setIDVar(name = "commodities", columns = 7, rows = 6) %>%
#     setIDVar(name = "year", columns = 21, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_10,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_10,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_11 <- schema_twn_56_04 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_11,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_11,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_12 <- schema_twn_56_04 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_12,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_13 <- schema_twn_56_00 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_13,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_14 <- schema_twn_56_05 %>%
#     setCluster(id = "year", left = 2, top = 25, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_14,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_14,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_14,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_56_15 <- schema_twn_56_10 %>%
#     setCluster(id = "year", left = 2, top = 25, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_15,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_15,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_56_15,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_57 <- setCluster(id = "year", left = 2, top = 26, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 15), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 15) %>%
#     setIDVar(name = "year", columns= 15, rows = 25) %>%
#     setIDVar(name = "commodities", columns = c(2, 5, 9, 12), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 9, 12)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(3, 6, 10, 13)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(4, 7, 11, 14))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_57,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_57_00 <- schema_twn_57 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 31) %>%
#     setIDVar(name = "year", columns = 15, rows = 26)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_57_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_57_01 <- schema_twn_57 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 31) %>%
#     setIDVar(name = "year", columns = 15, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_57_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_57_01,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_57_02 <- schema_twn_57 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 31) %>%
#     setIDVar(name = "year", columns = 15, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_57_02,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_57_03 <- setCluster(id = "year", left = 2, top = 29, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 12), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 12) %>%
#     setIDVar(name = "year", columns = 12, rows = 28) %>%
#     setIDVar(name = "commodities", columns = c(2, 5, 9), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 9)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(3, 7, 10)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(4, 8, 11))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_57_03,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_57_04 <- schema_twn_57_03 %>%
#     setCluster(id = "year", left = 2, top = 25, height = 31) %>%
#     setIDVar(name = "year", columns = 12, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_57_04,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_57_04,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_57_04,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_58 <- setCluster(id = "year", left = 2, top = 25, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 21), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 21) %>%
#     setIDVar(name = "year", columns = 21, rows = 24) %>%
#     setIDVar(name = "commodities", columns = c(2, 4, 6, 8, 10, 13, 15, 17, 19), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 4, 6, 8, 10, 13, 15, 17, 19)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(3, 5, 7, 9, 12, 14, 16, 18, 20))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_58,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_58_00 <- schema_twn_58 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 26)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_58_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_58_01 <- schema_twn_58 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_58_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_58_01,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_58_02 <- schema_twn_58 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_58_02,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_59 <-  setCluster(id = "year", left = 2, top = 26, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 19), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 19) %>%
#     setIDVar(name = "year", value = "1999") %>%
#     setIDVar(name = "commodities", columns = c(2, 4, 6, 8, 11, 13, 15, 17), rows = 8) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 4, 6, 8, 11, 13, 15, 17)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(3, 5, 7, 9, 12, 14, 16, 18))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_59,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_59_00 <- schema_twn_59 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 31) %>%
#     setIDVar(name = "year", columns = 19, rows = 26)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_59_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_59_01 <- schema_twn_59 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 31) %>%
#     setIDVar(name = "year", columns = 19, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_59_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_59_01,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_59_02 <- schema_twn_59 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 31) %>%
#     setIDVar(name = "year", columns = 19, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_59_02,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_59_03 <-  setCluster(id = "year", left = 2, top = 29, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 17), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 17) %>%
#     setIDVar(name = "year", columns = 17, rows = 28) %>%
#     setIDVar(name = "commodities", columns = c(2, 4, 6, 8, 11, 13, 15), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(2, 4, 6, 8, 11, 13, 15)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(3, 5, 7, 10, 12, 14, 16))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_59_03,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_59_03,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_59_04 <- schema_twn_59_03 %>%
#     setCluster(id = "year", left = 2, top = 25, height = 31) %>%
#     setIDVar(name = "year", columns = 17, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_59_04,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_59_04,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_59_04,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_59_04,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_59_04,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_59_04,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_60 <- setCluster(id = "year", left = 2, top = 25, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 18), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 18) %>%
#     setIDVar(name = "year", columns = 18, rows = 24) %>%
#     setIDVar(name = "commodities", value = "flowers total") %>%
#     setObsVar(name = "planted", unit = "ha", columns = 2)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_60,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_60,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_60,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_60,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_60_00 <- schema_twn_60 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 31) %>%
#     setIDVar(name = "year", value = "2000")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_60_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_60_01 <- schema_twn_60 %>%
#     setCluster(id = "year", left = 2, top = 27, height = 31) %>%
#     setIDVar(name = "year", value = "2000")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_60_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_60_02 <- schema_twn_60 %>%
#     setCluster(id = "year", left = 2, top = 28, height = 31) %>%
#     setIDVar(name = "year", columns = 18, rows = 27)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_60_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_60_03 <- schema_twn_60 %>%
#     setCluster(id = "year", left = 2, top = 29, height = 31) %>%
#     setIDVar(name = "year", columns = 18, rows = 28)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_60_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_60_03,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_61 <- setCluster(id = "year", left = 4, top = 25, height = 36) %>%
#     setFilter(rows = .find(".. Province", col = 20), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 20) %>%
#     setIDVar(name = "year", columns = 21, rows = 24) %>%
#     setIDVar(name = "commodities", columns = 12, rows = 3) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = 4) %>%
#     setObsVar(name = "yield/paddy rice", unit = "kg/ha", columns = 7) %>%
#     setObsVar(name = "yield/brown rice", unit = "kg/ha", columns = 10) %>%
#     setObsVar(name = "production/paddy rice", unit = "t", columns = 14) %>%
#     setObsVar(name = "production/brown rice", unit = "t", columns = 17)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_61_00 <- schema_twn_61 %>%
#     setCluster(id = "year", left = 4, top = 26, height = 32)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61_00,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_61_01 <- schema_twn_61 %>%
#     setCluster(id = "year", left = 4, top = 26, height = 32) %>%
#     setIDVar(name = "year", columns = 20, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61_01,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61_01,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61_01,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61_01,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "riceSubcategory05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_61_01,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_62 <- setCluster(id = "year", left = 4, top = 25, height = 36) %>%
#     setFilter(rows = .find(".. Province", col = 21), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 21) %>%
#     setIDVar(name = "year", columns = 22, rows = 24) %>%
#     setIDVar(name = "commodities", columns = c(4, 8, 13, 17), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(4, 8, 13, 17)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(5, 9, 14, 18)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 10, 15, 19)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(7, 11, 16, 20))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_62_00 <- schema_twn_62 %>%
#     setFilter(rows = .find(".. Province", col = 20), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 20) %>%
#     setIDVar(name = "year", columns = 21, rows = 24) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 10, 15, 12)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(7, 11, 16, 19))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_00,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_00,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_00,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_00,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_00,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_00,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_00,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_00,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_00,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_00,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_00,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_00,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_62_01 <- schema_twn_62 %>%
#     setCluster(id = "year", left = 4, top = 25, height = 32) %>%
#     setIDVar(name = "year", columns = 21, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_01,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_01,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_01,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            evel = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_01,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_01,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_62_02 <- schema_twn_62_00 %>%
#     setCluster(id = "year", left = 4, top = 25, height = 32) %>%
#     setIDVar(name = "year", columns = 20, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_02,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_02,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_62_03 <- schema_twn_62 %>%
#     setCluster(id = "year", left = 4, top = 25, height = 32)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_03,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_62_04 <- schema_twn_62_00 %>%
#     setCluster(id = "year", left = 4, top = 25, height = 32)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_04,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_04,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_04,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_04,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_04,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_04,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "coarseGrain02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_04,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_62_04,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_63 <- setCluster(id = "year", left = 4, top = 26, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 14), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 14) %>%
#     setIDVar(name = "year", columns = 15, rows = 25) %>%
#     setIDVar(name = "commodities", columns = c(4, 10), rows = 5) %>%
#     setObsVar(name = "planted", unit = "ha", columns =  c(4, 10)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(5, 11)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 12)) %>%
#     setObsVar(name = "production", unit = "ha", columns = c(7, 13))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_63,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_63,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_63,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_63,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_63,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_63,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_63,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_63,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_63,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_63,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_63_00 <- schema_twn_63 %>%
#     setFilter(rows = .find(".. Province", col = 15), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 15) %>%
#     setIDVar(name = "year", columns = 14, rows = 25)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "sugar",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_63_00,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_64 <- setCluster(id = "commodities", left = c(4, 8, 13, 16), top = 26, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 19), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 19) %>%
#     setIDVar(name = "year", value = "2005") %>%
#     setIDVar(name = "commodities", columns = c(4, 8, 13, 16), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(4, 8, 12, 16)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(5, 9, 13, 17)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 10, 14, 12)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(7, 11, 15, 18))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_64,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_64_00 <- setCluster(id = "commodities", left = c(4, 8, 13, 16, 19), top = 26, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 22), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 22) %>%
#     setIDVar(name = "year", value = "2009") %>%
#     setIDVar(name = "commodities", columns = c(4, 8, 13, 16, 19), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(4, 8, 12, 16, 23)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(5, 9, 13, 17, 19)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 10, 14, 12, 24)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(7, 11, 15, 18, 20))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_64_00,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_64_01 <- schema_twn_64 %>%
#     setIDVar(name = "year", value = "2010")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_64_01,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_64_02 <- schema_twn_64 %>%
#     setIDVar(name = "year", value = "2011")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_64_02,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_64_03 <- schema_twn_64 %>%
#     setIDVar(name = "year", value = "2012")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_64_03,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_64_04 <- schema_twn_64 %>%
#     setIDVar(name = "year", value = "2012")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_64_04,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_64_05 <- schema_twn_64 %>%
#     setIDVar(name = "year", value = "2014")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_64_05,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_64_06 <- setCluster(id = "commodities", left = c(4, 8, 13, 16), top = 26, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 20), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 20) %>%
#     setIDVar(name = "year", value = "2015") %>%
#     setIDVar(name = "commodities", columns = c(4, 8, 13, 17), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(4, 8, 13, 17)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(5, 9, 14, 18)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 10, 15, 12)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(7, 11, 16, 19))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_64_06,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_64_07 <- schema_twn_64_06 %>%
#     setIDVar(name = "year", value = "2016")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_64_07,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_64_08 <- schema_twn_64_06 %>%
#     setIDVar(name = "year", value = "2017")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_64_08,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_64_09 <- schema_twn_64_06 %>%
#     setIDVar(name = "year", value = "2018")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "specialCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_64_09,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_65 <- setCluster(id = "commodities", left = c(5, 8, 12, 15), top = 26, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 17), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 17) %>%
#     setIDVar(name = "year", value = "2005") %>%
#     setIDVar(name = "commodities", columns = c(5, 8, 12, 15), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(4, 7, 11, 14)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(5, 8, 12, 15)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(6, 9, 13, 16))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_65,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_65_00 <- schema_twn_65 %>%
#     setCluster(id = "commodities", left = c(5, 8, 12, 15), top = 24, height = 31) %>%
#     setIDVar(name = "year", value = "2006")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_65_00,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_65_01 <- schema_twn_65 %>%
#     setIDVar(name = "year", value = "2009")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_65_01,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_65_02 <- schema_twn_65 %>%
#     setIDVar(name = "year", value = "2010")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_65_02,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_65_03 <- schema_twn_65 %>%
#     setIDVar(name = "year", value = "2011")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_65_03,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_65_04 <- schema_twn_65 %>%
#     setIDVar(name = "year", value = "2012")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_65_04,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_65_05 <- schema_twn_65 %>%
#     setIDVar(name = "year", value = "2013")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_65_05,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_65_06 <- schema_twn_65 %>%
#     setIDVar(name = "year", value = "2014")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_65_06,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_65_07 <- schema_twn_65 %>%
#     setIDVar(name = "year", value = "2015")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_65_07,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_65_08 <- schema_twn_65 %>%
#     setIDVar(name = "year", value = "2016")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_65_08,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_65_09 <- schema_twn_65 %>%
#     setIDVar(name = "year", value = "2017")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_65_09,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_65_10 <- schema_twn_65 %>%
#     setIDVar(name = "year", value = "2018")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_65_10,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_66 <- setCluster(id = "year", left = 4, top = 25, height = 31) %>%
#     setFilter(rows = .find(".. Province", col = 20), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 20) %>%
#     setIDVar(name = "year",columns = 21, rows = 24) %>%
#     setIDVar(name = "commodities", columns = c(4, 8, 13, 16), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(4, 8, 13, 16)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(5, 9, 14, 17)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 10, 12, 18)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(7, 11, 15, 19))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_66_00 <- schema_twn_66 %>%
#     setIDVar(name = "year",columns = 20, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66_00,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_66_00,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_67 <- setCluster(id = "year", left = 4, top = 24, height = 36) %>%
#     setFilter(rows = .find(".. Province", col = 21), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 21) %>%
#     setIDVar(name = "year", columns = 22, rows = 23) %>%
#     setIDVar(name = "commodities", columns = 13, rows = 3) %>%
#     setObsVar(name = "planted", unit = "ha", columns = 4) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = 8) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = 13) %>%
#     setObsVar(name = "production", unit = "t", columns = 17)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cauliflower",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cauliflower",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cauliflower",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cauliflower",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cauliflower",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cauliflower",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_67_00 <- schema_twn_67 %>%
#     setCluster(id = "year", left = 4, top = 25, height = 31) %>%
#     setIDVar(name = "year", columns = 21, rows = 23)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_00,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_00,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cauliflowers",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_00,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_00,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_00,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_67_01 <- schema_twn_67 %>%
#     setCluster(id = "year", left = 4, top = 24, height = 32)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cauliflower",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cauliflower",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cauliflower",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            evel = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "chineseCabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cabbage",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cauliflower",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "cantaloupes",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "watermelons",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_67_01,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_68 <- setCluster(id = "commodities", left = c(4, 8, 15, 17, 20), top = 25, height = 36) %>%
#     setFilter(rows = .find(".. Province", col = 24), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 24) %>%
#     setIDVar(name = "year", value = "2005") %>%
#     setIDVar(name = "commodities", columns = c(4, 8, 15, 17, 20), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(4, 8, 12, 17, 20)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(5, 9, 13, 18, 21)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 10, 15, 14, 22)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(7, 11, 16, 19, 23))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_68,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_68_00 <- schema_twn_68 %>%
#     setCluster(id = "commodities", left = c(4, 8, 15, 17, 20), top = 25, height = 32) %>%
#     setIDVar(name = "year", value = "2009")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_68_00,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_68_01 <- schema_twn_68 %>%
#     setIDVar(name = "year", value = "2010")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_68_01,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_68_02 <- schema_twn_68 %>%
#     setIDVar(name = "year", value = "2011")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_68_02,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_68_03 <- schema_twn_68 %>%
#     setIDVar(name = "year", value = "2012")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_68_03,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_68_04 <- schema_twn_68 %>%
#     setIDVar(name = "year", value = "2013")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_68_04,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_68_05 <- schema_twn_68 %>%
#     setIDVar(name = "year", value = "2014")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_68_05,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_68_06 <- schema_twn_68 %>%
#     setIDVar(name = "year", value = "2015")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_68_06,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_68_07 <- schema_twn_68 %>%
#     setIDVar(name = "year", value = "2016")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_68_07,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_68_08 <- schema_twn_68 %>%
#     setIDVar(name = "year", value = "2017")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_68_08,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_68_09 <- schema_twn_68 %>%
#     setIDVar(name = "year", value = "2018")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_68_09,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_69 <- setCluster(id = "year", left = 4, top = 25, height = 36) %>%
#     setFilter(rows = .find(".. Province", col = 20), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 20) %>%
#     setIDVar(name = "year", columns = 21, rows = 24) %>%
#     setIDVar(name = "commodities", columns = c(4, 8), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(4, 8)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(5, 9)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 10)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(7, 11))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_69,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_69_00 <- schema_twn_69 %>%
#     setCluster(id = "year", left = 4, top = 26, height = 32) %>%
#     setIDVar(name = "year", columns = 20, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_69_00,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_69_01 <- schema_twn_69 %>%
#     setCluster(id = "year", left = 4, top = 26, height = 36) %>%
#     setIDVar(name = "year", columns = 21, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_69_01,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_69_01,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_69_01,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_69_01,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_69_01,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_69_02 <- schema_twn_69 %>%
#     setFilter(rows = .find(".. Province", col = 23), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 23) %>%
#     setIDVar(name = "year", columns = 24, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_69_02,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_69_02,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_69_02,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "vegetables10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_69_02,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_70 <- setCluster(id = "commodities", left = c(13, 16), top = 26, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 18), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 18) %>%
#     setIDVar(name = "year", value = "1999") %>%
#     setIDVar(name = "commodities", columns = c(13, 16), rows = 8) %>%
#     setObsVar(name = "production", unit = "t", columns = c(14, 17))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forestMushrooms",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70,
#            begin = 1999,
#            end = 1999,
#            archive = "1999_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_00 <- schema_twn_70 %>%
#     setCluster(id = "commodities", left = c(13, 16), top = 27, height = 32) %>%
#     setIDVar(name = "year", value = "2000")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_00,
#            begin = 2000,
#            end = 2000,
#            archive = "2000_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_01 <- schema_twn_70 %>%
#     setCluster(id = "commodities", left = c(13, 16), top = 28, height = 32) %>%
#     setIDVar(name = "year", value = "2001")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_01,
#            begin = 2001,
#            end = 2001,
#            archive = "2001_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_02 <- schema_twn_70_01 %>%
#     setIDVar(name = "year", value = "2002")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_02,
#            begin = 2002,
#            end = 2002,
#            archive = "2002_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_03 <- schema_twn_70_01 %>%
#     setIDVar(name = "year", value = "2003") %>%
#     setIDVar(name = "commodities", columns = c(13, 16), rows = 7)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_03,
#            begin = 2003,
#            end = 2003,
#            archive = "2003_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_04 <- schema_twn_70 %>%
#     setCluster(id = "commodities", left = c(12, 15), top = 29, height = 32) %>%
#     setIDVar(name = "year", value = "2004") %>%
#     setIDVar(name = "commodities", columns = c(12, 15), rows = 7)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_04,
#            begin = 2004,
#            end = 2004,
#            archive = "2004_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_05 <- setCluster(id = "commodities", left = c(14, 17), top = 25, height = 36) %>%
#     setFilter(rows = .find(".. Province", col = 20), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 20) %>%
#     setIDVar(name = "year", value = "2005") %>%
#     setIDVar(name = "commodities", columns = c(14, 17), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(16, 19))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_05,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_06 <- schema_twn_70_04 %>%
#     setCluster(id = "commodities", left = c(12, 15), top = 25, height = 32) %>%
#     setIDVar(name = "year", value = "2006")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_06,
#            begin = 2006,
#            end = 2006,
#            archive = "2006_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_07 <- schema_twn_70_06 %>%
#     setIDVar(name = "year", value = "2007")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_07,
#            begin = 2007,
#            end = 2007,
#            archive = "2007_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_08 <- schema_twn_70_06 %>%
#     setIDVar(name = "year", value = "2008")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_08,
#            begin = 2008,
#            end = 2008,
#            archive = "2008_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_09 <- schema_twn_70_05 %>%
#     setCluster(id = "commodities", left = c(14, 17), top = 26, height = 32) %>%
#     setIDVar(name = "year", value = "2009")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_09,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   Fschema_twn_70_10 <- schema_twn_70_05 %>%
#     setCluster(id = "commodities", left = c(14, 17), top = 25, height = 36) %>%
#     setIDVar(name = "year", value = "2010")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_10,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_11 <- schema_twn_70_05 %>%
#     setIDVar(name = "year", value = "2011")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_11,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_12 <- schema_twn_70_05 %>%
#     setIDVar(name = "year", value = "2012")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_12,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_13 <- schema_twn_70_05 %>%
#     setIDVar(name = "year", value = "2013")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_13,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_14 <- schema_twn_70_05 %>%
#     setIDVar(name = "year", value = "2014")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_14,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_15 <- setCluster(id = "commodities", left = c(14, 17, 20), top = 25, height = 32) %>%
#     setFilter(rows = .find(".. Province", col = 23), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 23) %>%
#     setIDVar(name = "year", value = "2015") %>%
#     setIDVar(name = "commodities", columns = c(14, 17, 20), rows = c(7, 7, 6)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(16, 19, 22))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_15,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_16 <- schema_twn_70_15 %>%
#     setIDVar(name = "year", value = "2016")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_16,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_17 <- schema_twn_70_15 %>%
#     setIDVar(name = "year", value = "2017")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_17,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_70_18 <- schema_twn_70_15 %>%
#     setIDVar(name = "year", value = "2018")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "shiitake",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_70_18,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_71 <- setCluster(id = "year", left = 4, top = 23, height = 36) %>%
#     setFilter(rows = .find(".. Province", col = 13), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 13) %>%
#     setIDVar(name = "year", columns = 14, rows = 22) %>%
#     setIDVar(name = "commodities", columns = c(4, 9), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(4, 9)) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = c(5, 10)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 11)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(7, 12))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_71_01 <- schema_twn_71 %>%
#     setFilter(rows = .find(".. Province", col = 12), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 12) %>%
#     setIDVar(name = "year", columns = 13, rows = 22) %>%
#     setIDVar(name = "commodities", columns = c(4, 9), rows = 6) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 13)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(7, 11))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_01,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_01,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_01,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_01,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_01,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_01,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_01,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_01,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_01,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_01,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_01,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_01,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_71_02 <- schema_twn_71_01 %>%
#     setCluster(id = "year", left = 4, top = 23, height = 32)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_02,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_02,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_02,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_02,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_02,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_02,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_02,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_02,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_71_03 <- schema_twn_71 %>%
#     setCluster(id = "year", left = 4, top = 24, height = 32) %>%
#     setIDVar(name = "year", columns = 13, rows = 22)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_03,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_03,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_03,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_03,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits07",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_03,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits08",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_03,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits09",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_03,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits10",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_03,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits11",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_03,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits12",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_03,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits13",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_03,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits14",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_03,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_71_04 <- schema_twn_71_02 %>%
#     setCluster(id = "year", left = 4, top = 24, height = 32) %>%
#     setIDVar(name = "year", columns = 12, rows = 22)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_04,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "fruits15",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_04,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_71_05 <- schema_twn_71 %>%
#     setIDVar(name = "commodities", columns = 9, rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = 9) %>%
#     setObsVar(name = "harvested", unit = "ha", columns = 10) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = 11) %>%
#     setObsVar(name = "production", unit = "t", columns = 12)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_05,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_05,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_05,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_05,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_05,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_05,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_05,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_05,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_05,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_05,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_71_06 <- schema_twn_71_05 %>%
#     setCluster(id = "year", left = 4, top = 24, height = 32) %>%
#     setIDVar(name = "year", columns = 13, rows = 22)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "bananas",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_71_06,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_72 <- setCluster(id = "year", left = 4, top = 25, height = 36) %>%
#     setFilter(rows = .find(".. Province", col = 20), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 20) %>%
#     setIDVar(name = "year", columns = 21, rows = 24) %>%
#     setIDVar(name = "commodities", value = "flowers total") %>%
#     setObsVar(name = "planted", unit = "ha", columns = 4)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_72,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_72,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_72,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_72,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_72,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_72,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_72_00 <- schema_twn_72 %>%
#     setFilter(rows = .find(".. Province", col = 23), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 23) %>%
#     setIDVar(name = "year", columns = 24, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_72_00,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_72_00,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_72_00,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_72_00,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_72_01 <- schema_twn_72 %>%
#     setIDVar(name = "year", columns = 20, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowersTotal",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_72_01,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_73 <- setCluster(id = "commodities", left = c(7, 11, 14, 17), top = 25, height = 36) %>%
#     setFilter(rows = .find(".. Province", col = 20), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 20) %>%
#     setIDVar(name = "year", value = "2005") %>%
#     setIDVar(name = "commodities", columns = c(7, 11, 14, 17), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(7, 10, 14, 17)) %>%
#     setObsVar(name = "yield", unit = "n/ha", factor = 12, columns = c(8, 11, 15, 18)) %>%
#     setObsVar(name = "production", unit = "n", factor = 12000, columns = c(9, 13, 16, 19))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_73,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_73_00 <- schema_twn_73 %>%
#     setCluster(id = "commodities", left = c(7, 11, 14, 17), top = 25, height = 32) %>%
#     setIDVar(name = "year", value = "2009")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_73_00,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_73_01 <- schema_twn_73 %>%
#     setIDVar(name = "year", value = "2010")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_73_01,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_73_02 <- schema_twn_73 %>%
#     setIDVar(name = "year", value = "2011")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_73_02,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_73_03 <- schema_twn_73 %>%
#     setIDVar(name = "year", value = "2012")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_73_03,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_73_04 <- schema_twn_73 %>%
#     setIDVar(name = "year", value = "2013")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_73_04,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_73_05 <- schema_twn_73 %>%
#     setIDVar(name = "year", value = "2014")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_73_05,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_73_06 <- setCluster(id = "commodities", left = c(7, 11, 14, 17, 20), top = 25, height = 36) %>%
#     setFilter(rows = .find(".. Province", col = 23), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 23) %>%
#     setIDVar(name = "year", value = "2015") %>%
#     setIDVar(name = "commodities", columns = c(7, 11, 14, 17, 20), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(7, 10, 14, 17, 20)) %>%
#     setObsVar(name = "yield", unit = "n/ha", factor = 12, columns = c(8, 11, 15, 18, 21)) %>%
#     setObsVar(name = "production", unit = "n", factor = 12000, columns = c(9, 13, 16, 19, 22))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_73_06,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_73_07 <- schema_twn_73_06 %>%
#     setIDVar(name = "year", value = "2016")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_73_07,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_73_08 <- schema_twn_73_06 %>%
#     setIDVar(name = "year", value = "2017")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_73_08,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_73_09 <- schema_twn_73_06 %>%
#     setIDVar(name = "year", value = "2018")
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_73_09,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_74 <- setCluster(id = "year", left = 4, top = 25, height = 36) %>%
#     setFilter(rows = .find(".. Province", col = 23), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 23) %>%
#     setIDVar(name = "year", columns = 24, rows = 24) %>%
#     setIDVar(name = "commodities", columns = c(4, 7, 10, 14, 17, 20), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(4, 7, 10, 14, 17, 20)) %>%
#     setObsVar(name = "production", unit = "n", factor = 12000, columns = c(6, 9, 12, 16, 19, 22))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_74_00 <- schema_twn_74 %>%
#     setCluster(id = "year", left = 4, top = 25, height = 32)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_00,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_00,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_00,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_00,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_74_01 <- schema_twn_74 %>%
#     setIDVar(name = "commodities", columns = c(4, 7), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(4, 7)) %>%
#     setObsVar(name = "production", unit = "n", factor = 12000, columns = c(6, 8))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_01,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_01,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_01,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_01,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_01,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_01,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_74_02 <- schema_twn_74 %>%
#     setIDVar(name = "commodities", columns = 9, rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = 9) %>%
#     setObsVar(name = "production", unit = "bowl", factor = 1000, columns = 11)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_02,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_02,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_02,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_02,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_02,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_02,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_74_03 <- schema_twn_74 %>%
#     setIDVar(name = "commodities", columns = c(13, 16), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(13, 16)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(14, 17)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(15, 18))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_03,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_03,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_03,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_03,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_03,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_03,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_74_04 <- schema_twn_74 %>%
#     setCluster(id = "year", left = 4, top = 25, height = 32) %>%
#     setIDVar(name = "year", columns = 23, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_04,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_74_05 <- schema_twn_74_01 %>%
#     setIDVar(name = "year", columns = 23, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_05,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_74_06 <- schema_twn_74_02 %>%
#     setIDVar(name = "year", columns = 23, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_06,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_74_07 <- schema_twn_74_03 %>%
#     setIDVar(name = "year", columns = 23, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_07,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_74_08 <- schema_twn_74_01 %>%
#     setFilter(rows = .find(".. Province", col = 26), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 26) %>%
#     setIDVar(name = "year", columns = 27, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_08,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_08,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_08,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_08,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_74_09 <- schema_twn_74_08 %>%
#     setIDVar(name = "commodities", columns = 12, rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = 12) %>%
#     setObsVar(name = "yield", unit = "bowl/ha", columns = 13) %>%
#     setObsVar(name = "production", unit = "bowl", factor = 1000, columns = 14)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_09,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_09,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_09,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers04",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_09,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_74_10 <- schema_twn_74_08 %>%
#     setCluster(id = "year", left = 4, top = 25, height = 32) %>%
#     setIDVar(name = "commodities", columns = c(9, 16, 19), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(9, 16, 19)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(10, 17, 20)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(11, 18, 21))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_10,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_10,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_10,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers05",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_74_10,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_75 <- setCluster(id = "year", left = 4, top = 25, height = 36) %>%
#     setFilter(rows = .find(".. Province", col = 23), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 23) %>%
#     setIDVar(name = "year", columns = 24, rows = 24) %>%
#     setIDVar(name = "commodities", columns = c(19, 21), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(19, 21))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_75,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_75,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_75,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_75,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_75,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_75,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_75_00 <- schema_twn_75 %>%
#     setCluster(id = "year", left = 4, top = 25, height = 32) %>%
#     setIDVar(name = "year", columns = 23, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_75_00,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_75_01 <- schema_twn_75 %>%
#     setFilter(rows = .find(".. Province", col = 26), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 26) %>%
#     setIDVar(name = "year", columns = 27, rows = 24) %>%
#     setIDVar(name = "commodities", columns = c(22, 24), rows = 6) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(22, 24))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_75_01,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_75_01,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_75_01,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "flowers06",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_75_01,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_76 <- setCluster(id = "year", left = 4, top = 25, height = 36) %>%
#     setFilter(rows = .find(".. Province", col = 14), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 14) %>%
#     setIDVar(name = "year", columns = 15, rows = 24) %>%
#     setIDVar(name = "commodities", columns = c(4, 7, 11), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(4, 7, 11)) %>%
#     setObsVar(name = "yield", unit = "kg/ha", columns = c(5, 9, 12)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(6, 10, 13))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_76,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_76,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_76,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_76,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_76,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_76,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_76_00 <- schema_twn_76 %>%
#     setCluster(id = "year", left = 4, top = 25, height = 32)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_76_00,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_76_00,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_76_00,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_76_00,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_76_01 <- schema_twn_76 %>%
#     setCluster(id = "year", left = 4, top = 25, height = 32) %>%
#     setIDVar(name = "year", columns = 14, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "forageCrops",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_76_01,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_twn_77 <- setCluster(id = "year", left = 4, top = 25, height = 36) %>%
#     setFilter(rows = .find(".. Province", col = 19), invert = TRUE) %>%
#     setIDVar(name = "al3", columns = 19) %>%
#     setIDVar(name = "year", columns = 20, rows = 24) %>%
#     setIDVar(name = "commodities", columns = c(4, 6, 8, 10, 13, 15, 17), rows = 7) %>%
#     setObsVar(name = "planted", unit = "ha", columns = c(4, 6, 8, 10, 13, 15, 17)) %>%
#     setObsVar(name = "production", unit = "t", columns = c(5, 7, 9, 12, 14, 16, 18))
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77,
#            begin = 2005,
#            end = 2005,
#            archive = "2005_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77,
#            begin = 2010,
#            end = 2010,
#            archive = "2010_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77,
#            begin = 2011,
#            end = 2011,
#            archive = "2011_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77,
#            begin = 2012,
#            end = 2012,
#            archive = "2012_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77,
#            begin = 2013,
#            end = 2013,
#            archive = "2013_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77,
#            begin = 2014,
#            end = 2014,
#            archive = "2014_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_77_00 <- schema_twn_77 %>%
#     setCluster(id = "year", left = 4, top = 25, height = 32)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77_00,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77_00,
#            begin = 2015,
#            end = 2015,
#            archive = "2015_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77_00,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77_00,
#            begin = 2016,
#            end = 2016,
#            archive = "2016_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77_00,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77_00,
#            begin = 2017,
#            end = 2017,
#            archive = "2017_Agriculture2.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77_00,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77_00,
#            begin = 2018,
#            end = 2018,
#            archive = "2018_Agriculture.ods",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_twn_77_01 <- schema_twn_77 %>%
#     setCluster(id = "year", left = 4, top = 26, height = 32) %>%
#     setIDVar(name = "year", columns = 19, rows = 24)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops01",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77_01,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   regTable(nation = "twn",
#            level = 3,
#            subset = "greenManureCrops02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_twn_77_01,
#            begin = 2009,
#            end = 2009,
#            archive = "2009_Agriculture.xls",
#            archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)

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

  ### tca ----
  # schema_twn_liv_01 <- setCluster(id = "commodities", left = c(2, c(3, 5, 7)), top = 14, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 20) %>%
  #   setIDVar(name = "commodities", columns = c(2, c(3, 5, 7)), rows = c(9, c(8, 8, 8))) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = c(2, 4, 6, 8))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "cattle",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_01,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_02 <- setCluster(id = "al1", left = 3, top = 10, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 21) %>%
  #   setIDVar(name = "commodities", columns = 13, rows = 2) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = 3)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_02,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_03 <- setCluster(id = "al1", left = 2, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 20) %>%
  #   setIDVar(name = "commodities", columns = c(2, 12, 13, 17), rows = 5) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = c(2, 12, 13, 17))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "livestockOther",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_03,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_04 <- setCluster(id = "commodities", left = c(2, c(3, 10), c(14, 15)), top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 16) %>%
  #   setIDVar(name = "commodities", columns = c(2, c(3, 10), c(14, 15)), rows = c(9, c(6, 6), c(9, 9))) %>%
  #   setObsVar(name = "headcount", unit = "n", factor = 1000, columns = c(2, 3, 10, 14, 15))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_04,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_04_00 <- schema_twn_liv_04 %>%
  #   setIDVar(name = "commodities", columns = c(2, c(3, 10), c(14, 15)), rows = c(8, c(6, 6), c(9, 9)))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_04_00,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1990_1999_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_05 <- setCluster(id = "al1", left = 3, top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 16) %>%
  #   setIDVar(name = "commodities", columns = 10, rows = 2) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = 3)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_05,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1990_1999_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_05_00 <- schema_twn_liv_05 %>%
  #   setIDVar(name = "year", columns = 17) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = 5)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_05_00,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "1990_1999_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # Commodities "total" referes only to cattles. Does not include goats and deers.
  # schema_twn_liv_06 <- setCluster(id = "commodities", left = c(c(2, 3), 4, 5, 9, 14), top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 16) %>%
  #   setIDVar(name = "commodities", columns = c(c(2, 3), 4, 5, 9, 14), rows = c(c(9, 9), 8, 9, 5, 6)) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = c(2:5, 9, 14))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "cattleOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_06,
  #          begin = 1999,
  #          end = 2008,
  #          archive = "1990_1999_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_07 <- setCluster(id = "commodities", left = c(4, c(5, 12), c(16, 17)), top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 19) %>%
  #   setIDVar(name = "commodities", columns = c(4, c(5, 12), c(16, 17)), rows = c(8, c(6, 6), c(9, 9))) %>%
  #   setObsVar(name = "headcount", unit = "n", factor = 1000, columns = c(4, 5, 12, 16, 17))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_07,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "1990_1999_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_08 <- setCluster(id = "commodities", left = c(1, 6), top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 9) %>%
  #   setIDVar(name = "commodities", columns = c(1, 6), rows = c(5, 6)) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = c(1, 6))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_08,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "1990_1999_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # the years here and missing from the table, however, the data is organised in the same way as: twn_1_livestockOthers_TCA.csv
  # schema_twn_liv_09 <- setCluster(id = "commodities", left = c(4, 5, 6, 7), top = 13, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 2) %>%
  #   setIDVar(name = "commodities", columns = c(4, 5, 6, 7), rows = c(9, 9, 8, 9)) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = c(4, 5, 6, 7))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "cattle",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_09,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "1990_1999_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_10 <- setCluster(id = "commodities", left = c(2, 3, 5, 7), top = 26, height = 34) %>%
  #   setFilter(rows = .find(".. Province", col = 20), invert = TRUE) %>%
  #   setIDVar(name = "al3", columns = 20) %>%
  #   setIDVar(name = "year", value = "1999") %>%
  #   setIDVar(name = "commodities", columns = c(2, 3, 5, 7), rows = c(9, 8, 8, 8)) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = c(2, 4, 6, 8))
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "cattle",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_10,
  #          begin = 1999,
  #          end = 1999,
  #          archive = "1999_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_10_00 <- schema_twn_liv_10 %>%
  #   setCluster(id = "commodities", left = c(2, 3, 5, 7), top = 27, height = 34) %>%
  #   setIDVar(name = "year", value = "2000")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "cattle",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_10_00,
  #          begin = 2000,
  #          end = 2000,
  #          archive = "2000_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_10_01 <- schema_twn_liv_10 %>%
  #   setCluster(id = "commodities", left = c(2, 3, 5, 7), top = 28, height = 34) %>%
  #   setIDVar(name = "year", value = "2001")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "cattle",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_10_01,
  #          begin = 2001,
  #          end = 2001,
  #          archive = "2001_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_10_02 <- schema_twn_liv_10 %>%
  #   setCluster(id = "commodities", left = c(2, 3, 5, 7), top = 29, height = 34) %>%
  #   setIDVar(name = "year", value = "2002")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "cattle",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_10_02,
  #          begin = 2002,
  #          end = 2002,
  #          archive = "2002_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_10_03 <- schema_twn_liv_10 %>%
  #   setCluster(id = "commodities", left = c(2, 3, 5, 7), top = 30, height = 34) %>%
  #   setIDVar(name = "year", value = "2003")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "cattle",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_10_03,
  #          begin = 2003,
  #          end = 2003,
  #          archive = "2003_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_11 <- setCluster(id = "year", left = 3, top = 25, height = 32) %>%
  #   setFilter(rows = .find(".. Province", col = 16), invert = TRUE) %>%
  #   setIDVar(name = "al3", columns = 16) %>%
  #   setIDVar(name = "year", columns = 16, rows = 24) %>%
  #   setIDVar(name = "commodities", value = "hogs") %>%
  #   setObsVar(name = "headcount", unit = "n", columns = 3)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_11,
  #          begin = 1999,
  #          end = 1999,
  #          archive = "1999_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_11,
  #          begin = 2007,
  #          end = 2007,
  #          archive = "2007_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_11,
  #          begin = 2008,
  #          end = 2008,
  #          archive = "2008_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_11,
  #          begin = 2009,
  #          end = 2009,
  #          archive = "2009_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_11_00 <- schema_twn_liv_11 %>%
  #   setCluster(id = "year", left = 3, top = 26, height = 32) %>%
  #   setIDVar(name = "year", value = "2000")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_11_00,
  #          begin = 2000,
  #          end = 2000,
  #          archive = "2000_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_11_01 <- schema_twn_liv_11 %>%
  #   setCluster(id = "year", left = 3, top = 27, height = 32) %>%
  #   setFilter(rows = .find(".. Province", col = 17), invert = TRUE) %>%
  #   setIDVar(name = "al3", columns = 17) %>%
  #   setIDVar(name = "year", columns = 17, rows = 26)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_11_01,
  #          begin = 2001,
  #          end = 2001,
  #          archive = "2001_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_11_02 <- schema_twn_liv_11_01 %>%
  #   setCluster(id = "year", left = 3, top = 28, height = 32) %>%
  #   setIDVar(name = "year", columns = 17, rows = 27)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_11_02,
  #          begin = 2002,
  #          end = 2002,
  #          archive = "2002_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_11_03 <- schema_twn_liv_11_01 %>%
  #   setCluster(id = "year", left = 3, top = 29, height = 32) %>%
  #   setIDVar(name = "year", columns = 17, rows = 28)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_11_03,
  #          begin = 2003,
  #          end = 2003,
  #          archive = "2003_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_11_04 <- schema_twn_liv_11_03 %>%
  #   setIDVar(name = "year", value = "2004")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_11_04,
  #          begin = 2004,
  #          end = 2004,
  #          archive = "2004_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_11_05 <- schema_twn_liv_11 %>%
  #   setFilter(rows = .find(".. Province", col = 17), invert = TRUE) %>%
  #   setIDVar(name = "al3", columns = 17) %>%
  #   setIDVar(name = "year", columns = 17, rows = 24)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_11_05,
  #          begin = 2005,
  #          end = 2005,
  #          archive = "2005_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_11_05,
  #          begin = 2006,
  #          end = 2006,
  #          archive = "2006_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_12 <- setCluster(id = "year", left = 5, top = 25, height = 36) %>%
  #   setFilter(rows = .find(".. Province", col = 18), invert = TRUE) %>%
  #   setIDVar(name = "al3", columns = 18) %>%
  #   setIDVar(name = "year", columns = 19, rows = 24) %>%
  #   setIDVar(name = "commodities", value = "hogs") %>%
  #   setObsVar(name = "headcount", unit = "n", columns = 5)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_12,
  #          begin = 2010,
  #          end = 2010,
  #          archive = "2010_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_12,
  #          begin = 2011,
  #          end = 2011,
  #          archive = "2011_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_12,
  #          begin = 2012,
  #          end = 2012,
  #          archive = "2012_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_12_00 <- schema_twn_liv_12 %>%
  #   setFilter(rows = .find(".. Province", col = 16), invert = TRUE) %>%
  #   setIDVar(name = "al3", columns = 16) %>%
  #   setIDVar(name = "year", columns = 17, rows = 24) %>%
  #   setIDVar(name = "commodities", columns = 10, rows = 2)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_12_00,
  #          begin = 2013,
  #          end = 2013,
  #          archive = "2013_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_12_00,
  #          begin = 2014,
  #          end = 2014,
  #          archive = "2014_Livestock.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_12_01 <- schema_twn_liv_12_00 %>%
  #   setCluster(id = "year", left = 5, top = 25, height = 33)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_12_01,
  #          begin = 2015,
  #          end = 2015,
  #          archive = "2015_Livestock.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_12_01,
  #          begin = 2016,
  #          end = 2016,
  #          archive = "2016_Livestock.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_12_01,
  #          begin = 2017,
  #          end = 2017,
  #          archive = "2017_Livestock.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "hogs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_12_01,
  #          begin = 2018,
  #          end = 2018,
  #          archive = "2018_Livestock.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_13 <- setCluster(id = "year", left = 2, top = 25, height = 32) %>%
  #   setFilter(rows = .find(".. Province", col = 20), invert = TRUE) %>%
  #   setIDVar(name = "al3", columns = 20) %>%
  #   setIDVar(name = "year", columns = 20, rows = 24) %>%
  #   setIDVar(name = "commodities", columns = c(2, 12, 13, 17), rows = 5) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = c(2, 12, 13, 17))
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_13,
  #          begin = 1999,
  #          end = 1999,
  #          archive = "1999_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_13_00 <- schema_twn_liv_13 %>%
  #   setCluster(id = "year", left = 2, top = 26, height = 32) %>%
  #   setIDVar(name = "year", columns = 20, rows = 25)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_13_00,
  #          begin = 2000,
  #          end = 2000,
  #          archive = "2000_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_14 <- setCluster(id = "year", left = 2, top = 27, height = 32) %>%
  #   setFilter(rows = .find(".. Province", col = 26), invert = TRUE) %>%
  #   setIDVar(name = "al3", columns = 26) %>%
  #   setIDVar(name = "year", columns = 26, rows = 26) %>%
  #   setIDVar(name = "commodities", columns = c(2, 13, 14, 22), rows = 5) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = c(2, 13, 14, 22))
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_14,
  #          begin = 2001,
  #          end = 2001,
  #          archive = "2001_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_14_00 <- schema_twn_liv_14 %>%
  #   setCluster(id = "year", left = 2, top = 28, height = 32) %>%
  #   setIDVar(name = "year", columns = 26, rows = 27)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_14_00,
  #          begin = 2002,
  #          end = 2002,
  #          archive = "2002_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_14_01 <- schema_twn_liv_14 %>%
  #   setCluster(id = "year", left = 2, top = 29, height = 32) %>%
  #   setIDVar(name = "year", columns = 26, rows = 28)
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_14_01,
  #          begin = 2003,
  #          end = 2003,
  #          archive = "2003_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_15 <- setCluster(id = "commodities", left = c(c(2, 3), 4, 5, 9, 14), top = 30, height = 31) %>%
  #   setFilter(rows = .find(".. Province", col = 16), invert = TRUE) %>%
  #   setIDVar(name = "al3", columns = 16) %>%
  #   setIDVar(name = "year", value = "2004") %>%
  #   setIDVar(name = "commodities", columns = c(c(2, 3), 4, 5, 9, 14), rows = c(c(9, 9), 8, 9, 5, 6)) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = c(2:5, 9, 14))
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_15,
  #          begin = 2004,
  #          end = 2004,
  #          archive = "2004_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_15_00 <- schema_twn_liv_15 %>%
  #   setCluster(id = "commodities", left = c(c(2, 3, 4, 5), 9, 14), top = 25, height = 31) %>%
  #   setIDVar(name = "year", value = "2005")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_15_00,
  #          begin = 2005,
  #          end = 2005,
  #          archive = "2005_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_15_01 <- schema_twn_liv_15_00 %>%
  #   setIDVar(name = "year", value = "2006")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_15_01,
  #          begin = 2006,
  #          end = 2006,
  #          archive = "2006_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_15_02 <- schema_twn_liv_15_00 %>%
  #   setIDVar(name = "year", value = "2007")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_15_02,
  #          begin = 2007,
  #          end = 2007,
  #          archive = "2007_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)#
  #
  # schema_twn_liv_15_03 <- schema_twn_liv_15_00 %>%
  #   setIDVar(name = "year", value = "2008")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_15_03,
  #          begin = 2008,
  #          end = 2008,
  #          archive = "2008_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_15_04 <- schema_twn_liv_15_00 %>%
  #   setIDVar(name = "year", value = "2009")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_15_04,
  #          begin = 2009,
  #          end = 2009,
  #          archive = "2009_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_16 <- setCluster(id = "commodities", left = c(c(4, 5), 6, 7, 11, 16), top = 25, height = 23) %>%
  #   setFilter(rows = .find(".. Province", col = 18), invert = TRUE) %>%
  #   setIDVar(name = "al3", columns = 18) %>%
  #   setIDVar(name = "year", value = "2010") %>%
  #   setIDVar(name = "commodities", columns = c(c(4, 5), 6, 7, 11, 16), rows = c(c(9, 9), 8, 9, 5, 6)) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = c(4, 5, 6, 7, 11, 16))
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_16,
  #          begin = 2010,
  #          end = 2010,
  #          archive = "2010_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_16_00 <- schema_twn_liv_16 %>%
  #   setIDVar(name = "year", value = "2011")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_16_00,
  #          begin = 2011,
  #          end = 2011,
  #          archive = "2011_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_16_01 <- schema_twn_liv_16 %>%
  #   setIDVar(name = "year", value = "2012")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_16_01,
  #          begin = 2012,
  #          end = 2012,
  #          archive = "2012_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_16_02 <- schema_twn_liv_16 %>%
  #   setIDVar(name = "year", value = "2013")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_16_02,
  #          begin = 2013,
  #          end = 2013,
  #          archive = "2013_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_16_03 <- schema_twn_liv_16 %>%
  #   setIDVar(name = "year", value = "2014")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "livestockOthers",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_16_03,
  #          begin = 2014,
  #          end = 2014,
  #          archive = "2014_Livestock.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_17 <- setCluster(id = "commodities", left = c(2, c(3, 10), c(14, 15)), top = 25, height = 32) %>%
  #   setFilter(rows = .find(".. Province", col = 16), invert = TRUE) %>%
  #   setIDVar(name = "al3", columns = 16) %>%
  #   setIDVar(name = "year", value = "1999") %>%
  #   setIDVar(name = "commodities", columns = c(2, c(3, 10), c(14, 15)), rows = c(9, c(6, 6), c(9, 9))) %>%
  #   setObsVar(name = "headcount", unit = "n", factor = 1000, columns = c(2, 3, 10, 14, 15))
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_17,
  #          begin = 1999,
  #          end = 1999,
  #          archive = "1999_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_17_00 <- schema_twn_liv_17 %>%
  #   setCluster(id = "commodities", left = c(2, c(3, 10), c(14, 15)), top = 26, height = 32) %>%
  #   setIDVar(name = "year", value = "2000")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_17_00,
  #          begin = 2000,
  #          end = 2000,
  #          archive = "2000_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_17_01 <- schema_twn_liv_17 %>%
  #   setCluster(id = "commodities", left = c(2, c(3, 10), c(14, 15)), top = 27, height = 32) %>%
  #   setIDVar(name = "year", value = "2001")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_17_01,
  #          begin = 2001,
  #          end = 2001,
  #          archive = "2001_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_17_02 <- schema_twn_liv_17 %>%
  #   setCluster(id = "commodities", left = c(2, c(3, 10), c(14, 15)), top = 28, height = 32) %>%
  #   setIDVar(name = "year", value = "2002")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_17_02,
  #          begin = 2002,
  #          end = 2002,
  #          archive = "2002_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_17_03 <- schema_twn_liv_17 %>%
  #   setCluster(id = "commodities", left = c(2, c(3, 10), c(14, 15)), top = 29, height = 32) %>%
  #   setIDVar(name = "year", value = "2003")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_17_03,
  #          begin = 2003,
  #          end = 2003,
  #          archive = "2003_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_17_04 <- schema_twn_liv_17 %>%
  #   setCluster(id = "commodities", left = c(2, c(3, 10), c(14, 15)), top = 30, height = 32) %>%
  #   setIDVar(name = "year", value = "2004")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_17_04,
  #          begin = 2004,
  #          end = 2004,
  #          archive = "2004_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_17_05 <- schema_twn_liv_17 %>%
  #   setIDVar(name = "commodities", columns = c(2, c(3, 10), c(14, 15)), rows = c(8, c(6, 6), c(9, 9))) %>%
  #   setIDVar(name = "year", value = "2005")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_17_05,
  #          begin = 2005,
  #          end = 2005,
  #          archive = "2005_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_17_06 <- schema_twn_liv_17_05 %>%
  #   setIDVar(name = "year", value = "2006")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_17_06,
  #          begin = 2006,
  #          end = 2006,
  #          archive = "2006_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_17_07 <- schema_twn_liv_17_05 %>%
  #   setIDVar(name = "year", value = "2007")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_17_07,
  #          begin = 2007,
  #          end = 2007,
  #          archive = "2007_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_17_08 <- schema_twn_liv_17_05 %>%
  #   setIDVar(name = "year", value = "2008")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_17_08,
  #          begin = 2008,
  #          end = 2008,
  #          archive = "2008_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_17_09 <- schema_twn_liv_17_05 %>%
  #   setIDVar(name = "year", value = "2009")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_17_09,
  #          begin = 2009,
  #          end = 2009,
  #          archive = "2009_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_18 <- setCluster(id = "commodities", left = c(c(5, 12), c(16, 17)), top = 26, height = 36) %>%
  #   setFilter(rows = .find(".. Province", col = 18), invert = TRUE) %>%
  #   setIDVar(name = "al3", columns = 18) %>%
  #   setIDVar(name = "year", value = "2010") %>%
  #   setIDVar(name = "commodities", columns = c(c(5, 12), c(16, 17)), rows = c(c(6, 6), c(9, 9))) %>%
  #   setObsVar(name = "headcount", unit = "n", factor = 1000, columns = c(4, 5, 12, 16, 17))
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_18,
  #          begin = 2010,
  #          end = 2010,
  #          archive = "2010_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_18_00 <- schema_twn_liv_18 %>%
  #   setCluster(id = "commodities", left = c(c(5, 12), c(16, 17)), top = 25, height = 36) %>%
  #   setIDVar(name = "year", value = "2011")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_18_00,
  #          begin = 2011,
  #          end = 2011,
  #          archive = "2011_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_18_01 <- schema_twn_liv_18_00 %>%
  #   setIDVar(name = "year", value = "2012")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_18_01,
  #          begin = 2012,
  #          end = 2012,
  #          archive = "2012_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_18_02 <- schema_twn_liv_18_00 %>%
  #   setIDVar(name = "year", value = "2013")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_18_02,
  #          begin = 2013,
  #          end = 2013,
  #          archive = "2013_Livestock.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_18_03 <- schema_twn_liv_18_00 %>%
  #   setIDVar(name = "year", value = "2014")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_18_03,
  #          begin = 2014,
  #          end = 2014,
  #          archive = "2014_Livestock.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_18_04 <- schema_twn_liv_18_00 %>%
  #   setCluster(id = "commodities", left = c(c(5, 12), c(16, 17)), top = 25, height = 35) %>%
  #   setIDVar(name = "year", value = "2015")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_18_04,
  #          begin = 2015,
  #          end = 2015,
  #          archive = "2015_Livestock.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_18_05 <- schema_twn_liv_18_00 %>%
  #   setIDVar(name = "year", value = "2016")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_18_05,
  #          begin = 2016,
  #          end = 2016,
  #          archive = "2016_Livestock.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_18_06 <- schema_twn_liv_18_00 %>%
  #   setIDVar(name = "year", value = "2017")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_18_06,
  #          begin = 2017,
  #          end = 2017,
  #          archive = "2017_Livestock.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_liv_18_07 <- schema_twn_liv_18_00 %>%
  #   setIDVar(name = "year", value = "2018")
  #
  # regTable(nation = "twn",
  #          level = 3,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_liv_18_07,
  #          begin = 2018,
  #          end = 2018,
  #          archive = "2018_Livestock.ods",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
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

  ### tca ----
  # schema_twn_for_01 <- setCluster(id = "commodities", left = c(4, 10), top = 11, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 3) %>%
  #   setIDVar(name = "commodities", columns = c(4, 10), rows = c(5, 6)) %>%
  #   setObsVar(name = "area", unit = "ha", columns = c(4, 10))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "forestryFelling",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_for_01,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Forest.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # units are in m2, I need a factor of 0.0001
  # schema_twn_for_02 <- setCluster(id = "al1", left = 4, top = 12, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 21) %>%
  #   setIDVar(name = "commodities", columns = 13, rows = 2) %>%
  #   setObsVar(name = "area", unit = "ha", factor = 0.0001, columns = 4)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "forestryNursery",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_for_02,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Forest.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_for_03 <- setCluster(id = "commodities", left = c(4, c(12, 14, 17)), top = 11, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 23) %>%
  #   setIDVar(name = "commodities", columns = c(4, c(12, 14, 17)), rows = 6) %>%
  #   setObsVar(name = "area", unit = "ha", columns = c(4, 10, 14, 17))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "forestryForestation01",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_for_03,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Forest.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_for_04 <- setCluster(id = "al1", left = 4, top = 11, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 23) %>%
  #   setIDVar(name = "commodities", columns = c(4, 7, 10, 14, 17), rows = 6) %>%
  #   setObsVar(name = "area", unit = "ha", columns = c(4, 7, 10, 14, 17))
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "forestryForestation02",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_for_04,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Forest.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_twn_for_05 <- setCluster(id = "al1", left = 4, top = 12, height = 12) %>%
  #   setIDVar(name = "al1", value = "Taiwan") %>%
  #   setIDVar(name = "year", columns = 2) %>%
  #   setIDVar(name = "commodities", columns = 1, rows = 3) %>%
  #   setObsVar(name = "area", unit = "ha", columns = 4)
  #
  # regTable(nation = "twn",
  #          level = 1,
  #          subset = "forestryDamage",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_twn_for_05,
  #          begin = 1990,
  #          end = 1999,
  #          archive = "1990_1999_Forest.xls",
  #          archiveLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://agrstat.coa.gov.tw/sdweb/public/book/Book.aspx",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)

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
