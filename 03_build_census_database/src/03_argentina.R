# script arguments ----
#
thisNation <- "Argentina"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
# name the data series ...
ds <- c("senasa")
gs <- c("gadm", "ign")

# ... and register them
regDataseries(name = gs[1],
              description = "Instituto Geografico Nacional",
              homepage = "http://www.ign.gob.ar",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)

regDataseries(name = ds[1],
              description = "Ministerio de Agricultura, Ganaderia y Pesca",
              homepage = "https://www.argentina.gob.ar/senasa",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)


# register geometries ----
#
## ign ----
regGeometry(nation = "Argentina",
            gSeries = gs[1],
            level = 1,
            nameCol = "NAM",
            archive = "pais.zip|País.shp",
            archiveLink = "http://www.ign.gob.ar/NuestrasActividades/InformacionGeoespacial/CapasSIG",
            updateFrequency = "notPlanned",
            update = updateTables)

regGeometry(nation = "Argentina",
            gSeries = gs[1],
            level = 2,
            nameCol = "NAM",
            archive = "PROVINCIAS.zip|Provincias.shp",
            archiveLink = "http://www.ign.gob.ar/NuestrasActividades/InformacionGeoespacial/CapasSIG",
            updateFrequency = "notPlanned",
            update = updateTables)

regGeometry(nation = "Argentina",
            gSeries = gs[1],
            level = 3,
            nameCol = "NAM",
            archive = "DEPARTAMENTOS.zip|Departamentos.shp",
            archiveLink = "http://www.ign.gob.ar/NuestrasActividades/InformacionGeoespacial/CapasSIG",
            updateFrequency = "notPlanned",
            update = updateTables)


# register census tables ----
#
## senasa ----
schema_senasa1 <-
  setIDVar(name = "al2", columns = 2) %>%
  setIDVar(name = "al3", columns = 4) %>%
  setIDVar(name = "year", columns = 8, split = "(?<=\\/).*") %>%
  setIDVar(name = "commodities", columns = 6) %>%
  setObsVar(name = "planted", columns = 9, unit = "ha") %>%
  setObsVar(name = "harvested", columns = 10, unit = "ha") %>%
  setObsVar(name = "production", columns = 11, unit = "t") %>%
  setObsVar(name = "yield", columns = 12, unit = "kg/ha")

regTable(nation = "arg",
         level = 3,
         subset = "crops",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_senasa1,
         begin = 1970,
         end = 2020,
         archive = "estimaciones-agricolas-2020-08.csv",
         archiveLink = "https://datos.magyp.gob.ar/dataset/estimaciones-agricolas",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataPath = "unknown",
         metadataLink = "https://datos.magyp.gob.ar/dataset/estimaciones-agricolas/archivo/95d066e6-8a0f-4a80-b59d-6f28f88eacd5",
         update = updateTables,
         overwrite = overwriteTables)


schema_senasa2 <-
  setIDVar(name = "al2", columns = 2) %>%
  setIDVar(name = "al3", columns = 4) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(6:14), rows = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(6:14))

regTable(nation = "arg",
         level = 3,
         subset = "bovines",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_senasa2,
         begin = 2008,
         end = 2019,
         archive = "existencias-bovinas-provincia-departamento-2008-2019.csv",
         archiveLink = "https://datos.agroindustria.gob.ar/dataset/c19a5875-fb39-48b6-b0b2-234382722afb/resource/1b920477-8112-4e12-bc2c-94b564f04183/download/existencias-bovinas-provincia-departamento-2008-2019.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataPath = "unknown",
         metadataLink = "https://datos.agroindustria.gob.ar/dataset/senasa-existencias-bovinas",
         update = updateTables,
         overwrite = overwriteTables)


schema_senasa3 <-
  setIDVar(name = "al2", columns = 2) %>%
  setIDVar(name = "al3", columns = 4) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(6:11), rows = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(6:11))

