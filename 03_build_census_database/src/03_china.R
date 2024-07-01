# ----
# title       : build census database - nbs, cnki, goahr
# description : this script integrates data of ' National Bureau of Statistics of China' (http://www.data.stats.gov.cn/english/), 'Data for Agriculture, Forest, Livestock and Fishery' (https://www.cnki.net/), 'National Geomatics Center of China' (http://gaohr.win/site/blogs/2017/2017-04-18-GIS-basic-data-of-China.html)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-MM-DD
# version     : 0.0.0
# status      : find data, update, inventarize, validate, normalize, done
# comment     : file.edit(paste0(dir_docs, "/documentation/03_build_census_database.md"))
# ----
# geography   : China
# spatial     : _INSERT
# period      : 1949 - 2020
# variables   :
# - land      : hectares_covered
# - crops     : hectares_harvested, tons_produced, kiloPerHectare_yield
# - livestock : number_heads
# - tech      : number_machines, tons_applied (fertilizer)
# - social    : _INSERT
# sampling    : survey, census
# ----

thisNation <- "China"

# 1. dataseries ----
#
ds <- c("nbs", "cnki", "gaohr")
gs <- c("nbs", "gaohr")

regDataseries(name = ds[1],
              description = "National Bureau of Statistics of China",
              homepage = "http://www.data.stats.gov.cn/english/",
              version = "2022.10",
              licence_link = "unknown")

# regDataseries(name = ds[1],
#               description = "National Bureau of Statistics of China",
#               homepage = "http://www.data.stats.gov.cn/english/",
#               licence_link = "http://www.stats.gov.cn/enGliSH/nbs/200701/t20070104_59236.html",
#               licence_path = "unknown")
#
# regDataseries(name = ds[2],
#               description = "Data for Agriculture, Forest, Livestock and Fishery",
#               homepage = "https://www.cnki.net/",
#               licence_link = "unknown",
#               licence_path = "unknown")
#
# regDataseries(name = ds[3],
#               description = "National Geomatics Center of China",
#               homepage = "http://gaohr.win/site/blogs/2017/2017-04-18-GIS-basic-data-of-China.html",
#               licence_link = "unknown",
#               licence_path = "unknown")


# 2. geometries ----
#
# regGeometry(nation = "China",
#             gSeries = gs[2],
#             level = 1,
#             nameCol = "",
#             archive = "|",
#             archiveLink = "http://gaohr.win/site/blogs/2017/2017-04-18-GIS-basic-data-of-China.html",
#             updateFrequency = "unknown")
#
# regGeometry(nation = "China",
#             gSeries = gs[2],
#             level = 2,
#             nameCol = "",
#             archive = "|",
#             archiveLink = "http://gaohr.win/site/blogs/2017/2017-04-18-GIS-basic-data-of-China.html",
#             updateFrequency = "unknown")
#
# regGeometry(nation = "China",
#             gSeries = gs[2],
#             level = 3,
#             nameCol = "",
#             archive = "|",
#             archiveLink = "http://gaohr.win/site/blogs/2017/2017-04-18-GIS-basic-data-of-China.html",
#             updateFrequency = "unknown")

normGeometry(pattern = gs[],
             beep = 10)


# 3. tables ----
#
nbs_data <- list.files(path = paste0(censusDBDir, "/adb_tables/stage1/"), pattern = "_china.csv")

schema_nbs <- setCluster(id = "al1", top = 4, left = 1, height = 32) %>%
  setFormat(decimal = ".") %>%
  setIDVar(name = "al1", value = "China") %>%
  setIDVar(name = "al2", columns = 1, relative = TRUE) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:73), relative = TRUE) %>%
  setIDVar(name = "commodities", rows = 2, columns = 1, split = "(?<=of).*")

if(build_crops){
  ## crops ----

  ### nbs ----
  # schema_nbs_harvested <- schema_nbs %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = c(2:73))
  #
  # schema_nbs_planted <- schema_nbs %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 1000, columns = c(2:73), relative = TRUE)
  #
  # schema_nbs_production <- schema_nbs %>%
  #   setIDVar(name = "commodities", rows = 2, columns = 1, split = "(?<=of ).*(?=\\()") %>%
  #   setObsVar(name = "production", unit = "t", factor = 10000, columns = c(2:73))
  #
  # schema_nbs_production_02 <- schema_nbs %>%
  #   setIDVar(name = "year", rows = 1, columns = c(2:71), relative = TRUE) %>%
  #   setIDVar(name = "commodities", rows = 2, columns = 1, split = "(?<=of ).*(?=\\()") %>%
  #   setObsVar(name = "production", unit = "t", factor = 10000, columns = c(2:71))

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


  ### nbs ----
  schema_nbs_livestock <- schema_nbs %>%
    setIDVar(name = "year", rows = 1, columns = c(2:71), relative = TRUE) %>%
    setIDVar(name = "commodities", rows = 2, columns = 1, split = "(?<=of ).*(?= at)") %>%
    setObsVar(name = "headcount", unit = "n", factor = 10000, columns = c(2:71), relative = TRUE)


  schema_livestock <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "") %>%
    setIDVar(name = "animal", )  %>%
    setObsVar(name = "number_heads", )

  regTable(nation = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_livestock,
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


for(i in seq_along(nbs_data)){

  thisFile <- nbs_data[i]
  message("  --> working with '", thisFile, "'")
  temp <- str_split(thisFile, "_")[[1]]

  if(temp[2] == "area"){
    schema <- schema_nbs_harvested
  } else if(temp[2] == "planted"){
    schema <- schema_nbs_planted
  } else if(temp[2] == "output" & temp[1] != "barley" & temp[1] != "benne" &
            temp[1] != "fibreCrops" & temp[1] != "flax" & temp[1] != "helianthus" &
            temp[1] != "hemp" & temp[1] != "jowar" & temp[1] != "juteAmbaryHemp" &
            temp[1] != "millet" & temp[1] != "mung" & temp[1] != "otherCereals" &
            temp[1] != "potato" & temp[1] != "ramee" & temp[1] != "redDates" &
            temp[1] != "soja" & temp[1] != "springWheat" & temp[1] != "sugarcane" &
            temp[1] != "winterWheat"){
    schema <- schema_nbs_production
  }

  regTable(nation = "chn",
           level = 2,
           subset = paste0(temp[1], toupper(temp[2])),
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema,
           begin = 1949,
           end = 2020,
           archive = thisFile,
           archiveLink = "http://www.stats.gov.cn/enGliSH/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  if(temp[2] == "headcount"){
    schema <- schema_nbs_livestock
  } else if(temp[2] == "output" & temp[1] == "barley" & temp[1] == "benne" &
            temp[1] == "fibreCrops" & temp[1] == "flax" & temp[1] == "helianthus" &
            temp[1] == "hemp" & temp[1] == "jowar" & temp[1] == "juteAmbaryHemp" &
            temp[1] == "millet" & temp[1] == "mung" & temp[1] == "otherCereals" &
            temp[1] == "potato" & temp[1] == "ramee" & temp[1] == "redDates" &
            temp[1] == "soja" & temp[1] == "springWheat" & temp[1] == "sugarcane" &
            temp[1] == "winterWheat"){
    schema <- schema_nbs_production_02
  }

  regTable(nation = "chn",
           level = 2,
           subset = paste0(temp[1], toupper(temp[2])),
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema,
           begin = 1950,
           end = 2019,
           archive = thisFile,
           archiveLink = "http://www.stats.gov.cn/enGliSH/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

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
