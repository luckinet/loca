# script arguments ----
#
thisNation <- "Sudan"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("cbs", "ocha")
gs <- c("gadm36")


# 1. register dataseries ----
#
regDataseries(name = "cbs",
              description = "Central Bureau of Statistics",
              homepage = "http://cbs.gov.sd/",
              notes = "data are public domain",
              licence_link = "",
              licence_path = "",
              update = updateTables)

regDataseries(name = "ocha",
              description = "United Nations Office for the Coordination of Humanitarian Affairs",
              homepage = "https://data.humdata.org/",
              notes = "data are public domain",
              licence_link = "",
              licence_path = "",
              update = updateTables)


# 2. register geometries ----
#
## cbs ----
regGeometry(nation = "NorthSudan",
            gSeries = "cbs", # change the source dataseries here
            level = 1,
            nameCol = "admin1Name",
            archive = "sdn_admbndna_adm0_imwg_11302015.zip|sdn_admbndna_adm0_imwg_11302015.shp",
            archiveLink = "", #find out link
            updateFrequency = "unknown",
            update = myUpdate)

regGeometry(nation = "NorthSudan",
            gSeries = "cbs", # change the source dataseries here
            level = 2,
            nameCol = "admin1Name",
            archive = "sdn_admbndna_adm1_imwg_11302015.zip|sdn_admbndna_adm1_imwg_11302015.shp",
            archiveLink = "", #find out link
            updateFrequency = "unknown",
            update = myUpdate)

regGeometry(nation = "NorthSudan",
            gSeries = "cbs", # change the source dataseries here
            level = 3,
            nameCol = "admin1Name",
            archive = "sdn_admbndna_adm2_imwg_11302015.zip|sdn_admbndna_adm2_imwg_11302015.shp",
            archiveLink = "", #find out link
            updateFrequency = "unknown",
            update = myUpdate)


# 3. register census tables ----
#
## crops ----
if(build_crops){

}

## livestock ----
if(build_livestock){

}

## landuse ----
if(build_landuse){

}


schema_sdn_01 <-
  setIDVar(name = "al1", value = "Sudan") %>%
  setIDVar(name = "year", columns = 6) %>%
  setIDVar(name = "commodities", columns = c(2:5), rows = 2) %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = c(2:5), top = 1)

regTable(nation = "sdn",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_sdn_01,
         begin = 2006,
         end = 2010,
         archive = "Livestock 2006_2010.csv",
         archiveLink = "http://cbs.gov.sd/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://cbs.gov.sd/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_sdn_02 <- setCluster(id = "al1", left = 1, top = 3, height = 25) %>%
  setIDVar(name = "al1", value = "Sudan") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = 4)

regTable(nation = "sdn",
         level = 1,
         subset = "livestockSheep",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_sdn_02,
         begin = 1991,
         end = 2015,
         archive = "Livestocks_1991_2015.csv",
         archiveLink = "http://cbs.gov.sd/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://cbs.gov.sd/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_sdn_03 <- setCluster(id = "commodities", left = c(1, 1, 4, 1, 4, 1, 4), top = c(4, 15, 15, 25, 25, 34, 34), height = 7) %>%
  setIDVar(name = "al1", value = "Sudan") %>%
  setIDVar(name = "year",  columns = c(4, 7, 4, 7, 4, 7, 4), relative =  TRUE) %>%
  setIDVar(name = "commodities", columns = c(1, 1, 4, 1, 4, 1, 4), rows = c(4, 15, 15, 25, 25, 34, 34)) %>%
  setObsVar(name = "planted", unit = "ha", factor = 1000, columns = 3, relative = TRUE) %>%
  setObsVar(name = "production", unit = "t", factor = 1000, columns = 2, relative = TRUE) %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = 1, relative = TRUE)

