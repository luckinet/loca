# script arguments ----
#
thisNation <- "Indonesia"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("bps", "faoDatalab", "agCensus", "spam")
gs <- c("gadm", "bps", "agCensus", "spam")


# register dataseries ----
#
regDataseries(name = ds[1],
              description = "Badan Pusat Statistik",
              homepage = "https://www.bps.go.id",
              licence_link = "https://www.bps.go.id/website/fileMenu/law16_97_eng.pdf",
              licence_path = "I:/MAS/01_data/LUCKINet/output/areal data/personal versions/test_annika/adb_tables/incoming/Indonesia/meta/law16_97_eng.pdf",
              notes = "metadata namely concept and methodology is downloaded from mainpage but apply for all sub-websites",
              update = updateTables)


# 2. register geometries ----
#
regGeometry(nation = "Indonesia",
            gSeries = gs[2],
            level = 1,
            nameCol = "ADM0_EN",
            archive = "idn_adm_bps_20200401_shp.zip|idn_admbnda_adm0_bps_20200401.shp",
            archiveLink = "https://data.amerigeoss.org/ro/dataset/indonesia-central-sulawesi-administrative-boundary-polygons-levels-1-4",
            nextUpdate = "unknown",
            updateFrequency = "notplanned",
            update = updateTables,
            overwrite = overwriteTables)

regGeometry(nation = "Indonesia",
            gSeries = gs[2],
            level = 2,
            nameCol = "ADM0_EN|ADM1_EN",
            archive = "idn_adm_bps_20200401_shp.zip|idn_admbnda_adm1_bps_20200401.shp",
            archiveLink = "https://data.amerigeoss.org/ro/dataset/indonesia-central-sulawesi-administrative-boundary-polygons-levels-1-4",
            nextUpdate = "unknown",
            updateFrequency = "notplanned",
            update = updateTables,
            overwrite = overwriteTables)

regGeometry(nation = "Indonesia",
            gSeries = gs[2],
            level = 3,
            nameCol = "ADM0_EN|ADM1_EN|ADM2_EN",
            archive = "idn_adm_bps_20200401_shp.zip|idn_admbnda_adm2_bps_20200401.shp",
            archiveLink = "https://data.amerigeoss.org/ro/dataset/indonesia-central-sulawesi-administrative-boundary-polygons-levels-1-4",
            nextUpdate = "unknown",
            updateFrequency = "notplanned",
            update = updateTables,
            overwrite = overwriteTables)

regGeometry(nation = "Indonesia",
            gSeries = gs[2],
            level = 4,
            nameCol = "ADM0_EN|ADM1_EN|ADM2_EN|ADM3_EN",
            archive = "idn_adm_bps_20200401_shp.zip|idn_admbnda_adm3_bps_20200401.shp",
            archiveLink = "https://data.amerigeoss.org/ro/dataset/indonesia-central-sulawesi-administrative-boundary-polygons-levels-1-4",
            nextUpdate = "unknown",
            updateFrequency = "notplanned",
            update = updateTables,
            overwrite = overwriteTables)


# 3. register census tables ----
#
# faoDatalab ----
## Region Kalimantan Utara has been translated to ignore, because in gadm it is part of Kalimantan Timur
# Here I put geometry bps
schema_idn_faoDatalab_01 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 6) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 10,
            key = 11, value = "Hectares") %>%
  setObsVar(name = "production", unit = "t", columns = 10,
            key = 11, value = "Metric Tonnes")

regTable(nation = "idn",
         level = 2,
         subset = "crops",
         dSeries = ds[1],
         gSeries = gs[2],
         schema = schema_idn_faoDatalab_01,
         begin = 1993,
         end = 2019,
         archive = "Indonesia - Sub-National Level 1.csv",
         archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Indonesia%20-%20Sub-National%20Level%201.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Indonesia.pdf",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


# bps ----
## level 1 ----
schema_idn_l1_00 <-
  setIDVar(name = "al1", value = "Indonesia") %>%
  setIDVar(name = "year", columns = c(2:22), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1)

schema_idn_l1_01 <- schema_idn_l1_00 %>%
  setObsVar(name = "planted", unit = "ha", factor = 1000, columns = c(2:22))

regTable(nation = "idn",
         level = 1,
         subset = "planted",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l1_01,
         begin = 2000,
         end = 2020,
         archive = "planted_l1_2000_2020.xls",
         archiveLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l1_02 <- schema_idn_l1_00 %>%
  setIDVar(name = "year", columns = c(2:27), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:27))

regTable(nation = "idn",
         level = 1,
         subset = "production",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l1_02,
         begin = 1995,
         end = 2020,
         archive = "production_l1.xls",
         archiveLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


## level 2 ----
schema_idn_l2_00 <-
  setFilter(rows = .find("INDONESIA", col = 1, invert = TRUE)) %>%
  setIDVar(name = "al2", columns = 1)

schema_idn_l2_01 <- schema_idn_l2_00 %>%
  setIDVar(name = "year", columns = c(2:243), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:243), rows = 1, split = ".*(?=Population)") %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:243))

regTable(nation = "idn",
         level = 2,
         subset = "livestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_01,
         begin = 2000,
         end = 2021,
         archive = "Livestock_level_2_2000_2021.xls",
         archiveLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_02 <- schema_idn_l2_00 %>%
  setIDVar(name = "year", columns = c(2:484), rows = 3) %>%
  setIDVar(name = "commodities", columns = .find(is.character, row = 2), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:162)) %>%
  setObsVar(name = "production", unit = "t", columns = c(163:323)) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(324:484))

regTable(nation = "idn",
         level = 2,
         subset = "prodHarvestYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_02,
         begin = 1993,
         end = 2015,
         archive = "prodHarvestYield_1993_2015.xls",
         archiveLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_03 <- schema_idn_l2_00 %>%
  setIDVar(name = "year", columns = c(2:13), rows = 3) %>%
  setIDVar(name = "commodities", value = "paddy") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(10:13)) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:5)) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(6:9))

regTable(nation = "idn",
         level = 2,
         subset = "paddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_03,
         begin = 2018,
         end = 2021,
         archive = "paddy2018_2021.xls",
         archiveLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)
#
# schema_idn_l2_04 <- schema_idn_l2_00 %>%
#   setIDVar(name = "year", columns = c(2:73), rows = 3) %>%
#   setIDVar(name = "commodities", columns = c(2:73), rows = 2) %>%
#   setObsVar(name = "production", unit = "n", columns = c(2:73))
#
# regTable(nation = "idn",
#          level = 2,
#          subset = "prodTree",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l2_04,
#          begin = 1997,
#          end = 2020,
#          archive = "prodTrees.xls",
#          archiveLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)

schema_idn_l2_05 <- schema_idn_l2_00 %>%
  setIDVar(name = "year", columns = c(2:215), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:215), rows = 2, split = ".*(?=\\()") %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:215))

regTable(nation = "idn",
         level = 2,
         subset = "production01",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_05,
         begin = 1997,
         end = 2020,
         archive = "production_kg_1997_2020.xls",
         archiveLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_06 <- schema_idn_l2_00 %>%
  setIDVar(name = "year", columns = c(2:529), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:529), rows = 2, split = ".*(?=\\()") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:529))

regTable(nation = "idn",
         level = 2,
         subset = "production02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_06,
         begin = 1997,
         end = 2020,
         archive = "production02.xls",
         archiveLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_07 <- schema_idn_l2_00 %>%
  setIDVar(name = "year", columns = c(2:625), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:625), rows = 2, split = ".*(?=\\()") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:625))

regTable(nation = "idn",
         level = 2,
         subset = "production03",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_07,
         begin = 1997,
         end = 2020,
         archive = "production03.xls",
         archiveLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_08 <- schema_idn_l2_00 %>%
  setIDVar(name = "year", columns = c(2:81), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:81), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", factor = 1000, columns = c(2:81))

regTable(nation = "idn",
         level = 2,
         subset = "planted",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_08,
         begin = 2011,
         end = 2020,
         archive = "plantation_area_l2_2011_2020.xls",
         archiveLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_09 <- schema_idn_l2_00 %>%
  setIDVar(name = "year", columns = c(2:97), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:97), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 1000, columns = c(2:97))

regTable(nation = "idn",
         level = 2,
         subset = "production04",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_09,
         begin = 2009,
         end = 2020,
         archive = "plantation_production_2009_2020.xls",
         archiveLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_10 <- schema_idn_l2_00 %>%
  setIDVar(name = "year", columns = c(2:14), rows = 2) %>%
  setIDVar(name = "commodities", value = "wetland") %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:14))

regTable(nation = "idn",
         level = 2,
         subset = "wetland",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_10,
         begin = 2003,
         end = 2015,
         archive = "wetland_l2_2003_2015.xls",
         archiveLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_11 <- schema_idn_l2_00 %>%
  setIDVar(name = "year", columns = c(2:14), rows = 2) %>%
  setIDVar(name = "commodities", value = "forest") %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:14))

regTable(nation = "idn",
         level = 2,
         subset = "forestConcession",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_11,
         begin = 2004,
         end = 2017,
         archive = "forest_concession_2004_2017.xls",
         archiveLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_12 <-
  setFilter(rows = .find("Jenis..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", value = "Jawa Barat") %>%
  setIDVar(name = "year", columns = c(2:7), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1)

schema_idn_l2_12_01 <- schema_idn_l2_12 %>%
  setObsVar(name = "planted", unit = "ha", factor = 0.0001, columns = c(2:7))

regTable(nation = "idn",
         level = 2,
         subset = "JawaBaratBiopharmaCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_12_01,
         begin = 2015,
         end = 2020,
         archive = "JawaBaratBiopharmaCrop_2015_2020.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_12_02 <- schema_idn_l2_12 %>%
  setIDVar(name = "year", columns = c(2:6), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:6))

regTable(nation = "idn",
         level = 2,
         subset = "JawaBaratfruit",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_12_02,
         begin = 2016,
         end = 2020,
         archive = "JawaBaratFruitsProd16-20.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_12_03 <- schema_idn_l2_12 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:7))

regTable(nation = "idn",
         level = 2,
         subset = "JawaBaratVeg",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_12_03,
         begin = 2015,
         end = 2020,
         archive = "JawaBaratVegHarvest2015_2020.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_13 <- setCluster(id = "al2", left = 2, top = 3, height = 5) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al2", value = "Jawa Barat") %>%
  setIDVar(name = "year", value = "2016") %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = 3)

regTable(nation = "idn",
         level = 2,
         subset = "JawaBaratForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_13,
         begin = 2016,
         end = 2016,
         archive = "JawaBaratForestry16.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_13_00 <- schema_idn_l2_13 %>%
  setIDVar(name = "year", value = "2019") %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "area", unit = "ha", columns = 2)

regTable(nation = "idn",
         level = 2,
         subset = "JawaBaratForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_13_00,
         begin = 2019,
         end = 2019,
         archive = "JawaBaratForestry19.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_14 <- setCluster(id = "al2", left = 1, top = 5, height = 27) %>%
  setFilter(rows = .find("Jamur..", col = 1), invert = TRUE) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al2", value = "Jawa Tengah") %>%
  setIDVar(name = "year", columns = c(3:4), rows = 4) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(3:4))

regTable(nation = "idn",
         level = 2,
         subset = "JawaTengahVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_14,
         begin = 2018,
         end = 2019,
         archive = "JawaTengahFruitsVegiesHarv18-19.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_15 <- setCluster(id = "al2", left = 2, top = 5, height = 27) %>%
  setIDVar(name = "al2", value = "Jawa Tengah") %>%
  setIDVar(name = "year", columns = c(4:9), rows = 5) %>%
  setIDVar(name = "commodities", columns = 2, split = "(?<=/).*")

schema_idn_l2_15_00 <- schema_idn_l2_15 %>%
  setFilter(rows = .find("Jamur..", col = 2), invert = TRUE) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(4:9))

regTable(nation = "idn",
         level = 2,
         subset = "JawaTengahVegHarv02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_15_00,
         begin = 2010,
         end = 2015,
         archive = "JawaTengahVegiesFruitsHarv10-15.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_15_01 <- schema_idn_l2_15 %>%
  setFilter(rows = .find("Jamur..", col = 2)) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(4:9))

regTable(nation = "idn",
         level = 2,
         subset = "JawaTengahMushHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_15_01,
         begin = 2010,
         end = 2015,
         archive = "JawaTengahVegiesFruitsHarv10-15.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_15_02 <- schema_idn_l2_15 %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(4:9))

regTable(nation = "idn",
         level = 2,
         subset = "JawaTengahVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_15_02,
         begin = 2010,
         end = 2015,
         archive = "JawaTengahVegiesFruitsProd10-15.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_15_03 <- schema_idn_l2_15 %>%
  setCluster(id = "al2", left = 2, top = 5, height = 16) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(4:9))

regTable(nation = "idn",
         level = 2,
         subset = "JawaTengahMedProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_15_03,
         begin = 2010,
         end = 2015,
         archive = "JawaTengahMedicalPlantsProd10-15.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_16 <-
  setIDVar(name = "al2", value = "Jawa Timur") %>%
  setIDVar(name = "year", columns = c(2:12), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1)

schema_idn_l2_16_01 <- schema_idn_l2_16 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:12), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "JawaTimurLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_17_01,
         begin = 2006,
         end = 2016,
         archive = "JawaTimurLivestock2006-2016.xls",
         archiveLink = "https://jatim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jatim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_16_02 <- schema_idn_l2_16 %>%
  setIDVar(name = "year", columns = c(2:28), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:10), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(11:19), top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = c(20:28), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "JawaTimurHarvProdyield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_16_02,
         begin = 2009,
         end = 2017,
         archive = "JawaTimurFoodCropsHarvProdYield09-17.xls",
         archiveLink = "https://jatim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jatim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_16_03 <- schema_idn_l2_16 %>%
  setIDVar(name = "year", columns = c(2:25), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:9), top = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(10:17), top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 10000, columns = c(18:25), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "JawaTimurMedHarvProdyield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_16_03,
         begin = 2009,
         end = 2016,
         archive = "JawaTimurMedPlanHarvProdYield09-16.xls",
         archiveLink = "https://jatim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jatim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_17 <-
  setIDVar(name = "al2", value = "Kalimantan Barat") %>%
  setIDVar(name = "year", columns = c(2:8), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1)

schema_idn_l2_17_01 <- schema_idn_l2_17 %>%
  setObsVar(name = "production", unit = "t", columns = c(2:8), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "KalimanBaratFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_17_01,
         begin = 2015,
         end = 2021,
         archive = "KalimanBaratFruitProd15-21.xls",
         archiveLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_17_02 <- schema_idn_l2_17 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:7), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "KalimanBaratFruitHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_17_02,
         begin = 2015,
         end = 2021,
         archive = "KalimanBaratFruitHarv15-21.xls",
         archiveLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_18 <-
  setIDVar(name = "al2", value = "Kalimantan Timur") %>%
  setIDVar(name = "year", columns = c(2:7), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:4), top = 1) %>%
  setObsVar(name = "production", unit = "ha", factor = 0.1, columns = c(5:7), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "KalimanTimurFruitVeg",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_19,
         begin = 2018,
         end = 2020,
         archive = "KalimanTimurFruitVeg18-20.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "hhttps://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_19 <-
  setIDVar(name = "al2", value = "Kalimantan Timur") %>%
  setIDVar(name = "year", columns = c(2:7), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:4), top = 1) %>%
  setObsVar(name = "production", unit = "ha", factor = 0.001, columns = c(5:7), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "KalimanTimurMedPLants",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_19,
         begin = 2018,
         end = 2020,
         archive = "KalimanTimurMedPlants18-20.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "hhttps://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_20 <- setCluster(id = "al2", left = 1, top = 7) %>%
  setIDVar(name = "al2", value = "Kalimantan Timur") %>%
  setIDVar(name = "year", columns = c(2:6), rows = 4) %>%
  setIDVar(name = "commodities", columns = 1)

schema_idn_l2_20_01 <- schema_idn_l2_20 %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:6))

regTable(nation = "idn",
         level = 2,
         subset = "KalimanTimurVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_20_01,
         begin = 2011,
         end = 2015,
         archive = "KalimantanTimurVegiesHarv11-15.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "hhttps://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_20_02 <- schema_idn_l2_20_01 %>%
  setCluster(id = "al2", left = 1, top = 7, height = 7)

regTable(nation = "idn",
         level = 2,
         subset = "KalimanTimurCropsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_20_02,
         begin = 2011,
         end = 2015,
         archive = "KalimantanTimurFoodCropsProd11-15.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "hhttps://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_20_03 <- schema_idn_l2_20 %>%
  setObsVar(name = "production", unit = "t", columns = c(2:6))

regTable(nation = "idn",
         level = 2,
         subset = "KalimanTimurVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_20_03,
         begin = 2011,
         end = 2015,
         archive = "KalimantanTimurVegiesProd11-15.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "hhttps://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "KalimanTimurFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_20_03,
         begin = 2011,
         end = 2015,
         archive = "KalimantanTimurFruitsProd11-15.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "hhttps://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_21 <-
  setIDVar(name = "al2", value = "Kalimantan Utara") %>%
  setIDVar(name = "year", columns = c(2:7), rows = 1) %>%
  setIDVar(name = "commodities", columns = 1)

schema_idn_l2_21_01 <- schema_idn_l2_21 %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2, 4, 6), top = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(3, 5, 7), top = 2)

regTable(nation = "idn",
         level = 2,
         subset = "KalimanUtaraMedPlantsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_21_01,
         begin = 2018,
         end = 2020,
         archive = "KalimanUtaraMedPlantsHarvProdLevel2-18-20.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.htmll",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_21_02 <- schema_idn_l2_21 %>%
  setIDVar(name = "year", columns = c(2:4), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:4), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "KalimanUtaraOrnPlantsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_21_02,
         begin = 2018,
         end = 2020,
         archive = "KalimanUtaraOrnPlanstHarvLevel2-18-20.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.htmll",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_21_03 <- schema_idn_l2_21 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:4), top = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(5:7), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "KalimanUtaraVegFruitHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_21_03,
         begin = 2018,
         end = 2020,
         archive = "KalimanUtaraVegFruitHarvLevel2-Prod18-20.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.htmll",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_22 <-setCluster(id = "al2", left = 1, top = 6) %>%
  setFilter(rows = .find("..Jagung|..Ubi|..Kacang|.. Kedelai", col = 1)) %>%
  setIDVar(name = "al2", value = "Kalimantan Utara") %>%
  setIDVar(name = "year", columns = c(2:6), rows = 4, split = "^\\d.*(?=\\*)") %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:6))

regTable(nation = "idn",
         level = 2,
         subset = "KalimanUtaraCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_22,
         begin = 2009,
         end = 2013,
         archive = "KalimantanUtaraFoodCropsProd09-13.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.htmll",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_23 <-setCluster(id = "al2", left = 1, top = 6) %>%
  setFilter(rows = .find("^\\d", col = 1)) %>%
  setIDVar(name = "al2", value = "Kalimantan Utara") %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<!,)\\d.*") %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 2)

regTable(nation = "idn",
         level = 2,
         subset = "KalimanUtaraVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_23,
         begin = 2013,
         end = 2013,
         archive = "KalimantanUtaraVegiesHarv13.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.htmll",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_24 <-setCluster(id = "al2", left = 1, top = 6) %>%
  setFilter(rows = .find("^\\d", col = 2)) %>%
  setIDVar(name = "al2", value = "Kalimantan Utara") %>%
  setIDVar(name = "year", columns = c(2, 3), rows = 4) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 3))

regTable(nation = "idn",
         level = 2,
         subset = "KalimanUtaraFoodCropsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_24,
         begin = 2012,
         end = 2013,
         archive = "KalimantanUtraraFoodCropsHarv12-13.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.htmll",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_25 <-
  setIDVar(name = "al2", value = "Kepulauan Riau") %>%
  setIDVar(name = "year", columns = c(2:4), rows = 2) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:4),
            key = 1, value = "Luas Panen (ha)") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:4),
            key = 1, value = "Produksi (ton)") %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(2:4),
            key = 1, value = "Produktivitas (ku/ha)")

regTable(nation = "idn",
         level = 2,
         subset = "KepulanMaizePlanttProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_25,
         begin = 2013,
         end = 2015,
         archive = "KepulauanRiauMaizeHarvProdYield13-15.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "KepulanSoyPlanttProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_25,
         begin = 2013,
         end = 2015,
         archive = "KepulauanRiauSoyHarvProdYield13-15.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "KepulanWetPaddyPlanttProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_25,
         begin = 2013,
         end = 2015,
         archive = "KepulauanRiauWetPaddyHarvProdYield13-15.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_26 <-
  setFilter(rows = .find("Jenis Unggas", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", value = "Lampung Barat") %>%
  setIDVar(name = "year", columns = c(2:11), rows = 3) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:11), top = 2)

regTable(nation = "idn",
         level = 2,
         subset = "LampungPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_26,
         begin = 2005,
         end = 2014,
         archive = "LampungPoultry05-14.xls",
         archiveLink = "https://lampung.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://lampung.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_26_01 <- schema_idn_l2_26 %>%
  setIDVar(name = "year", columns = c(2:14), rows = 3) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:14), top = 2)

regTable(nation = "idn",
         level = 2,
         subset = "LampungLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_26_01,
         begin = 2005,
         end = 2014,
         archive = "LampungLivestockTotal05-18.xls",
         archiveLink = "https://lampung.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://lampung.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_27 <-
  setIDVar(name = "al2", value = "Lampung Barat") %>%
  setIDVar(name = "year", columns = c(2:6), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:6), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "LampungForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_27,
         begin = 2014,
         end = 2018,
         archive = "LampungForestry14-18.xls",
         archiveLink = "https://lampung.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://lampung.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_28 <-
  setIDVar(name = "al2", value = "Maluku") %>%
  setIDVar(name = "year", columns = c(2:11), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:6), top = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(7:11), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "MalukuVegFruitHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_28,
         begin = 2012,
         end = 2016,
         archive = "MalukuVegiesFruitsHarvProdSubDis12-16.xls",
         archiveLink = "https://maluku.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://maluku.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_29 <-
  setIDVar(name = "al2", value = "Maluku") %>%
  setIDVar(name = "year", columns = 2, rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 2, top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = 3, top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = 4, top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "MalukuCropsHarvProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_29,
         begin = 2013,
         end = 2013,
         archive = "MalukuCropsHarvProdYield13.xls",
         archiveLink = "https://maluku.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://maluku.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_30 <-
  setIDVar(name = "al2", value = "Maluku") %>%
  setIDVar(name = "year", columns = c(2:6), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:6), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "MalukuFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_30,
         begin = 2012,
         end = 2016,
         archive = "MalukuFruitsProdSubDis12-16.xls",
         archiveLink = "https://maluku.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://maluku.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_31 <-
  setIDVar(name = "al2", value = "Maluku") %>%
  setIDVar(name = "year", columns = 2, rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", columns = 2, top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "MalukuFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_31,
         begin = 2013,
         end = 2013,
         archive = "MalukuFruitsProdSubDis13.xls",
         archiveLink = "https://maluku.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://maluku.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_32 <-
  setIDVar(name = "al2", value = "Nusa Timur") %>%
  setIDVar(name = "year", columns = c(2:5), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1)

schema_idn_l2_32_01 <- schema_idn_l2_32 %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:5), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "NusaTimurFruitHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_32_01,
         begin = 2017,
         end = 2020,
         archive = "NusaTenggaraTimurFruitHarvestLEVEL217-20.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "NusaTimurVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_32_01,
         begin = 2017,
         end = 2020,
         archive = "NusaTenggaraTimurVegHarvestLEVEL217-20.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_32_02 <- schema_idn_l2_32 %>%
  setIDVar(name = "year", columns = c(2:10), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:10), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "NusaTimurFruitProd01",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_32_02,
         begin = 2013,
         end = 2021,
         archive = "NusaTenggaraTimurFruitProdLEVEL2-13-21.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "NusaTimurFruitProd02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_32_02,
         begin = 2013,
         end = 2021,
         archive = "NusaTenggaraTimurFruitProdLEVEL213-21.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_32_03 <- schema_idn_l2_32 %>%
  setIDVar(name = "year", columns = c(2:5), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:5), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "NusaTimurMedHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_33_03,
         begin = 2017,
         end = 2020,
         archive = "NusaTenggaraTimurMedHarvestLEVEL217-20.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_32_04 <- schema_idn_l2_32 %>%
  setIDVar(name = "year", columns = c(2:10), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:10), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "NusaTimurMedProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_32_04,
         begin = 2013,
         end = 2021,
         archive = "NusaTenggaraTimurMedProdLEVEL213-21.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_32_05 <- schema_idn_l2_32 %>%
  setIDVar(name = "year", columns = c(2:6), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:6), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "NusaTimurOrnHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_32_05,
         begin = 2015,
         end = 2020,
         archive = "NusaTenggaraTimurOrnHarvestLEVEL2-15-20.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_32_06 <- schema_idn_l2_32 %>%
  setIDVar(name = "year", columns = c(2:8), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:8), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "NusaTimurVegProd01",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_32_06,
         begin = 2013,
         end = 2020,
         archive = "NusaTenggaraTimurVegProdLEVEL2-13-20.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_32_07 <- schema_idn_l2_32 %>%
  setIDVar(name = "year", columns = c(2:9), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:9), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "NusaTimurVegProd02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_32_07,
         begin = 2013,
         end = 2021,
         archive = "NusaTenggaraTimurVegProdLEVEL2-13-21.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_33 <-
  setIDVar(name = "al2", value = "Riau") %>%
  setIDVar(name = "year", columns = c(2:5), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1)

schema_idn_l2_33_01 <- schema_idn_l2_33 %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:5), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "RiauMedHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_33_01,
         begin = 2016,
         end = 2019,
         archive = "RiauMedPlantsHarvLEVEL2-2016-2019.xls",
         archiveLink = "https://riau.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://riau.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "RiauOrnHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_33_01,
         begin = 2016,
         end = 2019,
         archive = "RiauOrnPlantsHarvLEVEL2-2016-2019.xls",
         archiveLink = "https://riau.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://riau.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_33_02 <- schema_idn_l2_33 %>%
  setIDVar(name = "year", columns = c(2:6), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:6), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "RiauMedProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_33_02,
         begin = 2016,
         end = 2020,
         archive = "RiauMedPlantsProdLEVEL2-2016-2020.xls",
         archiveLink = "https://riau.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://riau.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_33_03 <- schema_idn_l2_33 %>%
  setIDVar(name = "year", columns = c(2:5), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:5), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "RiauVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_33_03,
         begin = 2016,
         end = 2019,
         archive = "RiauVegHarvLEVEL2-2016-2019.xls",
         archiveLink = "https://riau.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://riau.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# Based on other tables with Medicinal plants, I put factors here as well.
schema_idn_l2_34 <- setCluster(id = "al2", left = 1, top = 2) %>%
  setFilter(rows = .find("Sulawesi..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 19) %>%
  setIDVar(name = "year", columns = c(2:5), rows = 3) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(4:5), top = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:3), top = 2)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiBaratMedHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_34,
         begin = 2017,
         end = 2018,
         archive = "SulawesiBaratMedicalPlantsHarvProd17-18.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_35 <-
  setFilter(rows = .find("Sulawesi..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 29) %>%
  setIDVar(name = "year", columns = c(2:3), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:3), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiBaratVegFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_35,
         begin = 2017,
         end = 2018,
         archive = "SulawesiBaratVegiesFruitsProd17-18.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_36 <- setCluster(id = "al2", left = 1, top = 2) %>%
  setFilter(rows = .find("Sulawesi..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 33) %>%
  setIDVar(name = "year", columns = c(2:5), rows = 3) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:3), top = 2) %>%
  setObsVar(name = "harvested", unit = "t", columns = c(4:5), top = 2)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiBaratVegFruitProdHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_36,
         begin = 2017,
         end = 2018,
         archive = "SulawesiBaratVegiesFruitsProd17-18.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_37 <- setCluster(id = "al2", left = 1, top = 22, height = 6) %>%
  setFormat(flags = data.frame(flag = "r)", value = "Provisional")) %>%
  setIDVar(name = "al2", columns = 1, rows = 22) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(4, 5), rows = 5) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(4:5))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_37,
         begin = 2010,
         end = 2014,
         archive = "SulawesiTengahPoultrySubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/318/populasi-unggas-ekor-menurut-kabupaten-kota-dan-jenisnya-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

 schema_idn_l2_38 <-setCluster(id = "al2", left = 2, top = 20, height = 6) %>%
   setFormat(flags = data.frame(flag = "r)", value = "Provisional")) %>%
   setIDVar(name = "al2", columns = 1, rows = 20) %>%
   setIDVar(name = "year", columns = 1) %>%
   setIDVar(name = "commodities", columns = c(2:4), rows = 5) %>%
   setObsVar(name = "headcount", unit = "n", columns = c(2:4))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_38,
         begin = 2010,
         end = 2014,
         archive = "SulawesiTengahSmallLivestockSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/319/populasi-ternak-kecil-ekor-menurut-kabupaten-kota-dan-jenisnya-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_39 <- setCluster(id = "al2", left = 2, top = 20, height = 6) %>%
  setIDVar(name = "al2", columns = 1, rows = 20) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(2:4), rows = 5) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:4))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahLivestock02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_39,
         begin = 2010,
         end = 2014,
         archive = "SulawesiTengahLargeLivestockSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/320/populasi-ternak-besar-ekor-menurut-kabupaten-kota-dan-jenisnya-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_40 <- setCluster(id = "al2", left = 2, top = 23) %>%
  setIDVar(name = "al2", columns = 1, rows = 23) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 1, rows = 2, split = "(?<=of).*(?=,)")

