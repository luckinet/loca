# script arguments ----
#
thisNation <- "China"

updateTables <- FALSE
overwriteTables <- FALSE

ds <- c("nbs", "cnki", "gaohr")
gs <- c("nbs", "gaohr")


# 1. register dataseries ----
#
regDataseries(name = ds[1],
              description = "National Bureau of Statistics of China",
              homepage = "http://www.data.stats.gov.cn/english/",
              licence_link = "http://www.stats.gov.cn/enGliSH/nbs/200701/t20070104_59236.html",
              licence_path = "unknown",
              update = updateTables)

regDataseries(name = ds[2],
              description = "Data for Agriculture, Forest, Livestock and Fishery",
              homepage = "https://www.cnki.net/",
              licence_link = "unknown",
              licence_path = "unknown",
              update = updateTables)

regDataseries(name = ds[3],
              description = "National Geomatics Center of China",
              homepage = "http://gaohr.win/site/blogs/2017/2017-04-18-GIS-basic-data-of-China.html",
              licence_link = "unknown",
              licence_path = "unknown",
              update = updateTables)


# 2. register geometries ----
#
# regGeometry(nation = "China",
#             gSeries = gs[2],
#             level = 1,
#             nameCol = "",
#             archive = "|",
#             archiveLink = "http://gaohr.win/site/blogs/2017/2017-04-18-GIS-basic-data-of-China.html",
#             updateFrequency = "unknown",
#             update = updateTables)
#
# regGeometry(nation = "China",
#             gSeries = gs[2],
#             level = 2,
#             nameCol = "",
#             archive = "|",
#             archiveLink = "http://gaohr.win/site/blogs/2017/2017-04-18-GIS-basic-data-of-China.html",
#             updateFrequency = "unknown",
#             update = updateTables)
#
# regGeometry(nation = "China",
#             gSeries = gs[2],
#             level = 3,
#             nameCol = "",
#             archive = "|",
#             archiveLink = "http://gaohr.win/site/blogs/2017/2017-04-18-GIS-basic-data-of-China.html",
#             updateFrequency = "unknown",
#             update = updateTables)


# 3. register census tables ----
#
nbs_data <- list.files(path = paste0(censusDBDir, "/adb_tables/stage1/"), pattern = "_china.csv")

schema_nbs <- setCluster(id = "al1", top = 4, left = 1, height = 32) %>%
  setFormat(decimal = ".") %>%
  setIDVar(name = "al1", value = "China") %>%
  setIDVar(name = "al2", columns = 1, relative = TRUE) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:73), relative = TRUE) %>%
  setIDVar(name = "commodities", rows = 2, columns = 1, split = "(?<=of).*")

## crops ----
if(build_crops){

  ### nbs ----
  schema_nbs_harvested <- schema_nbs %>%
    setObsVar(name = "harvested", unit = "ha", columns = c(2:73))

  schema_nbs_planted <- schema_nbs %>%
    setObsVar(name = "planted", unit = "ha", factor = 1000, columns = c(2:73), relative = TRUE)

  schema_nbs_production <- schema_nbs %>%
    setIDVar(name = "commodities", rows = 2, columns = 1, split = "(?<=of ).*(?=\\()") %>%
    setObsVar(name = "production", unit = "t", factor = 10000, columns = c(2:73))

  schema_nbs_production_02 <- schema_nbs %>%
    setIDVar(name = "year", rows = 1, columns = c(2:71), relative = TRUE) %>%
    setIDVar(name = "commodities", rows = 2, columns = 1, split = "(?<=of ).*(?=\\()") %>%
    setObsVar(name = "production", unit = "t", factor = 10000, columns = c(2:71))

}

## livestock ----
if(build_livestock){

  ### nbs ----

}

## landuse ----
if(build_landuse){

  ### nbs ----
  schema_nbs_livestock <- schema_nbs %>%
    setIDVar(name = "year", rows = 1, columns = c(2:71), relative = TRUE) %>%
    setIDVar(name = "commodities", rows = 2, columns = 1, split = "(?<=of ).*(?= at)") %>%
    setObsVar(name = "headcount", unit = "n", factor = 10000, columns = c(2:71), relative = TRUE)

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
           update = updateTables,
           overwrite = overwriteTables)

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
           update = updateTables,
           overwrite = overwriteTables)

}


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


# 4. normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg",
#              update = updateTables)

normGeometry(pattern = gs[],
             outType = "gpkg",
             update = updateTables)


# 5. normalise census tables ----
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
