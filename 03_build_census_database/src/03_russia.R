# script arguments ----
#
thisNation <- "Russia"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("rosstat")
gs <- c("gadm36")


# load metadata ----
#
# source(paste0(mdl0301, "src/_03_rosstat_preprocess.R"))


# register dataseries ----
#
regDataseries(name = ds[1],
              description = "Russian National Statistics Agency",
              homepage = "www.fedstat.ru",
              licence_link = "not available",
              licence_path = "not available",
              update = updateTables)


# register geometries ----
#


# register census tables ----
#

# crops ----
if(build_crops){

  ## rosstat ----
  rosstat_yield <- list.files(path = paste0(censusDBDir, "adb_tables/stage1/rosstat/"),
                              pattern = "*_Crop yield per harvested area.csv")

  schema_yield <- setCluster(id = "al3", left = 1, top = .find(pattern = "центнер с гектара убранной площади", col = 1)) %>%
    setFormat(decimal = ".") %>%
    setIDVar(name = "al3", columns = 1, rows = .find(row = 1, relative = TRUE)) %>%
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
    setIDVar(name = "commodities", columns = 1) %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = .find(fun = is.numeric, row = 2, relative = TRUE)) # russian centner to kilogram

  for(i in seq_along(rosstat_yield)){

    thisFile <- rosstat_yield[i]
    munst <- str_split(thisFile, "_")[[1]][2]
    # write_clip(paste0("Russia_al3_yield", munst, "_2008_2020_rosstat"))

    regTable(nation = !!thisNation,
             label = "al3",
             subset = paste0("yield", munst),
             dSeries = ds[1],
             gSeries = gs[1],
             schema = schema_yield,
             begin = 2008,
             end = 2020,
             archive = thisFile,
             archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
             updateFrequency = "annually",
             nextUpdate = "uknown",
             metadataLink = "unknown",
             metadataPath = "unknown",
             update = updateTables,
             overwrite = overwriteTables)

  }

  rosstat_planted <- list.files(path = paste0(censusDBDir, "/adb_tables/stage1/rosstat/"),
                                pattern = "*_Sown area of agricultural crops in farms of all categories.csv")

  schema_planted <- setCluster(id = "al3", left = 1, top = .find(pattern = "Посевные площади сельскохозяйственных культур", col = 1)) %>%
    setFilter(rows = .find(pattern = "Вся посевная площадь.", col = 1, invert = TRUE)) %>%
    setFormat(decimal = ".") %>%
    setIDVar(name = "al3", columns = 1, rows = .find(row = 1, relative = TRUE)) %>%
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
    setIDVar(name = "commodities", columns = 1) %>%
    setObsVar(name = "planted", unit = "ha", columns = .find(fun = is.numeric, row = 3))

  for(i in seq_along(rosstat_planted)){

    thisFile <- rosstat_planted[i]
    munst <- str_split(thisFile, "_")[[1]][2]
    # write_clip(paste0("rus_3_planted", munst, "_2008_2020_rosstat"))

    regTable(nation = !!thisNation,
             label = "al3",
             subset = paste0("planted", munst),
             dSeries = ds[1],
             gSeries = gs[1],
             schema = schema_planted,
             begin = 2008,
             end = 2020,
             archive = thisFile,
             archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
             updateFrequency = "annually",
             nextUpdate = "uknown",
             metadataLink = "unknown",
             metadataPath = "unknown",
             update = updateTables,
             overwrite = overwriteTables)

  }

  rosstat_production <- list.files(path = paste0(censusDBDir, "/adb_tables/stage1/rosstat/"),
                                   pattern = "*_Gross harvest of agricultural crops in farms of all categories.csv")

  schema_production <- setCluster(id = "al3", left = 1, top = .find(pattern = "Валовые сборы сельскохозяйственных культур", col = 1)) %>%
    setFormat(decimal = ".") %>%
    setIDVar(name = "al3", columns = 1, rows = .find(row = 1, relative = TRUE)) %>%
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
    setIDVar(name = "commodities", columns = 1) %>%
    setObsVar(name = "production", unit = "t", factor = 0.1, columns = .find(fun = is.numeric, row = 3))

  for(i in seq_along(rosstat_production)){

    thisFile <- rosstat_production[i]
    munst <- str_split(thisFile, "_")[[1]][2]
    # write_clip(paste0("rus_3_production", munst, "_2008_2020_rosstat"))

    regTable(nation = !!thisNation,
             label = "al3",
             subset = paste0("production", munst),
             dSeries = ds[1],
             gSeries = gs[1],
             schema = schema_production,
             begin = 2008,
             end = 2020,
             archive = thisFile,
             archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
             updateFrequency = "annually",
             nextUpdate = "uknown",
             metadataLink = "unknown",
             metadataPath = "unknown",
             update = updateTables,
             overwrite = overwriteTables)

  }

  rosstat_perennial <- list.files(path = paste0(censusDBDir, "/adb_tables/stage1/rosstat/"),
                                  pattern = "*_The area of perennial plantations in farms of all categories.csv")

  schema_perennial <- setCluster(id = "al3", left = 1, top = .find(pattern = "Площадь многолетних насаждений", col = 1)) %>%
    setFormat(decimal = ".") %>%
    setIDVar(name = "al3", columns = 1, rows = .find(row = 1, relative = TRUE)) %>%
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
    setIDVar(name = "commodities", columns = 1) %>%
    setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 3))

  for(i in seq_along(rosstat_perennial)){

    thisFile <- rosstat_perennial[i]
    munst <- str_split(thisFile, "_")[[1]][2]
    # write_clip(paste0("rus_3_perennial", munst, "_2008_2020_rosstat"))

    regTable(nation = !!thisNation,
             label = "al3",
             subset = paste0("perennial", munst),
             dSeries = ds[1],
             gSeries = gs[1],
             schema = schema_perennial,
             begin = 2008,
             end = 2020,
             archive = thisFile,
             archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
             updateFrequency = "annually",
             nextUpdate = "uknown",
             metadataLink = "unknown",
             metadataPath = "unknown",
             update = updateTables,
             overwrite = overwriteTables)

  }
}


