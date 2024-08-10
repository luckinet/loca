# ----
# geography : _INSERT
# period    : _INSERT
# dataseries: _INSERT
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
# comment   : https://www.regionalstatistik.de/genesis/online?operation=themes&levelindex=0&levelid=1699809095879&code=41#abreadcrumb
# ----

thisNation <- "Germany"

# 1. dataseries ----
#
ds <- c("genesis")
gs <- c("gadm")


regDataseries(name = ds[1],
              description = "Regionaldatenbank Deutschland",
              homepage = "https://www.regionalstatistik.de/genesis/online",
              version = "2024.07",
              licence_link = "https://www.govdata.de/dl-de/by-2-0")


# 2. geometries ----
#


# 3. tables ----
#
if(build_crops){
  ## crops ----

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

  schema_livestock_census <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "census") %>%
    setIDVar(name = "animal", )  %>%
    setObsVar(name = "number_heads", )

  schema_livestock_survey <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "animal", )  %>%
    setObsVar(name = "number_heads", )

  same schema as india basically, solve together!

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_census,
           begin = 1999,
           end = 2007,
           archive = "41120-12-01-4.csv",
           archiveLink = "https://www.regionalstatistik.de/genesis//online?operation=table&code=41120-12-01-4",
           downloadDate = ymd("2024-07-30"),
           updateFrequency = "annual",
           metadataPath = "",
           metadataLink = "https://www.regionalstatistik.de/genesis/online?operation=statistic&levelindex=0&levelid=1722440782412&code=41312",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_census,
           begin = 2010,
           end = 2010,
           archive = "41141-03-02-4_2010.csv",
           archiveLink = "https://www.regionalstatistik.de/genesis//online?operation=table&code=41141-03-02-4",
           downloadDate = ymd("2024-07-30"),
           updateFrequency = "annual",
           metadataPath = "",
           metadataLink = "https://www.regionalstatistik.de/genesis/online?operation=statistic&levelindex=0&levelid=1722440782412&code=41312",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_census,
           begin = 2016,
           end = 2016,
           archive = "41141-03-02-4_2016.csv",
           archiveLink = "https://www.regionalstatistik.de/genesis//online?operation=table&code=41141-03-02-4",
           downloadDate = ymd("2024-07-30"),
           updateFrequency = "annual",
           metadataPath = "",
           metadataLink = "https://www.regionalstatistik.de/genesis/online?operation=statistic&levelindex=0&levelid=1722440782412&code=41312",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_census,
           begin = 2020,
           end = 2020,
           archive = "41141-03-02-4_2020.csv",
           archiveLink = "https://www.regionalstatistik.de/genesis//online?operation=table&code=41141-03-02-4",
           downloadDate = ymd("2024-07-30"),
           updateFrequency = "annual",
           metadataPath = "",
           metadataLink = "https://www.regionalstatistik.de/genesis/online?operation=statistic&levelindex=0&levelid=1722440782412&code=41312",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "cattle",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_survey,
           begin = 2009,
           end = 2023,
           archive = "41312-01-01-4.csv",
           archiveLink = "https://www.regionalstatistik.de/genesis//online?operation=table&code=41312-01-01-4",
           downloadDate = ymd("2024-07-30"),
           updateFrequency = "annual",
           metadataPath = "",
           metadataLink = "https://www.regionalstatistik.de/genesis/online?operation=statistic&levelindex=0&levelid=1722440782412&code=41312",
           overwrite = TRUE)

  normTable(pattern = ds[1],
            ontoMatch = "animal",
            beep = 10)
}

if(build_landuse){
  ## landuse ----

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
