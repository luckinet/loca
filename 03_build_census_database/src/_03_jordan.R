# script arguments ----
#
thisNation <- "Jordan"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("dos")
gs <- c("gadm36")


# register dataseries ----
#
regDataseries(name = ds[1],
              description = "Department of Statistics",
              homepage = "http://dosweb.dos.gov.jo/",
              licence_link = "",
              licence_path = "",
              update = updateTables)


# register geometries ----
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


# register census tables ----
#
## DoS ----
#
# schema_LETTUCE16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:5),
#   variables = list(
#     al3 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", row = c(2,4,6:10,12:13,15:16,18:24,28:29,31:33,35:38,42:44,47:50), col = c(2,4,6,8,14,21,25,28), unit = "ha", factor = 0.1),
#     production = list(type = "measured", row = c(3,4,6:10,12:13,15:16,18:24,28:29,31:33,35:38,42:44,47:50), col = c(3,6,9,15,18,22,29,30), unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 3,
#          subset = "Land use",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_LETTUCE16,
#          archive = "Actual cultivated area and production by district 2008.xls",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_Landuse08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:5),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id", row = 5, col = c(10:13,19:20,23:24,26:27)),
#     planted = list(type = "measured", col = c(2,4,6,8,14,21,25,28,31), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(3,6,9,15,18,22,29,30), unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Land use",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_Landuse08,
#          archive = "Actual cultivated area and production by district 2008.xls",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_wintercereals08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:5),
#   variables = list(
#     al3 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id", row = 5, col = c(2:5,8:11,21:24,27:30)),
#     planted = list(type = "measured", col = c(2:3,6,8:9,12,14,17,19,21:22,25,27:28,31), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(4:5,7,10:11,13,15,18,20,23:24,26,29:30,32), unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 3,
#          subset = "winter cereals",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_wintercereals08,
#          archive = "Cereals2008.xls",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_summercereals08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   variables = list(
#     al3 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = c(2,4,6,8,10,12) , unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(3,5,7,9,11,13) , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 3,
#          subset = "Summer cereals",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_summercereals08,
#          archive = "Cereals2008.xls",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_summercereals08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id", row = 4),
#     planted = list(type = "measured", col = 2:6 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "cereals",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_summercereals08,
#          archive = "Cereals2008.xls",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse208 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:8 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Land use2",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_landuse208,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_agriArea08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:4 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Agri area",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_agriArea08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse308 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:4 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "land use3",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_landuse308,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse408 <- makeSchema(schema = list(
#   clusters =
#     list(row = 6, col = 1, id = "commodities"),
#   header = list(row = 6:7),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id", row = 7),
#     planted = list(type = "measured", col = 2:6 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "land use4",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_landuse408,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_AWinterVegetables08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id", row = 6),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AreaWinter Vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_AWinterVegetables08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_ASummerVegetables08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id", row = 6),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AreaSummer Vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_ASummerVegetables08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTrees08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 12, col = 1, id = "commodities"),
#   header = list(row = 12),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 4, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Fruit Trees",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTrees08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAmman08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesAmman08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesBalqa08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesBalqa08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesZarqa08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesZarqa08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMadaba08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesMadaba08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesIrbid08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesIrbid08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMafraq08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesMafraq08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesJarash08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesJarash08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAjlun08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesAjlun08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAjlun08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesAjlun08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesKarak08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesKarak08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesTafiela08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesTafiela08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMaaan08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesMaaan08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAqaba08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesAqaba08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsUplands08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsUplands08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAmman08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsAmman08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsBalqa08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsBalqa08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsZarqa08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsZarqa08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMadaba08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsMadaba08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsIrbid08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsIrbid08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMafraq08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsMafraq08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsJarash08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsJarash08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAjlun08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsAjlun08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsKarak08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsKarak08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsTafiela08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsTafiela08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMaaan08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsMaaan08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAqaba08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsAqaba08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesUplands08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Uplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesUplands08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAmman08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Amman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesAmman08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesBalqa08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Balqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesBalqa08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesZarqa08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Zarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesZarqa08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMadaba08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Madaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesMadaba08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesIrbid08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Irbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesIrbid08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMafraq08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Mafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesMafraq08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesJarash08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Jarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesJarash08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAjlun08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Ajlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesAjlun08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesKarak08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Karak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesKarak08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesTafiela08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Tafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesTafiela08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMaaan08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Maaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesMaaan08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAqaba08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Aqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesAqaba08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehJ08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesShoonehJ08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesDairAlla08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesDairAlla08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehS08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees  ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesShoonehS08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesGhorSafi08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees  GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FruitTreesGhorSafi08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAlAghwar08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsAlAghwar08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsSh08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsSh08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsDairAlla08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsDairAlla08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsShoonehSh08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsShoonehSh08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsGhorSafi08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_FieldCropsGhorSafi08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAlAghwar08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesAlAghwar08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesShoonehJa08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehJanobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesShoonehJa08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesDairAlla08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesDairAlla08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesShoonehSh08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesShoonehSh08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesGhorSafi08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_VegetablesGhorSafi08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_Animals08 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 5:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 6),
#     production = list(type = "measured", unit = "t", factor = 1),
#     headcount = list(type = "measured", col = 2:7, unit = "h", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Animals",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2008,
#          end = 2008,
#          schema = schema_Animals08,
#          archive = "Argi statistics2008.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse207 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:8 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Land use",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_landuse207,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_agriArea07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 2),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:4 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Agri area",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_agriArea07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse107 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:4 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "land use1",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_landuse107,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse207 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 5),
#     IrriMethod = list(type = "id", row = 4),
#     planted = list(type = "measured", col = 2:6 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "land use2",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_landuse207,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_AWinterVegetables07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id", row = 5),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AreaWinter Vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_AWinterVegetables07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_ASummerVegetables07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id", row = 5),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AreaSummer Vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_ASummerVegetables07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAlAghwar07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesAlAghwar07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesUplands07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   yield = list(type = "measured", unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesUplands07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAmman07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesAmman07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesBalqa07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesBalqa07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesZarqa07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesZarqa07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMadaba07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesMadaba07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesIrbid07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesIrbid07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMafraq07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesMafraq07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesJarash07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesJarash07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAjlun07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesAjlun07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesKarak07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesKarak07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesTafiela07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesTafiela07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMaaan07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesMaaan07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAqaba07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesAqaba07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsUplands07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsUplands07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAmman07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsAmman07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsBalqa07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsBalqa07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsZarqa07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsZarqa07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMadaba07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsMadaba07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsIrbid07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsIrbid07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMafraq07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsMafraq07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsJarash07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsJarash07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAjlun07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsAjlun07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsKarak07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsKarak07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsTafiela07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsTafiela07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMaaan07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsMaaan07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAqaba07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsAqaba07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesUplands07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Uplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesUplands07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAmman07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Amman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesAmman07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesBalqa07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Balqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesBalqa07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesZarqa07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Zarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesZarqa07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMadaba07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Madaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesMadaba07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesIrbid07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Irbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesIrbid07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMafraq07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Mafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesMafraq07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesJarash07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Jarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesJarash07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAjlun07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Ajlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesAjlun07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesKarak07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Karak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesKarak07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesTafiela07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Tafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesTafiela07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMaaan07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Maaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesMaaan07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAqaba07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Aqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesAqaba07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehJ07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesShoonehJ07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesDairAlla07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesDairAlla07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehS07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesShoonehS07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesGhorSafi07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees  GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FruitTreesGhorSafi07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAlAghwar07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsAlAghwar07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsSh07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsSh07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsDairAlla07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsDairAlla07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsShoonehSh07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_FieldCropsShoonehSh07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAlAghwar07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesAlAghwar07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesDairAlla07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesDairAlla07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_VegetablesShoonehJa07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehJanobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesShoonehJa07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesShoonehSh07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesShoonehSh07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesGhorSafi07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_VegetablesGhorSafi07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_Animals07 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, id = "commodities"),
#   header = list(row = 7:8),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 8),
#     production = list(type = "measured", unit = "t", factor = 1),
#     headcount = list(type = "measured", col = 2:7, unit = "h", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Animals",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2007,
#          end = 2007,
#          schema = schema_Animals07,
#          archive = "Argi statistics2007.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_landuse09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:8 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Land use",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_landuse09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_agriArea09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:4 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Agri area",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_agriArea09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse109 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:4 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "land use1",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_landuse109,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse209 <- makeSchema(schema = list(
#   clusters =
#     list(row = 6, col = 1, id = "commodities"),
#   header = list(row = 6:7),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 6),
#     IrriMethod = list(type = "id", row = 6:7, col = 2:6),
#     planted = list(type = "measured", col = 2:6 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "land use2",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_landuse209,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_AWinterVegetables09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 5),
#     IrriMethod = list(type = "id", row = 6),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AreaWinter Vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_AWinterVegetables09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_ASummerVegetables09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 5),
#     IrriMethod = list(type = "id", row = 6),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AreaSummer Vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_ASummerVegetables09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesAlAghwar09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesAlAghwar09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_AgriUplands09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 4, col = 1),
#     commodities = list(type = "id", row = 6:8, col = 1),
#     planted = list(type = "measured", col = 2:4, unit = "ha", factor = 0.1),
#     production = list(type = "measured", unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AgriUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_AgriUplands09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesUplands09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesUplands09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAmman09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesAmman09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesBalqa09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesBalqa09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesZarqa09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesZarqa09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMadaba09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesMadaba09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesIrbid09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesIrbid09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMafraq09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesMafraq09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesJarash09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesJarash09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAjlun09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesAjlun09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesKarak09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesKarak09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesTafiela09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesTafiela09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMaaan09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesMaaan09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAqaba09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesAqaba09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsUplands09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsUplands09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAmman09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsAmman09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsBalqa09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsBalqa09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsZarqa09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsZarqa09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMadaba09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsMadaba09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsIrbid09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsIrbid09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMafraq09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsMafraq09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsJarash09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsJarash09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAjlun09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsAjlun09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsKarak09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsKarak09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsTafiela09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsTafiela09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMaaan09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsMaaan09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAqaba09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsAqaba09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesUplands09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Uplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesUplands09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAmman09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Amman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesAmman09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesBalqa09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Balqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesBalqa09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesZarqa09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Zarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesZarqa09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMadaba09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Madaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesMadaba09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesIrbid09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Irbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesIrbid09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMafraq09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Mafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesMafraq09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesJarash09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Jarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesJarash09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAjlun09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Ajlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesAjlun09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesKarak09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Karak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesKarak09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesTafiela09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Tafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesTafiela09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMaaan09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Maaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesMaaan09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAqaba09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Aqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesAqaba09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehJ09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesShoonehJ09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesDairAlla09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesDairAlla09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehS09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesShoonehS09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesGhorSafi09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FruitTreesGhorSafi09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAlAghwar09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsAlAghwar09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsSh09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsSh09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsDairAlla09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsDairAlla09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsShoonehSh09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_FieldCropsShoonehSh09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAlAghwar09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesAlAghwar09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesDairAlla09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesDairAlla09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_VegetablesShoonehJa09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehJanobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesShoonehJa09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesShoonehSh09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesShoonehSh09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesGhorSafi09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_VegetablesGhorSafi09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_Animals09 <- makeSchema(schema = list(
#   clusters =
#     list(row = 7, col = 1, id = "commodities"),
#   header = list(row = 7:8),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 8),
#     production = list(type = "measured", unit = "t", factor = 1),
#     headcount = list(type = "measured", col = 2:7, unit = "h", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Animals",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2009,
#          end = 2009,
#          schema = schema_Animals09,
#          archive = "Argi statistics2009.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:8 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Land use",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_landuse10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_agriArea10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:4 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Agri area",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_agriArea10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse110 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:4 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "land use1",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_landuse110,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse210 <- makeSchema(schema = list(
#   clusters =
#     list(row = 6, col = 1, id = "commodities"),
#   header = list(row = 6:7),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 6),
#     IrriMethod = list(type = "id", row = 6:7, col = 2:6),
#     planted = list(type = "measured", col = 2:6 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "land use2",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_landuse210,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_CropAreaIrrMethods10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 5:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id", row = 6),
#     planted = list(type = "measured", col = 2:6 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "CropArea IrrMethods",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_CropAreaIrrMethods10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_AWinterVegetables10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id", row = 6),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Winter vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_AWinterVegetables10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_ASummerVegetables10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 5),
#     IrriMethod = list(type = "id", row = 6),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AreaSummer Vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_ASummerVegetables10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAlAghwar10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesAlAghwar10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_AgriUplands10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", row = 5:8, col = 1),
#     planted = list(type = "measured", col = 2:4, unit = "ha", factor = 0.1),
#     production = list(type = "measured", unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AgriUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_AgriUplands10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesUplands10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesUplands10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesAmman10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesAmman10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesZarqa10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesZarqa10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesBalqa10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesBalqa10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMadaba10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesMadaba10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesIrbid10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesIrbid10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMafraq10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesMafraq10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesJarash10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesJarash10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAjlun10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesAjlun10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesKarak10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesKarak10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesTafiela10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesTafiela10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMaaan10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesMaaan10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAqaba10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesAqaba10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsUplands10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsUplands10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAmman10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsAmman10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsBalqa10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsBalqa10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsZarqa10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsZarqa10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMadaba10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsMadaba10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsIrbid10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsIrbid10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMafraq10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsMafraq10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsJarash10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsJarash10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAjlun10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsAjlun10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsKarak10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsKarak10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsTafiela10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsTafiela10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMaaan10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsMaaan10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAqaba10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsAqaba10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesUplands10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Uplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesUplands10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAmman10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Amman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesAmman10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesBalqa10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Balqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesBalqa10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesZarqa10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Zarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesZarqa10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMadaba10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Madaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesMadaba10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesIrbid10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Irbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesIrbid10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMafraq10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Mafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesMafraq10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesJarash10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Jarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesJarash10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAjlun10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Ajlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesAjlun10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesKarak10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Karak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesKarak10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesTafiela10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Tafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesTafiela10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMaaan10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Maaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesMaaan10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAqaba10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Aqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesAqaba10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehJ10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesShoonehJ10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesDairAlla10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesDairAlla10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehS10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesShoonehS10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesGhorSafi10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FruitTreesGhorSafi10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAlAghwar10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsAlAghwar10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsSh10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsSh10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsDairAlla10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsDairAlla10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsShoonehSh10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsShoonehSh10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsGhorSafi10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_FieldCropsGhorSafi10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAlAghwar10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesAlAghwar10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_VegetablesShoonehJa10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehJanobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesShoonehJa10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesDairAlla10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesDairAlla10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_VegetablesShoonehSh10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesShoonehSh10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesGhorSafi10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_VegetablesGhorSafi10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_Animals10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 5:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 6),
#     year = list(type = "id", row = 4, col = c(2,5)),
#     production = list(type = "measured", unit = "t", factor = 1),
#     headcount = list(type = "measured", col = 2:7, unit = "h", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Animals",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2010,
#          end = 2010,
#          schema = schema_Animals10,
#          archive = "Argi statistics2010.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:8 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Land use",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_landuse11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_agriArea11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:4 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Agri area",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_agriArea11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse111 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:4 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "land use1",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_landuse111,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse211 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 5:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id", row = 5:6, col = 2:6),
#     planted = list(type = "measured", col = 2:6 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "land use2",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_landuse211,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_AWinterVegetables11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id", row = 6),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Winter vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_AWinterVegetables11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_ASummerVegetables11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id", row = 6),
#     planted = list(type = "measured", col = 2:11 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AreaSummer Vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_ASummerVegetables11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAlAghwar11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesAlAghwar11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_AgriAghwar11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", row = 5:8, col = 1),
#     planted = list(type = "measured", col = 2:4, unit = "ha", factor = 0.1),
#     production = list(type = "measured", unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AgriAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_AgriAghwar11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_AgriUplands11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", row = 5:8, col = 1),
#     planted = list(type = "measured", col = 2:4, unit = "ha", factor = 0.1),
#     production = list(type = "measured", unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AgriUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_AgriUplands11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesUplands11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesUplands11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesAmman11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesAmman11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesBalqa11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesBalqa11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesZarqa11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesZarqa11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMadaba11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesMadaba11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesIrbid11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesIrbid11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMafraq11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesMafraq11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesJarash11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesJarash11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAjlun11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesAjlun11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesKarak11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesKarak11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesTafiela11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesTafiela11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMaaan11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesMaaan11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAqaba11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesAqaba11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsUplands11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsUplands11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAmman11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsAmman11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsBalqa11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsBalqa11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsZarqa11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsZarqa11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMadaba11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsMadaba11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsIrbid11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsIrbid11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMafraq11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsMafraq11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsJarash11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsJarash11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAjlun11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsAjlun11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsKarak11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsKarak11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsTafiela11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsTafiela11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMaaan11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsMaaan11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAqaba11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsAqaba11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesUplands11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Uplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesUplands11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAmman11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Amman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesAmman11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesBalqa11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Balqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesBalqa11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesZarqa11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Zarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesZarqa11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMadaba11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Madaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesMadaba11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesIrbid11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Irbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesIrbid11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMafraq11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Mafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesMafraq11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesJarash11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Jarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesJarash11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAjlun11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Ajlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesAjlun11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesKarak11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Karak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesKarak11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesTafiela11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Tafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesTafiela11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMaaan11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Maaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesMaaan11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAqaba11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Aqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesAqaba11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehJ11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesShoonehJ11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesDairAlla11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesDairAlla11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehS11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesShoonehS11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesGhorSafi11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FruitTreesGhorSafi11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAlAghwar11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsAlAghwar11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsSh11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsSh11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsDairAlla11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsDairAlla11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsShoonehSh11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsShoonehSh11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsGhorSafi11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_FieldCropsGhorSafi11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAlAghwar11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesAlAghwar11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesShoonehJa11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehJanobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesShoonehJa11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesDairAlla11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesDairAlla11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_VegetablesShoonehSh11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesShoonehSh11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesGhorSafi11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_VegetablesGhorSafi11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# ```{r register tables Syria, eval=FALSE}
# myUpdate <- TRUE
# schema_Animals11 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 5:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 6),
#     year = list(type = "id", row = 5, col = c(2,5)),
#     production = list(type = "measured", unit = "t", factor = 1),
#     headcount = list(type = "measured", col = 2:7, unit = "h", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Animals",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2011,
#          end = 2011,
#          schema = schema_Animals11,
#          archive = "Argi statistics2011.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_Fruittrees12 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", col = c(2,8,15,21,28,34,41,47,54,60,67,70,72,79)),
#     IrriMethod = list(type = "id", row = 5),
#     season = list(type = "id"),
#     planted = list(type = "measured", col = 85:89 , unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = c(6,12,19,25,32,38,45,51,58,64,76,83,89), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.012),
#     production = list(type = "measured", col = c(7,13,20,26,33,39,46,52,59,65,69,71,77,84,90), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Fruit trees",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2012,
#          end = 2012,
#          schema = schema_Fruittrees12,
#          archive = "Fruit trees2012.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_Fruittrees212 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 2),
#     IrriMethod = list(type = "id", row = 4),
#     season = list(type = "id"),
#     planted = list(type = "measured", col = 8, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.012),
#     production = list(type = "measured", col = 7, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Fruit trees2",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2012,
#          end = 2012,
#          schema = schema_Fruittrees212,
#          archive = "Fruit trees2012.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_Citrustrees12 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id"),
#     season = list(type = "id"),
#     AreaProductive = list(type = "measured", col = c(2,5,8,11,15,18,21,24), unit = "ha", factor = 0.1),
#     AreaNonProductive = list(type = "measured", col = c(3,6,9,12,16,19,22,25), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = c(2,5,8,11,15,18,21,24), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.012),
#     production = list(type = "measured", col = c(4,7,10,13,17,20,23,26), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Citrus trees",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2012,
#          end = 2012,
#          schema = schema_Citrustrees12,
#          archive = "Fruit trees2012.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_Wintercereals12 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id", row = 5),
#     planted = list(type = "measured", col = c(2,12,14,17,19,25,31), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(7,13,15,18,20,26,32), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Winter cereals",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2012,
#          end = 2012,
#          schema = schema_Wintercereals12,
#          archive = "Winter cereals_province.xls",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_Summercereals12 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     planted = list(type = "measured", col = c(2,4,6,8,10,12), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(3,5,7,9,11,13), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Summer cereals",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2012,
#          end = 2012,
#          schema = schema_Summercereals12,
#          archive = "Summer cereals_province.xls",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_Wintervegetables12 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     planted = list(type = "measured", col = c(2,4,6,8,10,12,14,17,19,21,23,25,27,29,32,34,36,38,40,42), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(3,5,7,9,11,13,15,18,20,22,24,26,28,30,33,35,37,39,41,43), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Winter vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2012,
#          end = 2012,
#          schema = schema_Wintervegetables12,
#          archive = "Winter vegetables.xls",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_SummerRainfedvegetables12 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     planted = list(type = "measured", col = c(2,4,6,8,10,12,14,17,19,21,23), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(3,5,7,9,11,13,15,18,20,22,24), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Summer Rainfedvegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2012,
#          end = 2012,
#          schema = schema_SummerRainfedvegetables12,
#          archive = "Summer Rainfedvegetables.xls",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_SummerIrrigatedvegetables12 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     planted = list(type = "measured", col = c(2,4,6,8,10,12,14,17,19,21,23,25,27,29,32,34,36), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(3,5,7,9,11,13,15,18,20,22,24,26,28,30,33,35,37), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Summer Irrigatedvegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2012,
#          end = 2012,
#          schema = schema_SummerIrrigatedvegetables12,
#          archive = "Summer Irrigatedvegetables.xls",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_plasticHouses12 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     houseNo = list(type = "measured", col = c(2,4,6,8,10,12,14,16,18,20), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(3,5,7,9,11,13,15,17,19,21), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "plastic houses",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2012,
#          end = 2012,
#          schema = schema_plasticHouses12,
#          archive = "plastic houses.xls",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_AgwarPlasticHouses12 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 2, id = "commodities"),
#   header = list(row = 5:8),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 2),
#     commodities = list(type = "id", row = 5),
#     houseNo = list(type = "measured", col = c(3,5,7,9,11,13), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(4,6,8,10,12,14), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AgwarPlastic houses",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2012,
#          end = 2012,
#          schema = schema_AgwarPlasticHouses12,
#          archive = "plastic houses.xls",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:8 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Land use",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_landuse14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_agriArea14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:4 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Agri area",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_agriArea14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_Agriarea1 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id"),
#     planted = list(type = "measured", col = 2:4 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Agri area1",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_Agriarea1,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse214 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id", row = 5:6, col = 2:6),
#     planted = list(type = "measured", col = 2:6 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "land use2",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_landuse214,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_AWinterVegetables14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 5:7),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id", row = 7),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Winter vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_AWinterVegetables14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_ASummerVegetables14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id", row = 6),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AreaSummer Vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_ASummerVegetables14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_AgriUplands14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", row = 5:8, col = 1),
#     planted = list(type = "measured", col = 2:4, unit = "ha", factor = 0.1),
#     production = list(type = "measured", unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AgriUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_AgriUplands14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesUplands14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesUplands14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesAmman14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesAmman14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesBalqa14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesBalqa14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesZarqa14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesZarqa14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMadaba14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesMadaba14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesIrbid14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesIrbid14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMafraq14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesMafraq14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesJarash14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesJarash14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAjlun14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesAjlun14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesKarak14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesKarak14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesTafiela14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesTafiela14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMaaan14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesMaaan14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAqaba14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesAqaba14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsUplands14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.001),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsUplands14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAmman14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsAmman14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsBalqa14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsBalqa14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsZarqa14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsZarqa14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMadaba14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsMadaba14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsIrbid14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsIrbid14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMafraq14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsMafraq14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsJarash14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsJarash14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAjlun14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsAjlun14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsKarak14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsKarak14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsTafiela14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsTafiela14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMaaan14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsMaaan14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAqaba14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsAqaba14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesUplands14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Uplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesUplands14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAmman14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Amman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesAmman14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesBalqa14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Balqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesBalqa14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesZarqa14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Zarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesZarqa14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMadaba14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Madaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesMadaba14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesIrbid14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Irbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesIrbid14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMafraq14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Mafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesMafraq14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesJarash14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Jarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesJarash14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAjlun14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Ajlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesAjlun14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesKarak14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Karak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesKarak14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesTafiela14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Tafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesTafiela14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMaaan14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Maaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesMaaan14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAqaba14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Aqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesAqaba14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehJ14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesShoonehJ14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesDairAlla14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesDairAlla14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehS14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesShoonehS14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesGhorSafi14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FruitTreesGhorSafi14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAlAghwar14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsAlAghwar14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsSh14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsSh14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsDairAlla14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsDairAlla14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsShoonehSh14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsShoonehSh14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsGhorSafi14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/h", factor = 0.014),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_FieldCropsGhorSafi14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAlAghwar14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/h", factor = 0.014),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesAlAghwar14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesShoonehJa14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.014),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehJanobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesShoonehJa14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesDairAlla14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.014),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesDairAlla14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_VegetablesShoonehSh14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.014),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesShoonehSh14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesGhorSafi14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/h", factor = 0.014),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_VegetablesGhorSafi14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# ```{r register tables Syria, eval=FALSE}
# myUpdate <- TRUE
# schema_Animals14 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 5:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 6),
#     year = list(type = "id", row = 5, col = c(2,5)),
#     production = list(type = "measured", unit = "t", factor = 1),
#     headcount = list(type = "measured", col = 2:7, unit = "h", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Animals",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2014,
#          end = 2014,
#          schema = schema_Animals14,
#          archive = "Argi statistics2014.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     planted = list(type = "measured", col = 2:8 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Land use",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_landuse15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_agriArea15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     planted = list(type = "measured", col = 2:4 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Agri area",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_agriArea15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse215 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id", row = 5:6, col = 2:6),
#     planted = list(type = "measured", col = 2:6 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "land use2",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_landuse215,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_AWinterVegetables15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 5:7),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 4),
#     IrriMethod = list(type = "id", row = 7),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Winter vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_AWinterVegetables15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_ASummerVegetables15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 2),
#     IrriMethod = list(type = "id", row = 6),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AreaSummer Vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_ASummerVegetables15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_AgriUplands15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", row = 5:8, col = 1),
#     planted = list(type = "measured", col = 2:4, unit = "ha", factor = 0.1),
#     production = list(type = "measured", unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AgriUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_AgriUplands15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesUplands15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesUplands15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesAmman15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesAmman15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesBalqa15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesBalqa15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesZarqa15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesZarqa15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMadaba15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesMadaba15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesIrbid15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesIrbid15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMafraq15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesMafraq15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesJarash15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesJarash15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAjlun15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesAjlun15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesKarak15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesKarak15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesTafiela15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesTafiela15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMaaan15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesMaaan15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAqaba15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesAqaba15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsUplands15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsUplands15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAmman15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsAmman15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsBalqa15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsBalqa15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsZarqa15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsZarqa15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMadaba15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsMadaba15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsIrbid15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsIrbid15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMafraq15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsMafraq15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsJarash15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsJarash15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAjlun15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsAjlun15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsKarak15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsKarak15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsTafiela15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsTafiela15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMaaan15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsMaaan15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAqaba15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 2, col = 1, id = "commodities"),
#   header = list(row = 2:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 1, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsAqaba15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesUplands15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Uplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesUplands15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAmman15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Amman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesAmman15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesBalqa15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Balqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesBalqa15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesZarqa15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Zarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesZarqa15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMadaba15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Madaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesMadaba15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesIrbid15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Irbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesIrbid15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMafraq15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Mafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesMafraq15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesJarash15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Jarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesJarash15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAjlun15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Ajlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesAjlun15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesKarak15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Karak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesKarak15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesTafiela15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Tafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesTafiela15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMaaan15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Maaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesMaaan15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAqaba15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Aqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesAqaba15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_AgriAghwar15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", row = 5:8, col = 1),
#     planted = list(type = "measured", col = 2:4, unit = "ha", factor = 0.1),
#     production = list(type = "measured", unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AgriAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_AgriAghwar15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesAlAghwar15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesAlAghwar15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehJ15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesShoonehJ15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesDairAlla15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesDairAlla15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehS15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesShoonehS15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesGhorSafi15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FruitTreesGhorSafi15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAlAghwar15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsAlAghwar15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsSh15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsSh15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FieldCropsShoonehSh15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsShoonehSh15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsGhorSafi15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_FieldCropsGhorSafi15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_VegetablesAlAghwar15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesAlAghwar15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesShoonehJa15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehJanobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesShoonehJa15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesDairAlla15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesDairAlla15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_VegetablesShoonehSh15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesShoonehSh15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesGhorSafi15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_VegetablesGhorSafi15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# ```{r register tables Syria, eval=FALSE}
# myUpdate <- TRUE
# schema_Animals15 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 5:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 6),
#     year = list(type = "id", row = 5, col = c(2,5)),
#     production = list(type = "measured", unit = "t", factor = 1),
#     headcount = list(type = "measured", col = 2:7, unit = "h", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Animals",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2015,
#          end = 2015,
#          schema = schema_Animals15,
#          archive = "Argi statistics2015.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 2),
#     planted = list(type = "measured", col = 2:8 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Land use",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_landuse16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_agriArea16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     planted = list(type = "measured", col = 2:4 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Agri area",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_agriArea16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse216 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 2),
#     IrriMethod = list(type = "id", row = 4:5, col = 2:5),
#     planted = list(type = "measured", col = 2:6 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "land use2",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_landuse216,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_AWinterVegetables16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 5:7),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     IrriMethod = list(type = "id", row = 7),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Winter vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_AWinterVegetables16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_ASummerVegetables16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 2),
#     IrriMethod = list(type = "id", row = 6),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AreaSummer Vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_ASummerVegetables16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_AgriUplands16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", row = 5:8, col = 1),
#     planted = list(type = "measured", col = 2:4, unit = "ha", factor = 0.1),
#     production = list(type = "measured", unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AgriUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_AgriUplands16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesUplands16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesUplands16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesAmman16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesAmman16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesBalqa16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesBalqa16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesZarqa16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesZarqa16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMadaba16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesMadaba16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesIrbid16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesIrbid16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMafraq16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesMafraq16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesJarash16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesJarash16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAjlun16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesAjlun16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesKarak16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesKarak16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesTafiela16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesTafiela16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMaaan16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesMaaan16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAqaba16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesAqaba16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsUplands16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsUplands16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAmman16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsAmman16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsBalqa16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsBalqa16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsZarqa16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsZarqa16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMadaba16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsMadaba16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsIrbid16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsIrbid16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMafraq16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsMafraq16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsJarash16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsJarash16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAjlun16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsAjlun16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsKarak16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsKarak16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsTafiela16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsTafiela16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMaaan16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsMaaan16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAqaba16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 2, col = 1, id = "commodities"),
#   header = list(row = 2:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 1, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsAqaba16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesUplands16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Uplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesUplands16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAmman16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Amman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesAmman16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesBalqa16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Balqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesBalqa16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesZarqa16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Zarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesZarqa16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMadaba16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Madaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesMadaba16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesIrbid16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Irbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesIrbid16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMafraq16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Mafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesMafraq16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesJarash16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Jarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesJarash16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAjlun16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Ajlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesAjlun16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesKarak16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Karak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesKarak16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesTafiela16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Tafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesTafiela16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMaaan16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Maaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesMaaan16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAqaba16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Aqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesAqaba16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_AgriAghwar16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", row = 5:7, col = 1),
#     planted = list(type = "measured", col = 2:4, unit = "ha", factor = 0.1),
#     production = list(type = "measured", unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AgriAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_AgriAghwar16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesAlAghwar16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesAlAghwar16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehJ16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesShoonehJ16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesDairAlla16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesDairAlla16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehS16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesShoonehS16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesGhorSafi16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FruitTreesGhorSafi16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAlAghwar16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsAlAghwar16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsSh16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsSh16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FieldCropsShoonehSh16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsShoonehSh16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsGhorSafi16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsGhorSafi16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsDairAlla16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_FieldCropsDairAlla16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAlAghwar16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesAlAghwar16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesShoonehJa16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehJanobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesShoonehJa16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesDairAlla16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesDairAlla16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_VegetablesShoonehSh16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesShoonehSh16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesGhorSafi16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_VegetablesGhorSafi16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# ```{r register tables Syria, eval=FALSE}
# myUpdate <- TRUE
# schema_Animals16 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 5:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 6),
#     year = list(type = "id", row = 5, col = c(2,5)),
#     production = list(type = "measured", unit = "t", factor = 1),
#     headcount = list(type = "measured", col = 2:7, unit = "h", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Animals",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2016,
#          end = 2016,
#          schema = schema_Animals16,
#          archive = "Argi statistics2016.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_landuse17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 2),
#     planted = list(type = "measured", col = 2:8 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Land use",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_landuse17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_agriArea17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     planted = list(type = "measured", col = 2:4 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Agri area",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_agriArea17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_landuse217 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 2),
#     IrriMethod = list(type = "id", row = 4:5, col = 2:5),
#     planted = list(type = "measured", col = 2:6 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "land use2",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_landuse217,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_AWinterVegetables17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 2),
#     IrriMethod = list(type = "id", row = 6),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Winter vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_AWinterVegetables17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_ASummerVegetables17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:6),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 2),
#     IrriMethod = list(type = "id", row = 6),
#     planted = list(type = "measured", col = 2:10 , unit = "ha", factor = 0.1),
#     production = list(type = "measured" , unit = "t", factor = 1),
#     yield = list(type = "measured", unit = "t/ha", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AreaSummer Vegetables",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_ASummerVegetables17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_AgriUplands17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", row = 5:8, col = 1),
#     planted = list(type = "measured", col = 2:4, unit = "ha", factor = 0.1),
#     production = list(type = "measured", unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AgriUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_AgriUplands17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesUplands17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesUplands17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesAmman17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesAmman17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesBalqa17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesBalqa17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesZarqa17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesZarqa17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMadaba17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 1, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesMadaba17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesIrbid17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesIrbid17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMafraq17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesMafraq17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesJarash17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 1, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesJarash17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAjlun17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 1, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesAjlun17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesKarak17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesKarak17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesTafiela17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, id = "commodities"),
#   header = list(row = 5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesTafiela17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesMaaan17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesMaaan17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesAqaba17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreeAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesAqaba17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsUplands17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsUplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsUplands17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAmman17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAmman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsAmman17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsBalqa17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsBalqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsBalqa17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsZarqa17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsZarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsZarqa17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMadaba17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMadaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsMadaba17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsIrbid17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsIrbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsIrbid17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMafraq17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsMafraq17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsJarash17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsJarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsJarash17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAjlun17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAjlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsAjlun17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsKarak17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsKarak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsKarak17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsTafiela17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsTafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsTafiela17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsMaaan17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsMaaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsMaaan17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAqaba17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 2, col = 1, id = "commodities"),
#   header = list(row = 2:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 1, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Field CropsAqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsAqaba17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesUplands17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Uplands",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesUplands17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAmman17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Amman",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesAmman17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesBalqa17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Balqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesBalqa17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesZarqa17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Zarqa",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesZarqa17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMadaba17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1) )))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Madaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesMadaba17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesIrbid17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Irbid",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesIrbid17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMafraq17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Mafraq",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesMafraq17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesJarash17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Jarash",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesJarash17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAjlun17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Ajlun",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesAjlun17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesKarak17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Karak",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesKarak17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesTafiela17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Tafiela",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesTafiela17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesMaaan17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Maaan",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesMaaan17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAqaba17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables Aqaba",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesAqaba17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_AgriAghwar17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 3, col = 1),
#     commodities = list(type = "id", row = 5:7, col = 1),
#     planted = list(type = "measured", col = 2:4, unit = "ha", factor = 0.1),
#     production = list(type = "measured", unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "AgriAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_AgriAghwar17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FruitTreesAlAghwar17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 4,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =3,  unit = "tree")),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesAlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesAlAghwar17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehJ17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 1, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col = 4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTreesShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesShoonehJ17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesDairAlla17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 1, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesDairAlla17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesShoonehS17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 1, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesShoonehS17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FruitTreesGhorSafi17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 1, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 6, unit = "ha", factor = 0.1),
#     treecount = list(type = "measured", col = 5,  unit = "tree")),
#   Productivetrees = list(type = "measured", col =4,  unit = "tree")),
#   yield = list(type = "measured", col = 3, unit = "t/tree", factor = 0.001),
#   production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FruitTrees GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FruitTreesGhorSafi17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsAlAghwar17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 1, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 3, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsAlAghwar17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsSh17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehJanoobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsSh17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_FieldCropsShoonehSh17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsShoonehSh17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# ##
#
# schema_FieldCropsGhorSafi17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsGhorSafi17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_FieldCropsDairAlla17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     planted = list(type = "measured", col = 5, unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", col = 4, unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = 3, unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = 2, unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "FieldCrops DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_FieldCropsDairAlla17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesAlAghwar17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 4, col = 1, id = "commodities"),
#   header = list(row = 4:5),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(4,6)),
#     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables AlAghwar",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesAlAghwar17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesShoonehJa17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehJanobiyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesShoonehJa17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesDairAlla17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 4, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables DairAlla",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesDairAlla17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
#
#
# schema_VegetablesShoonehSh17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables ShoonehShamaliyeh",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesShoonehSh17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
# schema_VegetablesGhorSafi17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 3, col = 1, id = "commodities"),
#   header = list(row = 3:4),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", row = 2, col = 1),
#     commodities = list(type = "id", col = 1),
#     season = list(type = "id", row = 3, col = c(2,5)),
#     planted = list(type = "measured", col = c(4,7), unit = "ha", factor = 0.1),
#     harvested = list(type = "measured", unit = "ha", factor = 0.1),
#     yield = list(type = "measured", col = c(3,6), unit = "t/ha", factor = 0.011),
#     production = list(type = "measured", col = c(2,5), unit = "t", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Vegetables GhorSafi",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_VegetablesGhorSafi17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)
#
#
# myUpdate <- TRUE
# schema_Animals17 <- makeSchema(schema = list(
#   clusters =
#     list(row = 2, col = 1, id = "commodities"),
#   header = list(row = 2:3),
#   meta = list(del = ","),
#   variables = list(
#     al2 = list(type = "id", col = 1),
#     commodities = list(type = "id", row = 3),
#     year = list(type = "id", row = 2, col = c(2,5)),
#     production = list(type = "measured", unit = "t", factor = 1),
#     headcount = list(type = "measured", col = 2:7, unit = "h", factor = 1))))
# regTable(nation = "Jordan",
#          level = 2,
#          subset = "Animals",
#          dSeries = "DoS",
#          gSeries = "GADM",
#          begin = 2017,
#          end = 2017,
#          schema = schema_Animals17,
#          archive = "Argi statistics2017.pdf",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)


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
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg",
#              update = updateTables)

normGeometry(pattern = gs[],
             outType = "gpkg",
             update = updateTables)


# normalise census tables ----
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
          ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)

