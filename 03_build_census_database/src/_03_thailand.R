# script arguments ----
#
thisNation <- "Thailand"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("unodc", "nso")
gs <- c("gadm36", "nso")


# 1. register dataseries ----
#
regDataseries(name = ds[2],
              description = "National Statistics Office GIS",
              homepage = "http://statgis.nso.go.th/d/index/en",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)


# 2. register geometries ----
#
## nso ----
regGeometry(nation = "Thailand",
            gSeries = gs[2],
            level = 3,
            nameCol = "ADM0_EN|ADM1_EN|ADM2_EN",
            archive = "thailand.zip|tha_admbnda_adm2_rtsd_20190221.shp",
            archiveLink = "http://statgis.nso.go.th/d/index/en",
            updateFrequency = "notPlanned",
            update = TRUE)

regGeometry(nation = "Thailand",
            gSeries = gs[2],
            level = 2,
            nameCol = "ADM0_EN|ADM1_EN",
            archive = "thailand.zip|tha_admbnda_adm1_rtsd_20190221.shp",
            archiveLink = "http://statgis.nso.go.th/d/index/en",
            updateFrequency = "notPlanned",
            update = TRUE)

regGeometry(nation = "Thailand",
            gSeries = gs[2],
            level = 1,
            nameCol = "ADM0_EN",
            archive = "thailand.zip|tha_admbnda_adm0_rtsd_20190221.shp",
            archiveLink = "http://statgis.nso.go.th/d/index/en",
            updateFrequency = "notPlanned",
            update = TRUE)

