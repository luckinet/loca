# ----
# geography : Russian Federation
# period    : 2007 - 2022
# dataseries: Russian National Statistics Agency (www.fedstat.ru)
# variables :
#   - land      : _INSERT
#   - crops     : hectares_harvested, hectares_planted, tons_produced, kiloPerHectare_yield
#   - livestock : number_heads
#   - technology: number_machines, tons_applied (fertilizer)
#   - social    : -
# sampling  : survey
# spatial   : Nation, Oblasts/Republics, Municipalities
# authors   : Steffen Ehrmann
# date      : 2024-06-06
# status    : validate (luts), done (gpw)
# comment   : look for some more older data (should be available at lower level)
# ----

thisNation <- "Russian Federation"
# source(paste0(mdl0301, "src/96_preprocess_rosstat.R"))

# todo:
# - sort in files from stage1/outdated to capture more municipalities

ds <- c("rosstat")
gs <- c("gadm")


# 1. dataseries ----
#
regDataseries(name = ds[1],
              description = "Russian National Statistics Agency",
              homepage = "www.fedstat.ru",
              version = "2023.12",
              licence_link = "unknown")


# 2. geometries ----
#
# based on GADM 3.6


# 3. tables ----
#
if(build_crops){
  # crops ----

  ## yield ----
  rosstat_yield <- list.files(path = paste0(dir_census_wip, "tables/stage1/rosstat/"),
                              pattern = "yield")

  for(i in seq_along(rosstat_yield)){

    thisFile <- rosstat_yield[i]
    name <- str_split(thisFile, "_")[[1]]
    munst <- name[2]
    al2Val <- str_split(name[4], "[.]")[[1]][1]

    schema_yield <- setCluster(id = "al3", left = 1, top = .find(pattern = "центнеров с гектара", col = 1)) %>%
      setFormat(decimal = ".") %>%
      setIDVar(name = "al2", value = al2Val) %>%
      setIDVar(name = "al3", columns = 1, split = "(?<=год\\. ).*", rows = .find(row = 1, relative = TRUE)) %>%
      setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
      setIDVar(name = "method", value = "survey") %>%
      setIDVar(name = "crop", columns = 1) %>%
      setObsVar(name = "kiloPerHectare_yield", factor = 100, columns = .find(fun = is.numeric, row = 2, relative = TRUE)) # russian centner to kilogram

    regTable(al1 = !!thisNation,
             label = "al3",
             subset = paste0("yield", al2Val),
             dSeries = ds[1],
             gSeries = gs[1],
             schema = schema_yield,
             begin = 2008,
             end = 2022,
             archive = thisFile,
             archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
             downloadDate = dmy("07-03-2024"),
             updateFrequency = "annually",
             metadataLink = "unknown",
             metadataPath = "unknown",
             overwrite = TRUE)

  }

  ## plantations ----
  rosstat_planted <- list.files(path = paste0(dir_census_wip, "/tables/stage1/rosstat/"),
                                pattern = "planted")

  for(i in seq_along(rosstat_planted)){

    thisFile <- rosstat_planted[i]
    name <- str_split(thisFile, "_")[[1]]
    munst <- name[2]
    al2Val <- str_split(name[4], "[.]")[[1]][1]

    schema_planted <- setCluster(id = "al3", left = 1, top = .find(pattern = "Посевные площади сельскохозяйственных культур", col = 1)) %>%
      setFilter(rows = .find(pattern = "Вся посевная площадь.", col = 1, invert = TRUE)) %>%
      setFormat(decimal = ".") %>%
      setIDVar(name = "al2", value = al2Val) %>%
      setIDVar(name = "al3", columns = 1, split = "(?<=год\\. ).*", rows = .find(row = 1, relative = TRUE)) %>%
      setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
      setIDVar(name = "method", value = "survey") %>%
      setIDVar(name = "crop", columns = 1) %>%
      setObsVar(name = "hectares_harvested", columns = .find(fun = is.numeric, row = 2, relative = TRUE))

    regTable(al1 = !!thisNation,
             label = "al3",
             subset = paste0("planted", al2Val),
             dSeries = ds[1],
             gSeries = gs[1],
             schema = schema_planted,
             begin = 2008,
             end = 2022,
             archive = thisFile,
             archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
             downloadDate = dmy("07-03-2024"),
             updateFrequency = "annually",
             metadataLink = "unknown",
             metadataPath = "unknown",
             overwrite = TRUE)

  }

  rosstat_production <- list.files(path = paste0(dir_census_wip, "/tables/stage1/rosstat/"),
                                   pattern = "production")

  ## production ----
  for(i in seq_along(rosstat_production)){

    thisFile <- rosstat_production[i]
    name <- str_split(thisFile, "_")[[1]]
    munst <- name[2]
    al2Val <- str_split(name[4], "[.]")[[1]][1]

    schema_production <- setCluster(id = "al3", left = 1, top = .find(pattern = "Валовые сборы сельскохозяйственных культур", col = 1)) %>%
      setFormat(decimal = ".") %>%
      setIDVar(name = "al2", value = al2Val) %>%
      setIDVar(name = "al3", columns = 1, split = "(?<=год\\. ).*", rows = .find(row = 1, relative = TRUE)) %>%
      setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
      setIDVar(name = "method", value = "survey") %>%
      setIDVar(name = "crop", columns = 1) %>%
      setObsVar(name = "tons_produced", factor = 0.1, columns = .find(fun = is.numeric, row = 2, relative = TRUE))

    regTable(al1 = !!thisNation,
             label = "al3",
             subset = paste0("production", al2Val),
             dSeries = ds[1],
             gSeries = gs[1],
             schema = schema_production,
             begin = 2008,
             end = 2022,
             archive = thisFile,
             archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
             downloadDate = dmy("07-03-2024"),
             updateFrequency = "annually",
             metadataLink = "unknown",
             metadataPath = "unknown",
             overwrite = TRUE)

  }

  rosstat_perennial <- list.files(path = paste0(dir_census_wip, "/tables/stage1/rosstat/"),
                                  pattern = "perennial")

  ## perennials ----
  for(i in seq_along(rosstat_perennial)){

    thisFile <- rosstat_perennial[i]
    name <- str_split(thisFile, "_")[[1]]
    munst <- name[2]
    al2Val <- str_split(name[4], "[.]")[[1]][1]

    schema_perennial <- setCluster(id = "al3", left = 1, top = .find(pattern = "Площадь многолетних насаждений", col = 1)) %>%
      setFormat(decimal = ".") %>%
      setIDVar(name = "al2", value = al2Val) %>%
      setIDVar(name = "al3", columns = 1, split = "(?<=год\\. ).*", rows = .find(row = 1, relative = TRUE)) %>%
      setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
      setIDVar(name = "method", value = "survey") %>%
      setIDVar(name = "crop", columns = 1) %>%
      setObsVar(name = "hectares_planted", columns = .find(fun = is.numeric, row = 2, relative = TRUE))

    regTable(al1 = !!thisNation,
             label = "al3",
             subset = paste0("perennial", al2Val),
             dSeries = ds[1],
             gSeries = gs[1],
             schema = schema_perennial,
             begin = 2008,
             end = 2022,
             archive = thisFile,
             archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
             downloadDate = dmy("07-03-2024"),
             updateFrequency = "annually",
             metadataLink = "unknown",
             metadataPath = "unknown",
             overwrite = TRUE)

  }

  normTable(pattern = ds[1],
            ontoMatch = "crop",
            beep = 10)

}