schema_idn_l2_40_01 <- schema_idn_l2_40 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 2) %>%
  setObsVar(name = "production", unit = "t", columns = 3) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor =  100, columns = 4)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahCassava",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_40_01,
         begin = 2010,
         end = 2014,
         archive = "SulawesiTengahCassavaHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/307/luas-panen-hasil-per-hektar-dan-produksi-ubi-kayu-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahMaize",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_40_01,
         begin = 2010,
         end = 2014,
         archive = "SulawesiTengahMaizeHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/306/luas-panen-hasil-per-hektar-dan-produksi-jagung-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahGreenPeanuts",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_40_01,
         begin = 2010,
         end = 2014,
         archive = "SulawesiTengahGreenPeanutsHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/311/luas-panen-hasil-per-hektar-dan-produksi-kacang-hijau-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahSoy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_40_01,
         begin = 2010,
         end = 2014,
         archive = "SulawesiTengahSoyHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/310/luas-panen-hasil-per-hektar-dan-produksi-kacang-kedelai-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_40_01,
         begin = 2010,
         end = 2014,
         archive = "SulawesiTengahDryWetPaddyHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/305/luas-panen-hasil-per-hektar-dan-produksi-padi-sawah-dan-ladang-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_40_02 <- schema_idn_l2_40_01 %>%
  setCluster(id = "al2", left = 2, top = 24) %>%
  setIDVar(name = "al2", columns = 1, rows = 24)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahPeanut",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_40_02,
         begin = 2010,
         end = 2014,
         archive = "SulawesiTengahPeanutsHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/309/luas-panen-hasil-per-hektar-dan-produksi-kacang-tanah-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahSweetPotato",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_40_02,
         begin = 2010,
         end = 2014,
         archive = "SulawesiTengahSweetPotatoeHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/308/luas-panen-hasil-per-hektar-dan-produksi-ubi-jalar-2010---2014-.htmll",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_41 <- setCluster(id = "al2", left = 1, top = 26, height = 6) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "al2", columns = 1, rows = 26) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(2:72), rows = 5) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 6, 10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50, 54, 58, 62, 66, 70)) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 7, 11, 15, 19, 23, 27, 31, 35, 39, 43, 47, 51, 55, 59, 63, 67, 71)) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor =  100, columns = c(4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahVeg",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_41,
         begin = 2010,
         end = 2014,
         archive = "SulawesiTengahVegiesHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_42 <- setCluster(id = "al2", left = 1, top = 26, height = 6) %>%
  setIDVar(name = "al2", columns = 1, rows = 26) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(2:36), rows = 6) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35)) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahPlantationCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_42,
         begin = 2010,
         end = 2014,
         archive = "SulawesiTengahPlantationCropsPlanProdSmallSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_42_01 <- schema_idn_l2_42 %>%
  setCluster(id = "al2", left = 1, top = 25, height = 6) %>%
  setIDVar(name = "al2", columns = 1, rows = 25) %>%
  setIDVar(name = "commodities", columns = c(2:12), rows = 5) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 8, 11)) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 6, 9, 12))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahPlantationCropsLarge",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_42_01,
         begin = 2010,
         end = 2014,
         archive = "SulawesiTengahPlantationCropsPlanProdSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_43 <- setCluster(id = "al2", left = 1, top = 26, height = 6) %>%
  setIDVar(name = "al2", columns = 1, rows = 26) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 7, rows = 6) %>%
  setObsVar(name = "area", unit = "ha", columns = 7)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_43,
         begin = 2010,
         end = 2014,
         archive = "SulawesiTengahForestSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_44 <- setCluster(id = "al2", left = 1, top = 10) %>%
  setIDVar(name = "al2", value = "Sulawesi Tengah") %>%
  setIDVar(name = "year", columns = 1, rows = 2, split = "(?<=s,).*") %>%
  setIDVar(name = "commodities", columns = 2, split = "(?<=/).*") %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = 4)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahFruit",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_44,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTengahFruitsProd14.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_44_01 <- schema_idn_l2_44 %>%
  setCluster(id = "al2", left = 1, top = 6, height = 24)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahFruit",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_44_01,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTengahFruitsProd15.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_44_02 <- schema_idn_l2_44 %>%
  setCluster(id = "al2", left = 1, top = 9, height = 24)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengahFruit",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_44_02,
         begin = 2016,
         end = 2016,
         archive = "SulawesiTengahFruitsProd16.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_45 <- setCluster(id = "al2", left = 1, top = 15, height = 7) %>%
  setIDVar(name = "al2", columns = 1, rows = 15) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(2:4), rows = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:4))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_45,
         begin = 2006,
         end = 2011,
         archive = "SulawesiTenggaraLivestockSubDis11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1819/populasi-ternak-besar-menurut-kabupaten-kota-ekor-2012.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_45_01 <- schema_idn_l2_45 %>%
  setCluster(id = "al2", left = 1, top = 17, height = 8) %>%
  setIDVar(name = "al2", columns = 1, rows = 17) %>%
  setIDVar(name = "commodities", columns = c(2:4), rows = 3)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraLivestock02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_45_01,
         begin = 2006,
         end = 2012,
         archive = "SulawesiTenggaraSmallLivestockSubDis12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1820/populasi-ternak-kecil-menurut-kabupaten-kota-ekor-2012.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_45_02 <- schema_idn_l2_45 %>%
  setIDVar(name = "commodities", columns = c(2:5), rows = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:5))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_45_02,
         begin = 2011,
         end = 2011,
         archive = "SulawesiTenggaraPoultrySubDis11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/16/2442/populasi-ternak-unggas-menurut-kabupaten-kota-ekor-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_46 <- setCluster(id = "al2", left = 1, top = 4, height = 16) %>%
  setIDVar(name = "al2", value = "Sulawesi Tengarra") %>%
  setIDVar(name = "year", columns = c(3:4), rows = 3) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(3:4))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_46,
         begin = 2014,
         end = 2015,
         archive = "SulawesiTenggaraLivestock14-15.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/01/29/379/populasi-ternak-menurut-jenis-ternak-di-provinsi-sulawesi-tenggara-ekor-2014-2015.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_46_01 <- schema_idn_l2_46 %>%
  setCluster(id = "al2", left = 1, top = 3, height = 16)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_46_01,
         begin = 2016,
         end = 2017,
         archive = "SulawesiTenggaraLivestock16-17.xls",
         archiveLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_47 <-
  setFilter(rows = .find("Jamur", col = 2), invert = TRUE) %>%
  setIDVar(name = "al2", value = "Sulawesi Tengarra") %>%
  setIDVar(name = "year", columns = c(3:7), rows = 1) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(3:7))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraVegFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_47,
         begin = 2014,
         end = 2018,
         archive = "SulawesiTenggaraVegiesFruitsProd14-18.xls",
         archiveLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_47_01 <- schema_idn_l2_47 %>%
  setFilter(rows = .find("Jamur", col = 2)) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(3:7))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraJamurProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_47_01,
         begin = 2014,
         end = 2018,
         archive = "SulawesiTenggaraVegiesFruitsProd14-18.xls",
         archiveLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_48 <- setCluster(id = "al2", left = 2, top = 3) %>%
  setFormat(thousand = ",") %>%
  setFilter(rows = .find("Jamur", col = 2), invert = TRUE) %>%
  setIDVar(name = "al2", value = "Sulawesi Tengarra") %>%
  setIDVar(name = "year", columns = c(3:7), rows = 3) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(3:7))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraVegFruitHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_48,
         begin = 2014,
         end = 2018,
         archive = "SulawesiTenggaraVegiesFruitsHarv14-18.xls",
         archiveLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_48_01 <- schema_idn_l2_48 %>%
  setFilter(rows = .find("Jamur", col = 2)) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(3:7))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraJamurHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_48_01,
         begin = 2014,
         end = 2018,
         archive = "SulawesiTenggaraVegiesFruitsHarv14-18.xls",
         archiveLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_49 <- setCluster(id = "al2", left = 1, top = 3) %>%
  setFilter(rows = .find("Jamur..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", value = "Sulawesi Tengarra") %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 3)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraVegFruitHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_49,
         begin = 2019,
         end = 2019,
         archive = "SulawesiTenggaraVegiesFruitsPlantsHarvSubDis19.xls",
         archiveLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_49_01 <- schema_idn_l2_49 %>%
  setFilter(rows = .find("Jamur", col = 1)) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = 3)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraJamurHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_49_01,
         begin = 2019,
         end = 2019,
         archive = "SulawesiTenggaraVegiesFruitsPlantsHarvSubDis19.xls",
         archiveLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_50 <- setCluster(id = "al2", left = 1, top = 3, height = 9) %>%
  setIDVar(name = "al2", value = "Sulawesi Tengarra") %>%
  setIDVar(name = "year", columns = c(2:7), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 5)) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(3, 6)) %>%
  setObsVar(name = "production", unit = "t", columns = c(4, 7))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_50,
         begin = 2010,
         end = 2011,
         archive = "SulawesiTenggaraFoodCropsHarvProdYield10-11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/12/2336/luas-panen-hasil-perhektar-dan-produksi-tanaman-bahan-makanan-2010-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_51 <- setCluster(id = "al2", left = 2, top = 5) %>%
  setIDVar(name = "al2", value = "Sulawesi Tengarra") %>%
  setIDVar(name = "year", columns = c(7, 8), rows = 5) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(7, 8))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraFruitVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_51,
         begin = 2016,
         end = 2017,
         archive = "SulawesiTenggaraFruitsVegiesProd16-17.xls",
         archiveLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_51_01 <- schema_idn_l2_51 %>%
  setFilter(rows = .find("God'..|Noni", col = 2), invert = TRUE) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(7, 8))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraMedPlantsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_51_01,
         begin = 2016,
         end = 2017,
         archive = "SulawesiTenggaraMedicalPlantsHarvProd16-17.xls",
         archiveLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_52 <- setCluster(id = "al2", left = 1, top = 4, height = 25) %>%
  setFilter(rows = .find("Palem", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", value = "Sulawesi Teggara") %>%
  setIDVar(name = "year", columns = c(2:6), rows = 3) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:6))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraOrnPlantsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_52,
         begin = 2014,
         end = 2018,
         archive = "SulawesiTenggaraOrnamentalHarv14-18.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/12/2356/produksi-sayur-sayuran-yang-dipanen-sekaligus-menurut-jenisnya-dan-kabupaten-kota-kuintal-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_53 <- setCluster(id = "al2", left = 1, top = 4, height = 22) %>%
  setIDVar(name = "al2", value = "Sulawesi Teggara") %>%
  setIDVar(name = "year",  columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = 5)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraPlantCropsPant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_53,
         begin = 2012,
         end = 2012,
         archive = "SulawesiTenggaraPlantaitonCropsPlan12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/12/2356/produksi-sayur-sayuran-yang-dipanen-sekaligus-menurut-jenisnya-dan-kabupaten-kota-kuintal-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraPlantCropsPant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_53,
         begin = 2013,
         end = 2013,
         archive = "SulawesiTenggaraPlantaitonCropsPlan13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1672/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-sulawesi-tenggara-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_53_01 <- schema_idn_l2_53 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 24)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraPlantCropsPant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_53_01,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTenggaraPlantationCropsPlan14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/816/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-sulawesi-tenggara-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_54 <- setCluster(id = "al2", left = 1, top = 3, height = 21) %>%
  setIDVar(name = "al2", value = "Sulawesi Teggara") %>%
  setIDVar(name = "year",  columns = c(3:8), rows = 3) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(3:8))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_54,
         begin = 2010,
         end = 2015,
         archive = "SulawesiTenggaraPlantaitonCropsProd10-15.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/01/29/373/produksi-tanaman-perkebunan-menurut-jenis-tanaman-ton-2010-2015.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_54,
         begin = 2012,
         end = 2017,
         archive = "SulawesiTenggaraPlantationCropsProd12-17.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/03/1160/produksi-tanaman-perkebunan-menurut-jenis-tanaman-ton-2012-2017.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_54_01 <- schema_idn_l2_54 %>%
  setCluster(id = "al2", left = 1, top = 3, height = 19) %>%
  setIDVar(name = "year",  columns = c(3:7), rows = 3) %>%
  setObsVar(name = "production", unit = "t", columns = c(3:7))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_54_01,
         begin = 2013,
         end = 2017,
         archive = "SulawesiTenggaraPlantationCropsProdSmall13-17.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_55 <- setCluster(id = "al2", left = 2, top = 5, height = 27) %>%
  setFilter(rows = .find("Mushroom", col = 2), invert = TRUE) %>%
  setIDVar(name = "al2", value = "Sulawesi Tenggara") %>%
  setIDVar(name = "year", columns = c(4, 5, 7, 8), rows = 5) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(4, 5)) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(7, 8))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraFruitHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_55,
         begin = 2016,
         end = 2017,
         archive = "SulawesiTenggaraSeasonalFruitsVegiesProd16-17.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_55_01 <- schema_idn_l2_55 %>%
  setFilter(rows = .find("Mushroom", col = 2)) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(7, 8))

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiTengarraMushroomHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_55_01,
         begin = 2016,
         end = 2017,
         archive = "SulawesiTenggaraSeasonalFruitsVegiesProd16-17.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


# It is unclear what the unit for yield and production are.
# Usually yield is kw/ha and production is quintal for fruits.
schema_idn_l2_56 <- setCluster(id = "al2", left = 2, top = 3) %>%
  setIDVar(name = "al2", value = "Sulawesi Utara") %>%
  setIDVar(name = "year", columns = c(2:10), rows = 3) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:4), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = c(5:7), top = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(8:10), top = 2)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiUtaraFruitHarvProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_56,
         begin = 2014,
         end = 2016,
         archive = "SulawesiUtaraFruitsHarvProdYield14-16.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_56_01 <- schema_idn_l2_56 %>%
  setIDVar(name = "year", columns = c(2:13), rows = 3) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:5), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(6:9), top = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(10:13), top = 2)

regTable(nation = "idn",
         level = 2,
         subset = "SulawesiUtaraVegHarvProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_56_01,
         begin = 2014,
         end = 2017,
         archive = "SulawesiUtaraVegiesHarvProdYield14-16.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_57 <- setCluster(id = "al2", left = 3, top = 24, height = 6) %>%
  setIDVar(name = "al2", value = "Sumatera Selatan") %>%
  setIDVar(name = "year", columns = 3) %>%
  setIDVar(name = "commodities", columns = c(4:6), rows = 6) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(4:6))

regTable(nation = "idn",
         level = 2,
         subset = "SumateraSelatanLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_57,
         begin = 2010,
         end = 2014,
         archive = "SumateraSelatanLivestockSubDis14.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_58 <- setCluster(id = "al2", left = 2, top = 7, height = 24) %>%
  setIDVar(name = "al2", value = "Sumatera Selatan") %>%
  setIDVar(name = "year", columns = 3, rows = 4, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = 6)

regTable(nation = "idn",
         level = 2,
         subset = "SumateraSelatanFruit",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_58,
         begin = 2010,
         end = 2014,
         archive = "SumateraSelatanFruitsHarvProd14.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_60 <-
  setIDVar(name = "al2", value = "Bangla Belitung") %>%
  setIDVar(name = "year", columns = c(2:6), rows = 2) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1, split = "(?<=\\().*(?=\\))") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:6),
            key = 1, value = "Luas Panen (ha)") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:6),
            key = 1, value = "Produksi (ton)") %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = c(2:6),
            key = 1, value = "Produktivitas (ton/ha)")

regTable(nation = "idn",
         level = 2,
         subset = "BangkaBelitungCassava",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_60,
         begin = 2012,
         end = 2016,
         archive = "BangkaBelitungCassavaHarvestHarvProdYield12-16.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "BangkaBelitungCorn",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_60,
         begin = 2012,
         end = 2016,
         archive = "BangkaBelitungCornHarvestHarvProdYield12-16.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "BangkaBelitungPeanut",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_60,
         begin = 2012,
         end = 2016,
         archive = "BangkaBelitungPeanutHarvestHarvProdYield12-16.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "BangkaBelitungSweetPotato",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_60,
         begin = 2012,
         end = 2016,
         archive = "BangkaBelitungsweetPotatoHarvestHarvProdYield12-16.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_61 <-
  setIDVar(name = "al2", value = "Banten") %>%
  setIDVar(name = "year", columns = c(2:52), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1)

schema_idn_l2_61_01 <- schema_idn_l2_61 %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:18), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(19:35), top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(36:52), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "BantenCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_61_01,
         begin = 2005,
         end = 2021,
         archive = "BantenFoodCropsProdYieldHarv05-21.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "BantenFruitVeg02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_61_01,
         begin = 2005,
         end = 2021,
         archive = "BantenSeasonalFruitsVegiesHarvProd05-21.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_61_02 <- schema_idn_l2_61 %>%
  setIDVar(name = "year", columns = c(2:18), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:18), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "BantenFruitVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_61_02,
         begin = 2005,
         end = 2021,
         archive = "BantenFruitsVegiesProd05-21.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_61_03 <- schema_idn_l2_61 %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:18), top = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(19:35), top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 0.0001, columns = c(36:52), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "BantenMedCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_61_03,
         begin = 2005,
         end = 2021,
         archive = "BantenMedicalPlantsHarvProdYield05-21.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_61_04 <- schema_idn_l2_61 %>%
  setIDVar(name = "year", columns = c(2:18), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:18), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "BantenOrnCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_61_04,
         begin = 2005,
         end = 2021,
         archive = "BantenOrnamentalPlantsHarv05-21.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_61_05 <- schema_idn_l2_61 %>%
  setIDVar(name = "year", columns = c(2:14), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:14), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "BantenPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_61_05,
         begin = 2009,
         end = 2021,
         archive = "BantenPlantationCropsProd09-21.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_62 <- setCluster(id = "al2", left = 2, top = 7, height = 27) %>%
  setIDVar(name = "al2", value = "Bengkulu") %>%
  setIDVar(name = "year", columns = c(3:5), rows = 4) %>%
  setIDVar(name = "commodities", columns = 1)

schema_idn_l2_62_01 <- schema_idn_l2_62 %>%
  setFilter(rows = .find("m2", col = 2), invert = TRUE) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(3:5))

regTable(nation = "idn",
         level = 2,
         subset = "BengkuluFruitHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_62_01,
         begin = 2019,
         end = 2021,
         archive = "BengkuluFruitsVegHarv19-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/statictable/2022/03/30/1212/luas-panen-tanaman-sayuran-dan-buah-buahan-semusim-menurut-jenis-tanaman-di-provinsi-bengkulu-2019-2021.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_62_02 <- schema_idn_l2_62 %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(3:5))

regTable(nation = "idn",
         level = 2,
         subset = "BengkuluFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_62_02,
         begin = 2019,
         end = 2021,
         archive = "BengkuluFruitsVegProd19-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/statictable/2022/03/30/1223/produksi-buah-buahan-dan-sayuran-tahunan-menurut-jenis-tanaman-di-provinsi-bengkulu-2019-2021.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_62_03 <- schema_idn_l2_62 %>%
  setCluster(id = "al2", left = 2, top = 7, height = 25) %>%
  setFilter(rows = .find("Palem..", col = 1), invert = TRUE) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(3:5))

regTable(nation = "idn",
         level = 2,
         subset = "BengkuluOrnPlantHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_62_03,
         begin = 2019,
         end = 2021,
         archive = "BengkuluOrnamentalPlantsHarvest19-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_62_04 <- schema_idn_l2_62 %>%
  setCluster(id = "al2", left = 2, top = 7, height = 16) %>%
  setFilter(rows = .find("pohon..", col = 2), invert = TRUE) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(3:5))

regTable(nation = "idn",
         level = 2,
         subset = "BengkuluMedPlantHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_62_04,
         begin = 2019,
         end = 2021,
         archive = "BengkuluMEdicinalPlantsHarvest19-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_62_05 <- schema_idn_l2_62 %>%
  setCluster(id = "al2", left = 2, top = 7, height = 16) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(3:5))

regTable(nation = "idn",
         level = 2,
         subset = "BengkuluMedPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_62_05,
         begin = 2019,
         end = 2021,
         archive = "BengkuluMEdicinalPlantsProductiont19-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_62_06 <- schema_idn_l2_62 %>%
  setFilter(rows = .find("m2", col = 2)) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(3:5))

regTable(nation = "idn",
         level = 2,
         subset = "BengkuluMushroomHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_62_06,
         begin = 2019,
         end = 2021,
         archive = "BengkuluFruitsVegHarv19-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/statictable/2022/03/30/1212/luas-panen-tanaman-sayuran-dan-buah-buahan-semusim-menurut-jenis-tanaman-di-provinsi-bengkulu-2019-2021.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_63 <- setCluster(id = "al2", left = 1, top = 4, height = 3) %>%
  setIDVar(name = "al2", value = "Dki Jakarta") %>%
  setIDVar(name = "year", columns = c(2:13), rows = 4) %>%
  setIDVar(name = "commodities", columns = 1)

schema_idn_l2_63_01 <- schema_idn_l2_63 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:13))

regTable(nation = "idn",
         level = 2,
         subset = "DkiJakartaPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_63_01,
         begin = 2008,
         end = 2019,
         archive = "DKIJakartaPoultry08-19.xls",
         archiveLink = "https://jakarta.bps.go.id/statictable/2021/06/04/236/populasi-unggas-menurut-jenis-unggas-2008---2019.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_63_02 <- schema_idn_l2_63_01 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 7)

regTable(nation = "idn",
         level = 2,
         subset = "DkiJakartaLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_63_02,
         begin = 2008,
         end = 2019,
         archive = "DKIJakartaLivestock08-19.xls",
         archiveLink = "https://jakarta.bps.go.id/statictable/2021/06/04/235/populasi-ternak-di-dki-jakarta-menurut-jenis-ternak-2008-2019.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_63_03 <- schema_idn_l2_63 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 5) %>%
  setIDVar(name = "year", columns = c(2:6), rows = 4) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:6))

regTable(nation = "idn",
         level = 2,
         subset = "DkiJakartaCropsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_63_03,
         begin = 2009,
         end = 2013,
         archive = "DKIJakartaFoodCropsHarv09-13.xls",
         archiveLink = "https://jakarta.bps.go.id/statictable/2015/04/10/38/luas-panen-tanaman-bahan-makanan-2009-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_63_04 <- schema_idn_l2_63 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 5) %>%
  setIDVar(name = "year", columns = c(2:6), rows = 4) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:6))

regTable(nation = "idn",
         level = 2,
         subset = "DkiJakartaCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_63_04,
         begin = 2009,
         end = 2013,
         archive = "DKIJakartaFoodCropsProd09-13.xls",
         archiveLink = "https://jakarta.bps.go.id/statictable/2015/04/10/39/produksi-tanaman-bahan-makanan-2009-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_63_05 <- schema_idn_l2_63 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 5) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "year", columns = c(2:6), rows = 4) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(2:6))

regTable(nation = "idn",
         level = 2,
         subset = "DkiJakartaCropsYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_63_05,
         begin = 2009,
         end = 2013,
         archive = "DKIJakartaFoodCropsYield09-13.xls",
         archiveLink = "https://jakarta.bps.go.id/statictable/2015/04/10/40/rata-rata-produksi-tanaman-bahan-makanan-2009-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_64 <-
  setIDVar(name = "al2", value = "Dki Jakarta") %>%
  setIDVar(name = "year", columns = c(2:9), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:9), top =1)

regTable(nation = "idn",
         level = 2,
         subset = "DkiJakartaVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_64,
         begin = 2009,
         end = 2016,
         archive = "DKIJakartaVegHarv09-16.xls",
         archiveLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_65 <-
  setIDVar(name = "al2", value = "Dki Jakarta") %>%
  setIDVar(name = "year", columns = c(2:9), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(6:9), top =1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:5), top =1)

regTable(nation = "idn",
         level = 2,
         subset = "DkiJakartaMedPlantHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_65,
         begin = 2017,
         end = 2020,
         archive = "DKIJakartaMedicialPlantsHarvProd17-20.xls",
         archiveLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_66 <-
  setIDVar(name = "al2", value = "Dki Jakarta") %>%
  setIDVar(name = "year", columns = c(2:5), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:5), top =1)

regTable(nation = "idn",
         level = 2,
         subset = "DkiJakartaOrnPlantHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_66,
         begin = 2017,
         end = 2020,
         archive = "DKIJakartaOrnamentalPlantsDis17-20.xls",
         archiveLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_67 <-
  setIDVar(name = "al2", value = "Dki Jakarta") %>%
  setIDVar(name = "year", columns = c(2:9), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:9), top =1)

regTable(nation = "idn",
         level = 2,
         subset = "DkiJakartaFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_67,
         begin = 2009,
         end = 2016,
         archive = "DKIJakartaFruitsProd09-16.xls",
         archiveLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_68 <-
  setIDVar(name = "al2", value = "Dki Jakarta") %>%
  setIDVar(name = "year", columns = c(2:9), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:9), top =1)

regTable(nation = "idn",
         level = 2,
         subset = "DkiJakartaVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_68,
         begin = 2009,
         end = 2016,
         archive = "DKIJakartaHorticultureHarv09-16.xls",
         archiveLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_69 <-
  setIDVar(name = "al2", value = "Dki Jakarta") %>%
  setIDVar(name = "year", columns = c(2:5), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:5), top =1)

regTable(nation = "idn",
         level = 2,
         subset = "DkiJakartaVegProd02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_69,
         begin = 2017,
         end = 2020,
         archive = "DKIJakartaHorticultureProd17-20.xls",
         archiveLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_70 <-
  setIDVar(name = "al2", value = "Gorontalo") %>%
  setIDVar(name = "year", columns = c(2:12), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:12), top =1)

regTable(nation = "idn",
         level = 2,
         subset = "GorontaloCropsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_70,
         begin = 2007,
         end = 2017,
         archive = "GorontaloFoodCropsHarv07-17.xls",
         archiveLink = "https://gorontalo.bps.go.id/subject/55/hortikultura.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/55/hortikultura.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_71 <-
  setIDVar(name = "al2", value = "Gorontalo") %>%
  setIDVar(name = "year", columns = c(2:12), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:12), top =1)

regTable(nation = "idn",
         level = 2,
         subset = "GorontaloCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_71,
         begin = 2007,
         end = 2017,
         archive = "GorontaloFoodCropsProd07-17.xls",
         archiveLink = "https://gorontalo.bps.go.id/subject/55/hortikultura.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/55/hortikultura.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_72 <-
  setIDVar(name = "al2", value = "Gorontalo") %>%
  setIDVar(name = "year", columns = c(2:12), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(2:12), top =1)

regTable(nation = "idn",
         level = 2,
         subset = "GorontaloCropsYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_72,
         begin = 2007,
         end = 2017,
         archive = "GorontaloFoodCropsYield10-17.xls",
         archiveLink = "https://gorontalo.bps.go.id/subject/55/hortikultura.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/55/hortikultura.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_73 <- setCluster(id = "al2", left = 2, top = 4, height = 19) %>%
  setIDVar(name = "al2", value = "Gorontalo") %>%
  setIDVar(name = "year", columns = c(3:5), rows = 3) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(3:5))

regTable(nation = "idn",
         level = 2,
         subset = "GorontaloFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_73,
         begin = 2012,
         end = 2014,
         archive = "GorontaloFruitsProd12-14.xls",
         archiveLink = "https://gorontalo.bps.go.id/subject/55/hortikultura.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/55/hortikultura.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_73_01 <- schema_idn_l2_73 %>%
  setCluster(id = "al2", left = 2, top = 4, height = 17)

regTable(nation = "idn",
         level = 2,
         subset = "GorontaloVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_73_01,
         begin = 2012,
         end = 2014,
         archive = "GorontaloVegiesProd12-14.xls",
         archiveLink = "https://gorontalo.bps.go.id/subject/55/hortikultura.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/55/hortikultura.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_73_02 <- schema_idn_l2_73 %>%
  setCluster(id = "al2", left = 2, top = 4, height = 6) %>%
  setFormat(thousand = ",") %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(3:5))

regTable(nation = "idn",
         level = 2,
         subset = "GorontaloMedProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_73_02,
         begin = 2012,
         end = 2014,
         archive = "GorontaloMedicalPlantsProd12-14.xls",
         archiveLink = "https://gorontalo.bps.go.id/subject/55/hortikultura.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/55/hortikultura.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_74 <-
  setIDVar(name = "al2", value = "Jambi") %>%
  setIDVar(name = "year", columns = c(2:139), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:139), rows = 1, split = "(?<=of ).*(?= in)")

schema_idn_l2_74_01 <- schema_idn_l2_74  %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:139))

regTable(nation = "idn",
         level = 2,
         subset = "JambiCropsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_74_01,
         begin = 2000,
         end = 2017,
         archive = "JambiFoodCropsHarv00-17.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_74_02 <- schema_idn_l2_74  %>%
  setObsVar(name = "production", unit = "t", columns = c(2:139))

regTable(nation = "idn",
         level = 2,
         subset = "JambiCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_74_02,
         begin = 2000,
         end = 2017,
         archive = "JambiFoodCropsProd00-17.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_74_03 <- schema_idn_l2_74  %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 0.1, columns = c(2:139))

regTable(nation = "idn",
         level = 2,
         subset = "JambiCropsYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_74_03,
         begin = 2000,
         end = 2017,
         archive = "JambiFoodCropsYield00-17.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_74_04 <- schema_idn_l2_74  %>%
  setIDVar(name = "year", columns = c(2:23), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:23), rows = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:23))

regTable(nation = "idn",
         level = 2,
         subset = "JambiRubberPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_74_04,
         begin = 1997,
         end = 2018,
         archive = "JambiRubberPlan97-18.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_75 <-
  setIDVar(name = "al2", value = "Jambi") %>%
  setIDVar(name = "year", columns = c(2:21), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:21), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "JambiForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_75,
         begin = 1999,
         end = 2018,
         archive = "JambiForestry99-18.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_76 <-
  setIDVar(name = "al2", value = "Jambi") %>%
  setIDVar(name = "year", columns = c(2:3), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:3), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "JambiFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_76,
         begin = 2017,
         end = 2018,
         archive = "JambiFruitsProd-01-17-18.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "JambiVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_76,
         begin = 2017,
         end = 2018,
         archive = "JambiVegProd17-18.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_77 <-
  setIDVar(name = "al2", value = "Jambi") %>%
  setIDVar(name = "year", columns = c(2:3), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:3), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "JambiOrnPlantsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_77,
         begin = 2017,
         end = 2018,
         archive = "JambiOrnamentalPlantsHarv17-18.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_78 <-
  setIDVar(name = "al2", value = "Jambi") %>%
  setIDVar(name = "year", columns = c(2:20), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:20), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "JambiCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_78,
         begin = 2000,
         end = 2018,
         archive = "JambiPlantationCropsProd00-18.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_79 <-
  setIDVar(name = "al2", value = "Jambi") %>%
  setIDVar(name = "year", columns = c(2:20), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:20), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "JambiCropsPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_79,
         begin = 2000,
         end = 2018,
         archive = "JambiPlatationCropsPlan00-18.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_80 <-
  setIDVar(name = "al2", value = "Aceh") %>%
  setIDVar(name = "year", columns = c(2:33), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:33), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "AcehCacaoPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_80,
         begin = 1986,
         end = 2017,
         archive = "AcehCacoaSmallHybridPlan86-17.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_81 <-
  setIDVar(name = "al2", value = "Aceh") %>%
  setIDVar(name = "year", columns = c(2:40), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:40), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "AcehCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_81,
         begin = 1979,
         end = 2017,
         archive = "AcehClovesTabacoSmallProd79-17.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_82 <-
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:71), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:71), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:71), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "AcehCropsPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_82,
         begin = 1979,
         end = 2013,
         archive = "AcehCloveTabacoSmallPlan79-13.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_83 <- setCluster(id = "al2", left = 3, top = 6, height = 15) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al2", value = "Aceh") %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = c(3:17), rows = 3) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(3, 6, 9, 12, 15)) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(4, 7, 10, 13, 16)) %>%
  setObsVar(name = "production", unit = "t", columns = c(4, 8, 11, 14, 17))

regTable(nation = "idn",
         level = 2,
         subset = "AcehCropsHarvYieldProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_83,
         begin = 2000,
         end = 2013,
         archive = "AcehCropsProductionYieldHarvested00-13.pdf",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_84 <-
  setIDVar(name = "al2", value = "Aceh") %>%
  setIDVar(name = "year", columns = c(2:40), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1)

schema_idn_l2_84_01 <- schema_idn_l2_84 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:40), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "AcehBigLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_84_01,
         begin = 1979,
         end = 2017,
         archive = "AcehBigLivestock79-17.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_84_02 <- schema_idn_l2_84 %>%
  setIDVar(name = "year", columns = c(2:37), rows = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:37), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "AcehPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_84_02,
         begin = 1979,
         end = 2014,
         archive = "AcehPoultry79-14.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_84_03 <- schema_idn_l2_84 %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:40), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "AcehNutsPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_84_03,
         begin = 1986,
         end = 2017,
         archive = "AcehNutsEstatPlant86-17.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "AcehPalmOilPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_84_03,
         begin = 1979,
         end = 2017,
         archive = "AcehOilPalmSmallEstatPlan79-17.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_84_04 <- schema_idn_l2_84 %>%
  setObsVar(name = "production", unit = "t", columns = c(2:40), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "AcehPalmOilProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_84_04,
         begin = 1979,
         end = 2017,
         archive = "AcehOilPalmSmallEstatProd79-17.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "AcehFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_84_04,
         begin = 1979,
         end = 2017,
         archive = "AcehProdFruits79-17.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "AcehRubberProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_84_04,
         begin = 1979,
         end = 2017,
         archive = "AcehRubberSmallEstat79-17.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 2,
         subset = "AcehTabaccoCloves",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_84_04,
         begin = 1979,
         end = 2017,
         archive = "AcehTabacoClovesSmallPlan79-17.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l2_84_05 <- schema_idn_l2_84 %>%
  setFilter(rows = .find("Jumlah", col = 1)) %>%
  setIDVar(name = "year", columns = c(2:77), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:39), top = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(40:77), top = 1)

regTable(nation = "idn",
         level = 2,
         subset = "AcehPaddyHarvPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_84_05,
         begin = 1979,
         end = 2016,
         archive = "AcehPadiPlantedHarvested79-16.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l2_85 <- setCluster(id = "al2", left = 2, top = 5, height = 15) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al2", value = "Aceh") %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=of ).*(?=,)") %>%
  setObsVar(name = "harvested", unit = "ha", columns = 4) %>%
  setObsVar(name = "production", unit = "t", columns = 5) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = 7)

regTable(nation = "idn",
         level = 2,
         subset = "AcehRicePlantHarvProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l2_86,
         begin = 2000,
         end = 2013,
         archive = "AcehPadiProductionYieldHarvested00-13.pdf",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


## level 3 ----
schema_idn_l3_01 <- setCluster(id = "al2", left = 1, top = 4, height = 18) %>%
  setFormat(thousand = ",") %>%
  setFilter(rows = .find("Regency", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", value = "Jawa Barat") %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", value = "2016") %>%
  setIDVar(name = "commodities", columns = c(3:6), rows = 3)

schema_idn_l3_01_00 <- schema_idn_l3_01 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(3:6))

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratPoultry01",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_01_00,
         begin = 2016,
         end = 2016,
         archive = "JawaBaratPoultrySubDis16.xls",
         archiveLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab4",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# When I use two columns for the al3 and merge I get weird error:
# schema_idn_l3_01_01 <- schema_idn_l3_01_00 %>%
#   setCluster(id = "al2", left = 1, top = 23, height = 8) %>%
#   setIDVar(name = "al3", columns = c(1:2), merge = "-")

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratPoultry02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_01_01,
         begin = 2016,
         end = 2016,
         archive = "JawaBaratPoultrySubDis16.xls",
         archiveLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab4",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_01_02 <- schema_idn_l3_01 %>%
  setCluster(id = "al2", left = 2, top = 4, height = 19) %>%
  setIDVar(name = "commodities", columns = c(5:9), rows = 3) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(5:9))

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratFruit01",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_01_02,
         begin = 2016,
         end = 2016,
         archive = "JawaBaratFruitsProdSubDis16.xls",
         archiveLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab4",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratFruit03",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_01_02,
         begin = 2016,
         end = 2016,
         archive = "JawaBaratFurtherFruitsProdSubDis16.xls",
         archiveLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab4",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratFruit05",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_01_02,
         begin = 2016,
         end = 2016,
         archive = "JawaBaratMoreFruitsProdSubDis16.xls",
         archiveLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab4",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# Merge argument not working.
schema_idn_l3_01_03 <- schema_idn_l3_01_02 %>%
  setCluster(id = "al2", left = 1, top = 23, height = 10) %>%
  setIDVar(name = "al3", columns = c(1, 2), merge = "-")
#
# regTable(nation = "idn",
#          level = 3,
#          subset = "JawaBaratFruit02",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l3_01_03,
#          begin = 2016,
#          end = 2016,
#          archive = "JawaBaratFruitsProdSubDis16.xls",
#          archiveLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab4",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "idn",
#          level = 3,
#          subset = "JawaBaratFruit04",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l3_01_03,
#          begin = 2016,
#          end = 2016,
#          archive = "JawaBaratFurtherFruitsProdSubDis16.xls",
#          archiveLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab4",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "idn",
#          level = 3,
#          subset = "JawaBaratFruit06",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l3_01_03,
#          begin = 2016,
#          end = 2016,
#          archive = "JawaBaratMoreFruitsProdSubDis16.xls",
#          archiveLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab4",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)


