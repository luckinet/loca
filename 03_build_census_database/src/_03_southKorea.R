# script arguments ----
#
thisNation <- "South Korea"

updateTables <- FALSE
overwriteTables <- FALSE

ds <- c("kosis", "kfs")
gs <- c("gadm36", "ngii")


# register dataseries ----
#
regDataseries(name = ds[1],
              description = "Korean Statistical Information Service",
              homepage = "http://kosis.kr/eng/index/index.do;jsessionid=TayIGWJkv4eWP8T5qE5lj8hIaecm5cNkH0qtGNbZcRdxEdPayHnZe4NVLipe1feN.STAT_WAS1_servlet_engine2",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)

regDataseries(name = ds[2],
              description = "Korea Forest Service",
              homepage = "http://english.forest.go.kr/newkfsweb/eng/idx/Index.do?mn=ENG_01",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)

regDataseries(name = gs[2],
              description = "National Geographic Information Institute",
              homepage = "https://www.ngii.go.kr/eng/main.do",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)


# register geometries ----
#
## ngii ----
regGeometry(nation = "South Korea",
            gSeries = gs[2],
            level = 2,
            nameCol = "MNG_NAM",
            archive = "southKorea.zip|ARD_ADMIN_AS.shp",
            archiveLink = "https://www.ngii.go.kr/eng/main.do",
            nextUpdate = "unknown",
            updateFrequency = "notPlanned",
            update = updateTables)

regGeometry(nation = "South Korea",
            gSeries = gs[2],
            level = 3,
            nameCol = "MNG_NAM",
            archive = "southKorea.zip|KOR_ADMIN_AS.shp",
            archiveLink = "https://www.ngii.go.kr/eng/main.do",
            nextUpdate = "unknown",
            updateFrequency = "notPlanned",
            update = updateTables)



# register census tables ----
#
## kosis----
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
#
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
#
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


#### test schemas

# myRoot <- paste0(dataDir, "censusDB/adb_tables/stage2/")
# myFile <- ""
# schema <-
#
# input <- read_csv(file = paste0(myRoot, myFile),
#                   col_names = FALSE,
#                   col_types = cols(.default = "c"))
#
# validateSchema(schema = schema, input = input)
#
# output <- reorganise(input = input, schema = schema)
#
# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script


# normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg",
#              update = updateTables)

normGeometry(pattern = gs[],
             outType = "gpkg",
             update = updateTables)


# normalise census tables ----
#
## in case the output shall be examined before writing into the DB
# testing <- normTable(nation = thisNation,
#                      update = FALSE,
#                      keepOrig = TRUE)
#
# only needed if FAO datasets have not been integrated before
# normTable(pattern = "fao",
#           outType = "rds",
#           update = updateTables)

normTable(pattern = ds[],
          ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)

