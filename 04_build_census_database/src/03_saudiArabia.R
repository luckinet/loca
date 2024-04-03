# ----
# geography : Saudi Arabia
# period    : _INSERT
# dataseries: General Authority for Statistics (https://www.stats.gov.sa/en/node)
# variables :
#   - land      : _INSERT
#   - crops     : _INSERT
#   - livestock : _INSERT
#   - technology: _INSERT
#   - social    : _INSERT
# sampling  : survey, census
# spatial   : _INSERT
# authors   : Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisNation <- "Saudi Arabia"

# 1. dataseries ----
#
ds <- c("gas")
gs <- c("gadm36", "gas")

regDataseries(name = ds[],
              description = _INSERT,
              homepage = _INSERT,
              version = _INSERT,
              licence_link = _INSERT)

# regDataseries(name = ds[1],
#               description = "General Authority for Statistics",
#               homepage = "https://www.stats.gov.sa/en/node",
#               notes = "data are public domain",
#               licence_link = "",
#               licence_path = "",
#               update = updateTables)



# 2. geometries ----
#
regGeometry(nation = !!thisNation,
            gSeries = gs[],
            label = list(al_ = ""),
            archive = "|",
            archiveLink = _INSERT,
            downloadDate = _INSERT,
            updateFrequency = _INSERT)

## gas ----
# regGeometry(nation = "Saudi Arabia",
#             gSeries = gs[2],
#             level = 1,
#             nameCol = "Name_Engli",
#             archive = "sau_adm0.zip|SAU_adm0.shp",
#             archiveLink = "", #find out link
#             updateFrequency = "unknown",
#             update = myUpdate)
#
# regGeometry(nation = "Saudi Arabia",
#             gSeries = gs[2],
#             level = 2,
#             nameCol = "Name_1",
#             archive = "sau_adm1.zip|SAU_adm1.shp",
#             archiveLink = "", #find out link
#             updateFrequency = "unknown",
#             update = myUpdate)
#
# regGeometry(nation = "Saudi Arabia",
#             gSeries = gs[2],
#             level = 3,
#             nameCol = "Mohafza",
#             archive = "saudia_district_29f.zip|saudia_district_29f.shp",
#             archiveLink = "", #find out link
#             updateFrequency = "unknown",
#             update = myUpdate)

normGeometry(pattern = gs[],
             beep = 10)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  schema_crops <- setCluster(id = _INSERT) %>%
    setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
              na_values = _INSERT) %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "") %>%
    setIDVar(name = "crop", ) %>%
    setObsVar(name = "hectares_harvested", ) %>%
    setObsVar(name = "tons_produced", ) %>%
    setObsVar(name = "kiloPerHectare_yield", )

  regTable(nation = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_crops,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           downloadDate = ymd(_INSERT),
           updateFrequency = _INSERT,
           metadataLink = _INSERT,
           metadataPath = _INSERT,
           overwrite = TRUE)

  normTable(pattern = ds[],
            ontoMatch = "crop",
            beep = 10)
}

if(build_livestock){
  ## livestock ----

  schema_livestock <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "") %>%
    setIDVar(name = "animal", )  %>%
    setObsVar(name = "number_heads", )

  regTable(nation = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_livestock,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           downloadDate = ymd(_INSERT),
           updateFrequency = _INSERT,
           metadataLink = _INSERT,
           metadataPath = _INSERT,
           overwrite = TRUE)

  normTable(pattern = ds[],
            ontoMatch = "animal",
            beep = 10)
}

if(build_landuse){
  ## landuse ----

  schema_landuse <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "landuse", ) %>%
    setObsVar(name = "hectares_covered", )

  regTable(nation = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_landuse,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           downloadDate = ymd(_INSERT),
           updateFrequency = _INSERT,
           metadataLink = _INSERT,
           metadataPath = _INSERT,
           overwrite = TRUE)

  normTable(pattern = ds[],
            ontoMatch = "landuse",
            beep = 10)
}

#### test schemas
#
# myRoot <- paste0(census_dir, "tables/stage2/")
# myFile <- ""
# input <- read_csv(file = paste0(myRoot, myFile),
#                   col_names = FALSE,
#                   col_types = cols(.default = "c"))
#
# schema <-
# validateSchema(schema = schema, input = input)
#
# output <- reorganise(input = input, schema = schema)
#
# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script