schema_idn_l3_02 <- setCluster(id = "al2", left = 1, top = 2) %>%
  setFilter(rows = .find("Provinsi..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 4) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:52), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:52), rows = 2)%>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:52))

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_02,
         begin = 2016,
         end = 2020,
         archive = "JawaBaratLivestock_16-20.xls",
         archiveLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab4",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jabar.bps.go.id/subject/24/peternakan.html#subjekViewTab1",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_02_00 <- schema_idn_l3_02 %>%
  setFilter(rows = .find("PROVINSI..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:89), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:89), rows = 2)%>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:89))

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_02_00,
         begin = 2010,
         end = 2021,
         archive = "JawaTengahLivestock2010_2021.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_02_01 <- schema_idn_l3_02 %>%
  setFilter(rows = .find("PROVINSI..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:25), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:25), rows = 2)%>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:25))

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_02_01,
         begin = 2018,
         end = 2021,
         archive = "JawaTengahPoultry2018_2021.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_03 <-
  setFilter(rows = .find("Provinsi..|Wilayah..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 4) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:13), rows = 3) %>%
  setIDVar(name = "commodities", value = "rice plants")

schema_idn_l3_03_00 <- schema_idn_l3_03 %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:5)) %>%
  setObsVar(name = "production", unit = "t", columns = c(6:9)) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = c(10:13))

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratPaddyHarvYieldProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_00,
         begin = 2015,
         end = 2020,
         archive = "JawaBaratRice_2015_2020.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_01 <- schema_idn_l3_03 %>%
  setCluster(id = "al2", left = 1, top = 3) %>%
  setIDVar(name = "year", value = "2015") %>%
  setIDVar(name = "commodities", value = "maize")%>%
  setObsVar(name = "harvested", unit = "ha", columns = 2) %>%
  setObsVar(name = "production", unit = "t", columns = 4) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = 3)

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratMaizeHarvYieldProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_01,
         begin = 2015,
         end = 2015,
         archive = "JawaBarat_maize_2015.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_02 <- schema_idn_l3_03 %>%
  setIDVar(name = "year", columns = c(2:5), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2, 4), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:5))

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratSoyMaizeProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_02,
         begin = 2015,
         end = 2018,
         archive = "JawaBaratSoyMaizeProdSubDis15-18.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_03 <- schema_idn_l3_03 %>%
  setIDVar(name = "al2", columns = 1, rows = 3) %>%
  setIDVar(name = "year", columns = c(2:8), rows = 2) %>%
  setIDVar(name = "commodities", value = "soybean") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:8))

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratSoyProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_03,
         begin = 2010,
         end = 2016,
         archive = "JawaBaratSoyProdSubDis10-16.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_04 <- schema_idn_l3_03 %>%
  setIDVar(name = "year", columns = c(2:136), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:136), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:61)) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(62:136))

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratMedPLant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_04,
         begin = 2000,
         end = 2020,
         archive = "JawaBararMedicialPlantsProdHarvest.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_05 <- schema_idn_l3_03 %>%
  setCluster(id = "al2", left = 1, top = 3) %>%
  setIDVar(name = "year", value = "2000") %>%
  setIDVar(name = "commodities", columns = c(2:16), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:16))

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratMedPLant02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_05,
         begin = 2000,
         end = 2000,
         archive = "JawaBaratMedicialPlantsProdSubDis00.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_05_00 <- setCluster(id = "al2", left = 2, top = 4, height = 22) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al2", value = "Jawa Barat") %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", value = "2016") %>%
  setIDVar(name = "commodities", columns = c(5:8), rows = 3) %>%
  setObsVar(name = "production", unit = "t", factor = 1000, columns = c(5:8))

# Table with issues with the cities and regencies.
regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratMedPLant03",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_05_00,
         begin = 2016,
         end = 2016,
         archive = "JawaBaratMedicialPlantsProdSubDis16.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# Merging problem
schema_idn_l3_03_05_01 <- schema_idn_l3_03_05_00 %>%
  setCluster(id = "al2", left = 2, top = 23, height = 10) %>%
  setIDVar(name = "al3", columns = c(1:2))

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratMedPLant04",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_05_01,
         begin = 2016,
         end = 2016,
         archive = "JawaBaratMedicialPlantsProdSubDis16.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# Production values are not included, because the unit is stalk.
schema_idn_l3_03_06 <- schema_idn_l3_03 %>%
  setIDVar(name = "year", columns = c(2:61), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:61), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:61), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratOrnamPlantHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_06,
         begin = 2015,
         end = 2019,
         archive = "JawaBaratOrnamentPLantsProdHarvest2015_2019.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_07 <- schema_idn_l3_03 %>%
  setIDVar(name = "year", columns = c(2:41), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:41), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:41), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_07,
         begin = 2015,
         end = 2019,
         archive = "JawaBaratVegHarvest2015_2019.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_08 <- schema_idn_l3_03 %>%
  setIDVar(name = "year", columns = c(2:111), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:111), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:111), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_08,
         begin = 2015,
         end = 2019,
         archive = "JawaBaratVegProd2015_2019.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_09 <- schema_idn_l3_03 %>%
  setFilter(rows = .find("Provinsi..|Kabupaten..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 31) %>%
  setIDVar(name = "year", columns = c(2:13), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:23), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:23), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratEstateCropsPlant04",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_09,
         begin = 2018,
         end = 2019,
         archive = "JawaBaratEstateCrops042018_2019.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_10 <- schema_idn_l3_03 %>%
  setFilter(rows = .find("Provinsi..|Kabupaten..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 31) %>%
  setIDVar(name = "year", columns = c(2:34), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:34), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:34), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratEstateCropsProd02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_10,
         begin = 2015,
         end = 2019,
         archive = "JawaBaratEstateCropsProd022015_2019.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_11 <- schema_idn_l3_03 %>%
  setFilter(rows = .find("PROVINSI..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:91), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:91), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:31), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(31:61), top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(61:91), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_11,
         begin = 2012,
         end = 2018,
         archive = "JawaTengahCropsHarvProdYield2012_2018(1).xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_12 <- schema_idn_l3_03 %>%
  setFilter(rows = .find("PROVINSI..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:55), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:55), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:10, 29:37), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(11:19, 38:46), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(20:28, 47:55), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahRice",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_12,
         begin = 2009,
         end = 2019,
         archive = "JawaTengahDryWetPaddyHarvProdYieldSubDis09-18.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_13 <- schema_idn_l3_03 %>%
  setFilter(rows = .find("PROVINSI..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:7), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:3), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(4:5), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(6:7), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahBean",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_13,
         begin = 2017,
         end = 2018,
         archive = "JawaTengahBeanHarvProdYield2017_2018.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahGreenGram",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_13,
         begin = 2013,
         end = 2014,
         archive = "JawaTengahGramHarvProdYield2013_2014.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_14 <- schema_idn_l3_03 %>%
  setFilter(rows = .find("PROVINSI..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:41), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:41), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:41), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_14,
         begin = 2013,
         end = 2021,
         archive = "JawaTengahHarv2013_2021.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_15 <- schema_idn_l3_03 %>%
  setFilter(rows = .find("PROVINSI..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:13), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:13), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:5), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(6:9), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(10:13), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_15,
         begin = 2018,
         end = 2021,
         archive = "JawaTengahPaddyHarvProdYield2018_2021.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_16 <- schema_idn_l3_03 %>%
  setFilter(rows = .find("PROVINSI..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:6), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:6), rows = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:6), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_16,
         begin = 2018,
         end = 2018,
         archive = "JawaTengahForest2018.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_17 <- schema_idn_l3_03 %>%
  setFilter(rows = .find("PROVINSI..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:12), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:12), rows = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:12), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_17,
         begin = 2019,
         end = 2021,
         archive = "JawaTengahForest022019_2021.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_18 <- schema_idn_l3_03 %>%
  setFilter(rows = .find("PROVINSI..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:169), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:169), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(86:169), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:85), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahVegHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_18,
         begin = 2017,
         end = 2020,
         archive = "JawaTengahVegHarvProd2017_2020.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_19 <- schema_idn_l3_03 %>%
  setFilter(rows = .find("PROVINSI..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:23), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:23), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(13:23), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:12), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahVegHarvProd02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_19,
         begin = 2017,
         end = 2020,
         archive = "JawaTengahVegHarv02Prod2017_2020.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_20 <- schema_idn_l3_03 %>%
  setFilter(rows = .find("PROVINSI..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:241), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:241), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(122:241), top = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:121), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahMedHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_20,
         begin = 2014,
         end = 2021,
         archive = "JawaTengahMedPlantHarvProd14-21.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_21 <- schema_idn_l3_03 %>%
  setFilter(rows = .find("PROVINSI..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:55), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:55), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:28), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(29:55), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_21,
         begin = 2019,
         end = 2021,
         archive = "JawaTengahPlantationPlantProd19-21.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_03_22 <- schema_idn_l3_03 %>%
  setFilter(rows = .find("PROVINSI..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:93), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:93), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:47), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(48:93), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahPlantProd02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_03_22,
         begin = 2018,
         end = 2018,
         archive = "JawaTengahPlantationPlantProd18.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_04 <- setCluster(id = "al2", left = 1, top = 3, height = 28) %>%
  setFilter(rows = .find("Jawa..", col = 1), invert = TRUE) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "al2", columns = 1, rows = 3) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 2, rows = 2) %>%
  setIDVar(name = "commodities", value = "soybean") %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = 2)

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratSoyYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_04,
         begin = 2015,
         end = 2015,
         archive = "JawaBaratSoyYieldSubDis15.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_05 <-
  setFilter(rows = .find("Provinsi..|Kabupaten..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 31) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:76), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:76), rows = 1) %>%
  setIDVar(name = "ownership", columns = c(2:76), rows = 2)

schema_idn_l3_05_00 <- schema_idn_l3_05 %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:76))

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratEstateCropsPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_05_00,
         begin = 2015,
         end = 2020,
         archive = "JawaBaratEstateCrops2015_2020.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_05_01 <- schema_idn_l3_05 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:7), rows = 1) %>%
  setIDVar(name = "ownership", columns = c(2:7), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:7))

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratEstateCropsPlant02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_05_01,
         begin = 2019,
         end = 2020,
         archive = "JawaBaratEstateCrops022015_2020.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratEstateCropsPlant03",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_05_01,
         begin = 2019,
         end = 2019,
         archive = "JawaBaratEstateCrops032019.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_05_02 <- schema_idn_l3_05 %>%
  setIDVar(name = "year", columns = c(2:61), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:61), rows = 1) %>%
  setIDVar(name = "ownership", columns = c(2:61), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:61))

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratEstateCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_05_02,
         begin = 2015,
         end = 2020,
         archive = "JawaBaratEstateCropsProd2015_2020.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_05_03 <- schema_idn_l3_05 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:7), rows = 1) %>%
  setIDVar(name = "ownership", columns = c(2:7), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:7))

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratEstateCropsProd03",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_05_03,
         begin = 2019,
         end = 2019,
         archive = "JawaBaratEstateCropsProd032019_2019.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratEstateCropsProd04",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_05_03,
         begin = 2019,
         end = 2020,
         archive = "JawaBaratEstateCropsProd042019_2020.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_05_04 <- schema_idn_l3_05 %>%
  setIDVar(name = "year", columns = c(2:10), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:10), rows = 1) %>%
  setIDVar(name = "ownership", columns = c(2:10), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:10))

regTable(nation = "idn",
         level = 3,
         subset = "JawaBaratEstateCropsProd05",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_05_04,
         begin = 2015,
         end = 2020,
         archive = "JawaBaratEstateCropsProd052015_2020.xls",
         archiveLink = "https://jabar.bps.go.id/subject/53/tanaman-pangan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",notes =
         metadataLink = "https://www.bps.go.id/subject/53/tanaman-pangan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


# need to extract city values separatly from regencies.
# schema_idn_l3_06 <- setCluster(id = "al2", left = 2, top = 10, height = 30) %>%
#   setFilter(rows = .find("Kabupaten", col = 1), invert = TRUE) %>%
#   setIDVar(name = "al2", value = "Jawa Tengah") %>%
#   setIDVar(name = "al3", columns = 2) %>%
#   setIDVar(name = "year", columns = c(3:106), rows = 3) %>%
#   setIDVar(name = "commodities", columns = c(3:106), rows = 5) %>%
#   setObsVar(name = "harvested", unit = "ha", columns = c(3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105)) %>%
#   setObsVar(name = "production", unit = "t", columns = c(4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100, 102, 104, 106))
#
# regTable(nation = "idn",
#          level = 3,
#          subset = "JawaTengahFruitHarv",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l3_06,
#          begin = 2015,
#          end = 2016,
#          archive = "JawaTengahVegiesFruitsHarvProdSubDis15-16.xls",
#          archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# schema_idn_l3_06_00 <- schema_idn_l3_06 %>%
#   setCluster(id = "al2", left = 2, top = 40, height = 7) %>%
#   setIDVar(name = "al3", columns = c(1, 2), merge = "-")
#
# regTable(nation = "idn",
#          level = 3,
#          subset = "JawaTengahFruitHarv02",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l3_06_00,
#          begin = 2015,
#          end = 2016,
#          archive = "JawaTengahVegiesFruitsHarvProdSubDis15-16.xls",
#          archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)
#
#
# schema_idn_l3_07 <- setCluster(id = "al2", left = 2, top = 6, height = 30) %>%
#   setFilter(rows = .find("Kabupaten", col = 1), invert = TRUE) %>%
#   setFormat(thousand = ",") %>%
#   setIDVar(name = "al2", value = "Jawa Tengah") %>%
#   setIDVar(name = "al3", columns = 2) %>%
#   setIDVar(name = "year", columns = c(3:54), rows = 5) %>%
#   setIDVar(name = "commodities", columns = c(3:54), rows = 4) %>%
#   setObsVar(name = "production", unit = "t", columns = c(3:54))
#
# regTable(nation = "idn",
#          level = 3,
#          subset = "JawaTengahFruitProd03",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l3_07,
#          begin = 2018,
#          end = 2019,
#          archive = "JawaTengahFruitsProdSubDis18-19.xls",
#          archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# schema_idn_l3_07_00 <- schema_idn_l3_07 %>%
#   setCluster(id = "al2", left = 2, top = 36, height = 6) %>%
#   setIDVar(name = "al3", columns = c(1, 2), merge = "-")
#
# regTable(nation = "idn",
#          level = 3,
#          subset = "JawaTengahFruitProd04",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l3_07_00,
#          begin = 2018,
#          end = 2019,
#          archive = "JawaTengahFruitsProdSubDis18-19.xls",
#          archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)

# schema_idn_l3_07_01 <- schema_idn_l3_07 %>%
#   setCluster(id = "al2", left = 2, top = 5, height = 30) %>%
#   setIDVar(name = "year", value = "2017") %>%
#   setIDVar(name = "commodities", columns = c(4:51), rows = 3) %>%
#   setObsVar(name = "harvested", unit= "ha", columns = c(4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50)) %>%
#   setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51))
#
# regTable(nation = "idn",
#          level = 3,
#          subset = "JawaTengahFruitHarvProd",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l3_07_01,
#          begin = 2017,
#          end = 2017,
#          archive = "JawaTengahFruitsProdSubDis17.xls",
#          archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)

schema_idn_l3_07_02 <- schema_idn_l3_07 %>%
  setCluster(id = "al2", left = 2, top = 6, height = 29) %>%
  setIDVar(name = "year", value = "2016") %>%
  setIDVar(name = "commodities", columns = c(3:52), rows = 4) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(4, 6, 7, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52))

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahFruitProd03",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_07_02,
         begin = 2016,
         end = 2016,
         archive = "JawaTengahFruitsHarvProdSubDis16.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_07_03 <- schema_idn_l3_07_02 %>%
  setCluster(id = "al2", left = 2, top = 37, height = 7) %>%
  setIDVar(name = "al3", columns = 1)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTengahFruitProd04",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_07_03,
         begin = 2016,
         end = 2016,
         archive = "JawaTengahFruitsHarvProdSubDis16.xls",
         archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


#  need to extract city values separatly from regencies.
# schema_idn_l3_08 <- setCluster(id = "al2", left = 2, top = 6, height = 30) %>%
#   setFilter(rows = .find("Kabupaten", col = 1), invert = TRUE) %>%
#   setIDVar(name = "al2", value = "Jawa Tengah") %>%
#   setIDVar(name = "al3", columns = 2) %>%
#   setIDVar(name = "year", value = "2015") %>%
#   setIDVar(name = "commodities", columns = c(4:96), rows = 4)
#
# schema_idn_l3_08_00 <- schema_idn_l3_08 %>%
#   setObsVar(name = "planted", unit = "ha", columns = c(4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96))
#
# regTable(nation = "idn",
#          level = 3,
#          subset = "JawaTengahPlantCropsPlant",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l3_08_00,
#          begin = 2015,
#          end = 2015,
#          archive = "JawahTengahPlantationCropsPlanSubDis15.xls",
#          archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# schema_idn_l3_08_01 <- schema_idn_l3_08 %>%
#   setCluster(id = "al2", left = 2, top = 36, height = 7) %>%
#   setIDVar(name = "al3", columns = 1)
#
# regTable(nation = "idn",
#          level = 3,
#          subset = "JawaTengahPlantCropsPlant02",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l3_08_01,
#          begin = 2015,
#          end = 2015,
#          archive = "JawahTengahPlantationCropsPlanSubDis15.xls",
#          archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# schema_idn_l3_08_02 <- schema_idn_l3_08 %>%
#   setObsVar(name = "production", unit = "ha", columns = c(4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96))
#
# regTable(nation = "idn",
#          level = 3,
#          subset = "JawaTengahPlantCropsProd",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l3_08_02,
#          begin = 2015,
#          end = 2015,
#          archive = "JawahTengahPlantationCropsPlanSubDis15.xls",
#          archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# schema_idn_l3_08_03 <- schema_idn_l3_08_02 %>%
#   setCluster(id = "al2", left = 2, top = 36, height = 7) %>%
#   setIDVar(name = "al3", columns = 1)
#
# regTable(nation = "idn",
#          level = 3,
#          subset = "JawaTengahPlantCropsProd02",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l3_08_03,
#          begin = 2015,
#          end = 2015,
#          archive = "JawahTengahPlantationCropsPlanSubDis15.xls",
#          archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)
#
#
# schema_idn_l3_09 <- setCluster(id = "al2", left = 2, top = 6, height = 30) %>%
#   setFilter(rows = .find("Kabupaten", col = 1), invert = TRUE) %>%
#   setFormat(thousand = ",") %>%
#   setIDVar(name = "al2", value = "Jawa Tengah") %>%
#   setIDVar(name = "al3", columns = 2) %>%
#   setIDVar(name = "year", columns = c(3:54), rows = 5) %>%
#   setIDVar(name = "commodities", columns = c(3:54), rows = 4) %>%
#   setObsVar(name = "harvested", unit = "ha", factor = 0,0001, columns = c(3:54))
#
# regTable(nation = "idn",
#          level = 3,
#          subset = "JawaTengahOrnamHarv",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l3_09,
#          begin = 2018,
#          end = 2019,
#          archive = "JawaTengahOrnamentalPlantsHarvSubDis18-19.xls",
#          archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# schema_idn_l3_09_03 <- schema_idn_l3_08_02 %>%
#   setCluster(id = "al2", left = 2, top = 36, height = 7) %>%
#   setIDVar(name = "al3", columns = 1)
#
# regTable(nation = "idn",
#          level = 3,
#          subset = "JawaTengahOrnamHarv02",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l3_08_03,
#          begin = 2018,
#          end = 2019,
#          archive = "JawaTengahOrnamentalPlantsHarvSubDis18-19.xls",
#          archiveLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://jateng.bps.go.id/site/pilihdata.html",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)


schema_idn_l3_10 <-
  setFilter(rows = .find("Jawa..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 41) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:57), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:52), rows = 1, split = ".*(?=Po)")

schema_idn_l3_10_01 <- schema_idn_l3_10 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:57))

regTable(nation = "idn",
         level = 3,
         subset = "JawaTimurLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_10_01,
         begin = 2009,
         end = 2016,
         archive = "JawaTimurLivestock2009-2016.xls",
         archiveLink = "https://jatim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jatim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_10_02 <- schema_idn_l3_10 %>%
  setIDVar(name = "year", value = "2018") %>%
  setIDVar(name = "commodities", columns = 2, rows = 1, split = ".*(?=Pro)") %>%
  setObsVar(name = "production", unit = "t", columns = 2)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTimurPady",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_10_02,
         begin = 2018,
         end = 2018,
         archive = "JawaTimurPaddyProdSubDis18.xls",
         archiveLink = "https://jatim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jatim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_11 <- setCluster(id = "al2", left = 1, top = 4, height = 40) %>%
  setFilter(rows = .find("Jawa..|Kota", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 44) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:6), rows = 3) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:6))

regTable(nation = "idn",
         level = 3,
         subset = "JawaTimurPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_11,
         begin = 2011,
         end = 2011,
         archive = "JawaTimurPoultrySubDis11.xls",
         archiveLink = "https://jatim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jatim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTimurPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_11,
         begin = 2012,
         end = 2012,
         archive = "JawaTimurPoultrySubDis12.xls",
         archiveLink = "https://jatim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jatim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTimurPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_11,
         begin = 2013,
         end = 2013,
         archive = "JawaTimurPoultrySubDis13.xls",
         archiveLink = "https://jatim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jatim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTimurPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_11,
         begin = 2014,
         end = 2014,
         archive = "JawaTimurPoultrySubDis14.xls",
         archiveLink = "https://jatim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jatim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTimurPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_11,
         begin = 2015,
         end = 2015,
         archive = "JawaTimurPoultrySubDis15.xls",
         archiveLink = "https://jatim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jatim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "JawaTimurPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_11,
         begin = 2016,
         end = 2016,
         archive = "JawaTimurPoultrySubDis16.xls",
         archiveLink = "https://jatim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jatim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_12 <-
  setFilter(rows = .find("Kalimantan..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 3) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:9), rows = 2) %>%
  setIDVar(name = "commodities", value = "rice")

schema_idn_l3_12_01 <- schema_idn_l3_12 %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(6:9)) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:5))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanBaratRiceHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_12_01,
         begin = 2018,
         end = 2021,
         archive = "KalimanBaratRiceHarvProd18-21.xls",
         archiveLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_12_02 <- schema_idn_l3_12 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 2) %>%
  setIDVar(name = "commodities", value = "food crops") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:7))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanBaratFoodCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_12_02,
         begin = 2010,
         end = 2015,
         archive = "KalimanBaratFoodCropsProd10-15.xls",
         archiveLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_12_03 <- schema_idn_l3_12 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 2) %>%
  setIDVar(name = "commodities", value = "food crops") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:7))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanBaratFoodCropsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_12_03,
         begin = 2010,
         end = 2015,
         archive = "KalimanBaratFoodCropsHarv10-15.xls",
         archiveLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_12_04 <- schema_idn_l3_12 %>%
  setIDVar(name = "al2", columns = 1, rows = 4) %>%
  setIDVar(name = "year", columns = c(2:71), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:71), rows = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:71))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanBaratLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_12_04,
         begin = 2015,
         end = 2021,
         archive = "KalimanBaratRiceHarvProd18-21.xls",
         archiveLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_13 <-
  setFilter(rows = .find("Kalimantan..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 4) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:49), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:49), rows = 2)

schema_idn_l3_13_01 <- schema_idn_l3_13 %>%
  setObsVar(name = "production", unit = "t", columns = c(2:49), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanBaratPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_01,
         begin = 2015,
         end = 2021,
         archive = "KalimatanBaratPlantationCropsProdSubDis15-21.xls",
         archiveLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_02 <- schema_idn_l3_13 %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:49), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanBaratPlantCropsPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_02,
         begin = 2015,
         end = 2021,
         archive = "KalimatanBaratPlantationCropsPlanEstateSubDis15-21.xls",
         archiveLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_03 <- schema_idn_l3_13 %>%
  setIDVar(name = "year", columns = c(2:43), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:43), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:22), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(23:43), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanBaratPlantCropsPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_03,
         begin = 2015,
         end = 2021,
         archive = "KalimatanBaratPlantationCropsPlanProdSubDis15-21.xls",
         archiveLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_04 <- schema_idn_l3_13 %>%
  setFilter(rows = .find("KALIMANTAN..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:37), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:37), rows = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:37), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanSelatanLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_04,
         begin = 2015,
         end = 2021,
         archive = "KalimantanSelatanLivestockSubDis15-18.xls",
         archiveLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_05 <- schema_idn_l3_13 %>%
  setFilter(rows = .find("KALIMANTAN..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:25), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:25), rows = 2, split = "(?<=of).*") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(14:25), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:13), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanSelatanRicePlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_05,
         begin = 2015,
         end = 2021,
         archive = "KalimantanSelatanRiceHarvProdSubDis10-21.xls",
         archiveLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_06 <- schema_idn_l3_13 %>%
  setFilter(rows = .find("KALIMANTAN..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:37), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:37), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:37), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanSelatanThirdHarv01",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_06,
         begin = 2010,
         end = 2015,
         archive = "KalimantanSelatanCropsHarv10-15.xls",
         archiveLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_07 <- schema_idn_l3_13 %>%
  setFilter(rows = .find("KALIMANTAN..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:43), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:43), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:43), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanSelatanThirdProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_07,
         begin = 2013,
         end = 2019,
         archive = "KalimantanSelatanThirdProd13-19.xls",
         archiveLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_08 <- schema_idn_l3_13 %>%
  setFilter(rows = .find("KALIMANTAN..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:337), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:337), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:337), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanSelatanFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_08,
         begin = 2006,
         end = 2018,
         archive = "KalimantanSelatanFruitsProdSubDis06-18.xls",
         archiveLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_09 <- schema_idn_l3_13 %>%
  setFilter(rows = .find("KALIMANTAN..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:50), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:50), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:50), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanSelatanVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_09,
         begin = 2006,
         end = 2018,
         archive = "KalimantanSelatanVegiesHarvSubDis06-18.xls",
         archiveLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_10 <- schema_idn_l3_13 %>%
  setFilter(rows = .find("KALIMANTAN..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:253), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:253), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:253), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanSelatanVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_10,
         begin = 2006,
         end = 2018,
         archive = "KalimantanSelatanVegiesProdSubDis06-18.xls",
         archiveLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_11 <- schema_idn_l3_13 %>%
  setFilter(rows = .find("KALIMANTAN..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:181), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:181), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:181), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanSelatanMedPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_11,
         begin = 2006,
         end = 2018,
         archive = "KalimantanSelatanMedicalPlantsProdSubDis06-18.xls",
         archiveLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_12 <- schema_idn_l3_13_07 %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:22), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(23:43), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanSelatanCropsPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_12,
         begin = 2015,
         end = 2018,
         archive = "KalimantanSelatanPlantationCropsHarvProdSubDis15-18.xls",
         archiveLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_13 <- schema_idn_l3_13 %>%
  setFilter(rows = .find("KALIMANTAN..", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", columns = c(2:11), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:11), rows = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:11), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanSelatanForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_13,
         begin = 2015,
         end = 2018,
         archive = "KalimantanSelatanForestSubDis15-18.xls",
         archiveLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_14 <- schema_idn_l3_13 %>%
  setIDVar(name = "al2", columns = 1, rows = 18) %>%
  setIDVar(name = "year", columns = c(2:88), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:88), rows = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:88), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_14,
         begin = 2013,
         end = 2018,
         archive = "KalimantanTengahLivestockSubDis13-18.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_15 <- schema_idn_l3_13 %>%
  setIDVar(name = "year", columns = c(2:22), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:22), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:8), top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(9:15), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(16:22), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahHarvProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_15,
         begin = 2014,
         end = 2014,
         archive = "KalimanTengahCropsHarvProdYield2014.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_16 <- schema_idn_l3_13 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:7), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:3), top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(4:5), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(6:7), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahHarvDryPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_16,
         begin = 2013,
         end = 2014,
         archive = "KalimanTenaghDryPaddy13-14.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_17 <- schema_idn_l3_13 %>%
  setIDVar(name = "al2", columns = 1, rows = 18) %>%
  setIDVar(name = "year", columns = c(2:82), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:82), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(56:82), top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(29:55), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:28), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahHarvProdYield02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_17,
         begin = 2013,
         end = 2015,
         archive = "KalimanTengahCropHarvProdYield0113-15.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_18 <- schema_idn_l3_13 %>%
  setIDVar(name = "al2", columns = 1, rows = 3) %>%
  setIDVar(name = "year", columns = c(2:25), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:25), rows = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:25))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahCropProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_18,
         begin = 2006,
         end = 2014,
         archive = "KalimantanTengahProd03-14.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_19 <- schema_idn_l3_13 %>%
  setIDVar(name = "al2", columns = 1, rows = 17) %>%
  setIDVar(name = "year", columns = c(2:203), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:203), rows = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:203))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahVegFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_19,
         begin = 2013,
         end = 2018,
         archive = "KalimantanTengahProd03-14.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_20 <- schema_idn_l3_13 %>%
  setIDVar(name = "al2", columns = 1, rows = 3) %>%
  setIDVar(name = "year", columns = c(2:3), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:3), rows = 1, split = "(?<=of).*(?=\\()") %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:3))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahTurmProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_20,
         begin = 2018,
         end = 2019,
         archive = "KalimantanTengahTurmericProdSubDis18-19.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_21 <- schema_idn_l3_13 %>%
  setIDVar(name = "al2", columns = 1, rows = 18) %>%
  setIDVar(name = "year", columns = c(6:29), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(6:29), rows = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = c(6:29), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_21,
         begin = 2015,
         end = 2018,
         archive = "KalimantanTengahForestrySubDis15-18.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_22 <- schema_idn_l3_13 %>%
  setCluster(id = "al2", left = 1, top = 4) %>%
  setIDVar(name = "al2", columns = 1, rows = 18) %>%
  setIDVar(name = "year", value = "2018") %>%
  setIDVar(name = "commodities", value = "betel nut") %>%
  setObsVar(name = "harvested", unit = "ha", columns = 2, top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = 3, top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = 4, top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahBetelNut",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_22,
         begin = 2018,
         end = 2018,
         archive = "KalimantanTengahBetelnutHarvYieldSubDis18.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_23 <- schema_idn_l3_13 %>%
  setIDVar(name = "al2", columns = 1, rows = 18) %>%
  setIDVar(name = "year", columns = c(2:43), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:43), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:13, 26:34), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(14:25, 35:43), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahCottonClove",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_23,
         begin = 2007,
         end = 2018,
         archive = "KalimantanTengahCottonCloveProdHarvSubDis07-18.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_13_24 <- schema_idn_l3_13 %>%
  setIDVar(name = "al2", columns = 1, rows = 18) %>%
  setIDVar(name = "year", columns = c(2:121), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:121), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(8:13, 20:25, 32:37, 44:49, 56:61, 68:73, 80:85, 92:97, 104:109, 116:121), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:7, 14:19, 26:31, 38:43, 50:55, 62:67, 74:79, 86:91, 98:103, 110:115), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahCropsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_13_24,
         begin = 2013,
         end = 2018,
         archive = "KalimantanTengahPlantationCropsProdHarvSubDis13-18.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_14 <- setCluster(id = "al2", left = 1, top = 8, height = 16) %>%
  setFilter(rows = .find("Regency|Municipality", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", value = "Kalimantan Tengah") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<!,)\\d.*") %>%
  setIDVar(name = "commodities", columns = c(2:7), rows = 5)

schema_idn_l3_14_01 <- schema_idn_l3_14 %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 5), top = 6) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = c(4, 7), top = 6) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 6), top = 6)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahHarvDryWetPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_14_01,
         begin = 2015,
         end = 2015,
         archive = "KalimantanTengahDryWetPaddyHarvProdYieldSubDis15.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_14_02 <- schema_idn_l3_14 %>%
  setCluster(id = "al2", left = 1, top = 9, height = 16) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "commodities", columns = c(2:13), rows = 4) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 5, 8, 11), top = 6) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = c(4, 7, 10, 13), top = 6) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 6, 9, 12), top = 6)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahCropHarvProdYield03",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_14_02,
         begin = 2015,
         end = 2015,
         archive = "KalimantanTengahFoodCropsHarvProdYieldSubDis15.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_14_03 <- schema_idn_l3_14 %>%
  setCluster(id = "al2", left = 1, top = 5, height = 16) %>%
  setIDVar(name = "commodities", columns = c(2:16), rows = 3) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:16))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahVegHarv01",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_14_03,
         begin = 2015,
         end = 2015,
         archive = "KalimantanTengahVegiesHarvSubDis15.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahVegHarv02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_14_03,
         begin = 2016,
         end = 2016,
         archive = "KalimantanTengahVegiesHarvSubDis16.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTengahVegHarv03",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_14_03,
         begin = 2017,
         end = 2017,
         archive = "KalimantanTengahVegiesHarvSubDis17.xls",
         archiveLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kalteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_15 <-
  setFilter(rows = .find("Kalimantan..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 14) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:78), rows = 3) %>%
  setIDVar(name = "commodities",columns = c(2:78), rows = 2)

schema_idn_l3_15_01 <- schema_idn_l3_15 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:78), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTimurLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_15_01,
         begin = 2009,
         end = 2015,
         archive = "KalimantanTimurLivestockSubDis09-15.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_15_02 <- schema_idn_l3_15 %>%
  setIDVar(name = "year", columns = c(2:43), rows = 3) %>%
  setIDVar(name = "commodities",columns = c(2:43), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:8, 23:29), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(9:15, 30:36), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(16:22, 37:43), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTimurDryWetPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_15_02,
         begin = 2009,
         end = 2015,
         archive = "KalimantanTimurDryWetPaddyHarvProdYieldSubDis09-15.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_15_03 <- schema_idn_l3_15 %>%
  setIDVar(name = "al2", columns = 1, rows = 13) %>%
  setIDVar(name = "year", columns = c(2:7), rows = 2) %>%
  setIDVar(name = "commodities", value = "paddy") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:3)) %>%
  setObsVar(name = "production", unit = "t", columns = c(4:5)) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(6:7))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTimurPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_15_03,
         begin = 2018,
         end = 2019,
         archive = "KalimantanTimurPaddyHarvProdYieldSubDis18-19.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_15_04 <- schema_idn_l3_15 %>%
  setIDVar(name = "al2", columns = 1, rows = 13) %>%
  setIDVar(name = "year", columns = 2, rows = 2) %>%
  setIDVar(name = "commodities",columns = 2, rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 2)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTimurPaddy02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_15_04,
         begin = 2020,
         end = 2020,
         archive = "KalimanTimurPAddyHarv_2020.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_15_05 <- schema_idn_l3_15 %>%
  setIDVar(name = "al2", columns = 1, rows = 13) %>%
  setIDVar(name = "year", columns = c(2:5), rows = 2) %>%
  setIDVar(name = "commodities",columns = c(2:5), rows = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:5))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTimurRicePaddyProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_15_05,
         begin = 2018,
         end = 2019,
         archive = "KalimantanTimurWetDryPaddyProdSubDis18-19.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_15_06 <- schema_idn_l3_15 %>%
  setIDVar(name = "al2", columns = 1, rows = 13) %>%
  setIDVar(name = "year", columns = c(2:76), rows = 3) %>%
  setIDVar(name = "commodities",columns = c(2:76), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:76), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTimurFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_15_06,
         begin = 2018,
         end = 2020,
         archive = "KalimanTimurFruitProd18-20.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_15_07 <- schema_idn_l3_15 %>%
  setIDVar(name = "year", columns = c(2:55), rows = 3) %>%
  setIDVar(name = "commodities",columns = c(2:55), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:28), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(29:55), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTimurEstateCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_15_07,
         begin = 2018,
         end = 2020,
         archive = "KalimanTimurEsteCropsPLantProd18-20.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_15_08 <- schema_idn_l3_15 %>%
  setIDVar(name = "year", columns = c(2:19), rows = 3) %>%
  setIDVar(name = "commodities",columns = c(2:19), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:3, 6:12), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(4:5, 13:19), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTimurEstateCrops02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_15_08,
         begin = 2020,
         end = 2020,
         archive = "KalimanTimurEsteCropsPlantProd2020.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_16 <- setCluster(id = "al2", left = 1, top = 7, height = 13) %>%
  setIDVar(name = "al2", value = "Kalimantan Timur") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<!,)\\d.*") %>%
  setIDVar(name = "commodities", columns = c(2:6), rows = 4)