regTable(nation = "sdn",
         level = 1,
         subset = "crops",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_sdn_03,
         begin = 2007,
         end = 2011,
         archive = "Agri_Statistic 2006_2011.csv",
         archiveLink = "http://cbs.gov.sd/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://cbs.gov.sd/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_sdn_04 <- setCluster(id = "commodities", left = 1, top = c(1, 12, 22, 32, 42, 52, 62, 72, 84, 93, 104, 114), height = 8) %>%
  setFilter(rows = .find("Season", col = 5), invert = TRUE) %>%
  setIDVar(name = "al1", value = "Sudan") %>%
  setIDVar(name = "year",  columns = 5, relative =  TRUE) %>%
  setIDVar(name = "commodities", columns = 1, rows = c(1, 12, 22, 32, 42, 52, 62, 72, 84, 93, 104, 114)) %>%
  setObsVar(name = "planted", unit = "ha", factor = 1000, columns = 4, top = 2, relative = TRUE) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 1000, columns = 3, top = 2, relative = TRUE) %>%
  setObsVar(name = "production", unit = "t", factor = 1000, columns = 2, top = 2, relative = TRUE) %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = 1, top = 2, relative = TRUE)

regTable(nation = "sdn",
         level = 1,
         subset = "fieldCrops",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_sdn_04,
         begin = 2013,
         end = 2016,
         archive = "Agri_Statistic 2012_2016.csv",
         archiveLink = "http://cbs.gov.sd/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://cbs.gov.sd/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_sdn_05 <- setCluster(id = "al1", left = 1, top = 128, height = 20) %>%
  setFilter(rows = .find("Crop", col = 11), invert = TRUE) %>%
  setIDVar(name = "al1", value = "Sudan") %>%
  setIDVar(name = "year", columns = c(1:10), row = 128) %>%
  setIDVar(name = "commodities", columns = 11) %>%
  setObsVar(name = "planted", unit = "ha", factor = 1000, columns = c(2, 4, 6, 8, 10), top = 2) %>%
  setObsVar(name = "production", unit = "t", facto = 1000, columns = c(1, 3, 5, 7, 9), top = 2)

regTable(nation = "sdn",
         level = 1,
         subset = "vegetables",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_sdn_05,
         begin = 2012,
         end = 2016,
         archive = "Agri_Statistic 2012_2016.csv",
         archiveLink = "http://cbs.gov.sd/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://cbs.gov.sd/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_sdn_06 <- setCluster(id = "al1", left = 1, top = 162, height = 10) %>%
  setFilter(rows = .find("Crop", col = 11), invert = TRUE) %>%
  setIDVar(name = "al1", value = "Sudan") %>%
  setIDVar(name = "year", columns = c(1:10), row = 162) %>%
  setIDVar(name = "commodities", columns = 11) %>%
  setObsVar(name = "planted", unit = "ha", factor = 1000, columns = c(2, 4, 6, 8, 10), top = 2) %>%
  setObsVar(name = "production", unit = "t", facto = 1000, columns = c(1, 3, 5, 7, 9), top = 2)

regTable(nation = "sdn",
         level = 1,
         subset = "fruits",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_sdn_06,
         begin = 2012,
         end = 2016,
         archive = "Agri_Statistic 2012_2016.csv",
         archiveLink = "http://cbs.gov.sd/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://cbs.gov.sd/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_sdn_07 <- setCluster(id = "al1", left = 1, top = 186, height = 6) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al1", value = "Sudan") %>%
  setIDVar(name = "year", columns = 3) %>%
  setIDVar(name = "commodities", value = "forest") %>%
  setObsVar(name = "area", unit = "ha", columns = 1)

regTable(nation = "sdn",
         level = 1,
         subset = "forest",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_sdn_07,
         begin = 2012,
         end = 2016,
         archive = "Agri_Statistic 2012_2016.csv",
         archiveLink = "http://cbs.gov.sd/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://cbs.gov.sd/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# not working properly
schema_sdn_08 <- setCluster(id = "al1", left = 1, top = 221, height = 7) %>%
  setIDVar(name = "al1", value = "Sudan") %>%
  setIDVar(name = "year", columns = 9) %>%
  setIDVar(name = "commodities", columns = c(1, 3, 5, 7), rows = 221) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2, 4, 6, 8))

regTable(nation = "sdn",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_sdn_08,
         begin = 2012,
         end = 2016,
         archive = "Agri_Statistic 2012_2016.csv",
         archiveLink = "http://cbs.gov.sd/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://cbs.gov.sd/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_sdn_09 <- setCluster(id = "al1", left = 1, top = 232, height = 6) %>%
  setIDVar(name = "al1", value = "Sudan") %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", value = "poultry") %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = 1)

regTable(nation = "sdn",
         level = 1,
         subset = "poultry",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_sdn_09,
         begin = 2012,
         end = 2016,
         archive = "Agri_Statistic 2012_2016.csv",
         archiveLink = "http://cbs.gov.sd/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://cbs.gov.sd/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


#
#
# Schema_SudStat00_02 <- makeSchema(schema = list(
#   clusters =
#     list(row = c(2,18,26,37), col = 1, width = NULL, height = NULL,
#          id = "commodities"),
#   header = list(row = 1, rel = T),
#   meta = list(dec = NULL, del = NULL, na = NULL, types = NULL),
#   variables = list(
#     al1 =
#       list(type = "id", value = "Sudan"),
#     year =
#       list(type = "id", row = c(2,c(20,21),c(28,29), 37), col = c(1, 1, 1, c(2,3)), value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     commodities =
#       list(type = "id", row = c(1, 18, 26, c(38:41)), col = c(1, c(2,5,8), c(2,5,8), 1), value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     planted =
#       list(type = "measured", row = c(4, c(20,21), c(28,29)), col = c(1,c(2,5,8), c(2,5,8)),
#            unit = "ha", factor = 0.42, key = NULL, value = NULL,
#            rel = FALSE, dist = TRUE),
#     production =
#       list(type = "measured", row = c(4, c(20:21), c(28:29)), col =c(c(2,6), c(3,6,9),c(3,6,9)),
#            unit = "t", factor = 1102, key = NULL, value = NULL,
#            rel = F, dist = TRUE), #cluster one needs factor = 110.2 and the rest needs factor = 1102
#     yield =
#       list(type = "measured", row = c(4, c(20:21), c(28,29)) , col = c(c(3,7), c(3,7,10), c(3,7,10)),
#            unit = "t/ha", factor = 0.002, key = NULL, value = NULL,
#            rel = F, dist = TRUE),#cluster one needs factor = 0,262 but the rest needs factor = 1.102
#     headcount =
#       list(type = "measured", row = c(38:41), col = c(2,3),
#            unit = "t", factor = 1000, key = NULL, value = NULL,
#            rel = TRUE, dist = FALSE))))
#
#
# regTable(nation = "Sudan",
#          level = 1,
#          dSeries = "cbsSudan",
#          gSeries = "ocha",
#          begin = 2000,
#          end = 2002,
#          schema = Schema_SudStat00_02,
#          archive = "Agriculture Production 2000-02.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_SudStat01_03 <- makeSchema(schema = list(
#   clusters =
#     list(row = c(2,18,26,37), col = 1, width = NULL, height = NULL,
#          id = "commodities"),
#   header = list(row = 1, rel = T),
#   meta = list(dec = NULL, del = NULL, na = NULL, types = NULL),
#   variables = list(
#     al1 =
#       list(type = "id", value = "Sudan"),
#     year =
#       list(type = "id", row = c(2,c(20,21),c(28,29), 37,c(48,49)), col = c(1, 1, 1, c(2,3), 1), value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     commodities =
#       list(type = "id", row = c(1, 18, 26, c(38:41)), col = c(1, c(2,5,8), c(2,5,8), 1), value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     planted =
#       list(type = "measured", row = c(4, c(20,21), c(28,29)), col = c(1,c(2,5,8), c(2,5,8)),
#            unit = "ha", factor = 0.42, key = NULL, value = NULL,
#            rel = FALSE, dist = TRUE),
#     production =
#       list(type = "measured", row = c(4, c(20:21), c(28:29)), col =c(c(2,6), c(3,6,9),c(3,6,9)),
#            unit = "t", factor = 1102, key = NULL, value = NULL,
#            rel = F, dist = TRUE), #cluster one needs factor = 110.2 and the rest needs factor = 1102
#     yield =
#       list(type = "measured", row = c(4, c(20:21), c(28,29)) , col = c(c(3,7), c(3,7,10), c(3,7,10)),
#            unit = "t/ha", factor = 0.002, key = NULL, value = NULL,
#            rel = F, dist = TRUE),#cluster one needs factor = 0,262 but the rest needs factor = 1.102
#     headcount =
#       list(type = "measured", row = c(38:41), col = c(2,3),
#            unit = "t", factor = 1000, key = NULL, value = NULL,
#            rel = TRUE, dist = FALSE))))
#
# regTable(nation = "Sudan",
#          level = 1,
#          dSeries = "cbsSudan",
#          gSeries = "ocha",
#          begin = 2001,
#          end = 2003,
#          schema = Schema_SudStat01_03,
#          archive = "Agriculture Production 2001-03.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# Schema_SudStat03_04 <- makeSchema(schema = list(
#   clusters =
#     list(row = c(2,18,26,37,58), col = 1, width = NULL, height = NULL,
#          id = "commodities"),
#   header = list(row = 1, rel = T),
#   meta = list(dec = NULL, del = NULL, na = NULL, types = NULL),
#   variables = list(
#     al1 =
#       list(type = "id", value = "Sudan"),
#     year =
#       list(type = "id", row = c(2,c(20,21),c(28,29), 37,c(48,49), col = c(1, 1, 1, c(2,3), 1), value = NULL,
#                                 split = NULL, rel = FALSE, dist = T),
#            commodities =
#              list(type = "id", row = c(1, 18, 26, c(38:41), c(48,49)), col = c(1, c(2,5,8), c(2,5,8), 1, 1), value = NULL,
#                   split = NULL, rel = FALSE, dist = T),
#            planted =
#              list(type = "measured", row = c(4, c(20,21), c(28,29)), col = c(1,c(2,5,8), c(2,5,8)),
#                   unit = "ha", factor = 0.42, key = NULL, value = NULL,
#                   rel = FALSE, dist = TRUE),
#            production =
#              list(type = "measured", row = c(4, c(20:21), c(28:29)), col =c(c(2,6), c(3,6,9),c(3,6,9)),
#                   unit = "t", factor = 1102, key = NULL, value = NULL,
#                   rel = F, dist = TRUE), #cluster one needs factor = 420 and the rest needs factor = 1102
#            yield =
#              list(type = "measured", row = c(4, c(20:21), c(28,29)) , col = c(c(3,7), c(3,7,10), c(3,7,10)),
#                   unit = "t/ha", factor = 0.002, key = NULL, value = NULL,
#                   rel = F, dist = TRUE),#cluster one needs factor = 0,42 but the rest needs factor = 1.102
#            headcount =
#              list(type = "measured", row = c(38:41), col = c(2,3),
#                   unit = "t", factor = 1000, key = NULL, value = NULL,
#                   rel = TRUE, dist = FALSE)))))
#
# regTable(nation = "Sudan",
#          level = 1,
#          dSeries = "cbsSudan",
#          gSeries = "ocha",
#          begin = 2003,
#          end = 2004,
#          schema = Schema_SudStat03_04,
#          archive = "Agriculture Production 2003-04.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# Schema_SudStat04_06 <- makeSchema(schema = list(
#   clusters =
#     list(row = c(2,18,26,37,58), col = 1, width = NULL, height = NULL,
#          id = "commodities"),
#   header = list(row = 1, rel = T),
#   meta = list(dec = NULL, del = NULL, na = NULL, types = NULL),
#   variables = list(
#     al1 =
#       list(type = "id", value = "Sudan"),
#     year =
#       list(type = "id", row = c(2,c(20,21),c(28,29), 37, c(59,60)), col = c(1, 1, 1, c(2,3), 1), value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     commodities =
#       list(type = "id", row = c(1, 18, 26, c(38:41), c(48,49)), col = c(1, c(2,5,8), c(2,5,8), 1, 1), value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     planted =
#       list(type = "measured", row = c(4, c(20,21), c(28,29)), col = c(1,c(2,5,8), c(2,5,8)),
#            unit = "ha", factor = 0.42, key = NULL, value = NULL,
#            rel = FALSE, dist = TRUE),
#     production =
#       list(type = "measured", row = c(4, c(20:21), c(28:29)), col =c(c(2,6), c(3,6,9),c(3,6,9)),
#            unit = "t", factor = 1102, key = NULL, value = NULL,
#            rel = F, dist = TRUE), #cluster one needs factor = 420 and the rest needs factor = 1102
#     yield =
#       list(type = "measured", row = c(4, c(20:21), c(28,29)) , col = c(c(3,7), c(3,7,10), c(3,7,10)),
#            unit = "t/ha", factor = 0.002, key = NULL, value = NULL,
#            rel = F, dist = TRUE),#cluster one needs factor = 0,42 but the rest needs factor = 1.102
#     headcount =
#       list(type = "measured", row = c(38:41), col = c(2,3),
#            unit = "h", factor = 1000, key = NULL, value = NULL,
#            rel = TRUE, dist = FALSE))))
#
#
# regTable(nation = "Sudan",
#          level = 1,
#          dSeries = "cbsSudan",
#          gSeries = "ocha",
#          begin = 2004,
#          end = 2006,
#          schema = Schema_SudStat04_06,
#          archive = "Agriculture Production 2004-06.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# Schema_SudStat06_07 <- makeSchema(schema = list(
#   clusters =
#     list(row = c(2,18,26,37,48), col = 1, width = NULL, height = NULL,
#          id = "commodities"),
#   header = list(row = 1, rel = T),
#   meta = list(dec = NULL, del = NULL, na = NULL, types = NULL),
#   variables = list(
#     al1 =
#       list(type = "id", value = "Sudan"),
#     year =
#       list(type = "id", row = c(2,c(20,21),c(28,29), 37, c(59,60)), col = c(1, 1, 1, c(2,3), 1), value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     commodities =
#       list(type = "id", row = c(1, 18, 26, c(38:41), c(48,49)), col = c(1, c(2,5,8), c(2,5,8), 1, 1), value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     planted =
#       list(type = "measured", row = c(4, c(20,21), c(28,29)), col = c(1,c(2,5,8), c(2,5,8)),
#            unit = "ha", factor = 0.42, key = NULL, value = NULL,
#            rel = FALSE, dist = TRUE),
#     production =
#       list(type = "measured", row = c(4, c(20:21), c(28:29)), col =c(c(2,6), c(3,6,9),c(3,6,9)),
#            unit = "t", factor = 1102, key = NULL, value = NULL,
#            rel = F, dist = TRUE), #cluster one needs factor = 420 and the rest needs factor = 1102
#     yield =
#       list(type = "measured", row = c(4, c(20:21), c(28,29)) , col = c(c(3,7), c(3,7,10), c(3,7,10)),
#            unit = "t/ha", factor = 0.002, key = NULL, value = NULL,
#            rel = F, dist = TRUE),#cluster one needs factor = 0,42 but the rest needs factor = 1.102
#     headcount =
#       list(type = "measured", row = c(38:41), col = c(2,3),
#            unit = "h", factor = 1000, key = NULL, value = NULL,
#            rel = TRUE, dist = FALSE))))
#
#
# regTable(nation = "Sudan",
#          level = 1,
#          dSeries = "cbsSudan",
#          gSeries = "ocha",
#          begin = 2006,
#          end = 2007,
#          schema = Schema_SudStat06_07,
#          archive = "Agriculture Production 2006-07.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# Schema_SudStat07_08Crops <- makeSchema(schema = list(
#   clusters =
#     list(row = c(2, 18, 27), col = 1,
#          id = "commodities"),
#   header = list(row = c(3, 19, 28), rel = F),
#   variables = list(
#     al1 =
#       list(type = "id", value = "Sudan"),
#     year =
#       list(type = "id", row = c(2,20:21,28:29), col = c(1, 13, 10, 5), value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     commodities =
#       list(type = "id", row = c(1, 18, 27), col = c(1, c(1,5,7,10), c(1,4,7)), value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     planted =
#       list(type = "measured", row = c(4, 20:21, 29:30), col = c(c(3,6), c(3,6,9,12),c(3,6,9)),
#            unit = "ha", factor = 408, key = NULL, value = NULL, # cluster one needs factor = 420 but the rest need factor = 408
#            rel = FALSE, dist = TRUE),
#     production =
#       list(type = "measured", row = c(4, 20:21, 29:30), col = c(c(1,4), c(2,5,8,11), c(2,5,8)),
#            unit = "t", factor = 1102, key = NULL, value = NULL,
#            rel = F, dist = TRUE), # cluster one needs factor = 420 and the rest needs factor = 1102
#     yield =
#       list(type = "measured", row = c(4, 20:21, 28:29), col = c(2:5, c(1,4,7,10), c(1,4,7)),
#            unit = "t/ha", factor = 0.004, key = NULL, value = NULL,
#            rel = T, dist = F)))) #cluster one needs factor = 0,11 but the rest needs factor = 0.004
#
# regTable(nation = "Sudan",
#          level = 1,
#          dSeries = "cbsSudan",
#          gSeries = "ocha",
#          begin = 2007,
#          end = 2008,
#          schema = Schema_SudStat07_08Crops,
#          archive = "Agriculture Production 2007-08.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# Schema_SudStat07_08Livestock <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, width = NULL, height = NULL,
#          id = "commodities"),
#   header = list(row = 3, rel = T),
#   meta = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al1 =
#       list(type = "id", value = "Sudan"),
#     year =
#       list(type = "id", row = 3, col = c(2,3), value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     commodities =
#       list(type = "id", row = 4, col = NULL, value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     headcount =
#       list(type = "measured", row = c(4:7), col = c(2:3),
#            unit = "h", factor = 1000, key = NULL, value = NULL,
#            rel = TRUE, dist = FALSE))))
#
# regTable(nation = "Sudan",
#          level = 1,
#          dSeries = "cbsSudan",
#          gSeries = "ocha",
#          begin = 2007,
#          end = 2008,
#          schema = Schema_SudStat07_08Livestock,
#          archive = "Agriculture Production 2007-08Livestock.csv",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# Schema_SudStat09_10Crops <- makeSchema(schema = list(
#   clusters =
#     list(row = c(2, 18, 31), col = 1,
#          id = "commodities"),
#   header = list(row = c(4, 19, 32), rel = F),
#   variables = list(
#     al1 =
#       list(type = "id", value = "Sudan"),
#     year =
#       list(type = "id", row = c(3, 20:21, 33:34), col = c(c(1,3), 1, 1), value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     commodities =
#       list(type = "id", row = c(2, 18, 31), col = c(1, c(2, 5, 8), c(2, 5, 8)), value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     planted =
#       list(type = "measured", row = c(6, 20:21, 33:34), col = c(c(1,3), c(2,5,8), c(2,5,8), c(2,5, 8),c(2,5, 8)),
#            unit = "ha", factor = 408, key = NULL, value = NULL, # cluster one needs factor = 420 but the rest need factor = 408
#            rel = FALSE, dist = TRUE),
#     production =
#       list(type = "measured", row = c(6, 20:21, 33:34), col = c(c(2,4), c(3,6,9), c(3,6,9)),
#            unit = "t", factor = 1102, key = NULL, value = NULL,
#            rel = F, dist = TRUE), # cluster one needs factor = 420 and the rest needs factor = 1102
#     yield =
#       list(type = "measured", row = c(20:21,33:34), col = c(c(4,7,10), c(4,7,10)),
#            unit = "t/ha", factor = 0.004, key = NULL, value = NULL,
#            rel = F, dist = F))))
#
# regTable(nation = "Sudan",
#          level = 1,
#          dSeries = "cbsSudan",
#          gSeries = "ocha",
#          begin = 2009,
#          end = 2010,
#          schema = Schema_SudStat09_10Crops,
#          archive = "Agriculture Production 2009-10.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# Schema_SudStat09_10Livestock <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, width = NULL, height = NULL,
#          id = "commodities"),
#   header = list(row = 3, rel = T),
#   meta = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al1 =
#       list(type = "id", value = "Sudan"),
#     year =
#       list(type = "id", row = 3, col = c(2,3), value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     commodities =
#       list(type = "id", row = 4, col = NULL, value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     headcount =
#       list(type = "measured", row = c(4:7), col = c(2:3),
#            unit = "h", factor = 1000, key = NULL, value = NULL,
#            rel = TRUE, dist = FALSE))))
#
# regTable(nation = "Sudan",
#          level = 1,
#          dSeries = "cbsSudan",
#          gSeries = "ocha",
#          begin = 2009,
#          end = 2010,
#          schema = Schema_SudStat07_08Livestock,
#          archive = "Agriculture Production 2009-10.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# Schema_SudStat09_10Livestock <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, width = NULL, height = NULL,
#          id = "commodities"),
#   header = list(row = 3, rel = T),
#   meta = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al1 =
#       list(type = "id", value = "Sudan"),
#     year =
#       list(type = "id", row = 3, col = c(2,3), value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     commodities =
#       list(type = "id", row = 4, col = NULL, value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     headcount =
#       list(type = "measured", row = c(4:7), col = c(2:3),
#            unit = "h", factor = 1000, key = NULL, value = NULL,
#            rel = TRUE, dist = FALSE))))
#
# regTable(nation = "Sudan",
#          level = 1,
#          dSeries = "cbsSudan",
#          gSeries = "ocha",
#          begin = 2009,
#          end = 2010,
#          schema = Schema_SudStat07_08Livestock,
#          archive = "Agriculture Production 2009-10.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# Schema_SudStat12_16Crops <- makeSchema(schema = list(
#   clusters =
#     list(row = c(1, 12, 22, 32, 42, 52, 62, 72, 82, 92, 103, 113, 131, 141), col = 1,
#          id = "commodities"),
#   header = list(row = 2, rel = T),
#   variables = list(
#     al1 =
#       list(type = "id", value = "Sudan"),
#     year =
#       list(type = "id", row = 4:8, col = 6, value = NULL,
#            split = NULL, rel = T, dist = T),
#     commodities =
#       list(type = "id", row = 1, col = 1, value = NULL,
#            split = NULL, rel = TRUE, dist = T),
#     planted =
#       list(type = "values", row = 4:8, col = 4,
#            unit = "ha", factor = 420, key = NULL, value = NULL,   # there is a problem in this schema "values" and "meaured"
#            rel = TRUE, dist = TRUE),
#     production =
#       list(type = "values", row = 4:8, col = 2,
#            unit = "t", factor = 1000, key = NULL, value = NULL,
#            rel = TRUE, dist = TRUE),
#     yield =
#       list(type = "values", row = 4:8, col = 1,
#            unit = "t/ha", factor = 0.002, key = NULL, value = NULL,
#            rel = TRUE, dist = F))))
#
# regTable(nation = "Sudan",
#          level = 1,
#          dSeries = "cbsSudan",
#          gSeries = "ocha",
#          begin = 2012,
#          end = 2016,
#          schema = Schema_SudStat12_16Crops,
#          archive = "Agri_Statistical_2012_2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# Schema_SudStat12_16SubVegFruit <- makeSchema(schema = list(
#   clusters =
#     list(row = c(1, 33), col = 1,
#          id = "commodities"),
#   header = list(row = 1,33, rel = FALSE), # there is a problem in this schema
#   variables = list(
#     al1 =
#       list(type = "id", value = "Sudan"),
#     year =
#       list(type = "id", row = c(2, 28), col = c(1,3,5,7,9), value = NULL,
#            split = NULL, rel = F, dist = F),
#     commodities =
#       list(type = "id", row = c(4:21, 36:43), col = 1, value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     planted =
#       list(type = "measured", row = c(4:21, 36:43), col = c(c(2,4,6,8,10), c(2,4,6,8,10)),
#            unit = "ha", factor = 420, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE),
#     production =
#       list(type = "measured", row = 4:21, 36:43, col = 1,3,5,7,9,
#            unit = "t", factor = 1000, key = NULL, value = NULL,
#            rel = F, dist = FALSE),
#   )))
#
# regTable(nation = "Sudan",
#          level = 1,
#          subset = "VegFruit",
#          dSeries = "cbsSudan",
#          gSeries = "ocha",
#          begin = 2012,
#          end = 2016,
#          schema = Schema_SudStat12_16subVegFruit,
#          archive = "Agri_Statistical_2012_2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# Schema_SudStat12_16Livestock <- makeSchema(schema = list(
#   clusters =
#     list(row = c(2, 13), col = 1, width = NULL, height = NULL, # error element 3 is empty
#          id = "commodities"),
#   header = list(row = 2, 12, rel = F),
#   meta = list(del = NULL, na = NULL, types = NULL),
#   variables = list(
#     al1 =
#       list(type = "id", value = "Sudan"),
#     year =
#       list(type = "id", row = c(4:8, 14:18), col = c(9,2), value = NULL,
#            split = NULL, rel = FALSE, dist = F),
#     commodities =
#       list(type = "id", row = 2, 13, col = NULL, value = NULL,
#            split = NULL, rel = FALSE, dist = F),
#     headcount =
#       list(type = "measured", row = c(4:8, 14:18), col = c(c(2,4,6,8),1),
#            unit = "h", factor = 1000, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE))))
#
# regTable(nation = "Sudan",
#          level = 1,
#          subset = "livestock",
#          dSeries = "cbsSudan",
#          gSeries = "ocha",
#          begin = 2012,
#          end = 2016,
#          schema = Schema_SudStat07_08Livestock,
#          archive = "Agri_Statistical_2012_2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# Schema_SudStat02_03 <- makeSchema(schema = list(
#   clusters =
#     list(row = c(2, 42), col = 1,
#          id = "commodities"),
#   header = list(row = 2,40, rel = FALSE),
#   variables = list(
#     al1 =
#       list(type = "id", value = "Sudan"),
#     year =
#       list(type = "id", row = c(2, 39), col = NULL, value = NULL,
#            split = NULL, rel = F, dist = F),
#     commodities =
#       list(type = "id", row = c(1, 36:43), col = 1, value = NULL,
#            split = NULL, rel = FALSE, dist = T),
#     planted =
#       list(type = "measured", row = c(4:21, 36:43), col = c(c(2,4,6,8,10), c(2,4,6,8,10)),  # Problem#
#            unit = "ha", factor = 420, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE),
#     production =
#       list(type = "measured", row = 4:21, 36:43, col = 1,3,5,7,9,
#            unit = "t", factor = 1000, key = NULL, value = NULL,
#            rel = F, dist = FALSE)
#   )))
#
# regTable(nation = "Sudan",
#          level = 1,
#          #subset = "livestock",
#          dSeries = "cbsSudan",
#          gSeries = "ocha",
#          begin = 2002,
#          end = 2003,
#          schema = Schema_SudStat12_16subVegFruit,
#          archive = "Agri_Statistic 2002_2003.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)


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


# 4. normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg",
#              update = updateTables)

normGeometry(pattern = gs[],
             outType = "gpkg",
             update = updateTables)


# 5. normalise census tables ----
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