## gas ----
# schema_cropsarea09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 4, col = 1),
#     year = list(type = "id", row = 7, col = 2:4),
#     planted = list(type = "observed", col = 2:4, unit = "ha", factor = 1),
#     harvested = list(type = "observed", unit = "ha", factor = 1),
#     yield = list(type = "observed", unit = "t/h", factor = 1, rel = FALSE),
#     production = list(type = "observed", unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "crops area",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_cropsarea09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_cereals09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "cereals",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_cereals09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_cereals09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "wheat",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_cereals09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_MillentGrains09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "MillentGrains",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_MillentGrains09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Sorghum09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Sorghum",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Sorghum09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Maize09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Maize",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Maize09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Barley09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Barley",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Barley09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Sesame09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Sesame",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Sesame09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherCereals09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Other Cereals",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_OtherCereals09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Tomato09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Tomato",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Tomato09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Potato09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Potato",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Potato09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Marrow09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Marrow",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Marrow09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Eggplant09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Eggplant",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Eggplant09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Okra09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Okra",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Okra09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Carrot09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Carrot",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Carrot09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Onion09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Onion",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Onion09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Cucumber09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Cucumber",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Cucumber09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Melon09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Melon",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Melon09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Watermelon09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Watermelon",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Watermelon09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schemaVegetables09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Vegetables",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schemaVegetables09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_VGreenHouses09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "VegGreen Houses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_VGreenHouses09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_TomatoGreenHouse09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Tomato GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_TomatoGreenHouse09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_CucumberGreenHouses09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Cucumber GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_CucumberGreenHouses09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_MarrowGreenHouses09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Marrow GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_MarrowGreenHouses09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherVegeGreenHouses09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "OtherVege GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_OtherVegeGreenHouses09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Fodder09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Fodder",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Fodder09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Clover09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Clover",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Clover09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherFodder09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Other Fodder",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_OtherFodder09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Fruits09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "All Fruits",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Fruits09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Dates09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Dates",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Dates09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Citrus09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Citrus",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Citrus09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Grapes09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Grapes",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Grapes09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherFruits09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Other Fruits",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_OtherFruits09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Camels09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Camels",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Camels09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Sheep09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Sheep",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Sheep09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Goats09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Goats",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Goats09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Cows09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Cows",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Cows09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Chicken09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Chicken",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2007,
#          end = 2009,
#          schema = schema_Chicken09,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_cropsarea10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3, col = 1),
#     year = list(type = "id", row = 7, col = 2:4),
#     planted = list(type = "observed", col = 2:4, unit = "ha", factor = 1),
#     harvested = list(type = "observed", unit = "ha", factor = 1),
#     yield = list(type = "observed", unit = "t/h", factor = 1, rel = FALSE),
#     production = list(type = "observed", unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "crops area",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_cropsarea10,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_cereals10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "cereals",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_cereals10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_cereals10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "wheat",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_cereals10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_MillentGrains10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "MillentGrains",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_MillentGrains10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Sorghum10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Sorghum",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Sorghum10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Maize10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Maize",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Maize10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Barley10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Barley",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Barley10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Sesame10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Sesame",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Sesame10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherCereals10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Other Cereals",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_OtherCereals10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_AllVegetables10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = " All Vegetables",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_AllVegetables10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Potato10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Potato",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Potato10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Tomato10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Tomato",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Tomato10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Marrow10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Marrow",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Marrow10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Eggplant10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Eggplant",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Eggplant10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Okra10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Okra",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Okra10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Carrot10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Carrot",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Carrot10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Onion10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Onion",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Onion10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Cucumber10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Cucumber",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Cucumber10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Melon10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Melon",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Melon10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Watermelon10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Watermelon",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Watermelon10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schemaVegetables10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Vegetables",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schemaVegetables10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_VGreenHouses10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "VegGreen Houses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_VGreenHouses10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_TomatoGreenHouse10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Tomato GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_TomatoGreenHouse10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_CucumberGreenHouses10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Cucumber GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_CucumberGreenHouses10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_MarrowGreenHouses10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Marrow GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_MarrowGreenHouses10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherVegeGreenHouses10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "OtherVege GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_OtherVegeGreenHouses10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Fodder10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Fodder",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Fodder10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Clover10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Clover",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Clover10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherFodder10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Other Fodder",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_OtherFodder10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Fruits10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "All Fruits",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Fruits10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Dates10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Dates",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Dates10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Citrus10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Citrus",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Citrus10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Grapes10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Grapes",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Grapes10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherFruits10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Other Fruits",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_OtherFruits10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Camels10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Camels",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Camels10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Sheep10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Sheep",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Sheep10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Goats10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Goats",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Goats10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Cows10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Cows",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Cows10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Chicken10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Chicken",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2008,
#          end = 2010,
#          schema = schema_Chicken10,
#          archive = "Statistical year book_46_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_cropsarea11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3, col = 1),
#     year = list(type = "id", row = 7, col = 2:4),
#     planted = list(type = "observed", col = 2:4, unit = "ha", factor = 1),
#     harvested = list(type = "observed", unit = "ha", factor = 1))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "crops area",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_cropsarea11,
#          archive = "Statistical year book_2012.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_cereals11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "cereals",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_cereals11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_cereals11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "wheat",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_cereals11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_MillentGrains11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "MillentGrains",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_MillentGrains11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Sorghum11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Sorghum",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Sorghum11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Maize11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Maize",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Maize11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Barley11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Barley",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Barley11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Sesame11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Sesame",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Sesame11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherCereals11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Other Cereals",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_OtherCereals11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_AllVegetables11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = " All Vegetables",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_AllVegetables11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Tomato11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Tomato",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Tomato11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Potato11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Potato",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Potato11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Marrow11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Marrow",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Marrow11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Eggplant11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Eggplant",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Eggplant11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Okra11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Okra",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Okra11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Carrot11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Carrot",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Carrot11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Onion11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Onion",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Onion11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Cucumber11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Cucumber",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Cucumber11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Melon11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Melon",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Melon11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Watermelon11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Watermelon",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Watermelon11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schemaVegetables11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Vegetables",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schemaVegetables11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_VGreenHouses11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "VegGreen Houses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_VGreenHouses11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_TomatoGreenHouse11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Tomato GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_TomatoGreenHouse11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_CucumberGreenHouses11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Cucumber GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_CucumberGreenHouses11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_MarrowGreenHouses11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Marrow GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_MarrowGreenHouses11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherVegeGreenHouses11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "OtherVege GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_OtherVegeGreenHouses11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Fodder11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Fodder",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Fodder11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Clover11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Clover",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Clover11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherFodder11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Other Fodder",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_OtherFodder11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Fruits11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "All Fruits",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Fruits11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Dates11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Dates",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Dates11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Citrus11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Citrus",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Citrus11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Grapes11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Grapes",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Grapes11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherFruits11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Other Fruits",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_OtherFruits11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Camels11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Camels",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Camels11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Sheep11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Sheep",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Sheep11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Goats11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Goats",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Goats11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Cows11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Cows",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Cows11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Chicken11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Chicken",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2009,
#          end = 2011,
#          schema = schema_Chicken11,
#          archive = "Statistical year book_46_2011.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_cropsarea08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3, col = 1),
#     year = list(type = "id", row = 7, col = 2:4),
#     planted = list(type = "observed", col = 2:4, unit = "ha", factor = 1),
#     harvested = list(type = "observed", unit = "ha", factor = 1))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "crops area",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_cropsarea08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_cereals08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "cereals",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_cereals08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_cereals08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "wheat",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_cereals08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_MillentGrains08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "MillentGrains",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_MillentGrains08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Sorghum08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Sorghum",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Sorghum08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Maize08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Maize",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Maize08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Barley08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Barley",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Barley08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Sesame08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Sesame",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Sesame08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherCereals08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Other Cereals",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_OtherCereals08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_AllVegetables08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = " All Vegetables",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_AllVegetables08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Tomato08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Tomato",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Tomato08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Potato08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Potato",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Potato08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Marrow08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Marrow",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Marrow08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Eggplant08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Eggplant",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Eggplant08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Okra08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Okra",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Okra08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Carrot08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Carrot",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Carrot08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Onion08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Onion",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Onion08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Cucumber08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Cucumber",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Cucumber08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Melon08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Melon",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Melon08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Watermelon08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Watermelon",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Watermelon08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schemaVegetables08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Vegetables",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schemaVegetables08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_VGreenHouses08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "VegGreen Houses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_VGreenHouses08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_TomatoGreenHouse08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Tomato GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_TomatoGreenHouse08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_CucumberGreenHouses08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Cucumber GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_CucumberGreenHouses08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_MarrowGreenHouses08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Marrow GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_MarrowGreenHouses08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherVegeGreenHouses08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "OtherVege GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_OtherVegeGreenHouses08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Fodder08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Fodder",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Fodder08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Clover08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Clover",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Clover08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherFodder08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Other Fodder",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_OtherFodder08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Fruits08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "All Fruits",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Fruits08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Dates08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Dates",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Dates08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Citrus08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Citrus",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Citrus08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Grapes08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Grapes",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Grapes08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherFruits08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Other Fruits",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_OtherFruits08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Camels08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Camels",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Camels08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Sheep08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Sheep",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Sheep08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Goats08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Goats",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Goats08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Cows08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Cows",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Cows08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Chicken08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Chicken",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2005,
#          end = 2007,
#          schema = schema_Chicken08,
#          archive = "Statistical year book 2008.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_cropsarea09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3, col = 1),
#     year = list(type = "id", row = 7, col = 2:4),
#     planted = list(type = "observed", col = 2:4, unit = "ha", factor = 1),
#     harvested = list(type = "observed", unit = "ha", factor = 1))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "crops area",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_cropsarea09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_cereals09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "cereals",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_cereals09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_cereals09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "wheat",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_cereals09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_MillentGrains09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "MillentGrains",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_MillentGrains09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Sorghum09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Sorghum",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Sorghum09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Maize09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Maize",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Maize09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Barley09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Barley",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Barley09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Sesame09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Sesame",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Sesame09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherCereals09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Other Cereals",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_OtherCereals09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_AllVegetables09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = " All Vegetables",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_AllVegetables09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Tomato09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Tomato",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Tomato09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Potato09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Potato",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Potato09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Marrow09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Marrow",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Marrow09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Eggplant09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Eggplant",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Eggplant09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Okra09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Okra",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Okra09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Carrot09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Carrot",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Carrot09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Onion09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Onion",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Onion09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Cucumber09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Cucumber",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Cucumber09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Melon09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Melon",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Melon09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Watermelon09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Watermelon",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Watermelon09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schemaVegetables09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Vegetables",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schemaVegetables09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_VGreenHouses09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 8, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "VegGreen Houses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_VGreenHouses09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_TomatoGreenHouse09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 8, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Tomato GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_TomatoGreenHouse09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_CucumberGreenHouses09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 8, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Cucumber GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_CucumberGreenHouses09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_MarrowGreenHouses09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 8, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Marrow GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_MarrowGreenHouses09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherVegeGreenHouses09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 8, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "OtherVege GreenHouses",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_OtherVegeGreenHouses09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Fodder09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Fodder",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Fodder09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Clover09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Clover",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Clover09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherFodder09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Other Fodder",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_OtherFodder09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Fruits09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "All Fruits",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Fruits09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Dates09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Dates",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Dates09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Citrus09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Citrus",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Citrus09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Grapes09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Grapes",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Grapes09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_OtherFruits09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 8),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:6 ),
#     planted = list(type = "observed", col = c(2,4,6), unit = "ha", factor = 1),
#     production = list(type = "observed", col = c(3,5,7), unit = "t", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Other Fruits",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_OtherFruits09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Camels09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 7, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Camels",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Camels09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Sheep09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 3:4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Sheep",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Sheep09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Goats09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Goats",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Goats09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Cows09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Cows",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Cows09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_Chicken09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, width = NULL, height = NULL, id = "commodities"),
#   header = list(row = 7:9),
#   format = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 = list(type = "id", col = 5),
#     commodities = list(type = "id", row = 4, col = 1),
#     year = list(type = "id", row = 8, col = 2:4 ),
#     headcount = list(type = "observed", col = 2:4, unit = "h", factor = 1, rel = FALSE))))
# regTable(nation = "Saudi Arabia",
#          level = 2,
#          subset = "Chicken",
#          dSeries = ds[1],
#          gSeries = gs[2],
#          begin = 2006,
#          end = 2008,
#          schema = schema_Chicken09,
#          archive = "Statistical year book 2009.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
