# script arguments ----
#
thisNation <- "Bolivia"

ds <- c("ine")
gs <- c("gadm")


# 1. dataseries ----
#
# ! see 02_unodc.R !
#
regDataseries(name = ds[1],
              description = "Institution Nacional de Estadistica",
              version = "2023.01.08",
              homepage = "https://www.ine.gob.bo/",
              licence_link = "unknown")


# 2. geometries ----
#


# 3. tables ----
#
if(build_crops){
  ## crops ----

  schema_ine1 <- setCluster(id = "al2", left = 1, top = 3, height = 30) %>%
    setFormat(thousand = ".") %>%
    setIDVar(name = "al2", columns = 1, rows = 1, split = ".+?(?=:)") %>%
    setIDVar(name = "year", columns = c(2:31), rows = 3, split = "((?<=\\-).*)") %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "crop", columns = 1) %>%
    setObsVar(name = "hectares_harvested", columns = c(2:31))

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_ine1_01 <- schema_ine1 %>%
    setCluster(id = "al2", left = 1, top = 3, height = 33)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_ine1_02 <- schema_ine1 %>%
    setCluster(id = "al2", left = 1, top = 3, height = 36)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_ine1_03 <- schema_ine1 %>%
    setCluster(id = "al2", left = 1, top = 3, height = 17)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_ine1_04 <- schema_ine1 %>%
    setCluster(id = "al2", left = 1, top = 3, height = 23)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_ine1_05 <- schema_ine1 %>%
    setCluster(id = "al2", left = 1, top = 3, height = 26)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_ine1_06 <- schema_ine1 %>%
    setCluster(id = "al2", left = 1, top = 3, height = 40)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_ine1_07 <- schema_ine1 %>%
    setCluster(id = "al2", left = 1, top = 3, height = 38)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)


  schema_ine2 <- setCluster(id = "al2", left = 1, top = 4, height = 27) %>%
    setFormat(thousand = ".") %>%
    setIDVar(name = "al2", columns = 1, rows = 1, split = ".+?(?=:)") %>%
    setIDVar(name = "year", columns = c(2:31), rows = 3, split = "((?<=\\-).*)") %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "crop", columns = 1) %>%
    setObsVar(name = "tons_produced", columns = c(2:31))

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_ine2_01 <- schema_ine2 %>%
    setCluster(id = "al2", left = 1, top = 4, height = 31)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_ine2_02 <- schema_ine2 %>%
    setCluster(id = "al2", left = 1, top = 4, height = 34)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_ine2_03 <- schema_ine2 %>%
    setCluster(id = "al2", left = 1, top = 4, height = 15)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_ine2_04 <- schema_ine2 %>%
    setCluster(id = "al2", left = 1, top = 4, height = 21)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_ine2_05 <- schema_ine2 %>%
    setCluster(id = "al2", left = 1, top = 4, height = 24)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_ine2_06 <- schema_ine2 %>%
    setCluster(id = "al2", left = 1, top = 4, height = 38)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_ine2_07 <- schema_ine2 %>%
    setCluster(id = "al2", left = 1, top = 4, height = 36)

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.ine.gob.bo/index.php/estadisticas-economicas/agropecuaria/agricultura-metadatos/",
           metadataPath = "unknown",
           overwrite = TRUE)

  normTable(pattern = ds[1],
            ontoMatch = "crop",
            beep = 10)

}

if(build_livestock){
  ## livestock ----

}

if(build_landuse){
  ## landuse ----

}
