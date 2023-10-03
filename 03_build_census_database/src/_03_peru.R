# script arguments ----
#
# see "97_oldCode.R"
thisNation <- "Peru"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("unodc")
gs <- c("gadm36")


# register dataseries ----
#


# register geometries ----
#


# register census tables ----
#
# unodc ----
schema_per_01 <- setCluster(id = "al1") %>%
  setFormat(thousand = ".") %>%
  setIDVar(name = "al1", value = "Peru") %>%
  setIDVar(name = "year", rows = 1, columns = c(2:12)) %>%
  setIDVar(name = "commodities", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:12), relative = TRUE)

regTable(nation = "per",
         level = 1,
         subset = "plantCoca",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_01,
         begin = 1994,
         end = 2004,
         archive = "Andean-coca-June05.pdf|p.193",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Andean-coca-June05.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# Following two tables have Ene as geometry. Ene is a geo-political area of a rivervaley. Numbers for planted hectarse are very low there.
schema_per_02 <-
  setFormat(thousand = ".") %>%
  setFilter(rows = .find("Total", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:5)) %>%
  setIDVar(name = "commodities", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:5))

regTable(nation = "per",
         level = 2,
         subset = "plantCocaApurimac",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_02,
         begin = 2001,
         end = 2004,
         archive = "Andean-coca-June05.pdf|p.207",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Andean-coca-June05.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_per_03 <-
  setFormat(thousand = ",") %>%
  setFilter(rows = .find("Total", col = 1)) %>%
  setIDVar(name = "al2", value = "Apurimac") %>%
  setIDVar(name = "year", rows = 1, columns = c(2:6)) %>%
  setIDVar(name = "commodities", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:6))

regTable(nation = "per",
         level = 2,
         subset = "plantCocaApurimac",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_03,
         begin = 2002,
         end = 2006,
         archive = "peru_2006_sp_web.pdf|p.28",
         archiveLink = "https://www.unodc.org/pdf/research/icmp/peru_2006_sp_web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# Data is level 4, from district Macusani - Inambari and Tambopata are river valeys in this district. It is not available in our gadm dataset.
schema_per_04 <-
  setFormat(thousand = ".") %>%
  setFilter(rows = .find("..total", col = 1), invert = TRUE) %>%
  setIDVar(name = "al4", columns = 1) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:5)) %>%
  setIDVar(name = "commodities", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:5))

regTable(nation = "per",
         level = 4,
         subset = "plantCocaInambariTambopata",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_04,
         begin = 2001,
         end = 2004,
         archive = "Andean-coca-June05.pdf|p.213",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Andean-coca-June05.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_per_05 <-
  setIDVar(name = "al1", value = "Peru") %>%
  setIDVar(name = "year", rows = 1, columns = c(1:11)) %>%
  setIDVar(name = "commodities", value = "poppy") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(1:11))

regTable(nation = "per",
         level = 1,
         subset = "plantPoppy",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_05,
         begin = 1994,
         end = 2004,
         archive = "Andean-coca-June05.pdf|p.243",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Andean-coca-June05.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# Both La Convcion and Lares are in province La convencion, again river valeys.
schema_per_06 <-
  setFilter(rows = .find("Total", col = 1)) %>%
  setFormat(thousand = ".") %>%
  setIDVar(name = "al3", value = "La Convencion") %>%
  setIDVar(name = "year", rows = 1, columns = c(2:5)) %>%
  setIDVar(name = "commodities", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:5))