schema_idn_l3_16_01 <- schema_idn_l3_16 %>%
  setObsVar(name = "production", unit = "t", columns = c(2:6))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTimurVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_16_01,
         begin = 2015,
         end = 2015,
         archive = "KalimantanTimurVegiesProdSubDis15.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTimurFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_16_01,
         begin = 2015,
         end = 2015,
         archive = "KalimantanTimurFruitsProdSubDis15.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_16_02 <- schema_idn_l3_16 %>%
  setCluster(id = "al2", left = 1, top = 7, height = 11) %>%
  setIDVar(name = "commodities", columns = c(2:8), rows = 4) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:8))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanTimurForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_16_02,
         begin = 2015,
         end = 2015,
         archive = "KalimantanTimurForestSubDis15.xls",
         archiveLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltim.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_17 <-
  setFilter(rows = .find("Kalimantan..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 9) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:34), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:34), rows = 2)

schema_idn_l3_17_01 <- schema_idn_l3_17 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:34), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_17_01,
         begin = 2018,
         end = 2020,
         archive = "KalimanUtaraLivestock18-20.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_17_02 <- schema_idn_l3_17 %>%
  setIDVar(name = "year", columns = c(2:52), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:52), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:52), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraVegFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_17_02,
         begin = 2018,
         end = 2020,
         archive = "KalimanUtaraVegFruitProd18-20.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_17_03 <- schema_idn_l3_17 %>%
  setIDVar(name = "year", columns = c(2:49), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:49), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:25), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(25:49), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraCropsPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_17_03,
         begin = 2018,
         end = 2020,
         archive = "KalimanTimurPlantationCropsPlantProd18-20.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_17_04 <- schema_idn_l3_17 %>%
  setIDVar(name = "year", columns = c(2:37), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:37), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:19), top = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(20:37), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraMedPlantsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_17_04,
         begin = 2018,
         end = 2020,
         archive = "KalimanUtaraMedPlantsHarvProd18-20.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_17_05 <- schema_idn_l3_17 %>%
  setIDVar(name = "year", columns = c(2:19), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:19), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:19), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraOrnPlantsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_17_05,
         begin = 2018,
         end = 2020,
         archive = "KalimanUtaraOrnPlanstHarv08-20.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_17_06 <- schema_idn_l3_17 %>%
  setIDVar(name = "year", columns = c(2:10), rows = 3) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(8:10), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(5:7), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:4), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraPaddyHarvYieldProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_17_06,
         begin = 2018,
         end = 2020,
         archive = "KalimanUtaraPaddyHarvProdYield18-20.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_17_07 <- schema_idn_l3_17 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:7), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:7), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraPaddyRiceProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_17_07,
         begin = 2018,
         end = 2020,
         archive = "KalimanUtaraPaddyRiceProd18-20.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_17_08 <- schema_idn_l3_17 %>%
  setIDVar(name = "year", columns = c(4:17), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(4:17), rows = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = c(4:17), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_17_08,
         begin = 2014,
         end = 2018,
         archive = "KalimantanUtaraForestSubDis14-18.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_17_09 <- schema_idn_l3_17 %>%
  setIDVar(name = "year", columns = c(2:3), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:3), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:3), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraSoyMaizeProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_17_09,
         begin = 2015,
         end = 2015,
         archive = "KalimantanUtaraMaizeSoyProdSubDis15.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_18 <- setCluster(id = "al2", left = 1, top = 8, height = 6) %>%
  setIDVar(name = "al2", value = "Kalimantan Utara") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<!,)\\d.*") %>%
  setIDVar(name = "commodities", columns = c(2:5), rows = 4)

schema_idn_l3_18_01 <- schema_idn_l3_18 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:5))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_18_01,
         begin = 2013,
         end = 2013,
         archive = "KalimantanUtaraPoultrySubDis13.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_18_02 <- schema_idn_l3_18 %>%
  setIDVar(name = "commodities", columns = c(2:8), rows = 4) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:8))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_18_02,
         begin = 2013,
         end = 2013,
         archive = "KalimantanUtaraLivestockSubDis13.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_18_03 <- schema_idn_l3_18 %>%
  setCluster(id = "al2", left = 1, top = 6, height = 6) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "commodities", columns = c(2:5), rows = 5) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:5))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_18_03,
         begin = 2013,
         end = 2013,
         archive = "KalimantanUtaraForestSubDis13.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_18_04 <- schema_idn_l3_18 %>%
  setCluster(id = "al2", left = 1, top = 6, height = 6) %>%
  setIDVar(name = "commodities", columns = c(2:6), rows = 4) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:6))

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_18_04,
         begin = 2013,
         end = 2013,
         archive = "KalimantanUtaraFruitsProdSubDis13.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_18_04,
         begin = 2013,
         end = 2013,
         archive = "KalimantanUtaraVegiesProdSubDis13.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_18_05 <- schema_idn_l3_18 %>%
  setCluster(id = "al2", left = 1, top = 7) %>%
  setIDVar(name = "commodities", value = "paddy") %>%
  setObsVar(name = "harvested", unit = "ha", columns = 2) %>%
  setObsVar(name = "production", unit = "t", columns = 4)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraDryPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_18_05,
         begin = 2013,
         end = 2013,
         archive = "KalimantanUtraraDryPaddyHarvYieldProdSubDis13.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_18_05,
         begin = 2013,
         end = 2013,
         archive = "KalimantanUtraraPaddyHarvYieldProdSubDis13.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KalimanUtaraWetPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_18_05,
         begin = 2013,
         end = 2013,
         archive = "KalimantanUtraraWetPaddyHarvYieldProdSubDis13.xls",
         archiveLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kaltara.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_19 <-
  setFilter(rows = .find("Kepulauan Riau", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", value = "Kepulauan Riau") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:34), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:34), rows = 2)

schema_idn_l3_19_01 <- schema_idn_l3_19 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:34), factor = 1000, top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_01,
         begin = 2017,
         end = 2019,
         archive = "KepulauanRiauLivestockSubDis17-19.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_19_02 <- schema_idn_l3_19 %>%
  setIDVar(name = "year", columns = 2, rows = 2) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1, split = ".*(?=Pro)") %>%
  setObsVar(name = "production", unit = "n", columns = 2)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanMaizeProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_02,
         begin = 2019,
         end = 2019,
         archive = "KepulauanRiauMaizeProdSubDis19.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_19_03 <- schema_idn_l3_19 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 2) %>%
  setIDVar(name = "commodities", value = "paddy") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:3)) %>%
  setObsVar(name = "production", unit = "n", columns = c(4:5))  %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 0.1, columns = c(6:7))

regTable(nation = "idn",
         level = 3,
         subset = "KepulanPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_03,
         begin = 2018,
         end = 2019,
         archive = "KepulauanRiauPaddyProdSubDis18-19.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_19_04 <- schema_idn_l3_19 %>%
  setIDVar(name = "year", columns = c(2:31), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:31), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:31), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanMedPlantsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_04,
         begin = 2018,
         end = 2019,
         archive = "KepulauanRiauMedicialPlantsHarvSubDis18-19.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_19_05 <- schema_idn_l3_19 %>%
  setIDVar(name = "year", columns = c(2:49), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:49), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:49), factor = 0.0001, top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanOrnPlantsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_05,
         begin = 2018,
         end = 2019,
         archive = "KepulauanRiauOrnamentalPlantsHarvSubDis18-19.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_19_06 <- schema_idn_l3_19 %>%
  setIDVar(name = "year", columns = c(2:50), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:50), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:50), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanVegFruitHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_06,
         begin = 2018,
         end = 2019,
         archive = "KepulauanRiauSeasonalHorticultHarvSubDis18-19.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_19_07 <- schema_idn_l3_19 %>%
  setIDVar(name = "year", columns = c(2:25), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:25), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:25), factor = 1000, top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanEstateCropstHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_07,
         begin = 2017,
         end = 2019,
         archive = "KepulauanRiauPlantationCropsPlanSubDis17-19.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_19_08 <- schema_idn_l3_19 %>%
  setIDVar(name = "year", columns = c(2:25), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:25), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:25), factor = 1000, top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanEstateCropstProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_08,
         begin = 2017,
         end = 2019,
         archive = "KepulauanRiauPlantationCropsProdSubDis17-19.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_19_09 <- schema_idn_l3_19 %>%
  setIDVar(name = "year", columns = 2, rows = 3) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = 2, top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = 3, factor = 0.001, top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = 4, top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanClovePlantProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_09,
         begin = 2014,
         end = 2014,
         archive = "KepulauanRiauClovePlanProdYield14.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanCoconutPlantProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_09,
         begin = 2014,
         end = 2014,
         archive = "KepulauanRiauCoconutPlanProdYield14.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanPepperPlantProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_09,
         begin = 2014,
         end = 2014,
         archive = "KepulauanRiauPepperPlanProdYield14.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanRubberPlantProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_09,
         begin = 2014,
         end = 2014,
         archive = "KepulauanRiauPepperPlanProdYield14.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_19_10 <- schema_idn_l3_19 %>%
  setIDVar(name = "year", columns = c(2:209), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:209), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:209), factor = 0.1, top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanVegFruitsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_10,
         begin = 2012,
         end = 2019,
         archive = "KepulauanRiauSeasonalHorticultYieldSubDis12-19.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_19_11 <- schema_idn_l3_19 %>%
  setIDVar(name = "year", columns = c(2:183), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:183), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:183), factor = 0.1, top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanVegFruitsProd02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_11,
         begin = 2012,
         end = 2019,
         archive = "KepulauanRiauSeasonalHorticultProdSubDis12-19.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_19_12 <- schema_idn_l3_19 %>%
  setIDVar(name = "year", columns = c(2:121), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:121), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:121), factor = 0.001, top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanMedPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_12,
         begin = 2012,
         end = 2019,
         archive = "KepulauanRiauMedicialPlantsProdSubDis12-19.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_19_13 <- schema_idn_l3_19 %>%
  setIDVar(name = "year", columns = c(2:4), rows = 3) %>%
  setIDVar(name = "commodities", columns = 2, rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:4), factor = 0.001, top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanJasmineProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_13,
         begin = 2014,
         end = 2019,
         archive = "KepulauanRiauOrnamentalPlantsProdSubDis14-19.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_19_14 <- schema_idn_l3_19 %>%
  setIDVar(name = "year", columns = c(2:4), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:4), rows = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:4), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "KepulanForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_19_14,
         begin = 2014,
         end = 2014,
         archive = "KepulauanRiauForestrySubDis14.xls",
         archiveLink = "https://kepri.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://kepri.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_20 <-
  setIDVar(name = "al2", columns = 1, rows = 19) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:26), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:26), rows = 1, split = "(?<=\\().*")

schema_idn_l3_20_01 <- schema_idn_l3_20 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:26), factor = 1000, top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "LampungLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_20_01,
         begin = 2014,
         end = 2018,
         archive = "LampungLivestockSubDis14-18.xls",
         archiveLink = "https://lampung.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://lampung.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_20_02 <- schema_idn_l3_20 %>%
  setIDVar(name = "year", columns = c(2:5), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:5), rows = 1, split = "(?<=\\().*(?=\\))") %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:5), factor = 1000, top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "LampungPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_20_02,
         begin = 2014,
         end = 2014,
         archive = "LampungPoultrySubDis14.xls",
         archiveLink = "https://lampung.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://lampung.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_20_03 <- schema_idn_l3_20 %>%
  setIDVar(name = "year", columns = c(2:94), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:94), rows = 2, split = ".*(?=\\()") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:32), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(33:63), top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(64:94), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "LampungCropsHarvProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_20_03,
         begin = 2010,
         end = 2017,
         archive = "LampungCornPeanutsSoyHarvProdYieldSubDis10-17.xls",
         archiveLink = "https://lampung.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://lampung.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_20_04 <- schema_idn_l3_20 %>%
  setIDVar(name = "year", columns = c(2:25), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:25), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:25), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "LampungVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_20_04,
         begin = 2015,
         end = 2018,
         archive = "LampungVegiesHarvSubDis15-18.xls",
         archiveLink = "https://lampung.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://lampung.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_20_05 <- schema_idn_l3_20 %>%
  setIDVar(name = "year", columns = c(2:221), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:221), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(111:221), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:111), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "LampungCropsPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_20_05,
         begin = 2014,
         end = 2018,
         archive = "LampungPlantationCropsPlanProdSubDis14-18.xls",
         archiveLink = "https://lampung.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://lampung.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_20_06 <- schema_idn_l3_20 %>%
  setIDVar(name = "year", columns = c(2:19), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:19), rows = 1,  split = ".*(?=\\()") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:4, 11:13), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(5:7, 14:16), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(8:10, 17:19), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "LampungDryWetPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_20_06,
         begin = 2015,
         end = 2017,
         archive = "LampungDryWetPaddyHarvProdYieldSubDis15-17.xls",
         archiveLink = "https://lampung.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://lampung.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_20_07 <- schema_idn_l3_20 %>%
  setIDVar(name = "year", columns = 2, rows = 3) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1,  split = ".*(?=\\()") %>%
  setObsVar(name = "harvested", unit = "ha", columns = 2, top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = 3, top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = 4, top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "LampungPaddyHarvProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_20_07,
         begin = 2018,
         end = 2018,
         archive = "LampungPaddyHarvProdYieldSubDis18.xls",
         archiveLink = "https://lampung.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://lampung.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_20_08 <- schema_idn_l3_20 %>%
  setIDVar(name = "al2", columns = 1, rows = 18) %>%
  setIDVar(name = "year", columns = c(2:17), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:17), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:17))

regTable(nation = "idn",
         level = 3,
         subset = "LampungPaddyHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_20_08,
         begin = 2010,
         end = 2017,
         archive = "LampungDryWetPaddyHarvSubDis10-17.xls",
         archiveLink = "https://lampung.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://lampung.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_20_09 <- schema_idn_l3_20 %>%
  setIDVar(name = "al2", columns = 1, rows = 18) %>%
  setIDVar(name = "year", columns = c(2:9), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:9), rows = 1, split = "(?<=of).*(?=by)") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:9))

regTable(nation = "idn",
         level = 3,
         subset = "LampungPaddyProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_20_09,
         begin = 2010,
         end = 2017,
         archive = "LampungDryWetPaddyProdSubDis10-17.xls",
         archiveLink = "https://lampung.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://lampung.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_20_10 <- schema_idn_l3_20 %>%
  setIDVar(name = "al2", columns = 1, rows = 18) %>%
  setIDVar(name = "year", columns = c(2:13), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:13), rows = 1) %>%
  setObsVar(name = "production", unit = "kg/ha", factor = 100, columns = c(2:13))

regTable(nation = "idn",
         level = 3,
         subset = "LampungPaddyYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_20_10,
         begin = 2010,
         end = 2017,
         archive = "LampungDryWetPaddyYieldSubDis10-15.xls",
         archiveLink = "https://lampung.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://lampung.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_22 <- setCluster(id = "al2", left = 1, top = 6, height = 11) %>%
  setIDVar(name = "al2", columns = 1, rows = 17) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 2, split = "(?<!,)\\d.*") %>%
  setIDVar(name = "commodities", columns = c(2:5), rows = 4) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:5))

regTable(nation = "idn",
         level = 3,
         subset = "MalukuPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_22,
         begin = 2013,
         end = 2013,
         archive = "MalukuPoultrySubDis13.xls",
         archiveLink = "https://maluku.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://maluku.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_23 <-
  setIDVar(name = "al2", columns = 1, rows = 15) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 2, rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:13), rows = 1, split = "(?<=of).*") %>%
  setObsVar(name = "production", unit = "t", columns = c(2, 4, 6, 8, 10, 12), top = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(3, 5, 7, 9, 11, 13), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "MalukuCropsPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_23,
         begin = 2017,
         end = 2017,
         archive = "MalukuPlantationCropsProdPlanSubDis17.xls",
         archiveLink = "https://maluku.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://maluku.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_24 <-
  setIDVar(name = "al2", value = "Maluku Utara") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:22), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:22), rows = 2)

schema_idn_l3_24_01 <- schema_idn_l3_24 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:22), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "MalukuUtaraLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_24_01,
         begin = 2017,
         end = 2019,
         archive = "MalakaUtaralivestock2017-2019.xls",
         archiveLink = "https://malut.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://malut.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_24_02 <- schema_idn_l3_24 %>%
  setIDVar(name = "year", columns = c(2:71), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:71), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:31), factor = 1000, top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(31:71), factor = 1000, top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "MalukuUtaraCropsPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_24_02,
         begin = 2017,
         end = 2020,
         archive = "MalakaUtaraEstateCropsPlantProd2017-2020.xls",
         archiveLink = "https://malut.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://malut.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_25 <-
  setIDVar(name = "al2", columns = 1, rows = 14) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:61), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:61), rows = 2)

schema_idn_l3_25_01 <- schema_idn_l3_25 %>%
  setObsVar(name = "production", unit = "t", columns = c(2:61), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "MalukuUtaraFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_25_01,
         begin = 2015,
         end = 2019,
         archive = "MalakaUtaraFruitsProdSubDis15-19.xls",
         archiveLink = "https://malut.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://malut.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_25_02 <- schema_idn_l3_25 %>%
  setIDVar(name = "year", columns = c(2:155), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:155), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:85), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(86:155), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "MalukuUtaraVegHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_25_02,
         begin = 2015,
         end = 2020,
         archive = "MalakaUtaraHorticultHarvProdSubDis15-20.xls",
         archiveLink = "https://malut.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://malut.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_25_03 <- schema_idn_l3_25 %>%
  setIDVar(name = "year", columns = 2, rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:25), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:9), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(10:17), top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = c(18:25), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "MalukuUtaraCropHarvProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_25_03,
         begin = 2015,
         end = 2015,
         archive = "MalakaUtaraCropsHarvProdYield-2015.xls",
         archiveLink = "https://malut.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://malut.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_25_04 <- schema_idn_l3_25 %>%
  setIDVar(name = "year", columns = c(2:97), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:97), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:49), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(50:97), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "MalukuUtaraCropsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_25_04,
         begin = 2015,
         end = 2018,
         archive = "MalakaUtaraPlantationCropsPlanProdSubDis15-18.xls",
         archiveLink = "https://malut.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://malut.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_25_05 <- schema_idn_l3_25 %>%
  setIDVar(name = "year", columns = c(2:10), rows = 3) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1, split = "(?<=of).*(?=by)") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(8:10), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:4), top = 2) %>%
  setObsVar(name= "yield", unit = "kg/ha", factor = 100, columns = (5:7), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "MalukuUtaraPaddyHarvProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_25_05,
         begin = 2018,
         end = 2020,
         archive = "MalakaUtaraPaddyProdYieldHarvSubDis18-20.xls",
         archiveLink = "https://malut.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://malut.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_25_06 <- schema_idn_l3_25 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:7), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:7), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "MalukuUtaraPaddyRiceProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_25_06,
         begin = 2018,
         end = 2020,
         archive = "MalakaUtaraRicePaddyProd18-20.xls",
         archiveLink = "https://malut.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://malut.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_25_07 <- schema_idn_l3_25 %>%
  setIDVar(name = "year", columns = c(2:26), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:26), rows = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:26), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "MalukuUtaraForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_25_07,
         begin = 2015,
         end = 2019,
         archive = "MalakaUtaraForestSubDis15-19.xls",
         archiveLink = "https://malut.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://malut.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_25_08 <- schema_idn_l3_25 %>%
  setIDVar(name = "year", columns = c(2:73), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:73), rows = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:73), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaBaratLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_25_08,
         begin = 2012,
         end = 2019,
         archive = "NusaTenggaraBaratLivestockSubDis13-19.xls",
         archiveLink = "https://ntb.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntb.bps.go.id/site/pilihdata.htmll",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_25_09 <- schema_idn_l3_25 %>%
  setIDVar(name = "year", columns = c(2:97), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:97), rows = 2, split = "(?<=ites).*") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:33), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(66:73), top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(34:65), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaBaratCropHarvProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_25_09,
         begin = 2012,
         end = 2015,
         archive = "NusaTenggaraBaratFoodCropsProdHarvSubDis12-15.xls",
         archiveLink = "https://ntb.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntb.bps.go.id/site/pilihdata.htmll",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_25_10 <- schema_idn_l3_25 %>%
  setIDVar(name = "year", columns = 2, rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:8), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:8), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaBaratFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_25_10,
         begin = 2015,
         end = 2015,
         archive = "NusaTenggaraBaratFruitsProdSubDis15.xls",
         archiveLink = "https://ntb.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntb.bps.go.id/site/pilihdata.htmll",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_25_11 <- schema_idn_l3_25 %>%
  setIDVar(name = "year", columns = c(2:25), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:25), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:13), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(14:25), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaBaratVegHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_25_11,
         begin = 2015,
         end = 2015,
         archive = "NusaTenggaraBaratVegiesHarvProdSubDis15.xls",
         archiveLink = "https://ntb.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntb.bps.go.id/site/pilihdata.htmll",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_25_12 <- schema_idn_l3_25 %>%
  setIDVar(name = "year", columns = c(2:145), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:145), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:73), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(74:145), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaBaratVegHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_25_12,
         begin = 2015,
         end = 2020,
         archive = "NusaTenggaraBaratVegiesHarvProdSubDis15-20.xls",
         archiveLink = "https://ntb.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntb.bps.go.id/site/pilihdata.htmll",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_25_13 <- schema_idn_l3_25 %>%
  setIDVar(name = "year", columns = c(2:29), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:29), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(16:29), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:15), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaBaratCropsPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_25_13,
         begin = 2015,
         end = 2015,
         archive = "NusaTenggaraBaratPlantationCropsPlantProd2015xls.xls",
         archiveLink = "https://ntb.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntb.bps.go.id/site/pilihdata.htmll",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_25_14 <- schema_idn_l3_25 %>%
  setIDVar(name = "year", columns = c(2:29), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:29), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(16:29), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:15), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaBaratRiceHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_25_14,
         begin = 2018,
         end = 2020,
         archive = "NusaTenggaraBaratPaddyHarvProdSubDis18-20.xls",
         archiveLink = "https://ntb.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntb.bps.go.id/site/pilihdata.htmll",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_26 <-
  setIDVar(name = "al2", columns = 1, rows = 26) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:25), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:25), rows = 2)

schema_idn_l3_26_01 <- schema_idn_l3_26 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:25), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaTimurLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_26_01,
         begin = 2016,
         end = 2021,
         archive = "NusaTenggaraTimurLivestock2016-2021.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "NusaTimurPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_26_01,
         begin = 2016,
         end = 2021,
         archive = "NusaTenggaraTimurPoultry2016-2021.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_26_02 <- schema_idn_l3_26 %>%
  setIDVar(name = "year", columns = c(2:28), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:28), rows = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:28), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaTimurPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_26_02,
         begin = 2007,
         end = 2015,
         archive = "NusaTenggaraTimurPoultry2007-2015.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_26_03 <- schema_idn_l3_26 %>%
  setIDVar(name = "year", columns = c(2:19), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:19), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:10), top = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(11:19), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaTimurCropsHarvPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_26_03,
         begin = 2017,
         end = 2017,
         archive = "NusaTenggaraTimurFoodCropsHarvPlanSubDis17.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_26_04 <- schema_idn_l3_26 %>%
  setIDVar(name = "year", columns = c(2:10), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:10), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:10), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaTimurCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_26_04,
         begin = 2015,
         end = 2015,
         archive = "NusaTenggaraTimurFoodCropsProdSubDis15.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_26_05 <- schema_idn_l3_26 %>%
  setIDVar(name = "year", columns = c(2:97), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:97), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:49), top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = c(50:97), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaTimurCropsProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_26_05,
         begin = 2010,
         end = 2015,
         archive = "NusaTenggaraTimurFoodCropsProdYieldSubDis10-15.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_26_06 <- schema_idn_l3_26 %>%
  setIDVar(name = "year", columns = c(2:37), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:37), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:37), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaTimurFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_26_06,
         begin = 2015,
         end = 2020,
         archive = "NusaTenggaraTimurFruitProd15-20.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_26_07 <- schema_idn_l3_26 %>%
  setIDVar(name = "year", columns = c(2:41), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:41), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:41), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaTimurMedOrnHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_26_07,
         begin = 2015,
         end = 2020,
         archive = "NusaTenggaraTimurMedOrnamHarvest15-20.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_26_08 <- schema_idn_l3_26 %>%
  setIDVar(name = "year", columns = c(2:25), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:25), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:25), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaTimurMedProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_26_08,
         begin = 2015,
         end = 2021,
         archive = "NusaTenggaraTimurMedProd15-21.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_26_09 <- schema_idn_l3_26 %>%
  setIDVar(name = "year", columns = c(2:12), rows = 3) %>%
  setIDVar(name = "commodities", value = "paddy") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:5), top = 2) %>%
  setObsVar(name = "production", unit = "t",  columns = c(6:9), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = c(10:12), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "NusaTimurPaddyHarvProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_26_09,
         begin = 2015,
         end = 2021,
         archive = "NusaTenggaraTimurPaddyProdHarvYieldSubDis18-21.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_26_10 <- schema_idn_l3_26 %>%
  setIDVar(name = "year", columns = c(2:85), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:85), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:43), top = 1) %>%
  setObsVar(name = "production", unit = "t",  factor = 0.1, columns = c(44:85), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "NusaTimurVegHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_26_10,
         begin = 2016,
         end = 2021,
         archive = "NusaTenggaraTimurVegHarvProd16-21.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_26_11 <- schema_idn_l3_26 %>%
  setIDVar(name = "year", columns = c(2:19), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:13, 14:19), rows = c(2, 1)) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:19))

regTable(nation = "idn",
         level = 3,
         subset = "NusaTimurForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_26_11,
         begin = 2017,
         end = 2020,
         archive = "NusaTenggaraTimurForestrySubDis17-20.xls",
         archiveLink = "https://ntt.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ntt.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_27 <-
  setIDVar(name = "al2", columns = 1, rows = 33) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:74), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:74), rows = 2)

schema_idn_l3_27_01 <- schema_idn_l3_27 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:74), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "PapuaLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_27_01,
         begin = 2010,
         end = 2016,
         archive = "PapuaLivestockSubDis10-16.xls",
         archiveLink = "https://papua.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://papua.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_27_02 <- schema_idn_l3_27 %>%
  setIDVar(name = "year", columns = c(2:61), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:61), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:37), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(38:61), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "PapuaCropsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_27_02,
         begin = 2011,
         end = 2016,
         archive = "PapuaCropsHarvProdSubDis11-16.xls",
         archiveLink = "https://papua.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://papua.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_27_03 <- schema_idn_l3_27 %>%
  setIDVar(name = "year", columns = c(2:267), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:267), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:134), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(135:67), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "PapuaCropsHarvProd02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_27_03,
         begin = 2010,
         end = 2016,
         archive = "PapuaHoritcultureHarvProdSubDis10-16.xls",
         archiveLink = "https://papua.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://papua.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_27_04 <- schema_idn_l3_27 %>%
  setIDVar(name = "year", columns = c(2:73), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:73), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:37), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(38:73), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "PapuaCropsPlantProd03",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_27_04,
         begin = 2014,
         end = 2016,
         archive = "PapuaPlantationCropsHarvProdSubDis14-16.xls",
         archiveLink = "https://papua.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://papua.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_27_05 <- schema_idn_l3_27 %>%
  setIDVar(name = "al2", columns = 1, rows = 32) %>%
  setIDVar(name = "year", columns = c(2:5), rows = 2) %>%
  setIDVar(name = "commodities", value = "paddy") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:3), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(4:5), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "PapuaPaddyHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_27_05,
         begin = 2018,
         end = 2019,
         archive = "PapuaPaddyHarvProdSubDis18-19.xls",
         archiveLink = "https://papua.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://papua.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_27_06 <- schema_idn_l3_27 %>%
  setIDVar(name = "year", columns = c(2:21), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:21), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:11), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(12:21), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "PapuaWetDryPaddyHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_27_06,
         begin = 2011,
         end = 2015,
         archive = "PapuaWetDryPaddyHarvProdSubDis11-15.xls",
         archiveLink = "https://papua.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://papua.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_27_07 <- schema_idn_l3_27 %>%
  setIDVar(name = "year", columns = c(2:50), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:50), rows = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:50), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "PapuaForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_27_07,
         begin = 2010,
         end = 2016,
         archive = "PapuaForestSubDis10-16.xls",
         archiveLink = "https://papua.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://papua.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_28 <-
  setIDVar(name = "al2", columns = 1, rows = 17) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:74), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:74), rows = 2)

schema_idn_l3_28_01 <- schema_idn_l3_28 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:74), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "PapuaBaratLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_28_01,
         begin = 2005,
         end = 2018,
         archive = "PapuaBaratLivestockSubDis05-18.xls",
         archiveLink = "https://papuabarat.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://papuabarat.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_28_02 <- schema_idn_l3_28 %>%
  setIDVar(name = "year", columns = c(2:232), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:232), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:78), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(79:155), top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(156:232), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "PapuaBaratCropsProdHarvYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_28_02,
         begin = 2005,
         end = 2015,
         archive = "PapuaBaratFoodCropsHarvProdyieldSubDis05-15.xls",
         archiveLink = "https://papuabarat.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://papuabarat.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_28_03 <- schema_idn_l3_28 %>%
  setIDVar(name = "year", columns = c(2:221), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:221), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:221), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "PapuaBaratFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_28_03,
         begin = 2008,
         end = 2019,
         archive = "PapuaBaratFruitsProdSubDis08-19.xls",
         archiveLink = "https://papuabarat.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://papuabarat.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_28_04 <- schema_idn_l3_28 %>%
  setIDVar(name = "year", columns = c(2:133), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:133), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:133), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "PapuaBaratMedProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_28_04,
         begin = 2008,
         end = 2019,
         archive = "PapuaBaratMedicalPlantsProdSubDis08-19.xls",
         archiveLink = "https://papuabarat.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://papuabarat.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_28_05 <- schema_idn_l3_28 %>%
  setIDVar(name = "year", columns = c(2:301), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:301), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:301), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "PapuaBaratVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_28_05,
         begin = 2005,
         end = 2019,
         archive = "PapuaBaratVegiesProdSubDis05-19.xls",
         archiveLink = "https://papuabarat.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://papuabarat.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_28_06 <- schema_idn_l3_28 %>%
  setIDVar(name = "year", columns = c(2:57), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:57), rows = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:57), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "PapuaBaratForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_28_06,
         begin = 2012,
         end = 2019,
         archive = "PapuaBaratForestSubDis12-19.xls",
         archiveLink = "https://papuabarat.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://papuabarat.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_29 <- setCluster(id = "al2", left = 1, top = 4) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al2", columns = 1, rows = 16) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", columns = c(3:37), rows = 4) %>%
  setIDVar(name = "commodities", columns = c(3:37), rows = 3) %>%
  setObsVar(name = "area", unit = "ha", columns = c(3:37))

regTable(nation = "idn",
         level = 3,
         subset = "PapuaBaratForest02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_29,
         begin = 2010,
         end = 2014,
         archive = "PapuaBaratForestSubDis10-14.xls",
         archiveLink = "https://papuabarat.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://papuabarat.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_30 <-
  setIDVar(name = "al2", columns = 1, rows = 4) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:23), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:23), rows = 2)

