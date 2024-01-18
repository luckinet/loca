# script arguments ----
#
thisNation <- ""

ds <- c("")
gs <- c("")


# 1. register dataseries ----
#
# regDataseries(name = ds[],
#               description = "",
#               homepage = "",
#               licence_link = "",
#               licence_path = "")


# 2. register geometries ----
#
# regGeometry(nation = !!thisNation, # or any other "class = value" combination from the gazetteer
#             gSeries = gs[],
#             label = list(al_ = ""),
#             archive = "|",
#             archiveLink = "",
#             nextUpdate = "",
#             updateFrequency = "",
#             update = updateTables)


# 3. register census tables ----
#
# schema_crops <- setCluster() %>%
#   setFormat() %>%
#   setIDVar(name = "al2", ) %>%
#   setIDVar(name = "al3", ) %>%
#   setIDVar(name = "year", ) %>%
#   setIDVar(name = "methdod", value = "") %>%
#   setIDVar(name = "crop", ) %>%
#   setObsVar(name = "harvested", unit = "ha", ) %>%
#   # for livestock
#   setIDVar(name = "animal", )  %>%
#   setObsVar(name = "headcount", unit = "n", ) %>%
#   # for landuse
#   setIDVar(name = "landuse", ) %>%
#   setObsVar(name = "area", unit = "ha", )
#
#
# regTable(nation = !!thisNation, # or any other "class = value" combination from the gazetteer
#          label = "al_", # this should be the name of a level in the gazetteer
#          subset = "",
#          dSeries = ds[],
#          gSeries = gs[],
#          schema = ,
#          begin = , # first year in the table
#          end = , # last year in the table
#          archive = "", # the name of this table in our database
#          archiveLink = "", # where this table can be found online
#          updateFrequency = "",
#          nextUpdate = "",
#          metadataPath = "",
#          metadataLink = "")

if(build_crops){
  ## crops ----

}

if(build_livestock){
  ## livestock ----

}

if(build_landuse){
  ## landuse ----

}


#### test schemas

myRoot <- paste0(census_dir, "tables/stage2/")
myFile <- ""
input <- read_csv(file = paste0(myRoot, myFile),
                  col_names = FALSE,
                  col_types = cols(.default = "c"))

schema <-
validateSchema(schema = schema, input = input)

output <- reorganise(input = input, schema = schema)

# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script


# 4. normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg")

# normGeometry(pattern = gs[],
#              outType = "gpkg")


# 5. normalise census tables ----
#
## in case the output shall be examined before writing into the DB
# testing <- normTable(nation = thisNation,
#                      update = FALSE,
#                      keepOrig = TRUE)

# normTable(pattern = ds[],
#           ontoMatch = ,
#           outType = "rds")
