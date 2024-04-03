# ----
# geography : South Korea
# period    : _INSERT
# dataseries:
#   - Korean Statistical Information Service (https://kosis.kr/eng/index/index.do)
#   - Korea Forest Service (http://english.forest.go.kr)
#   - National Geographic Information Institute (https://www.ngii.go.kr/eng/main.do)
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

thisNation <- "South Korea"

# 1. dataseries ----
#
ds <- c("kosis", "kfs")
gs <- c("gadm36", "ngii")


regDataseries(name = ds[],
              description = _INSERT,
              homepage = _INSERT,
              version = _INSERT,
              licence_link = _INSERT)

# regDataseries(name = ds[1],
#               description = "Korean Statistical Information Service",
#               homepage = "http://kosis.kr/eng/index/index.do",
#               licence_link = "unknown",
#               licence_path = "not available",
#               update = updateTables)
#
# regDataseries(name = ds[2],
#               description = "Korea Forest Service",
#               homepage = "http://english.forest.go.kr",
#               licence_link = "unknown",
#               licence_path = "not available",
#               update = updateTables)
#
# regDataseries(name = gs[2],
#               description = "National Geographic Information Institute",
#               homepage = "https://www.ngii.go.kr/eng/main.do",
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

## ngii ----
# regGeometry(nation = "South Korea",
#             gSeries = gs[2],
#             level = 2,
#             nameCol = "MNG_NAM",
#             archive = "southKorea.zip|ARD_ADMIN_AS.shp",
#             archiveLink = "https://www.ngii.go.kr/eng/main.do",
#             nextUpdate = "unknown",
#             updateFrequency = "notPlanned",
#             update = updateTables)
#
# regGeometry(nation = "South Korea",
#             gSeries = gs[2],
#             level = 3,
#             nameCol = "MNG_NAM",
#             archive = "southKorea.zip|KOR_ADMIN_AS.shp",
#             archiveLink = "https://www.ngii.go.kr/eng/main.do",
#             nextUpdate = "unknown",
#             updateFrequency = "notPlanned",
#             update = updateTables)

