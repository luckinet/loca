# script arguments ----
#
thisNation <- "Russia"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- FALSE
overwriteTables <- FALSE


# load metadata ----
#
# source(paste0(modlDir, "src/99_preprocess_rosstat.R"))


# register dataseries ----
#
ds <- c("rosstat")
gs <- c("gadm")

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

# yield ----
#
rosstat_yield <- list.files(path = paste0(censusDBDir, "/adb_tables/stage1/"),
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
  # write_clip(paste0("rus_3_yield", munst, "_2008_2020_rosstat"))

  regTable(nation = "rus",
           level = 3,
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


# planted area ----
#
rosstat_planted <- list.files(path = paste0(censusDBDir, "/adb_tables/stage1/"),
                              pattern = "*_Sown area of agricultural crops in farms of all categories.csv")

schema_planted <- setCluster(id = "al3", left = 1, top = .find(pattern = "Посевные площади сельскохозяйственных культур", col = 1)) %>%
  setFilter(rows = .find("Вся посевная площадь.", col = 1, invert = TRUE)) %>%
  setFormat(decimal = ".") %>%
  setIDVar(name = "al3", columns = 1, rows = .find(row = 1, relative = TRUE)) %>%
  setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = .find(fun = is.numeric, row = 3))

for(i in seq_along(rosstat_planted)){

  thisFile <- rosstat_planted[i]
  munst <- str_split(thisFile, "_")[[1]][2]
  # write_clip(paste0("rus_3_planted", munst, "_2008_2020_rosstat"))

  regTable(nation = "rus",
           level = 3,
           subset = paste0("planted", munst),
           dSeries = "rosstat",
           gSeries = "gadm",
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


# production ----
#
rosstat_production <- list.files(path = paste0(censusDBDir, "/adb_tables/stage1/"),
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

  regTable(nation = "rus",
           level = 3,
           subset = paste0("production", munst),
           dSeries = "rosstat",
           gSeries = "gadm",
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


# perennial crops ----
#
rosstat_perennial <- list.files(path = paste0(censusDBDir, "/adb_tables/stage1/"),
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

  regTable(nation = "rus",
           level = 3,
           subset = paste0("perennial", munst),
           dSeries = "rosstat",
           gSeries = "gadm",
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


# livestock ----
rosstat_livestock <- list.files(path = paste0(censusDBDir, "/adb_tables/stage1/"),
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

  regTable(nation = "rus",
           level = 3,
           subset = paste0("livestock", munst),
           dSeries = "rosstat",
           gSeries = "gadm",
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


# Reforestation area ----
regTable(nation = "rus",
         level = 2,
         subset = "reforestation",
         dSeries = "rosstat",
         gSeries = "gadm",
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

# Land area of specially protected areas and objects ----
regTable(nation = "rus",
         level = 2,
         subset = "protected",
         dSeries = "rosstat",
         gSeries = "gadm",
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

# Forest areas (by landcover-class) ----
regTable(nation = "rus",
         level = 2,
         subset = "protected",
         dSeries = "rosstat",
         gSeries = "gadm",
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

# Forest land area ----
regTable(nation = "rus",
         level = 2,
         subset = "protected",
         dSeries = "rosstat",
         gSeries = "gadm",
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


# harmonise commodities ----
#
for(i in seq_along(ds)){

  tibble(new = get_variable(variable = "commodities", dataseries = ds[i])) %>%
    match_ontology(table = ., columns = "new", dataseries = ds[i], ontology = ontoDir)

}


# normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              al1 = thisNation,
#              outType = "gpkg",
#              update = updateTables)


# normalise census tables ----
#
normTable(pattern = ds[1],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)


