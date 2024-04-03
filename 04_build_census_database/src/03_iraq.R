# ----
# geography : _INSERT
# period    : _INSERT
# dataseries: _INSERT
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

thisNation <- "Iraq"

# 1. dataseries ----
#
ds <- c("cosit")
gs <- c("gadm36", "cosit")

regDataseries(name = ds[],
              description = _INSERT,
              homepage = _INSERT,
              version = _INSERT,
              licence_link = _INSERT)

# regDataseries(name = ds[1],
#               description = "Central statistical origination",
#               homepage = "http://cosit.gov.iq/en/",
#               notes = "data are public domain",
#               licence_link = "unknown",
#               licence_path = "unknown",
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

# regGeometry(nation = "Iraq",
#             gSeries = gs[2],
#             level = 1,
#             nameCol = "Name_0",
#             archive = "Iraq_data0.zip|gadm36_IRQ_0.shp",
#             archiveLink = "", #find out link
#             nextUpdate = "",
#             updateFrequency = "unknown",
#             update = updateTables)
#
# regGeometry(nation = "Iraq",
#             gSeries = gs[2],
#             level = 2,
#             nameCol = "Name_1",
#             archive = "Iraq_data1.zip|gadm36_IRQ_1.shp",
#             archiveLink = "", #find out link
#             nextUpdate = "",
#             updateFrequency = "unknown",
#             update = updateTables)
#
# regGeometry(nation = "Iraq",
#             gSeries = gs[2],
#             level = 3,
#             nameCol = "Name_2",
#             archive = "Iraq_data2.zip|gadm36_IRQ_2.shp",
#             archiveLink = "", #find out link
#             nextUpdate = "",
#             updateFrequency = "unknown",
#             update = updateTables)

normGeometry(pattern = gs[],
             beep = 10)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  ### cosit ----
  #### governerate ----
  # paddy rice and sunfolower
  # Schema_PADDY15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 6, col = c(1,5), width = 4, height = 19, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", value = "Iraq"),
  #     govern = list(type = "id", row = c(7:25), col = c(1,8)),
  #     commodities = list(type = "id", row = 4),
  #     planted = list(type = "measured", row = c(7:25), col = c(2,5), unit = "tree", factor = 0.1),
  #     production = list(type = "measured", row = c(7:25), col = c(3,6) unit = "t", factor = 10),
  #     yield = list(type = "measured", row = c(7,25), col = c(4,7) unit = "t/ha", factor = 0.011)
  #   )))

  # regTable(nation = "Iraq",
  #          level = 2,
  #          subset = "PUDDY",
  #          dSeries = "cso Iraq",
  #          gSeries = "cso Iraq",
  #          begin = 2015,
  #          end = 2015,
  #          schema = Schema_PADDY15,
  #          archive = "Cultivated paddy and sun flower by governerate 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  #### nation ----
  #     schema_Sativaseed16 <- makeSchema(schema = list(
  #       clusters =
  #         list(row = 4, col = 1, id = "commodities"),
  #       header = list(row = 4:6),
  #       meta = list(del = "."),
  #       variables = list(
  #         al2 = list(type = "id", col = 7),
  #         commodities = list(type = "id", row = 3ALSE),
  #         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
  #         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
  #         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
  #         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
  #         production = list(type = "measured", col = 1 unit = "t", factor = 1)
  #       )))
  #
  #     regTable(nation = "Iraq",
  #              level =2,
  #              subset = "Sativa seed",
  #              dSeries = "cso Iraq",
  #              gSeries = "cso Iraq",
  #              begin = 2016,
  #              end = 2016,
  #              schema = schema_Sativaseed16,
  #              archive = "Secondary crops and vegetables production report 2016.pdf",
  #              archiveLink = "unknown",
  #              updateFrequency = "notPlanned",
  #              metadataLink = "unknown",
  #              metadataPath = "unknown",
  #              update = TRUE)

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