# livestock ----
if(build_livestock){

  ## rosstat ----
  rosstat_livestock <- list.files(path = paste0(censusDBDir, "/adb_tables/stage1/rosstat/"),
                                  pattern = "*_Livestock and poultry population at the end of the year.csv")

  schema_livestock <- setCluster(id = "al3", left = 1, top = .find(pattern = "Поголовье скота и птицы", col = 1)) %>%
    setFormat(decimal = ".") %>%
    setIDVar(name = "al3", columns = 1, rows = .find(row = 1, relative = TRUE)) %>%
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
    setIDVar(name = "commodities", columns = 1) %>%
    setObsVar(name = "headcount", unit = "n", columns = .find(fun = is.numeric, row = 2, relative = TRUE))

  for(i in seq_along(rosstat_livestock)){

    thisFile <- rosstat_livestock[i]
    munst <- str_split(thisFile, "_")[[1]][2]
    # write_clip(paste0("rus_3_livestock", munst, "_2008_2020_rosstat"))

    regTable(nation = !!thisNation,
             label = "al3",
             subset = paste0("livestock", munst),
             dSeries = ds[1],
             gSeries = gs[1],
             schema = schema_livestock,
             begin = 2008,
             end = 2020,
             archive = thisFile,
             archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
             updateFrequency = "annually",
             nextUpdate = "uknown",
             metadataLink = "unknown",
             metadataPath = "unknown",
             update = updateTables,
             overwrite = overwriteTables)

  }

}


# landuse ----
if(build_landuse){

  ## rosstat ----
  regTable(nation = !!thisNation,
           label = "al2",
           subset = "reforestation",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = ,
           begin = 2009,
           end = 2020,
           archive = "Площадь лесовосстановления - Reforestation.xls",
           archiveLink = "https://www.fedstat.ru/indicator/37852",
           updateFrequency = "annually",
           nextUpdate = "uknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "protected",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = ,
           begin = 2009,
           end = 2010,
           archive = "Площадь земель особо охраняемых территорий и объектов - Protected area.xls",
           archiveLink = "https://www.fedstat.ru/indicator/38146",
           updateFrequency = "annually",
           nextUpdate = "uknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "protected",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = ,
           begin = 1998,
           end = 2020,
           archive = "Лесные площади - Forest areas (by landcover-class).xls",
           archiveLink = "https://www.fedstat.ru/indicator/38135",
           updateFrequency = "annually",
           nextUpdate = "uknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "protected",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = ,
           begin = 2009,
           end = 2020,
           archive = "Площадь лесных земель - Forest land area.xls",
           archiveLink = "https://www.fedstat.ru/indicator/38194",
           updateFrequency = "annually",
           nextUpdate = "uknown",
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


# normalise geometries ----
#
# not needed


# normalise census tables ----
#
normTable(pattern = ds[1],
          ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)