schema_idn_l3_30_01 <- schema_idn_l3_30 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:23), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "RiauLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_30_01,
         begin = 2018,
         end = 2019,
         archive = "RiauLivestock2018-2019.xls",
         archiveLink = "https://riau.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://riau.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_30_02 <- schema_idn_l3_30 %>%
  setIDVar(name = "year", columns = c(2:3), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:3), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:3), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "RiauMaizeSoyProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_30_02,
         begin = 2018,
         end = 2019,
         archive = "RiauMaizeSoyProd2015.xls",
         archiveLink = "https://riau.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://riau.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_30_03 <- schema_idn_l3_30 %>%
  setIDVar(name = "year", columns = c(2:21), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:21), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:11), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(12:21), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "RiauCropsPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_30_03,
         begin = 2018,
         end = 2019,
         archive = "RiauEstateCropsPlantProd18-19.xls",
         archiveLink = "https://riau.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://riau.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_30_04 <- schema_idn_l3_30 %>%
  setIDVar(name = "year", columns = c(2:4), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:4), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:4), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "RiauRiceProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_30_04,
         begin = 2018,
         end = 2021,
         archive = "RiauRiceProd2019-2021.xls",
         archiveLink = "https://riau.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://riau.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_31 <-
  setIDVar(name = "al2", columns = 1, rows = 16) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:6), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:6), rows = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:6), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "RiauForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_31,
         begin = 2019,
         end = 2019,
         archive = "RiauForest2019.xls",
         archiveLink = "https://riau.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://riau.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_32 <-
  setIDVar(name = "al2", columns = 1, rows = 10) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:49), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:49), rows = 2)

schema_idn_l3_32_01 <- schema_idn_l3_32 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:49), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_32_01,
         begin = 2015,
         end = 2018,
         archive = "SulawesiBaratLivestockSubDis15-18.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_32_02 <- schema_idn_l3_32 %>%
  setIDVar(name = "year", columns = c(2:81), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:81), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:81), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCropsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_32_02,
         begin = 2008,
         end = 2017,
         archive = "SulawesiBaratFoodCropsHarvSubDis08-17.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_32_03 <- schema_idn_l3_32 %>%
  setIDVar(name = "year", columns = c(2:81), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:81), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:81), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_32_03,
         begin = 2008,
         end = 2017,
         archive = "SulawesiBaratFoodCropsProdSubDis08-17.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_32_04 <- schema_idn_l3_32 %>%
  setIDVar(name = "year", columns = c(6:21), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(6:21), rows = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = c(6:21), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_32_04,
         begin = 2015,
         end = 2018,
         archive = "SulawesiBaratForestSubDis15-18.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_32_05 <- schema_idn_l3_32 %>%
  setIDVar(name = "al2", columns = 1, rows = 9) %>%
  setIDVar(name = "year", columns = c(2:3), rows = 2) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:3))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratPaddyHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_32_05,
         begin = 2018,
         end = 2020,
         archive = "SulawesiBaratPaddyHarvSubDis18-20.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_32_06 <- schema_idn_l3_32 %>%
  setIDVar(name = "al2", columns = 1, rows = 9) %>%
  setIDVar(name = "year", columns = c(2:3), rows = 2) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:3))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratPaddyProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_32_06,
         begin = 2018,
         end = 2020,
         archive = "SulawesiBaratPaddyProdSubDis18-19.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_32_07 <- schema_idn_l3_32 %>%
  setIDVar(name = "year", columns = c(2:89), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:89), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:45), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(46:89), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCropsPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_32_07,
         begin = 2015,
         end = 2018,
         archive = "SulawesiBaratPlantationCropsPlanProdSubDis15-18.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_32_08 <- schema_idn_l3_32 %>%
  setIDVar(name = "year", columns = c(2:85), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:85), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:85), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_32_08,
         begin = 2006,
         end = 2018,
         archive = "SulawesiBaratVegiesHarvSubDis06-18.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_32_09 <- schema_idn_l3_32 %>%
  setIDVar(name = "year", columns = c(2:85), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:85), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:85), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_32_09,
         begin = 2006,
         end = 2017,
         archive = "SulawesiBaratVegiesProdSubDis06-17.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_32_10 <- schema_idn_l3_32 %>%
  setIDVar(name = "year", columns = c(2:5), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:5), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:5), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_32_10,
         begin = 2018,
         end = 2018,
         archive = "SulawesiBaratFoodCropsProdSubDis18.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_32_11 <- schema_idn_l3_32 %>%
  setIDVar(name = "year", columns = c(2:97), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:97), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:97), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_32_11,
         begin = 2007,
         end = 2018,
         archive = "SulawesiBaratFruitsProd07-18.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_32_12 <- schema_idn_l3_32 %>%
  setIDVar(name = "year", columns = c(2:8), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:8), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:8), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_32_12,
         begin = 2018,
         end = 2018,
         archive = "SulawesiBaratVegiesProdSubDis18.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_33 <- setCluster(id = "al2", left = 1, top = 7, height = 6) %>%
  setIDVar(name = "al2", columns = 1, rows = 13) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:15), rows = 4) %>%
  setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=of).*(?=by)") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 4, 6, 8, 10, 12, 14)) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 5, 7, 9, 11, 13, 15))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratSweetPotaHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_33,
         begin = 2005,
         end = 2011,
         archive = "SulawesiBaratSweetPotatoeHarvProdSubDis05-11.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratSoyHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_33,
         begin = 2005,
         end = 2011,
         archive = "SulawesiBaratSoyHarvProdSubDis05-11.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratPeanutHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_33,
         begin = 2005,
         end = 2011,
         archive = "SulawesiBaratPeanutsHarvProdSubDis05-11.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratMaizeHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_33,
         begin = 2005,
         end = 2011,
         archive = "SulawesiBaratMaizeHarvProdSubDis05-11.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratGreenBeaHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_33,
         begin = 2005,
         end = 2011,
         archive = "SulawesiBaratGreenBeanHarvProdSubDis05-11.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCassavaHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_33,
         begin = 2005,
         end = 2011,
         archive = "SulawesiBaratCassavaSubDis05-11.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_33_01 <- schema_idn_l3_33 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 4) %>%
  setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=of).*") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 5)) %>%
  setObsVar(name = "production", unit = "t", columns = c(4, 7))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratPaddyHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_33_01,
         begin = 2011,
         end = 2012,
         archive = "SulawesiBaratPaddyHarvYieldProdSubDis11-12.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_33_02 <- schema_idn_l3_33 %>%
  setIDVar(name = "year", columns = c(2:10), rows = 4) %>%
  setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=of).*") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 5, 8)) %>%
  setObsVar(name = "production", unit = "t", columns = c(4, 7, 10))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratPaddyHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_33_02,
         begin = 2008,
         end = 2010,
         archive = "SulawesiBaratPaddyHarvYieldProdSubDis08-10.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratPaddyHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_33_02,
         begin = 2005,
         end = 2007,
         archive = "SulawesiBaratPaddyHarvYieldProdSubDis05-07.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_34 <- setCluster(id = "al2", left = 1, top = 6, height = 6) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "al2", value = "Sulawesi Barat") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 2, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(2:43), rows = 4)

schema_idn_l3_34_00 <- schema_idn_l3_34 %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35, 38, 41)) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42)) %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCropsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_34_00,
         begin = 2006,
         end = 2006,
         archive = "SulawesiBaratPlantationCropsPlanProdSubDis06.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCropsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_34_00,
         begin = 2007,
         end = 2007,
         archive = "SulawesiBaratPlantationCropsPlanProdSubDis07.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_34_01 <- schema_idn_l3_34 %>%
  setIDVar(name = "commodities", columns = c(2:29), rows = 4) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28)) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCropsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_34_01,
         begin = 2008,
         end = 2008,
         archive = "SulawesiBaratPlantationCropsPlanProdSubDis08.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCropsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_34_01,
         begin = 2009,
         end = 2009,
         archive = "SulawesiBaratPlantationCropsPlanProdSubDis09.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_34_02 <- schema_idn_l3_34 %>%
  setIDVar(name = "commodities", columns = c(2:31), rows = 4,) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30)) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCropsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_34_02,
         begin = 2010,
         end = 2010,
         archive = "SulawesiBaratPlantationCropsPlanProdSubDis10.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCropsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_34_02,
         begin = 2011,
         end = 2011,
         archive = "SulawesiBaratPlantationCropsPlanProdSubDis11.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCropsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_34_02,
         begin = 2012,
         end = 2012,
         archive = "SulawesiBaratPlantationCropsPlanProdSubDis12.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_34_03 <- schema_idn_l3_34_02 %>%
  setCluster(id = "al2", left = 1, top = 6, height = 7)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCropsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_34_03,
         begin = 2013,
         end = 2013,
         archive = "SulawesiBaratPlantationCropsPlanProdSubDis13.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCropsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_34_03,
         begin = 2014,
         end = 2014,
         archive = "SulawesiBaratPlantationCropsPlanProdSubDis14.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_35 <- setCluster(id = "al2", left = 1, top = 6, height = 7) %>%
  setIDVar(name = "al2", value = "Sulawesi Barat") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 3, rows = 4) %>%
  setObsVar(name = "headcount", unit = "n", columns = 3)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCattle",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2012,
         end = 2012,
         archive = "SulawesiBaratBeefCattleSubDis12.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratCattle",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2013,
         end = 2013,
         archive = "SulawesiBaratBeefCattleSubDis13.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratBroilerChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2005,
         end = 2005,
         archive = "SulawesiBaratBroilerSubDis05.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratBroilerChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2012,
         end = 2012,
         archive = "SulawesiBaratBroilerSubDis12.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratBroilerChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2013,
         end = 2013,
         archive = "SulawesiBaratBroilerSubDis13.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratBuffalo",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2012,
         end = 2012,
         archive = "SulawesiBaratBuffaloSubDis12.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratBuffalo",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2013,
         end = 2013,
         archive = "SulawesiBaratBuffaloSubDis13.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratDairyCow",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2012,
         end = 2012,
         archive = "SulawesiBaratDiaryCowSubDis12.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratDairyCow",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2013,
         end = 2013,
         archive = "SulawesiBaratDiaryCowSubDis13.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratDuck",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2012,
         end = 2012,
         archive = "SulawesiBaratDuckSubDis12.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratGoat",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2012,
         end = 2012,
         archive = "SulawesiBaratGoatSubDis12.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratGoat",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2013,
         end = 2013,
         archive = "SulawesiBaratGoatSubDis13.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratHorse",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2012,
         end = 2012,
         archive = "SulawesiBaratHorseSubDis12.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratHorse",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2013,
         end = 2013,
         archive = "SulawesiBaratHorseSubDis13.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratNativeChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2012,
         end = 2012,
         archive = "SulawesiBaratNativeChickenSubDis12.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratNativeChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2013,
         end = 2013,
         archive = "SulawesiBaratNativeChickenSubDis13.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratPig",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2012,
         end = 2012,
         archive = "SulawesiBaratPigSubDis12.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratPig",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35,
         begin = 2013,
         end = 2013,
         archive = "SulawesiBaratPigSubDis13.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_35_01 <- schema_idn_l3_35 %>%
  setCluster(id = "al2", left = 1, top = 6, height = 6)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratBroilerChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35_01,
         begin = 2006,
         end = 2006,
         archive = "SulawesiBaratBroilerSubDis06.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratBroilerChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35_01,
         begin = 2007,
         end = 2007,
         archive = "SulawesiBaratBroilerSubDis07.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratBroilerChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35_01,
         begin = 2008,
         end = 2008,
         archive = "SulawesiBaratBroilerSubDis08.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratBroilerChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35_01,
         begin = 2009,
         end = 2009,
         archive = "SulawesiBaratBroilerSubDis09.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratBroilerChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35_01,
         begin = 2010,
         end = 2010,
         archive = "SulawesiBaratBroilerSubDis10.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratBroilerChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35_01,
         begin = 2011,
         end = 2011,
         archive = "SulawesiBaratBroilerSubDis11.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_35_02 <- schema_idn_l3_35 %>%
  setIDVar(name = "commodities", columns = 4, rows = 4)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratDuck",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35_02,
         begin = 2013,
         end = 2013,
         archive = "SulawesiBaratDuckSubDis13.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_35_03 <- schema_idn_l3_35 %>%
  setCluster(id = "al2", left = 1, top = 7, height = 6) %>%
  setIDVar(name = "commodities", columns = 3, rows = 5)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratNativeChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35_03,
         begin = 2005,
         end = 2005,
         archive = "SulawesiBaratNativeChickenSubDis05.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratNativeChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35_03,
         begin = 2006,
         end = 2006,
         archive = "SulawesiBaratNativeChickenSubDis06.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratNativeChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35_03,
         begin = 2007,
         end = 2007,
         archive = "SulawesiBaratNativeChickenSubDis07.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratNativeChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35_03,
         begin = 2008,
         end = 2008,
         archive = "SulawesiBaratNativeChickenSubDis08.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratNativeChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35_03,
         begin = 2009,
         end = 2009,
         archive = "SulawesiBaratNativeChickenSubDis09.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratNativeChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35_03,
         begin = 2010,
         end = 2010,
         archive = "SulawesiBaratNativeChickenSubDis10.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratNativeChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_35_03,
         begin = 2011,
         end = 2011,
         archive = "SulawesiBaratNativeChickenSubDis11.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_36 <- setCluster(id = "al2", left = 1, top = 5, height = 7) %>%
  setIDVar(name = "al2", value = "Sulawesi Barat") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:8), rows = 4) %>%
  setIDVar(name = "commodities", value = "pig") %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:8))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratPig",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_36,
         begin = 2005,
         end = 2011,
         archive = "SulawesiBaratPigSubDis05-11.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_37 <- setCluster(id = "al2", left = 1, top = 5, height = 6) %>%
  setIDVar(name = "al2", value = "Sulawesi Barat") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 2, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(2:9), rows = 4) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:9))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_37,
         begin = 2009,
         end = 2009,
         archive = "SulawesiBaratForestSubDis09.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_37,
         begin = 2010,
         end = 2010,
         archive = "SulawesiBaratForestSubDis10.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_37_01 <- schema_idn_l3_37 %>%
  setIDVar(name = "commodities", columns = c(2:8), rows = 4) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:8))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_37_01,
         begin = 2011,
         end = 2011,
         archive = "SulawesiBaratForestSubDis11.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_37_01,
         begin = 2012,
         end = 2012,
         archive = "SulawesiBaratForestSubDis12.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiBaratForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_37_01,
         begin = 2013,
         end = 2013,
         archive = "SulawesiBaratForestSubDis13.xls",
         archiveLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulbar.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_38 <-
  setIDVar(name = "al2", columns = 1, rows = 28) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:116), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:116), rows = 1)

schema_idn_l3_38_01 <- schema_idn_l3_38 %>%
  setIDVar(name = "commodities", columns = c(2:116), rows = 1,  split = ".*(?=Production)") %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:116), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanFruitVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_38_01,
         begin = 2016,
         end = 2020,
         archive = "SulawesiSelatanHorticultureProdSubDis16-20.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_38_02 <- schema_idn_l3_38 %>%
  setIDVar(name = "year", columns = c(2:134), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:134), rows = 1,  split = ".*(?=Production)") %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:134), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanFruitVegProd02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_38_02,
         begin = 2016,
         end = 2020,
         archive = "SulawesiSelatanHorticultureProdSubDis16-20-02.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_38_03 <- schema_idn_l3_38 %>%
  setIDVar(name = "year", columns = c(2:71), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:71), rows = 1,  split = ".*(?=Production)") %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:71), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanFruitVegProd03",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_38_03,
         begin = 2016,
         end = 2020,
         archive = "SulawesiSelatanHorticultureProdSubDis16-20-03.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_38_04 <- schema_idn_l3_38 %>%
  setCluster(id = "al2", left = 1, top = 4) %>%
  setIDVar(name = "al2", value = "Sulawesi Selatan") %>%
  setIDVar(name = "year", columns = c(2:31), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:31), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:31))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanCropsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_38_04,
         begin = 2015,
         end = 2019,
         archive = "SulawesiSelatanFoodCropsHarv15-19.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_38_05 <- schema_idn_l3_38 %>%
  setCluster(id = "al2", left = 1, top = 1, height = 27) %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:7), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 4, 6), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 5, 7), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanCropsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_38_05,
         begin = 2015,
         end = 2015,
         archive = "SulawesiSelatanFoodCropsHarvProdSubDis15.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_38_06 <- schema_idn_l3_38 %>%
  setCluster(id = "al2", left = 1, top = 4) %>%
  setIDVar(name = "al2", columns = 1, rows = 29) %>%
  setIDVar(name = "year", columns = c(2:13), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:13), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:13), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_38_06,
         begin = 2018,
         end = 2019,
         archive = "SulawesiSelatanFoodCropsProd18-19.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_38_07 <- schema_idn_l3_38 %>%
  setCluster(id = "al2", left = 1, top = 4) %>%
  setIDVar(name = "al2", columns = 1, rows = 29) %>%
  setIDVar(name = "year", columns = c(2:19), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:19), rows = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(2:19), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanCropsYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_38_07,
         begin = 2017,
         end = 2019,
         archive = "SulawesiSelatanFoodCropsYield17-19.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_38_08 <- schema_idn_l3_38 %>%
  setIDVar(name = "year", columns = c(2:13), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:13), rows = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:13), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_38_08,
         begin = 2015,
         end = 2015,
         archive = "SulawesiSelatanForestSubDis15.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_38_09 <- schema_idn_l3_38 %>%
  setIDVar(name = "al2", columns = 1, rows = 27) %>%
  setIDVar(name = "year", columns = c(2:31), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:31), rows = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:31))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanLivestock02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_38_09,
         begin = 2013,
         end = 2015,
         archive = "SulawesiSelatanLivestockSubDis13-15.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_38_10 <- schema_idn_l3_38 %>%
  setIDVar(name = "al2", columns = 1, rows = 27) %>%
  setIDVar(name = "year", columns = c(2:4), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:4), rows = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:4))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanLivestock03",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_38_10,
         begin = 2015,
         end = 2015,
         archive = "SulawesiSelatanLivestockSubDis15.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_38_11 <- schema_idn_l3_38 %>%
  setIDVar(name = "al2", columns = 1, rows = 27) %>%
  setIDVar(name = "year", columns = 2, rows = 2) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanLivestock04",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_38_11,
         begin = 2015,
         end = 2015,
         archive = "SulawesiSelatanLivestockSubDis15-02.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# for some reason schema does not read the numbers.
schema_idn_l3_38_12 <-  setCluster(id = "al2", left = 1, top = 1, height = 26) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "al2", columns = 1, rows = 27) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:3), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:3), rows = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:3))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanChicken",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_38_12,
         begin = 2013,
         end = 2015,
         archive = "SulawesiSelatanNativeChickenSubDis13-15.xlsx",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_38_13 <- schema_idn_l3_38 %>%
  setIDVar(name = "year", columns = c(2:17), rows = 3) %>%
  setIDVar(name = "commodities", columns = (2:17), rows = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:3, 6:7, 10:11, 14:15), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(4:5, 8:9, 12:13, 16:17), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanCropsPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_38_13,
         begin = 2013,
         end = 2014,
         archive = "SulawesiSelatanPlantationCropsPlanProdSubDis13-14.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_38_14 <- schema_idn_l3_38 %>%
  setIDVar(name = "al2", columns = 1, rows = 27) %>%
  setIDVar(name = "year", columns = c(2:5), rows = 2) %>%
  setIDVar(name = "commodities", columns = (2:5), rows = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:5))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_38_14,
         begin = 2013,
         end = 2014,
         archive = "SulawesiSelatanPlantationCropsProdSubDis15.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# The schema does not record values for harvested areas
schema_idn_l3_38_15 <- schema_idn_l3_38 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 2) %>%
  setIDVar(name = "commodities", columns = (2:7), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:4), top = 3) %>%
  setObsVar(name = "production", unit = "t", columns = c(5:7), top = 3)
#
# regTable(nation = "idn",
#          level = 3,
#          subset = "SulawesiSelantanRiceHarvProd",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = schema_idn_l3_38_15,
#          begin = 2018,
#          end = 2020,
#          archive = "SulawesiSelatanRiceHarvProd18-20.xls",
#          archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)

schema_idn_l3_38_16 <- schema_idn_l3_38 %>%
  setIDVar(name = "year", columns = c(2:4), rows = 2) %>%
  setIDVar(name = "commodities", columns = (2:4), rows = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(3:4), top = 3)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanDryRiceProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_38_16,
         begin = 2018,
         end = 2020,
         archive = "SulawesiSelatanRiceProd18-20.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_39 <- setCluster(id = "al2", left = 1, top = 4, height = 25) %>%
  setIDVar(name = "al2", columns = 1, rows = 29) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=Mey).*(?=by)") %>%
  setIDVar(name = "commodities", columns = c(2:5), rows = 4) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:5))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanLivestock01",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_39,
         begin = 2013,
         end = 2013,
         archive = "SulawesiSelatanLivestockSubDis13.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_40 <- setCluster(id = "al2", left = 2, top = 31, height = 23) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al2", columns = 2, rows = 57) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", columns = 13, rows = 4, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(16:125), rows = 9, split = "(?<=- ).*") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(17, 37, 56, 76, 95, 115), top = 21) %>%
  setObsVar(name = "production", unit = "t", columns = c(27, 47, 66, 86, 105, 125), top = 21)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanCropsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_40,
         begin = 2013,
         end = 2013,
         archive = "SulawesiSelatanFoodCropsHarvProdSubDis13.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_41 <- setCluster(id = "al2", left = 2, top = 27, height = 23) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al2", columns = 2, rows = 52) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", columns = 14, rows = 4, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(17:81), rows = 17) %>%
  setObsVar(name = "production", unit = "t", columns = c(18, 30, 42, 54, 63, 72, 81))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiSelantanFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_41,
         begin = 2013,
         end = 2013,
         archive = "SulawesiSelatanFruitsProdSubDis13.xls",
         archiveLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulsel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_42 <- setCluster(id = "al2", left = 2, top = 8, height = 14) %>%
  setFilter(rows = .find("Sulawesi Tengah", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 22) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=-).*") %>%
  setIDVar(name = "commodities", columns = c(2:3, 4:5), rows = c(7, 5)) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:5))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_42,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTengahPoultrySubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/318/populasi-unggas-ekor-menurut-kabupaten-kota-dan-jenisnya-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_42_01 <- schema_idn_l3_42 %>%
  setCluster(id = "al2", left = 2, top = 6, height = 14) %>%
  setIDVar(name = "al2", columns = 1, rows = 20) %>%
  setIDVar(name = "commodities", columns = c(2:4), rows = 5) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:4))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_42_01,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTengahSmallLivestockSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/319/populasi-ternak-kecil-ekor-menurut-kabupaten-kota-dan-jenisnya-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahLivestock02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_42_01,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTengahLargeLivestockSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/320/populasi-ternak-besar-ekor-menurut-kabupaten-kota-dan-jenisnya-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_43 <- setCluster(id = "al2", left = 2, top = 6, height = 15) %>%
  setFilter(rows = .find("Kota...", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 21) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(3:9), rows = 4) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(3:9))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_43,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTengahPoultrySubDis15.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2016/07/28/599/populasi-unggas-menurut-kabupaten-kota-dan-jenis-unggas-di-provinsi-sulawesi-tengah-2015-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_43,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTengahLivestockSubDis15.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2016/07/28/598/populasi-ternak-menurut-kabupaten-kota-dan-jenis-ternak-di-provinsi-sulawesi-tengah-2015-.htmll",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_43_01 <- schema_idn_l3_43 %>%
  setCluster(id = "al2", left = 2, top = 8, height = 14) %>%
  setIDVar(name = "al2", columns = 1, rows = 24) %>%
  setIDVar(name = "commodities", columns = c(3:9), rows = 5)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_43_01,
         begin = 2016,
         end = 2016,
         archive = "SulawesiTengahPoultrySubDis16.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2017/12/21/661/-populasi-ternak-menurut-kabupaten-kota-dan-jenis-ternak-di-provinsi-sulawesi-tengah-2016-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_44 <- setCluster(id = "al2", left = 2, top = 9, height = 14) %>%
  setIDVar(name = "al2", columns = 1, rows = 23) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=-).*") %>%
  setIDVar(name = "commodities", columns = 1, rows = 2, split = "(?<=of).*(?=,)")

schema_idn_l3_44_01 <- schema_idn_l3_44 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 2) %>%
  setObsVar(name = "production", unit = "t", columns = 3) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor =  100, columns = 4)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahCassava",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_44_01,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTengahCassavaHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/307/luas-panen-hasil-per-hektar-dan-produksi-ubi-kayu-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahMaize",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_44_01,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTengahMaizeHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/306/luas-panen-hasil-per-hektar-dan-produksi-jagung-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahGreenPeanuts",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_44_01,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTengahGreenPeanutsHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/311/luas-panen-hasil-per-hektar-dan-produksi-kacang-hijau-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahSoy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_44_01,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTengahSoyHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/310/luas-panen-hasil-per-hektar-dan-produksi-kacang-kedelai-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_44_01,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTengahDryWetPaddyHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/305/luas-panen-hasil-per-hektar-dan-produksi-padi-sawah-dan-ladang-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_44_02 <- schema_idn_l3_44_01 %>%
  setCluster(id = "al2", left = 2, top = 10, height = 14) %>%
  setIDVar(name = "al2", columns = 1, rows = 24)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahPeanut",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_44_02,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTengahPeanutsHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/309/luas-panen-hasil-per-hektar-dan-produksi-kacang-tanah-2010-2014-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahSweetPotato",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_44_02,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTengahSweetPotatoeHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2015/11/13/308/luas-panen-hasil-per-hektar-dan-produksi-ubi-jalar-2010---2014-.htmll",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_45 <- setCluster(id = "al2", left = 2, top = 7, height = 15) %>%
  setFormat(decimal = ",") %>%
  setFilter(rows = .find("Kota..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 22) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=h,).*") %>%
  setIDVar(name = "commodities", columns = c(3:9), rows = 4, split = "(?<=/).*") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(3, 7)) %>%
  setObsVar(name = "production", unit = "t", columns = c(4, 8)) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor =  100, columns = c(5, 9))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahCassavaSweetPotato",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_45,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTengahCassavaSweetPotatoeHarvProdYieldSubDis15.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2016/07/28/612/luas-panen-produksi-dan-produktivitas-ubi-kayu-dan-ubi-jalar-menurut-kabupaten-kota-di-provinsi-sulawesi-tengah-2015-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahMaizeSoy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_45,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTengahMaizeSoyHarvProdYieldSubDis15.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2016/07/28/609/luas-panen-produksi-dan-produktivitas-jagung-dan-kedelai-menurut-kabupaten-kota-di-provinsi-sulawesi-tengah-2015-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahWetDryPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_45,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTengahWetDryPaddyHarvProdYieldSubDis15.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2016/07/28/608/luas-panen-produksi-dan-produktivitas-padi-sawah-dan-padi-ladang-menurut-kabupaten-kota-di-provinsi-sulawesi-tengah-2015-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_45_01 <- schema_idn_l3_45 %>%
  setIDVar(name = "commodities", columns = c(3:10), rows = 4, split = "(?<=/).*") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(3, 7)) %>%
  setObsVar(name = "production", unit = "t", columns = c(4, 9)) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor =  100, columns = c(5, 10))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahPeanutMungbean",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_45_01,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTengahPeanutMungobeanHarvProdYieldSubDis15.xls",
         archiveLink = "https://sulteng.bps.go.id/statictable/2016/07/28/610/luas-panen-produksi-dan-produktivitas-kacang-tanah-dan-kacang-hijau-menurut-kabupaten-kota-di-provinsi-sulawesi-tengah-2015-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_46 <- setCluster(id = "al2", left = 1, top = 11, height = 15) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "al2", columns = 1, rows = 26) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 2, split = "(?<=-).*") %>%
  setIDVar(name = "commodities", columns = c(2:72), rows = 5, split = "(?<=/).*") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 6, 10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50, 54, 58, 62, 66, 70)) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 7, 11, 15, 19, 23, 27, 31, 35, 39, 43, 47, 51, 55, 59, 63, 67, 71)) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor =  100, columns = c(4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahVeg",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_46,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTengahVegiesHarvProdYieldSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_46_01 <- schema_idn_l3_46 %>%
  setCluster(id = "al2", left = 1, top = 10, height = 15) %>%
  setFilter(rows = .find("Kota..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 25) %>%
  setIDVar(name = "commodities", columns = c(2:76), rows = 4, split = "(?<=/).*") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 6, 10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50, 54, 58, 62, 66, 70, 74)) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 7, 11, 15, 19, 23, 27, 31, 35, 39, 43, 47, 51, 55, 59, 63, 67, 71, 75)) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor =  100, columns = c(4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahVeg",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_46_01,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTengahVegiesHarvProdYieldSubDis15.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_46_02 <- schema_idn_l3_46_01 %>%
  setIDVar(name = "year", columns = 1, rows = 26)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahVeg",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_46_02,
         begin = 2016,
         end = 2016,
         archive = "SulawesiTengahVegiesHarvProdYieldSubDis16.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_47 <- setCluster(id = "al2", left = 1, top = 11, height = 15) %>%
  setIDVar(name = "al2", columns = 1, rows = 26) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 2, split = "(?<=-).*") %>%
  setIDVar(name = "commodities", columns = c(2:36), rows = 6) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35)) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahPlantationCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_47,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTengahPlantationCropsPlanProdSmallSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_47_01 <- schema_idn_l3_47 %>%
  setCluster(id = "al2", left = 1, top = 10, height = 15) %>%
  setFormat(decimal = ",") %>%
  setFilter(rows = .find("Kota..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 25) %>%
  setIDVar(name = "commodities", columns = c(2:49), rows = 4) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 33, 36, 39, 42, 45, 48)) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 34, 37, 40, 43, 46, 49))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahPlantationCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_47_01,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTengahPlantationCropsPlanProdSmallSubDis15.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_47_02 <- schema_idn_l3_47_01 %>%
  setCluster(id = "al2", left = 1, top = 12, height = 15) %>%
  setIDVar(name = "al2", columns = 1, rows = 27) %>%
  setIDVar(name = "year", columns = 1, rows = 2, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(2:48), rows = 6) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47)) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 44, 48))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahPlantationCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_47_02,
         begin = 2016,
         end = 2016,
         archive = "SulawesiTengahPlantationCropsPlanProdSmallSubDis16.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_47_03 <- schema_idn_l3_47_01 %>%
  setIDVar(name = "commodities", columns = c(2:12), rows = 5) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2, 5, 8, 11)) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 6, 9, 12))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahPlantationCropsLarge",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_47_03,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTengahPlantationCropsPlanProdSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_47_04 <- schema_idn_l3_47_02 %>%
  setIDVar(name = "commodities", columns = c(2:48), rows = 7)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahPlantationCrops02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_47_04,
         begin = 2016,
         end = 2016,
         archive = "SulawesiTengahPlantationCropsPlanProdSubDis16.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_47_05 <- schema_idn_l3_47_01 %>%
  setIDVar(name = "al2", value = "Sulawesi Tengah") %>%
  setIDVar(name = "year", columns = 1, rows = 2, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(2:6), rows = 5) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2, 5)) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 6))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahRubberPalm",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_47_05,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTengahRubberPalmOilPlanProdSubDis15.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_48 <- setCluster(id = "al2", left = 1, top = 11, height = 15) %>%
  setIDVar(name = "al2", columns = 1, rows = 26) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=-).*") %>%
  setIDVar(name = "commodities", columns = c(2:7), rows = 6) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:7))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_48,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTengahForestSubDis14.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_48_01 <- schema_idn_l3_48 %>%
  setCluster(id = "al2", left = 1, top = 7, height = 15) %>%
  setFilter(rows = .find ("Kota..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 22) %>%
  setIDVar(name = "commodities", columns = c(2:7), rows = 5)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_48_01,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTengahForestSubDis15.xls",
         archiveLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_49 <-
  setIDVar(name = "al2", columns = 1, rows = 16) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:4), rows = 2) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1, split = "(?<=of).*(?=by)") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:4))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengahPaddyProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_49,
         begin = 2018,
         end = 2020,
         archive = "SulawesiTengahWetPaddyProdSubDis18-20.xls",
         archiveLink = "https://sulteng.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulteng.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_50 <- setCluster(id = "al2", left = 1, top = 3, height = 15) %>%
  setIDVar(name = "al2", columns = 1, rows = 19) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(2:4), rows = 3) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:4))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_50,
         begin = 2013,
         end = 2013,
         archive = "SulawesiTenggaraLivestockSubDis13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1687/populasi-ternak-besar-menurut-kabupaten-kota-ekor-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraLivestock02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_50,
         begin = 2013,
         end = 2013,
         archive = "SulawesiTenggaraSmallLivestockSubDis13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1688/populasi-ternak-kecil-menurut-kabupaten-kota-ekor-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_50_01 <- schema_idn_l3_50 %>%
  setCluster(id = "al2", left = 1, top = 3, height = 13) %>%
  setIDVar(name = "al2", columns = 1, rows = 17)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_50_01,
         begin = 2012,
         end = 2012,
         archive = "SulawesiTenggaraLivestockSubDis12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1819/populasi-ternak-besar-menurut-kabupaten-kota-ekor-2012.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraLivestock02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_50_01,
         begin = 2012,
         end = 2012,
         archive = "SulawesiTenggaraSmallLivestockSubDis12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1820/populasi-ternak-kecil-menurut-kabupaten-kota-ekor-2012.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_50_02 <- schema_idn_l3_50_01 %>%
  setCluster(id = "al2", left = 1, top = 2, height = 13) %>%
  setIDVar(name = "al2", columns = 1, rows = 15) %>%
  setIDVar(name = "commodities", columns = c(2:4), rows = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_50_02,
         begin = 2011,
         end = 2011,
         archive = "SulawesiTenggaraLivestockSubDis11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1819/populasi-ternak-besar-menurut-kabupaten-kota-ekor-2012.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_50_03 <- schema_idn_l3_50_01 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 15) %>%
  setIDVar(name = "al2", columns = 1, rows = 21)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_50_03,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTenggaraLivestockSubDis14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/847/populasi-ternak-besar-menurut-kabupaten-kota-ekor-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_50_04 <- schema_idn_l3_50 %>%
  setIDVar(name = "commodities", columns = c(2:5), rows = 3) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:5))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_50_04,
         begin = 2013,
         end = 2013,
         archive = "SulawesiTenggaraPoultrySubDis13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1689/populasi-ternak-unggas-menurut-kabupaten-kota-ekor-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_50_05 <- schema_idn_l3_50_01 %>%
  setIDVar(name = "commodities", columns = c(2:5), rows = 3) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:5))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_50_05,
         begin = 2012,
         end = 2012,
         archive = "SulawesiTenggaraPoultrySubDis12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1821/populasi-ternak-unggas-menurut-kabupaten-kota-ekor-2012.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_50_06 <- schema_idn_l3_50_03 %>%
  setIDVar(name = "commodities", columns = c(2:5), rows = 3) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:5))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_50_06,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTenggaraPoultrySubDis14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/851/populasi-ternak-unggas-menurut-kabupaten-kota-ekor-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_50_07 <- schema_idn_l3_50_02 %>%
  setIDVar(name = "commodities", columns = c(2:5), rows = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:5))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_50_07,
         begin = 2011,
         end = 2011,
         archive = "SulawesiTenggaraPoultrySubDis11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/16/2442/populasi-ternak-unggas-menurut-kabupaten-kota-ekor-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_51 <- setCluster(id = "al2", left = 1, top = 4, height = 20) %>%
  setFilter(rows = .find("Municipality", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 24) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(4:10), rows = 3) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(4:10))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_51,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTenggaraLivestockSubDis15.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/01/29/374/populasi-ternak-menurut-kabupaten-kota-dan-jenis-ternak-di-provinsi-sulawesi-tenggara-ekor-2015.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_51,
         begin = 2016,
         end = 2016,
         archive = "SulawesiTenggaraLivestockSubDis16.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/01/24/204/populasi-ternak-menurut-kabupaten-kota-dan-jenis-ternak-di-provinsi-sulawesi-tenggara-ekor-2016.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_51_01 <- schema_idn_l3_51 %>%
  setCluster(id = "al2", left = 1, top = 5, height = 20) %>%
  setFilter(rows = .find("Municipality", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 25)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_51_01,
         begin = 2017,
         end = 2017,
         archive = "SulawesiTenggaraLivestockSubDis17.xls",
         archiveLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_51_02 <- schema_idn_l3_51 %>%
  setIDVar(name = "commodities", columns = c(3:6), rows = 3) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(3:6))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_51_02,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTenggaraPoultrySubDis15.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/01/29/375/populasi-unggas-menurut-kabupaten-kota-dan-jenis-unggas-di-provinsi-sulawesi-tenggara-ekor-2015.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_51_03 <- schema_idn_l3_51 %>%
  setIDVar(name = "commodities", columns = c(4:7), rows = 3) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(4:7))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_51_03,
         begin = 2016,
         end = 2016,
         archive = "SulawesiTenggaraPoultrySubDis16.xls",
         archiveLink = "https://sultra.bps.go.id/indicator/24/376/1/poultry-population-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_51_03,
         begin = 2017,
         end = 2017,
         archive = "SulawesiTenggaraPoultrySubDis17.xls",
         archiveLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_52 <- setCluster(id = "al2", left = 1, top = 4, height = 18) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "al2", columns = 1, rows = 22) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(2:8), rows = 3) %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = c(2:8))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_52,
         begin = 2019,
         end = 2019,
         archive = "SulawesiTenggaraLivestockSubDis19.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2020/05/15/2783/populasi-ternak-menurut-kabupaten-kota-dan-jenis-ternak-di-provinsi-sulawesi-tenggara-ribu-ekor-2019.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_52_01 <- schema_idn_l3_52 %>%
  setIDVar(name = "commodities", columns = c(2:5), rows = 3) %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = c(2:5))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_52_01,
         begin = 2019,
         end = 2019,
         archive = "SulawesiTenggaraPoultrySubDis19.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2020/05/15/2786/populasi-unggas-menurut-kabupaten-kota-dan-jenis-unggas-di-provinsi-sulawesi-tenggara-ribu-ekor-2019.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_53 <- setCluster(id = "al2", left = 1, top = 4, height = 18) %>%
  setFilter(rows = .find("Municipality", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 24) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(3:15), rows = 3)

