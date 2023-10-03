# script arguments ----
#
thisNation <- "Bolivia"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("ine", "UNODC")
gs <- c("gadm36")


# register dataseries ----
#
regDataseries(name = ds[1],
              description = "Institution Nacional de Estadistica",
              homepage = "https://www.ine.gob.bo/",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)


# register geometries ----
#


# register census tables ----
#
## ine ----
schema_ine1 <- setCluster(id = "al2", left = 1, top = 3, height = 30) %>%
  setFormat(thousand = ".") %>%
  setIDVar(name = "al2", columns = 1, rows = 1, split = ".+?(?=:)") %>%
  setIDVar(name = "year", columns = c(2:31), rows = 3, split = "(?<=\\-).*") %>%
  setIDVar(name = "item", columns = 1) %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2:31))

regTable(nation = "Bolivia",
         label = "al2",
         subset = "beniPlan",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine1,
         begin = 1984,
         end = 2012,
         archive = "Bolivia - Superficie Año Agricola por Departamento, 1984 - 2019 .xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ine1_01 <- schema_ine1 %>%
  setCluster(id = "al2", left = 1, top = 3, height = 33)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "chuquisacaPlan",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine1_01,
         begin = 1984,
         end = 2012,
         archive = "Bolivia - Superficie Año Agricola por Departamento, 1984 - 2019 .xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ine1_02 <- schema_ine1 %>%
  setCluster(id = "al2", left = 1, top = 3, height = 36)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "cochabambaPlan",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine1_02,
         begin = 1984,
         end = 2012,
         archive = "Bolivia - Superficie Año Agricola por Departamento, 1984 - 2019 .xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "laPazPlan",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine1_02,
         begin = 1984,
         end = 2012,
         archive = "Bolivia - Superficie Año Agricola por Departamento, 1984 - 2019 .xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ine1_03 <- schema_ine1 %>%
  setCluster(id = "al2", left = 1, top = 3, height = 17)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "oruroPlan",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine1_03,
         begin = 1984,
         end = 2012,
         archive = "Bolivia - Superficie Año Agricola por Departamento, 1984 - 2019 .xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ine1_04 <- schema_ine1 %>%
  setCluster(id = "al2", left = 1, top = 3, height = 23)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "pandoPlan",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine1_04,
         begin = 1984,
         end = 2012,
         archive = "Bolivia - Superficie Año Agricola por Departamento, 1984 - 2019 .xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ine1_05 <- schema_ine1 %>%
  setCluster(id = "al2", left = 1, top = 3, height = 26)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "potosiPlan",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine1_05,
         begin = 1984,
         end = 2013,
         archive = "Bolivia - Superficie Año Agricola por Departamento, 1984 - 2019 .xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ine1_06 <- schema_ine1 %>%
  setCluster(id = "al2", left = 1, top = 3, height = 40)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "santaCruzPlan",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine1_06,
         begin = 1984,
         end = 2013,
         archive = "Bolivia - Superficie Año Agricola por Departamento, 1984 - 2019 .xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ine1_07 <- schema_ine1 %>%
  setCluster(id = "al2", left = 1, top = 3, height = 38)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "tarijaPlan",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine1_07,
         begin = 1984,
         end = 2013,
         archive = "Bolivia - Superficie Año Agricola por Departamento, 1984 - 2019 .xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_ine2 <- setCluster(id = "al2", left = 1, top = 4, height = 27) %>%
  setFormat(thousand = ".") %>%
  setIDVar(name = "al2", columns = 1, rows = 1, split = ".+?(?=:)") %>%
  setIDVar(name = "year", columns = c(2:31), rows = 3, split = "(?<=\\-).*") %>%
  setIDVar(name = "item", columns = 1) %>%
  setObsVar(name = "production", unit = "t", columns = c(2:31))

regTable(nation = "Bolivia",
         label = "al2",
         subset = "beniProd",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine2,
         begin = 1984,
         end = 2013,
         archive = "Bolivia - Produccion Año Agricola por Departamento, 1984 - 2019.xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ine2_01 <- schema_ine2 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 31)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "chuquisacaProd",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine2_01,
         begin = 1984,
         end = 2013,
         archive = "Bolivia - Produccion Año Agricola por Departamento, 1984 - 2019.xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ine2_02 <- schema_ine2 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 34)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "cochabambaProd",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine2_02,
         begin = 1984,
         end = 2013,
         archive = "Bolivia - Produccion Año Agricola por Departamento, 1984 - 2019.xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "laPazProd",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine2_02,
         begin = 1984,
         end = 2013,
         archive = "Bolivia - Produccion Año Agricola por Departamento, 1984 - 2019.xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ine2_03 <- schema_ine2 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 15)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "oruroProd",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine2_03,
         begin = 1984,
         end = 2013,
         archive = "Bolivia - Produccion Año Agricola por Departamento, 1984 - 2019.xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ine2_04 <- schema_ine2 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 21)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "pandoProd",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine2_04,
         begin = 1984,
         end = 2013,
         archive = "Bolivia - Produccion Año Agricola por Departamento, 1984 - 2019.xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ine2_05 <- schema_ine2 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 24)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "potosiProd",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine2_05,
         begin = 1984,
         end = 2013,
         archive = "Bolivia - Produccion Año Agricola por Departamento, 1984 - 2019.xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ine2_06 <- schema_ine2 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 38)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "santaCruzProd",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine2_06,
         begin = 1984,
         end = 2013,
         archive = "Bolivia - Produccion Año Agricola por Departamento, 1984 - 2019.xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ine2_07 <- schema_ine2 %>%
  setCluster(id = "al2", left = 1, top = 4, height = 36)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "tarijaProd",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ine2_07,
         begin = 1984,
         end = 2013,
         archive = "Bolivia - Produccion Año Agricola por Departamento, 1984 - 2019.xlsx",
         archiveLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-cuadros-estadisticos/",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## UNODC-----
# Province "Caranavi" is a part of Nor Yungas in gadm database. I have translated it into Nor Yungas, as it is the only problem with the dataset.
# In gadm Caranavi is level 4.
schema_bol_UNODC_01 <-
  setFormat(thousand = ".") %>%
  setFilter(rows = .find(pattern = "Total", invert = TRUE)) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:12)) %>%
  setIDVar(name = "item", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:12))

