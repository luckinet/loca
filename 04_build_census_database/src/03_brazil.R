# ----
# geography : Brazil
# period    : (1974)1990 - 2018
# dataseries:
#   - Instituto Brasileiro de Geografia e Estatistica (https://sidra.ibge.gov.br)
#   - MapBiomas (https://mapbiomas.org/)
# variables :
#   - land      : hectares_covered
#   - crops     : hectares_planted, hectares_harvested, tons_produced, kiloPerHectare_yield
#   - livestock : number_heads
#   - technology: -
#   - social    : -
# sampling  : survey, census
# spatial   : Nation, Estado, Municipality
# authors   : Steffen Ehrmann
# date      : 2024-03-27
# status    : done
# comment   : -
# ----

thisNation <- "Brazil"
update period

ds <- c("ibge", "mapb")
gs <- c("ibge")


# 1. dataseries ----
#
regDataseries(name = ds[1],
              description = "Instituto Brasileiro de Geografia e Estatistica",
              version = "2023.12.14",
              homepage = "https://sidra.ibge.gov.br",
              licence_link = "unknown")

regDataseries(name = ds[2],
              description = "MapBiomas",
              version = "2023.12.14",
              homepage = "https://mapbiomas.org/",
              licence_link = "unknown")


# 2. geometries ----
#
regGeometry(al1 = !!thisNation,
            gSeries = gs[1],
            label = list(al2 = "NM_ESTADO"),
            archive = "br_unidades_da_federacao.zip|BRUFE250GC_SIR.shp",
            archiveLink = "https://mapas.ibge.gov.br/bases-e-referenciais/bases-cartograficas/malhas-digitais",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "notPlanned")

regGeometry(al1 = !!thisNation,
            gSeries = gs[1],
            label = list(al3 = "NM_MUNICIP"),
            archive = "br_municipios.zip|BRMUE250GC_SIR.shp",
            archiveLink = "https://mapas.ibge.gov.br/bases-e-referenciais/bases-cartograficas/malhas-digitais",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "notPlanned")

normGeometry(pattern = gs[1],
             beep = 10)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  schema_ibge1 <- setCluster(id = "year", left = 1, top = 3, height = 400536) %>%
    setIDVar(name = "al2", columns = 1, split = "((?<=\\().*(?=\\)))") %>%
    setIDVar(name = "al3", columns = 1, split = "(^.*?(?=\\s\\())") %>%
    setIDVar(name = "year", columns = 3) %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "crop", columns = 2) %>%
    setObsVar(name = "hectares_planted", columns = 4) %>%
    setObsVar(name = "hectares_harvested", columns = 5) %>%
    setObsVar(name = "tons_produced", columns = 6) %>%
    setObsVar(name = "kilo_per_hectare_yield", factor = 0.001, columns = 7)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 1990,
           end = 1990,
           archive = "ibge.7z|tabela5457_1990.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 1991,
           end = 1991,
           archive = "ibge.7z|tabela5457_1991.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 1992,
           end = 1992,
           archive = "ibge.7z|tabela5457_1992.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 1993,
           end = 1993,
           archive = "ibge.7z|tabela5457_1993.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1= !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 1994,
           end = 1994,
           archive = "ibge.7z|tabela5457_1994.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 1995,
           end = 1995,
           archive = "ibge.7z|tabela5457_1995.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 1996,
           end = 1996,
           archive = "ibge.7z|tabela5457_1996.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 1997,
           end = 1997,
           archive = "ibge.7z|tabela5457_1997.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 1998,
           end = 1998,
           archive = "ibge.7z|tabela5457_1998.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 1999,
           end = 1999,
           archive = "ibge.7z|tabela5457_1999.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2000,
           end = 2000,
           archive = "ibge.7z|tabela5457_2000.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2001,
           end = 2001,
           archive = "ibge.7z|tabela5457_2001.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2002,
           end = 2002,
           archive = "ibge.7z|tabela5457_2002.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2003,
           end = 2003,
           archive = "ibge.7z|tabela5457_2003.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2004,
           end = 2004,
           archive = "ibge.7z|tabela5457_2004.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2005,
           end = 2005,
           archive = "ibge.7z|tabela5457_2005.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2006,
           end = 2006,
           archive = "ibge.7z|tabela5457_2006.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2007,
           end = 2007,
           archive = "ibge.7z|tabela5457_2007.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2008,
           end = 2008,
           archive = "ibge.7z|tabela5457_2008.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2009,
           end = 2009,
           archive = "ibge.7z|tabela5457_2009.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2010,
           end = 2010,
           archive = "ibge.7z|tabela5457_2010.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2011,
           end = 2011,
           archive = "ibge.7z|tabela5457_2011.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2012,
           end = 2012,
           archive = "ibge.7z|tabela5457_2012.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2013,
           end = 2013,
           archive = "ibge.7z|tabela5457_2013.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2014,
           end = 2014,
           archive = "ibge.7z|tabela5457_2014.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2015,
           end = 2015,
           archive = "ibge.7z|tabela5457_2015.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2016,
           end = 2016,
           archive = "ibge.7z|tabela5457_2016.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2017,
           end = 2017,
           archive = "ibge.7z|tabela5457_2017.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           subset = "crops",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge1,
           begin = 2018,
           end = 2018,
           archive = "ibge.7z|tabela5457_2018.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/5457",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  normTable(pattern = paste0("crops.*", ds[1]),
            ontoMatch = "crop",
            beep = 10)
}

if(build_livestock){
  ## livestock ----

  schema_ibge2 <-
    setFormat(na_values = c("...", "-")) %>%
    setIDVar(name = "al2", columns = 1, split = "((?<=\\().*(?=\\)))") %>%
    setIDVar(name = "al3", columns = 1, split = "(^.*?(?=\\s\\())") %>%
    setIDVar(name = "year", columns = 3) %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "animal", columns = 2) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           subset = "livestock",
           label = "al3",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ibge2,
           begin = 1974,
           end = 2018,
           archive = "ibge.7z|tabela3939.csv",
           archiveLink = "https://sidra.ibge.gov.br/tabela/3939",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://metadados.ibge.gov.br/consulta/estatisticos/operacoes-estatisticas/PA",
           metadataPath = "unavailable",
           overwrite = TRUE)

  normTable(pattern = paste0("livestock.*", ds[1]),
            ontoMatch = "animal",
            beep = 10)

}

if(build_landuse){
  ## landuse ----

  schema_mapb1 <- setFormat(thousand = ",") %>%
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 4) %>%
    setIDVar(name = "year", columns = c(9:41), rows = 1) %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "use", columns = 7) %>%
    setObsVar(name = "hectares_covered", columns = c(9:41))

  regTable(al1 = !!thisNation,
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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://mapbiomas.org/atbd-3",
           metadataPath = "unavailable",
           overwrite = TRUE)

  normTable(pattern = ds[2],
            ontoMatch = "use",
            beep = 10)

}