if(build_livestock){
  # livestock ----

  rosstat_livestock <- list.files(path = paste0(dir_census_wip, "/tables/stage1/rosstat/"),
                                  pattern = "livestock")

  for(i in seq_along(rosstat_livestock)){

    thisFile <- rosstat_livestock[i]
    name <- str_split(thisFile, "_")[[1]]
    munst <- name[2]
    al2Val <- str_split(name[4], "[.]")[[1]][1]

    schema_livestock <- setCluster(id = "al3", left = 1, top = .find(pattern = "Поголовье скота и птицы", col = 1)) %>%
      setFormat(decimal = ".") %>%
      setIDVar(name = "al2", value = al2Val) %>%
      setIDVar(name = "al3", columns = 1, split = "[^,|.]+$", rows = .find(row = 1, relative = TRUE)) %>%
      setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
      setIDVar(name = "method", value = "survey") %>%
      setIDVar(name = "animal", columns = 1) %>%
      setObsVar(name = "number_heads", columns = .find(fun = is.numeric, row = 2, relative = TRUE))

    regTable(al1 = !!thisNation,
             label = "al3",
             subset = paste0("livestock", al2Val),
             dSeries = ds[1],
             gSeries = gs[1],
             schema = schema_livestock,
             begin = 2008,
             end = 2022,
             archive = thisFile,
             archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
             updateFrequency = "annually",
             downloadDate = dmy("07-03-2024"),
             metadataLink = "unknown",
             metadataPath = "unknown",
             overwrite = TRUE)

  }

  normTable(pattern = paste0("livestock.*", ds[1]),
            ontoMatch = "animal",
            beep = 10)

}


