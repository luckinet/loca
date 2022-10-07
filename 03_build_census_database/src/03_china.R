# springWheat, winterWeath, redBeans, barley - no 1000 hectares in the tables?
# winterWheat_output - has only 71 columns - think how to incorporate it better in the script
# sugarcane_output - has only 71 columns -
# springWheat_output - has only 71 columns
# soya_output - has only 71 columns
# red bean_output - has 71 columns
# rame_output - has 71 columns
# potato_output - has 71 columns
# otherCereals_output - has 71 columns
# mung_output - has 71 columns
# millet_output - has 71 columns
# jute_output - has 71 columns
# jowar_output - has 71 columns
# hemp_output - has 71 columns
# Helianthus_output - has 71 columns
# flax_output - has 71 columns
# fiberCrops_output - has 71 columns
# benne_output - has 71 columns
# barley_output - has 71 columns

# script arguments ----
#
thisNation <- "China"
assertSubset(x = thisNation, choices = countries$label) # ensure that nation is valid

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested


# register dataseries ----
#
ds <- c("nbs", "cnki", "gaohr")
gs <- c("nbs", "gaohr")

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

# register geometries ----
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


# register census tables ----
#
# NBS ----
nbs_data <- list.files(path = paste0(DBDir, "/adb_tables/stage1/"), pattern = "_china.csv")

schema_nbs <- setCluster(id = "al1", top = 4, left = 1, height = 32) %>%
  setFormat(decimal = ".") %>%
  setIDVar(name = "al1", value = "China") %>%
  setIDVar(name = "al2", columns = 1, relative = TRUE) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:73), relative = TRUE) %>%
  setIDVar(name = "commodities", rows = 2, columns = 1, split = "(?<=of).*")

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

schema_nbs_livestock <- schema_nbs %>%
  setIDVar(name = "year", rows = 1, columns = c(2:71), relative = TRUE) %>%
  setIDVar(name = "commodities", rows = 2, columns = 1, split = "(?<=of ).*(?= at)") %>%
  setObsVar(name = "headcount", unit = "n", factor = 10000, columns = c(2:71), relative = TRUE)

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


# CNKI ----

# normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(nation = thisNation,
#              pattern = gs[],
#              outType = "gpkg",
#              update = updateTables)

normGeometry(nation = thisNation,
             pattern = gs[],
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
# normTable(nation = thisNation,
#           pattern = "fao",
#           source = "datID",
#           outType = "rds",
#           update = updateTables)

normTable(nation = thisNation,
          pattern = "",
          source = "datID",
          outType = "rds",
          update = updateTables)


# harmonise commodities ----
#
for(i in seq_along(ds)){

  # tibble(new = get_variable(variable = "commodities", dataseries = ds[]),
  #        label_en = "") %>%
  #   write_csv(file = paste0(TTDir, "match_", ds[], "_lucki.csv"), append = TRUE) # fill rest by hand

  commodities <- read_csv(paste0(TTDir, "match_", ds[i], "_lucki.csv"), col_types = "cc") %>%
    filter(!is.na(harmonised))

  # in case new concepts are recorded, they have to be added to the ontology, before they can be used.
  # get_concept(label_en = commodities$harmonised,
  #             ontoDir = ontoDir, missing = TRUE) %>%
  #   pull(new) %>%
  #   set_concept(new = .,
  #               broader = c(""),       # specify here the already harmonised concepts into which the new concepts should be nested
  #               class = "commodity",
  #               source = paste0(thisNation, ".", ds[i]))

  get_concept(label_en = commodities$harmonised,
              ontoDir = ontoDir) %>%
    pull(label_en) %>%
    set_mapping(concept = .,
                external = commodities$new,
                match = "close",
                source = paste0(thisNation, ".", ds[i]),
                certainty = )

}

