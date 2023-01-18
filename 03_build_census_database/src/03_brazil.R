# script arguments ----
#
thisNation <- "Brazil"

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("ibge", "mapb", "spam")
gs <- c("ibge", "spam")

regDataseries(name = ds[1],
              description = "Instituto Brasileiro de Geografia e Estatistica",
              homepage = "https://sidra.ibge.gov.br",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)

regDataseries(name = ds[2],
              description = "MapBiomas",
              homepage = "https://mapbiomas.org/",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)


# register geometries ----
#
## ibge ----
regGeometry(nation = "Brazil",
            gSeries = gs[1],
            label = "al2",
            nameCol = "NM_ESTADO",
            archive = "br_unidades_da_federacao.zip|BRUFE250GC_SIR.shp",
            archiveLink = "https://mapas.ibge.gov.br/bases-e-referenciais/bases-cartograficas/malhas-digitais",
            updateFrequency = "notPlanned",
            update = updateTables)

regGeometry(nation = "Brazil",
            gSeries = gs[1],
            label = "al3",
            nameCol = "NM_MUNICIP",
            archive = "br_municipios.zip|BRMUE250GC_SIR.shp",
            archiveLink = "https://mapas.ibge.gov.br/bases-e-referenciais/bases-cartograficas/malhas-digitais",
            updateFrequency = "notPlanned",
            update = updateTables)


# register census tables ----
#
## ibge ----
schema_ibge1 <- setCluster(id = "year", left = 1, top = 3, height = 400536) %>%
  setIDVar(name = "al2", columns = 1, split = "(?<=\\().*(?=\\))") %>%
  setIDVar(name = "al3", columns = 1, split = "^.*?(?=\\s\\()") %>%
  setIDVar(name = "year", columns = 3) %>%
  setIDVar(name = "commodity", columns = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = 4) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 5) %>%
  setObsVar(name = "production", unit = "t", columns = 6) %>%
  setObsVar(name = "yield", unit = "t/ha", factor = 0.001, columns = 7)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 1990,
         end = 1990,
         archive = "ibge.7z|tabela5457_1990.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 1991,
         end = 1991,
         archive = "ibge.7z|tabela5457_1991.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 1992,
         end = 1992,
         archive = "ibge.7z|tabela5457_1992.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 1993,
         end = 1993,
         archive = "ibge.7z|tabela5457_1993.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 1994,
         end = 1994,
         archive = "ibge.7z|tabela5457_1994.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 1995,
         end = 1995,
         archive = "ibge.7z|tabela5457_1995.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 1996,
         end = 1996,
         archive = "ibge.7z|tabela5457_1996.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 1997,
         end = 1997,
         archive = "ibge.7z|tabela5457_1997.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 1998,
         end = 1998,
         archive = "ibge.7z|tabela5457_1998.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 1999,
         end = 1999,
         archive = "ibge.7z|tabela5457_1999.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2000,
         end = 2000,
         archive = "ibge.7z|tabela5457_2000.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2001,
         end = 2001,
         archive = "ibge.7z|tabela5457_2001.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2002,
         end = 2002,
         archive = "ibge.7z|tabela5457_2002.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2003,
         end = 2003,
         archive = "ibge.7z|tabela5457_2003.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2004,
         end = 2004,
         archive = "ibge.7z|tabela5457_2004.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2005,
         end = 2005,
         archive = "ibge.7z|tabela5457_2005.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2006,
         end = 2006,
         archive = "ibge.7z|tabela5457_2006.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2007,
         end = 2007,
         archive = "ibge.7z|tabela5457_2007.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2008,
         end = 2008,
         archive = "ibge.7z|tabela5457_2008.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2009,
         end = 2009,
         archive = "ibge.7z|tabela5457_2009.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2010,
         end = 2010,
         archive = "ibge.7z|tabela5457_2010.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2011,
         end = 2011,
         archive = "ibge.7z|tabela5457_2011.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2012,
         end = 2012,
         archive = "ibge.7z|tabela5457_2012.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2013,
         end = 2013,
         archive = "ibge.7z|tabela5457_2013.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2014,
         end = 2014,
         archive = "ibge.7z|tabela5457_2014.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2015,
         end = 2015,
         archive = "ibge.7z|tabela5457_2015.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2016,
         end = 2016,
         archive = "ibge.7z|tabela5457_2016.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2017,
         end = 2017,
         archive = "ibge.7z|tabela5457_2017.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "Brazil",
         subset = "crops",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge1,
         begin = 2018,
         end = 2018,
         archive = "ibge.7z|tabela5457_2018.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

schema_ibge2 <- setCluster(id = "year", left = 1, top = 3) %>%
  setFormat(na_values = c("...", "-")) %>%
  setIDVar(name = "al2", columns = 1, split = "(?<=\\().*(?=\\))") %>%
  setIDVar(name = "al3", columns = 1, split = "^.*?(?=\\s\\()") %>%
  setIDVar(name = "year", columns = 3) %>%
  setIDVar(name = "commodity", columns = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = 4)

regTable(nation = "Brazil",
         subset = "livestock",
         label = "al3",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ibge2,
         begin = 1974,
         end = 2018,
         archive = "ibge.7z|tabela3939.csv",
         archiveLink = "https://sidra.ibge.gov.br/tabela/3939",
         nextUpdate = "unknown",
         updateFrequency = "annually",
         metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

## mapb ----
schema_mapb1 <- setFormat(thousand = ",") %>%
  setIDVar(name = "al2", columns = 2) %>%
  setIDVar(name = "al3", columns = 4) %>%
  setIDVar(name = "year", columns = c(9:41), rows = 1) %>%
  setIDVar(name = "commodity", columns = 7) %>%
  setObsVar(name = "covered", unit = "ha", columns = c(9:41))

regTable(nation = "Brazil",
         subset = "forest",
         label = "al3",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_mapb1,
         begin = 1985,
         end = 2017,
         archive = "MapBiomas Col3 - COBERTURA_uf_biomas_municpios.xlsx",
         archiveLink = "https://mapbiomas.org/download_estatisticas",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://mapbiomas.org/atbd-3",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

# regTable(nation = "Brazil",
#          label = "al3",
#          dSeries = ds[3],
#          gSeries = gs[2],
#          schema = meta_spam52,
#          begin = 2006,
#          end = 2006,
#          archive = "woodSichra_Brazil_data.rar|Brazilmun_key_Pasture2006.dbf",
#          archiveLink = "https://www.dropbox.com/sh/wmfktyq34on5jbn/AACrD6p2HjVZH2EwaMPS04Xua?dl=0",
#          updateFrequency = "not planned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = updateTables)


# normalise geometries ----
#
normGeometry(pattern = gs[1],
             outType = "gpkg",
             priority = "ontology",
             update = updateTables)


# normalise census tables ----
#
normTable(pattern = ds[1],
          ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)