if(build_landuse){
  # landuse ----

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

if(build_tech){

  # rosstat_machines <- list.files(path = paste0(dir_census_wip, "/tables/stage1/rosstat/"),
  #                                pattern = "machines")
  #
  # # machines ----
  # for(i in seq_along(rosstat_machines)){
  #
  #   thisFile <- rosstat_machines[i]
  #   name <- str_split(thisFile, "_")[[1]]
  #   munst <- name[2]
  #   al2Val <- str_split(name[4], "[.]")[[1]][1]
  #
  #   schema_machines <- setCluster(id = "al3", left = 1, top = .find(pattern = "тракторов|комбайнов|техники", col = 1)) %>%
  #     setFormat(decimal = ".") %>%
  #     setIDVar(name = "al2", value = al2Val) %>%
  #     setIDVar(name = "al3", columns = 1, split = "(?<=год\\. ).*", rows = .find(row = 1, relative = TRUE)) %>%
  #     setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
  #     setIDVar(name = "method", value = "survey") %>%
  #     setIDVar(name = "machine", columns = 1) %>%
  #     setObsVar(name = "number_machines", columns = .find(fun = is.numeric, row = 2, relative = TRUE))
  #
  #   regTable(al1 = !!thisNation,
  #            label = "al3",
  #            subset = paste0("machines", al2Val),
  #            dSeries = ds[1],
  #            gSeries = gs[1],
  #            schema = schema_machines,
  #            begin = 2008,
  #            end = 2022,
  #            archive = thisFile,
  #            archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
  #            downloadDate = dmy("07-03-2024"),
  #            updateFrequency = "annually",
  #            metadataLink = "unknown",
  #            metadataPath = "unknown",
  #            overwrite = TRUE)
  #
  # }
  #
  # normTable(pattern = ds[1],
  #           # ontoMatch = "machines",
  #           beep = 10)
  #
  # rosstat_fertMin <- list.files(path = paste0(dir_census_wip, "/tables/stage1/rosstat/"),
  #                               pattern = "fertMin")
  #
  # # mineral fertilizer ----
  # for(i in seq_along(rosstat_fertMin)){
  #
  #   thisFile <- rosstat_fertMin[i]
  #   name <- str_split(thisFile, "_")[[1]]
  #   munst <- name[2]
  #   al2Val <- str_split(name[4], "[.]")[[1]][1]
  #
  #   schema_fertMin <- setCluster(id = "al3", left = 1, top = .find(pattern = "значение показателя за год", col = 1)) %>%
  #     setFormat(decimal = ".") %>%
  #     setIDVar(name = "al2", value = al2Val) %>%
  #     setIDVar(name = "al3", columns = 1, split = "(?<=год\\. ).*", rows = .find(row = 1, relative = TRUE)) %>%
  #     setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
  #     setIDVar(name = "method", value = "survey") %>%
  #     setIDVar(name = "fertilizer", columns = 1) %>%
  #     setObsVar(name = "tons_applied", factor = , columns = .find(fun = is.numeric, row = 2, relative = TRUE)) # needs a factor to translate centners to tons
  #
  #   regTable(al1 = !!thisNation,
  #            label = "al3",
  #            subset = paste0("fertMin", al2Val),
  #            dSeries = ds[1],
  #            gSeries = gs[1],
  #            schema = schema_fertMin,
  #            begin = 2008,
  #            end = 2022,
  #            archive = thisFile,
  #            archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
  #            downloadDate = dmy("07-03-2024"),
  #            updateFrequency = "annually",
  #            metadataLink = "unknown",
  #            metadataPath = "unknown",
  #            overwrite = TRUE)
  #
  # }
  #
  # rosstat_fertOrg <- list.files(path = paste0(dir_census_wip, "/tables/stage1/rosstat/"),
  #                               pattern = "fertOrg")
  #
  # # organic fertilizer ----
  # for(i in seq_along(rosstat_fertOrg)){
  #
  #   thisFile <- rosstat_fertOrg[i]
  #   name <- str_split(thisFile, "_")[[1]]
  #   munst <- name[2]
  #   al2Val <- str_split(name[4], "[.]")[[1]][1]
  #
  #   schema_fertOrg <- setCluster(id = "al3", left = 1, top = .find(pattern = "значение показателя за год", col = 1)) %>%
  #     setFormat(decimal = ".") %>%
  #     setIDVar(name = "al2", value = al2Val) %>%
  #     setIDVar(name = "al3", columns = 1, split = "(?<=год\\. ).*", rows = .find(row = 1, relative = TRUE)) %>%
  #     setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) %>%
  #     setIDVar(name = "method", value = "survey") %>%
  #     setIDVar(name = "fertilizer", columns = 1) %>%
  #     setObsVar(name = "tons_applied", columns = .find(fun = is.numeric, row = 2, relative = TRUE))
  #
  #   regTable(al1 = !!thisNation,
  #            label = "al3",
  #            subset = paste0("fertOrg", al2Val),
  #            dSeries = ds[1],
  #            gSeries = gs[1],
  #            schema = schema_fertOrg,
  #            begin = 2008,
  #            end = 2022,
  #            archive = thisFile,
  #            archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
  #            downloadDate = dmy("07-03-2024"),
  #            updateFrequency = "annually",
  #            metadataLink = "unknown",
  #            metadataPath = "unknown",
  #            overwrite = TRUE)
  #
  # }
  #
  # normTable(pattern = ds[1],
  #           # ontoMatch = "fertilizer",
  #           beep = 10)
}

#### test schemas

myRoot <- paste0(dir_census_wip, "/adb_tables/stage2/")
myFile <- "Russian Federation_al3_livestockAdygea_2008_2020_rosstat.csv"
schema <- schema_livestock

input <- read_csv(file = paste0(myRoot, myFile),
                  col_names = FALSE,
                  col_types = cols(.default = "c"))

validateSchema(schema = schema, input = input)

output <- reorganise(input = input, schema = schema)

#### delete this section after finalising script
