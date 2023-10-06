# script arguments ----
#
thisNation <- "Algeria"

updateTables <- FALSE
overwriteTables <- FALSE

ds <- c("ons")
gs <- c("gadm36")


# 1. register dataseries ----
#
regDataseries(name = ds[1],
              description = "Office National des Statistiques",
              homepage = "http://www.ons.dz/",
              licence_link = "",
              licence_path = "",
              update = updateTables)


# 2. register geometries ----
#
regGeometry(nation = !!thisNation, # or any other "class = value" combination from the gazetteer
            gSeries = gs[],
            level = 2,
            nameCol = "",
            archive = "|",
            archiveLink = "",
            nextUpdate = "",
            updateFrequency = "",
            update = updateTables)


# 3. register census tables ----
#
## crops ----
if(build_crops){

}

## livestock ----
if(build_livestock){

  ### ons ----
  schema_alg_01 <-
    setFormat(thousand = ",") %>%
    setFilter(rows = .find("Total", col = 1), invert = TRUE) %>%
    setIDVar(name = "al1", value = "Algeria") %>%
    setIDVar(name = "year", columns = c(2:11), rows = 2) %>%
    setIDVar(name = "commodities", columns = 1) %>%
    setObsVar(name = "headcount", unit = "n", columns = c(2:11), top = 1)

  regTable(nation = "alg",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_alg_01,
           begin = 2000,
           end = 2009,
           archive = "Cheptel2000-2009-2.pdf",
           archiveLink = "https://www.ons.dz/IMG/pdf/Cheptel2000-2009-2.pdf",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://www.ons.dz/",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## landuse ----
if(build_landuse){

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
          # ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)


