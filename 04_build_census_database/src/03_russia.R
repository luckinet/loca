# script arguments ----
#
# source(paste0(mdl0301, "src/96_preprocess_rosstat.R"))
thisNation <- "Russia"

ds <- c("rosstat")
gs <- c("gadm36")


# 1. register dataseries ----
#
regDataseries(name = ds[1],
              description = "Russian National Statistics Agency",
              homepage = "www.fedstat.ru",
              licence_link = "not available",
              licence_path = "not available")


# 2. register geometries ----
#


# 3. register census tables ----
#

# crops ----
if(build_crops){

  ## rosstat ----
  rosstat_yield <- list.files(path = paste0(census_dir, "adb_tables/stage1/rosstat/"),
                              pattern = "*_yield.csv")

  for(i in seq_along(rosstat_yield)){

    thisFile <- rosstat_yield[i]
    name <- str_split(thisFile, "_")[[1]]
    munst <- name[3]
    al2Val <- name[2]

    schema_yield <- setCluster(id = "al3", left = 1, top = .find(pattern = "центнеров с гектара", col = 1)) %>%
      setFormat(decimal = ".") %>%
      setIDVar(name = "al2", value = al2Val) %>%
      setIDVar(name = "al3", columns = 1, rows = .find(row = 1, relative = TRUE)) %>%
      setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
      setIDVar(name = "method", value = "survey") %>%
      setIDVar(name = "crop", columns = 1) %>%
      setObsVar(name = "yield", unit = "kg/ha", factor = 100, columns = .find(fun = is.numeric, row = 2, relative = TRUE)) # russian centner to kilogram

    regTable(nation = !!thisNation,
             label = "al3",
             subset = paste0("yield", al2Val),
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
             overwrite = TRUE)

  }

  rosstat_planted <- list.files(path = paste0(census_dir, "/adb_tables/stage1/rosstat/"),
                                pattern = "*_planted.csv")

  for(i in seq_along(rosstat_planted)){

    thisFile <- rosstat_planted[i]
    name <- str_split(thisFile, "_")[[1]]
    munst <- name[3]
    al2Val <- name[2]

    schema_planted <- setCluster(id = "al3", left = 1, top = .find(pattern = "Посевные площади сельскохозяйственных культур", col = 1)) %>%
      setFilter(rows = .find(pattern = "Вся посевная площадь.", col = 1, invert = TRUE)) %>%
      setFormat(decimal = ".") %>%
      setIDVar(name = "al2", value = al2Val) %>%
      setIDVar(name = "al3", columns = 1, rows = .find(row = 1, relative = TRUE)) %>%
      setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
      setIDVar(name = "method", value = "survey") %>%
      setIDVar(name = "crop", columns = 1) %>%
      setObsVar(name = "planted", unit = "ha", columns = .find(fun = is.numeric, row = 2, relative = TRUE))

    regTable(nation = !!thisNation,
             label = "al3",
             subset = paste0("planted", al2Val),
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
             overwrite = TRUE)

  }

  rosstat_production <- list.files(path = paste0(census_dir, "/adb_tables/stage1/rosstat/"),
                                   pattern = "*_production.csv")

  for(i in seq_along(rosstat_production)){

    thisFile <- rosstat_production[i]
    name <- str_split(thisFile, "_")[[1]]
    munst <- name[3]
    al2Val <- name[2]

    schema_production <- setCluster(id = "al3", left = 1, top = .find(pattern = "Валовые сборы сельскохозяйственных культур", col = 1)) %>%
      setFormat(decimal = ".") %>%
      setIDVar(name = "al2", value = al2Val) %>%
      setIDVar(name = "al3", columns = 1, rows = .find(row = 1, relative = TRUE)) %>%
      setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
      setIDVar(name = "method", value = "survey") %>%
      setIDVar(name = "crop", columns = 1) %>%
      setObsVar(name = "production", unit = "t", factor = 0.1, columns = .find(fun = is.numeric, row = 2, relative = TRUE))

    regTable(nation = !!thisNation,
             label = "al3",
             subset = paste0("production", al2Val),
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
             overwrite = TRUE)

  }

  rosstat_perennial <- list.files(path = paste0(census_dir, "/adb_tables/stage1/rosstat/"),
                                  pattern = "*_perennial.csv")

  for(i in seq_along(rosstat_perennial)){

    thisFile <- rosstat_perennial[i]
    name <- str_split(thisFile, "_")[[1]]
    munst <- name[3]
    al2Val <- name[2]

    schema_perennial <- setCluster(id = "al3", left = 1, top = .find(pattern = "Площадь многолетних насаждений", col = 1)) %>%
      setFormat(decimal = ".") %>%
      setIDVar(name = "al2", value = al2Val) %>%
      setIDVar(name = "al3", columns = 1, rows = .find(row = 1, relative = TRUE)) %>%
      setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
      setIDVar(name = "method", value = "survey") %>%
      setIDVar(name = "crop", columns = 1) %>%
      setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 2, relative = TRUE))

    regTable(nation = !!thisNation,
             label = "al3",
             subset = paste0("perennial", al2Val),
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
             overwrite = TRUE)

  }
}


