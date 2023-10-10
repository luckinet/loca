# script arguments ----
#
thisNation <- "Morocco"

updateTables <- FALSE
overwriteTables <- FALSE

ds <- c("unodc", "hpc", "maroc-maps")
gs <- c("gadm", "maroc-maps")


# register dataseries ----
#
# regDataseries(name = ds[1],
#               description = "High Commission for Planning of Morocco",
#               homepage = "www.hcp.ma",
#               licence_link = "unknown",
#               licence_path = "unknown",
#               notes = "data are public domain",
#               update = updateTables)

# regDataseries(name = gs[2],
#               description = "Maroc Maps",
#               homepage = "http://maroc-maps.blogspot.com/",
#               licence_link = "unknown",
#               licence_path = "unknown",
#               notes = "data are public domain",
#               update = updateTables)


# register geometries ----
#
### maroc-maps ----
# regGeometry(nation = "Morocco",
#             gSeries = "maroc-maps", # change the source dataseries here
#             level = 1,
#             nameCol = "Name",
#             archive = "Morocco - Eaux territoriales.zip| Morocco.shp",
#             archiveLink = "", #find out link
#             nextUpdate = "unknow",
#             updateFrequency = "unknown",
#             update = updateTables)
#
# regGeometry(nation = "Morocco",
#             gSeries = "GADM", # change the source dataseries here
#             level = 2,
#             nameCol = "Name",
#             archive = "mar_adm_unhcr2020_shp.zip| MAR_adm1.shp",
#             archiveLink = "", #find out link
#             nextUpdate = "unknow",
#             updateFrequency = "unknown",
#             update = updateTables)
#
# regGeometry(nation = "Morocco",
#             gSeries = gs[2],
#             level = 3,
#             nameCol = "Name",
#             archive = "Provinces & Préfecture.zip| Provinces & Préfecture.shp",
#             archiveLink = "", #find out link
#             nextUpdate = "unknow",
#             updateFrequency = "unknown",
#             update = updateTables)


