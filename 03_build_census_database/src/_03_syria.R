# script arguments ----
#
thisNation <- "Syria"

updateTables <- FALSE
overwriteTables <- FALSE

ds <- c("cbs")
gs <- c("gadm36")


# load metadata ----
#
# source(paste0(modlDir, "src/03_cbssyr_preprocess.R"))


# register dataseries ----
#
regDataseries(name = ds[1],
              description = "Central Bureau of Statistics",
              homepage = "http://cbssyr.sy/index-EN.htm",
              notes = "data are public domain",
              licence_link = "unknown",
              licence_path = "unknown",
              update = updateTables)


# register geometries ----
#


# register census tables ----
#
# syrian data are split up into 7 distinct PDFs according to the included
# variables. In each PDF of one group, the tables are typically organised the
# same, so I hope that one schema for each group is sufficient

cbs_animals <- list.files(path = paste0(DBDir, "/adb_tables/stage2/"), pattern = "syr_2_animal")
cbs_crops <- list.files(path = paste0(DBDir, "/adb_tables/stage2/"), pattern = "syr_2_crops")
cbs_fruit <- list.files(path = paste0(DBDir, "adb_tables/stage2/"), pattern = "syr_2_orch")
# cbs_machines <- list.files(path = paste0(DBDir, "/adb_tables/stage2/"), pattern = "")
# cbs_tenure <- list.files(path = paste0(DBDir, "/adb_tables/stage2/"), pattern = "")
cbs_landuse <- list.files(path = paste0(DBDir, "/adb_tables/stage2/"), pattern = "syr_2_landuse")


# Agricultural animals ----
#
schema_ungulates <-
  setCluster(id = "type", left = 1, top = .find("Total")) %>%
  setFilter(rows = .find(by = is.numeric, col = 1), invert = TRUE) %>%
  setIDVar(name = "al1", value = "syria") %>%
  setIDVar(name = "al2", columns = 1)

schema_cattle <- schema_ungulates %>%
  setObsVar(name = "headcount", unit = "n", columns = 8)

schema_sheep <- schema_ungulates %>%
  setObsVar(name = "headcount", unit = "n", columns = 12)

schema_goats <- schema_ungulates %>%
  setObsVar(name = "headcount", unit = "n", columns = 11)

schema_buffalo <- schema_ungulates %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

schema_other <- schema_ungulates %>%
  setIDVar(name = "commodities", columns = c(2:6), rows = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:6))

schema_poultry <-
  setCluster(id = "type", left = 1, top = .find("Chicken")) %>%
  setFilter(rows = .find(by = is.numeric, col = 1), invert = TRUE) %>%
  setIDVar(name = "al1", value = "syria") %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(2:11), rows = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:11))

schema_bees <-
  setCluster(id = "type", left = 6, top = .find("Bee Hives")) %>%
  setFilter(rows = .find(by = is.numeric, col = 1), invert = TRUE) %>%
  setIDVar(name = "al1", value = "syria") %>%
  setIDVar(name = "al2", columns = 1) %>%
  setObsVar(name = "hives", unit = "n", columns = .find("Total"))