regTable(nation = "per",
         level = 3,
         subset = "plantLaConvencion",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_06,
         begin = 2001,
         end = 2004,
         archive = "Andean-coca-June05.pdf|p.211",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Andean-coca-June05.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# Very detailed data, however, level 4 is not in our gadm dataset.
schema_per_07 <-
  setFormat(thousand = ",") %>%
  setFilter(rows = .find("TOTAL..", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "al4", columns = 3) %>%
  setIDVar(name = "year", value = "2017") %>%
  setIDVar(name = "commodities", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = 4)

regTable(nation = "per",
         level = 4,
         subset = "plantedCoca",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_07,
         begin = 2017,
         end = 2017,
         archive = "Peru_Monitoreo_de_Cultivos_de_Coca_2017_web.pdf|p.102-105",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Peru_Monitoreo_de_Cultivos_de_Coca_2017_web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_per_08 <- schema_per_07 %>%
  setIDVar(name = "year", value = "2016")

regTable(nation = "per",
         level = 4,
         subset = "plantedCoca",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_08,
         begin = 2016,
         end = 2016,
         archive = "Peru_Monitoreo_de_coca_2016_web.pdf|p.83-86",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Peru_Monitoreo_de_coca_2016_web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_per_09 <- schema_per_07 %>%
  setIDVar(name = "year", value = "2015")

regTable(nation = "per",
         level = 4,
         subset = "plantedCoca",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_09,
         begin = 2015,
         end = 2015,
         archive = "Peru_monitoreo_coca_2016.pdf|p.99-101",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Peru_monitoreo_coca_2016.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_per_10 <- schema_per_07 %>%
  setIDVar(name = "year", value = "2014")

regTable(nation = "per",
         level = 4,
         subset = "plantedCoca",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_10,
         begin = 2014,
         end = 2014,
         archive = "Peru_Informe_monitoreo_coca_2014_web.pdf|p.86-89",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Peru_Informe_monitoreo_coca_2014_web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_per_11 <- schema_per_07 %>%
  setIDVar(name = "year", value = "2013")

regTable(nation = "per",
         level = 4,
         subset = "plantedCoca",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_11,
         begin = 2013,
         end = 2013,
         archive = "Peru_Monitoreo_de_cultivos_de_coca_2013_web.pdf|p.73-75",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Peru_Monitoreo_de_cultivos_de_coca_2013_web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_per_12 <- schema_per_07 %>%
  setIDVar(name = "year", value = "2012")

regTable(nation = "per",
         level = 4,
         subset = "plantedCoca",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_12,
         begin = 2012,
         end = 2012,
         archive = "Peru_Monitoreo_de_Coca_2012_web.pdf|p.76-78",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Peru_Monitoreo_de_Coca_2012_web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_per_13 <- schema_per_07 %>%
  setIDVar(name = "year", value = "2011")

regTable(nation = "per",
         level = 4,
         subset = "plantedCoca",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_13,
         begin = 2011,
         end = 2011,
         archive = "Informe_cultivos_coca_2011_septiembre2012_web.pdf|p.63-65",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Informe_cultivos_coca_2011_septiembre2012_web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_per_14 <-
  setFormat(thousand = ",") %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:3)) %>%
  setIDVar(name = "commodities", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:3))

regTable(nation = "per",
         level = 2,
         subset = "plantCoca",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_14,
         begin = 2009,
         end = 2010,
         archive = "Peru-cocasurvey2010_es.pdf|p.31",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru/Peru-cocasurvey2010_es.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_per_15 <- schema_per_14 %>%
  setFilter(rows = .find("Total", col = 1), invert = TRUE)

regTable(nation = "per",
         level = 2,
         subset = "plantCoca",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_15,
         begin = 2007,
         end = 2008,
         archive = "Peru_monitoreo_cultivos_coca_2008.pdf|p.29",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Peru_monitoreo_cultivos_coca_2008.pdff",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_per_16 <-
  setFormat(thousand = ",") %>%
  setIDVar(name = "al1", value = "Peru") %>%
  setIDVar(name = "year", rows = 1, columns = c(2:12)) %>%
  setIDVar(name = "commodities", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:12))

regTable(nation = "per",
         level = 1,
         subset = "plantCoca",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_16,
         begin = 1996,
         end = 2006,
         archive = "peru_2006_sp_web.pdf|p.10",
         archiveLink = "https://www.unodc.org/pdf/research/icmp/peru_2006_sp_web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_per_17 <-
  setFilter(rows = .find("Total", col = 1)) %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "al3", value = "La Convencion") %>%
  setIDVar(name = "year", rows = 1, columns = c(2:6)) %>%
  setIDVar(name = "commodities", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:6))

regTable(nation = "per",
         level = 3,
         subset = "plantLaConvencion",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_17,
         begin = 2002,
         end = 2006,
         archive = "peru_2006_sp_web.pdf|p.34",
         archiveLink = "https://www.unodc.org/pdf/research/icmp/peru_2006_sp_web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_per_18 <-
  setFormat(thousand = ",") %>%
  setIDVar(name = "al4", columns = 1) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:6)) %>%
  setIDVar(name = "commodities", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:6))

regTable(nation = "per",
         level = 4,
         subset = "plantCocaSanGaban",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_18,
         begin = 2002,
         end = 2006,
         archive = "peru_2006_sp_web.pdf|p.41",
         archiveLink = "https://www.unodc.org/pdf/research/icmp/peru_2006_sp_web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_per_19 <-
  setFormat(thousand = ",") %>%
  setFilter(rows = .find("Total", col = 1), invert = TRUE) %>%
  setIDVar(name = "al4", columns = 1) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:6)) %>%
  setIDVar(name = "commodities", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:6))

regTable(nation = "per",
         level = 4,
         subset = "plantCocaInambariTambopata",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_per_19,
         begin = 2002,
         end = 2006,
         archive = "peru_2006_sp_web.pdf|p.43",
         archiveLink = "https://www.unodc.org/pdf/research/icmp/peru_2006_sp_web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Peru",
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

normTable(pattern = ds[1],
          ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)