schema_idn_l3_53_01 <- schema_idn_l3_53 %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(3:15))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraFruit",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_53_01,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTenggaraFruitsHarvSubDis15.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraFruit",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_53_01,
         begin = 2017,
         end = 2017,
         archive = "SulawesiTenggaraFruitsProdSubDis17.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/03/1157/produksi-buah-buahan-menurut-kabupaten-kota-dan-jenis-sayuran-di-provinsi-sulawesi-tenggara-kuintal-2017.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_53_02 <- schema_idn_l3_53 %>%
  setCluster(id = "al2", left = 1, top = 3, height = 18) %>%
  setIDVar(name = "al2", columns = 1, rows = 21) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(2:26), rows = 2, split = "(?<=/).*") %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:26))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraFruit",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_53_02,
         begin = 2019,
         end = 2019,
         archive = "SulawesiTenggaraFruitsProdSubDis19.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_53_03 <- schema_idn_l3_53 %>%
  setIDVar(name = "commodities", columns = c(3:14), rows = 3) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(3:14))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_53_03,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTenggaraVegiesHarvSubDis14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/01/29/364/luas-panen-tanaman-sayuran-menurut-kabupaten-kota-dan-jenis-sayuran-di-provinsi-sulawesi-tenggara-hektar-2015.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_53_03,
         begin = 2016,
         end = 2016,
         archive = "SulawesiTenggaraVegiesHarvSubDis16.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/01/24/194/luas-panen-tanaman-sayuran-menurut-kabupaten-kota-dan-jenis-sayuran-di-provinsi-sulawesi-tenggara-hektar-2016.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_53_03,
         begin = 2017,
         end = 2017,
         archive = "SulawesiTenggaraVegiesHarvSubDis17.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/03/1155/luas-panen-tanaman-sayuran-menurut-kabupaten-kota-dan-jenis-sayuran-di-provinsi-sulawesi-tenggara-hektar-2017.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_53_04 <- schema_idn_l3_53 %>%
  setIDVar(name = "al2", columns = 1, rows = 22) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(2:27), rows = 3, split = "(?<=/).*") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:27))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_53_04,
         begin = 2019,
         end = 2019,
         archive = "SulawesiTenggaraVegiesHarvSubDis19.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_54 <- setCluster(id = "al2", left = 1, top = 4, height = 26) %>%
  setIDVar(name = "al2", value = "Sulawesi Tengarra") %>%
  setIDVar(name = "al3", columns = c(2:12), rows = 4) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:12))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraFruit",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_54,
         begin = 2012,
         end = 2012,
         archive = "SulawesiTenggaraFruitsProdSubDis12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1788/produksi-buah-buahan-menurut-jenis-buah-dan-kabupaten-kota-di-provinsi-sulawesi-tenggara-kuintal-2012.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_54_01 <- schema_idn_l3_54 %>%
  setCluster(id = "al2", left = 1, top = 5, height = 26) %>%
  setIDVar(name = "al3", columns = c(3:9), rows = 4) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(3:9))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraFruit",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_54_01,
         begin = 2013,
         end = 2013,
         archive = "SulawesiTenggaraFruitsProdSubDis13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1654/-produksi-buah-buahan-menurut-jenis-buah-dan-kabupaten-kota-di-provinsi-sulawesi-tenggara-kuintal-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_54_02 <- schema_idn_l3_54_01 %>%
  setIDVar(name = "al3", columns = c(3:16), rows = 4) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(3:16))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraFruit",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_54_02,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTenggaraFruitsProdSubDis14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/782/produksi-buah-buahan-menurut-jenis-buah-dan-kabupaten-kota-di-provinsi-sulawesi-tenggara-kuintal-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_55 <- setCluster(id = "al2", left = 1, top = 5, height = 14) %>%
  setIDVar(name = "al2", value = "Sulawesi Tengarra") %>%
  setIDVar(name = "al3", columns = c(2:13), rows = 4) %>%
  setIDVar(name = "year", value = "2012") %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:13))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_55,
         begin = 2012,
         end = 2012,
         archive = "SulawesiTenggaraVegiesProdSubDis12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1789/produksi-sayur-sayuran-yang-dipanen-berkali-kali-menurut-jenis-sayuran-dan-kabupaten-kota-kuinta-l-2012.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_55_01 <- schema_idn_l3_55 %>%
  setIDVar(name = "al3", columns = c(2:15), rows = 4) %>%
  setIDVar(name = "year", value = "2013") %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:15))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_55_01,
         begin = 2013,
         end = 2013,
         archive = "SulawesiTenggaraVegiesProdSubDis13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1655/produksi-sayur-sayuran-yang-dipanen-berkali-kali-menurut-jenis-sayuran-dan-kabupaten-kota-kuintal-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_55_02 <- schema_idn_l3_55 %>%
  setCluster(id = "al2", left = 1, top = 5, height = 15) %>%
  setIDVar(name = "al3", columns = c(2:15), rows = 4) %>%
  setIDVar(name = "year", value = "2014") %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:15))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_55_02,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTenggaraVegiesProdSubDis14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/785/produksi-sayur-sayuran-yang-dipanen-berkali-kali-menurut-jenis-sayuran-dan-kabupaten-kota-kuintal-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_56 <- setCluster(id = "al2", left = 1, top = 4, height = 20) %>%
  setFilter(rows = .find("Municipality", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 24) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(3:14), rows = 3) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(3:14))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_56,
         begin = 2017,
         end = 2017,
         archive = "SulawesiTenggaraVegiesProdSubDis17.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/03/1156/produksi-tanaman-sayuran-menurut-kabupaten-kota-dan-jenis-sayuran-di-provinsi-sulawesi-tenggara-kuintal-2017.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_56_01 <- schema_idn_l3_56 %>%
  setFormat(decimal = ",") %>%
  setCluster(id = "al2", left = 1, top = 5, height = 20) %>%
  setIDVar(name = "al2", columns = 1, rows = 25) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=ce,).*") %>%
  setIDVar(name = "commodities", columns = c(5:10), rows = 3) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(5, 8)) %>%
  setObsVar(name = "production", unit = "t", columns = c(6, 9)) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(7, 10))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraCassPot",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_56_01,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTenggaraCassavaSweetPotatoeHarvProdYieldSubDis15.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/01/24/186/luas-panen-produksi-dan-produktivitas-ubi-kayu-dan-ubi-jalar-menurut-kabupaten-kota-di-provinsi-sulawesi-tenggara-2015.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_56_01,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTenggaraDryWetPaddyHarvProdYieldSubDis15.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/01/24/183/luas-panen-produksi-dan-produktivitas-padi-sawah-dan-padi-ladang-menurut-kabupaten-kota-di-provinsi-sulawesi-tenggara-2015.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraMaizeSoy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_56_01,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTenggaraMaizeSoyHarvProdYieldSubDis15.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/01/24/184/luas-panen-produksi-dan-produktivitas-jagung-dan-kedelai-menurut-kabupaten-kota-di-provinsi-sulawesi-tenggara-2015.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPeanutBean",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_56_01,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTenggaraPeanutHarvProdYieldSubDis15.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/01/24/185/luas-panen-produksi-dan-produktivitas-kacang-tanah-dan-kacang-hijau-menurut-kabupaten-kota-di-provinsi-sulawesi-tenggara-2015.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_57 <- setCluster(id = "al2", left = 1, top = 4, height = 18) %>%
  setIDVar(name = "al2", columns = 1, rows = 22) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(2:27), rows = 3, split = "(?<=/).*") %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:27))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_57,
         begin = 2019,
         end = 2019,
         archive = "SulawesiTenggaraVegiesProdSubDis19.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_58 <- setCluster(id = "al2", left = 1, top = 3, height = 18) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "al2", columns = 1, rows = 21) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(2:3), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:3))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPaddyRice",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_58,
         begin = 2019,
         end = 2019,
         archive = "SulawesiTenggaraDryWetPaddyProdSubDis19.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_59 <- setCluster(id = "al2", left = 1, top = 3, height = 10) %>%
  setFilter(rows = 4, invert = TRUE) %>%
  setIDVar(name = "al2", value = "Sulawesi Tengarra") %>%
  setIDVar(name = "al3", columns = c(2:13), rows = 3) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = 1)

schema_idn_l3_59_00 <- schema_idn_l3_59 %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:13))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraCropsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_59_00,
         begin = 2011,
         end = 2011,
         archive = "SulawesiTenggaraFoodCropsHarvSubDis11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/12/2339/luas-panen-tanaman-bahan-makanan-menurut-kabupaten-kota-dan-jenis-tanaman-ha-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_59_01 <- schema_idn_l3_59 %>%
  setFilter(rows = 5, invert = TRUE) %>%
  setCluster(id = "al2", left = 1, top = 4, height = 10) %>%
  setIDVar(name = "al3", columns = c(2:13), rows = 4) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:13))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraCropsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_59_01,
         begin = 2012,
         end = 2012,
         archive = "SulawesiTenggaraFoodCropsHarvSubDis12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1782/luas-panen-tanaman-bahan-makanan-menurut-kabupaten-kota-dan-jenis-tanaman-ha-2012.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_59_02 <- schema_idn_l3_59 %>%
  setCluster(id = "al2", left = 1, top = 5, height = 10) %>%
  setFilter(rows = 6, invert = TRUE) %>%
  setIDVar(name = "al3", columns = c(2:15), rows = 4) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:15))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraCropsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_59_02,
         begin = 2013,
         end = 2013,
         archive = "SulawesiTenggaraFoodCropsHarvSubDis13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1647/luas-panen-tanaman-bahan-makanan-menurut-kabupaten-kota-dan-jenis-tanaman-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraCropsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_59_02,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTenggaraFoodCropsHarvSubDis14.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_59_03 <- schema_idn_l3_59 %>%
  setObsVar(name = "production", unit = "t", columns = c(2:13))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_59_03,
         begin = 2011,
         end = 2011,
         archive = "SulawesiTenggaraFoodCropsProdSubDis11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/12/2337/produksi-tanaman-bahan-makanan-menurut-kabupaten-kota-dan-jenis-tanaman-ton-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_59_04 <- schema_idn_l3_59 %>%
  setFilter(rows = 5, invert = TRUE) %>%
  setCluster(id = "al2", left = 1, top = 4, height = 10) %>%
  setIDVar(name = "al3", columns = c(2:13), rows = 4) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:13))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_59_04,
         begin = 2012,
         end = 2012,
         archive = "SulawesiTenggaraFoodCropsProdSubDis12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1781/produksi-tanaman-bahan-makanan-menurut-kabupaten-kota-dan-jenis-tanaman-ton-2012.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_59_05 <- schema_idn_l3_59 %>%
  setCluster(id = "al2", left = 1, top = 5, height = 10) %>%
  setFilter(rows = 6, invert = TRUE) %>%
  setIDVar(name = "al3", columns = c(2:15), rows = 4) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:15))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_59_05,
         begin = 2013,
         end = 2013,
         archive = "SulawesiTenggaraFoodCropsProdSubDis13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1646/produksi-tanaman-bahan-makanan-menurut-kabupaten-kota-dan-jenis-tanaman-ton-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_59_06 <- schema_idn_l3_59 %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(2:13))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraCropsYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_59_06,
         begin = 2011,
         end = 2011,
         archive = "SulawesiTenggaraFoodCropsYieldSubDis11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/12/2341/hasil-perhektar-tanaman-bahan-makanan-menurut-kabupaten-kota-dan-jenis-tanaman-ku-ha-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_59_07 <- schema_idn_l3_59 %>%
  setFilter(rows = 5, invert = TRUE) %>%
  setCluster(id = "al2", left = 1, top = 4, height = 10) %>%
  setIDVar(name = "al3", columns = c(2:13), rows = 4) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(2:13))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraCropsYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_59_07,
         begin = 2012,
         end = 2012,
         archive = "SulawesiTenggaraFoodCropsYieldSubDis12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1783/hasil-perhektar-tanaman-bahan-makanan-menurut-kabupaten-kota-dan-jenis-tanaman-ku-ha-2012.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_59_08 <- schema_idn_l3_59 %>%
  setCluster(id = "al2", left = 1, top = 5, height = 10) %>%
  setFilter(rows = 6, invert = TRUE) %>%
  setIDVar(name = "al3", columns = c(2:15), rows = 4) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(2:15))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraCropsYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_59_08,
         begin = 2013,
         end = 2013,
         archive = "SulawesiTenggaraFoodCropsYieldSubDis13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1648/hasil-per-hektar-tanaman-bahan-makanan-menurut-kabupaten-kota-dan-jenis-tanaman-ku-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_59_09 <- schema_idn_l3_59_08 %>%
  setFormat(decimal = ",")

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraCropsYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_59_09,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTenggaraFoodCropsYieldSubDis14.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_60 <- setCluster(id = "al2", left = 1, top = 3, height = 7) %>%
  setIDVar(name = "al2", value = "Sulawesi Tengarra") %>%
  setIDVar(name = "al3", columns = c(2:13), rows = 3) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:13))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_60,
         begin = 2011,
         end = 2011,
         archive = "SulawesiTenggaraForestSubDis11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/16/2472/luas-kawasan-hutan-dan-perairan-yang-telah-ditetapkan-menurut-kabupaten-kota-ha-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_60_01 <- schema_idn_l3_60 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 7) %>%
  setIDVar(name = "al3", columns = c(2:13), rows = 4)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_60_01,
         begin = 2012,
         end = 2012,
         archive = "SulawesiTenggaraForestSubDis12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1832/luas-kawasan-hutan-dan-perairan-yang-telah-ditetapkan-menurut-kabupaten-kota-ha-2012.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_60_02 <- schema_idn_l3_60_01 %>%
  setIDVar(name = "al3", columns = c(2:15), rows = 4) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:15))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_60_02,
         begin = 2013,
         end = 2013,
         archive = "SulawesiTenggaraForestSubDis13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1703/luas-kawasan-hutan-dan-perairan-yang-telah-ditetapkan-menurut-kabupaten-kota-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_60_03 <- schema_idn_l3_60 %>%
  setCluster(id = "al2", left = 1, top = 5, height = 7) %>%
  setIDVar(name = "al3", columns = c(3:14), rows = 4) %>%
  setObsVar(name = "area", unit = "ha", columns = c(3:14))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_60_03,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTenggaraForestSubDis14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/876/luas-kawasan-hutan-dan-perairan-yang-telah-ditetapkan-menurut-kabu--paten-kota-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# schema not working because of the different positions of the comoddities names
schema_idn_l3_61 <- setCluster(id = "al2", left = 2, top = 5, height = 20) %>%
  setFilter(rows = .find("Municipality", col= 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 25) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", value = "forest") %>%
  setObsVar(name = "area", unit = "ha", columns = 14)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_61,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTenggaraForestSubDis15.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/01/29/389/luas-kawasan-hutan-dan-perairan-menurut-kabupaten-kota-di-provinsi-sulawesi-tenggara-hektar-2015.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_61,
         begin = 2017,
         end = 2017,
         archive = "SulawesiTenggaraForestSubDis17.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/03/1171/luas-kawasan-hutan-dan-perairan-menurut-kabupaten-kota-di-provinsi-sulawesi-tenggara-hektar-2017.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_61_01 <- schema_idn_l3_61 %>%
  setObsVar(name = "area", unit = "ha", columns = 9)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_61_01,
         begin = 2016,
         end = 2016,
         archive = "SulawesiTenggaraForestSubDis16.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_62 <- setCluster(id = "al2", left = 1, top = 5, height = 19) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "al2", columns = 1, rows = 22) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(3:7), rows = 4) %>%
  setObsVar(name = "area", unit = "ha", factor = 1000, columns = c(3:7))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_62,
         begin = 2019,
         end = 2019,
         archive = "SulawesiTenggaraForestSubDis19.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2020/05/15/2780/luas-kawasan-hutan-dan-perairan-menurut-kabupaten-kota-di-provinsi-sulawesi-tenggara-ribu-ha-2019.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_63 <- setCluster(id = "al2", left = 1, top = 3, height = 11) %>%
  setIDVar(name = "al2", value = "Sulawesi Tengarra") %>%
  setIDVar(name = "al3", columns = c(2:13), rows = 3) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:13))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_63,
         begin = 2011,
         end = 2011,
         archive = "SulawesiTenggaraFurtherVegiesProdSubDis11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/12/2356/produksi-sayur-sayuran-yang-dipanen-sekaligus-menurut-jenisnya-dan-kabupaten-kota-kuintal-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_63_01 <- schema_idn_l3_63 %>%
  setCluster(id = "al2", left = 1, top = 5, height = 11) %>%
  setIDVar(name = "al3", columns = c(3:14), rows = 4) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=al\\)).*") %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(3:14))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraVegProd02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_63_01,
         begin = 2012,
         end = 2012,
         archive = "SulawesiTenggaraFurtherVegiesProdSubDis12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1790/produksi-sayur-sayuran-yang-dipanen-sekaligus-menurut-jenis-sayuran-dan-kabupaten-kota-kuintal-2012.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraVegProd02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_63_01,
         begin = 2013,
         end = 2013,
         archive = "SulawesiTenggaraFurtherVegiesProdSubDis13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1656/produksi-sayur-sayuran-yang-dipanen-sekaligus-menurut-jenis-sayuran-dan-kabupaten-kota-kuintal-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraVegProd02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_63_01,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTenggaraFurtherVegiesProdSubDis14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/786/produksi-sayur-sayuran-yang-dipanen-sekaligus-menurut-jenis-sayuran-dan-kabupaten-kota-kuintal-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_63_02 <- schema_idn_l3_63_01 %>%
  setCluster(id = "al2", left = 1, top = 5, height = 16)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraMedPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_63_02,
         begin = 2012,
         end = 2012,
         archive = "SulawesiTenggaraMedicalPlantsProdSubDis12.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_63_03 <- schema_idn_l3_63_01 %>%
  setCluster(id = "al2", left = 1, top = 5, height = 16) %>%
  setIDVar(name = "al3", columns = c(3:16), rows = 4) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(3:16))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraMedPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_63_03,
         begin = 2013,
         end = 2013,
         archive = "SulawesiTenggaraMedicalPlantsProdSubDis13.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraMedPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_63_03,
         begin = 2014,
         end = 2014,
         archive = "SulawesiTenggaraMedicalPlantsProdSubDis14.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_64 <- setCluster(id = "al2", left = 1, top = 4, height = 18) %>%
  setIDVar(name = "al2", columns = 1, rows = 22) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(2:10, 13:16), rows = 3, split = "(?<=/).*")

schema_idn_l3_64_01 <- schema_idn_l3_64 %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:10, 13:16))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraMedPlantsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_64_01,
         begin = 2019,
         end = 2019,
         archive = "SulawesiTenggaraMedicalPlantsHarvSubDis19.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/12/2356/produksi-sayur-sayuran-yang-dipanen-sekaligus-menurut-jenisnya-dan-kabupaten-kota-kuintal-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_64_02 <- schema_idn_l3_64 %>%
  setIDVar(name = "commodities", columns = c(2:16), rows = 3, split = "(?<=/).*") %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:16))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraMedPlantsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_64_02,
         begin = 2019,
         end = 2019,
         archive = "SulawesiTenggaraMedicalPlantsProdSubDis19.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/12/2356/produksi-sayur-sayuran-yang-dipanen-sekaligus-menurut-jenisnya-dan-kabupaten-kota-kuintal-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_64_03 <- schema_idn_l3_64 %>%
  setIDVar(name = "commodities", columns = c(2:18, 20:25), rows = 3, split = "(?<=/).*") %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:18, 20:25))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraOrnPlantsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_64_03,
         begin = 2019,
         end = 2019,
         archive = "SulawesiTenggaraOrnamentalPlantsHarvSubDis19.xls",
         archiveLink = "https://sultra.bps.go.id/subject/55/hortikultura.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_65 <- setCluster(id = "al2", left = 1, top = 3, height = 18) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "al2", columns = 1, rows = 21) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=ce,).*") %>%
  setIDVar(name = "commodities", value = "paddy") %>%
  setObsVar(name = "harvested", unit = "ha", columns = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = 3) %>%
  setObsVar(name = "production", unit = "t", columns = 4)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_65,
         begin = 2019,
         end = 2019,
         archive = "SulawesiTenggaraPaddyHarvProdYieldSubDis19.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_66 <- setCluster(id = "al2", left = 2, top = 4, height = 20) %>%
  setFilter(rows = .find("Municipality", col = 1), invert= TRUE) %>%
  setIDVar(name = "al2", columns = 1, rows = 24) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(3:16), rows = 3)

schema_idn_l3_66_01 <- schema_idn_l3_66 %>%
  setObsVar(name = "planted", unit = "ha", columns = c(3:16))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPlantCropsPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_66_01,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTenggaraPlantationCropsPlanSubDis15.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/01/29/370/luas-tanaman-perkebunan-menurut-kabupaten-kota-dan-jenis-tanaman-di-provinsi-sulawesi-tenggara-hektar-2015.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPlantCropsPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_66_01,
         begin = 2017,
         end = 2017,
         archive = "SulawesiTenggaraPlantationCropsPlanSubDis17.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_66_02 <- schema_idn_l3_66 %>%
  setIDVar(name = "commodities", columns = c(4:17), rows = 3) %>%
  setObsVar(name = "production", unit = "t", columns = c(4:17))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_66_02,
         begin = 2015,
         end = 2015,
         archive = "SulawesiTenggaraPlantationCropsProdSubDis15.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/01/29/371/produksi-tanaman-perkebunan-menurut-kabupaten-kota-dan-jenis-tanaman-di-provinsi-sulawesi-tenggara-ton-2015.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_66_02,
         begin = 2017,
         end = 2017,
         archive = "SulawesiTenggaraPlantationCropsProdSubDis17.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_66_03 <- schema_idn_l3_66 %>%
  setIDVar(name = "commodities", columns = c(3:14), rows = 3) %>%
  setObsVar(name = "production", unit = "t", columns = c(3:14))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_66_03,
         begin = 2016,
         end = 2016,
         archive = "SulawesiVegiesProdSubDis16.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/01/29/371/produksi-tanaman-perkebunan-menurut-kabupaten-kota-dan-jenis-tanaman-di-provinsi-sulawesi-tenggara-ton-2015.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_67 <- setCluster(id = "al2", left = 2, top = 3, height = 18) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "al2", columns = 1, rows = 21) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(2:9), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 1000, columns = c(2:9))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_67,
         begin = 2019,
         end = 2019,
         archive = "SulawesiTenggaraPlantationCropsProdSubDis16.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2021/04/28/3133/produksi-perkebunan-menurut-kabupaten-kota-dan-jenis-tanaman-ton-2019-dan-2020.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_68 <-
  setIDVar(name = "al2", columns = 1, rows = 21) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:29), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:29), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:15)) %>%
  setObsVar(name = "production", unit = "t", columns = c(16:29))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTengarraPlantCropsPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_68,
         begin = 2016,
         end = 2016,
         archive = "SulawesiTenggaraPlantationPlanProdCropsSubDis16.xls",
         archiveLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/154/pertanian.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_69 <-
  setIDVar(name = "al2", columns = 1, rows = 19) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:99), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:99), rows = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:99), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_69,
         begin = 2008,
         end = 2021,
         archive = "SulawesiUtaraLivestockSubDis08-21.xls",
         archiveLink = "https://sulut.bps.go.id/indicator/24/171/1/livestock-population-by-regency-city-and-by-types-of-livestock-sulawesi-utara.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_70 <-
  setIDVar(name = "al2", columns = 1, rows = 19) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:169), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:169), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:9, 26:33, 58:65, 74:81, 98:105, 122:129, 146:153), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(10:17, 34:41, 66:73, 82:89, 106:113, 130:137, 154:161), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(18:25, 42:49, 50:57, 90:97, 114:121, 138:145, 162:169), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraFoodCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70,
         begin = 2008,
         end = 2015,
         archive = "SulawesiUtaraFoodCropsHarvProdYieldSubDis08-15.xls",
         archiveLink = "https://sulut.bps.go.id/indicator/24/171/1/livestock-population-by-regency-city-and-by-types-of-livestock-sulawesi-utara.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_70_01 <- schema_idn_l3_70 %>%
  setIDVar(name = "year", columns = c(2:13), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:13), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(6:9), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(10:13), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(2:5), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_01,
         begin = 2018,
         end = 2021,
         archive = "SulawesiUtaraPaddyHarvProdYieldSubDis18-21.xls",
         archiveLink = "https://sulut.bps.go.id/indicator/24/171/1/livestock-population-by-regency-city-and-by-types-of-livestock-sulawesi-utara.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraAmaranth",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_01,
         begin = 2003,
         end = 2008,
         archive = "SulawesiUtaraAmaranthHarvProdYieldSubDis03-08.xls",
         archiveLink = "https://sulut.bps.go.id/indicator/24/171/1/livestock-population-by-regency-city-and-by-types-of-livestock-sulawesi-utara.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_70_02 <- schema_idn_l3_70 %>%
  setIDVar(name = "year", columns = 2, rows = 3) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 4, top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = 3, top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = 2, top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraCauliflower",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_02,
         begin = 2009,
         end = 2009,
         archive = "SulawesiUtaraCauliflowerYieldProdHarvSubDis09.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraRadish",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_02,
         begin = 2009,
         end = 2009,
         archive = "SulawesiUtraraRadishHarvProdYieldSubDis09.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_70_03 <- schema_idn_l3_70 %>%
  setIDVar(name = "year", columns = c(2:22), rows = 3) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(16:22), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(9:15), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = c(2:8), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraLeek",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_03,
         begin = 2003,
         end = 2012,
         archive = "SulawesiUtaraLeeksHarvProdYieldSubDis03-12.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_70_04 <- schema_idn_l3_70 %>%
  setIDVar(name = "year", columns = c(2:13), rows = 3) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(10:13), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(6:9), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = c(2:5), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraSapodilas",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_04,
         begin = 2005,
         end = 2009,
         archive = "SulawesiUtaraSapodillasHarvProdYieldSubDis05-09.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraCabbage",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_04,
         begin = 2003,
         end = 2008,
         archive = "SulawesiUtaraSwampCabbageHarvProdYieldSubDis03-08.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraEggplant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_04,
         begin = 2003,
         end = 2008,
         archive = "SulawesiUtraraEggplantHarvProdYieldSubDis03-08.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_70_05 <- schema_idn_l3_70 %>%
  setIDVar(name = "year", columns = c(2:19), rows = 3) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(14:19), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(8:13), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = c(2:7), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraShallots",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_05,
         begin = 2003,
         end = 2010,
         archive = "SulawesiUtaraShallotsHarvProdYieldSubDis03-10.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_70_06 <- schema_idn_l3_70 %>%
  setIDVar(name = "year", columns = c(2:16), rows = 3) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(12:16), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(7:11), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = c(2:6), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraTomato",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_06,
         begin = 2003,
         end = 2009,
         archive = "SulawesiUtaraTomatoHarvProdYieldSubDis03-09.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraCarrot",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_06,
         begin = 2003,
         end = 2009,
         archive = "SulawesiUtraraCarrotsHarvProdYieldSubDis03-09.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraMustard",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_06,
         begin = 2003,
         end = 2009,
         archive = "SulawesiUtraraGreenMustardHarvProdYieldSubDis03-09.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraMelon",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_06,
         begin = 2009,
         end = 2015,
         archive = "SulawesiUtraraMelonHarvProdYieldSubDis09-15.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraPatato",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_06,
         begin = 2003,
         end = 2009,
         archive = "SulawesiUtraraPotatoeHarvProdYieldSubDis03-09.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_70_07 <- schema_idn_l3_70 %>%
  setIDVar(name = "year", columns = c(2:10), rows = 3) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(8:10), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(5:7), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = c(2:4), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraChilly",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_07,
         begin = 2004,
         end = 2009,
         archive = "SulawesiUtraraBigChilliHarvProdYieldSubDis04-09.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraPepper",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_07,
         begin = 2009,
         end = 2011,
         archive = "SulawesiUtraraCayennePepperHarvProdYieldSubDis09-11.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraLongBean",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_07,
         begin = 2009,
         end = 2011,
         archive = "SulawesiUtraraLongBeansHarvProdYieldSubDis09-11.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraRedBean",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_70_07,
         begin = 2009,
         end = 2011,
         archive = "SulawesiUtraraRedBeansHarvProdYieldSubDis09-11.xls",
         archiveLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab5",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_71 <- setCluster(id = "al2", left = 2, top = 3, height = 16) %>%
  setIDVar(name = "al2", columns = 1, rows = 19) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(10:17), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(10:17), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(10:17), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraBioHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_71,
         begin = 2017,
         end = 2018,
         archive = "SulawesiUtaraVegiesHarvProdYield17-18.xls",
         archiveLink = "https://sulut.bps.go.id/indicator/24/171/1/livestock-population-by-regency-city-and-by-types-of-livestock-sulawesi-utara.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraFlowerHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_71,
         begin = 2017,
         end = 2018,
         archive = "SulawesiUtaraOrnamentalPlantsHarvProd17-18.xls",
         archiveLink = "https://sulut.bps.go.id/indicator/24/171/1/livestock-population-by-regency-city-and-by-types-of-livestock-sulawesi-utara.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_71_01 <- schema_idn_l3_71 %>%
  setIDVar(name = "year", columns = c(2:17), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:17), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:17), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraGladiolus",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_71_01,
         begin = 2003,
         end = 2018,
         archive = "SulawesiUtaraGladiolusHarvSubDis03-18.xls",
         archiveLink = "https://sulut.bps.go.id/indicator/24/171/1/livestock-population-by-regency-city-and-by-types-of-livestock-sulawesi-utara.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_71_02 <- schema_idn_l3_71 %>%
  setIDVar(name = "year", columns = c(2:131), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:131), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:131), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraOrnPlantsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_71_02,
         begin = 2008,
         end = 2018,
         archive = "SulawesiUtaraOrnamentalPlantsHarvSubDis08-18.xls",
         archiveLink = "https://sulut.bps.go.id/indicator/24/171/1/livestock-population-by-regency-city-and-by-types-of-livestock-sulawesi-utara.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_72 <- setCluster(id = "al2", left = 2, top = 3, height = 16) %>%
  setIDVar(name = "al2", columns = 1, rows = 19) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:66), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:66), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:66), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraCropsPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_72,
         begin = 2014,
         end = 2021,
         archive = "SulawesiUtaraPlantationCropsPlanSmallEstateTotalSubDis14-21.xls",
         archiveLink = "https://sulut.bps.go.id/indicator/24/171/1/livestock-population-by-regency-city-and-by-types-of-livestock-sulawesi-utara.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_72_01 <- schema_idn_l3_72 %>%
  setIDVar(name = "year", columns = c(2:40), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:40), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:40), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraCropsSmallPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_72_01,
         begin = 2014,
         end = 2016,
         archive = "SulawesiUtaraPlantationCropsPlanSmallSubDis14-16.xls",
         archiveLink = "https://sulut.bps.go.id/indicator/24/171/1/livestock-population-by-regency-city-and-by-types-of-livestock-sulawesi-utara.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_73 <- setCluster(id = "al2", left = 2, top = 3, height = 16) %>%
  setIDVar(name = "al2", columns = 1, rows = 19) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:66), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:66), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:66), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_73,
         begin = 2014,
         end = 2021,
         archive = "SulawesiUtaraPlantationCropsProdSmallEstateTotalSubDis14-21.xls",
         archiveLink = "https://sulut.bps.go.id/indicator/24/171/1/livestock-population-by-regency-city-and-by-types-of-livestock-sulawesi-utara.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_74 <- setCluster(id = "al2", left = 2, top = 3, height = 16) %>%
  setIDVar(name = "al2", columns = 1, rows = 19) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:31), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:31), rows = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:31), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiUtaraForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_74,
         begin = 2016,
         end = 2021,
         archive = "SulawesiUtaraForestSubDis16-21.xls",
         archiveLink = "https://sulut.bps.go.id/indicator/24/171/1/livestock-population-by-regency-city-and-by-types-of-livestock-sulawesi-utara.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sulut.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_75 <- setCluster(id = "al2", left = 2, top = 3, height = 18) %>%
  setIDVar(name = "al2", columns = 1, rows = 21) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:78), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:78), rows = 1)

