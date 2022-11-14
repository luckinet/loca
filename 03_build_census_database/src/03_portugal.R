# script arguments ----
#
thisNation <- "Portugal"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- FALSE
overwriteTables <- FALSE


# register dataseries ----
#
ds <- c("ine")
gs <- c("gadm", "ine")

regDataseries(name = ds[1],
              description = "Instituto Nacional de Estatistica",
              homepage = "https://www.ine.pt/",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)


# register geometries ----
#
regGeometry(gSeries = gs[2],
            level = 3,
            nameCol = "LUG11DESIG",
            archive = "portugal.zip|BGRI11_CONT.shp",
            archiveLink = "http://mapas.ine.pt/download/metadados/bgri11.html",
            nextUpdate = "unknown",
            updateFrequency = "notPlanned",
            update = updateTables)


# register census tables ----
#

# ine----
# meta_ine70 <-
#   makeSchema(
#     list(clusters = list(top = 10, left = c(3,7), width = NULL, height = NULL,
#                          id = NULL),
#          variables = list(al3 =
#                             list(type = "id", name = NULL, split = NULL,
#                                  row = NULL, col = 2, rel = FALSE),
#                           year =
#                             list(type = "id", name = NULL, split = NULL,
#                                  row = 1, col = NULL, rel = FALSE),
#                           commodities =
#                             list(type = "id", name = NULL, split = NULL,
#                                  row = 2, col = c(3,5), rel = FALSE),
#                           headcount =
#                             list(type = "values", unit = "units", factor = 1,
#                                  row = 3, col = c(3,5), rel = FALSE,
#                                  id = "units", value = NULL))))
# regTable(subset = "livestock",
#          level = 2,
#          dSeries = ds[1],
#          gSeries = gs[2],
#          schema = meta_ine70,
#          begin = 1852,
#          end = 2018,
#          archive = "portugal.zip|headcount.Adm2.1852-2019.csv",
#          archiveLink = "https://www.ine.pt/xportal/xmain?xpid=INE&xpgid=ine_bdc_tree&contexto=bd&selTab=tab2",
#          updateFrequency = "unknown",
#          nextUpdate = "unknown",
#          metadataLink = "http://smi.ine.pt/",
#          metadataPath = "unavailable",
#          update = myUpdate,
#          overwrite = overwriteTables)
#
# meta_ine71 <-
#   makeSchema(
#     list(clusters = list(top = 12, left = 1, width = NULL, height = NULL,
#                          id = NULL),
#          variables = list(territory =
#                             list(type = "id", name = NULL, split = NULL,
#                                  row = NULL, col = 1, rel = FALSE),
#                           year =
#                             list(type = "id", name = NULL, split = NULL,
#                                  row = 8, col = c(2,34,66), rel = FALSE),
#                           commodities =
#                             list(type = "id", name = NULL, split = NULL,
#                                  row = 9, col = 2, rel = FALSE),
#                           planted =
#                             list(type = "values", unit = "ha", factor = 1,
#                                  row = 12, col = c(2:96), rel = FALSE,
#                                  key = "Forest", value = "Forest Planted Area"))))
# regTable(subset = "forest",
#          level = 2,
#          dSeries = "ine",
#          gSeries = "ine",
#          schema = meta_ine71,
#          begin = 1995,
#          end = 2010,
#          archive = "portugal.zip|forest.adm2.1995-2010.csv",
#          archiveLink = "https://www.ine.pt/xportal/xmain?xpid=INE&xpgid=ine_bdc_tree&contexto=bd&selTab=tab2",
#          updateFrequency = "unknown",
#          nextUpdate = "unknown",
#          metadataLink = "http://smi.ine.pt/",
#          metadataPath = "unavailable",
#          update = myUpdate,
#          overwrite = overwriteTables)
#
# meta_ine72 <-
#   makeSchema(
#     list(clusters = list(top = 8, left = 1, width = NULL, height = NULL,
#                          id = NULL),
#          variables = list(territory =
#                             list(type = "id", name = NULL, split = NULL,
#                                  row = 102, col = 2, rel = FALSE),
#                           year =
#                             list(type = "id", name = NULL, split = NULL,
#                                  row = 3, col = 6, rel = FALSE),
#                           commodities =
#                             list(type = "id", name = NULL, split = NULL,
#                                  row = 2, col = 7, rel = FALSE),
#                           planted =
#                             list(type = "values", unit = "ha", factor = 1,
#                                  row = 6, col = 4, rel = FALSE,
#                                  key = "PlantedArea", value = "Planted Area"),
#                           production =
#                             list(type = "values", unit = "t", factor = 1,
#                                  row = 6, col = 6, rel = FALSE,
#                                  key = "Production", value = "Production"),
#                           yield =
#                             list(type = "values", unit = "Kg/ha", factor = 1,
#                                  row = 6, col = 7, rel = FALSE,
#                                  key = "Yield", value = "Yield"))))
#
# regTable(subset = "mainCrops",
#          level = 2,
#          dSeries = "ine",
#          gSeries = "ine",
#          schema = meta_ine72,
#          begin = 1986,
#          end = 2018,
#          archive = "portugal.zip|Prod.Plant.Yield.Adm2.1986-2019.csv",
#          archiveLink = "https://www.ine.pt/xportal/xmain?xpid=INE&xpgid=ine_bdc_tree&contexto=bd&selTab=tab2",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "http://smi.ine.pt/",
#          metadataPath = "unavailable",
#          update = myUpdate,
#          overwrite = overwriteTables)



# normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              al1 = thisNation,
#              outType = "gpkg",
#              update = updateTables)


# normalise census tables ----
#
## in case the output shall be examined before writing into the DB
# testing <- normTable(nation = thisNation,
#                      update = FALSE,
#                      keepOrig = TRUE)
#
# only needed if FAO datasets have not been integrated before
# normTable(pattern = "fao",
#           al1 = thisNation,
#           outType = "rds",
#           update = updateTables)

normTable(pattern = "",
          # al1 = thisNation,
          outType = "rds",
          update = updateTables)


# harmonise commodities ----
#
for(i in seq_along(ds)){

  # tibble(new = get_variable(variable = "commodities", dataseries = ds[]),
  #        label_en = "") %>%
  #   write_csv(file = paste0(TTDir, "match_", ds[], "_lucki.csv"), append = TRUE) # fill rest by hand

  commodities <- read_csv(paste0(TTDir, "match_", ds[i], "_lucki.csv"), col_types = "cc") %>%
    filter(!is.na(harmonised))

  # in case new concepts are recorded, they have to be added to the ontology, before they can be used.
  # get_concept(label_en = commodities$harmonised,
  #             ontoDir = ontoDir, missing = TRUE) %>%
  #   pull(new) %>%
  #   set_concept(new = .,
  #               broader = c(""),       # specify here the already harmonised concepts into which the new concepts should be nested
  #               class = "commodity",
  #               source = paste0(thisNation, ".", ds[i]))

  get_concept(label_en = commodities$harmonised,
              ontoDir = ontoDir) %>%
    pull(label_en) %>%
    set_mapping(concept = .,
                external = commodities$new,
                match = "close",
                source = paste0(thisNation, ".", ds[i]),
                certainty = )

}