regTable(nation = "Bolivia",
         label = "al3",
         subset = "plantedCocaLaPaz",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_bol_UNODC_01,
         begin = 2009,
         end = 2019,
         archive = "Bolivia_Informe_Monitoreo_Coca_2019.pdf|p.39",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Bolivia/Bolivia_Informe_Monitoreo_Coca_2018_web.pdf",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_bol_UNODC_02 <-
  setFormat(thousand = ".") %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 1, invert = TRUE)) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "al4", columns = 2) %>%
  setIDVar(name = "year", rows = 1, columns = c(3:9)) %>%
  setIDVar(name = "item", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(3:9))

regTable(nation = "Bolivia",
         level = 4,
         subset = "plantedCocaLaPaz",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_bol_UNODC_02,
         begin = 2002,
         end = 2008,
         archive = "Bolivia_Coca_Survey_for2008_En.pdf.pdf|p.19",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Bolivia/Bolivia_Coca_Survey_for2008_En.pdf.pdf",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/documents/crop-monitoring/Bolivia/Bolivia_Coca_Survey_for2008_En.pdf.pdf",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_bol_UNODC_03 <-
  setFormat(thousand = ".") %>%
  setFilter(rows = .find(pattern = "Total", col = 1, invert = TRUE)) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", rows = 1, columns = c(3:13)) %>%
  setIDVar(name = "item", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(3:13))

regTable(nation = "Bolivia",
         label = "al3",
         subset = "plantedCocaCochabambaBeni",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_bol_UNODC_03,
         begin = 2009,
         end = 2019,
         archive = "Bolivia_Informe_Monitoreo_Coca_2019.pdf|p.44",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Bolivia/Bolivia_Informe_Monitoreo_Coca_2018_web.pdf",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_bol_UNODC_04 <-
  setFormat(thousand = ".") %>%
  setFilter(rows = .find(pattern = "..Total", col = 1, invert = TRUE)) %>%
  setIDVar(name = "al3", columns = 1) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:7)) %>%
  setIDVar(name = "item", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:7))

regTable(nation = "Bolivia",
         label = "al3",
         subset = "plantedCocaCochabamba",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_bol_UNODC_04,
         begin = 2003,
         end = 2008,
         archive = "Bolivia_Coca_Survey_for2008_En.pdf.pdf|p.28",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Bolivia/Bolivia_Coca_Survey_for2008_En.pdf.pdf",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_bol_UNODC_05 <-
  setFormat(thousand = ",") %>%
  setIDVar(name = "al1", value = "Bolivia") %>%
  setIDVar(name = "year", rows = 1, columns = c(2:12)) %>%
  setIDVar(name = "item", value = "coca") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:12))

regTable(nation = "Bolivia",
         label = "al1",
         subset = "plantedCocaBolivia",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_bol_UNODC_05,
         begin = 1994,
         end = 2004,
         archive = "Andean-coca-June05.pdf|p.34",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Andean-coca-June05.pdf",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_bol_UNODC_06 <-
  setFilter(rows = c(3:6)) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:5), rows = 3) %>%
  setIDVar(name = "item", value = "coca") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:5))

regTable(nation = "Bolivia",
         label = "al2",
         subset = "productionCoca",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_bol_UNODC_06,
         begin = 2010,
         end = 2013,
         archive = "production_bolivia_coca_lvl2_2012_2013_unit(mt).csv", # can't find the original pdf file containing this data
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_bol_UNODC_07 <-
  setFilter(rows = .find(pattern = "Total..", col = 1, invert = TRUE)) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", value = "2014") %>%
  setIDVar(name = "item", value = "coca") %>%
  setObsVar(name = "production", unit = "t", columns = 4) %>%
  setObsVar(name = "planted", unit = "ha", columns = 2) %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = 3)

regTable(nation = "Bolivia",
         label = "al2",
         subset = "productionCoca",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_bol_UNODC_07,
         begin = 2014,
         end = 2014,
         archive = "production_bolivia_coca_lvl2_2014_unit(mt).csv", # can't find the original pdf file containing this data
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_bol_UNODC_08 <-
  setFilter(rows = .find(pattern = "Bolivia", col = 1)) %>%
  setIDVar(name = "al1", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:12), rows = 1) %>%
  setIDVar(name = "item", value = "coca") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:12))

regTable(nation = "Bolivia",
         label = "al1",
         subset = "productionCoca",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_bol_UNODC_08,
         begin = 1994,
         end = 2004,
         archive = "production_bolivia_peru_colombia_cocaine_lvl3_1994_2004_unit(mt).csv", # can't find the original pdf file containing this data
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Bolivia",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


# normalise geometries ----
#
# not needed


# normalise census tables ----
#
normTable(pattern = ds[1],
          # ontoMatch = "item",
          outType = "rds",
          beep = 10,
          update = updateTables)

normTable(pattern = ds[2],
          # ontoMatch = "item",
          outType = "rds",
          beep = 10,
          update = updateTables)