normGeometry(pattern = gs[],
             beep = 10)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  ### kosis ----
  # regTable(nation = "kor",
  #          subset = "vegetableFruits",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 1980,
  #          end = 2018,
  #          archive = "southKorea.zip|fruits.plant.prod.adm2.1980-2018.csv",
  #          archiveLink = "http://kosis.kr/eng/statisticsList/statisticsListIndex.do?menuId=M_01_01&vwcd=MT_ETITLE&parmTabId=M_01_01#SelectStatsBoxDiv",
  #          updateFrequency = "annual",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://kosis.kr/eng/aboutKosis/kosisGuide.do",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "kor",
  #          subset = "allFruits",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 1980,
  #          end = 2018,
  #          archive = "southKorea.zip|fruitsComp.plant.prod.yield.adm2.1980-2018.csv",
  #          archiveLink = "http://kosis.kr/eng/statisticsList/statisticsListIndex.do?menuId=M_01_01&vwcd=MT_ETITLE&parmTabId=M_01_01#SelectStatsBoxDiv",
  #          updateFrequency = "annual",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://kosis.kr/eng/aboutKosis/kosisGuide.do",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "kor",
  #          subset = "allFruits",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 1980,
  #          end = 2018,
  #          archive = "southKorea.zip|fruitsComp.plant.prod.yield.adm2.1980-2018.csv",
  #          archiveLink = "http://kosis.kr/eng/statisticsList/statisticsListIndex.do?menuId=M_01_01&vwcd=MT_ETITLE&parmTabId=M_01_01#SelectStatsBoxDiv",
  #          updateFrequency = "annual",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://kosis.kr/eng/aboutKosis/kosisGuide.do",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "kor",
  #          subset = "oilSeed",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 1980,
  #          end = 2018,
  #          archive = "southKorea.zip|oilseed.plant.prod.adm2.1980-2018.csv",
  #          archiveLink = "http://kosis.kr/eng/statisticsList/statisticsListIndex.do?menuId=M_01_01&vwcd=MT_ETITLE&parmTabId=M_01_01#SelectStatsBoxDiv",
  #          updateFrequency = "annual",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://kosis.kr/eng/aboutKosis/kosisGuide.do",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "kor",
  #          subset = "pulses",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 1980,
  #          end = 2018,
  #          archive = "southKorea.zip|pulses.plant.prod.adm2.1980-2018.csv",
  #          archiveLink = "http://kosis.kr/eng/statisticsList/statisticsListIndex.do?menuId=M_01_01&vwcd=MT_ETITLE&parmTabId=M_01_01#SelectStatsBoxDiv",
  #          updateFrequency = "annual",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://kosis.kr/eng/aboutKosis/kosisGuide.do",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "kor",
  #          subset = "roots",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 1980,
  #          end = 2018,
  #          archive = "southKorea.zip|roots.plant.prod.adm2.1980-2018.csv",
  #          archiveLink = "http://kosis.kr/eng/statisticsList/statisticsListIndex.do?menuId=M_01_01&vwcd=MT_ETITLE&parmTabId=M_01_01#SelectStatsBoxDiv",
  #          updateFrequency = "annual",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://kosis.kr/eng/aboutKosis/kosisGuide.do",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "kor",
  #          subset = "spices",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 1980,
  #          end = 2018,
  #          archive = "southKorea.zip|spices.plant.prod.adm2.1980-2018.csv",
  #          archiveLink = "http://kosis.kr/eng/statisticsList/statisticsListIndex.do?menuId=M_01_01&vwcd=MT_ETITLE&parmTabId=M_01_01#SelectStatsBoxDiv",
  #          updateFrequency = "annual",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://kosis.kr/eng/aboutKosis/kosisGuide.do",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "kor",
  #          subset = "vegetables",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 1980,
  #          end = 2018,
  #          archive = "southKorea.zip|vegetables.plant.prod.adm2.1980-2018.csv",
  #          archiveLink = "http://kosis.kr/eng/statisticsList/statisticsListIndex.do?menuId=M_01_01&vwcd=MT_ETITLE&parmTabId=M_01_01#SelectStatsBoxDiv",
  #          updateFrequency = "annual",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://kosis.kr/eng/aboutKosis/kosisGuide.do",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "kor",
  #          subset = "mainCrops",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 1998,
  #          end = 2018,
  #          archive = "southKorea.zip|plantArea.Prod.Adm2.1998-2018.csv",
  #          archiveLink = "http://kosis.kr/eng/statisticsList/statisticsListIndex.do?menuId=M_01_01&vwcd=MT_ETITLE&parmTabId=M_01_01#SelectStatsBoxDiv",
  #          updateFrequency = "annual",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://kosis.kr/eng/aboutKosis/kosisGuide.do",
  #          metadataPath = "unavailable",
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

  ### kosis----
  # schema_kosis1 <- makeSchema()
  #
  # regTable(nation = "kor",
  #          subset = "headcountCattle",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema =
  #          begin = 1980,
  #          end = 2018,
  #          archive = "southKorea.zip|headcount.cattle.adm2.1980-2018.csv",
  #          archiveLink = "http://kosis.kr/eng/statisticsList/statisticsListIndex.do?menuId=M_01_01&vwcd=MT_ETITLE&parmTabId=M_01_01#SelectStatsBoxDiv",
  #          updateFrequency = "annual",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://kosis.kr/eng/aboutKosis/kosisGuide.do",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "kor",
  #          subset = "headcountSwine",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 1980,
  #          end = 2018,
  #          archive = "southKorea.zip|headcount.swine.adm2.1980-2018.csv",
  #          archiveLink = "http://kosis.kr/eng/statisticsList/statisticsListIndex.do?menuId=M_01_01&vwcd=MT_ETITLE&parmTabId=M_01_01#SelectStatsBoxDiv",
  #          updateFrequency = "annual",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://kosis.kr/eng/aboutKosis/kosisGuide.do",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "kor",
  #          subset = "headcountChicken",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 1980,
  #          end = 2018,
  #          archive = "southKorea.zip|headcount.cchicken.adm2.1980-2018.csv",
  #          archiveLink = "http://kosis.kr/eng/statisticsList/statisticsListIndex.do?menuId=M_01_01&vwcd=MT_ETITLE&parmTabId=M_01_01#SelectStatsBoxDiv",
  #          updateFrequency = "annual",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://kosis.kr/eng/aboutKosis/kosisGuide.do",
  #          metadataPath = "unavailable",
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

  ### kfs ----
  # regTable(nation = "kor",
  #          subset = "forest",
  #          level = 2,
  #          dSeries = "kfs",
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 2015,
  #          end = 2017,
  #          archive = "southKorea.zip|2018forestry.pdf",
  #          archiveLink = "http://english.forest.go.kr/images/korea/2018forestry.pdf",
  #          updateFrequency = "annual",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://english.forest.go.kr/images/korea/2018forestry.pdf",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "kor",
  #          subset = "forest",
  #          level = 1,
  #          dSeries = "kfs",
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 1981,
  #          end = 2017,
  #          archive = "southKorea.zip|2018forestry.pdf",
  #          archiveLink = "http://english.forest.go.kr/images/korea/2018forestry.pdf",
  #          updateFrequency = "annual",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://english.forest.go.kr/images/korea/2018forestry.pdf",
  #          metadataPath = "unavailable",
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