for(i in seq_along(cbs_animals)){

  thisFile <- cbs_animals[i]
  temp <- str_split(thisFile, "_")[[1]]

  if(temp[5] %in% c(2006:2009)){
    thisArchive <- paste0(temp[5], "_Agricultural animals.xls")
  } else if(temp[5] %in% c(2014)) {
    thisArchive <- "2014_Agristatistics.pdf"
  } else {
    thisArchive <- paste0(temp[5], "_Agricultural animals.pdf")
  }

  if(temp[4] == "animalCATTLE"){

    thisSchema <- schema_cattle %>%
      setIDVar(name = "commodities", value = "cattle") %>%
      setIDVar(name = "year", value = temp[4])

  } else if(temp[4] == "animalSHEEP"){

    thisSchema <- schema_sheep %>%
      setIDVar(name = "commodities", value = "sheep") %>%
      setIDVar(name = "year", value = temp[4])

  } else if(temp[4] == "animalGOATS"){

    thisSchema <- schema_goats %>%
      setIDVar(name = "commodities", value = "goats") %>%
      setIDVar(name = "year", value = temp[4])

  } else if(temp[4] == "animalBUFFALO"){

    thisSchema <- schema_buffalo %>%
      setIDVar(name = "commodities", value = "buffalo") %>%
      setIDVar(name = "year", value = temp[4])

  } else if(temp[4] == "animalOTHER"){

    thisSchema <- schema_other %>%
      setIDVar(name = "year", value = temp[4])

  } else if(temp[4] == "animalPOULTRY"){

    thisSchema <- schema_poultry %>%
      setIDVar(name = "year", value = temp[4])

  } else if(temp[4] == "animalBEE"){

    thisSchema <- schema_bees %>%
      setIDVar(name = "commodities", value = "bee") %>%
      setIDVar(name = "year", value = temp[4])

  }

  regTable(nation = "syr",
           level = 2,
           subset = thisSub,
           dSeries = ds[1],
           gSeries = gs[1],
           schema = thisSchema,
           begin = as.numeric(temp[4]),
           end = as.numeric(temp[4]),
           archive = thisArchive,
           archiveLink = "unknown",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

# Crops and vegetables ----
#
schema_crops <-
  setCluster(id = "irrigation", left = c(2, 5, 8), top = .find()) %>%
  setFilter(rows = .find(by = is.numeric, col = 1), invert = TRUE) %>%
  setIDVar(name = "irrigation", value = c("total", "non-irrigated", "irrigated")) %>%
  setIDVar(name = "al1", value = "syria") %>%
  setIDVar(name = "al2", columns = 1) %>%
  setObsVar(name = "yield", unit = "t/ha", factor = 1000, columns = 1, relative = TRUE) %>%
  setObsVar(name = "production", unit = "t", columns = 2, relative = TRUE) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 3, relative = TRUE)

for(i in seq_along(cbs_crops)){

  adapt from here on out the fields of temp
  thisFile <- cbs_crops[i]
  temp <- str_split(thisFile, "_")[[1]]
  thisYear <- as.numeric(temp[5])
  thisSub <- paste0(temp[3], temp[4])

  thisSchema <- schema_crops %>%
    setIDVar(name = "commodities", value = temp[4]) %>%
    setIDVar(name = "year", value = thisYear)

  regTable(nation = "syr",
           level = 2,
           subset = thisSub,
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_orch,
           begin = thisYear,
           end = thisYear,
           archive = paste0(thisYear, "_Crops and vegetables.pdf"),
           archiveLink = "unknown",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

# Fruit trees and forests ----
#
schema_orch <-
  setCluster(id = "irrigation", left = c(2, 6, 10), top = .find()) %>%
  setFilter(rows = .find(by = is.numeric, col = 1), invert = TRUE) %>%
  setIDVar(name = "irrigation", value = c("total", "non-irrigated", "irrigated")) %>%
  setIDVar(name = "al1", value = "syria") %>%
  setIDVar(name = "al2", columns = 1) %>%
  setObsVar(name = "production", unit = "t", columns = 1, relative = TRUE) %>%
  setObsVar(name = "trees_with_fruits", unit = "n", columns = 2, relative = TRUE) %>%
  setObsVar(name = "trees_total", unit = "n", columns = 3, relative = TRUE) %>%
  setObsVar(name = "planted", unit = "ha", columns = 4, relative = TRUE)

for(i in seq_along(cbs_fruit)){

  thisFile <- cbs_fruit[i]
  temp <- str_split(thisFile, "_")[[1]]
  thisYear <- as.numeric(temp[5])
  thisSub <- paste0(temp[3], temp[4])

  thisSchema <- schema_orch %>%
    setIDVar(name = "commodities", value = temp[4]) %>%
    setIDVar(name = "year", value = thisYear)

  regTable(nation = "syr",
           level = 2,
           subset = thisSub,
           dSeries = ds[1],
           gSeries = gs[1],
           schema = thisSchema,
           begin = thisYear,
           end = thisYear,
           archive = paste0(thisYear, "_Fruit trees and forests.pdf"),
           archiveLink = "unknown",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}


# Rain and land use ----
for(i in seq_along(cbs_landuse)){

  thisFile <- cbs_landuse[i]
  temp <- str_split(thisFile, "_")[[1]]
  thisYear <- as.numeric(temp[5])
  thisSub <- paste0(temp[3], temp[4])

  regTable(nation = "syr",
           level = 2,
           subset = thisSub,
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_orch,
           begin = thisYear,
           end = thisYear,
           archive = thisFile,
           archiveLink = "unknown",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

# Machines ----
for(i in seq_along(cbs_machines)){

  thisFile <- cbs_machines[i]
  temp <- str_split(thisFile, "_")[[1]]
  thisYear <- as.numeric(temp[5])
  thisSub <- paste0(temp[3], temp[4])

  regTable(nation = "syr",
           level = 2,
           subset = thisSub,
           dSeries = ds[1],
           gSeries = "gadm",
           schema = ,
           begin = thisYear,
           end = thisYear,
           archive = thisFile,
           archiveLink = "unknown",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

# Production tenure ----
for(i in seq_along(cbs_tenure)){

  thisFile <- cbs_tenure[i]
  temp <- str_split(thisFile, "_")[[1]]
  thisYear <- as.numeric(temp[5])
  thisSub <- paste0(temp[3], temp[4])

  regTable(nation = "syr",
           level = 2,
           subset = thisSub,
           dSeries = ds[1],
           gSeries = gs[1],
           schema = ,
           begin = thisYear,
           end = thisYear,
           archive = thisFile,
           archiveLink = "unknown",
           updateFrequency = "annually",
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
#
# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script


# normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg",
#              update = updateTables)

normGeometry(pattern = gs[],
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
# normTable(pattern = "fao",
#           outType = "rds",
#           update = updateTables)

normTable(pattern = ds[],
          ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)