schema_idn_l3_75_01 <- schema_idn_l3_75 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:78), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_75_01,
         begin = 2015,
         end = 2021,
         archive = "SumateraSelatanLivestockSubDis15-21.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_75_02 <- schema_idn_l3_75 %>%
  setIDVar(name = "year", columns = c(2:29), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:29), rows = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:29), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_75_02,
         begin = 2015,
         end = 2021,
         archive = "SumateraSelatanForestrySubDis15-21.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_75_03 <- schema_idn_l3_75 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:7), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:7), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanPaddyHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_75_03,
         begin = 2015,
         end = 2017,
         archive = "SumateraSelatanDryWetPaddyHarvSubDis15-17.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_75_04 <- schema_idn_l3_75 %>%
  setIDVar(name = "year", columns = c(2:9), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:9), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:9), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SumuateraSelatanMedPlantsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_75_04,
         begin = 2018,
         end = 2019,
         archive = "SumateraSelatanMedicialPlantsHarvProdSubDis18-19.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_75_05 <- schema_idn_l3_75 %>%
  setIDVar(name = "year", columns = c(2:9), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:9), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:9), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanOrnHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_75_05,
         begin = 2018,
         end = 2019,
         archive = "SumateraSelatanOrnamentalPlantsHarvProdSubDis18-19.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_75_06 <- schema_idn_l3_75 %>%
  setCluster(id = "al2", left = 2, top = 2, height = 18) %>%
  setIDVar(name = "al2", columns = 1, rows = 20) %>%
  setIDVar(name = "year", columns = c(2:13), rows = 2) %>%
  setIDVar(name = "commodities", value = "paddy") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:5), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(6:9), top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(10:13), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_75_06,
         begin = 2018,
         end = 2021,
         archive = "SumateraSelatanPaddyHarvProdYieldSubDis18-21.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_75_07 <- schema_idn_l3_75 %>%
  setIDVar(name = "year", columns = c(2:92), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:92), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:43), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(44:92), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanCropsPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_75_07,
         begin = 2013,
         end = 2019,
         archive = "SumateraSelatanPlantationCropsPlanProdSubDis13-19.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_75_08 <- schema_idn_l3_75 %>%
  setIDVar(name = "year", columns = c(2:91), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:91), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:31), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(32:61), top = 1) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(62:91), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanCropsHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_75_08,
         begin = 2015,
         end = 2019,
         archive = "SumateraSelatanScndHarvCropsHarvProdYieldSubDis15-19.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_75_09 <- schema_idn_l3_75 %>%
  setIDVar(name = "year", columns = c(2:51), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:51), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:26), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(27:51), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanVegHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_75_09,
         begin = 2015,
         end = 2019,
         archive = "SumateraSelatanVegiesHarvProdSubDis15-19.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_75_10 <- schema_idn_l3_75 %>%
  setIDVar(name = "year", columns = c(2:3), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:3), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:3), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanPaddyProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_75_10,
         begin = 2015,
         end = 2015,
         archive = "SumateraSelatanWetDryPaddyYieldSubDis15.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_75_11 <- schema_idn_l3_75 %>%
  setIDVar(name = "year", columns = c(10:13), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(10:13), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(10:13), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "SumuateraSelatanMedPlantsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_75_11,
         begin = 2018,
         end = 2019,
         archive = "SumateraSelatanMedicialPlantsHarvProdSubDis18-19.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_76 <- setCluster(id = "al2", left = 2, top = 6, height = 16) %>%
  setIDVar(name = "al2", value = "Sumatera Selatan") %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", value = "2013") %>%
  setIDVar(name = "commodities", columns = c(4:8), rows = 5) %>%
  setObsVar(name = "area", unit = "ha", columns = c(4:8))

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_76,
         begin = 2013,
         end = 2013,
         archive = "SumateraSelatanForestrySubDis13.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_77 <- setCluster(id = "al2", left = 2, top = 7, height = 18) %>%
  setIDVar(name = "al2", value = "Sumatera Selatan") %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", columns = 3, rows = 2, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = c(4:6), rows = 6) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(4:6))

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_77,
         begin = 2014,
         end = 2014,
         archive = "SumateraSelatanLivestockSubDis14.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_77_01 <- schema_idn_l3_77 %>%
  setIDVar(name = "commodities", columns = c(4:10), rows = 6) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(4:10))

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_77_01,
         begin = 2014,
         end = 2014,
         archive = "SumateraSelatanPoultrySubDis14.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_78 <-
  setIDVar(name = "al2", columns = 1, rows = 20) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:7), rows = 2) %>%
  setIDVar(name = "commodities", value = "reforested land") %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:7))

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanReforestation",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_78,
         begin = 2014,
         end = 2019,
         archive = "SumateraSelatanReforestationSubDis14-19.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_79 <-
  setIDVar(name = "al2", columns = 1, rows = 4) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:50), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:50), rows = 2)

schema_idn_l3_79_01 <- schema_idn_l3_79 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:50), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "DIYogyakartaLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_79_01,
         begin = 2010,
         end = 2016,
         archive = "YogyakartaLivestockSubDis10-16.xls",
         archiveLink = "https://yogyakarta.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://yogyakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_79_02 <- schema_idn_l3_79 %>%
  setIDVar(name = "year", columns = c(2:106), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:106), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:106), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "DIYogyakartaCropsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_79_02,
         begin = 2012,
         end = 2016,
         archive = "YogyakartaHorticultureHarvSubDis12-16.xls",
         archiveLink = "https://yogyakarta.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://yogyakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_79_03 <- schema_idn_l3_79 %>%
  setIDVar(name = "year", columns = c(2:43), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:43), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:43), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "DIYogyakartaCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_79_03,
         begin = 2015,
         end = 2016,
         archive = "YogyakartaHorticultureProdSubDis15-16.xls",
         archiveLink = "https://yogyakarta.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://yogyakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_79_04 <- schema_idn_l3_79 %>%
  setIDVar(name = "year", columns = c(2:85), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:85), rows = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(2:85), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "DIYogyakartaCropsYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_79_04,
         begin = 2012,
         end = 2016,
         archive = "YogyakartaHorticultureYieldSubDis12-15.xls",
         archiveLink = "https://yogyakarta.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://yogyakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_79_05 <- schema_idn_l3_79 %>%
  setIDVar(name = "year", columns = c(2:101), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:101), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:101), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "DIYogyakartaCropsPlant02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_79_05,
         begin = 2012,
         end = 2016,
         archive = "YogyakartaPlantationCropsPlanSubDis12-16.xls",
         archiveLink = "https://yogyakarta.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://yogyakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_80 <- setCluster(id = "al2", left = 1, top = 3, height = 26) %>%
  setIDVar(name = "al2", value = "Sulawesi Tenggara") %>%
  setIDVar(name = "al3", columns = c(2:13), rows = 3) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:13))

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTenggaraFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_80,
         begin = 2011,
         end = 2011,
         archive = "SulawesiTenggaraFruitsProdSubDis11.xlsx",
         archiveLink = "https://sultra.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_80_01 <- schema_idn_l3_80 %>%
  setCluster(id = "al2", left = 1, top = 3, height = 14)

regTable(nation = "idn",
         level = 3,
         subset = "SulawesiTenggaraVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_80_01,
         begin = 2011,
         end = 2011,
         archive = "SulawesiTenggaraVegiesProdSubDis11.xlsx",
         archiveLink = "https://sultra.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_81 <-
  setIDVar(name = "al2", columns = 1, rows = 13) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:113), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:113), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:113), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "BaliCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_81,
         begin = 2000,
         end = 2015,
         archive = "BaliFoodCropsProdSubDis00-15.xls",
         archiveLink = "https://bali.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bali.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_82 <-
  setIDVar(name = "al2", columns = 1, rows = 12) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:442), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:442), rows = 1, split = ".*(?=Produc)") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:442))

regTable(nation = "idn",
         level = 3,
         subset = "BaliCropsProd02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_82,
         begin = 2000,
         end = 2020,
         archive = "BaliHorticultureSubDisProd00-21.xls",
         archiveLink = "https://bali.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bali.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_82_01 <- schema_idn_l3_82 %>%
  setIDVar(name = "year", columns = c(2:176), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:176), rows = 1, split = "(?<=of ).*(?= by)") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:176))

regTable(nation = "idn",
         level = 3,
         subset = "BaliCropsProd03",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_82_01,
         begin = 2000,
         end = 2020,
         archive = "BaliPlantationCropsProdSubDis00-21.xls",
         archiveLink = "https://bali.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bali.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_82_02 <- schema_idn_l3_82 %>%
  setIDVar(name = "year", columns = c(2:20), rows = 2) %>%
  setIDVar(name = "commodities", columns = c(2:20), rows = 1, split = "(?<=of ).*(?= by)") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:20))

regTable(nation = "idn",
         level = 3,
         subset = "BaliVanillaProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_82_02,
         begin = 2000,
         end = 2018,
         archive = "BaliVanillaProdSubDis00-18.xls",
         archiveLink = "https://bali.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bali.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_83 <- setCluster(id = "al2", left = 1, top = 7, height = 10) %>%
  setIDVar(name = "al2", value = "Bali") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:7), rows = 7) %>%
  setIDVar(name = "commodities", value = "paddy") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:3)) %>%
  setObsVar(name = "production", unit = "t", columns = c(4:5)) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(6:7))

regTable(nation = "idn",
         level = 3,
         subset = "BaliPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_83,
         begin = 2000,
         end = 2020,
         archive = "BaliPaddyHarvProdYieldSubDis18-19.xls",
         archiveLink = "https://bali.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bali.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_84 <-
  setIDVar(name = "al2", columns = 1, rows = 3) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:29), rows = 2) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1, split = "(?<=of ).*(?=\\(T)") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(16:29)) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:15))

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungCassava",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_84,
         begin = 2003,
         end = 2016,
         archive = "BangkaBelitungCassavaProdHarvSubDis03-16.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_84_01 <- schema_idn_l3_84 %>%
  setIDVar(name = "al2", value = "Bangka Belitung")

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungDryLandPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_84_01,
         begin = 2003,
         end = 2016,
         archive = "BangkaBelitungDryPaddyProdHarvSubDis03-16.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungPeanut",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_84_01,
         begin = 2003,
         end = 2016,
         archive = "BangkaBelitungPeanutProdHarvSubDis03-16.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungSweetPotato",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_84_01,
         begin = 2003,
         end = 2016,
         archive = "BangkaBelitungSweetPotatoeProdHarvSubDis03-16.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_84_02 <- schema_idn_l3_84_01 %>%
  setIDVar(name = "year", columns = c(2:31), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(17:31)) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:16))

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungMaize",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_84_02,
         begin = 2001,
         end = 2016,
         archive = "BangkaBelitungMaizeProdHarvSubDis01-16.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_85 <-
  setIDVar(name = "al2", value = "Bangka Belitung") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:17), rows = 2) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1, split = "(?<=of ).*(?=\\(T)")

schema_idn_l3_85_01 <- schema_idn_l3_85 %>%
  setObsVar(name = "production", unit = "t", columns = c(2:17))

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungWetPaddyProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_85_01,
         begin = 2001,
         end = 2016,
         archive = "BangkaBelitungWetPaddyProdHarvSubDis03-16.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_85_02 <- schema_idn_l3_85 %>%
  setIDVar(name = "year", columns = c(18:31), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(18:31))

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungWetPaddyHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_85_02,
         begin = 2003,
         end = 2016,
         archive = "BangkaBelitungWetPaddyProdHarvSubDis03-16.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_85_03 <- schema_idn_l3_85 %>%
  setFilter(rows = .find("Jumlah", col = 1), invert = TRUE) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1, split = ".*(?=P)") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:17))

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungPepperProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_85_03,
         begin = 2001,
         end = 2016,
         archive = "BangkaBelitungPepperProdSubDis01-16.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_85_04 <- schema_idn_l3_85 %>%
  setIDVar(name = "al3", columns = 1, rows = 3) %>%
  setIDVar(name = "year", columns = c(2:15), rows = 2) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:15))

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungPaddyHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_85_04,
         begin = 2001,
         end = 2014,
         archive = "BangkaBelitungPaddySubDis01-14.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_86 <- setCluster(id = "al2", left = 1, top = 4, height = 8) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al2", value = "Bangka Belitung") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:15), rows = 4) %>%
  setIDVar(name = "commodities", columns = 1, rows = 1, split = ".*(?=P)")

schema_idn_l3_86_01 <- schema_idn_l3_86 %>%
  setObsVar(name = "production", unit = "t", columns = c(2:15))

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungCoconut",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_86_01,
         begin = 2001,
         end = 2014,
         archive = "BangkaBelitungCoconutProdSubDis01-14.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungRubber",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_86_01,
         begin = 2001,
         end = 2014,
         archive = "BangkaBelitungRubberProdSubDis01-14.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_86_02 <- schema_idn_l3_86 %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "year", columns = c(2:16), rows = 4) %>%
  setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=of).*(?=by)") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:16))

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungPalmOil",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_86_02,
         begin = 2001,
         end = 2015,
         archive = "BangkaBelitungPalmOilProdSubDis01-14.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_86_03 <- schema_idn_l3_86 %>%
  setIDVar(name = "year", columns = c(2:13), rows = 4) %>%
  setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=s).*(?=Pr)") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:13))

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungCoffee",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_86_03,
         begin = 2004,
         end = 2015,
         archive = "BangkaBelitungCoffeeProdSmallSubDis04-15.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_86_04 <- schema_idn_l3_86 %>%
  setIDVar(name = "year", columns = c(2:15), rows = 4) %>%
  setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=l ).*(?=P)") %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:15))

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungCows",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_86_04,
         begin = 2001,
         end = 2015,
         archive = "BangkaBelitungCowSubDis01-15.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_87 <- setCluster(id = "al2", left = 1, top = 3, height = 8) %>%
  setIDVar(name = "al2", value = "Bangka Belitung") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:16), rows = 3) %>%
  setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=of).*(?=by)") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:16))

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungPaddyHarv01",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_87,
         begin = 2001,
         end = 2015,
         archive = "BangkaBelitungPaddyHarvSubDis01-15.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_88 <-
  setIDVar(name = "al2", columns = 1, rows = 3) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:13), rows = 2) %>%
  setIDVar(name = "commodities", columns = 2, rows = 1, split = "(?<=of ).*(?=\\(t)") %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:13))

regTable(nation = "idn",
         level = 3,
         subset = "BangkaBelitungDuck",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_88,
         begin = 2004,
         end = 2015,
         archive = "BangkaBelitungPoultrySubDis04-15.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_89 <-
  setIDVar(name = "al2", columns = 1, rows = 12) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:188), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:188), rows = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:188), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "BantenLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_89,
         begin = 2005,
         end = 2021,
         archive = "BantenLivestockSubDis05-21.xls",
         archiveLink = "https://babel.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://babel.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_90 <- setCluster(id = "al2", left = 1, top = 4, height = 24) %>%
  setIDVar(name = "al2", value = "Sulawesi Tenggara") %>%
  setIDVar(name = "al3", columns = 1, rows = 1, split = "(?<=in ).*(?=\\()") %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = 5)

regTable(nation = "idn",
         level = 3,
         subset = "BauBauPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90,
         begin = 2014,
         end = 2014,
         archive = "BauBauPlantationCropsPlan14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/844/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kota-bau-bau-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "ButonPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90,
         begin = 2014,
         end = 2014,
         archive = "ButonPlantationCropsPlan14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/817/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-buton-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "ButonUtaraPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90,
         begin = 2014,
         end = 2014,
         archive = "ButonUtaraPlantationCropsPlan14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/834/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-buton-utara-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "BombanaPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90,
         begin = 2014,
         end = 2014,
         archive = "BombanaPlantationCropsPlan14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/827/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-bombana-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KendariPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90,
         begin = 2014,
         end = 2014,
         archive = "KendariPlantationCropsPlan14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/843/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kota-kendari-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "MunaPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90,
         begin = 2014,
         end = 2014,
         archive = "MunaPlantationCropsPlan14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/820/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-muna-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonaweUtaraPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90,
         begin = 2014,
         end = 2014,
         archive = "KonaweUtaraPlantationCropsPlan14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/837/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-utara-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonaweSelatanPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90,
         begin = 2014,
         end = 2014,
         archive = "KonaweSelatanPlantationCropsPlan14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/826/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-selatan-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonawePlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90,
         begin = 2014,
         end = 2014,
         archive = "KonawePlantationCropsPlan14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/821/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonaweKepulauanPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90,
         begin = 2014,
         end = 2014,
         archive = "KonaweKepulauanPlantationCropsPlan14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/841/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-kepulauan-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KolakaPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90,
         begin = 2014,
         end = 2014,
         archive = "KolakaPlantationCropsPlan14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/823/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kolaka-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KolakaTimurPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90,
         begin = 2014,
         end = 2014,
         archive = "KolakaTimurPlantationCropsPlan14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/839/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kolaka-timur-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KolakaUtaraPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90,
         begin = 2014,
         end = 2014,
         archive = "KolakaUtaraPlantationCropsPlan14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/833/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kolaka-utara-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "WakatobiPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90,
         begin = 2014,
         end = 2014,
         archive = "WakatobiPlantationCropsPlan14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/830/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-wakatobi-ha-2014.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_90_01 <- schema_idn_l3_90 %>%
  setCluster(id = "al2", left = 1, top = 2, height = 22)

regTable(nation = "idn",
         level = 3,
         subset = "BauBauPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_01,
         begin = 2011,
         end = 2011,
         archive = "BauBauPlantaitonCropsPlan11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/16/2435/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kota-bau-bau-ha-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "ButonPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_01,
         begin = 2011,
         end = 2011,
         archive = "ButonPlantaitonCropsPlan11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2399/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-buton-ha-2011.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "ButonUtaraPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_01,
         begin = 2011,
         end = 2011,
         archive = "ButonUtaraPlantaitonCropsPlan11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/16/2425/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-buton-utara-ha-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "BombanaPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_01,
         begin = 2011,
         end = 2011,
         archive = "BombanaPlantaitonCropsPlan11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2407/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-bombana-ha-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KendariPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_01,
         begin = 2011,
         end = 2011,
         archive = "KendariPlantaitonCropsPlan11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/16/2434/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kota-kendari-ha-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "MunaPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_01,
         begin = 2011,
         end = 2011,
         archive = "MunaPlantaitonCropsPlan11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2403/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-muna-ha-2011.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonaweUtaraPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_01,
         begin = 2011,
         end = 2011,
         archive = "KonaweUtaraPlantaitonCropsPlan11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/16/2430/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-utara-ha-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonaweSelatanPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_01,
         begin = 2011,
         end = 2011,
         archive = "KonaweSelatanPlantaitonCropsPlan11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2406/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-selatan-ha-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonawePlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_01,
         begin = 2011,
         end = 2011,
         archive = "KonawePlantaitonCropsPlan11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2404/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-ha-2011.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KolakaPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_01,
         begin = 2011,
         end = 2011,
         archive = "KolakaPlantaitonCropsPlan11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2405/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kolaka-ha-2011.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KolakaUtaraPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_01,
         begin = 2011,
         end = 2011,
         archive = "KolakaUtaraPlantaitonCropsPlan11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/16/2424/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kolaka-utara-ha-2011-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_90_02 <- schema_idn_l3_90 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 22) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*(?=\\*)")

regTable(nation = "idn",
         level = 3,
         subset = "BauBauPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_02,
         begin = 2012,
         end = 2012,
         archive = "BauBauPlantaitonCropsPlan12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1818/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kota-bau-bau-ha-2012-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "ButonPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_02,
         begin = 2012,
         end = 2012,
         archive = "ButonPlantaitonCropsPlan12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1815/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-buton-utara-ha-2012-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "ButonUtaraPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_02,
         begin = 2012,
         end = 2012,
         archive = "ButonUtaraPlantaitonCropsPlan12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1815/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-buton-utara-ha-2012-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KendariPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_02,
         begin = 2012,
         end = 2012,
         archive = "KendariPlantaitonCropsPlan12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1817/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kota-kendari-ha-2012-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "MunaPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_02,
         begin = 2012,
         end = 2012,
         archive = "MunaPlantaitonCropsPlan12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1808/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-muna-ha-2012-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonaweUtaraPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_02,
         begin = 2012,
         end = 2012,
         archive = "KonaweUtaraPlantaitonCropsPlan12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1814/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kolaka-utara-ha-2012-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonawePlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_02,
         begin = 2012,
         end = 2012,
         archive = "KonawePlantaitonCropsPlan12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1816/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-ha-2012-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonawePlantCrops02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_02,
         begin = 2012,
         end = 2012,
         archive = "KonaweDifferentPlantaitonCropsPlan12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1811/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-ha-2012-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KolakaPlantCrops02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_02,
         begin = 2012,
         end = 2012,
         archive = "KolakaPlantaitonCropsPlan12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1810/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kolaka-ha-2012-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KolakaPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_02,
         begin = 2012,
         end = 2012,
         archive = "KolakaiDifferentPlantaitonCropsPlan12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1812/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kolaka-ha-2012-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KolakaUtaraPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_02,
         begin = 2012,
         end = 2012,
         archive = "KolakaUtaraPlantaitonCropsPlan12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1814/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kolaka-utara-ha-2012-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "WakatobiPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_02,
         begin = 2012,
         end = 2012,
         archive = "WakatobiPlantaitonCropsPlan12.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/21/1813/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-wakatobi-ha-2012-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_90_03 <- schema_idn_l3_90 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 21)

regTable(nation = "idn",
         level = 3,
         subset = "BauBauPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_03,
         begin = 2013,
         end = 2013,
         archive = "BauBauPlantaitonCropsPlan13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1686/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kota-bau-bau-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "ButonPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_03,
         begin = 2013,
         end = 2013,
         archive = "ButonPlantaitonCropsPlan13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1673/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-buton-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "ButonUtaraPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_03,
         begin = 2013,
         end = 2013,
         archive = "ButonUtaraPlantaitonCropsPlan13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1681/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-buton-utara-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "BombanaPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_03,
         begin = 2013,
         end = 2013,
         archive = "BombanaPlantaitonCropsPlan13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1678/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-bombana-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KendariPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_03,
         begin = 2013,
         end = 2013,
         archive = "KendariPlantaitonCropsPlan13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1685/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kota-kendari-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "MunaPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_03,
         begin = 2013,
         end = 2013,
         archive = "MunaPlantaitonCropsPlan13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1674/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-muna-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonaweUtaraPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_03,
         begin = 2013,
         end = 2013,
         archive = "KonaweUtaraPlantaitonCropsPlan13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1682/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-utara-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonaweSelatanPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_03,
         begin = 2013,
         end = 2013,
         archive = "KonaweSelatanPlantaitonCropsPlan13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1677/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-selatan-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonawePlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_03,
         begin = 2013,
         end = 2013,
         archive = "KonawePlantaitonCropsPlan13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1675/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonaweKepuluaunPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_03,
         begin = 2013,
         end = 2013,
         archive = "KonaweKepulauanPlantaitonCropsPlan13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1684/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-kepulauan-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KolakaPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_03,
         begin = 2013,
         end = 2013,
         archive = "KolakaPlantaitonCropsPlan13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1676/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kolaka-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KolakaTimurPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_03,
         begin = 2013,
         end = 2013,
         archive = "KolakaTimurPlantaitonCropsPlan13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1683/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kolaka-timur-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KolakaUtaraPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_03,
         begin = 2013,
         end = 2013,
         archive = "KolakaUtaraPlantaitonCropsPlan13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1680/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kolaka-utara-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "WakatobiPlantCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_90_03,
         begin = 2013,
         end = 2013,
         archive = "WakatobiPlantaitonCropsPlan13.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/01/14/1679/luas-areal-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-wakatobi-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_91 <- setCluster(id = "al2", left = 1, top = 2, height = 22) %>%
  setIDVar(name = "al2", value = "Sulawesi Tenggara") %>%
  setIDVar(name = "al3", columns = 1, rows = 1, split = "(?<=in ).*(?=D)") %>%
  setIDVar(name = "year", columns = c(2:6), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:6))

regTable(nation = "idn",
         level = 3,
         subset = "BauBauPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91,
         begin = 2007,
         end = 2011,
         archive = "BauBauPlantaitonCropsProd07-11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2385/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kota-bau-bau-2007-2011-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "ButonPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91,
         begin = 2007,
         end = 2011,
         archive = "ButonPlantaitonCropsProd07-11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2360/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-buton-2007-2011-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "ButonUtaraPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91,
         begin = 2007,
         end = 2011,
         archive = "ButonUtaraPlantaitonCropsProd07-11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2372/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-buton-utara-2007-2011-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "BombanaPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91,
         begin = 2007,
         end = 2011,
         archive = "BombanaPlantaitonCropsProd07-11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2368/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-bombana-2007-2011-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KendariPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91,
         begin = 2007,
         end = 2011,
         archive = "KendariPlantaitonCropsProd07-11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2375/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kota-kendari-2007-2011-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "MunaPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91,
         begin = 2007,
         end = 2011,
         archive = "MunaPlantaitonCropsProd07-11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2361/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-muna-2007-2011-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonaweUtaraPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91,
         begin = 2007,
         end = 2011,
         archive = "KonaweUtaraPlantaitonCropsProd07-11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2374/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-utara-2007-2011-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonaweSelatanPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91,
         begin = 2007,
         end = 2011,
         archive = "KonaweSelatanPlantaitonCropsProd07-11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2367/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-selatan-2007-2011-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonawePlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91,
         begin = 2007,
         end = 2011,
         archive = "KonawePlantaitonCropsProd07-11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2363/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-2007-2011-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KolakaPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91,
         begin = 2007,
         end = 2011,
         archive = "KolakaPlantaitonCropsProd07-11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2365/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kolaka-2007-2011-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KolakaUtaraPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91,
         begin = 2007,
         end = 2011,
         archive = "KolakaUtaraPlantaitonCropsProd07-11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2371/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kolaka-utara-2007-2011-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "WakatobiPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91,
         begin = 2007,
         end = 2011,
         archive = "WakatobiPlantaitonCropsProd07-11.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2019/07/15/2369/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-wakatobi-2007-2011-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_91_01 <- schema_idn_l3_91 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 24) %>%
  setIDVar(name = "al3", columns = 1, rows = 1, split = "(?<=in ).*(?=C)") %>%
  setIDVar(name = "year", columns = c(2:6), rows = 3)

regTable(nation = "idn",
         level = 3,
         subset = "BauBauPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91_01,
         begin = 2010,
         end = 2014,
         archive = "BauBauPlantaitonCropsProd10-14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/814/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kota-bau-bau-2010-2014-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KendariPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91_01,
         begin = 2010,
         end = 2014,
         archive = "KendariPlantaitonCropsProd10-14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/812/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kota-kendari-2010-2014-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_91_02 <- schema_idn_l3_91_01 %>%
  setIDVar(name = "al3", columns = 1, rows = 1, split = "(?<=in ).*(?=R)")

regTable(nation = "idn",
         level = 3,
         subset = "ButonPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91_02,
         begin = 2010,
         end = 2014,
         archive = "ButonPlantaitonCropsProd10-14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/797/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-buton-2010-2014-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "ButonUtaraPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91_02,
         begin = 2010,
         end = 2014,
         archive = "ButonUtaraPlantaitonCropsProd10-14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/806/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-buton-utara-2010-2014-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "BombanaPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91_02,
         begin = 2010,
         end = 2014,
         archive = "BombanaPlantaitonCropsProd10-14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/803/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-bombana-2010-2014-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "MunaPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91_02,
         begin = 2010,
         end = 2014,
         archive = "MunaPlantaitonCropsProd10-14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/799/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-muna-2010-2014-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonaweUtaraPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91_02,
         begin = 2010,
         end = 2014,
         archive = "KonaweUtaraPlantaitonCropsProd10-14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/807/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-utara-2010-2014-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonaweSelatanPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91_02,
         begin = 2010,
         end = 2014,
         archive = "KonaweSelatanPlantaitonCropsProd10-14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/802/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-selatan-2010-2014-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KonawePlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91_02,
         begin = 2010,
         end = 2014,
         archive = "KonawePlantaitonCropsProd10-14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/800/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-2010-2014-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KolakaPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91_02,
         begin = 2010,
         end = 2014,
         archive = "KolakaPlantaitonCropsProd10-14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/801/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kolaka-2010-2014-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "KolakaUtaraPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91_02,
         begin = 2010,
         end = 2014,
         archive = "KolakaUtaraPlantaitonCropsProd10-14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/805/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kolaka-utara-2010-2014-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "WakatobiPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_91_02,
         begin = 2010,
         end = 2014,
         archive = "WakatobiPlantaitonCropsProd10-14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/804/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-wakatobi-2010-2014-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_92 <- setCluster(id = "al2", left = 1, top = 4, height = 24) %>%
  setIDVar(name = "al2", value = "Sulawesi Tenggara") %>%
  setIDVar(name = "al3", columns = 1, rows = 1, split = "(?<=di ).*(?=,)") %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=, ).*(?=\\()") %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "production", unit = "t", columns = 2)

regTable(nation = "idn",
         level = 3,
         subset = "KonaweKepulauanPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_92,
         begin = 2014,
         end = 2014,
         archive = "KonaweKepulauanPlantaitonCropsProd14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/810/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-konawe-kepulauan-2014-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_92_01 <- schema_idn_l3_92 %>%
  setIDVar(name = "al3", columns = 1, rows = 1, split = "(?<=in ).*(?=R)") %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=cy ).*(?=\\()")

regTable(nation = "idn",
         level = 3,
         subset = "KolakaTimurPlantCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_92_01,
         begin = 2014,
         end = 2014,
         archive = "KolakaTimurPlantaitonCropsProd10-14.xls",
         archiveLink = "https://sultra.bps.go.id/statictable/2018/02/15/808/produksi-tanaman-perkebunan-menurut-jenis-tanaman-di-kabupaten-kolaka-timur-2014-ton-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sultra.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_93 <- setCluster(id = "al2", left = 1, top = 7, height = 11) %>%
  setIDVar(name = "al2", value = "Bengkulu") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 2, split = "(?<=, ).*") %>%
  setIDVar(name = "commodities", columns = c(2:5), rows = 6) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:5))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_93,
         begin = 2013,
         end = 2013,
         archive = "BengkuluLivestockSubDis13.xls",
         archiveLink = "https://bengkulu.bps.go.id/statictable/2015/03/27/127/populasi-ternak-besar-ekor-menurut-kabupaten-kota-dan-jenis-ternak-di-bengkulu-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_94 <- setCluster(id = "al2", left = 1, top = 5, height = 11) %>%
  setIDVar(name = "al2", columns = 1, rows = 16) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:15), rows = 5) %>%
  setIDVar(name = "commodities", columns = c(2:15), rows = 4)

schema_idn_l3_94_01 <- schema_idn_l3_94 %>%
  setFormat(decimal = ",") %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = c(2:15))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_94_01,
         begin = 2019,
         end = 2020,
         archive = "BengkuluLivestockSubDis19_20.xls",
         archiveLink = "https://bengkulu.bps.go.id/statictable/2021/07/07/651/populasi-ternak-menurut-kabupaten-kota-dan-jenis-ternak-di-provinsi-bengkulu-ribu-ekor-2019-dan-2020.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_94_02 <- schema_idn_l3_94 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", value = "Cassava") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:7))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluCassavaProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_94_02,
         begin = 2010,
         end = 2015,
         archive = "BengkuluCassavaProdSubDis10-15.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_94_03 <- schema_idn_l3_94 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", value = "paddy") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:7))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluDryWetPaddyHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_94_03,
         begin = 2010,
         end = 2015,
         archive = "BengkuluDryWetPaddyHarvSubDis10-15.xls",
         archiveLink = "https://bengkulu.bps.go.id/statictable/2016/03/17/254/luas-penen-padi-sawah-padi-ladang-menurut-kabupaten-kota-di-provinsi-bengkulu-tahun-2010-2015-ha-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_94_04 <- schema_idn_l3_94 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", value = "green beans") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:7))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluGreenBeans",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_94_04,
         begin = 2010,
         end = 2015,
         archive = "BengkuluGreenBeanProdSubDis10-15.xls",
         archiveLink = "https://bengkulu.bps.go.id/statictable/2016/03/17/260/produksi-kacang-hijau-menurut-kabupaten-kota-di-provinsi-bengkulu-tahun-2010-2015-ton-biji-kering-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_94_05 <- schema_idn_l3_94 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", value = "soy") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:7))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluSoyProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_94_05,
         begin = 2010,
         end = 2015,
         archive = "BengkuluSoyProdSubDis10-15.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_94_06 <- schema_idn_l3_94 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", value = "sweet potato") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:7))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluSweetPotatoProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_94_06,
         begin = 2010,
         end = 2015,
         archive = "BengkuluSweetPotatoeProdSubDis10-15.xls",
         archiveLink = "https://bengkulu.bps.go.id/statictable/2016/03/28/263/produksi-ubi-jalar-menurut-kabupaten-kota-di-provinsi-bengkulu-tahun-2010-2015-ton-umbi-basah-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_94_07 <- schema_idn_l3_94 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", value = "peanut") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:7))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluPeanutsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_94_07,
         begin = 2010,
         end = 2015,
         archive = "BengkuluPeanutsProdSubDis10-15.xls",
         archiveLink = "https://bengkulu.bps.go.id/statictable/2016/03/17/259/produksi-kacang-tanah-menurut-kabupaten-kota-di-provinsi-bengkulu-tahun-2010-2015-ton-biji-kering-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_94_08 <- schema_idn_l3_94 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", value = "paddy") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:7))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluPaddyProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_94_08,
         begin = 2010,
         end = 2015,
         archive = "BengkuluPaddyProdSubDis10-15.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_94_09 <- schema_idn_l3_94 %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", value = "maize") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:7))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluMaizeProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_94_09,
         begin = 2010,
         end = 2015,
         archive = "BengkuluMaizeProdSubDis10-15.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_95 <- setCluster(id = "al2", left = 2, top = 7, height = 11) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al2", columns = 2, rows = 19) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", columns = 1, rows = 3, split = "(?<=hun ).*") %>%
  setIDVar(name = "commodities", value = "paddy") %>%
  setObsVar(name = "harvested", unit = "ha", columns = 4) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = 6) %>%
  setObsVar(name = "production", unit = "t", columns = 8)

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluPaddy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_95,
         begin = 2013,
         end = 2013,
         archive = "BengkuluPaddyHarvProdYieldSubDis13.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTabl",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_95_01 <- schema_idn_l3_95 %>%
  setIDVar(name = "al2", columns = 2, rows = 17) %>%
  setIDVar(name = "year", columns = 1, rows = 2, split = "(?<=hun ).*") %>%
  setIDVar(name = "commodities", value = "soy beans")

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluSoybean",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_95_01,
         begin = 2013,
         end = 2013,
         archive = "BengkuluSoyHarvProdYieldSubDis13.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_95_02 <- schema_idn_l3_95_01 %>%
  setIDVar(name = "commodities", value = "maize")

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluMaize",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_95_02,
         begin = 2013,
         end = 2013,
         archive = "BengkuluMaizeHarvProdYieldSubDis13.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_96 <- setCluster(id = "al2", left = 2, top = 6, height = 11) %>%
  setIDVar(name = "al2", value = "Bengkulu") %>%
  setIDVar(name = "al3", columns = c(2:11), rows = 6) %>%
  setIDVar(name = "year", columns = 1, rows = 2, split = "(?<=, ).*") %>%
  setIDVar(name = "commodities", columns = 1)

