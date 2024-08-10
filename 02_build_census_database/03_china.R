# ----
# title       : build census database - nbs, cnki, goahr
# description : this script integrates data of ' National Bureau of Statistics of China' (http://www.data.stats.gov.cn/english/), 'Data for Agriculture, Forest, Livestock and Fishery' (https://www.cnki.net/), 'National Geomatics Center of China' (http://gaohr.win/site/blogs/2017/2017-04-18-GIS-basic-data-of-China.html)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-07-17
# version     : 0.6.0
# status      :update, inventarize, validate, normalize, done
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
# - social    : -
# sampling    : survey, census
# ----

thisNation <- "China"
# source(paste0(mdl0301, "src/96_preprocess_cnki.R"))

# 1. dataseries ----
#
ds <- c("nbs", "cnki")
gs <- c("gadm", "gaohr")

regDataseries(name = ds[1],
              description = "National Bureau of Statistics of China",
              homepage = "https://www.data.stats.gov.cn/english/",
              version = "2024.07",
              licence_link = "https://www.stats.gov.cn/english/nbs/200701/t20070104_59236.html")

regDataseries(name = ds[2],
              description = "Data for Agriculture, Forest, Livestock and Fishery",
              homepage = "https://www.cnki.net/",
              version = "2024.07",
              licence_link = "unknown")

regDataseries(name = gs[2],
              description = "National Geomatics Center of China",
              homepage = "http://gaohr.win/site/blogs/2017/2017-04-18-GIS-basic-data-of-China.html",
              version = "2024.07",
              licence_link = "unknown")


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
nbs_data <- list.files(path = paste0(dir_census_wip, "/tables/stage1/nbs"))

schema_nbs <- setCluster(id = "animal", left = 1, top = 4) %>%
  setFormat(decimal = ".") |>
  setIDVar(name = "al1", value = "China") |>
  setIDVar(name = "al2", rows = 4, columns = .find(fun = is.na, row = 3)) |>
  setIDVar(name = "year", columns = 1) |>
  setIDVar(name = "method", value = "survey")

if(build_crops){
  ## crops ----

  ### nbs ----
  https://data.stats.gov.cn/english/easyquery.htm?cn=E0103
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


  }

}

if(build_livestock){
  ## livestock ----

  ### nbs ----
  nbs_livestock <- nbs_data[str_which(string = nbs_data, pattern = c("headcount"))]

  for(i in seq_along(nbs_livestock)){

    temp <- str_split(nbs_livestock[i], "_")[[1]]
    temp[2] <- str_split(temp[2], "[.]")[[1]][1]

    schema_nbs_livestock <- schema_nbs |>
      setIDVar(name = "animal", value = temp[2]) |>
      setObsVar(name = "number_heads", factor = 10000, columns = .find(fun = is.na, row = 3))

    regTable(al1 = !!thisNation,
             label = "al2",
             subset = paste0(temp[2], .toCap(temp[1])),
             dSeries = ds[1],
             gSeries = gs[1],
             schema = schema_nbs_livestock,
             begin = 1978,
             end = 2020,
             archive = nbs_livestock[i],
             archiveLink = "https://www.stats.gov.cn/english/",
             downloadDate = ymd("2024-07-17"),
             updateFrequency = "annually",
             metadataLink = "unavailable",
             metadataPath = "unavailable",
             overwrite = TRUE)

  }

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