# 3. register census tables ----
#
## crops ----
if(build_crops){

  ### unodc ----
  schema_mar_01 <-
    setFilter(rows = .find("Total", col = 1), invert = TRUE) %>%
    setIDVar(name = "al3", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2,4)) %>%
    setIDVar(name = "commodities", value = "cannabis") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2,4))

  regTable(nation = "mar",
           level = 3,
           subset = "plantedCanabis",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mar_01,
           begin = 2003,
           end = 2005,
           archive = "Morocco_survey_2005.pdf|p.10",
           archiveLink = "https://www.unodc.org/pdf/research/Morocco_survey_2005.pdf",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Morocco",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  ### maroc-maps ----
  # schema_SpinachWint16 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1),
  #     planted = list(type = "measured", row = 4:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "CULTURE DES CEREALES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2016,
  #          end = 2016,
  #          schema = schema_SpinachWint16,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_debledur16 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1),
  #     planted = list(type = "measured", row = 4:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "Culture de ble dur",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2009,
  #          end = 2016,
  #          schema = schema_debledur16,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DUBLETENDRE16 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1),
  #     planted = list(type = "measured", row = 4:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "CULTURE DU BLE TENDRE",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2009,
  #          end = 2016,
  #          schema = schema_DUBLETENDRE16,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DUMAIS16 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1),
  #     planted = list(type = "measured", row = 4:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "CULTURE DU MAIS",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2009,
  #          end = 2016,
  #          schema = schema_DUMAIS16,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_CULTUREDELORGE16 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1),
  #     planted = list(type = "measured", row = 4:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "CULTURE DE LORGE",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2009,
  #          end = 2016,
  #          schema = schema_CULTUREDELORGE16,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_CULTUREDESLEGUMINEUSES16 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1),
  #     planted = list(type = "measured", row = 4:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "CULTURE DES LEGUMINEUSES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2009,
  #          end = 2016,
  #          schema = schema_CULTUREDESLEGUMINEUSES16,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_CULTUREDESFEVES16 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1),
  #     planted = list(type = "measured", row = 4:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "CULTURE DES FEVES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2009,
  #          end = 2016,
  #          schema = schema_CULTUREDESFEVES16,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_CULTUREDESPETITSPOIS16 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1),
  #     planted = list(type = "measured", row = 4:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "CULTURE DES PETITS POIS",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2009,
  #          end = 2016,
  #          schema = schema_CULTUREDESPETITSPOIS16,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESPOISCHICHES16 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1),
  #     planted = list(type = "measured", row = 4:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DES POIS CHICHES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2009,
  #          end = 2016,
  #          schema = schema_DESPOISCHICHES16,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESLENTILLES16 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1),
  #     planted = list(type = "measured", row = 4:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DES DES LENTILLES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2016,
  #          schema = schema_DESLENTILLES16,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_INDUSTRIELLES16 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = c(4,8,12,16,20,24), col = 1),
  #     commodities = list(type = "id", col = 1),
  #     planted = list(type = "measured", row = 3:14, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 17:26, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "INDUSTRIELLES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2009,
  #          end = 2016,
  #          schema = schema_INDUSTRIELLES16,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_OLEAGINEUSES16 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = c(4,8,12,16,20,24), col = 1),
  #     commodities = list(type = "id", col = 1),
  #     planted = list(type = "measured", row = 3:11, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 13:20, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "OLEAGINEUSES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2009,
  #          end = 2016,
  #          schema = schema_OLEAGINEUSES16,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_MARAICHERESETFOURRAGERES15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 2),
  #     commodities = list(type = "id", row = 3:20, col = 1),
  #     planted = list(type = "measured", row = 3:20, unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "MARAICHERES ET FOURRAGERES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2015,
  #          schema = schema_MARAICHERESETFOURRAGERES15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_PMARAICHERESETFOURRAGERES15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 2, col = 1),
  #     commodities = list(type = "id", row = 3:20, col = 1),
  #     planted = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", row = 3:19, unit = "t", factor = 0.1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "PRODUCTION MARAICHERES ET FOURRAGERES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2015,
  #          schema = schema_PMARAICHERESETFOURRAGERES15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_PLANTATIONSFRUITIERES <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 2),
  #     commodities = list(type = "id", row = 3:10, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1),
  #     production = list(type = "measured", row =NULL, unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "SUPERFICIE DES PLANTATIONS FRUITIERES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2015,
  #          schema = schema_PLANTATIONSFRUITIERES,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_PrPLANTATIONSFRUITIERES15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 2),
  #     commodities = list(type = "id", row = 3:10, col = 1),
  #     planted = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", row = 3:10, unit = "t", factor = 0.1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "PRODUCTION DES PLANTATIONS FRUITIERES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2015,
  #          schema = schema_PrPLANTATIONSFRUITIERES15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESANIMAUXDETRAIT15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 1),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 2),
  #     commodities = list(type = "id", row = 3:10, col = 1),
  #     headcount = list(type = "measured", col = 2:9, unit = "h", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DU CHEPTEL ET DES ANIMAUX DE TRAIT",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2015,
  #          end = 2015,
  #          schema = schema_DESANIMAUXDETRAIT15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESANIMAUXDETRAIT15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id"),
  #     headcount = list(type = "measured", col = 2:10, unit = "h", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DES ANIMAUX DE TRAIT",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2007,
  #          end = 2015,
  #          schema = schema_DESANIMAUXDETRAIT15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_boisees15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 1),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 2),
  #     commodities = list(type = "id", row = 3:14, col = 1),
  #     planted = list(type = "measured", row = 3:14, unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 0.1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "Zones boisees",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2015,
  #          end = 2015,
  #          schema = schema_boisees15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_forestieres15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 1),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 2),
  #     commodities = list(type = "id", row = 3:8, col = 1),
  #     planted = list(type = "measured", row = 3:8, unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 0.1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "forestieres",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2015,
  #          end = 2015,
  #          schema = schema_forestieres15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESLEGUMINEUSES15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DES LEGUMINEUSES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2015,
  #          schema = schema_DESLEGUMINEUSES15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESFEVES15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DES FEVES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2015,
  #          schema = schema_DESFEVES15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESPETITSPOIS15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DES PETITS POIS",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2015,
  #          schema = schema_DESPETITSPOIS15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESPOISCHICHES15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DES  POIS CHICHES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2015,
  #          schema = schema_DESPOISCHICHES15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESLENTILLES15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DES LENTILLES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2015,
  #          schema = schema_DESLENTILLES15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_INDUSTRIELLES15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:14, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 16:26, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "INDUSTRIELLES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2015,
  #          schema = schema_INDUSTRIELLES15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_OLEAGINEUSES15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:11, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 13:20, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "OLEAGINEUSES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2015,
  #          schema = schema_OLEAGINEUSES15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DELORGE15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DE LORGE",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2015,
  #          schema = schema_DELORGE15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESCEREALES15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DES CEREALES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2015,
  #          schema = schema_DESCEREALES15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DUBLEDUR15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DU BLE DUR",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2015,
  #          schema = schema_DUBLEDUR15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_CULTUREDUBLETENDRE15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "CULTURE DU BLE TENDRE",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2015,
  #          schema = schema_CULTUREDUBLETENDRE15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DUMAIS15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DU MAIS",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2015,
  #          schema = schema_DUMAIS15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_EffectifduCheptel15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1),
  #     headcount = list(type = "measured", col = 2:10, unit = "h", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "Effectif du Cheptel",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2015,
  #          end = 2016,
  #          schema = schema_EffectifduCheptel15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DUMAIS15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DU MAIS",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2015,
  #          schema = schema_DUMAIS15,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DELORGE14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     year = list(type = "id", row = 2, col = 2:9, rel = TRUE),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DE LORGE",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2007,
  #          end = 2014,
  #          schema = schema_DELORGE14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESCEREALES14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     year = list(type = "id", row = 2, col = 2:9, rel = TRUE),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DES CEREALES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2007,
  #          end = 2014,
  #          schema = schema_DESCEREALES14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESFEVES14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     year = list(type = "id", row = 2, col = 2:9, rel = TRUE),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DES FEVES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2007,
  #          end = 2014,
  #          schema = schema_DESFEVES14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESLEGUMINEUSES14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     year = list(type = "id", row = 2, col = 2:9, rel = TRUE),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DES LEGUMINEUSES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2007,
  #          end = 2014,
  #          schema = schema_DESLEGUMINEUSES14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESLENTILLES14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     year = list(type = "id", row = 2, col = 2:9, rel = TRUE),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DES LENTILLES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2007,
  #          end = 2014,
  #          schema = schema_DESLENTILLES14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESPETITSPOIS14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     year = list(type = "id", row = 2, col = 2:9, rel = TRUE),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DES PETITS POIS",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2007,
  #          end = 2014,
  #          schema = schema_DESPETITSPOIS14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESPOISCHICHES14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     year = list(type = "id", row = 2, col = 2:9, rel = TRUE),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DES POIS CHICHES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2007,
  #          end = 2014,
  #          schema = schema_DESPOISCHICHES14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_Bledur14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     year = list(type = "id", row = 2, col = 2:9, rel = TRUE),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "Ble dur",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2007,
  #          end = 2014,
  #          schema = schema_Bledur14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_BleTENDRE14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     year = list(type = "id", row = 2, col = 2:9, rel = TRUE),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "BLE TENDRE",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2007,
  #          end = 2014,
  #          schema = schema_BleTENDRE14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DUMAIS14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     year = list(type = "id", row = 2, col = 2:9, rel = TRUE),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DU MAIS",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2007,
  #          end = 2014,
  #          schema = schema_DUMAIS14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_INDUSTRIELLES14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     year = list(type = "id", row = 2, col = 2:9, rel = TRUE),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:10, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 12:18, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "INDUSTRIELLES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2007,
  #          end = 2014,
  #          schema = schema_INDUSTRIELLES14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_OLEAGINEUSES14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     year = list(type = "id", row = 2, col = 2:9, rel = TRUE),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:11, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 13:20, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "OLEAGINEUSES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2007,
  #          end = 2014,
  #          schema = schema_OLEAGINEUSES14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_forestieres14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 1),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 2),
  #     commodities = list(type = "id", row = 3:6, col = 1),
  #     planted = list(type = "measured", row = 3:6, unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 0.1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "forestieres",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2014,
  #          schema = schema_forestieres14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_FRUITIERES14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:11, unit = "ha", factor = 1000),
  #     production = list(type = "measured", row = 13:20, unit = "t", factor = 100)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "ZOne FRUITIERES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2007,
  #          end = 2014,
  #          schema = schema_FRUITIERES14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESANIMAUXDETRAIT14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 1),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 2),
  #     commodities = list(type = "id", row = 3:10, col = 1),
  #     headcount = list(type = "measured", col = 2:9, unit = "h", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DU CHEPTEL ET DES ANIMAUX DE TRAIT",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2014,
  #          schema = schema_DESANIMAUXDETRAIT14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_PFRUITIERES14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", row = 3:20, unit = "t", factor = 0.1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "Product MARAICHERES ET FOURRAGERES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2014,
  #          schema = schema_PFRUITIERES14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_ZFRUITIERES14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     planted = list(type = "measured", row = 3:20, unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 0.1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "Zone MARAICHERES ET FOURRAGERES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2014,
  #          schema = schema_ZFRUITIERES14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_ZFRUITIERES14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 2),
  #     commodities = list(type = "id", col = 1),
  #     planted = list(type = "measured", col = 2:9, unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 0.1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "Zone FRUITIERES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2014,
  #          schema = schema_ZFRUITIERES14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_REBOISEES14 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 2),
  #     commodities = list(type = "id", col = 1),
  #     planted = list(type = "measured", col = 2:10, unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 0.1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "Zone REBOISEES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2014,
  #          schema = schema_REBOISEES14,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_maraicheres11 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 3),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 3),
  #     commodities = list(type = "id", col = 2:11),
  #     planted = list(type = "measured", row = 5:22, col = c(3,5,7), unit = "ha", factor = 1),
  #     production = list(type = "measured", row = 31:48, col = 2:11 , unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "maraicheres",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2010,
  #          end = 2011,
  #          schema = schema_maraicheres11,
  #          archive = "Annuaire statistique de la region Souss-Massa-Draa 2012.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_DESANIMAUXDETRAIT11 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 1),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 2),
  #     commodities = list(type = "id", row = 3:11, col = 1),
  #     headcount = list(type = "measured", col = 2:5, unit = "h", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "DU CHEPTEL ET DES ANIMAUX DE TRAIT",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2010,
  #          end = 2011,
  #          schema = schema_DESANIMAUXDETRAIT11,
  #          archive = "Annuaire statistique de la region Souss-Massa-Draa 2012.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_Effectifsducheptel11 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 1),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 2),
  #     headcount = list(type = "measured", col = 2:6, unit = "h", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "Effectifs du cheptel",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2010,
  #          end = 2011,
  #          schema = schema_Effectifsducheptel11,
  #          archive = "Annuaire statistique de la region Souss-Massa-Draa 2012.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_descereales11 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 3, col = 1, id = "commodities"),
  #   header = list(row = 3),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 3, col = 2:6),
  #     planted = list(type = "measured", row = 4:12, col = 2:6, unit = "ha", factor = 1),
  #     production = list(type = "measured", row = 19:27, col = 2:6 , unit = "t", factor = 0.1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "des cereales",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2010,
  #          end = 2011,
  #          schema = schema_descereales11,
  #          archive = "Annuaire statistique de la region Souss-Massa-Draa 2012.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_descereales11 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 3, col = 1, id = "commodities"),
  #   header = list(row = 3),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 2, col = 2:3),
  #     planted = list(type = "measured", col = 2:3, unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 0.1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "des Essences Resineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2010,
  #          end = 2011,
  #          schema = schema_descereales11,
  #          archive = "Annuaire statistique de la region Souss-Massa-Draa 2012.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_agrumicoles11 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2:3),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 2),
  #     commodities = list(type = "id", row = c(2,5,8,12,16), col =1),
  #     planted = list(type = "measured", col = 5, unit = "ha", factor = 1),
  #     production = list(type = "measured", col = 4, unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "agrumicoles",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2010,
  #          end = 2011,
  #          schema = schema_agrumicoles11,
  #          archive = "Annuaire statistique de la region Souss-Massa-Draa 2012.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_industrielles11 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2:3),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 2, col = c(2,4,6)),
  #     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "industrielles",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2010,
  #          end = 2011,
  #          schema = schema_industrielles11,
  #          archive = "Annuaire statistique de la region Souss-Massa-Draa 2012.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_desessencesfeuillues11 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 2, col = 2:5),
  #     planted = list(type = "measured", col =2:5, unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "des essences feuillues",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2011,
  #          end = 2011,
  #          schema = schema_desessencesfeuillues11,
  #          archive = "Annuaire statistique de la region Souss-Massa-Draa 2012.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_desessencesnaturelles11 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2:4),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 4, col = 2:5),
  #     planted = list(type = "measured", col =2:5, unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "des essences naturelles",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2011,
  #          end = 2011,
  #          schema = schema_desessencesnaturelles11,
  #          archive = "Annuaire statistique de la region Souss-Massa-Draa 2012.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_Superficiesreboisees11 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2:3),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 4, col = 2:3),
  #     planted = list(type = "measured", col =2:3, unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "Superficies reboisees",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2011,
  #          end = 2011,
  #          schema = schema_Superficiesreboisees11,
  #          archive = "Annuaire statistique de la region Souss-Massa-Draa 2012.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_fourrageres11 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2:3),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 2),
  #     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "fourrageres",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2010,
  #          end = 2011,
  #          schema = schema_fourrageres11,
  #          archive = "Annuaire statistique de la region Souss-Massa-Draa 2012.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_Superficierégionalecultivable10 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 4, col = 1, id = "commodities"),
  #   header = list(row = 4:5),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 2, col = 1),
  #     commodities = list(type = "id", row = 6:8),
  #     planted = list(type = "measured", row = 6:8, col = 2:3, unit = "ha", factor = 1),
  #     yield =
  #       list(type = "measured", col = 4:5, unit = "t/ha", factor = 0.1),
  #     production = list(type = "measured", row = 6:8, col = 6:7, unit = "t", factor = 0.1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "Superficie regionale cultivable",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2009,
  #          schema = schema_Superficierégionalecultivable10,
  #          archive = "Annuaire statistique de la region dOued Eddahab-Lagouira 2010.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_productionsagricoles10 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1, id = "commodities"),
  #   header = list(row = 2:3),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 9, col = 1),
  #     commodities = list(type = "id", row = 4:6),
  #     planted = list(type = "measured", unit = "ha", factor = 1),
  #     yield =
  #       list(type = "measured", col = 2:3, unit = "t/ha", factor = 0.1),
  #     production = list(type = "measured", row = 6:8, col = 4:5, unit = "t", factor = 0.1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "productions  agricoles",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2007,
  #          end = 2009,
  #          schema = schema_productionsagricoles10,
  #          archive = "Annuaire statistique de la region dOued Eddahab-Lagouira 2010.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_Effectifsducheptel11 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 6, col = 1, id = "commodities"),
  #   header = list(row = 6),
  #   meta = list(del = "."),
  #   variables = list(
  #     al2 = list(type = "id", row = 2, col = 1),
  #     commodities = list(type = "id", row = 7:10),
  #     headcount = list(type = "measured", col = 2, unit = "h", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "Effectifs du cheptel",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2008,
  #          end = 2009,
  #          schema = schema_Superficierégionalecultivable10,
  #          archive = "Annuaire statistique de la region dOued Eddahab-Lagouira 2010.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_descereales13 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5:7, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col =c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100,  rel = TRUE),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1,  rel = TRUE)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des cereales",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2010,
  #          end = 2013,
  #          schema = schema_descereales13,
  #          archive = "Annuaire Statistique du Maroc, année 2013.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)

  # schema_deslegumineuses13 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5:7, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col =c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "la superficie des legumineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2010,
  #          end = 2013,
  #          schema = schema_deslegumineuses13,
  #          archive = "Annuaire Statistique du Maroc, année 2013.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)

  # schema_industrielles13 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5:8, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col =c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "industrielles",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2010,
  #          end = 2013,
  #          schema = schema_industrielles13,
  #          archive = "Annuaire Statistique du Maroc, année 2013.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_desoleagineuses13 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5:8, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col =c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "la superficie des oleagineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2010,
  #          end = 2013,
  #          schema = schema_desoleagineuses13,
  #          archive = "Annuaire Statistique du Maroc, année 2013.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)

  # schema_Superficiesreboisees13 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col = 2:3, unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Superficies reboisees",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2011,
  #          end = 2012,
  #          schema = schema_Superficiesreboisees13,
  #          archive = "Annuaire Statistique du Maroc, année 2013.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Superficiesreboisees2_13 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 2, col = 1,  id = NULL),
  #   header = list(row = 2:3, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col = 2:3, unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Superficies reboisees2",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2011,
  #          end = 2012,
  #          schema = schema_Superficiesreboisees2_13,
  #          archive = "Annuaire Statistique du Maroc, année 2013.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_des_essences_forestieres13 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 7, col = 1,  id = NULL),
  #   header = list(row = 7:10, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", col = 3:7, rel = F),
  #     planted = list(type = "measured", col = 2:7
  #                    , unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des essences forestieres",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2011,
  #          end = 2011,
  #          schema = schema_des_essences_forestieres13,
  #          archive = "Annuaire Statistique du Maroc, année 2013.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_des_essences_resineuses13 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 6, col = 1,  id = NULL),
  #   header = list(row = 6:7, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 7, col = 2:7, rel = F),
  #     planted = list(type = "measured", col = 2:7, unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des essences resineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2011,
  #          end = 2011,
  #          schema = schema_des_essences_resineuses13,
  #          archive = "Annuaire Statistique du Maroc, année 2013.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_descereales15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 3, col = 1,  id = NULL),
  #   header = list(row = 3:5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col =c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100,  rel = TRUE),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1,  rel = TRUE)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des cereales",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2011,
  #          end = 2014,
  #          schema = schema_descereales15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)


  # schema_deslegumineuses15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 3, col = 1,  id = NULL),
  #   header = list(row = 3:5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col =c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "la superficie des legumineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2010,
  #          end = 2015,
  #          schema = schema_deslegumineuses15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_desprincipaleslegumineuses15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:5, rel = F),
  #     planted = list(type = "measured", col = 2:5, unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Superficie des principales legumineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2014,
  #          schema = schema_desprincipaleslegumineuses15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = FALSE)
  #
  #
  # schema_Productionslegumineuses15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:5, rel = F),
  #     planted = list(type = "measured", unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = 2:5, unit = "t", factor = 1000),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Productions des principales legumineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2014,
  #          schema = schema_Productionslegumineuses15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_industrielles15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5:6, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col =c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "industrielles",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2011,
  #          end = 2014,
  #          schema = schema_industrielles15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_desoleagineuses15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5:6, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col =c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "la superficie des oleagineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2011,
  #          end = 2014,
  #          schema = schema_desoleagineuses15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Effectif_ducheptel15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     headcount = list(type = "measured", col = 2:4, unit = "n", factor = 1000)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Effectif du cheptel",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2014,
  #          schema = schema_Effectif_ducheptel15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Effectif_desbovinsl15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     headcount = list(type = "measured", col = 2:4, unit = "n", factor = 1000)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Effectif des bovins",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2014,
  #          schema = schema_Effectif_desbovinsl15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Effectif_desanimaux15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 5, col = 2:4, rel = F),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     headcount = list(type = "measured", col = 2:4, unit = "n", factor = 1000)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Effectif des animaux",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2011,
  #          end = 2011,
  #          schema = schema_Effectif_desanimaux15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Superficiesreboisees15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 4, col = 1,  id = NULL),
  #   header = list(row = 4:5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col = 2:3, unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Superficies reboisees",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2014,
  #          schema = schema_Superficiesreboisees15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Superficiesreboisees2_15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row =4, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col = 2:3, unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Superficies reboisees2",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2014,
  #          schema = schema_Superficiesreboisees2_15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_des_essences_forestieres15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 8, col = 1,  id = NULL),
  #   header = list(row = 5:7, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 7, col = 2:7, rel = F),
  #     planted = list(type = "measured", col = 2:7
  #                    , unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des essences forestieres",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2014,
  #          schema = schema_des_essences_forestieres15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_des_essences_resineuses15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 9, col = 1,  id = NULL),
  #   header = list(row = 7:8, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 8, col = 2:7, rel = F),
  #     planted = list(type = "measured", col = 2:7, unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des essences resineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2014,
  #          schema = schema_des_essences_resineuses15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_des_essences_feuillues15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 9, col = 1,  id = NULL),
  #   header = list(row = 7:8, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 8, col = 2:6, rel = F),
  #     planted = list(type = "measured", col = 2:6, unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des essences feuillues",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2014,
  #          schema = schema_des_essences_feuillues15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_descereales17 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 9, col = 1,  id = NULL),
  #   header = list(row = 8, rel = F, merge = F),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col =c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100,  rel = TRUE),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1,  rel = TRUE)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des cereales",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2016,
  #          schema = schema_descereales17,
  #          archive = "Annuaire Statistique du Maroc, année 2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_desprincipalescereales17 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 6, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:5, rel = F),
  #     planted = list(type = "measured", col = 2:5, unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des principales cereales",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2015,
  #          end = 2016,
  #          schema = schema_desprincipalescereales17,
  #          archive = "Annuaire Statistique du Maroc, année 2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Productionscereales17 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 6, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:5, rel = F),
  #     planted = list(type = "measured", unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = 2:5, unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Productions des principales cereales",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2015,
  #          end = 2016,
  #          schema = schema_Productionscereales17,
  #          archive = "Annuaire Statistique du Maroc, année 2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = FALSE)
  #
  #
  # schema_deslegumineuses17 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col =c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "la superficie des legumineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2010,
  #          end = 2017,
  #          schema = schema_deslegumineuses17,
  #          archive = "Annuaire Statistique du Maroc, année 2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_desprincipaleslegumineuses17 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:5, rel = F),
  #     planted = list(type = "measured", col = 2:5, unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Superficie des principales legumineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2015,
  #          end = 2016,
  #          schema = schema_desprincipaleslegumineuses17,
  #          archive = "Annuaire Statistique du Maroc, année 2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = FALSE)
  #
  #
  # schema_Productionslegumineuses17 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:5, rel = F),
  #     planted = list(type = "measured", unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = 2:5, unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Productions des principales legumineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2015,
  #          end = 2016,
  #          schema = schema_Productionslegumineuses17,
  #          archive = "Annuaire Statistique du Maroc, année 2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_idesculturessucrieres17 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5:6, rel = F, merge = F),
  #
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col =c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des cultures sucrieres",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2016,
  #          schema = schema_idesculturessucrieres17,
  #          archive = "Annuaire Statistique du Maroc, année 2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_desoleagineuses17 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5:6, rel = F, merge = F),
  #
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col =c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "la superficie des oleagineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2016,
  #          schema = schema_desoleagineuses17,
  #          archive = "Annuaire Statistique du Maroc, année 2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Effectif_ducheptel17 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5:6, rel = F, merge = F),
  #
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     headcount = list(type = "measured", col = 2:4, unit = "n", factor = 1000)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Effectif du cheptel",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2015,
  #          schema = schema_Effectif_ducheptel17,
  #          archive = "Annuaire Statistique du Maroc, année 2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Effectif_desbovinsl17 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5:6, rel = F, merge = F),
  #
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     headcount = list(type = "measured", col = 2:4, unit = "n", factor = 1000)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Effectif des bovins",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2015,
  #          schema = schema_Effectif_desbovinsl17,
  #          archive = "Annuaire Statistique du Maroc, année 2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Superficiesreboisees17 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 6, col = 1,  id = NULL),
  #   header = list(row = 6:8, rel = F, merge = F),
  #
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col = 2:3, unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level = 3,
  #          subset = "Superficies reboisees",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2015,
  #          end = 2016,
  #          schema = schema_Superficiesreboisees17,
  #          archive = "Annuaire Statistique du Maroc, année 2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Superficiesreboisees2_17 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5:6, rel = F, merge = F),
  #
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col = 2:3, unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Superficies reboisees2",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2015,
  #          schema = schema_Superficiesreboisees2_17,
  #          archive = "Annuaire Statistique du Maroc, année 2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_des_essences_forestieres17 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 7, col = 1,  id = NULL),
  #   header = list(row = 7:8, rel = F, merge = F),
  #
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 7, col = 2:7, rel = F),
  #     planted = list(type = "measured", col = 2:7
  #                    , unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des essences forestieres",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2016,
  #          end = 2016,
  #          schema = schema_des_essences_forestieres17,
  #          archive = "Annuaire Statistique du Maroc, année 2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_des_essences_resineuses17 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 4, col = 1,  id = NULL),
  #   header = list(row = 4, rel = F, merge = F),
  #
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 8, col = 1:2, rel = F),
  #     planted = list(type = "measured", col = 2:7, unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des essences resineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2016,
  #          end = 2016,
  #          schema = schema_des_essences_resineuses17,
  #          archive = "Annuaire Statistique du Maroc, année 2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_des_essences_feuillues17 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 7, col = 1,  id = NULL),
  #   header = list(row = 7:9, rel = F, merge = F),
  #
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 8, col = 2:6, rel = F),
  #     planted = list(type = "measured", col = 2:6, unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des essences feuillues",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2016,
  #          end = 2016,
  #          schema = schema_des_essences_feuillues17,
  #          archive = "Annuaire Statistique du Maroc, année 2017.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_descereales18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 4, col = 1,  id = NULL),
  #   header = list(row = 4:6, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 2:3, col = 1, rel = F),
  #     planted = list(type = "measured", col =c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100,  rel = TRUE),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1,  rel = TRUE)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des cereales",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2018,
  #          schema = schema_descereales18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_desprincipalescereales18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:5, rel = F),
  #     planted = list(type = "measured", col = 2:5, unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des principales cereales",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2016,
  #          end = 2017,
  #          schema = schema_desprincipalescereales18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Productionscereales18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:5, rel = F),
  #     planted = list(type = "measured", unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = 2:5, unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Productions des principales cereales",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2016,
  #          end = 2017,
  #          schema = schema_Productionscereales18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = FALSE)
  #
  #
  # schema_deslegumineuses18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 3, col = 1,  id = NULL),
  #   header = list(row = 3:5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col =c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "la superficie des legumineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2017,
  #          schema = schema_deslegumineuses18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_desprincipaleslegumineuses18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:5, rel = F),
  #     planted = list(type = "measured", col = 2:5, unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Superficie des principales legumineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2016,
  #          end = 2017,
  #          schema = schema_desprincipaleslegumineuses18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = FALSE)
  #
  #
  # schema_desprincipaleslegumineuses18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:5, rel = F),
  #     planted = list(type = "measured", unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = 2:5, unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Production des principales legumineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2016,
  #          end = 2017,
  #          schema = schema_desprincipaleslegumineuses18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = FALSE)
  #
  #
  # schema_desculturessucrieres18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col = c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des cultures sucrieres",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2017,
  #          schema = schema_desculturessucrieres18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_desoleagineuses18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 7, col = 1,  id = NULL),
  #   header = list(row = 7:9, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col =c(3,5,7), unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = c(2,4,6), unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "la superficie des oleagineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2014,
  #          end = 2017,
  #          schema = schema_desoleagineuses18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Effectif_ducheptel18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 2:3, col = 1, rel = F),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     headcount = list(type = "measured", col = 2:4, unit = "n", factor = 1000)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Effectif du cheptel",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2018,
  #          end = 2018,
  #          schema = schema_Effectif_ducheptel18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Effectif_ducheptel218 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 4, col = 1,  id = NULL),
  #   header = list(row = 4, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     headcount = list(type = "measured", col = 2:4, unit = "n", factor = 1000)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Effectif du cheptel2",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2017,
  #          end = 2017,
  #          schema = schema_Effectif_ducheptel218,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Effectif_desbovinsl18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     headcount = list(type = "measured", col = 2:4, unit = "n", factor = 1000)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Effectif des bovins",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2018,
  #          end = 2018,
  #          schema = schema_Effectif_desbovinsl18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Effectif_desbovins2l18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     headcount = list(type = "measured", col = 2:4, unit = "n", factor = 1000)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Effectif des bovins2",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2017,
  #          end = 2017,
  #          schema = schema_Effectif_desbovins2l18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Effectif_desanimaux18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 5, col = 2:4, rel = F),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     headcount = list(type = "measured", col = 2:4, unit = "n", factor = 1000)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Effectif des animaux",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2017,
  #          end = 2017,
  #          schema = schema_Effectif_desanimaux18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Effectif_desanimaux218 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 5, col = 2:4, rel = F),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     headcount = list(type = "measured", col = 2:4, unit = "n", factor = 1000)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Effectif des animaux de trait",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2017,
  #          end = 2017,
  #          schema = schema_Effectif_desanimaux218,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Superficiesreboisees18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5:6, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col = 2:3, unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Superficies reboisees",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2017,
  #          end = 2017,
  #          schema = schema_Superficiesreboisees18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Superficiesreboisees2_18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5:6, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     planted = list(type = "measured", col = 2:3, unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Superficies reboisees2",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2015,
  #          end = 2016,
  #          schema = schema_Superficiesreboisees2_18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_des_essences_forestieres18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 7, col = 1,  id = NULL),
  #   header = list(row = 7, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 7, col = 2:7, rel = F),
  #     planted = list(type = "measured", col = 2:7
  #                    , unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des essences forestieres",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2018,
  #          end = 2018,
  #          schema = schema_des_essences_forestieres18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_des_essences_resineuses18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 7, col = 1,  id = NULL),
  #   header = list(row = 7:8, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 7, col = 2:4, rel = F),
  #     planted = list(type = "measured", col = 2:7, unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des essences resineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2018,
  #          end = 2018,
  #          schema = schema_des_essences_resineuses18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_des_essences_feuillues18 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 7, col = 1,  id = NULL),
  #   header = list(row = 7:9, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 7, col = 2:6, rel = F),
  #     planted = list(type = "measured", col = 2:6, unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des essences feuillues",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2018,
  #          end = 2018,
  #          schema = schema_des_essences_feuillues18,
  #          archive = "Annuaire Statistique du Maroc, année 2018.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)

}