schema_idn_l3_96_01 <- schema_idn_l3_96 %>%
  setFormat(decimal = ",") %>%
  setObsVar(name = "area", unit = "ha", columns = c(2:11))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_96_01,
         begin = 2013,
         end = 2013,
         archive = "BengkuluForestrySubDis13.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_96_02 <- schema_idn_l3_96 %>%
  setCluster(id = "al2", left = 2, top = 9, height = 20) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:11))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_96_02,
         begin = 2013,
         end = 2013,
         archive = "BengkuluFruitsProdSubDis13.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_97 <- setCluster(id = "al2", left = 2, top = 8, height = 11) %>%
  setIDVar(name = "al2", columns = 1, rows = 19) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:51), rows = 7) %>%
  setIDVar(name = "commodities", columns = c(2:51), rows = 4)

schema_idn_l3_97_01 <- schema_idn_l3_97 %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:51))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_97_01,
         begin = 2020,
         end = 2021,
         archive = "BengkuluFruitsProdSubDis20-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/statictable/2022/03/30/1222/produksi-buah-buahan-menurut-jenis-tanaman-menurut-kabupaten-kota-di-provinsi-bengkulu-2020-dan-2021.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_97_02 <- schema_idn_l3_97 %>%
  setIDVar(name = "year", columns = c(2:15), rows = 7) %>%
  setIDVar(name = "commodities", columns = c(2:15), rows = 4) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:15))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_97_02,
         begin = 2020,
         end = 2021,
         archive = "BengkuluLivestockSubDis20_21.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_97_03 <- schema_idn_l3_97 %>%
  setIDVar(name = "year", columns = c(2:31), rows = 7) %>%
  setIDVar(name = "commodities", columns = c(2:31), rows = 4) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:31))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluMedPlantsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_97_03,
         begin = 2020,
         end = 2021,
         archive = "BengkuluMEdicinalPlantsHarvestSubDiv20-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_97_04 <- schema_idn_l3_97 %>%
  setIDVar(name = "year", columns = c(2:31), rows = 7) %>%
  setIDVar(name = "commodities", columns = c(2:31), rows = 4) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:31))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluMedPlantsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_97_04,
         begin = 2020,
         end = 2021,
         archive = "BengkuluMEdicinalPlantsProductionSubDiv20-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_97_05 <- schema_idn_l3_97 %>%
  setIDVar(name = "year", columns = c(2:35, 38:49), rows = 7) %>%
  setIDVar(name = "commodities", columns = c(2:35, 38:49), rows = 4) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:35, 38:49))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluOrnPlantsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_97_05,
         begin = 2020,
         end = 2021,
         archive = "BengkuluOrnamentalPlantsHarvestSubDiv20-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_97_06 <- schema_idn_l3_97 %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "year", columns = c(2:7), rows = 7) %>%
  setIDVar(name = "commodities", value = "paddy") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 3)) %>%
  setObsVar(name = "yiled", unit = "kg/ha", factor = 100, columns = c(4, 5)) %>%
  setObsVar(name = "production", unit = "t", factor = 0.0001, columns = c(6, 7))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluPaddyHarvYieldProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_97_06,
         begin = 2020,
         end = 2021,
         archive = "BengkuluPaddyHarvProdYieldSubDis20-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_97_07 <- schema_idn_l3_97 %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "year", columns = c(2:17), rows = 7) %>%
  setIDVar(name = "commodities", columns = c(2:17), rows = 4) %>%
  setObsVar(name = "planted", unit = "ha", factor = 1000, columns = c(2:17))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluCorpsPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_97_07,
         begin = 2020,
         end = 2021,
         archive = "BengkuluPlantationCropsPlanSubDis20-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_97_08 <- schema_idn_l3_97 %>%
  setCluster(id = "al2", left = 2, top = 7, height = 11) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "al2", columns = 1, rows = 18) %>%
  setIDVar(name = "year", columns = c(2:11), rows = 7) %>%
  setIDVar(name = "commodities", columns = c(2:11), rows = 4) %>%
  setObsVar(name = "planted", unit = "ha", factor = 1000, columns = c(2:11))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluCorpsPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_97_08,
         begin = 2019,
         end = 2020,
         archive = "BengkuluPlantationCropsProdSubDis19-20.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_97_09 <- schema_idn_l3_97 %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "year", columns = c(2:17), rows = 7) %>%
  setIDVar(name = "commodities", columns = c(2:17), rows = 4) %>%
  setObsVar(name = "production", unit = "t", factor = 1000, columns = c(2:17))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluCorpsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_97_09,
         begin = 2020,
         end = 2021,
         archive = "BengkuluPlantationCropsProdSubDis20-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_97_10 <- schema_idn_l3_97 %>%
  setIDVar(name = "year", columns = c(2:53), rows = 7) %>%
  setIDVar(name = "commodities", columns = c(2:53), rows = 4) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:17, 20:53))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_97_10,
         begin = 2020,
         end = 2021,
         archive = "BengkuluVegHarvSubDis20-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_97_11 <- schema_idn_l3_97 %>%
  setIDVar(name = "year", columns = c(2:53), rows = 7) %>%
  setIDVar(name = "commodities", columns = c(2:53), rows = 4) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:53))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_97_11,
         begin = 2020,
         end = 2021,
         archive = "BengkuluVegProdSubDis20-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_97_12 <- schema_idn_l3_97 %>%
  setIDVar(name = "year", columns = c(2:9), rows = 7) %>%
  setIDVar(name = "commodities", columns = c(2:9), rows = 4) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:9))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_97_12,
         begin = 2020,
         end = 2021,
         archive = "BengkuluPoultrySubDis20-21.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_97_13 <- setCluster(id = "al2", left = 2, top = 5, height = 11) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "al2", columns = 1, rows = 16) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:9), rows = 5) %>%
  setIDVar(name = "commodities", columns = c(2:9), rows = 4) %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = c(2:9))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_97_13,
         begin = 2019,
         end = 2020,
         archive = "BengkuluPoultrySubDis19-20.xls",
         archiveLink = "https://bengkulu.bps.go.id/statictable/2021/07/07/652/populasi-unggas-menurut-kabupaten-kota-dan-jenis-unggas-di-provinsi-bengkulu-ribu-ekor-2019-dan-2020.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_98 <- setCluster(id = "al2", left = 2, top = 6, height = 11) %>%
  setIDVar(name = "al2", columns = 1, rows = 17) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 2, split = "(?<=, ).*") %>%
  setIDVar(name = "commodities", columns = c(2:13), rows = 5) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:13))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_98,
         begin = 2013,
         end = 2013,
         archive = "BengkuluVegiesHarvSubDis13.xls",
         archiveLink = "https://bengkulu.bps.go.id/statictable/2015/03/27/121/luas-panen-tanaman-sayuran-menurut-kabupaten-kota-dan-jenis-sayuran-di-provinsi-bengkulu-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_99 <-
  setIDVar(name = "al2", columns = 1, rows = 4) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:7), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:7), rows = 1)

schema_idn_l3_99_01 <- schema_idn_l3_99 %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 3), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(4, 5), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(6, 7), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluPaddyHarvYieldProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_99_01,
         begin = 2018,
         end = 2019,
         archive = "BengkuluPaddyHarvProdYieldSubDis18-19.xls",
         archiveLink = "https://bengkulu.bps.go.id/statictable/2015/03/27/121/luas-panen-tanaman-sayuran-menurut-kabupaten-kota-dan-jenis-sayuran-di-provinsi-bengkulu-ha-2013.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_99_02 <- schema_idn_l3_99 %>%
  setIDVar(name = "year", columns = c(2:11), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:11), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:11), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluCropPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_99_02,
         begin = 2018,
         end = 2019,
         archive = "BengkuluPlantationCropsPlanSubDis18-19.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_99_03 <- schema_idn_l3_99 %>%
  setIDVar(name = "year", columns = c(2:27), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:27), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:27), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_99_03,
         begin = 2018,
         end = 2019,
         archive = "BengkuluVegiesHarvSubDis18-19.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_99_04 <- schema_idn_l3_99 %>%
  setIDVar(name = "year", columns = c(2:27), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:27), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:27), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_99_04,
         begin = 2018,
         end = 2019,
         archive = "BengkuluVegiesProdSubDis18-19.xls",
         archiveLink = "https://bengkulu.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_100 <- setCluster(id = "al2", left = 2, top = 7, height = 11) %>%
  setFormat(decimal = ",") %>%
  setIDVar(name = "al2", value = "Bengkulu") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 2, split = "(?<=, ).*") %>%
  setIDVar(name = "commodities", columns = c(2:4), rows = 6) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:4))

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_100,
         begin = 2013,
         end = 2013,
         archive = "BengkuluPoultrySubDis13.xls",
         archiveLink = "https://bengkulu.bps.go.id/indicator/24/120/1/poultry-population-heads-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "BengkuluSmallLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_100,
         begin = 2013,
         end = 2013,
         archive = "BengkuluSmallLivestockSubDis13.xls",
         archiveLink = "https://bengkulu.bps.go.id/indicator/24/119/1/small-livestock-population-heads-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://bengkulu.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_101 <-
  setIDVar(name = "al2", columns = 1, rows = 10) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:45), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:45), rows = 2)

schema_idn_l3_101_01 <- schema_idn_l3_101 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:45), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "DkiJakartaLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_101_01,
         begin = 2016,
         end = 2019,
         archive = "DKIJakartaLivestockSubDiv16-19.xls",
         archiveLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_101_02 <- schema_idn_l3_101 %>%
  setCluster(id = "al2", left = 1, top = 3, height = 7) %>%
  setIDVar(name = "year", columns = c(2:10), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:10), rows = 1, split = ".*(?=,)") %>%
  setObsVar(name = "hearvested", unit = "ha", columns = c(2:4), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(5:7), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(8:10), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "DkiJakartaPaddyHarvYieldProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_101_02,
         begin = 2018,
         end = 2020,
         archive = "DKIJakartaPadiProdYieldHarvSubDis18-20.xls",
         archiveLink = "https://jakarta.bps.go.id/indicator/53/653/1/luas-panen-produksi-dan-produktivitas-padi1-menurut-kabupaten-kota-di-provinsi-dki-jakarta-ha-.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_101_03 <- schema_idn_l3_101 %>%
  setIDVar(name = "year", columns = c(2:25), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:25), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:25), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "DkiJakartaFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_101_03,
         begin = 2017,
         end = 2020,
         archive = "DKIJakartaFruitsProdSubDis17-20.xls",
         archiveLink = "https://jakarta.bps.go.id/site/resultTab",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_101_04 <- schema_idn_l3_101 %>%
  setIDVar(name = "year", columns = c(2:13), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:13), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:13), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "DkiJakartaMedHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_101_04,
         begin = 2018,
         end = 2020,
         archive = "DKIJakartaMedicialPlantsHarvSubDis18-20.xls",
         archiveLink = "https://jakarta.bps.go.id/site/resultTab",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_101_05 <- schema_idn_l3_101 %>%
  setIDVar(name = "year", columns = c(2:17), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:17), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = c(2:17), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "DkiJakartaMedProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_101_05,
         begin = 2017,
         end = 2020,
         archive = "DKIJakartaMedicialPlantsProdSubDis17-20.xls",
         archiveLink = "https://jakarta.bps.go.id/site/resultTab",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_101_06 <- schema_idn_l3_101 %>%
  setIDVar(name = "year", columns = c(2:17), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:17), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:17), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "DkiJakartaOrnHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_101_06,
         begin = 2017,
         end = 2020,
         archive = "DKIJakartaOrnamentalPlantsHarvSubDis17-20.xls",
         archiveLink = "https://jakarta.bps.go.id/site/resultTab",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_101_07 <- schema_idn_l3_101 %>%
  setIDVar(name = "year", columns = c(2:29), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:29), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:29), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "DkiJakartaVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_101_07,
         begin = 2017,
         end = 2020,
         archive = "DKIJakartaVegiesHarvSubDis17-20.xls",
         archiveLink = "https://jakarta.bps.go.id/site/resultTab",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_101_08 <- schema_idn_l3_101 %>%
  setIDVar(name = "year", columns = c(2:29), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:29), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:29), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "DkiJakartaVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_101_08,
         begin = 2017,
         end = 2020,
         archive = "DKIJakartaVegiesProdSubDis17-20.xls",
         archiveLink = "https://jakarta.bps.go.id/site/resultTab",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jakarta.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_101_09 <- schema_idn_l3_101 %>%
  setIDVar(name = "year", columns = c(2:78), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:78), rows = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:78), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "GorontaloLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_101_09,
         begin = 2010,
         end = 2018,
         archive = "GorontaloLivestockSubDis10-18.xls",
         archiveLink = "https://gorontalo.bps.go.id/indicator/24/122/1/populasi-unggas-menurut-kab-kota.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_101_10 <- schema_idn_l3_101 %>%
  setIDVar(name = "year", columns = c(2:65), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:65), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:65), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "GorontaloCropsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_101_10,
         begin = 2010,
         end = 2017,
         archive = "GorontaloFoodCropsHarvSubDis10-17.xls",
         archiveLink = "https://gorontalo.bps.go.id/indicator/24/122/1/populasi-unggas-menurut-kab-kota.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_101_11 <- schema_idn_l3_101 %>%
  setIDVar(name = "year", columns = c(2:65), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:65), rows = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:65), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "GorontaloCropsProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_101_11,
         begin = 2010,
         end = 2017,
         archive = "GorontaloFoodCropsProdSubDis10-17.xls",
         archiveLink = "https://gorontalo.bps.go.id/indicator/24/122/1/populasi-unggas-menurut-kab-kota.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_101_12 <- schema_idn_l3_101 %>%
  setIDVar(name = "year", columns = c(2:33), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:33), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:33), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "GorontaloCropsProd02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_101_12,
         begin = 2016,
         end = 2017,
         archive = "GorontaloFruitsProdSubDis16-17.xls",
         archiveLink = "https://gorontalo.bps.go.id/indicator/24/122/1/populasi-unggas-menurut-kab-kota.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_101_13 <- schema_idn_l3_101 %>%
  setIDVar(name = "year", columns = c(2:129), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:129), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:65), top = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(66:129), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "GorontaloCropsPlantProd02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_101_13,
         begin = 2010,
         end = 2017,
         archive = "GorontaloPlantationCropsPlanProdSubDis10-17.xls",
         archiveLink = "https://gorontalo.bps.go.id/indicator/24/122/1/populasi-unggas-menurut-kab-kota.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_101_14 <- schema_idn_l3_101 %>%
  setIDVar(name = "year", columns = c(2:79), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:79), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:40), top = 1) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(41:79), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "GorontaloVegHarvProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_101_14,
         begin = 2015,
         end = 2017,
         archive = "GorontaloVegiesHarvProdSubDis15-17.xls",
         archiveLink = "https://gorontalo.bps.go.id/indicator/24/122/1/populasi-unggas-menurut-kab-kota.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_102 <- setCluster(id = "al2", left = 1, top = 5, height = 7) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al2", columns = 1, rows = 12) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=, ).*") %>%
  setIDVar(name = "commodities", value = "forest") %>%
  setObsVar(name = "area", unit = "ha", columns = 7)

regTable(nation = "idn",
         level = 3,
         subset = "GorontaloForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_102,
         begin = 2013,
         end = 2013,
         archive = "GorontaloForestSubDis13.xls",
         archiveLink = "https://gorontalo.bps.go.id/indicator/24/122/1/populasi-unggas-menurut-kab-kota.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_102_01 <- schema_idn_l3_102 %>%
  setIDVar(name = "al2", value = "Gorontalo") %>%
  setCluster(id = "al2", left = 1, top = 4, height = 7)

regTable(nation = "idn",
         level = 3,
         subset = "GorontaloForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_102_01,
         begin = 2016,
         end = 2016,
         archive = "GorontaloForestSubDis16.xls",
         archiveLink = "https://gorontalo.bps.go.id/indicator/24/122/1/populasi-unggas-menurut-kab-kota.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_102_02 <- schema_idn_l3_102 %>%
  setIDVar(name = "al2", value = "Gorontalo") %>%
  setCluster(id = "al2", left = 1, top = 3, height = 7)

regTable(nation = "idn",
         level = 3,
         subset = "GorontaloForest",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_102_02,
         begin = 2017,
         end = 2017,
         archive = "GorontaloForestSubDis17.xls",
         archiveLink = "https://gorontalo.bps.go.id/indicator/24/122/1/populasi-unggas-menurut-kab-kota.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_102_03 <- schema_idn_l3_102 %>%
  setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=tan ).*(?=\\()") %>%
  setObsVar(name = "area", unit = "ha", columns = 4)

regTable(nation = "idn",
         level = 3,
         subset = "GorontaloMangroove",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_102_03,
         begin = 2014,
         end = 2014,
         archive = "GorontaloMangroveSubDis13.xls",
         archiveLink = "https://gorontalo.bps.go.id/indicator/24/122/1/populasi-unggas-menurut-kab-kota.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_102_04 <- schema_idn_l3_102_03 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 7) %>%
  setIDVar(name = "al2", value = "Gorontalo")

regTable(nation = "idn",
         level = 3,
         subset = "GorontaloMangroove",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_102_04,
         begin = 2016,
         end = 2016,
         archive = "GorontaloMangroveSubDis16.xls",
         archiveLink = "https://gorontalo.bps.go.id/indicator/24/122/1/populasi-unggas-menurut-kab-kota.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_102_05 <- schema_idn_l3_102_03 %>%
  setCluster(id = "al2", left = 1, top = 3, height = 7) %>%
  setIDVar(name = "al2", value = "Gorontalo")

regTable(nation = "idn",
         level = 3,
         subset = "GorontaloMangroove",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_102_05,
         begin = 2017,
         end = 2017,
         archive = "GorontaloMangroveSubDis17.xls",
         archiveLink = "https://gorontalo.bps.go.id/indicator/24/122/1/populasi-unggas-menurut-kab-kota.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://gorontalo.bps.go.id/subject/24/peternakan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_103 <-
  setIDVar(name = "al2", columns = 1, rows = 4) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:16), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:16), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(4, 7, 10, 13, 16), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 6, 9, 12, 15), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = c(2, 5, 8, 11, 14), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "JambiCrops",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_103,
         begin = 2018,
         end = 2018,
         archive = "JambiFoodCropsHarvProdYieldSubDis18.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_103_01 <- schema_idn_l3_103 %>%
  setIDVar(name = "year", columns = c(2:58), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:58), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46, 49, 52, 55, 58), top = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50, 53, 56), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "JambiVegFruitHarvProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_103_01,
         begin = 2017,
         end = 2017,
         archive = "JambiHorticultureHarvProdYieldSubDis17.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_103_02 <- schema_idn_l3_103 %>%
  setIDVar(name = "year", columns = c(2:19), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:19), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(4, 7, 10, 13, 16, 19), top = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(3, 6, 9, 12, 15, 18), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(2, 5, 8, 11, 14, 17), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "JambiVegHarvProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_103_02,
         begin = 2017,
         end = 2017,
         archive = "JambiVegiesHarvYieldProdSubDiv-02-17.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_103_03 <- schema_idn_l3_103 %>%
  setIDVar(name = "year", columns = c(2:40), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:40), rows = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40), top = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39), top = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = c(2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35, 38), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "JambiVegHarvProdYield02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_103_03,
         begin = 2017,
         end = 2017,
         archive = "JambiVegiesHarvYieldProdSubDiv17.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_104 <-
  setIDVar(name = "al2", columns = 1, rows = 4) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:148), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:148), rows = 2)

schema_idn_l3_104_01 <- schema_idn_l3_104 %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:148), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "JambiLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_104_01,
         begin = 2000,
         end = 2020,
         archive = "JambiLivestockSubDis00-20.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_104_02 <- schema_idn_l3_104 %>%
  setIDVar(name = "year", columns = c(2:9), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:9), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = c(2:9), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "JambiOrnPLantsHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_104_02,
         begin = 2017,
         end = 2018,
         archive = "JambiOrnamentalPlantsHarvSubDis17-18.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_104_03 <- schema_idn_l3_104 %>%
  setIDVar(name = "year", columns = c(2:205), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:205), rows = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:205), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "JambiCropsPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_104_03,
         begin = 2006,
         end = 2017,
         archive = "JambiPlantationCropsPlanSubDis06-17.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_104_04 <- schema_idn_l3_104 %>%
  setIDVar(name = "year", columns = c(2:85), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:85), rows = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:85), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "JambiPoultry",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_104_04,
         begin = 2000,
         end = 2020,
         archive = "JambiPoultrySubDis00-20.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_105 <-
  setIDVar(name = "al2", columns = 13, rows = 2) %>%
  setIDVar(name = "al3", columns = c(2:12), rows = 2) %>%
  setIDVar(name = "year", columns = c(2:12), rows = 3) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:12), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "JambiCropsPlant",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_105,
         begin = 2018,
         end = 2018,
         archive = "JambiPlantationCropsPlanSubDis18.xls",
         archiveLink = "https://jambi.bps.go.id/site/pilihdata.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://jambi.bps.go.id/site/pilihdata.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_106 <-
  setFilter(rows = .find("Jumlah", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", value = "Aceh") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:5), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:5), rows = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:3), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(4:5), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "AcehCacaoPlanProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_106,
         begin = 2018,
         end = 2018,
         archive = "AcehCacoaPlanProdukRegency12-13.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_107 <-
  setIDVar(name = "al2", columns = 1, rows = 27) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:33), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:33), rows = 2)

schema_idn_l3_107_01 <- schema_idn_l3_107 %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:33), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "AcehVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_107_01,
         begin = 2015,
         end = 2019,
         archive = "AcehHarvVegetablesRegency15-19.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_107_02 <- schema_idn_l3_107 %>%
  setIDVar(name = "year", columns = c(2:9), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:9), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:9), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "AcehVegHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_107_02,
         begin = 2017,
         end = 2017,
         archive = "AcehHarvVegetablesRegency17.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_107_03 <- schema_idn_l3_107 %>%
  setIDVar(name = "al2", value = "Aceh") %>%
  setIDVar(name = "year", columns = c(2:25), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:25), rows = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:25), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "AcehLivestock",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_107_03,
         begin = 2014,
         end = 2015,
         archive = "AcehLivestockSubDiv14-15.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_107_04 <- schema_idn_l3_107 %>%
  setFilter(rows = .find("Jumlah", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", value = "Aceh") %>%
  setIDVar(name = "year", columns = c(2:11), rows = 3) %>%
  setIDVar(name = "commodities", columns =2, rows = 1, split = ".*(?= Pl)") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:6), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(7:11), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "AcehPalmOilPlantProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_107_04,
         begin = 2012,
         end = 2016,
         archive = "AcehOilPalmEstatesRegency12-16.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_107_05 <- schema_idn_l3_107 %>%
  setIDVar(name = "year", columns = c(2:25), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:25), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:25), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "AcehFruitProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_107_05,
         begin = 2015,
         end = 2017,
         archive = "AcehProdFruitsRegency15-17.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_107_06 <- schema_idn_l3_107 %>%
  setIDVar(name = "year", columns = c(2:17), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:17), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:17), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "AcehVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_107_06,
         begin = 2015,
         end = 2016,
         archive = "AcehProdVegetablesRegency15-16.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_107_07 <- schema_idn_l3_107 %>%
  setIDVar(name = "year", columns = c(2:9), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:9), rows = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(2:9), top = 1)

regTable(nation = "idn",
         level = 3,
         subset = "AcehVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_107_07,
         begin = 2017,
         end = 2017,
         archive = "AcehProdVegtablesRegency17.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_107_08 <- schema_idn_l3_107 %>%
  setIDVar(name = "year", columns = c(2:11), rows = 3) %>%
  setIDVar(name = "commodities", columns = c(2:11), rows = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:6), top = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(7:11), top = 2)

regTable(nation = "idn",
         level = 3,
         subset = "AcehRubberPlanProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_107_08,
         begin = 2012,
         end = 2016,
         archive = "AcehRubberEstatPlanProdukRegency12-16.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_108 <- setCluster(id = "al2", left = 1, top = 4, height = 24) %>%
  setIDVar(name = "al2", value = "Aceh") %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = 1, rows = 1, split = "(?<=of ).*(?= Pl)") %>%
  setObsVar(name = "planted", unit = "ha", columns = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 4)

regTable(nation = "idn",
         level = 3,
         subset = "AcehCassavaPlantHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_108,
         begin = 2013,
         end = 2013,
         archive = "AcehPlanHarvProdCassavaRegencyCity13.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "AcehPeanutPlantHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_108,
         begin = 2013,
         end = 2013,
         archive = "AcehPlanHarvProdPeanutsRegencyCity13.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "AcehSoybeanPlantHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_108,
         begin = 2013,
         end = 2013,
         archive = "AcehPlanHarvProdSoyRegencyCity13.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "idn",
         level = 3,
         subset = "AcehSweetPotatoPlantHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_108,
         begin = 2013,
         end = 2013,
         archive = "AcehPlanHarvProdSweetPotatoeRegencyCity13.xls",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_109 <- setCluster(id = "al2", left = 2, top = 6, height = 24) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al2", value = "Aceh") %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = 2, rows = 3, split = "(?<=of ).*(?= Pl)") %>%
  setObsVar(name = "planted", unit = "ha", columns = 6) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 10)

regTable(nation = "idn",
         level = 3,
         subset = "AcehMaizePlantHarv",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_109,
         begin = 2013,
         end = 2013,
         archive = "AcehPlanHarvProdMaizeRegencyCity13.pdf",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_idn_l3_110 <- setCluster(id = "al2", left = 2, top = 7, height = 22) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al2", value = "Aceh") %>%
  setIDVar(name = "al3", columns = c(3:25), rows = 3) %>%
  setIDVar(name = "year", columns = 1, rows = 1, split = "(?<=,).*") %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "production", unit = "t", columns = c(3:25))

regTable(nation = "idn",
         level = 3,
         subset = "AcehVegProd",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_110,
         begin = 2013,
         end = 2013,
         archive = "AcehVegetablesProductionRegency13.pdf",
         archiveLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://aceh.bps.go.id/subject/54/perkebunan.html#subjekViewTab3",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# The table has many vertical clusters and I cannot integrate it in one schema
schema_idn_l3_111 <- setCluster(id = "al2", left = 1, top = 8, height = 25) %>%
  setFilter(rows = .find("\\*", col = 2), invert = TRUE) %>%
  setIDVar(name = "al2", value = "Sumatera Selatan") %>%
  setIDVar(name = "al3", columns = c(4:9), rows = 6) %>%
  setIDVar(name = "year",  columns = 3, rows = 2, split = "(?<=, ).*") %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(5, 7, 9)) %>%
  setObsVar(name = "production", unit = "t", factor = 0.1, columns = c(4, 6, 8))

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanVeg",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_111,
         begin = 2014,
         end = 2014,
         archive = "SumateraSelatanVegiesHarProdSubDis14.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_111_01 <- schema_idn_l3_111 %>%
  setCluster(id = "al2", left = 1, top = 38, height = 25) %>%
  setIDVar(name = "al3", columns = c(4:9), rows = 36)

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanVeg01",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_111_01,
         begin = 2014,
         end = 2014,
         archive = "SumateraSelatanVegiesHarProdSubDis14.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_111_02 <- schema_idn_l3_111 %>%
  setCluster(id = "al2", left = 1, top = 68, height = 25) %>%
  setIDVar(name = "al3", columns = c(4:9), rows = 66)

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanVeg02",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_111_02,
         begin = 2014,
         end = 2014,
         archive = "SumateraSelatanVegiesHarProdSubDis14.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_111_03 <- schema_idn_l3_111 %>%
  setCluster(id = "al2", left = 1, top = 98, height = 25) %>%
  setIDVar(name = "al3", columns = c(4:9), rows = 96)

regTable(nation = "idn",
         level = 3,
         subset = "SumateraSelatanVeg03",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_111_03,
         begin = 2014,
         end = 2014,
         archive = "SumateraSelatanVegiesHarProdSubDis14.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_idn_l3_111_04 <- schema_idn_l3_111 %>%
  setCluster(id = "al2", left = 1, top = 128, height = 25) %>%
  setIDVar(name = "al3", columns = c(4:9), rows = 126)

regTable(nation = "idn",
         subset = "SumateraSelatanVeg04",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_idn_l3_111_04,
         begin = 2014,
         end = 2014,
         archive = "SumateraSelatanVegiesHarProdSubDis14.xls",
         archiveLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://sumsel.bps.go.id/subject/24/peternakan.html",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


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