# livestock ----
if(build_livestock){

  ## rosstat ----
  rosstat_livestock <- list.files(path = paste0(census_dir, "/adb_tables/stage1/rosstat/"),
                                  pattern = "*_livestock.csv")

  for(i in seq_along(rosstat_livestock)){

    thisFile <- rosstat_livestock[i]
    name <- str_split(thisFile, "_")[[1]]
    munst <- name[3]
    al2Val <- name[2]

    schema_livestock <- setCluster(id = "al3", left = 1, top = .find(pattern = "Поголовье скота и птицы", col = 1)) %>%
      setFormat(decimal = ".") %>%
      setIDVar(name = "al2", value = al2Val) %>%
      setIDVar(name = "al3", columns = 1, rows = .find(row = 1, relative = TRUE)) %>%
      setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
      setIDVar(name = "method", value = "survey") %>%
      setIDVar(name = "animal", columns = 1) %>%
      setObsVar(name = "headcount", unit = "n", columns = .find(fun = is.numeric, row = 2, relative = TRUE))

    regTable(nation = !!thisNation,
             label = "al3",
             subset = paste0("livestock", al2Val),
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
             overwrite = TRUE)

  }

}


# landuse ----
if(build_landuse){

  ## rosstat ----
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "reforestation",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = ,
  #          begin = 2009,
  #          end = 2020,
  #          archive = "Площадь лесовосстановления - Reforestation.xls",
  #          archiveLink = "https://www.fedstat.ru/indicator/37852",
  #          updateFrequency = "annually",
  #          nextUpdate = "uknown",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          overwrite = TRUE)
  #
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "protected",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = ,
  #          begin = 2009,
  #          end = 2010,
  #          archive = "Площадь земель особо охраняемых территорий и объектов - Protected area.xls",
  #          archiveLink = "https://www.fedstat.ru/indicator/38146",
  #          updateFrequency = "annually",
  #          nextUpdate = "uknown",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          overwrite = TRUE)
  #
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "protected",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = ,
  #          begin = 1998,
  #          end = 2020,
  #          archive = "Лесные площади - Forest areas (by landcover-class).xls",
  #          archiveLink = "https://www.fedstat.ru/indicator/38135",
  #          updateFrequency = "annually",
  #          nextUpdate = "uknown",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          overwrite = TRUE)
  #
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "protected",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = ,
  #          begin = 2009,
  #          end = 2020,
  #          archive = "Площадь лесных земель - Forest land area.xls",
  #          archiveLink = "https://www.fedstat.ru/indicator/38194",
  #          updateFrequency = "annually",
  #          nextUpdate = "uknown",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          overwrite = TRUE)

}

#### test schemas

myRoot <- paste0(census_dir, "/adb_tables/stage2/")
myFile <- "Russia_al3_perennialAdygea_2008_2020_rosstat.csv"
schema <- schema_perennial

input <- read_csv(file = paste0(myRoot, myFile),
                  col_names = FALSE,
                  col_types = cols(.default = "c"))

validateSchema(schema = schema, input = input)

output <- reorganise(input = input, schema = schema)

#### delete this section after finalising script


# 4. normalise geometries ----
#
# not needed


# 5. normalise census tables ----
#
normTable(pattern = paste0("livestock.*", ds[1]),
          ontoMatch = "animal",
          beep = 10)

normTable(pattern = ds[1],
          ontoMatch = "crop",
          beep = 10)