## livestock ----
if(build_livestock){

  ### maroc-maps ----
  # schema_LANDUSE16 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 3, col = 1, id = "commodities"),
  #   header = list(row = 4:9),
  #   variables = list(
  #     al2 = list(type = "id", row = 3),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     LandUse = list(type = "measured", col = 2:9, unit = "ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "LES SUPERFICIES AGRICOLES UTILES",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2016,
  #          end = 2016,
  #          schema = schema_LANDUSE16,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_LANDUSE16a <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 3, col = 1, id = "commodities"),
  #   header = list(row = 4:10),
  #   variables = list(
  #     al2 = list(type = "id", row = 3),
  #     commodities = list(type = "id", row = 1, col = 1),
  #     LandUse = list(type = "measured", col = 2:9, unit = "ha", factor = 1)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =2,
  #          subset = "LES SUPERFICIES AGRICOLES UTILES2",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2016,
  #          end = 2016,
  #          schema = schema_LANDUSE16a,
  #          archive = "Annuaire statistique de la région Tanger-Tétouan-Al hoceima2016.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_desprincipalescereales13 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:4, rel = F),
  #     planted = list(type = "measured", col = 2:4, unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des principales cereales",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2012,
  #          end = 2013,
  #          schema = schema_desprincipalescereales13,
  #          archive = "Annuaire Statistique du Maroc, année 2013.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  # schema_Productionscereales13 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:4, rel = F),
  #     planted = list(type = "measured", unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = 2:4, unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Productions des principales cereales",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2012,
  #          end = 2013,
  #          schema = schema_Productionscereales13,
  #          archive = "Annuaire Statistique du Maroc, année 2013.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = FALSE)

  # schema_desprincipaleslegumineuses13 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:4, rel = F),
  #     planted = list(type = "measured", col = 2:4, unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Superficie des principales legumineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2012,
  #          end = 2013,
  #          schema = schema_desprincipaleslegumineuses13,
  #          archive = "Annuaire Statistique du Maroc, année 2013.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = FALSE)
  #
  # schema_Productionslegumineuses13 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:5, rel = F),
  #     planted = list(type = "measured", unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = 2:5, unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Productions des principales legumineuses",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2012,
  #          end = 2013,
  #          schema = schema_Productionslegumineuses13,
  #          archive = "Annuaire Statistique du Maroc, année 2013.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Effectif_ducheptel13 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     headcount = list(type = "measured", col = 2:4, unit = "n", factor = 1000)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Effectif du cheptel",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2013,
  #          schema = schema_Effectif_ducheptel13,
  #          archive = "Annuaire Statistique du Maroc, année 2013.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Effectif_desbovinsl13 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     headcount = list(type = "measured", col = 2:4, unit = "n", factor = 1000)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Effectif des bovins",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2012,
  #          end = 2012,
  #          schema = schema_Effectif_desbovinsl13,
  #          archive = "Annuaire Statistique du Maroc, année 2013.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Effectif_desanimaux13 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1, rel = F),
  #     commodities = list(type = "id", row = 1:2, col = 1, rel = F),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     headcount = list(type = "measured", col = 2:4, unit = "n", factor = 1000)
  #
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Effectif des animaux",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2011,
  #          end = 2011,
  #          schema = schema_Effectif_desanimaux13,
  #          archive = "Annuaire Statistique du Maroc, année 2013.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_desprincipalescereales15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:5, rel = F),
  #     planted = list(type = "measured", col = 2:5, unit = "ha", factor = 1000),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", unit = "t", factor = 1),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "des principales cereales",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2014,
  #          schema = schema_desprincipalescereales15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = TRUE)
  #
  #
  # schema_Productionscereales15 <- makeSchema(schema = list(
  #   clusters =
  #     list(row = 5, col = 1,  id = NULL),
  #   header = list(row = 5, rel = F, merge = F),
  #   meta = list(dec = NULL, del = NULL),
  #   variables = list(
  #     al3 = list(type = "id", col = 1),
  #     commodities = list(type = "id", row = 5, col = 2:5, rel = F),
  #     planted = list(type = "measured", unit = "ha", factor = 1),
  #     harvested = list(type = "measured", unit = "ha", factor = 1),
  #     production = list(type = "measured", col = 2:5, unit = "t", factor = 100),
  #     yield = list(type = "measured", unit = "t/ha", factor = 1),
  #     headcount = list(type = "measured", unit = "n", factor = 1)
  #   )))
  # regTable(nation = "Morocco",
  #          level =3,
  #          subset = "Productions des principales cereales",
  #          dSeries = "maroc-maps",
  #          gSeries = "maroc-maps",
  #          begin = 2013,
  #          end = 2014,
  #          schema = schema_Productionscereales15,
  #          archive = "Annuaire Statistique du Maroc, année 2015.pdf",
  #          archiveLink = "unknown",
  #          updateFrequency = "notPlanned",
  #          metadataLink = "unknown",
  #          metadataPath = "unknown",
  #          update = FALSE)

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
#
# https://github.com/luckinet/tabshiftr/issues
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
          ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)

