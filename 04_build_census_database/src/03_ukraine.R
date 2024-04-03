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

thisNation <- "Ukraine"
# source(paste0(mdl0301, "src/96_preprocess_ukrstat.R"))


# 1. dataseries ----
#
ds <- c("ukrstat")
gs <- c(_INSERT)

regDataseries(name = ds[],
              description = _INSERT,
              homepage = _INSERT,
              version = _INSERT,
              licence_link = _INSERT)

# regDataseries(name = ds[1],
#               description = "State statistic service of Urkaine",
#               homepage = "https://ukrstat.gov.ua/",
#               licence_link = "https://ukrstat.gov.ua/",
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

  ### ukrstat ----
  # crops2021 <- list.files(path = paste0(censusDBDir, "adb_tables/stage1/ukrstat/"),
  #                         pattern = "crops_2021*.csv")
  #
  # schema_ukr_l2_01 <- setCluster(id = "al1", left = 3, top = 4, height = 25) %>%
  #   setFilter(rows = .find("Ukraine", col = 12, invert = TRUE)) %>%
  #   setIDVar(name = "al1", value = "Ukraine") %>%
  #   setIDVar(name = "al2", columns = 12) %>%
  #   setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=December).*(?=1)") %>%
  #   setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=of).*(?=as|of)") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 1000, columns = 3) %>%
  #   setObsVar(name = "production", unit = "t", factor = 100, columns = 4) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = 5)
  #
  # for(i in seq_along(crops2021)){
  #
  #   thisFile <- crops2021[i]
  #   munst <- str_split(thisFile, "_")[[1]][2]
  #
  #   regTable(nation = "ukr",
  #            level = 2,
  #            subset = munst,
  #            dSeries = ds[1],
  #            gSeries = gs[1],
  #            schema = schema_ukr_l2_01,
  #            begin = 2021,
  #            end = 2021,
  #            archive = "ovuzpsg_1221.xls",
  #            archiveLink = "https://ukrstat.gov.ua/",
  #            updateFrequency = "annually",
  #            nextUpdate = "unknown",
  #            metadataLink = "https://ukrstat.gov.ua/",
  #            metadataPath = "unknown",
  #            update = updateTables,
  #            overwrite = overwriteTables)
  # }
  #
  # crops2020 <- list.files(path = paste0(censusDBDir, "adb_tables/stage1/ukrstat/"),
  #                         pattern = "crops_2020*.csv")
  #
  # for(i in seq_along(crops2020)){
  #
  #   thisFile <- crops2020[i]
  #   munst <- str_split(thisFile, "_")[[1]][2]
  #
  #   regTable(nation = "ukr",
  #            level = 2,
  #            subset = munst,
  #            dSeries = ds[1],
  #            gSeries = gs[1],
  #            schema = schema_ukr_l2_01,
  #            begin = 2020,
  #            end = 2020,
  #            archive = "ovuzpsg_1220.xls",
  #            archiveLink = "https://ukrstat.gov.ua/",
  #            updateFrequency = "annually",
  #            nextUpdate = "unknown",
  #            metadataLink = "https://ukrstat.gov.ua/",
  #            metadataPath = "unknown",
  #            update = updateTables,
  #            overwrite = overwriteTables)
  # }
  #
  # crops2019 <- list.files(path = paste0(censusDBDir, "adb_tables/stage1/ukrstat/"),
  #                         pattern = "crops_2019*.csv")
  #
  # schema_ukr_l2_02 <- schema_ukr_l2_01 %>%
  #   setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=October).*(?=1)")
  #
  # for(i in seq_along(crops2019)){
  #
  #   thisFile <- crops2019[i]
  #   munst <- str_split(thisFile, "_")[[1]][2]
  #
  #   regTable(nation = "ukr",
  #            level = 2,
  #            subset = munst,
  #            dSeries = ds[1],
  #            gSeries = gs[1],
  #            schema = schema_ukr_l2_02,
  #            begin = 2019,
  #            end = 2019,
  #            archive = "ovuzpsg_10_2019.xls",
  #            archiveLink = "https://ukrstat.gov.ua/",
  #            updateFrequency = "annually",
  #            nextUpdate = "unknown",
  #            metadataLink = "https://ukrstat.gov.ua/",
  #            metadataPath = "unknown",
  #            update = updateTables,
  #            overwrite = overwriteTables)
  # }
  #
  # crops2018 <- list.files(path = paste0(censusDBDir, "adb_tables/stage1/ukrstat/"),
  #                         pattern = "crops_2018*.csv")
  #
  # schema_ukr_l2_03 <- schema_ukr_l2_01 %>%
  #   setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=November).*(?=1)")
  #
  # for(i in seq_along(crops2018)){
  #
  #   thisFile <- crops2018[i]
  #   munst <- str_split(thisFile, "_")[[1]][2]
  #
  #   regTable(nation = "ukr",
  #            level = 2,
  #            subset = munst,
  #            dSeries = ds[1],
  #            gSeries = gs[1],
  #            schema = schema_ukr_l2_03,
  #            begin = 2018,
  #            end = 2018,
  #            archive = "ovuzpsg_0111.xls",
  #            archiveLink = "https://ukrstat.gov.ua/",
  #            updateFrequency = "annually",
  #            nextUpdate = "unknown",
  #            metadataLink = "https://ukrstat.gov.ua/",
  #            metadataPath = "unknown",
  #            update = updateTables,
  #            overwrite = overwriteTables)
  # }
  #
  # crops2017 <- list.files(path = paste0(censusDBDir, "adb_tables/stage1/ukrstat/"),
  #                         pattern = "crops_2017*.csv")
  #
  # schema_ukr_l2_04 <- setCluster(id = "al1", left = 3, top = 4, height = 25) %>%
  #   setFilter(rows = .find("Україна", col = 1, invert = TRUE)) %>%
  #   setIDVar(name = "al1", value = "Ukraine") %>%
  #   setIDVar(name = "al2", columns = 2) %>%
  #   setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=листопада).*(?=року)") %>%
  #   setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=Виробництво).*(?=станом )") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 1000, columns = 3) %>%
  #   setObsVar(name = "production", unit = "t", factor = 100, columns = 4) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = 5)
  #
  # for(i in seq_along(crops2017)){
  #
  #   thisFile <- crops2017[i]
  #   munst <- str_split(thisFile, "_")[[1]][2]
  #
  #   regTable(nation = "ukr",
  #            level = 2,
  #            subset = munst,
  #            dSeries = ds[1],
  #            gSeries = gs[1],
  #            schema = schema_ukr_l2_04,
  #            begin = 2017,
  #            end = 2017,
  #            archive = "bl_zv_08_2017_x.xls",
  #            archiveLink = "https://ukrstat.gov.ua/",
  #            updateFrequency = "annually",
  #            nextUpdate = "unknown",
  #            metadataLink = "https://ukrstat.gov.ua/",
  #            metadataPath = "unknown",
  #            update = updateTables,
  #            overwrite = overwriteTables)
  # }
  #
  # crops2016 <- list.files(path = paste0(censusDBDir, "adb_tables/stage1/ukrstat/"),
  #                         pattern = "crops_2016*.csv")
  #
  # schema_ukr_l2_05 <- schema_ukr_l2_04 %>%
  #   setCluster(id = "al1", left = 3, top = 6, height = 25) %>%
  #   setIDVar(name = "year", value = "2016") %>%
  #   setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=Виробництво).*")
  #
  # for(i in seq_along(crops2016)){
  #
  #   thisFile <- crops2016[i]
  #   munst <- str_split(thisFile, "_")[[1]][2]
  #
  #   regTable(nation = "ukr",
  #            level = 2,
  #            subset = munst,
  #            dSeries = ds[1],
  #            gSeries = gs[1],
  #            schema = schema_ukr_l2_05,
  #            begin = 2016,
  #            end = 2016,
  #            archive = "bl_zvsgk1116xl.zip.xls",
  #            archiveLink = "https://ukrstat.gov.ua/",
  #            updateFrequency = "annually",
  #            nextUpdate = "unknown",
  #            metadataLink = "https://ukrstat.gov.ua/",
  #            metadataPath = "unknown",
  #            update = updateTables,
  #            overwrite = overwriteTables)
  # }
  #
  # crops2016 <- list.files(path = paste0(censusDBDir, "adb_tables/stage1/ukrstat/"),
  #                         pattern = "crops_2016_2*.csv")
  #
  # schema_ukr_l2_24 <- schema_ukr_l2_23 %>%
  #   setIDVar(name = "year", value = "2013")
  #
  # for(i in seq_along(crops2016_02)){
  #
  #   thisFile <- crops2016_02[i]
  #   munst <- str_split(thisFile, "_")[[1]][2]
  #
  #   regTable(nation = "ukr",
  #            level = 2,
  #            subset = munst,
  #            dSeries = ds[1],
  #            gSeries = gs[1],
  #            schema = schema_ukr_l2_24,
  #            begin = 2016,
  #            end = 2016,
  #            archive = "bl_zvsgk1116xl.zip.xls",
  #            archiveLink = "https://ukrstat.gov.ua/",
  #            updateFrequency = "annually",
  #            nextUpdate = "unknown",
  #            metadataLink = "https://ukrstat.gov.ua/",
  #            metadataPath = "unknown",
  #            update = updateTables,
  #            overwrite = overwriteTables)
  # }
  #
  # crops2015 <- list.files(path = paste0(censusDBDir, "adb_tables/stage1/ukrstat/"),
  #                         pattern = "crops_2015*.csv")
  #
  # schema_ukr_l2_06 <- schema_ukr_l2_05 %>%
  #   setIDVar(name = "year", value = "2015")
  #
  # for(i in seq_along(crops2015)){
  #
  #   thisFile <- crops2015[i]
  #   munst <- str_split(thisFile, "_")[[1]][2]
  #
  #   regTable(nation = "ukr",
  #            level = 2,
  #            subset = munst,
  #            dSeries = ds[1],
  #            gSeries = gs[1],
  #            schema = schema_ukr_l2_06,
  #            begin = 2015,
  #            end = 2015,
  #            archive = "bl_zvsk01_11_15xl.xls",
  #            archiveLink = "https://ukrstat.gov.ua/",
  #            updateFrequency = "annually",
  #            nextUpdate = "unknown",
  #            metadataLink = "https://ukrstat.gov.ua/",
  #            metadataPath = "unknown",
  #            update = updateTables,
  #            overwrite = overwriteTables)
  # }
  #
  # crops2014 <- list.files(path = paste0(censusDBDir, "adb_tables/stage1/ukrstat/"),
  #                         pattern = "crops_2014*.csv")
  #
  # schema_ukr_l2_07 <- schema_ukr_l2_05 %>%
  #   setIDVar(name = "year", value = "2014")
  #
  # for(i in seq_along(crops2014)){
  #
  #   thisFile <- crops2014[i]
  #   munst <- str_split(thisFile, "_")[[1]][2]
  #
  #   regTable(nation = "ukr",
  #            level = 2,
  #            subset = munst,
  #            dSeries = ds[1],
  #            gSeries = gs[1],
  #            schema = schema_ukr_l2_07,
  #            begin = 2014,
  #            end = 2014,
  #            archive = "bl_zvsk_xl.xls",
  #            archiveLink = "https://ukrstat.gov.ua/",
  #            updateFrequency = "annually",
  #            nextUpdate = "unknown",
  #            metadataLink = "https://ukrstat.gov.ua/",
  #            metadataPath = "unknown",
  #            update = updateTables,
  #            overwrite = overwriteTables)
  # }
  #
  # crops2013 <- list.files(path = paste0(censusDBDir, "adb_tables/stage1/ukrstat/"),
  #                         pattern = "crops_2013*.csv")
  #
  # schema_ukr_l2_08 <- schema_ukr_l2_05 %>%
  #   setIDVar(name = "year", value = "2013")
  #
  # for(i in seq_along(crops2013)){
  #
  #   thisFile <- crops2013[i]
  #   munst <- str_split(thisFile, "_")[[1]][2]
  #
  #   regTable(nation = "ukr",
  #            level = 2,
  #            subset = munst,
  #            dSeries = ds[1],
  #            gSeries = gs[1],
  #            schema = schema_ukr_l2_08,
  #            begin = 2013,
  #            end = 2013,
  #            archive = "bl_zb_11_2013.xls",
  #            archiveLink = "https://ukrstat.gov.ua/",
  #            updateFrequency = "annually",
  #            nextUpdate = "unknown",
  #            metadataLink = "https://ukrstat.gov.ua/",
  #            metadataPath = "unknown",
  #            update = updateTables,
  #            overwrite = overwriteTables)
  # }
  #
  # schema_ukr_l2_09 <- setCluster(id = "al1", left = 3, top = 4, height = 3) %>%
  #   setFilter(rows = .find("Україна", col = 1, invert = TRUE)) %>%
  #   setIDVar(name = "al1", value = "Ukraine") %>%
  #   setIDVar(name = "al2", columns = 2) %>%
  #   setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=December).*(?=1)") %>%
  #   setIDVar(name = "commodities", value = "rice") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 1000, columns = 3) %>%
  #   setObsVar(name = "production", unit = "t", factor = 100, columns = 4) %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = 5)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "rice",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_09,
  #          begin = 2021,
  #          end = 2021,
  #          archive = "ovuzpsg_1221.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "rice",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_09,
  #          begin = 2020,
  #          end = 2020,
  #          archive = "ovuzpsg_1220.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_l2_10 <- schema_ukr_l2_09 %>%
  #   setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=October).*(?=1)")
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "rice",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_10,
  #          begin = 2019,
  #          end = 2019,
  #          archive = "ovuzpsg_10_2019.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_l2_11 <- schema_ukr_l2_09 %>%
  #   setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=November).*(?=1)")
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "rice",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_11,
  #          begin = 2018,
  #          end = 2018,
  #          archive = "ovuzpsg_0111.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_l2_12 <- schema_ukr_l2_09 %>%
  #   setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=листопада).*(?=року)")
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "rice",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_12,
  #          begin = 2017,
  #          end = 2017,
  #          archive = "bl_zv_08_2017_x.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_l2_13 <- schema_ukr_l2_09 %>%
  #   setCluster(id = "al1", left = 3, top = 6, height = 4) %>%
  #   setIDVar(name = "year", value = "2016")
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "rice",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_13,
  #          begin = 2016,
  #          end = 2016,
  #          archive = "bl_zvsgk1116xl.zip.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_l2_14 <- schema_ukr_l2_13 %>%
  #   setIDVar(name = "year", value = "2015")
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "rice",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_14,
  #          begin = 2015,
  #          end = 2015,
  #          archive = "bl_zvsk01_11_15xl.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_l2_15 <- schema_ukr_l2_13 %>%
  #   setIDVar(name = "year", value = "2014")
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "rice",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_15,
  #          begin = 2014,
  #          end = 2014,
  #          archive = "bl_zvsk_xl.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_l2_16 <- schema_ukr_l2_13 %>%
  #   setIDVar(name = "year", value = "2013")
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "rice",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_16,
  #          begin = 2013,
  #          end = 2013,
  #          archive = "bl_zb_11_2013.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_l2_20 <- schema_ukr_l2_04 %>%
  #   setIDVar(name = "year", value = "2016") %>%
  #   setIDVar(name = "commodities", columns = 2, rows = 1, split = "(?<=Виробництво).*(?=станом )")
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "corn",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_20,
  #          begin = 2016,
  #          end = 2016,
  #          archive = "bl_zvsgk1116xl.zip.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "sugarbeet",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_20,
  #          begin = 2016,
  #          end = 2016,
  #          archive = "bl_zvsgk1116xl.zip.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_l2_21 <- schema_ukr_l2_20 %>%
  #   setIDVar(name = "year", value = "2015")
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "corn",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_21,
  #          begin = 2015,
  #          end = 2015,
  #          archive = "bl_zvsk01_11_15xl.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "sugarbeet",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_21,
  #          begin = 2015,
  #          end = 2015,
  #          archive = "bl_zvsk01_11_15xl.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_l2_22 <- schema_ukr_l2_20 %>%
  #   setIDVar(name = "year", value = "2014")
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "corn",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_22,
  #          begin = 2014,
  #          end = 2014,
  #          archive = "bl_zvsk_xl.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "sugarbeet",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_22,
  #          begin = 2014,
  #          end = 2014,
  #          archive = "bl_zvsk_xl.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_l2_22 <- schema_ukr_l2_20 %>%
  #   setIDVar(name = "year", value = "2013")
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "maize01",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_22,
  #          begin = 2013,
  #          end = 2013,
  #          archive = "bl_zb_11_2013.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "sugarbeet",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_22,
  #          begin = 2013,
  #          end = 2013,
  #          archive = "bl_zb_11_2013.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_l2_23 <- schema_ukr_l2_04 %>%
  #   setCluster(id = "al1", left = 3, top = 5, height = 25) %>%
  #   setIDVar(name = "year", value = "2013")
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "millet",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_22,
  #          begin = 2013,
  #          end = 2013,
  #          archive = "bl_zb_11_2013.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_00 <- setCluster(id = "al1", left = 2, top = 2) %>%
  #   setIDVar(name = "al1", value = "Ukraine") %>%
  #   setIDVar(name = "year", columns = 2) %>%
  #   setIDVar(name = "commodities", columns = c(3:8), rows = 2, split = "(?<=/).*")
  #
  # schema_ukr_01 <- schema_ukr_00 %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 1000, columns = c(3:8))
  #
  # regTable(nation = "ukr",
  #          level = 1,
  #          subset = "cropsPlant",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_01,
  #          begin = 1991,
  #          end = 2021,
  #          archive = "rosl_1991-2020_ue.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_02 <- schema_ukr_00 %>%
  #   setCluster(id = "al1", left = 2, top = 3) %>%
  #   setIDVar(name = "commodities", columns = c(3:8), rows = 3, split = "(?<=/).*") %>%
  #   setObsVar(name = "production", unit = "t", factor = 1000, columns = c(3:8))
  #
  # regTable(nation = "ukr",
  #          level = 1,
  #          subset = "cropsProd",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_02,
  #          begin = 1991,
  #          end = 2021,
  #          archive = "rosl_1991-2020_ue.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_03 <- schema_ukr_00 %>%
  #   setCluster(id = "al1", left = 2, top = 3) %>%
  #   setIDVar(name = "commodities", columns = c(3:8), rows = 3, split = "(?<=/).*") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(3:8))
  #
  # regTable(nation = "ukr",
  #          level = 1,
  #          subset = "cropsYield",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_03,
  #          begin = 1991,
  #          end = 2021,
  #          archive = "rosl_1991-2020_ue.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
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

  ### ukrstat ----
  # schema_ukr_l2_17 <- setCluster(id = "al1", left = 1, top = 4, height = 26) %>%
  #   setFilter(rows = .find("Україна", col = 1, invert = TRUE)) %>%
  #   setIDVar(name = "al1", value = "Ukraine") %>%
  #   setIDVar(name = "al2", columns = 1) %>%
  #   setIDVar(name = "year", columns = c(2, 3), rows = 4) %>%
  #   setIDVar(name = "commodities", columns = 1, rows = 1, split = ".*(?=number)") %>%
  #   setObsVar(name = "headcount", unit = "n", factor = 1000, columns = c(2, 3))
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "pigs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_17,
  #          begin = 2021,
  #          end = 2022,
  #          archive = "ksgt0222.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "cattle",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_17,
  #          begin = 2021,
  #          end = 2022,
  #          archive = "ksgt0222.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_17,
  #          begin = 2021,
  #          end = 2022,
  #          archive = "ksgt0222.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "sheepGoat",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_17,
  #          begin = 2021,
  #          end = 2022,
  #          archive = "ksgt0222.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "pigs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_17,
  #          begin = 2019,
  #          end = 2020,
  #          archive = "ksgt1220.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "cattle",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_17,
  #          begin = 2019,
  #          end = 2020,
  #          archive = "ksgt1220.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_17,
  #          begin = 2019,
  #          end = 2020,
  #          archive = "ksgt1220.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "sheepGoat",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_17,
  #          begin = 2019,
  #          end = 2020,
  #          archive = "ksgt1220.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "pigs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_17,
  #          begin = 2017,
  #          end = 2018,
  #          archive = "ksgt1218_xl.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "cattle",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_17,
  #          begin = 2017,
  #          end = 2018,
  #          archive = "ksgt1218_xl.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_17,
  #          begin = 2017,
  #          end = 2018,
  #          archive = "ksgt1218_xl.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "sheepGoat",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_17,
  #          begin = 2017,
  #          end = 2018,
  #          archive = "ksgt1218_xl.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  #
  # schema_ukr_l2_18 <- schema_ukr_l2_17 %>%
  #   setCluster(id = "al1", left = 1, top = 6, height = 26) %>%
  #   setIDVar(name = "year", columns = c(2, 3), rows = 6) %>%
  #   setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=КІЛЬКІСТЬ).*(?=ТА)")
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "sheepGoat",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_18,
  #          begin = 2015,
  #          end = 2016,
  #          archive = "24-сг за 11 2016.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "cattle",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_18,
  #          begin = 2015,
  #          end = 2016,
  #          archive = "24-сг за 11 2016.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "pigs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_18,
  #          begin = 2015,
  #          end = 2016,
  #          archive = "24-сг за 11 2016.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_18,
  #          begin = 2015,
  #          end = 2016,
  #          archive = "24-сг за 11 2016.xls",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ukr_l2_19 <- schema_ukr_l2_18 %>%
  #   setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<='Я).*")
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "sheepGoat",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_19,
  #          begin = 2013,
  #          end = 2014,
  #          archive = "bl_st_xl.XLS",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "poultry",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_19,
  #          begin = 2013,
  #          end = 2014,
  #          archive = "bl_st_xl.XLS",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "pigs",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_19,
  #          begin = 2013,
  #          end = 2014,
  #          archive = "bl_st_xl.XLS",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "ukr",
  #          level = 2,
  #          subset = "cattle",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ukr_l2_19,
  #          begin = 2013,
  #          end = 2014,
  #          archive = "bl_st_xl.XLS",
  #          archiveLink = "https://ukrstat.gov.ua/",
  #          updateFrequency = "annually",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://ukrstat.gov.ua/",
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