regTable(nation = "arg",
         level = 3,
         subset = "equines",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_senasa3,
         begin = 2008,
         end = 2019,
         archive = "existencias-equinas-provincia-departamento-2008-2019.csv",
         archiveLink = "https://datos.agroindustria.gob.ar/dataset/4e58e69d-317a-4666-b70e-c668b43cdf16/resource/47b0bbc7-3ca2-4909-a29e-54be64b180c6/download/existencias-equinas-provincia-departamento-2008-2019.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataPath = "unknown",
         metadataLink = "https://datos.agroindustria.gob.ar/dataset/senasa-existencias-equinas",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "arg",
         level = 3,
         subset = "goats",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_senasa3,
         begin = 2008,
         end = 2019,
         archive = "existencias-caprinas-provincia-departamento-2008-2019.csv",
         archiveLink = "https://datos.agroindustria.gob.ar/dataset/10be262c-e6b2-484c-9bb7-ec74b3b5bbc7/resource/5a4d55ff-464e-41bb-b3be-4aaad020bf35/download/existencias_caprinas.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataPath = "unknown",
         metadataLink = "https://datos.agroindustria.gob.ar/dataset/senasa-existencias-caprinas",
         update = updateTables,
         overwrite = overwriteTables)


schema_senasa4 <-
  setIDVar(name = "al2", columns = 2) %>%
  setIDVar(name = "al3", columns = 4) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(6:10), rows = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(6:10))

regTable(nation = "arg",
         level = 3,
         subset = "sheep",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_senasa4,
         begin = 2008,
         end = 2019,
         archive = "existencias-ovinas-provincia-departamento-2008-2019.csv",
         archiveLink = "https://datos.agroindustria.gob.ar/dataset/107f502f-d0f8-4835-860e-cc7d2fc5425f/resource/5dfb3c49-7260-4dc4-afa3-95f3459754a6/download/existencias-ovinas-provincia-departamento-2008-2019.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataPath = "unknown",
         metadataLink = "https://datos.agroindustria.gob.ar/dataset/senasa-existencias-ovinas",
         update = updateTables,
         overwrite = overwriteTables)


schema_senasa5 <-
  setIDVar(name = "al2", columns = 2) %>%
  setIDVar(name = "al3", columns = 4) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(6:12), rows = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(6:12))

regTable(nation = "arg",
         level = 3,
         subset = "pigs",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_senasa5,
         begin = 2008,
         end = 2019,
         archive = "existencias-porcinas-provincia-departamento-2008-2019.csv",
         archiveLink = "https://datos.agroindustria.gob.ar/dataset/7ca226f7-7727-44e8-9006-e9cabd854cf5/resource/e2ab186a-465d-481d-9159-e145f1435074/download/existencias-porcinas-provincia-departamento-2008-2019.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataPath = "unknown",
         metadataLink = "https://datos.agroindustria.gob.ar/dataset/senasa-existencias-porcinas",
         update = updateTables,
         overwrite = overwriteTables)


schema_senasa6 <-
  setIDVar(name = "al1", columns = 2) %>%
  setIDVar(name = "al2", columns = 4) %>%
  setIDVar(name = "year", columns = 14) %>%
  setIDVar(name = "commodities", columns = c(7:10), rows = 1) %>%
  setObsVar(name = "tree_rows", unit = "km", columns = c(7:10), key = 5, value = "cortinas") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(7:10), key = 5, value = "macizo")

regTable(nation = "arg",
         level = 2,
         subset = "plantation",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_senasa6,
         begin = 2009,
         end = 2017,
         archive = "inventario-nacional-de-plantaciones-forestales-superficie-20180725.csv",
         archiveLink = "http://datosestimaciones.magyp.gob.ar/reportes.php?reporte=Estimaciones",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "https://www.agroindustria.gob.ar/sitio/areas/estimaciones/estimaciones/metodologia/_archivos//000000_Metodo%20de%20segmentos%20aleatorios%20(Version%205).pdf",
         metadataPath = "/areal database/adb_tables/meta_maia",
         update = updateTables,
         overwrite = overwriteTables)


# harmonise commodities ----
#
for(i in seq_along(ds)){

  tibble(new = get_variable(variable = "commodities", dataseries = ds[i])) %>%
    match_ontology(table = ., columns = "new", dataseries = ds[i], ontology = ontoDir)

}


# normalise geometries ----
#
normGeometry(pattern = gs[2],
             outType = "gpkg",
             update = updateTables)


# normalise census tables ----
#
normTable(pattern = ds[1],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)


# correct years (can this also be moved to the previous section?----
#
# finally the year values need to be corrected, because they contain some sort
# of flag.
readRDS(file = paste0(getOption("adb_path"), "/adb_tables/stage3/Argentina.rds")) %>%
  mutate(year = if_else(is.na(as.numeric(year)),
                        as.numeric(str_sub(year, start = 1, end = 4))+1,
                        as.numeric(year)),
         year = as.character(year)) %>%
  saveRDS(file = paste0(getOption("adb_path"), "/adb_tables/stage3/Argentina.rds"))