# Schema_citrus <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 5),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     year = list(type = "id", row = 6),
#     commodities = list(type = "id", row = c(7:11), col = 9),
#     treecount = list(type = "measured", row = c(7:11), col = c(2:3), unit = "tree"),
#     yield_tree = list(type = "measured", row = c(7:11), col = c(4:5), unit = "kg", factor = 1),
#     production = list(type = "measured", row = c(7:11), col = c(6:7) unit = "t", factor = 1000)
#   )))
#
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "Citrus",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_citrus,
#          archive = "Citrus trees report for the year 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_bitterOrange <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 2),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(6:12), col = 1),
#     treecount = list(type = "measured", row = c(6:12), col = 2, unit = "tree"),
#     yield_tree = list(type = "measured", row = c(6:12), col = 3, unit = "kg", factor = 1),
#     production = list(type = "measured", row = c(6:12), col = 4 unit = "t", factor = 1000)
#   )))
#
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "bitterOrange",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_bitterOrange,
#          archive = "Citrus trees report for the year 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_SourLemon <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 2),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(6:12), col = 1),
#     treecount = list(type = "measured", row = c(6:12), col = 2, unit = "tree"),
#     yield_tree = list(type = "measured", row = c(6:12), col = 3, unit = "kg", factor = 1),
#     production = list(type = "measured", row = c(6:12), col = 4 unit = "t", factor = 1000)
#   )))
#
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "SourLemon",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_SourLemon,
#          archive = "Citrus trees report for the year 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_orange <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 2),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(6:12), col = 1),
#     treecount = list(type = "measured", row = c(6:12), col = 2, unit = "tree"),
#     yield_tree = list(type = "measured", row = c(6:12), col = 3, unit = "kg", factor = 1),
#     production = list(type = "measured", row = c(6:12), col = 4 unit = "t", factor = 1000)
#   )))
#
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "orange",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_orange,
#          archive = "Citrus trees report for the year 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_SweetLemon <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 2),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(6:9), col = 1),
#     treecount = list(type = "measured", row = c(6:9), col = 2, unit = "tree"),
#     yield_tree = list(type = "measured", row = c(6:9), col = 3, unit = "kg", factor = 1),
#     production = list(type = "measured", row = c(6:9), col = 4 unit = "t", factor = 1000,        # corection factor need to be corrected for the all trees #
#                       rel = FALSE)
#   )))
#
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "SweetLemon",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_SweetLemon,
#          archive = "Citrus trees report for the year 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Mandarin <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 2),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(6:9), col = 1),
#     treecount = list(type = "measured", row = c(6:9), col = 2, unit = "tree"),
#     yield_tree = list(type = "measured", row = c(6:9), col = 3, unit = "kg", factor = 1),
#     production = list(type = "measured", row = c(6:9), col = 4 unit = "t", factor = 1)
#   )))
#
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "Mandarin",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_Mandarin,
#          archive = "Citrus trees report for the year 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Millet <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 2),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(8:14), col = 1),
#     planted = list(type = "measured", row = c(8:14), col = 5, unit = "ha", factor = 0.1, rel = TRUE),
#     yield = list(type = "measured", row = c(8:14), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(8:14), col = 2 unit = "t", factor = 1)
#   )))
#
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "Millet",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_Millet,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_MilletSeed <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(8:13), col = 1),
#     planted = list(type = "measured", row = c(8:13), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(8:13), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(8:13), col = 2 unit = "t", factor = 1)
#   )))
#
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "MilletSeed",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_MilletSeed,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Sativaseed <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7:8), col = 1),
#     planted = list(type = "measured", row = c(7:8), col = 5, unit = "ha", factor = 0.1, rel = TRUE),
#     yield = list(type = "measured", row = c(7:8), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7:8), col = 2 unit = "t", factor = 1)
#   )))
#
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "SummerSativaSeed",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_Sativaseed,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_cucumber18w <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7:17), col = 1),
#     planted = list(type = "measured", row = c(7:17), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7:17), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7:17), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = " cucumberWiter",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_cucumber18w,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_AcuAlfalfa <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7:15), col = 1),
#     planted = list(type = "measured", row = c(7:15), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7:15), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7:15), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = " AcuAlfalfa",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_AcuAlfalfa,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_AlfalfaWint <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7:13), col = 1),
#     planted = list(type = "measured", row = c(7:13), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7:13), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7:13), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "AlfalfaWint",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_AlfalfaWint,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_AlfalfaSumm <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7:11), col = 1),
#     planted = list(type = "measured", row = c(7:11), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7:11), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7:11), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "AlfalfaSumm",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_AlfalfaSumm,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_AcumMelon <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7:20), col = 1),
#     planted = list(type = "measured", row = c(7:20), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7:20), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7:20), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "AcumMelon",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_AcumMelon,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_WinMelon <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 7, col = 1),
#     planted = list(type = "measured", row = 7, col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = 7, col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = 7, col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "WinMelon",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_WinMelon,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_SummMelon <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,20), col = 1),
#     planted = list(type = "measured", row = c(7,20), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,20), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,20), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "SummMelon",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_SummMelon,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_summSesame <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,13), col = 1),
#     planted = list(type = "measured", row = c(7,13), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,13), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,13), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "summSesame",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_summSesame,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_WinGreenbroad <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,18), col = 1),
#     planted = list(type = "measured", row = c(7,18), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,18), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,18), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "WinGreenbroad",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_WinGreenbroad,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_WinBrassica <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,17), col = 1),
#     planted = list(type = "measured", row = c(7,17), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,17), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,17), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "WinBrassica",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_WinBrassica,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_WinCauliflower <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,14), col = 1),
#     planted = list(type = "measured", row = c(7,14), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,14), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,14), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "WinCauliflower",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_WinCauliflower,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_WinTurnip <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,8), col = 1),
#     planted = list(type = "measured", row = c(7,8), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,8), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,8), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "WinTurnip",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_WinTurnip,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_BeansAcum <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,10), col = 1),
#     planted = list(type = "measured", row = c(7,10), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,10), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,10), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "BeansAcum",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_BeansAcum,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CucumberAcum <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 4),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,20), col = 1),
#     planted = list(type = "measured", row = c(7,20), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,20), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,20), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "CucumberAcum",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_CucumberAcum,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CucumberSumm <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,19), col = 1),
#     planted = list(type = "measured", row = c(7,19), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,19), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,19), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "CucumberSumm",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_CucumberSumm,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CucumberWin <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,20), col = 1),
#     planted = list(type = "measured", row = c(7,20), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,20), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,20), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "CucumberWin",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_CucumberWin,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_AcumRadish <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, height = 15, id = NULL),
#   header = list(row = 1:3, rel = TRUE),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     planted = list(type = "measured", row = c(7:18), col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#     harvested = list(type = "measured", row = c(7:18), col = 7, unit = "ha", factor = 0.1, rel = FALSE),
#     yield = list(type = "measured", row = c(7:18), col = 3, unit = "t/ha", factor = 10, rel = FALSE),
#     production = list(type = "measured", row = c(7:18), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "AcumRadish",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_AcumRadish,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_SummRadish <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,15), col = 1),
#     planted = list(type = "measured", row = c(7,15), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,15), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,15), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "SummRadish",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_SummRadish,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_WinRadish <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,16), col = 1),
#     planted = list(type = "measured", row = c(7,16), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,16), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,16), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "WinRadish",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_WinRadish,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_AcumPepper <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,19), col = 1),
#     planted = list(type = "measured", row = c(7,19), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,19), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,19), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "AcumPepper",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_AcumPepper,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_PeppersummerHot <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,13), col = 1),
#     planted = list(type = "measured", row = c(7,13), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,13), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,13), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "PeppersummerHot",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_PeppersummerHot,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Peppersummer <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,17), col = 1),
#     planted = list(type = "measured", row = c(7,17), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,17), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,17), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "Peppersummer",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_Peppersummer,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CoveredHotPepperWint <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,9), col = 1),
#     planted = list(type = "measured", row = c(7,9), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,9), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,9), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "CoveredHotPepperWint",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_CoveredHotPepperWint,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CoveredPepperWint <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,13), col = 1),
#     planted = list(type = "measured", row = c(7,13), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,13), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,13), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "CoveredPepperWint",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_CoveredPepperWint,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_acumSwisschard <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,19), col = 1),
#     planted = list(type = "measured", row = c(7,19), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,19), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,19), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = " (acumSwisschard",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_acumSwisschard,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_summerSwisschard <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,17), col = 1),
#     planted = list(type = "measured", row = c(7,17), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,17), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,17), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "summerSwisschard",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_summerSwisschard,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_WinSwisschard <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,17), col = 1),
#     planted = list(type = "measured", row = c(7,17), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,17), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,17), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "WinterSwisschard",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_WinSwisschard,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_BeetRootwin <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,12), col = 1),
#     planted = list(type = "measured", row = c(7,12), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,12), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,12), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "BeetRootwin",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_BeetRootwin,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CabbageWin <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,15), col = 1),
#     planted = list(type = "measured", row = c(7,15), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,15), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,15), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "CabbageWin",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_CabbageWin,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Carrotswinter <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = NULL),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,15), col = 1),
#     planted = list(type = "measured", row = c(7,15), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,15), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,15), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "Carrotswinter",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_Carrotswinter,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Cereal <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al1 = list(type = "id", value = "Iraq"),
#     commodities = list(type = "id", row = c(9,13), col = 9),
#     planted = list(type = "measured", row = c(9,13), col = 2, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(9,13), col = 6, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(9,13), col = 8 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 1,
#          subset = "Cereal",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_Cereal,
#          archive = "crops and vegetables for the year 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CottonTobaco <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al1 = list(type = "id", value = "Iraq"),
#     commodities = list(type = "id", row = c(4,5), col = 9),
#     planted = list(type = "measured", row = c(4,5), col = 2, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(4,5), col = 6, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(4,5), col = 8 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 1,
#          subset = "CottonTobaco",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_CottonTobaco,
#          archive = "crops and vegetables for the year 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Drygreenbread <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,9), col = 1),
#     planted = list(type = "measured", row = c(7,9), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,9), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,9), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "DrygreenbreadbeanSumm",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_Drygreenbread,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Eggplantsumm <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,20), col = 1),
#     planted = list(type = "measured", row = c(7,20), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,20), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,20), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "Eggplantsumm",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_Eggplantsumm,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_EggplantAcum <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,20), col = 1),
#     planted = list(type = "measured", row = c(7,20), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,20), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,20), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "EggplantAcum",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_EggplantAcum,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_fodderwinterSorghum <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,16), col = 1),
#     planted = list(type = "measured", row = c(7,16), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,16), col = 3, unit = "t/ha", factor = 10, rel = TRUE),
#     production = list(type = "measured", row = c(7,16), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "fodderwinterSorghum",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_fodderwinterSorghum,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Foddermixsumm <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,9), col = 1),
#     planted = list(type = "measured", row = c(7,9), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,9), col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = c(7,9), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "FoddermixSumm",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_Foddermixsumm,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_FodderMixAcum <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,10), col = 1),
#     planted = list(type = "measured", row = c(7,10), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,10), col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = c(7,10), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "FodderMixAcum",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_FodderMixAcum,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_DryGarlicwin <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(8,9), col = 1),
#     planted = list(type = "measured", row = c(8,9), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(8,9), col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = c(8,9), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "DryGarlicwin",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_DryGarlicwin,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_GreenGarlicwin <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,17), col = 1),
#     planted = list(type = "measured", row = c(7,17), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,17), col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = c(7,17), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "GreenGarlicwin",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_GreenGarlicwin,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Greengramsumm <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,15), col = 1),
#     planted = list(type = "measured", row = c(7,15), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,15), col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = c(7,15), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "Greengramsumm",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_Greengramsumm,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Greenonionwin <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,18), col = 1),
#     planted = list(type = "measured", row = c(7,18), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,18), col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = c(7,18), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "Greenonionwin",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_Greenonionwin,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Lettucewin <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = c(7,17), col = 1),
#     planted = list(type = "measured", row = c(7,17), col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = c(7,17), col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = c(7,17), col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "Lettucewin",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_Lettucewin,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Lintilswin <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 7, col = 1),
#     planted = list(type = "measured", row = 7, col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = 7, col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = 7, col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "Lintilswin",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_Lintilswin,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_PeasGreenwin <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 7:8, col = 1),
#     planted = list(type = "measured", row = 7:8, col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = 7:8, col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = 7:8, col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "PeasGreenwin",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_PeasGreenwin,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_PistachioSumm <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 7:9, col = 1),
#     planted = list(type = "measured", row = 7:9, col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = 7:9, col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = 7:9, col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "PistachioSumm",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_PistachioSumm,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_SummSorghumSeed <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 7:14, col = 1),
#     planted = list(type = "measured", row = 7:14, col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = 7:14, col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = 7:14, col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "SummSorghumSeed",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_SummSorghumSeed,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Spinachwin <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 7:17, col = 1),
#     planted = list(type = "measured", row = 7:17, col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = 7:17, col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = 7:17, col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "Spinachwin",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_Spinachwin,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_SquashAcum <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 7:19, col = 1),
#     planted = list(type = "measured", row = 7:19, col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = 7:19, col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = 7:19, col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "SquashAcum",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_SquashAcum,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_strawberrywin <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 7, col = 1),
#     planted = list(type = "measured", row = 7, col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = 7, col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = 7, col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "strawberrywin",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_strawberrywin,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CoveredTomatowin <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 7:17, col = 1),
#     planted = list(type = "measured", row = 7:17, col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = 7:17, col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = 7:17, col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "CoveredTomatowin",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_CoveredTomatowin,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Tomatosumm <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 7:19, col = 1),
#     planted = list(type = "measured", row = 7:19, col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = 7:19, col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = 7:19, col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "Tomatosumm",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_Tomatosumm,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_TomatoAcum <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 7:19, col = 1),
#     planted = list(type = "measured", row = 7:19, col = 5, unit = "ha", factor = 0.1, rel = TRUERUE),
#     yield = list(type = "measured", row = 7:19, col = 3, unit = "t/ha", factor = 0.011, rel = TRUE),
#     production = list(type = "measured", row = 7:19, col = 2 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "TomatoAcum",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2018,
#          end = 2018,
#          schema = Schema_TomatoAcum,
#          archive = "Secondary crops and vegetables production report 2018.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CottYelCornPotato <- makeSchema(schema = list(
#   clusters =
#     list(row = 2, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al1 = list(type = "id", value = "Iraq"),
#     year = list(type = "id", row = 3:20, col = 2, rel = TRUEALSE),
#     commodities = list(type = "id", row = 2, col = 3:5, rel = TRUEALSE),
#     planted = list(type = "measured", row = 3:8, col = 3:5, unit = "ha", factor = 10, rel = FALSERUE),
#     yield = list(type = "measured", row = 15:20, col = 3:5, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 9:14, col = 3:5 unit = "t", factor = 100)
#   )))
# regTable(nation = "Iraq",
#          level = 1,
#          subset = "CottYelCornPotato",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2014,
#          end = 2019,
#          schema = Schema_CottYelCornPotato,
#          archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CottYelCornPotato <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al1 = list(type = "id", value = "Iraq"),
#     commodities = list(type = "id", row = 4:6, col = 9),
#     planted = list(type = "measured", row = 4:6, col = 2, unit = "ha", factor = 10, rel = FALSERUE),
#     Harvested = list(type = "measured", row = 4:6, col = 3, unit = "ha", factor = 10, rel = FALSERUE),
#     yield = list(type = "measured", row = 4:6, col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4:6, col = 6 unit = "t", factor = 100)
#   )))
# regTable(nation = "Iraq",
#          level = 1,
#          subset = "CottYelCornPotato",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_CottYelCornPotato,
#          archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CottonPrivSec <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 4, col = 9),
#     planted = list(type = "measured", row = 4, col = 2, unit = "ha", factor = 10, rel = FALSERUE),
#     Harvested = list(type = "measured", row = 4, col = 3, unit = "ha", factor = 10, rel = FALSERUE),
#     yield = list(type = "measured", row = 4, col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4, col = 6 unit = "t", factor = 100)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "CottonPrivSec",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_CottonPrivSec,
#          archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CultiYelCornAutumnPrivSec <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 5:19, col = 9),
#     planted = list(type = "measured", row = 5:19, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#     Harvested = list(type = "measured", row =5:19, col = 3, unit = "ha", factor = 10, rel = FALSERUE),
#     yield = list(type = "measured", row = 5:19, col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 5:19, col = 6 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "CultiYelCornAutumnPrivSec",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_CultiYelCornAutumnPrivSec,
#          archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CultiYelCornAutumnPrivSecspr <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 2:5, col = 9),
#     planted = list(type = "measured", row = 4:5, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#     Harvested = list(type = "measured", row =4:5, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#     yield = list(type = "measured", row = 4:5, col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4:5, col = 6 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "CultiYelCornAutumnPrivSecSpr",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_CultiYelCornAutumnPrivSecspr,
#          archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CultiPotatoAutumPrivSec <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 4:11, col = 9),
#     planted = list(type = "measured", row = 4:11, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#     Harvested = list(type = "measured", row =4:11, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#     yield = list(type = "measured", row = 4:11, col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4:11, col = 6 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "CultiPotatoAutumPrivSec",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_CultiPotatoAutumPrivSec,
#          archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CultiPotatoSpringPrivSec <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 4:14, col = 9),
#     planted = list(type = "measured", row = 4:14, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#     Harvested = list(type = "measured", row = 4:14, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#     yield = list(type = "measured", row = 4:14, col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4:14, col = 6 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "CultiPotatoSpringPrivSec",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_CultiPotatoSpringPrivSec,
#          archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_CultiMaizeSpriAutu <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 1),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 4:18, col = 9),
#     planted = list(type = "measured", row = 4:18, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#     Harvested = list(type = "measured", row = 4:18, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#     yield = list(type = "measured", row = 4:18, col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4:18, col = 6 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "CultiMaizeSpriAutu",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_CultiMaizeSpriAutu,
#          archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_BarleyIrrMethodPriv <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 2, id = "commodities"),
#   header = list(row = 1),
#   meta = list(del = "."),
#   variables = list(
#     al1 = list(type = "id", value = "Iraq"),
#     planted = list(type = "measured", row = 4:5, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#     Harvested = list(type = "measured", row = 4:5, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#     yield = list(type = "measured", row = 4:5, col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4:5, col = 6 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 1,
#          subset = "BarleyIrrMethodPriv",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_BarleyIrrMethodPriv,
#          archive = "تقرير الحنطة والشعير لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_WheatIrrMethodPriv <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 2, id = "commodities"),
#   header = list(row = 1),
#   meta = list(del = "."),
#   variables = list(
#     al1 = list(type = "id", value = "Iraq"),
#     planted = list(type = "measured", row = 4:5, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#     Harvested = list(type = "measured", row = 4:5, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#     yield = list(type = "measured", row = 4:5, col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4:5, col = 6 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 1,
#          subset = "WheatIrrMethodPriv",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_WheatIrrMethodPriv,
#          archive = "تقرير الحنطة والشعير لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_BarleyrainfedPriv <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 2, id = "commodities"),
#   header = list(row = 1),
#   meta = list(del = "."),
#   variables = list(
#     al1 = list(type = "id", value = "Iraq"),
#     planted = list(type = "measured", row = 4:6, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#     Harvested = list(type = "measured", row = 4:6, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#     yield = list(type = "measured", row = 4:6, col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4:6, col = 6 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 1,
#          subset = "BarleyrainfedPriv",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_BarleyrainfedPriv,
#          archive = "تقرير الحنطة والشعير لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_WheatrainfedPriv <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 2, id = "commodities"),
#   header = list(row = 1),
#   meta = list(del = "."),
#   variables = list(
#     al1 = list(type = "id", value = "Iraq"),
#     planted = list(type = "measured", row = 4:6, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#     Harvested = list(type = "measured", row = 4:6, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#     yield = list(type = "measured", row = 4:6, col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4:6, col = 6 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 1,
#          subset = "WheatrainfedPriv",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_WheatrainfedPriv,
#          archive = "تقرير الحنطة والشعير لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_BarleyrainfedPriv <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = "."),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 4:11, col = 9),
#     planted = list(type = "measured", row = 4:11, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#     Harvested =
#       list(type = "measured", row = 4:11, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#     yield = list(type = "measured", row = 4:11, col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4:11, col = 6 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "BarleyrainfedPriv",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_BarleyrainfedPriv,
#          archive = "تقرير الحنطة والشعير لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_BarleyIrriPriv <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = "."),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 4:18, col = 9),
#     planted = list(type = "measured", row = 4:18, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#     Harvested =
#       list(type = "measured", row = 4:18, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#     yield = list(type = "measured", row = 4:18, col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4:18, col = 6 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "BarleyIrriPriv",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_BarleyIrriPriv,
#          archive = "تقرير الحنطة والشعير لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Barley <- makeSchema(schema = list(
#   clusters =
#     list(row = 2, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = "."),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 4:18, col = 10),
#     planted = list(type = "measured", row = 4:18, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#     Harvested =
#       list(type = "measured", row = 4:18, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#     yield = list(type = "measured", row = 4:18, col = 9, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4:18, col = 6 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "Barley",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_Barley,
#          archive = "تقرير الحنطة والشعير لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_WheatRainfed <- makeSchema(schema = list(
#   clusters =
#     list(row = 2, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = "."),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 4:12, col = 8),
#     planted = list(type = "measured", row = 4:12, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#     Harvested =
#       list(type = "measured", row = 4:12, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#     yield = list(type = "measured", row = 4:12, col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4:12, col = 5 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "WheatRainfed",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_WheatRainfed,
#          archive = "تقرير الحنطة والشعير لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_Wheat <- makeSchema(schema = list(
#   clusters =
#     list(row = 2, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = "."),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 4:18, col = 9),
#     planted = list(type = "measured", row = 4:18, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#     Harvested =
#       list(type = "measured", row = 4:18, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#     yield = list(type = "measured", row = 4:18, col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4:18, col = 5 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "Wheat",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_Wheat,
#          archive = "تقرير الحنطة والشعير لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_BarleyRainfedPriv <- makeSchema(schema = list(
#   clusters =
#     list(row = 2, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = "."),
#   variables = list(
#     al2 = list(type = "id", value = "Iraq"),
#     govern = list(type = "id", row = 4:11, col = 9),
#     planted = list(type = "measured", row = 4:11, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#     Harvested =
#       list(type = "measured", row = 4:11, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#     yield = list(type = "measured", row = 4:11, col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#     production = list(type = "measured", row = 4:11, col = 6 unit = "t", factor = 1)
#   )))
# regTable(nation = "Iraq",
#          level = 2,
#          subset = "BarleyRainfedPriv",
#          dSeries = "cso Iraq",
#          gSeries = "cso Iraq",
#          begin = 2019,
#          end = 2019,
#          schema = Schema_BarleyRainfedPriv,
#          archive = "تقرير الحنطة والشعير لسنة 2019.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# Schema_bitterOrange19 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1,   # problem id = "commodities"),
#          header = list(row = 2),
#          variables = list(
#            al2 = list(type = "id", value = "Iraq"),
#            govern = list(type = "id", row = 5:12, col = 6),
#            treecount = list(type = "measured", row = c(5:12), col = 2, unit = "tree"),
#            yield_tree = list(type = "measured", row = c(5:12), col = 3, unit = "kg", factor = 1),
#            production = list(type = "measured", row = c(5:12), col = 4 unit = "t", factor = 1)
#          )))
#   regTable(nation = "Iraq",
#            level = 2,
#            subset = " bitterOrange",
#            dSeries = "cso Iraq",
#            gSeries = "cso Iraq",
#            begin = 2019,
#            end = 2019,
#            schema = Schema_bitterOrange19,
#            archive = "Citrus trees report for the year 2019.pdf",
#            archiveLink = "unknown",
#            updateFrequency = "notPlanned",
#            metadataLink = "unknown",
#            metadataPath = "unknown",
#            update = TRUE)
#
#   Schema_Citrus18 <- makeSchema(schema = list(
#     clusters =
#       list(row = 4, col = 1,   # problem id = "commodities"),
#            header = list(row = 2),
#            variables = list(
#              al1 =
#                list(type = "id", value = "Iraq"),
#              year = list(type = "id", row = 5, rel = TRUEALSE),
#              commodities = list(type = "id", row = 6:10, col = 9),
#              treecount = list(type = "measured", row = c(6:10), col = 2, unit = "tree"),
#              yield_tree = list(type = "measured", row = c(6:10), col = 4, unit = "kg", factor = 1),
#              production = list(type = "measured", row = c(6:10), col = 6 unit = "t", factor = 1)
#            )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = " Citrus",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2018,
#              schema = Schema_Citrus18,
#              archive = "Citrus trees report for the year 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Mandarin19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 2),
#       variables = list(
#         al2 = list(type = "id", value = "Iraq"),
#         govern = list(type = "id", row = 4:9, col = 6),
#         treecount = list(type = "measured", row = c(4:9), col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", row = c(4:9), col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", row = c(4:9), col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = " Mandarin",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_Mandarin19,
#              archive = "Citrus trees report for the year 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_SweetLemon19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 4),
#       variables = list(
#         al2 = list(type = "id", value = "Iraq"),
#         govern = list(type = "id", row = 5:9, col = 6),
#         treecount = list(type = "measured", row = c(5:9), col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", row = c(5:9), col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", row = c(5:9), col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = " SweetLemon19",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_SweetLemon19,
#              archive = "Citrus trees report for the year 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_SourLemon19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 4),
#       variables = list(
#         al2 = list(type = "id", value = "Iraq"),
#         govern = list(type = "id", row = 5:9, col = 6),
#         treecount = list(type = "measured", row = c(5:9), col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", row = c(5:9), col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", row = c(5:9), col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = " SourLemon19",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_SourLemon19,
#              archive = "Citrus trees report for the year 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Orange19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 4),
#       variables = list(
#         al2 = list(type = "id", value = "Iraq"),
#         govern = list(type = "id", row = 5:12, col = 6),
#         treecount = list(type = "measured", row = c(5:12), col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", row = c(5:12), col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", row = c(5:12), col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = " Orange19",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_Orange19,
#              archive = "Citrus trees report for the year 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Plam19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "al2"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", col = 12),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Plam",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_Plam19,
#              archive = "تقرير انتاج التمور 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamProdution19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:7),
#       variables = list(
#         al2 = list(type = "id", col = 10),
#         commodities = list(type = "id", row = 6, col = 2:8),
#         production = list(type = "measured", col = 2:8 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamProdution",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_PlamProdution19,
#              archive = "تقرير انتاج التمور 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_AverPro19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:7),
#       variables = list(
#         al2 = list(type = "id", col = 10),
#         commodities = list(type = "id", row = 6, col = c(2:8)ALSE),
#         yield_tree = list(type = "measured", col = c(2:8), unit = "kg", factor = 1),
#         production = list(type = "measured" unit = "t", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Average productivity",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_AverPro19,
#              archive = "تقرير انتاج التمور 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Palms_kind19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:7),
#       variables = list(
#         al2 = list(type = "id", row = 4),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PalmsDiala",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_Palms_kind19,
#              archive = "تقرير انتاج التمور 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PalmsAlanbar19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PalmsAlanbar",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_PalmsAlanbar19,
#              archive = "تقرير انتاج التمور 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PalmsPalmsBaghdad19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PalmsBaghdad",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_PalmsPalmsBaghdad19,
#              archive = "تقرير انتاج التمور 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PalmsBabylon19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PalmsBabylon",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_PalmsBabylon19,
#              archive = "تقرير انتاج التمور 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PalmsKerbela19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PalmsKerbela",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_PalmsKerbela19,
#              archive = "تقرير انتاج التمور 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PalmsWsit19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PalmsWasit",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_PalmsWsit19,
#              archive = "تقرير انتاج التمور 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PalmsSlahAldeen19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 14),
#         treecount = list(type = "measured", col = 5, unit = "tree"),
#         prodectree = list(type = "measured", col = 9, unit = "tree"),
#         yield_tree = list(type = "measured", col = 11, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 13 unit = "t", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PalmsSlahAldeen",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_PalmsSlahAldeen19,
#              archive = "تقرير انتاج التمور 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PalmsNajaf19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PalmsNajaf",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_PalmsNajaf19,
#              archive = "تقرير انتاج التمور 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PalmsALqadisiya19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PalmsALqadisiya",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_PalmsALqadisiya19,
#              archive = "تقرير انتاج التمور 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Palms19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", col = 12),
#         commodities = list(type = "id", row = 2),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Palms",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_Palms19,
#              archive = "تقرير انتاج التمور 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PalmsProduction19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:7),
#       variables = list(
#         al2 = list(type = "id", col = 10),
#         commodities = list(type = "id", row = 7),
#         production = list(type = "measured", col = 2:8 unit = "t", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PalmsProduction",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_PalmsProduction19,
#              archive = "تقرير انتاج التمور 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PalmsYield19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       variables = list(
#         al2 = list(type = "id", col = 10),
#         commodities = list(type = "id", row = 6),
#         yield_tree = list(type = "measured", col = 2:8, unit = "kg", factor = 1),
#         production = list(type = "measured" unit = "t", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PalmsYield",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_PalmsYield19,
#              archive = "تقرير انتاج التمور 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_peach19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:7),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "peach",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_peach19,
#              archive = "تقرير انتاج اشجار الفواكه الصيفية لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Olive19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Olive",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_Olive19,
#              archive = "تقرير انتاج اشجار الفواكه الصيفية لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Plum19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:7),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 2),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Plum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_Plum19,
#              archive = "تقرير انتاج اشجار الفواكه الصيفية لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_greengage19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "greengage",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_greengage19,
#              archive = "تقرير انتاج اشجار الفواكه الصيفية لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Pear19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:7),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 2),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Pear",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_Pear19,
#              archive = "تقرير انتاج اشجار الفواكه الصيفية لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Fig19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Fig",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_Fig19,
#              archive = "تقرير انتاج اشجار الفواكه الصيفية لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Apple19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:7),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 2),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Apple",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_Apple19,
#              archive = "تقرير انتاج اشجار الفواكه الصيفية لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Apicot19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Apicot",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_Apicot19,
#              archive = "تقرير انتاج اشجار الفواكه الصيفية لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Grape19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:9),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 4),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Grape",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_Grape19,
#              archive = "تقرير انتاج اشجار الفواكه الصيفية لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_pomegranate19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "pomegranate",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_pomegranate19,
#              archive = "تقرير انتاج اشجار الفواكه الصيفية لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_fruitful_treesSummer19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 6, col = 1,   id = "commodities"),
#       header = list(row = 6:11),
#       variables = list(
#         al1 = list(type = "id"),
#         commodities = list(type = "id", col = 15ALSE),
#         treecount = list(type = "measured", col = 2:4, unit = "tree"),
#         yield_tree = list(type = "measured", col = 5:7, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 8:10 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "fruitfulTreesSummer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_fruitful_treesSummer19,
#              archive = "تقرير انتاج اشجار الفواكه الصيفية لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PaddyPriv19 <- makeSchema(schema = list(
#       clusters =
#         list(row =3, col = 1, id = "commodities"),
#       header = list(row = 3:5),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 5 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PaddyPriv19",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_PaddyPriv19,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_SunflowerAutumn19 <- makeSchema(schema = list(
#       clusters =
#         list(row =3, col = 1, id = "commodities"),
#       header = list(row = 3:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "SunflowerAutumn",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_SunflowerAutumn19,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = FALSE)
#
#     Schema_paddySunflower19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 4:5ALSE),
#         year = list(type = "id", col = 3ALSE),
#         planted = list(type = "measured", row = c(6:11), col = 4:5, unit = "ha", factor = 10, rel = FALSE),
#         yield = list(type = "measured", row = c(18:23), col = 4:5, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(12:17), col = 4:5 unit = "t", factor = 100)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "paddy and sunflower",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2014,
#              end = 2019,
#              schema = Schema_paddySunflower19,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_paddySunflower19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:5),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col =3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row =NULL, col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "paddy and sunflower",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_paddySunflower19,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_paddyHay19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:6),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 7, col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col =2, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row =NULL, col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "paddy hay Priv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2019,
#              end = 2019,
#              schema = Schema_paddyHay19,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2019.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_BarleyIrriMtehod18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:6),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 1, col = 1),
#         Irrigation = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col =3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row =NULL, col = 7, unit = "FALSE/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "BarleyIrriMtehod ",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_BarleyIrriMtehod18,
#              archive = "تقرير الحنطة والشعير لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Barley18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:6),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         commodities = list(type = "id", row =2, col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col =3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row =NULL, col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Barley",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Barley18,
#              archive = "تقرير الحنطة والشعير لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_BarleyRainfed18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:6),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         commodities = list(type = "id", row =2, col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col =3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row =NULL, col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Barley rainfed",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_BarleyRainfed18,
#              archive = "تقرير الحنطة والشعير لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_BarleyIrriPriv18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:6),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         commodities = list(type = "id", row =2, col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col =3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row =NULL, col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Barley IrriPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_BarleyIrriPriv18,
#              archive = "تقرير الحنطة والشعير لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_BarleyHay18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 1, col = 1),
#         planted = list(type = "measured", unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col =2, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row =NULL, col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "BarleyHay",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_BarleyHay18,
#              archive = "تقرير الحنطة والشعير لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_BarleyBarleyIrriMthd18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:5),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         Irrigation = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row =NULL, col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "BarleyIrriMthd",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_BarleyBarleyIrriMthd18,
#              archive = "تقرير الحنطة والشعير لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_WheatAndBarley18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 4, col = c(3,5)ALSE),
#         year = list(type = "id", col = 2),
#         planted = list(type = "measured", row = 6:11, col = c(3,5), unit = "ha", factor = 100, rel = FALSE),
#         harvested = list(type = "measured", unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = 18:23, col = c(3,5), unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 12:17, col = c(3,5) unit = "t", factor = 1000)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "WheatAndBarley",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2013,
#              end = 2018,
#              schema = Schema_WheatAndBarley18,
#              archive = "تقرير الحنطة والشعير لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_CottonPriv18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         commodities = list(type = "id", row = 1, col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "CottonPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_CottonPriv18,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_YellowcornAutumnPriv18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, width = 8, height = 14,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         commodities = list(type = "id", row = 1, col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "YellowcornAutumnPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_YellowcornAutumnPriv18,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_YellowcorSprAutumPriv18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, width = 9, height = 14,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al2 = list(type = "id", col = 9),
#         commodities = list(type = "id", row = 1, col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "YellowCorSprindAndAutumnPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_YellowcorSprAutumPriv18,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_YellowCorSpringPriv18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, width = 9, height = 14,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al2 = list(type = "id", col = 9),
#         commodities = list(type = "id", row = 1, col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "YellowCorSpringPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_YellowCorSpringPriv18,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_CottonYellowCorPotatPriv18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, width = 9, height = 6,   id = "commodities"),
#       header = list(row = 3:5),
#       variables = list(
#         al1 = list(type ="id", value = "Iraq"),
#         commodities = list(type = "id", col = 9),
#         year = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "CottonYellowCorPotatPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_CottonYellowCorPotatPriv18,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     SchemaCottonYellowCorPotatPri18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 4, col = c(3:5)ALSE),
#         year = list(type = "id", col = 2),
#         planted = list(type = "measured", row = 6:11, col = c(3:5), unit = "ha", factor = 10, rel = FALSE),
#         harvested = list(type = "measured", unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = 18:23, col = c(3:5), unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 12:17, col = c(3:5) unit = "t", factor = 100)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "CottonYellowCorPotatPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2013,
#              end = 2018,
#              schema = SchemaCottonYellowCorPotatPri18,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_CottonYelloCorPotatPriv18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:10),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 9),
#         year = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "CottonYelloCorPotatPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_CottonYelloCorPotatPriv18,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_paddyandSunflower18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 4, col = c(3:4)ALSE),
#         year = list(type = "id", col = 2),
#         planted = list(type = "measured", row = 5:10, col = c(3:4), unit = "ha", factor = 10, rel = FALSE),
#         harvested = list(type = "measured", unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = 17:22, col = c(3:4), unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 11:16, col = c(3:4) unit = "t", factor = 100)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "paddy and sunflower",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2013,
#              end = 2018,
#              schema = Schema_paddyandSunflower18,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_paddyHayPrivate18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 5, col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row = 5, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = 5, col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 5, col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "paddy hay priv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_paddyHayPrivate18,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_paddyAndSunflorPriv18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:5),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 6:7, col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row = 6:7, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", row = 6:7, col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = 6:7, col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 6:7, col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "paddy and SunflorPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_paddyAndSunflorPriv18,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PaddyPriv18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:5),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         commodities = list(type = "id", row = 1, col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PaddyPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PaddyPriv18,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Forage18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:10),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 9),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         Productive = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldProductive = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Forage crops18",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Forage18,
#              archive = "crops and vegetables for the year 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_WheatIrrMethod18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:5),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         planted = list(type = "measured", row = 7:8, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         Harvested = list(type = "measured", row = 7:8, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#         yieldPlanted = list(type = "measured", row = 7:6, col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldProductive = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row =7:8, col = 5 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "WheatIrrMethod",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_WheatIrrMethod18,
#              archive = "تقرير الحنطة والشعير لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Wheat18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:5),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", row = 7:8, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         Harvested = list(type = "measured", row = 7:8, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#         yieldPlanted = list(type = "measured", row = 7:6, col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldProductive = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row =7:8, col = 5 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Wheat",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Wheat18,
#              archive = "تقرير الحنطة والشعير لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Wheatrainfed18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:5),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", row = 7:8, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         Harvested = list(type = "measured", row = 7:8, col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#         yieldPlanted = list(type = "measured", row = 7:6, col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldProductive = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row =7:8, col = 5 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Wheat rainfed",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Wheatrainfed18,
#              archive = "تقرير الحنطة والشعير لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_WheatHay18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1, id = "commodities"),
#       header = list(row = 5),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         planted = list(type = "measured", row = 7, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         Harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#         yield = list(type = "measured", row = 7, col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row =7, col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Wheat Hay",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_WheatHay18,
#              archive = "تقرير الحنطة والشعير لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_WheatHay18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row =4:6),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         irrigation = list(type = "id", col = 8),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         Harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSERUE),
#         yieldPlanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldProductive = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "WheatIrriMthd",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_WheatHay18,
#              archive = "تقرير الحنطة والشعير لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PotatoAutumPriv18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:7),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         commodities = list(type = "id", col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PotatoAutumPriv18",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PotatoAutumPriv18,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PotatSprAutuPriv18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 4:6),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         commodities = list(type = "id", col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PotatoSprngAutumPriv18",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PotatSprAutuPriv18,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PotatSprAutuPriv18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:6),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         commodities = list(type = "id", col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PotatoSprngAutumPriv18",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PotatSprAutuPriv18,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_SunflowautmnPriv18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:7),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         commodities = list(type = "id", col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "SunflowerAutmnPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_SunflowautmnPriv18,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_WheatIrri18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:5),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         commodities = list(type = "id", row = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 5 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "WheatIrri",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_WheatIrri18,
#              archive = "تقرير الحنطة والشعير لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_seeds18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 2,   id = "commodities"),
#       header = list(row = 3:8),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 9),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         Productive = list(type = "measured", col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldProductive = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 9 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Seeds",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_seeds18,
#              archive = "crops and vegetables for the year 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_OilCrops18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:9),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 10:12, col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row = 10:12, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", row = 10:12, col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", row = 10:12, col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldProductive = list(type = "measured", row = 10:12, col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 10:12, col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "OilCrops",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_OilCrops18,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Bulbandtuble18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:9),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 9),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         Productive = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldProductive = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Bulbs and tublers",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Bulbandtuble18,
#              archive = "crops and vegetables for the year 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_VegetablesNati18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:10),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 9),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         Productive = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldProductive = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Vegetables",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_VegetablesNati18,
#              archive = "crops and vegetables for the year 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_WatermelonAcum18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:7),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldProductive = list(type = "measured", col = 4, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(3:10), col = 2 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "WatermelonAcum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_WatermelonAcum18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_CropUndVeg <- makeSchema(schema = list(
#       clusters =
#         list(row =6, col = 1, id = "commodities"),
#       header = list(row = 6:8),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         planted = list(type = "measured", col = c(2,4,6,8,10), unit = "ha", factor = 0.1, rel = FALSE),
#         production = list(type = "measured", col = c(3,5,7,9,11) unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "CropUndVeg",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2014,
#              end = 2018,
#              schema = Schema_CropUndVeg,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_AcumPepper18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 3),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", row = c(4:16), col = 1),
#         planted = list(type = "measured", row = c(4:16), col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = c(4:16), col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(4:16), col = 2 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "AcumPepper19",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_AcumPepper18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_sweetPeppersumm18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 3),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", value = "Iraq"),
#         govern = list(type = "id", row = c(4:16), col = 1),
#         planted = list(type = "measured", row = c(4:16), col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = c(4:16), col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(4:16), col = 2 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "SweetPeppersumm",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_sweetPeppersumm18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_AccuGreStringPean18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", value = "Iraq"),
#         govern = list(type = "id", row = c(7:20), col = 1),
#         planted = list(type = "measured", row = c(7:20), col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = c(7:20), col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(7:20), col = 2 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "AccuGreenStringPeans",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_AccuGreStringPean18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_OkraAcu18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", value = "Iraq"),
#         govern = list(type = "id", row = c(7:20), col = 1),
#         planted = list(type = "measured", row = c(7:20), col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = c(7:20), col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(7:20), col = 2 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "OkraAcu18",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_OkraAcu18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_OkraSummer18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", value = "Iraq"),
#         govern = list(type = "id", row = c(7:20), col = 1),
#         planted = list(type = "measured", row = c(7:20), col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = c(7:20), col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(7:20), col = 2 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "OkraSummer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_OkraSummer18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_GreenCowpea18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:7),
#       meta = list(del = "."),
#       variables = list(
#         commodities = list(type = "id", row = 1),
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "GreenCowpea",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_GreenCowpea18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Oatswinter18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:7),
#       meta = list(del = "."),
#       variables = list(
#         commodities = list(type = "id", row = 1),
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Oatswinter",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Oatswinter18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_OnionAcumilative18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:7),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = c(3:10), col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(3:10), col = 2 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "OnionAcumilative",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_OnionAcumilative18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_DryOnionSummer18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:7),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = c(3:10), col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(3:10), col = 2 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "DryOnionSummer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_DryOnionSummer18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_BoilerOnionSummer18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:7),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = c(3:10), col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(3:10), col = 2 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "BoilerOnionSummer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_BoilerOnionSummer18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_DryOnionwinter18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:7),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = c(3:10), col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(3:10), col = 2 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "DryOnionwinter",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_DryOnionwinter18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_BoilerOnionwin18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:7),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = c(3:10), col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(3:10), col = 2 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = " BoilerOnionwinter",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_BoilerOnionwin18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Tumbakwinter18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:7),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = c(3:10), col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(3:10), col = 2 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Tumbakwinter",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Tumbakwinter18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_WatermelonSeed18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:7),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = c(3:10), col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(3:10), col = 2 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "WatermelonSeed",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_WatermelonSeed18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_WatermelonSumm18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:7),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = c(3:10), col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(3:10), col = 2 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "WatermelonSumm",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_WatermelonSumm18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_WatermelonWin18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:7),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = c(3:10), col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = c(3:10), col = 2 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "WatermelonWin",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_WatermelonWin18,
#              archive = "Secondary crops and vegetables production report 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Plam18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:7),
#       variables = list(
#         al1 = list(type = "id"),
#         commodities = list(type = "id", col = 12),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Plams",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Plam18,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Plam18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:7),
#       variables = list(
#         al1 = list(type = "id"),
#         commodities = list(type = "id", col = 1),
#         year = list(type = "id", col = 2),
#         prodectree = list(type = "measured", col = 5, unit = "tree"),
#         yield_tree = list(type = "measured", col = 6, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 3 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "PlamsProduction",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2014,
#              end = 2018,
#              schema = Schema_Plam18,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsALMuthana18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:8),
#       variables = list(
#         al2 = list(type = "id", row = 4),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsALMuthana",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PlamsALMuthana18,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsALNajaf18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:8),
#       variables = list(
#         al2 = list(type = "id", row = 4),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsALNajaf",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PlamsALNajaf18,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsALQadisiya18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:8),
#       variables = list(
#         al2 = list(type = "id", row = 4),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsALQadisiya",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PlamsALQadisiya18,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsBasrah18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:8),
#       variables = list(
#         al2 = list(type = "id", row = 4),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsBasrah",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PlamsBasrah18,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsMysan18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:8),
#       variables = list(
#         al2 = list(type = "id", row = 4),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsMysan",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PlamsMysan18,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Plams18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:8),
#       variables = list(
#         al2 = list(type = "id", col = 12),
#         commodities = list(type = "id", row = 2),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Plams",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Plams18,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsBabylon18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:8),
#       variables = list(
#         al2 = list(type = "id", row = 4),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsBabylon",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PlamsBabylon18,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsBaghdad18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:8),
#       variables = list(
#         al2 = list(type = "id", row = 4),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsBaghdad",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PlamsBaghdad18,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsDiala18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:8),
#       variables = list(
#         al2 = list(type = "id", row = 4),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsDiala",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PlamsDiala18,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#
#     Schema_PlamsKerbela18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:8),
#       variables = list(
#         al2 = list(type = "id", row = 4),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsKerbela",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PlamsKerbela18,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsWasit18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:8),
#       variables = list(
#         al2 = list(type = "id", row = 4),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsWasit",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PlamsWasit18,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsThiQar18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:8),
#       variables = list(
#         al2 = list(type = "id", row = 4),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsThiQar",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PlamsThiQar18,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PalmsProduction19 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:7),
#       variables = list(
#         al2 = list(type = "id", col = 10),
#         commodities = list(type = "id", row = 7),
#         production = list(type = "measured", col = 2:8 unit = "t", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PalmsProduction",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PalmsProduction19,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsYield18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:6),
#       variables = list(
#         al2 = list(type = "id", col = 10),
#         commodities =
#           list(type = "id", row = 6),
#         yield_tree = list(type = "measured", col = 2:8, unit = "kg", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsYield",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_PlamsYield18,
#              archive = "تقرير انتاج التمور 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Peach18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:7),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 2),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Peach",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Peach18,
#              archive = "SummerFruitTreeProduction 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Apple18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:7),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 2),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Apple",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Apple18,
#              archive = "SummerFruitTreeProduction 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Olive18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 2),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Olive",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Olive18,
#              archive = "SummerFruitTreeProduction 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_plum18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 3:7),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 2),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "plum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_plum18,
#              archive = "SummerFruitTreeProduction 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_greengage18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "greengage",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_greengage18,
#              archive = "SummerFruitTreeProduction 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Fig18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Fig",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Fig18,
#              archive = "SummerFruitTreeProduction 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Pear18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Pear",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Pear18,
#              archive = "SummerFruitTreeProduction 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Apicot18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Apicot",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Apicot18,
#              archive = "SummerFruitTreeProduction 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_pomegranate18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "pomegranate",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_pomegranate18,
#              archive = "SummerFruitTreeProduction 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Grape18 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:9),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 4),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Grape",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2018,
#              end = 2018,
#              schema = Schema_Grape18,
#              archive = "SummerFruitTreeProduction 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Grape18 <- makeSchema(schema = list(
#       clusters =
#         list(row =7, col = 1,   id = "commodities"),
#       header = list(row = 7:11),
#       variables = list(
#         al1 = list(type = "id"),
#         commodities = list(type = "id", col = 11),
#         year = list(type = "id", row = 12, col = c(3:8)ALSE),
#         treecount = list(type = "measured", col = 3:4 , unit = "tree"),
#         yield_tree = list(type = "measured", col = 5:6, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 7:8 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Grape",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2018,
#              schema = Schema_Grape18,
#              archive = "SummerFruitTreeProduction 2018.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_BulbsTubers17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 3:5, col = 1),
#         planted = list(type = "measured", row = 3:5, col = 2, unit = "ha", factor = 10, rel = FALSERUE),
#         yield = list(type = "measured", row = 3:5, col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 3:5, col = 8 unit = "t", factor = 100)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = " Bulbs and tubers",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_BulbsTubers17,
#              archive = "crops and vegetables for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_VegNational17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 3:24, col = 9),
#         planted = list(type = "measured", row = 3:24, col = 2, unit = "ha", factor = 10, rel = FALSERUE),
#         yield = list(type = "measured", row = 3:24, col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 3:24, col = 8 unit = "t", factor = 100)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Vegetables National",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_VegNational17,
#              archive = "crops and vegetables for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_CropsVegNational <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 5),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 6:13, col = 13),
#         year = list(type = "id", row = 4, col = c(2,4,6,8,10)ALSE),
#         planted = list(type = "measured", row = 6:13, col = c(2,4,6,8,10), unit = "ha", factor = 10),
#         production = list(type = "measured", row = 6:13, col = c(3,5,7,9,11) unit = "t", factor = 100)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "CropsVegNational",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2013,
#              end = 2017,
#              schema = Schema_CropsVegNational,
#              archive = "crops and vegetables for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Sweetlimon17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2),
#       variables = list(
#         al2 = list(type = "id", row = 3:6, col = 1),
#         treecount = list(type = "measured", row = 3:6, col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", row = 3:6, col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", row = 3:6, col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = " Sweetlimon",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_Sweetlimon17,
#              archive = "Citrus trees report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_IndustCropNational <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:3),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 2:4, col = 1),
#         planted = list(type = "measured", row = 4:6, col = 2, unit = "ha", factor = 0.1),
#         yield = list(type = "measured", row = 4:6, col = 6, unit = "kg", factor = 0.011),
#         production = list(type = "measured", row = 4:6, col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "IndustCrops",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_IndustCropNational,
#              archive = "crops and vegetables for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_SouerLimon17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2),
#       variables = list(
#         al2 = list(type = "id", value = "Iraq"),
#         govern = list(type = "id", row = 3:9, col = 1),
#         treecount = list(type = "measured", row = 3:9, col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", row = 3:9, col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", row = 3:9, col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = " SouerLimon",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_SouerLimon17,
#              archive = "Citrus trees report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Orange17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2),
#       variables = list(
#         al2 = list(type = "id", value = "Iraq"),
#         govern = list(type = "id", row = 3:9, col = 1),
#         treecount = list(type = "measured", row = 3:9, col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", row = 3:9, col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", row = 3:9, col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = " Orange",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_Orange17,
#              archive = "Citrus trees report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Mandarin17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2),
#       variables = list(
#         al2 = list(type = "id", value = "Iraq"),
#         govern = list(type = "id", row = 3:9, col = 1),
#         treecount = list(type = "measured", row = 3:9, col = 2, unit = "tree"),
#         yield_tree = list(type = "measured", row = 3:9, col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", row = 3:9, col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Mandarin",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_Mandarin17,
#              archive = "Citrus trees report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_CirusNational17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 4:8, col = 1),
#         year = list(type = "id", row = 3, col = c(2:7)ALSE),
#         treecount = list(type = "measured", row = 4:8, col = c(2,3), unit = "tree"),
#         yield_tree = list(type = "measured", row = 4:8, col = c(4:5), unit = "kg", factor = 1),
#         production = list(type = "measured", row = 4:8, col = c(6,7) unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "CirusNational",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2017,
#              schema = Schema_CirusNational17,
#              archive = "Citrus trees report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_SeedsNational17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 3:5, col = 1),
#         planted = list(type = "measured", row = 3:5, col = 2, unit = "ha", factor = 0.1, rel = FALSERUE),
#         yield = list(type = "measured", row = 3:5, col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 3:5, col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "SeedsNational",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_SeedsNational17,
#              archive = "crops and vegetables for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PastureNational17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 3:9, col = 9),
#         planted = list(type = "measured", row = 3:9, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = 3:9, col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 3:9, col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "PastureNational",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_PastureNational17,
#              archive = "crops and vegetables for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_LegumesNational17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 3:6, col = 1),
#         planted = list(type = "measured", row = 3:6, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = 3:6, col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 3:6, col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "LegumesNational",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_LegumesNational17,
#              archive = "crops and vegetables for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_induscropsNational17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 3:5, col = 1),
#         planted = list(type = "measured", row = 3:5, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = 3:5, col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 3:5, col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "induscropsNational",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_induscropsNational17,
#              archive = "crops and vegetables for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_CerealsNational17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 3:6, col = 1),
#         planted = list(type = "measured", row = 3:6, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = 3:6, col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 3:6, col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "CerealsNational",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_CerealsNational17,
#              archive = "crops and vegetables for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_SativaAccum17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:5),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "SativaAccum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_SativaAccum17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_cucumberAccum17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "cucumberAccum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_cucumberAccum17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Garlic17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Garlic",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_Garlic17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_LettuceWint17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "LettuceWint",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_LettuceWint17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     SchemaChard17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Chard",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = SchemaChard17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Beerootwint <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Beetrootwint",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Beerootwint,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_RadishAcum17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "RadishAcum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_RadishAcum17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_RadishAcum17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "RadishAcum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_RadishAcum17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PaperAcum17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PaperAcum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_PaperAcum17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Cauliflowerwin17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Cauliflowerwin",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Cauliflowerwin17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Cabbagewin17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Cabbagewin",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Cabbagewin17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_FodderMix17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "FodderMix",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_FodderMix17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_MilletfodderSumm17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Millet fodderSumm",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_MilletfodderSumm17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_WhitesorghumSummFodder17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "White sorghumSummFodder",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_WhitesorghumSummFodder17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Spinachwinter17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Spinach winter",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Spinachwinter17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Clover17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Clover",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Clover17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Milletseeds17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Millet seeds",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Milletseeds17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Tobacco17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Tobacco ",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Tobacco17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Sugarcane17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Sugarcane",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Sugarcane17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Onion17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Onion",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Onion17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Greenpeas17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Green peas",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Greenpeas17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Cowpea17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Cowpea",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Cowpea17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Hummus17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Hummus",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Hummus17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Watermelon17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Watermelon",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Watermelon17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_broadbean17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "broad bean",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_broadbean17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Mungbean17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Mung bean",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Mungbean17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Yellowmelon17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Yellow melon",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Yellowmelon17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Okra17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Okra",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Okra17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Eggplant17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Eggplant",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Eggplant17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Squasht17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Squash",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Squash17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Tomato17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Tomato",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_Tomato17,
#              archive = "Secondary crops and vegetables production report 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_sunflowerAutumPrivate17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "sunflowerAutumPrivate",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_sunflowerAutumPrivate17,
#              archive = "Cultivated paddy and sun flower by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_sunflowerSprinPrivate17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:5),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "sunflowerSprPrivate",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =Schema_sunflowerSprinPrivate17,
#              archive = "Cultivated paddy and sun flower by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     sunflowerSprUndAutumPriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:5),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "sunflowerSprUndAutumPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema =sunflowerSprUndAutumPriv17,
#              archive = "Cultivated paddy and sun flower by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_PaddyfodderPri17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 6, col = 1),
#         planted = list(type = "measured", unit = "ha", factor = 0.1,
#                        rel = FALSE),
#         harvested = list(type = "measured", row = 6, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = 6, col = 4, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 6, col = 5 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "PaddyfodderPri",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_PaddyfodderPri17,
#              archive = "crops and vegetables for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_PaddyPri17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:5),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PaddyPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_PaddyPri17,
#              archive = "Cultivated paddy and sun flower by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_PaddySunflower17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:5),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 4, col = 3:4),
#         year = list(type = "id", col = 2, rel = TRUEALSE),
#         planted = list(type = "measured", row = 6:11, col = 3:4, unit = "ha", factor = 10,
#                        rel = FALSE),
#         yield = list(type = "measured", row = 18:23, col = 3:4, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 12:17, col = 3:4 unit = "t", factor = 100ALSE)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Paddy and sunflower",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2012,
#              end = 2017,
#              schema = schema_PaddySunflower17,
#              archive = "Cultivated paddy and sun flower by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_PaddySunflowerPri17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1,
#                        rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Paddy and SunflowerPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_PaddySunflowerPri17,
#              archive = "crops and vegetables for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_PotatoAutumPriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PotatoAutumPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_PotatoAutumPriv17,
#              archive = "Cotton, Yellow Corn and Potato Crops Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_PotatoSpriPriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PotatoSpringPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_PotatoSpriPriv17,
#              archive = "Cotton, Yellow Corn and Potato Crops Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_PotatoSpringAutumPriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PotatoSpringAutumPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_PotatoSpringAutumPriv17,
#              archive = "Cotton, Yellow Corn and Potato Crops Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_YellowMaizeAutumPriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Yellow maize AutumPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_YellowMaizeAutumPriv17,
#              archive = "Cotton, Yellow Corn and Potato Crops Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_YellowMaizeSpriPriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Yellow maize SpringPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_YellowMaizeSpriPriv17,
#              archive = "Cotton, Yellow Corn and Potato Crops Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_YellowMaizeSpriAutumPriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Yellow maize SpringAutumPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_YellowMaizeSpriAutumPriv17,
#              archive = "Cotton, Yellow Corn and Potato Crops Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_CottonPriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldPlanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldHarvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "CottonPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_CottonPriv17,
#              archive = "Cotton, Yellow Corn and Potato Crops Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_CottonMaizePotato <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:5),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 3, col = 3:5ALSE),
#         year = list(type = "id", col = 2, rel = TRUEALSE),
#         planted = list(type = "measured", row = 3:10, col = 4:5, unit = "ha", factor = 10,
#                        rel = FALSE),
#         yield = list(type = "measured", row = 17:22, col = 3:5, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 11:16, col = 3:5 unit = "t", factor = 100ALSE)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "CottonMaizePotato",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2012,
#              end = 2017,
#              schema = schema_CottonMaizePotato,
#              archive = "Cotton, Yellow Corn and Potato Crops Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_CottonMaizePotatoPriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:5),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1,
#                        rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1,
#                          rel = FALSE),
#         yieldplanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "CottonMaizePotatoPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_CottonMaizePotatoPriv17,
#              archive = "Cotton, Yellow Corn and Potato Crops Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsKindBasrah17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsKindsBasrah",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_PlamsKindBasrah17,
#              archive = "تقرير انتاج التمور 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsKindBasrah17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsKindsBasrah",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_PlamsKindBasrah17,
#              archive = "تقرير انتاج التمور 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsKindsMysan17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsKindsMysan",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_PlamsKindsMysan17,
#              archive = "تقرير انتاج التمور 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsKindsThiQar17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsKindsThiQar",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_PlamsKindsThiQar17,
#              archive = "تقرير انتاج التمور 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsKindsALMuthanarr17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsKinds AL-Muthanar",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_PlamsKindsALMuthanarr17,
#              archive = "تقرير انتاج التمور 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsKindsALQadisiya17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsKinds AL-Qadisiya",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_PlamsKindsALQadisiya17,
#              archive = "تقرير انتاج التمور 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsKindsWasit17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsKinds Wasit",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_PlamsKindsWasit17,
#              archive = "تقرير انتاج التمور 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsKindKerbela17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsKinds Kerbela",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_PlamsKindKerbela17,
#              archive = "تقرير انتاج التمور 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsKindBabylon17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsKinds Babylon",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_PlamsKindBabylon17,
#              archive = "تقرير انتاج التمور 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsKindBaghdad17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsKinds Baghdad",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_PlamsKindBaghdad17,
#              archive = "تقرير انتاج التمور 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsKindDiala17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsKinds Diala",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_PlamsKindDiala17,
#              archive = "تقرير انتاج التمور 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Averageyieldpalm17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:6),
#       variables = list(
#         al2 = list(type = "id", col = 10),
#         commodities = list(type = "id", row = 5:6),
#         yield_tree = list(type = "measured", col = 2:8, unit = "kg", factor = 1)
#
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Average yield per palmKind",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Averageyieldpalm17,
#              archive = "تقرير انتاج التمور 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsProducKind17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:7),
#       variables = list(
#         al2 = list(type = "id", col = 10),
#         commodities = list(type = "id", row = 5:7, col = 2:8),
#         production = list(type = "measured", col = 2:8 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Plams ProductionKind",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_PlamsProducKind17,
#              archive = "تقرير انتاج التمور 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Plams17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:7),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 12),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Plams",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_Plams17,
#              archive = "تقرير انتاج التمور 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Plams17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:8),
#       variables = list(
#         al2 = list(type = "id", col = 12),
#         commodities = list(type = "id"),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Plams",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_Plams17,
#              archive = "تقرير انتاج التمور 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Olive17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Olive",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_Olive17,
#              archive = "Summer Fruit Tree Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_peach17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:7),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 2),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "peach",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_peach17,
#              archive = "Summer Fruit Tree Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_greengage17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "greengage",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_greengage17,
#              archive = "Summer Fruit Tree Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_plum17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:7),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "plum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_plum17,
#              archive = "Summer Fruit Tree Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Fig17 <- makeSchema(schema = list(
#       clusters =
#         list(row =2, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Fig",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_Fig17,
#              archive = "Summer Fruit Tree Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Pear17 <- makeSchema(schema = list(
#       clusters =
#         list(row =2, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Pear",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_Pear17,
#              archive = "Summer Fruit Tree Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Apicot17 <- makeSchema(schema = list(
#       clusters =
#         list(row =2, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Apicot",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_Apicot17,
#              archive = "Summer Fruit Tree Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Apple17 <- makeSchema(schema = list(
#       clusters =
#         list(row =3, col = 1,   id = "commodities"),
#       header = list(row = 3:7),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 2),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Apple",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_Apple17,
#              archive = "Summer Fruit Tree Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_pomegranate17 <- makeSchema(schema = list(
#       clusters =
#         list(row =2, col = 1,   id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "pomegranate",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_pomegranate17,
#              archive = "Summer Fruit Tree Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_FruitfultreesSummer17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:9),
#       variables = list(
#         al2 = list(type = "id", col = 6),
#         commodities = list(type = "id", row = 4),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Fruitful trees Summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = Schema_FruitfultreesSummer17,
#              archive = "Summer Fruit Tree Production Report for the year 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_barleyhayPriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:5),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 6, col = 5ALSE),
#         planted = list(type = "measured", unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", row = 6, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = 6, col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 6, col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "barley hayPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_barleyhayPriv17,
#              archive = "Cultivated wheat and barley by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_barleyIrrPriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:7),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 9),
#         commodities = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "barley IrrigatedPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_barleyIrrPriv17,
#              archive = "Cultivated wheat and barley by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_barleyrainfedPriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:7),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 9),
#         commodities = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "barley rainfedPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_barleyrainfedPriv17,
#              archive = "Cultivated wheat and barley by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_barley17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:7),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 10),
#         commodities = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 9, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "barley",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_barley17,
#              archive = "Cultivated wheat and barley by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_barleyrqinfed17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:7),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         rainfed = list(type = "id", col = 9),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "barley rainfedPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_barleyrqinfed17,
#              archive = "Cultivated wheat and barley by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_barleyIrrigPrivd17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:7),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         Irrigation = list(type = "id", col = 9),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "barley IrrigPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_barleyIrrigPrivd17,
#              archive = "Cultivated wheat and barley by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_WheatHayPrivPriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:5),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 6, col = 5ALSE),
#         planted = list(type = "measured", unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", row = 6, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = 6, col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 6, col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "WheatHayPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_WheatHayPrivPriv17,
#              archive = "Cultivated wheat and barley by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_WheatHayPrivPriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:5),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 6, col = 5ALSE),
#         planted = list(type = "measured", unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", row = 6, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", row = 6, col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 6, col = 4 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "WheatHayPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_WheatHayPrivPriv17,
#              archive = "Cultivated wheat and barley by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_WheatIrrigatedPriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:7),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 8),
#         commodities = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 5 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Wheat IrrigatedPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_WheatIrrigatedPriv17,
#              archive = "Cultivated wheat and barley by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Wheatrainfed17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:7),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 8),
#         commodities = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 5 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Wheat rainfed",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_Wheatrainfed17,
#              archive = "Cultivated wheat and barley by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Wheat17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1, id = "commodities"),
#       header = list(row = 5:8),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 9),
#         commodities = list(type = "id"),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 5 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Wheat",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_Wheat17,
#              archive = "Cultivated wheat and barley by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_WheatBarley17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1, id = "commodities"),
#       header = list(row = 5:8),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 5, col = c(3,5)ALSE),
#         year = list(type = "id", col = 2, rel = TRUEALSE),
#         planted = list(type = "measured", row = 7:12, col = c(3,5), unit = "ha", factor = 100, rel = FALSE),
#         yield = list(type = "measured", row = 19:24, col = c(3,5), unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", row = 13:18, col = c(3,5) unit = "t", factor = 1000ALSE)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Wheat and Barley",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2012,
#              end = 2017,
#              schema = schema_WheatBarley17,
#              archive = "Cultivated wheat and barley by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Wheatrinfed17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:7),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         rainfed = list(type = "id", col = 8),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 5 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Wheat rainfedPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_Wheatrinfed17,
#              archive = "Cultivated wheat and barley by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Wheatirripriv17 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:7),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         irrigation = list(type = "id", col = 8),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 5 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Wheat irripriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2017,
#              end = 2017,
#              schema = schema_Wheatirripriv17,
#              archive = "Cultivated wheat and barley by governerate 2017.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Seedprduction16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1, id = "commodities"),
#       header = list(row = 5:11),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 9),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Seed prduction",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Seedprduction16,
#              archive = "crops and vegetables for the year 2016 national.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Bulbstubers16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 6, col = 1, id = "commodities"),
#       header = list(row = 6:11),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 9),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Bulbs and tubers",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Bulbstubers16,
#              archive = "crops and vegetables for the year 2016 national.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_OilCrops16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 6, col = 1, id = "commodities"),
#       header = list(row = 6:11),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 9),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Oil crops",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_OilCrops16,
#              archive = "crops and vegetables for the year 2016 national.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_IndustrialCrops16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 6, col = 1, id = "commodities"),
#       header = list(row = 6:12),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 9),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Industrial crops",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_IndustrialCrops16,
#              archive = "crops and vegetables for the year 2016 national.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_LegumeslCrops16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 6, col = 1, id = "commodities"),
#       header = list(row = 6:12),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 9),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Legumes crops",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_LegumeslCrops16,
#              archive = "crops and vegetables for the year 2016 national.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_ForageCrops16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 6, col = 1, id = "commodities"),
#       header = list(row = 6:12),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 9),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Forage crops",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_ForageCrops16,
#              archive = "crops and vegetables for the year 2016 national.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_vegetablesCrops16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 7, col = 1, id = "commodities"),
#       header = list(row = 7:13),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 9),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "vegetables crops",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_vegetablesCrops16,
#              archive = "crops and vegetables for the year 2016 national.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Cereal16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 6, col = 1, id = "commodities"),
#       header = list(row = 6:12),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 9),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 6, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 8 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Cereal crops",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Cereal16,
#              archive = "crops and vegetables for the year 2016 national.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_CropsVegetables16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 8, col = 1, id = "commodities"),
#       header = list(row = 8:10),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 13),
#         year = list(type = "id", row = 8, rel = TRUEALSE),
#         planted = list(type = "measured", col = c(2,4,6,8,10), unit = "ha", factor = 100, rel = FALSE),
#         production = list(type = "measured", col = c(3,5,7,9,11) unit = "t", factor = 1000ALSE)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = " Crops and Vegetables",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2012,
#              end = 2016,
#              schema = schema_CropsVegetables16,
#              archive = "crops and vegetables for the year 2016 national.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_WintTurnip16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Winter Tunip",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_WintTurnip16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_AlfalfaAcum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Alfalfa acum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_AlfalfaAcum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_TOmatoAcum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Tomato acum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_TOmatoAcum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_SquashAcum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", row =NULL, col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Squash acum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_SquashAcum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_GrenCowpeaAcum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Green cowpea acum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_GrenCowpeaAcum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_SugsrcsneSumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Sugsrcane summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_SugsrcsneSumm16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_GroundnutSumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Groundnut summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_GroundnutSumm16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_DryBeanswint16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Dry Beans wint",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_DryBeanswint16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_GreenBeans16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Green Beans",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_GreenBeans16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_watermelonAcum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "watermelon Acum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_watermelonAcum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_HummusWin16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Hummus winter",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_HummusWin16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     OnionAcum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Onion Acum winter",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = OnionAcum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_GreenStringbeansWin16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Green string beans wint",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_GreenStringbeansWin16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_MilletSeedsAcum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Millet seedsAcum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_MilletSeedsAcum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_GreenBroadBeanWint16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Green broad beans wint",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_GreenBroadBeanWint16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_MungBeanSumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Mung bean summ",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_MungBeanSumm16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Greenstringbeanwin16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Green string beans win",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Greenstringbeanwin16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_lentilswin16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "lentils win",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_lentilswin16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Oawtswin16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Oats winter",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Oawtswin16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_WhiteSorghumseedSumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "White sorghumseed summ",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_WhiteSorghumseedSumm16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_SesameSumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Sesame summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_SesameSumm16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_TobaccoSumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Tobacco summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_TobaccoSumm16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_YellowmelonAacum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Yellowmelon acum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_YellowmelonAacum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_OkraAacum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Okra acum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_OkraAacum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_DryBroadbeanSumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Dry broad bean summ",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_DryBroadbeanSumm16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_EggplantAcum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1, id = "commodities"),
#       header = list(row = 4:6),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 3ALSE),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Eggplant acum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_EggplantAcum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#
#     schema_SpinachWint16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Spinach winter",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_SpinachWint16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_WhitsorghFoddSumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "White sorghum fodder summ",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_WhitsorghFoddSumm16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_MilletFoddeWint16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Millet fodder wint",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_MilletFoddeWint16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_FodderMixtuAcum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Fodder Mixture acum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_FodderMixtuAcum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Cabbagewint16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Cabbage winter",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Cabbagewint16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Cauliflowerwint16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Cauliflower winter",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Cauliflowerwint16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_PeperAcum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Peper acum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_PeperAcum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_RadishAcum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Radish acum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_RadishAcum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_BeetrootWint16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Beetroot winter",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_BeetrootWint16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_ChardAcum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Chard acum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_ChardAcum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Lettucewint16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Lettuce winter",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Lettucewint16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Carrotswint16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Carrots winter",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Carrotswint16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_GarlicAcum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Garlic acum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_GarlicAcum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_GreenonionWint16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Green onionWinter",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_GreenonionWint16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Cucumberacum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Cucumber acum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Cucumberacum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Sativaacum16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 7),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 2, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 1 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Sativa acum",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Sativaacum16,
#              archive = "Secondary crops and vegetables production report 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_SunflowerAutmPri16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Sunflower autumnPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_SunflowerAutmPri16,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Paddyprivate16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Paddy private",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Paddyprivate16,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Paddystrawfodde16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1,   id = "commodities"),
#       header = list(row = 2:3),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col =2, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 4, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 5 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Paddy straw fodder",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Paddystrawfodde16,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_PaddySunflowerprivate16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:4),
#       meta = list(del = "."),
#       variables = list(
#         al2 = list(type = "id", col = 1),
#         commodities = list(type = "id", row = 1),
#         planted = list(type = "measured", col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yieldplanted = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         yieldharvested = list(type = "measured", col = 8, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level =2,
#              subset = "Paddy and sunflower private",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_PaddySunflowerprivate16,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_PaddySunflower <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3),
#       meta = list(del = "."),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 3:4),
#         year = list(type = "id", row = 2),
#         planted = list(type = "measured", row = 5:10, col = 3:4, unit = "ha", factor = 10, rel = FALSE),
#         yield = list(type = "measured", row = 17:22, col = 3:4, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 3:4 unit = "t", factor = 100ALSE)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Paddy and sunflower",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2011,
#              end = 2016,
#              schema = schema_PaddySunflower,
#              archive = "تقرير الشلب وزهرة الشمس لسنة 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Peachsummer16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:7),
#       variables = list(
#         al2 =
#           list(type = "id", col = 6),
#         commodities = list(type = "id", row = 2),
#         treecount =
#           list(type = "measured", col = 2, unit = "tree"),
#         yield_tree =
#           list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production =
#           list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Peach summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Peachsummer16,
#              archive = "Summer Fruit Tree Production Report for the year 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schemaOlivesummer16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 =
#           list(type = "id", col = 6),
#         commodities =
#           list(type = "id", row = 1),
#         treecount =
#           list(type = "measured", col = 2, unit = "tree"),
#         yield_tree =
#           list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production =
#           list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Olive summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schemaOlivesummer16,
#              archive = "Summer Fruit Tree Production Report for the year 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_greengagesumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 =
#           list(type = "id", col = 6),
#         commodities =
#           list(type = "id", row = 1),
#         treecount =
#           list(type = "measured", col = 2, unit = "tree"),
#         yield_tree =
#           list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production =
#           list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "greengage  summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_greengagesumm16,
#              archive = "Summer Fruit Tree Production Report for the year 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_PLumsumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:7),
#       variables = list(
#         al2 =
#           list(type = "id", col = 6),
#         commodities =
#           list(type = "id", row = 2),
#         treecount =
#           list(type = "measured", col = 2, unit = "tree"),
#         yield_tree =
#           list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production =
#           list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Plum summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_PLumsumm16,
#              archive = "Summer Fruit Tree Production Report for the year 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Figsumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 =
#           list(type = "id", col = 6),
#         commodities =
#           list(type = "id", row = 1),
#         treecount =
#           list(type = "measured", col = 2, unit = "tree"),
#         yield_tree =
#           list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production =
#           list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Fig summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Figsumm16,
#              archive = "Summer Fruit Tree Production Report for the year 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Pearsumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:7),
#       variables = list(
#         al2 =
#           list(type = "id", col = 6),
#         commodities =
#           list(type = "id", row = 2),
#         treecount =
#           list(type = "measured", col = 2, unit = "tree"),
#         yield_tree =
#           list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production =
#           list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Pear summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Pearsumm16,
#              archive = "Summer Fruit Tree Production Report for the year 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Apicotsumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 =
#           list(type = "id", col = 6),
#         commodities =
#           list(type = "id", row = 1),
#         treecount =
#           list(type = "measured", col = 2, unit = "tree"),
#         yield_tree =
#           list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production =
#           list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Apicot summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Apicotsumm16,
#              archive = "Summer Fruit Tree Production Report for the year 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Applesumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1, id = "commodities"),
#       header = list(row = 3:7),
#       variables = list(
#         al2 =
#           list(type = "id", col = 6),
#         commodities =
#           list(type = "id", row = 2),
#         treecount =
#           list(type = "measured", col = 2, unit = "tree"),
#         yield_tree =
#           list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production =
#           list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Apple summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Applesumm16,
#              archive = "Summer Fruit Tree Production Report for the year 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_Pomegranatesumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 2, col = 1, id = "commodities"),
#       header = list(row = 2:6),
#       variables = list(
#         al2 =
#           list(type = "id", col = 6),
#         commodities =
#           list(type = "id", row = 1),
#         treecount =
#           list(type = "measured", col = 2, unit = "tree"),
#         yield_tree =
#           list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production =
#           list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Pomegranate summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = schema_Pomegranatesumm16,
#              archive = "Summer Fruit Tree Production Report for the year 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     schema_fruitfultreesumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1, id = "commodities"),
#       header = list(row = 5:9),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities =
#           list(type = "id", col = 10),
#         year = list(type = "id", row = 10),
#         treecount =
#           list(type = "measured", col = 2:3, unit = "tree"),
#         yield_tree =
#           list(type = "measured", col = 4:5, unit = "kg", factor = 1),
#         production =
#           list(type = "measured", col = 6:7 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Fruitful trees summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2015,
#              end = 2016,
#              schema = schema_fruitfultreesumm16,
#              archive = "Summer Fruit Tree Production Report for the year 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Fruitfulsumm16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1, id = "commodities"),
#       header = list(row = 5:9),
#       variables = list(
#         al2 = list(type = "id", row = 6),
#         commodities = list(type = "id", row = 4),
#         year = list(type = "id"),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", unit = "tree"),
#         yield_tree = list(type = "measured", col = 3, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 4 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Fruitful trees summer",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_Fruitfulsumm16,
#              archive = "Summer Fruit Tree Production Report for the year 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_CottonYelowmaizePotatPriv16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:5),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "CottonYelowmaizePotatPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_CottonYelowmaizePotatPriv16,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PotatoAutumnPriv16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al2 = list(type = "id", row = 1),
#         commodities = list(type = "id", col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Potato autumnPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_PotatoAutumnPriv16,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PotatoSpringAutumnPriv16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al2 = list(type = "id", row = 1),
#         commodities = list(type = "id", col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Potato springautumnPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_PotatoSpringAutumnPriv16,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PotatoSpringPriv16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al2 = list(type = "id", row = 1),
#         commodities = list(type = "id", col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Potato springPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_PotatoSpringPriv16,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_SorghumautumPriv16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al2 = list(type = "id", row = 1),
#         commodities = list(type = "id", col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Sorghum autumPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_SorghumautumPriv16,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_MaizePriv16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al2 = list(type = "id", row = 1),
#         commodities = list(type = "id", col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Maize springPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_MaizePriv16,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_CottonPriv16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al2 = list(type = "id", row = 1),
#         commodities = list(type = "id", col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Cotton springPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_CottonPriv16,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_MaizeSprinAutumn16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al2 = list(type = "id", row = 1),
#         commodities = list(type = "id", col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Maize springAutumnPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_MaizeSprinAutumn16,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_MaizeSprinAutumn16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:4),
#       variables = list(
#         al2 = list(type = "id", row = 1),
#         commodities = list(type = "id", col = 1),
#         year = list(type = "id"),
#         planted = list(type = "measured", row =NULL, col = 2, unit = "ha", factor = 0.1, rel = FALSE),
#         harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1, rel = FALSE),
#         yield = list(type = "measured", col = 7, unit = "t/ha", factor = 0.011, rel = FALSE),
#         production = list(type = "measured", col = 6 unit = "t", factor = 1)
#       )))
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Maize springAutumnPriv",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_MaizeSprinAutumn16,
#              archive = "تقرير إنتاج محاصيل القطن والذرة الصفراء والبطاطا لسنة 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Plams16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 5, col = 1,   id = "commodities"),
#       header = list(row = 5:8),
#       variables = list(
#         al2 = list(type = "id", row = 12),
#         commodities = list(type = "id", row = 1),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Plams",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_Plams16,
#              archive = "تقرير انتاج التمور 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsProdkinds16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:7),
#       variables = list(
#         al2 = list(type = "id", row = 10),
#         commodities = list(type = "id", row = 7),
#         treecount = list(type = "measured", unit = "tree"),
#         prodectree = list(type = "measured", unit = "tree"),
#         yield_tree = list(type = "measured", unit = "kg", factor = 1),
#         production = list(type = "measured", col = 2:8 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Plams Producion kinds",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_PlamsProdkinds16,
#              archive = "تقرير انتاج التمور 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Plamsyieldkinds16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:6),
#       variables = list(
#         al2 = list(type = "id", row = 10),
#         commodities = list(type = "id", row = 6),
#         treecount = list(type = "measured", unit = "tree"),
#         prodectree = list(type = "measured", unit = "tree"),
#         yield_tree = list(type = "measured", col = 2:8, unit = "kg", factor = 1),
#         production = list(type = "measured" unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Plams Yield kinds",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_Plamsyieldkinds16,
#              archive = "تقرير انتاج التمور 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_Palmskinds16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:7),
#       variables = list(
#         al1 = list(type = "id", value = "Iraq"),
#         commodities = list(type = "id", col = 12),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 1,
#              subset = "Palms Kinds",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_Palmskinds16,
#              archive = "تقرير انتاج التمور 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsDiala16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 4, col = 1,   id = "commodities"),
#       header = list(row = 4:8),
#       variables = list(
#         al2 = list(type = "id", row = 3ALSE),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsDiala",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_PlamsDiala16,
#              archive = "تقرير انتاج التمور 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsBaghdad16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsBaghdad",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_PlamsBaghdad16,
#              archive = "تقرير انتاج التمور 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsBabylon16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsBabylon",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_PlamsBabylon16,
#              archive = "تقرير انتاج التمور 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsKerbela16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsKerbela",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_PlamsKerbela16,
#              archive = "تقرير انتاج التمور 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsWasit16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsWasit",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_PlamsWasit16,
#              archive = "تقرير انتاج التمور 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsAlNajaf16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsAL-Najaf",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_PlamsAlNajaf16,
#              archive = "تقرير انتاج التمور 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_AlQadisiya16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsAL-Qadisiya",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_AlQadisiya16,
#              archive = "تقرير انتاج التمور 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsAlMuthana16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "PlamsAL-Muthana",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_PlamsAlMuthana16,
#              archive = "تقرير انتاج التمور 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsThiQar16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Plams ThiQar",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_PlamsThiQar16,
#              archive = "تقرير انتاج التمور 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsMysan16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Plams Mysan",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_PlamsMysan16,
#              archive = "تقرير انتاج التمور 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
#
#     Schema_PlamsBasrah16 <- makeSchema(schema = list(
#       clusters =
#         list(row = 3, col = 1,   id = "commodities"),
#       header = list(row = 3:6),
#       variables = list(
#         al2 = list(type = "id", row = 2),
#         commodities = list(type = "id", col = 11),
#         treecount = list(type = "measured", col = 2, unit = "tree"),
#         prodectree = list(type = "measured", col = 6, unit = "tree"),
#         yield_tree = list(type = "measured", col = 8, unit = "kg", factor = 1),
#         production = list(type = "measured", col = 10 unit = "t", factor = 1)
#       )))
#
#     regTable(nation = "Iraq",
#              level = 2,
#              subset = "Plams Basrah",
#              dSeries = "cso Iraq",
#              gSeries = "cso Iraq",
#              begin = 2016,
#              end = 2016,
#              schema = Schema_PlamsBasrah16,
#              archive = "تقرير انتاج التمور 2016.pdf",
#              archiveLink = "unknown",
#              updateFrequency = "notPlanned",
#              metadataLink = "unknown",
#              metadataPath = "unknown",
#              update = TRUE)