# 3. register census tables ----
#
## crops ----
if(build_crops){

  ### nso ----
  # meta_nso140 <- makeSchema(
  #   list(clusters = list(top = 1, left = 1, width = NULL, height = NULL,
  #                        id = NULL),
  #        variables = list(al2 =
  #                           list(type = "Province", name = NULL, split = NULL,
  #                                row = NULL, col = 4, rel = FALSE),
  #                         year =
  #                           list(type = "Year", name = NULL, split = NULL,
  #                                row = NULL, col = 3, rel = FALSE),
  #                         commodities =
  #                           list(type = "Type of Crops", name = NULL, split = NULL,
  #                                row = NULL, col = 6, rel = FALSE),
  #                         planted =
  #                           list(type = "values", unit = "ha", factor = 1,
  #                                row = NULL, col = c(6,7), rel = FALSE,
  #                                key = "Planted area (Rai)", value = "Planted Area"),
  #                         harvested =
  #                           list(type = "values", unit = "ha", factor = 1,
  #                                row = NULL, col = c(6,7), rel = FALSE,
  #                                key = "Harvested area (Rai)", value = "Harvested Area"),
  #                         production =
  #                           list(type = "values", unit = "t", factor = 1,
  #                                row = NULL, col = c(6,7), rel = FALSE,
  #                                key = "Production (Tons)", value = "Production"),
  #                         yield =
  #                           list(type = "values", unit = "kg/ha", factor = 1,
  #                                row = NULL, col = c(6,7), rel = FALSE,
  #                                key = "Average yield per Planted area (Kg.)", value = "Yield"))))
  #
  # regTable(nation = "Thailand",
  #          subset = "allCrops",
  #          level = 2,
  #          dSeries = "nso",
  #          gSeries = "statgis",
  #          schema = meta_nso140,
  #          begin = 2007,
  #          end = 2018,
  #          archive = "thailand.zip|all.admin3.all.2007-2018.csv",
  #          archiveLink = "http://statbbi.nso.go.th/analytics/saw.dll?PortalPages&PortalPath=%2fshared%2f2.%20%e0%b8%a3%e0%b8%b2%e0%b8%a2%e0%b8%87%e0%b8%b2%e0%b8%99%e0%b8%a3%e0%b8%b0%e0%b8%9a%e0%b8%9a%e0%b8%84%e0%b8%a5%e0%b8%b1%e0%b8%87%e0%b8%82%e0%b9%89%e0%b8%ad%e0%b8%a1%e0%b8%b9%e0%b8%a5%e0%b8%a3%e0%b8%b2%e0%b8%a2%e0%b8%aa%e0%b8%b2%e0%b8%82%e0%b8%b2%2fEN%2f_portal%2f11%20Agriculture%20statistics%20and%20fishery%20statistics&Done=close",
  #          updateFrequency = "unknown",
  #          metadataLink = "http://statbbi.nso.go.th/staticreport/page/sector/en/index.aspx",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)

  ### unodc ----
  schema_tha_01 <- setCluster(id = "commodities", left = 1, top = 2) %>%
    setFilter(rows = .find("Total", col = 1), invert = TRUE) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", rows = 1, columns = c(2:3), relative = TRUE) %>%
    setIDVar(name = "commodities", value = "poppy") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(2:3))

  regTable(nation = "tha",
           level = 2,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tha_01,
           begin = 2005,
           end = 2006,
           archive = "Golden_triangle_2006.pdf|p.138",
           archiveLink = "https://www.unodc.org/pdf/research/Golden_triangle_2006.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "tha",
           level = 2,
           subset = "plantedPoppy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tha_01,
           begin = 2007,
           end = 2008,
           archive = "East_Asia_Opium_report_2008.pdf|p.119",
           archiveLink = "https://www.unodc.org/documents/crop-monitoring/East_Asia_Opium_report_2008.pdf",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## livestock ----
if(build_livestock){

}

## landuse ----
if(build_landuse){

  ### nso ----
  # meta_nso141 <- makeSchema(
  #   list(clusters = list(top = 1, left = 1, width = NULL, height = NULL,
  #                        id = NULL),
  #        variables = list(al3 =
  #                           list(type = "Province", name = NULL, split = NULL,
  #                                row = NULL, col = 8, rel = FALSE),
  #                         year =
  #                           list(type = "Year", name = NULL, split = NULL,
  #                                row = 4, col = c(2:10), rel = FALSE),
  #                         commodities =
  #                           list(type = "Type of Livestock", name = NULL, split = NULL,
  #                                row = c(5:25), col = 1, rel = FALSE),
  #                         headcount =
  #                           list(type = "values", unit = "units", factor = 1,
  #                                row = 6, col = c(6:25), rel = FALSE,
  #                                key = "จำนวน", value = "YForested Area"))))
  #
  # regTable(nation = "Thailand",
  #          subset = "grazing",
  #          level = 2,
  #          dSeries = "nso",
  #          gSeries = "statgis",
  #          schema = meta_nso141,
  #          begin = 1991,
  #          end = 2018,
  #          archive = "thailand.zip|grazing.part.adm2.1990-2018.all.csv",
  #          archiveLink = "http://statbbi.nso.go.th/analytics/saw.dll?PortalPages&PortalPath=%2fshared%2f2.%20%e0%b8%a3%e0%b8%b2%e0%b8%a2%e0%b8%87%e0%b8%b2%e0%b8%99%e0%b8%a3%e0%b8%b0%e0%b8%9a%e0%b8%9a%e0%b8%84%e0%b8%a5%e0%b8%b1%e0%b8%87%e0%b8%82%e0%b9%89%e0%b8%ad%e0%b8%a1%e0%b8%b9%e0%b8%a5%e0%b8%a3%e0%b8%b2%e0%b8%a2%e0%b8%aa%e0%b8%b2%e0%b8%82%e0%b8%b2%2fEN%2f_portal%2f11%20Agriculture%20statistics%20and%20fishery%20statistics&Done=close",
  #          updateFrequency = "unknown",
  #          metadataLink = "http://statbbi.nso.go.th/staticreport/page/sector/en/index.aspx",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # meta_nso142 <- makeSchema(
  #   list(clusters = list(top = 1, left = 1, width = NULL, height = NULL,
  #                        id = NULL),
  #        variables = list(al3 =
  #                           list(type = "Province", name = NULL, split = NULL,
  #                                row = NULL, col = 8, rel = FALSE),
  #                         year =
  #                           list(type = "Year", name = NULL, split = NULL,
  #                                row = NULL, col = 6, rel = FALSE),
  #                         commodities =
  #                           list(type = "Type of Livestock", name = NULL, split = NULL,
  #                                row = NULL, col = 10, rel = FALSE),
  #                         headcount =
  #                           list(type = "values", unit = "units", factor = 1,
  #                                row = NULL, col = c(11), rel = FALSE,
  #                                key = "จำนวน", value = "YForestedArea)"))))
  #
  # regTable(nation = "Thailand",
  #          subset = "grazing",
  #          level = 2,
  #          dSeries = "nso",
  #          gSeries = "statgis",
  #          schema = meta_nso142,
  #          begin = 2009,
  #          end = 2018,
  #          archive = "thailand.zip|grazing.part.adm2.1990.csv",
  #          archiveLink = "http://statbbi.nso.go.th/analytics/saw.dll?PortalPages&PortalPath=%2fshared%2f2.%20%e0%b8%a3%e0%b8%b2%e0%b8%a2%e0%b8%87%e0%b8%b2%e0%b8%99%e0%b8%a3%e0%b8%b0%e0%b8%9a%e0%b8%9a%e0%b8%84%e0%b8%a5%e0%b8%b1%e0%b8%87%e0%b8%82%e0%b9%89%e0%b8%ad%e0%b8%a1%e0%b8%b9%e0%b8%a5%e0%b8%a3%e0%b8%b2%e0%b8%a2%e0%b8%aa%e0%b8%b2%e0%b8%82%e0%b8%b2%2fEN%2f_portal%2f11%20Agriculture%20statistics%20and%20fishery%20statistics&Done=close",
  #          updateFrequency = "unknown",
  #          metadataLink = "http://statbbi.nso.go.th/staticreport/page/sector/en/index.aspx",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # meta_nso143 <- makeSchema(
  #   list(clusters = list(top = 1, left = 1, width = NULL, height = NULL,
  #                        id = NULL),
  #        variables = list(al3 =
  #                           list(type = "Province", name = NULL, split = NULL,
  #                                row = NULL, col = 7, rel = FALSE),
  #                         year =
  #                           list(type = "Year", name = NULL, split = NULL,
  #                                row = NULL, col = 5, rel = FALSE),
  #                         commodities =
  #                           list(type = "Type of Livestock", name = NULL, split = NULL,
  #                                row = NULL, col = 10, rel = FALSE),
  #                         headcount =
  #                           list(type = "values", unit = "units", factor = 1,
  #                                row = NULL, col = c(11), rel = FALSE,
  #                                key = "จำนวน", value = "YForested Area"))))
  #
  # regTable(nation = "Thailand",
  #          subset = "forest",
  #          level = 2,
  #          dSeries = "nso",
  #          gSeries = "statgis",
  #          schema = meta_nso143,
  #          begin = 1985,
  #          end = 2018,
  #          archive = "thailand.zip|1985-2018rpt_Forest Area from Using Remote Sensing by Region.csv",
  #          archiveLink = "http://statbbi.nso.go.th/analytics/saw.dll?PortalPages&PortalPath=%2fshared%2f2.%20%e0%b8%a3%e0%b8%b2%e0%b8%a2%e0%b8%87%e0%b8%b2%e0%b8%99%e0%b8%a3%e0%b8%b0%e0%b8%9a%e0%b8%9a%e0%b8%84%e0%b8%a5%e0%b8%b1%e0%b8%87%e0%b8%82%e0%b9%89%e0%b8%ad%e0%b8%a1%e0%b8%b9%e0%b8%a5%e0%b8%a3%e0%b8%b2%e0%b8%a2%e0%b8%aa%e0%b8%b2%e0%b8%82%e0%b8%b2%2fEN%2f_portal%2f11%20Agriculture%20statistics%20and%20fishery%20statistics&Done=close",
  #          updateFrequency = "unknown",
  #          metadataLink = "http://statbbi.nso.go.th/staticreport/page/sector/en/index.aspx",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)

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
