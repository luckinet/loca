# script arguments ----
#
thisNation <- "Germany"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("destatis")
gs <- c("nuts")

https://www-genesis.destatis.de/genesis/online?operation=themes&levelindex=0&levelid=1700502954493&code=41#abreadcrumb
https://www.regionalstatistik.de/genesis/online?operation=themes&levelindex=0&levelid=1699809095879&code=41#abreadcrumb

# 1. register dataseries ----
#
regDataseries(name = ds[1],
              description = "Statistische Ämter des Bundes und der Länder",
              homepage = "https://www.statistikportal.de/de",
              licence_link = "https://www.govdata.de/dl-de/by-2-0",
              licence_path = "")


# 2. register geometries ----
#


# 3. register census tables ----
#
if(build_crops){
  ## crops ----

  # schema_1 <- setCluster() %>%
  #   setFormat() %>%
  #   setIDVar(name = "al2", ) %>%
  #   setIDVar(name = "year", ) %>%
  #   setIDVar(name = "methdod", value = "") %>%
  #   setIDVar(name = "crop", ) %>%
  #   setObsVar(name = "planted", unit = "ha", )
  #
  # regTable(nation = !!thisNation, # or any other "class = value" combination from the gazetteer
  #          label = ,
  #          subset = "",
  #          dSeries = ds[],
  #          gSeries = gs[],
  #          schema = ,
  #          begin = ,
  #          end = ,
  #          archive = "",
  #          archiveLink = "",
  #          updateFrequency = "",
  #          nextUpdate = "",
  #          metadataPath = "",
  #          metadataLink = "",
  #          update = updateTables,
  #          overwrite = overwriteTables)
}

if(build_livestock){
  ## livestock ----

}

if(build_landuse){
  ## landuse ----

}


#### test schemas

# myRoot <- paste0(census_dir, "/adb_tables/stage2/")
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
