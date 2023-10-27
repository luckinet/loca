# script arguments ----
#
thisNation <- "Mozambique"

updateTables <- FALSE
overwriteTables <- FALSE

ds <- c("masa")
gs <- c("gadm36", "mozgis")


# 1. register dataseries ----
#
# ! see 02_countryStat !
#
regDataseries(name = ds[1],
              description = "Ministério da Agricultura e Segurança Alimentar",
              homepage = "http://www.masa.gov.mz/",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)

regDataseries(name = gs[2],
              description = "Programa de Desenvolvimento Espacial",
              homepage = "https://www.mozgis.gov.mz",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)


# 2. register geometries ----
#
## mozgis ----
regGeometry(gSeries = gs[2],
            level = 1,
            nameCol = "ADM0_EN",
            archive = "mozambique.zip|moz_admbnda_adm0_ine_20190607.shp",
            archiveLink = "https://www.mozgis.gov.mz/portal/home/",
            updateFrequency = "notPlanned",
            update = updateTables)

regGeometry(gSeries = gs[2],
            level = 2,
            nameCol = "ADM0_EN|ADM1_PT",
            archive = "mozambique.zip|moz_admbnda_adm1_ine_20190607.shp",
            archiveLink = "https://www.mozgis.gov.mz/portal/home/",
            updateFrequency = "notPlanned",
            update = updateTables)

regGeometry(gSeries = gs[2],
            level = 3,
            nameCol = "ADM0_EN|ADM1_PT|ADM2_PT",
            archive = "mozambique.zip|moz_admbnda_adm2_ine_20190607.shp",
            archiveLink = "https://www.mozgis.gov.mz/portal/home/",
            updateFrequency = "notPlanned",
            update = updateTables)


# 3. register census tables ----
#
if(build_crops){
  ## crops ----

  ### masa----
  # regTable(nation = "Mozambique",
  #          subset = "plantedArea",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 2009,
  #          end = 2009,
  #          archive = "mozambique.zip|Censo Agro 2013 Pecuario 2009 2013 2010 Resultados Definitivos -2.pdf",
  #          archiveLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
  #          updateFrequency = "unknown",
  #          metadataLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "Mozambique",
  #          subset = "plantedArea_Production",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 2012,
  #          end = 2014,
  #          archive = "mozambique.zip|Anuario_Estatistico-2012_2014.pdf",
  #          archiveLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
  #          updateFrequency = "unknown",
  #          metadataLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "Mozambique",
  #          subset = "plantedArea_Production",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 2015,
  #          end = 2015,
  #          archive = "mozambique.zip|Anuario_Estatistico2016.pdf",
  #          archiveLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
  #          updateFrequency = "unknown",
  #          metadataLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "Mozambique",
  #          subset = "sugarCane",
  #          level = 1,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 2012,
  #          end = 2014,
  #          archive = "mozambique.zip|Anuario_Estatistico-2012_2014.pdf",
  #          archiveLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
  #          updateFrequency = "unknown",
  #          metadataLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)

}

if(build_livestock){
  ## livestock ----

  ### masa----
  # schema_masa1 <- makeSchema()
  #
  # regTable(nation = "Mozambique",
  #          subset = "headcountCattle",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 2007,
  #          end = 2017,
  #          archive = "mozambique.zip|headcount.cattle.2007-2017.csv",
  #          archiveLink = "http://www.masa.gov.mz/pecuaria/producao-animal/",
  #          updateFrequency = "unknown",
  #          metadataLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # regTable(nation = "Mozambique",
  #          subset = "headcountSwine",
  #          level = 2,
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = ,
  #          begin = 2007,
  #          end = 2017,
  #          archive = "mozambique.zip|headcount.swine.2007-2017.csv",
  #          archiveLink = "http://www.masa.gov.mz/pecuaria/producao-animal/",
  #          updateFrequency = "unknown",
  #          metadataLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)

}

if(build_landuse){
  ## landuse ----

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


# 4. normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg",
#              update = updateTables)

# normGeometry(pattern = gs[],
#              outType = "gpkg",
#              update = updateTables)


# 5. normalise census tables ----
#
## in case the output shall be examined before writing into the DB
# testing <- normTable(nation = thisNation,
#                      update = FALSE,
#                      keepOrig = TRUE)

# normTable(pattern = ds[],
#           ontoMatch = ,
#           outType = "rds",
#           update = updateTables)
