# script arguments ----
#
thisNation <- "Malaysia"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- FALSE
overwriteTables <- FALSE


# register dataseries ----
#
ds <- c("midc", "data.gov.my", "dosm")
gs <- c("gadm")

regDataseries(name = ds[1],
              description = "malaysia informatic data centre",
              homepage = "https://mysidc.statistics.gov.my",
              licence_link = "",
              licence_path = "",
              update = updateTables)

regDataseries(name = ds[2],
              description = "open data portal of the malaysean government",
              homepage = "http://www.dataGov",
              licence_link = "http://www.data.gov.my/page/termsofuse",
              licence_path = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/Terms of Use Government Open Data 1_0_English.pdf",
              update = updateTables)

regDataseries(name= ds[3],
              description = "department of statistics Malaysia, official Portal",
              homepage = "https://www.dosm.gov.my",
              licence_link = "https://www.dosm.gov.my/v1/uploads/files/4_Portal%20Content/2_%20Statistics/Open%20Data/Terms%20of%20Use%20Government%20Open%20Data%201_0_English.pdf",
              licence_path = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/Terms of Use Government Open Data 1_0_English.pdf",
              notes = "terms of use licence link must be provided",
              update = updateTables)


# register geometries ----
#


# register census tables ----
#
# data.gov.my----
#
# schema_cacoa_reg_96_18 <-
#   setCluster(id = "territories",
#              left = 1, top = c(6, 11, 16)) %>%
#   setFilter(rows = c(1:20)) %>%
#   setIDVar(name = "territories", columns = 1, rows = 1, relative = T) %>%
#   setIDVar(name = "year", columns = c(2:24), rows = 4) %>%
#   setIDVar(name = "commodities", value = "cocoa") %>%
#   setObsVar(name = "production", columns = c(2:24),
#             key = 1, value = "Sub-Total")
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "cacoa",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 1996,
#          end = 2018,
#          schema = schema_cacoa_reg_96_18,
#          archive = "cocoa-4-2.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/malaysia-production-of-cocoa-beans-estates-and-smallholding-2017/resource/95f24c0b-663c-4c6f-8f49-795f3ae80002",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work",
#          update = myUpdate)
#
#
#
# schema_crops_sembilan_2015_2018 <-
#   setIDVar(name = "territories", value = "sembilan") %>%
#   setIDVar(name = "year", columns = 1) %>%
#   setIDVar(name = "commodities", columns = 2, split = "(?<=\\/[[:space:]]).+") %>%
#   setObsVar(name = "planted", columns = 3) %>%
#   setObsVar(name = "production", columns = 4)
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "cropsSembilan",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2015,
#          end = 2018,
#          schema = schema_crops_sembilan_2015_2018,
#          archive = "pertaniankeluasan--hasil-keluaranupdatedraw.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?organization=negeri-sembilan-state-government&_organization_limit=0&groups=pertanian",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = NULL,
#          update = myUpdate)
#
#
# schema_headcount_melaka <-
#   setCluster(id = "territories", left = 1, top = 4) %>%
#   setIDVar(name = "territories", value = "melaka") %>%
#   setIDVar(name = "year", columns = 1) %>%
#   setIDVar(name = "commodities", columns = c(3:28), rows = 4, split = "(?<=\\/[[:space:]]).+") %>%
#   setObsVar(name = "headcount", columns = c(3:28), key = 2, value = "Jumlah Ternakan\nNo. of Livestock")
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "headcountMelaka",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2014,
#          end = 2016,
#          schema = schema_headcount_melaka,
#          archive = "perangkaan-ternakan-negeri-melaka-2014-2016.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?_organization_limit=0&groups=pertanian&organization=melaka-state-government",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = NULL,
#          update = myUpdate)
#
#
#
#
#
# # dosm ----
#
# schema_rubber_planted_65_14 <-
#   makeSchema(schema = list(
#     clusters =
#       list(row= NULL, col= NULL, width = NULL, height = NULL),
#     header = list(row = 1, rel = FALSE),
#     meta = list(dec = "//.", del = NULL, na = NULL),
#     variables = list(
#       territory =
#         list(type = "id", value = "malaysia"),
#       year =
#         list(type = "id", row = NULL, col = 1),
#       commodities =
#         list(type = "id", value = "rubber"),
#       planted =
#         list(type = "measured", row = NULL, col = 2,
#              unit = "ha", factor = 1000))))
#
#
# regTable(nation = "malaysia",
#          level = 1,
#          subset = "rubberPlanted",
#          dSeries = "dosm",
#          gSeries = "gadm",
#          begin = 1965,
#          end = 2014,
#          schema = schema_rubber_planted_65_14,
#          archive = "bpas_Planted_Area_of_Rubber_Estates_1965-2014_Malaysia.csv",
#          archiveLink = "https://www.dosm.gov.my/v1/index.php?r=column3/accordion&menu_id=aHhRYUpWS3B4VXlYaVBOeUF0WFpWUT09",
#          updateFrequency = "continual",
#          metadataLink = "https://www.dosm.gov.my/v1/uploads/files/4_Portal%20Content/3_Methods%20%26%20Classifications/1_Metadata/2_Metadata%20-%20Publication%20Level/Agriculture/Metadata_BI%20ANNUAL%20RUBBER%20STATISTICS_28032017.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/Metadata_BI MONTHLY RUBBER STATISTICS_28032017.pdf",
#          notes = "just for the estates, no smallholder info",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
#
#
# schema_rubber_yield_65_14 <- makeSchema(schema = list(
#   header = list(row = 1, rel = FALSE),
#   meta = list(dec = "//.", del = NULL, na = NULL),
#   variables = list(
#     territory =
#       list(type = "id", value = "malaysia"),
#     year =
#       list(type = "id", row = NULL, col = 1, value = NULL,
#            split = NULL, rel = FALSE, dist = FALSE),
#     commodities =
#       list(type = "id", value = "rubber"),
#     yield =
#       list(type = "measured", row = NULL, col = 2,
#            unit = "t/ha", factor = 0.001, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE))))
#
# regTable(nation = "malaysia",
#          level = 1,
#          subset = "rubberYield",
#          dSeries = "dosm",
#          gSeries = "gadm",
#          begin = 1965,
#          end = 2014,
#          schema = schema_rubber_yield_65_14,
#          archive = "bpas_Yield_per_Hectare_of_Rubber_Estates_1965-2014_Malaysia.csv",
#          archiveLink = "https://www.dosm.gov.my/v1/index.php?r=column3/accordion&menu_id=aHhRYUpWS3B4VXlYaVBOeUF0WFpWUT10",
#          updateFrequency = "continual",
#          metadataLink = "https://www.dosm.gov.my/v1/uploads/files/4_Portal%20Content/3_Methods%20%26%20Classifications/1_Metadata/2_Metadata%20-%20Publication%20Level/Agriculture/Metadata_BI%20ANNUAL%20RUBBER%20STATISTICS_28032017.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/Metadata_BI MONTHLY RUBBER STATISTICS_28032017.pdf",
#          notes = "just for the estates, no smallholderinfo",
#          update = myUpdate)
#
#
# schema_rubber_production_65_14 <- makeSchema(schema = list(
#   header = list(row = 1, rel = FALSE),
#   meta = list(dec = "//.", del = NULL, na = NULL),
#   variables = list(
#     territory =
#       list(type = "id", value = "malaysia"),
#     year =
#       list(type = "id", row = NULL, col = 1, value = NULL,
#            split = NULL, rel = FALSE, dist = FALSE),
#     commodities =
#       list(type = "id", value = "rubber"),
#     production =
#       list(type = "measured", row = NULL, col = 2,
#            unit = "ha", factor = 1000, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE))))
#
#
# regTable(nation = "malaysia",
#          level = 1,
#          subset = "rubberProduction",
#          dSeries = "dosm",
#          gSeries = "gadm",
#          begin = 1965,
#          end = 2014,
#          schema = schema_rubber_production_65_14,
#          archive = "bpas_Planted_Area_of_Rubber_Estates_1965-2014_Malaysia.csv",
#          archiveLink = "https://www.dosm.gov.my/v1/index.php?r=column3/accordion&menu_id=aHhRYUpWS3B4VXlYaVBOeUF0WFpWUT11",
#          updateFrequency = "continual",
#          metadataLink = "https://www.dosm.gov.my/v1/uploads/files/4_Portal%20Content/3_Methods%20%26%20Classifications/1_Metadata/2_Metadata%20-%20Publication%20Level/Agriculture/Metadata_BI%20ANNUAL%20RUBBER%20STATISTICS_28032017.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/Metadata_BI MONTHLY RUBBER STATISTICS_28032017.pdf",
#          notes = "just for the estates, no smallholder info",
#          update = myUpdate)
#
#
# schema_rubber_harvested_65_14 <- makeSchema(schema = list(
#   header = list(row = 1, rel = FALSE),
#   meta = list(dec = "//.", del = NULL, na = NULL),
#   variables = list(
#     territory =
#       list(type = "id", value = "malaysia"),
#     year =
#       list(type = "id", row = NULL, col = 1, value = NULL,
#            split = NULL, rel = FALSE, dist = FALSE),
#     commodities =
#       list(type = "id", value = "rubber"),
#     harvested =
#       list(type = "measured", row = NULL, col = 2,
#            unit = "ha", factor = 1000, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE))))
#
# regTable(nation = "malaysia",
#          level = 1,
#          subset = "rubberHarvested",
#          dSeries = "dosm",
#          gSeries = "gadm",
#          begin = 1965,
#          end = 2014,
#          schema = schema_rubber_harvested_65_14,
#          archive = "bpas_Tapped_Area_of_Rubber_Estates_1965-2014_Malaysia.csv",
#          archiveLink = "https://www.dosm.gov.my/v1/index.php?r=column3/accordion&menu_id=aHhRYUpWS3B4VXlYaVBOeUF0WFpWUT12",
#          updateFrequency = "continual",
#          metadataLink = "https://www.dosm.gov.my/v1/uploads/files/4_Portal%20Content/3_Methods%20%26%20Classifications/1_Metadata/2_Metadata%20-%20Publication%20Level/Agriculture/Metadata_BI%20ANNUAL%20RUBBER%20STATISTICS_28032017.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/Metadata_BI MONTHLY RUBBER STATISTICS_28032017.pdf",
#          notes = "just for the estates, no smallholder info",
#          update = myUpdate)
#
# schema_rice_80_16 <- makeSchema(schema = list(
#   header = list(row = 7, rel = FALSE),
#   meta = list(dec = NULL, del = ",", na = NULL),
#   variables = list(
#     territory =
#       list(type = "id", value = "Malaysia"),
#     year =
#       list(type = "id", row = NULL, col = 1, value = NULL,
#            split = NULL, rel = FALSE, dist = FALSE),
#     commodities =
#       list(type = "id", value = "paddy"),
#     planted =
#       list(type = "measured", row = NULL, col = 2,
#            unit = "ha", factor = 1, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE),
#     production =
#       list(type = "measured", row = NULL, col = 4,
#            unit = "t", factor = 1, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE),
#     yield =
#       list(type = "measured", row = NULL, col = 3,
#            unit = "t/ha", factor = 0.001, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE))))
#
# regTable(nation = "malaysia",
#          level = 1,
#          subset = "paddy",
#          dSeries = "dosm",
#          gSeries = "gadm",
#          begin = 1980,
#          end = 2016,
#          schema = schema_rice_80_16,
#          archive = "09Padi.xlsx",
#          archiveLink = "https://www.dosm.gov.my/v1/index.php?r=column/ctimeseries&menu_id=NHJlaGc2Rlg4ZXlGTjh1SU1kaWY5UT09",
#          updateFrequency = "annualy",
#          metadataLink = "https://www.dosm.gov.my/v1/uploads/files/4_Portal%20Content/3_Methods%20%26%20Classifications/1_Metadata/2_Metadata%20-%20Publication%20Level/Agriculture/Metadata_SELECTED%20AGRICULTURAL%20INDICATORS%20MALAYSIA_2016.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/09_Padi.pdf",
#          update = myUpdate)
#
#
# schema_rubber_65_16 <- makeSchema(schema = list(
#   header = list(row = c(5:7), merge = T),
#   meta = list(dec = "\\.", del = NULL, na = NULL),
#   variables = list(
#     territory =
#       list(type = "id", value = "Malaysia"),
#     year =
#       list(type = "id", row = NULL, col = 1),
#     commodities =
#       list(type = "id", value = "rubber"),
#     planted =
#       list(type = "measured", row = NULL, col = 2,
#            unit = "ha", factor = 1),
#     production =
#       list(type = "measured", row = NULL, col = 5,
#            unit = "t", factor = 1))))
#
# #bei umwandlung in .csv unbedingt zweites sheet speichern!
#
# regTable(nation = "malaysia",
#          level = 1,
#          subset = "rubber",
#          dSeries = "dosm",
#          gSeries = "gadm",
#          begin = 1965,
#          end = 2016,
#          schema = schema_rubber_65_16,
#          archive = "10Getah.xlsx",
#          archiveLink = "https://www.dosm.gov.my/v1/index.php?r=column/ctimeseries&menu_id=NHJlaGc2Rlg4ZXlGTjh1SU1kaWY5UT10",
#          updateFrequency = "annualy",
#          metadataLink = "https://www.dosm.gov.my/v1/uploads/files/3_Time%20Series/Malaysia_Time_Series_2016/10_Getah.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/10_Getah.pdf",
#          update = myUpdate)
#
#
#
# schema_oilPalm_74_19 <- makeSchema(schema = list(
#   header = list(row = c(6)),
#   meta = list(dec = NULL, del = NULL, na = NULL),
#   variables = list(
#     territory =
#       list(type = "id", value = "Malaysia"),
#     year =
#       list(type = "id", row = NULL, col = 1),
#     commodities =
#       list(type = "id", value = "rubber"),
#     planted =
#       list(type = "measured", row = NULL, col = 2,
#            unit = "ha", factor = 1))))
#
#
# regTable(nation = "malaysia",
#          level = 1,
#          subset = "oilPalm",
#          dSeries = "dosm",
#          gSeries = "gadm",
#          begin = 1974,
#          end = 2019,
#          schema = schema_oilPalm_74_19,
#          archive = "11Kelapa_sawit.xlsx",
#          archiveLink = "https://www.dosm.gov.my/v1/uploads/files/3_Time%20Series/Malaysia_Time_Series_2019/10_Getah.pdf",
#          updateFrequency = "annualy",
#          metadataLink = "https://www.dosm.gov.my/v1/uploads/files/3_Time%20Series/Malaysia_Time_Series_2019/11_Kelapa%20Sawit.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/11_Kelapa Sawit.pdf",
#          update = myUpdate)
#
#
#
# schema_cocoanut_68_19<- makeSchema(schema = list(
#   clusters= list(row= 1, col = c(1,8)),
#   header = list(row = c(6:8), merge= T),
#   meta = list(dec = NULL, del = NULL, na = NULL),
#   variables = list(
#     territory =
#       list(type = "id", value = "Malaysia"),
#     year =
#       list(type = "id", row = NULL, col = 1, rel= T),
#     commodities =
#       list(type = "id", value = "rubber"),
#     planted =
#       list(type = "measured", row = NULL, col = 2, rel= T,
#            unit = "ha", factor = 1))))
#
# regTable(nation = "malaysia",
#          level = 1,
#          subset = "Coconut",
#          dSeries = "dosm",
#          gSeries = "gadm",
#          begin = 1968,
#          end = 2019,
#          schema = schema_cocoanut_68_19,
#          archive = "12Koko.xlsx",
#          archiveLink = "https://www.dosm.gov.my/v1/index.php?r=column/ctimeseries&menu_id=bnk3bk0wTTkxOXVHaVg3SUFDMlBUUT09",
#          updateFrequency = "annualy",
#          metadataLink = "https://www.dosm.gov.my/v1/uploads/files/3_Time%20Series/Malaysia_Time_Series_2019/12_Koko.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta12_Koko.pdf",
#          update = myUpdate)
#
#
# schema_forest_47_2016<-makeSchema(list(
#   clusters =
#     list(row = 7, col = c(1,7)),
#   header = list(row = 1, rel = TRUE),
#   variables =
#     list(territory =
#            list(type = "id", value = "malaysia"),
#          year =
#            list(type = "id", col = 1, rel = TRUE),
#          commodities =
#            list(type = "id", value= "production forest"),
#          planted =
#            list(type = "measured", unit = "ha", factor = 1000,
#                 col = 2, rel = TRUE),
#          production =
#            list(type = "measured", unit = "m²", factor = 1000,
#                 col = 3, rel = TRUE))))
#
#
# regTable(nation = "malaysia",
#          level = 1,
#          subset = "prodForest",
#          dSeries = "dosm",
#          gSeries = "gadm",
#          begin = 1947,
#          end = 2016,
#          schema = schema_forest_47_2016,
#          archive = "13Perhutanan.xlsx",
#          archiveLink = "https://www.dosm.gov.my/v1_/index.php?r=column/ctimeseries&menu_id=NHJlaGc2Rlg4ZXlGTjh1SU1kaWY5UT09",
#          updateFrequency = "unknown",
#          metadataLink = "https://www.dosm.gov.my/v1/uploads/files/3_Time%20Series/Malaysia_Time_Series_2016/13_Perhutanan.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/13_Perhutanan.pdf",
#          update = myUpdate,
#          notes= "Data which only includes Peninsular Malaysia and  Sabah:  Forest area(1947 – 1986); Production of logs (1947 – 1963)")
#
# # midc----
#
# schema_misc_10.1.10.csv <- makeSchema(
#   list(clusters = list(row = 4, col = 2, height = 27),
#        header = list (row = c(1:10), rel = TRUE, merge = TRUE),
#        meta = list(del = "\\.", dec = "," , na = NULL),
#        variables = list(
#          territory =
#            list(type = "id", value = "malaysia", dist = F),
#          year =
#            list(type = "id", col = 1, rel = TRUE, dist = F),
#          commodities =
#            list(type = "id", value = "rubber", dist = F),
#          planted =
#            list(type = "measured", unit = "ha", factor = 1000, col = 4, rel = TRUE),
#          harvested =
#            list(type = "measured", unit = "ha", factor = 1000, col = 5, rel = TRUE),
#          production =
#            list(type = "measured", unit = "t", factor = 1000, col = 6, rel = TRUE),
#          yield =
#            list(type = "measured", unit = "t/ha", factor = 0.001, col = 7, rel = TRUE))))
#
#
# regTable(nation = "malaysia",
#          level = 1,
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2014,
#          subset = "rubber",
#          schema = schema_misc_10.1.10.csv,
#          archive = "10.1.10.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "monthly",
#          metadataLink = "https://www.dosm.gov.my/v1/uploads/files/4_Portal%20Content/3_Methods%20%26%20Classifications/1_Metadata/2_Metadata%20-%20Publication%20Level/Agriculture/Metadata_BI%20MONTHLY%20RUBBER%20STATISTICS_28032017.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/Metadata_BI MONTHLY RUBBER STATISTICS_28032017.pdf",
#          notes = NULL,
#          update = myUpdate)
#
# schema_misc_my10_1_1_csv <- makeSchema(
#   list(clusters = list(row = 5, col = 2, width = NULL,
#                        height = 18 , id = NULL),
#        header = list (row = 1, rel = TRUE, merge = F),
#        meta = list(del = "\\.", dec = "," , na = NULL),
#        variables = list(
#          territory =
#            list(type = "id", value = "malaysia", dist = FALSE),
#          year =
#            list(type = "id", value = NULL, split = NULL,
#                 row = NULL , col = 1, rel = T, dist = FALSE),
#          commodities =
#            list(type = "id", value = "oil palm", dist = FALSE),
#          planted =
#            list(type = "measured", unit = "ha", factor = 1000, col = 5, rel = T),
#          production =
#            list(type = "measured", unit = "t", factor = 1,
#                 row = NULL, col = 6, rel = TRUE,
#                 key = NULL, value = NULL),
#          yield =
#            list(type = "measured", unit = "t/ha", factor = 1,
#                 row = NULL, col = 7, rel = TRUE,
#                 key = NULL, value = NULL))))
#
#
# regTable(nation = "malaysia",
#          level = 1,
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2016,
#          subset = "oilPalm",
#          schema = schema_misc_my10_1_1_csv,
#          archive = "10.1.1.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "https://www.dosm.gov.my/v1/uploads/files/4_Portal%20Content/3_Methods%20%26%20Classifications/1_Metadata/2_Metadata%20-%20Publication%20Level/Agriculture/2018/metadataSUABI9_2018.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/Metadata_SELECTED AGRICULTURAL INDICATORS MALAYSIA_2016.pdf",
#          notes = NULL,
#          update = myUpdate)
#
#
#
# schema_cocoa_my <- makeSchema(schema = list(
#   header = list(row = c(6:13), rel = F, merge = T),
#   meta = list(dec = NULL, del = "\\,", na = NULL),
#   variables = list(
#     territory =
#       list(type = "id", value = "malasia"),
#     year =
#       list(type = "id", row = NULL, col = 2, value = NULL,
#            split = "[^=\\D]*", rel = FALSE, dist = FALSE),
#     commodities =
#       list(type = "id", value = "coconuts"),
#     planted =
#       list(type = "measured", row = NULL, col = 4,
#            unit = "ha", factor = 1, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE),
#     harvested =
#       list(type = "measured", row = NULL, col = 5,
#            unit = "ha", factor = 1, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE),
#     production =
#       list(type = "measured", row = NULL, col = 6,
#            unit = "t", factor = 1, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE),
#     yield =
#       list(type = "measured", row = NULL, col = 7,
#            unit = "t/ha", factor = 1, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE))))
#
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "cocoa",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2014,
#          schema = schema_cocoa_my,
#          archive = "10.1.13.xlsx",
#          archiveLink = "https:\\mysidc.statistics.gov.my\\index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "https:\\www.dosm.gov.my\\v1/uploads\\files\\4_Portal%20Content\\3_Methods%20%26%20Classifications\\1_Metadata\\2_Metadata%20-%20Publication%20Level/Agriculture\\2018\\metadataSUABI9_2018.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/metadataSUABI9_2018.pdf",
#          notes = NULL,
#          update = myUpdate)
#
# schema_cocoa_region <- makeSchema(schema = list(
#   header = list(row = c(4:5), rel = F, merge = T),
#   meta = list(dec = NULL, del = "\\,", na = NULL),
#   variables = list(
#     territory =
#       list(type = "id", row = 7, col = c(2:4)),
#     year =
#       list(type = "id", row = NULL, col = 1),
#     commodities =
#       list(type = "id", value = "coconut"),
#     production =
#       list(type = "measured", row = NULL, col = c(2:5),
#            unit = "t", factor = 1))))
#
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "cocoa",
#          dSeries = "midc",
#          gSeries = "owngadm",
#          begin = 2000,
#          end = 2016,
#          schema = schema_cocoa_region,
#          archive = "10.1.17.xlsx",
#          archiveLink = "https:\\mysidc.statistics.gov.my\\index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "https:\\www.dosm.gov.my\\v1/uploads\\files\\4_Portal%20Content\\3_Methods%20%26%20Classifications\\1_Metadata\\2_Metadata%20-%20Publication%20Level/Agriculture\\2018\\metadataSUABI9_2018.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/metadataSUABI9_2018.pdf",
#          notes = "regions are not al2",
#          update = myUpdate)
#
#
#
# schema_pepper_plant_reg <- makeSchema(schema = list(
#   header = list(row = 6, rel = F, merge = T),
#   meta = list(dec = NULL, del = "\\,", na = NULL),
#   variables = list(
#     territory =
#       list(type = "id", row = 6, col = c(2:5)),
#     year =
#       list(type = "id", row = NULL, col = 1),
#     commodities =
#       list(type = "id", value = "pepper"),
#     planted =
#       list(type = "measured", row = NULL, col = c(2:5),
#            unit = "ha", factor = 1))))
#
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "pepper",
#          dSeries = "midc",
#          gSeries = "owngadm",
#          begin = 2000,
#          end = 2016,
#          schema = schema_pepper_plant_reg,
#          archive = "10.1.18-1.xlsx",
#          archiveLink = "https:\\mysidc.statistics.gov.my\\index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "https:\\www.dosm.gov.my\\v1/uploads\\files\\4_Portal%20Content\\3_Methods%20%26%20Classifications\\1_Metadata\\2_Metadata%20-%20Publication%20Level/Agriculture\\2018\\metadataSUABI9_2018.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/metadataSUABI9_2018.pdf",
#          notes = "Regions are not al2",
#          update = myUpdate)
#
#
# schema_pepper_prod_reg <- makeSchema(schema = list(
#   header = list(row = 5, rel = F, merge = F),
#   meta = list(dec = NULL, del = "\\,", na = NULL),
#   variables = list(
#     territory =
#       list(type = "id", row = 7, col = c(2:5)),
#     year =
#       list(type = "id", row = NULL, col = 1),
#     commodities =
#       list(type = "id", value = "pepper"),
#     planted =
#       list(type = "measured", row = NULL, col = c(2:5),
#            unit = "t", factor = 1))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "pepperProduction",
#          dSeries = "midc",
#          gSeries = "owngadm",
#          begin = 2000,
#          end = 2016,
#          schema = schema_pepper_prod_reg,
#          archive = "10.1.19.xlsx",
#          archiveLink = "https:\\mysidc.statistics.gov.my\\index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "https:\\www.dosm.gov.my\\v1/uploads\\files\\4_Portal%20Content\\3_Methods%20%26%20Classifications\\1_Metadata\\2_Metadata%20-%20Publication%20Level/Agriculture\\2018\\metadataSUABI9_2018.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/metadataSUABI9_2018.pdf",
#          notes = "Regions are not al2",
#          update = myUpdate)
#
#
#
# schema_tabacco_my<-
#   makeSchema(schema = list(
#     header = list(row = c(5), rel = FALSE, merge = T),
#     meta = list(dec = "\\.", del =",", na = "-"),
#     variables = list(
#       territory =
#         list(type = "id", value = "malaysia"),
#       year =
#         list(type = "id", row = NULL, col = 1),
#       commodities =
#         list(type = "id", value = "tabacco"),
#       planted =
#         list(type = "measured", row = NULL, col = 5,
#              unit = "ha", factor = 1, key = NULL, value = NULL,
#              rel = F, dist = FALSE),
#       production =
#         list(type = "measured", row = NULL, col = 6,
#              unit = "t", factor = 1, key = NULL, value = NULL,
#              rel = F, dist = FALSE),
#       yield =
#         list(type = "measured", row = NULL, col = 7,
#              unit = "t/ha", factor = 0.001, key = NULL, value = NULL,
#              rel = F, dist = FALSE))))
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "tabacco",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2016,
#          schema = schema_tabacco_my,
#          archive = "10.1.24.xlsx",
#          archiveLink = "https:\\mysidc.statistics.gov.my\\index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "https:\\www.dosm.gov.my\\v1/uploads\\files\\4_Portal%20Content\\3_Methods%20%26%20Classifications\\1_Metadata\\2_Metadata%20-%20Publication%20Level/Agriculture\\2018\\metadataSUABI9_2018.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/metadataSUABI9_2018.pdf",
#          notes = NULL,
#          update = myUpdate)
#
#
#
# #feature request: additional naming, does not work atm
#
# #input<- read.csv("10.2.7.csv", header= F)
# #output<- reorganise(input, schema = schema_paddy_seasonal)
#
# schema_paddy_seasonal<-
#   makeSchema(schema = list(
#     clusters= list(row= c(7,11,15), col= 1, height= 3, id= "measured"),
#     header = list(row = 1, rel= T),
#     variables = list(
#       territory =
#         list(type = "id", value = "malaysia"),
#       year =
#         list(type = "id", col = c(2:17), row= 5, dist= T),
#       commodities =
#         list(type = "id", col= 1, row= 1, rel= T),
#       planted =
#         list(type = "measured", row = c(2,3), col = c(2:17),
#              unit = "ha", factor = 1, key = "cluster", value = 1,
#              rel = T),
#       production =
#         list(type = "measured",  row = c(2,3), col = c(2:17),
#              unit = "t", factor = 1000, key = "cluster", value = 2,
#              rel = T),
#       yield =
#         list(type = "measured",  row = c(2,3), col = c(2:17),
#              unit = "t/ha", factor = 0.001, key = "cluster", value = 3,
#              rel = T))))
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "paddySeasonal",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_paddy_seasonal,
#          archive = "10.2.7.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "https://www.dosm.gov.my/v1/images/stories/files/metadata/item1_061211.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/item1_061211.pdf",
#          notes = "schema does not work, https://git.idiv.de/mas/projects/luckinet/software/tabshiftr/-/issues/12",
#          update = myUpdate)
#
#
# schema_pineapple_my<-makeSchema(schema = list(
#   header = list(row = 3, rel = F, merge = F),
#   meta = list(dec = NULL, del = "\\,", na = NULL),
#   variables = list(
#     territory =
#       list(type = "id", value = "malaysia"),
#     year =
#       list(type = "id", row = NULL, col = 1),
#     commodities =
#       list(type = "id", value = "pineapple"),
#     planted =
#       list(type = "measured", row = NULL, col = 2,
#            unit = "ha", factor = 1),
#     production =
#       list(type= "measured", row = NULL, col = 3, unit = "t", factor = 1))))
#
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "pineapple",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2016,
#          schema = schema_pineapple_my,
#          archive = "10.2.6.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "https:\\www.dosm.gov.my\\v1/uploads\\files\\4_Portal%20Content\\3_Methods%20%26%20Classifications\\1_Metadata\\2_Metadata%20-%20Publication%20Level/Agriculture\\2018\\metadataSUABI9_2018.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/metadataSUABI9_2018.pdf",
#          notes = NULL,
#          update = myUpdate)
#
#
#
# # schema formally correct but doesn't work! --> maybe thematic irrelevant
# #Warum funktioniert das nicht, bug oder fehler mit key &value? Problem evtl. bei : "Perkara \nItem mit dem absatz.
#
# # selbes problem wie issue!
#
# input<- read.csv("test10.2.9.csv", header = F)
#
#
# schema_select_spices_my<-makeSchema( schema = list(
#   header = list(row = c(4,5), merge= T, rel = F),
#   meta = list(del = NULL, dec= NULL, na = NULL),
#   variables =
#     list(territory =
#            list(type = "id", value = "malaysia"),
#          year =
#            list(type = "id",
#                 row = 5, col = c(3:18)),
#          commodities =
#            list(type = "id", value = NULL,
#                 row = c(6,8,10,12,14,16,18,20), col = 1),
#          planted =
#            list(type = "measured", unit = "ha", factor = 1,
#                 row = NULL, col = c(3:18) , key = "Item",
#                 value = "Planted Areas (Ha)"),
#          production =
#            list(type = "measured", unit = "n", factor = 1,
#                 row = NULL, col = c(3:18),key = "Item",
#                 value = "Production (Tonnes)" ))))
#
#
# #output<-reorganise(input, schema_select_spices_my)
#
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "selectSpices",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2016,
#          schema = schema_select_spices_my,
#          archive = "10.2.9.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "https://www.dosm.gov.my/v1/uploads/files/4_Portal%20Content/3_Methods%20%26%20Classifications/1_Metadata/2_Metadata%20-%20Publication%20Level/Agriculture/2018/metadataSUABI9_2018.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/metadataSUABI9_2018.pdf",
#          notes = "schema does not work, issue: key and value, wide id",
#          update = myUpdate)
#
#
#
# schema_herbs_my<-makeSchema(
#   list(
#     header = list(row = 2, rel = F),
#     meta = list(del = "//,", dec= NULL, na = NULL),
#     variables =
#       list(territory =
#              list(type = "id", value = "malaysia"),
#            year =
#              list(type = "id", value = NULL,
#                   row = NULL, col = 1, split = NULL, dist = F),
#            commodities =
#              list(type = "id", value= "herbs"),
#            planted =
#              list(type = "measured", unit = "ha", factor = 1,
#                   row = NULL, col = 2, rel = F),
#            production =
#              list(type = "measured", unit = "t", factor = 1,
#                   row = NULL, col = 3, rel = F))))
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "herbs",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2001,
#          end = 2015,
#          schema = schema_herbs_my,
#          archive = "10.2.10.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "annually",
#          metadataLink = "https://www.dosm.gov.my/v1/uploads/files/4_Portal%20Content/3_Methods%20%26%20Classifications/1_Metadata/2_Metadata%20-%20Publication%20Level/Agriculture/2018/metadataSUABI9_2018.pdf",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/meta/metadataSUABI9_2018.pdf",
#          update = myUpdate)
#
#
# schema_flowers_my<-makeSchema(
#   list(
#     header = list(row = 2, rel = F),
#     meta = list(del = "//,", dec= NULL, na = "n.a"),
#     variables =
#       list(territory =
#              list(type = "id", value = "malaysia"),
#            year =
#              list(type = "id", value = NULL,
#                   row = NULL, col = 1, split = NULL, dist = F),
#            commodities =
#              list(type = "id", value= "flowers"),
#            planted =
#              list(type = "measured", unit = "ha", factor = 1,
#                   row = NULL, col = 2, rel = F),
#            production =
#              list(type = "measured", unit = "n", factor = 1,
#                   row = NULL, col = 3, rel = F))))
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "flowers",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2003,
#          end = 2015,
#          schema = schema_flowers_my,
#          archive = "10.2.12.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
#
# schema_fruits_my<-makeSchema(
#   list(
#     header = list(row = 2, rel = F),
#     meta = list(del = "//,", dec= NULL, na = "n.a"),
#     variables =
#       list(territory =
#              list(type = "id", value = "malaysia"),
#            year =
#              list(type = "id", value = NULL,
#                   row = NULL, col = 1, split = NULL, dist = F),
#            commodities =
#              list(type = "id", value= "fruits"),
#            planted =
#              list(type = "measured", unit = "ha", factor = 1,
#                   row = NULL, col = 2, rel = F),
#            production =
#              list(type = "measured", unit = "t", factor = 1,
#                   row = NULL, col = 3, rel = F))))
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "fruits",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_fruits_my,
#          archive = "10.2.15.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
#
# #testen schema! klappt nicht
# # issue!
#
# #input<- read.csv("10.2.16.csv", header = F)
# ##output<-reorganise(input,schema_vegetables_my)
#
# #all 4 spreadsheets are important!
#
#
# schema_select_fruits_my<-makeSchema(
#   list(clusters =
#          list(row = NULL, col = NULL , id = NULL, height= NULL),
#        header = list(row = 5, rel = F),
#        meta = list(del = NULL, dec= NULL, na = NULL),
#        variables =
#          list(territory =
#                 list(type = "id", value = "malaysia"),
#               year =
#                 list(type = "id",
#                      row = 5, col = c(3:18)),
#               commodities =
#                 list(type = "id",
#                      row = NULL , col = 1),
#               planted =
#                 list(type = "measured", unit = "ha", factor = 1,
#                      row = 6, col = c(3:18), key= "Items", value= "PKeluasan Bertanam (Ha)\nPlanted Areas
#                        (Ha)"),
#               production =
#                 list(type = "measured", unit = "t", factor = 1,
#                      row = 2, col = c(3:18), rel = T,
#                      key = "Perkara\nItems", value = " Pengeluaran\n(Tan Metrik)\nProduction\n(Tonnes)"))))
#
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "selectfruits1",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_select_fruits_my,
#          archive = "10.2.16.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "does not work, issue: key and value, wide id",
#          update = myUpdate)
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "selectfruits2",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_select_fruits_my,
#          archive = "10.2.16.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "does not work, issue: key and value, wide id",
#          update = myUpdate)
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "selectfruits3",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_select_fruits_my,
#          archive = "10.2.16.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "does not work, issue: key and value, wide id",
#          update = myUpdate)
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "selectfruits4",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_select_fruits_my,
#          archive = "10.2.16.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "does not work, issue: key and value, wide id",
#          update = myUpdate)
#
# schema_vegetables_my<-makeSchema(
#   list(
#     header = list(row = 2, rel = F),
#     meta = list(del = "//,", dec= NULL, na = NULL),
#     variables =
#       list(territory =
#              list(type = "id", value = "malaysia"),
#            year =
#              list(type = "id", value = NULL,
#                   row = NULL, col = 1, split = NULL, dist = F),
#            commodities =
#              list(type = "id", value= "vegetables"),
#            planted =
#              list(type = "measured", unit = "ha", factor = 1,
#                   row = NULL, col = 2, rel = F),
#            production =
#              list(type = "measured", unit = "t", factor = 1,
#                   row = NULL, col = 3, rel = F))))
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "vegetables",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_vegetables_my,
#          archive = "10.2.17.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# schema_select_vegetables_my <- setCluster(id = "al1", left = 1, top = 4) %>%
#   setHeader(rows = c(1, 2), merge = TRUE, relative = TRUE) %>%
#   setIDVar(name = "al1", value = "Malaysia") %>%
#   setIDVar(name = "year", columns = c(3:18), row = 2, relative = TRUE) %>%
#   setIDVar(name = "commodities", columns = 1) %>%
#   setObsVar(name = "planted", unit = "ha", columns = c(3:18),
#             key = "Perkara\nItems", value = "Keluasan Bertanam (Ha)\nPlanted Areas (Ha)") %>%
#   setObsVar(name = "production", unit = "t", columns = c(3:18),
#             key = "Perkara\nItems", value = "Pengeluaran (Tan Metrik)\nProduction (Tonnes)")
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "selectVegetables1",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_select_vegetables_my,
#          archive = "10.2.18.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work: issue: key and value, wide id",
#          update = myUpdate)
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "selectVegetables2",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_select_vegetables_my,
#          archive = "10.2.18.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work: issue: key and value, wide id",
#          update = myUpdate)
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "selectVegetables3",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_select_vegetables_my,
#          archive = "10.2.18.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work: issue: key and value, wide id",
#          update = myUpdate)
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "selectVegetables4",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_select_vegetables_my,
#          archive = "10.2.18.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work: issue: key and value, wide id",
#          update = myUpdate)
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "selectVegetables5",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_select_vegetables_my,
#          archive = "10.2.18.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work: issue: key and value, wide id",
#          update = myUpdate)
#
#
#
# #just wide id
#
# schema_headcount_my<-makeSchema(
#   list(
#     header = list(row = 5),
#     meta = list(del = NULL, dec= NULL, na = NULL),
#     variables =
#       list(territory =
#              list(type = "id", value = "malaysia"),
#            year =
#              list(type = "id", value = NULL,
#                   row = 5, col = c(2:17)),
#            commodities =
#              list(type = "id", value= "cattle"),
#            headcount =
#              list(type = "measured", unit = "n", factor = 1,
#                   row = 7, col= c(2:17)))))
#
# #input<- read.csv("10.4.1.csv", header= F)
# ##output<-reorganise(input, schema_cattle_my)
#
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "cattle",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_headcount_my,
#          archive = "10.4.1-1.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work, issue: just wide id",
#          update = myUpdate)
#
#
#
# #wide id
# #input<-read.csv("10.4.2.csv", header= F)
#
# #output<-reorganise(input, schema_buffalo_my)
#
# schema_buffalo_my<-makeSchema(
#   list(clusters =
#          list(row = 4, col = 1, id = "territory"),
#        header = list(row = c(4,5), merge= T, rel = F),
#        meta = list(del = "//,", dec= NULL, na = NULL),
#        variables =
#          list(territory =
#                 list(type = "id", value = "malaysia"),
#               year =
#                 list(type = "id", value = NULL,
#                      row = NULL, col = c(2:17)),
#               commodities =
#                 list(type = "id", value= "buffalo"),
#               headcount =
#                 list(type = "measured", unit = "n", factor = 1,
#                      row = 7, col = c(2:17)))))
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "buffalo",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_buffalo_my,
#          archive = "10.4.2.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work, issue: just wide id",
#          update = myUpdate)
#
#
#
# #wide id
# #input<-read.csv("10.4.3.csv", header= F)
# #output<-reorganise(input, schema_goat_my)
#
# #gives output, when things are ordered headcount$row=NULL, but not the correct order!
#
# schema_goat_my<-makeSchema(
#   list(clusters =
#          list(row = 4, col = 1, id = "territory"),
#        header = list(row = c(4,5), merge= T, rel = F),
#        variables =
#          list(territory =
#                 list(type = "id", value = "malaysia"),
#               year =
#                 list(type = "id", value = NULL,
#                      row = 5, col = c(2:17)),
#               commodities =
#                 list(type = "id", value= NULL, value= "goat"),
#               headcount =
#                 list(type = "measured", unit = "n", factor = 1,
#                      row = 7, col = c(2:17)))))
#
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "goat",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_goat_my,
#          archive = "10.4.3.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work, issue: just wide id",
#          update = myUpdate)
#
# #input<-read.csv("10.4.4.csv", header= F)
# #output<-reorganise(input, schema_sheep_my)
#
# schema_sheep_my<-makeSchema(
#   list(clusters =
#          list(row = 4, col = 1, id = "territory"),
#        header = list(row = c(4,5), merge= T, rel = F),
#        variables =
#          list(territory =
#                 list(type = "id", value = "malaysia"),
#               year =
#                 list(type = "id", value = NULL,
#                      row = 5, col = c(2:17)),
#               commodities =
#                 list(type = "id", value= "sheep"),
#               headcount =
#                 list(type = "measured", unit = "n", factor = 1,
#                      row = 7, col = c(2:17)))))
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "sheep",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_sheep_my,
#          archive = "10.4.4.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work, issue: just wide id",
#          update = myUpdate)
#
#
# schema_swine_my<-makeSchema(
#   list(clusters =
#          list(row = 4, col = 1, id = "territory"),
#        header = list(row = c(4,5), merge= T, rel = F),
#        variables =
#          list(territory =
#                 list(type = "id", value = "malaysia"),
#               year =
#                 list(type = "id", value = NULL,
#                      row = 5, col = c(2:17)),
#               commodities =
#                 list(type = "id", value= "swine"),
#               headcount =
#                 list(type = "measured", unit = "n", factor = 1,
#                      row = 7, col = c(2:17)))))
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "swine",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_swine_my,
#          archive = "10.4.5.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work, issue: just wide id",
#          update = myUpdate)
#
# schema_chicken_my<-makeSchema(
#   list(clusters =
#          list(row = 4, col = 1, id = "territory"),
#        header = list(row = c(4,5), merge= T, rel = F),
#        variables =
#          list(territory =
#                 list(type = "id", value = "malaysia"),
#               year =
#                 list(type = "id", value = NULL,
#                      row = 5, col = c(2:17)),
#               commodities =
#                 list(type = "id", value= "chicken"),
#               headcount =
#                 list(type = "measured", unit = "n", factor = 1,
#                      row = 7, col = c(2:17)))))
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "chicken",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_chicken_my,
#          archive = "10.4.6.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work, issue: just wide id",
#          update = myUpdate)
#
#
# schema_duck_my<-makeSchema(
#   list(clusters =
#          list(row = 4, col = 1, id = "territory"),
#        header = list(row = c(4,5), merge= T, rel = F),
#        variables =
#          list(territory =
#                 list(type = "id", value = "malaysia"),
#               year =
#                 list(type = "id", value = NULL,
#                      row = 5, col = c(2:17)),
#               commodities =
#                 list(type = "id", value= "duck"),
#               headcount =
#                 list(type = "measured", unit = "n", factor = 1,
#                      row = 6, col = c(2:17)))))
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "duck",
#          dSeries = "midc",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2015,
#          schema = schema_duck_my,
#          archive = "10.4.7.xlsx",
#          archiveLink = "https://mysidc.statistics.gov.my/index.php?lang=en#",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work, issue: just wide id",
#          update = myUpdate)
#
#
#
#
#
# schema_cacoa_my_yield_96_18<-makeSchema(
#   list(clusters =
#          list(row = 4, col = 1, id = "territory"),
#        header = list(row = 5),
#        meta = list(del = "//,", dec= NULL, na = NULL),
#        variables =
#          list(territory =
#                 list(type = "id", value = "malaysia"),
#               year =
#                 list(type = "id", value = NULL,
#                      row = NULL, col = 1),
#               commodities =
#                 list(type = "id", value= "cacoa"),
#               yield =
#                 list(type = "measured", unit = "t/ha", factor = 0.001,
#                      row = NULL, col = 4))))
#
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "cacoaYield",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 1996,
#          end = 2018,
#          schema = schema_vegetables_my,
#          archive = "cocoa-4-3.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/malaysia-average-yield-of-cocoa-beans-2017/resource/ce96ffa1-27e1-43e5-a3b8-0210c1fccb23",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
# schema_replant_rubber_state<-
#   makeSchema(
#     list(clusters =
#            list(row = 3, col = 1, id = "year"),
#          header = list(row = c(3:5), merge= T),
#          meta = list(del = NULL, dec= "//.", na = NULL),
#          variables =
#            list(territory =
#                   list(type = "id", col= 1),
#                 year =
#                   list(type = "id", value = "2018",
#                        row = NULL, col = 1),
#                 commodities =
#                   list(type = "id", value= "rubber_replanting"),
#                 planted =
#                   list(type = "measured", unit = "ha", factor = 1,
#                        col = 7))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "replantRubber",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2018,
#          end = 2018,
#          schema = schema_replant_rubber_state,
#          archive = "tanam-semula-getah-risda-mac-2018.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/tanam-semula-getah-risda-mac-2018/resource/c9878886-d76d-4d0b-a405-787eadb0c527",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
#
# schema_logs_heav_hardwood_state<-
#   makeSchema(
#     list(clusters =
#            list(row = 5, col = 1, id = "year"),
#          header = list(row = 5),
#          meta = list(del = "\\,", dec= NULL, na = "-"),
#          variables =
#            list(territory =
#                   list(type = "id", row = 5, col= c(3:14)),
#                 year =
#                   list(type = "id", value = "2016"),
#                 commodities =
#                   list(type = "id", col= 1),
#                 production =
#                   list(type = "measured", unit = "m3", factor = 1,
#                        col = c(3:14)))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "logsHeavHardwood",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2016,
#          end = 2016,
#          schema = schema_logs_heav_hardwood_state,
#          archive = "4.-pengeluaran-kayu-balak-bagi-negeri-negeri-mengikut-kumpulan-kayu-keras-berat-2016.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/pengeluaran-kayu-balak-bagi-negeri-negeri-mengikut-kumpulan-kayu-keras-berat-2016/resource/ad8c7b9c-3522-4c2e-9216-67c3db60b868",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
#
#
# schema_logs_heav_hardwood<-
#   makeSchema(
#     list(clusters =
#            list(row = 5, col = 1, id = "territory"),
#          header = list(row = 5),
#          meta = list(del = "\\,", dec= NULL, na = "0"),
#          variables =list(
#            territory =
#              list(type = "id", value = "Malaysia"),
#            year =
#              list(type = "id", col = 1),
#            commodities =
#              list(type = "id", row= 5, col= c(2:22)),
#            production =
#              list(type = "measured", unit = "m3", factor = 1,
#                   col = c(2:22)))))
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "logsHeavHardwood",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2008,
#          end = 2017,
#          schema = schema_logs_heav_hardwood,
#          archive = "pengeluaran-kayu-balak-bagi-negeri-negeri-mengikut-kumpulan-kayu-keras-berat2017.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/pengeluaran-kayu-balak-bagi-negeri-negeri-mengikut-kumpulan-kayu-keras-berat-2016/resource/9a00d729-9fa7-4602-bad4-8e50723115b6",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
#
# schema_logs_light_hardwood_state<-
#   makeSchema(
#     list(clusters =
#            list(row = 5, col = 1, id = "year"),
#          header = list(row = 5),
#          meta = list(del = "\\,", dec= NULL, na = "-"),
#          variables =
#            list(territory =
#                   list(type = "id", row = 5, col= c(3:14)),
#                 year =
#                   list(type = "id", value = "2016"),
#                 commodities =
#                   list(type = "id", col= 1),
#                 production =
#                   list(type = "measured", unit = "m3", factor = 1,
#                        col = c(3:14)))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "logsLightHardwood",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2017,
#          end = 2017,
#          schema = schema_logs_light_hardwood_state,
#          archive = "6.-pengeluaran-kayu-balak-bagi-negeri-negeri-mengikut-kumpulan-kayu-keras-ringan-2016.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/pengeluaran-kayu-balak-bagi-negeri-negeri-mengikut-kumpulan-kayu-keras-ringan-2016/resource/1ae40749-aac0-4dbf-bba0-e8beafdef561",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
# schema_logs_light_hardwood<-
#   makeSchema(
#     list(clusters =
#            list(row = 5, col = 1, id = "territory"),
#          header = list(row = 5),
#          meta = list(del = "\\,", dec= NULL, na = "0"),
#          variables =list(
#            territory =
#              list(type = "id", value = "Malaysia"),
#            year =
#              list(type = "id", col = 1),
#            commodities =
#              list(type = "id", row= 5, col= c(2:50)),
#            production =
#              list(type = "measured", unit = "m3", factor = 1,
#                   col = c(2:50)))))
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "logsLightHardwood",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2008,
#          end = 2017,
#          schema = schema_logs_light_hardwood,
#          archive = "pengeluaran-kayu-balak-bagi-negeri-negeri-mengikut-kumpulan-kayu-keras-ringan2017.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/pengeluaran-kayu-balak-bagi-negeri-negeri-mengikut-kumpulan-kayu-keras-ringan-2016/resource/1ae40749-aac0-4dbf-bba0-e8beafdef562",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
#
#
# schema_logs_med_hardwood_state<-
#   makeSchema(
#     list(clusters =
#            list(row = 5, col = 1, id = "year"),
#          header = list(row = 5),
#          meta = list(del = "\\,", dec= NULL, na = "-"),
#          variables =
#            list(territory =
#                   list(type = "id", row = 5, col= c(3:14)),
#                 year =
#                   list(type = "id", value = "2017"),
#                 commodities =
#                   list(type = "id", col= 1),
#                 production =
#                   list(type = "measured", unit = "m3", factor = 1,
#                        col = c(3:14)))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "logsMedHardwood",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2016,
#          end = 2016,
#          schema = schema_logs_med_hardwood_state,
#          archive = "5.-pengeluaran-kayu-balak-bagi-negeri-negeri-mengikut-kumpulan-kayu-keras-sederhana-2016.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/pengeluaran-kayu-balak-bagi-negeri-negeri-mengikut-kumpulan-kayu-keras-sederhana-2016/resource/aeb92b4c-dfec-40ab-b639-b04078576d04",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
# schema_logs_med_hardwood<-
#   makeSchema(
#     list(clusters =
#            list(row = 5, col = 1, id = "territory"),
#          header = list(row = 5),
#          meta = list(del = "\\,", dec= NULL, na = "0"),
#          variables =list(
#            territory =
#              list(type = "id", value = "Malaysia"),
#            year =
#              list(type = "id", col = 1),
#            commodities =
#              list(type = "id", row= 5, col= c(2:38)),
#            production =
#              list(type = "measured", unit = "m3", factor = 1,
#                   col = c(2:38)))))
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "logsMedHardwood",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2008,
#          end = 2017,
#          schema = schema_logs_med_hardwood,
#          archive = "pengeluaran-kayu-balak-bagi-negeri-negeri-mengikut-kumpulan-kayu-keras-ringan2017.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/pengeluaran-kayu-balak-bagi-negeri-negeri-mengikut-kumpulan-kayu-keras-sederhana-2016/resource/aeb92b4c-dfec-40ab-b639-b04078576d05",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
#
# schema_reserved_forest_state<-
#   makeSchema(
#     list(clusters =
#            list(row = 5, col = 1, id = "year"),
#          header = list(row = c(5:8), merge= T),
#          meta = list(del = "\\,", dec= NULL, na = "0"),
#          variables =list(
#            territory =
#              list(type = "id", col= 1),
#            year =
#              list(type = "id", value= "2016"),
#            commodities =
#              list(type = "id", row= 6, col= c(3:8)),
#            planted =
#              list(type = "measured", unit = "ha", factor = 1,
#                   col = c(3:8)))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "reservedForest",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2016,
#          end = 2016,
#          schema = schema_reserved_forest_state,
#          archive = "2.-hutan-simpanan-kekal-mengikut-jenis-hutan-2016.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/hutan-simpanan-kekal-mengikut-jenis-hutan-2016/resource/5ad59723-4d1b-4b97-818f-e66063147fa0",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
#
# schema_permanent_reserved_forest_state<-
#   makeSchema(
#     list(clusters =
#            list(row = 5, col = 1, id = "year"),
#          header = list(row = c(5:8), merge= T),
#          meta = list(del = "\\,", dec= NULL, na = "0"),
#          variables =list(
#            territory =
#              list(type = "id", col= 1),
#            year =
#              list(type = "id", value= "2017"),
#            commodities =
#              list(type = "id", row= 6, col= c(3:8)),
#            planted =
#              list(type = "measured", unit = "ha", factor = 1,
#                   col = c(3,5,7,11)))))
#
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "permanentReservedForest",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2017,
#          end = 2017,
#          schema = schema_permanent_reserved_forest_state,
#          archive = "hutan-simpanan-kekal-mengikut-jenis-hutan-2017.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/hutan-simpanan-kekal-mengikut-jenis-hutan-2016/resource/5ad59723-4d1b-4b97-818f-e66063147fa0",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          note= NULL)
#
#
# ### forestManag?
#
#
#
# schema_amenity_forest_state<-
#   makeSchema(
#     list(clusters =
#            list(row = c(6,15,35,39,44,56,85,102,104,107,118,126), col = 1, height= c(9,20,4,6,12,29,17,2,3,11,8,2),  id = "territory"),
#          header = list(row = 1),
#          meta = list(del ="\\,", dec= "\\.", na = NULL),
#          variables =list(
#            territory =
#              list(type = "id", col= 2, row= 1, rel= T),
#            year =
#              list(type = "id", value = "2016"),
#            commodities =
#              list(type = "id", value = "amenity forest"),
#            planted =
#              list(type = "measured", unit = "ha", factor = 1,
#                   col = 4))))
#
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "amenityForest",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2016,
#          end = 2016,
#          schema = schema_amenity_forest_state,
#          archive = "21-senarai-hutan-lipur-dalam-hutan-simpanan-kekal-di-semenanjung-malaysia-2016.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/senarai-hutan-lipur-dalam-hutan-simpanan-kekal-di-semenanjung-malaysia-2016/resource/2959ff4c-c625-423b-9bc7-a13f1c085e4d",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          note= "numbers are partly doubled with ecoParc")
#
#
# #doubled with "amenity forest!", but additional(not new developed) entries for terranganu
#
# schema_eco_park_state<-
#   makeSchema(
#     list(clusters =
#            list(row = c(6,15,35,39,44,56,85,102,104,107,119,132), col = 1, height= c(9,20,4,6,12,29,17,2,3,12,13,2),  id = "territory"),
#          header = list(row = 1),
#          meta = list(del ="\\,", dec= "\\.", na = "0"),
#          variables =list(
#            territory =
#              list(type = "id", col= 2, row= 1, rel= T),
#            year =
#              list(type = "id", value = "2017"),
#            commodities =
#              list(type = "id", value = "amenity forest"),
#            planted =
#              list(type = "measured", unit = "ha", factor = 1,
#                   col = 4))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "ecoPark",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2017,
#          end = 2017,
#          schema = schema_eco_park_state,
#          archive = "senarai-taman-eko-rimba-dalam-hutan-simpanan-kekal-di-semenanjung-malaysia-2017.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/senarai-hutan-lipur-dalam-hutan-simpanan-kekal-di-semenanjung-malaysia-2016/resource/2959ff4c-c625-423b-9bc7-a13f1c085e4d",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          note=" is partly doubled with amenityForests/ new entries for terrenganu")
#
#
#
# schema_forestry_my <-
#   makeSchema(
#     list(
#       header = list(row = c(5:9), merge= T),
#       meta = list(del ="\\,", na = NULL, dec= "//,"),
#       variables =
#         list(territory =
#                list(type = "id", value = "malaysia"),
#              year =
#                list(type = "id", col = 1),
#              commodities =
#                list(type = "id", value = "forestry"),
#              harvested  =
#                list(type = "measured", unit = "ha", factor = 1, col = 4))))
#
#
# regTable(nation = "Malaysia",
#          level = 1,
#          subset = "forestry",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2003,
#          end = 2017,
#          schema = schema_forestry_my,
#          archive = "data-siri-masa-2008-2017-bagi-keluasan-hutan-yang-dilesenkan-untuk-pengusahasilan.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/data-siri-masa-2007-2016-bagi-keluasan-hutan-yang-dilesenkan-untuk-pengusahasilan/resource/0968af81-9403-406a-a583-80a8368a7e98",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          note= NULL)
#
#
# schema_forestry_state_16 <-
#   makeSchema(
#     list(
#       header = list(row = c(5:9), merge= T),
#       meta = list(del ="\\,", na = NULL, dec= "//,"),
#       variables =
#         list(territory =
#                list(type = "id", col= 1),
#              year =
#                list(type = "id", value= "2016"),
#              commodities =
#                list(type = "id", value = "forestry"),
#              harvested  =
#                list(type = "measured", unit = "ha", factor = 1, col = 4))))
#
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "forestry",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2016,
#          end = 2016,
#          schema = schema_forestry_state_16,
#          archive = "keluasan-hutan-yang-dilesenkan-untuk-pengusahasilan-2016.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/keluasan-hutan-yang-dilesenkan-untuk-pengusahasilan-2016/resource/766fce26-f3d5-4336-b7a5-c02b0275e536",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          note= NULL)
#
#
#
# schema_forestry_state_17 <-
#   makeSchema(
#     list(
#       header = list(row = c(5:9), merge= T),
#       meta = list(del ="\\,", na = NULL, dec= "//,"),
#       variables =
#         list(territory =
#                list(type = "id", col= 1),
#              year =
#                list(type = "id", value= "2017"),
#              commodities =
#                list(type = "id", value = "forestry"),
#              harvested  =
#                list(type = "measured", unit = "ha", factor = 1, col = 4))))
#
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "forestry",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2017,
#          end = 2017,
#          schema = schema_forestry_state_17,
#          archive = "keluasan-hutan-yang-dilesenkan-untuk-pengusahasilan2017.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/keluasan-hutan-yang-dilesenkan-untuk-pengusahasilan-2016/resource/766fce26-f3d5-4336-b7a5-c02b0275e536",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          note= NULL)
#
# #wide id
# schema_forest_manag<-
#   makeSchema(list(
#     header = list(row = 4),
#     meta = list(del =NULL, na = NULL, dec= NULL),
#     variables =
#       list(territory =
#              list(type = "id", value = "malaysia"),
#            year =
#              list(type = "id", row = 4, col= c(3:12)),
#            commodities =
#              list(type = "id", col= 1),
#            harvested  =
#              list(type = "measured", unit = "ha", factor = 1, row= 6, col = c(3:12)),
#            planted =
#              list(type = "measured", unit = "ha", factor = 1, row= c(8,17), col = c(3:12)))))
#
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "forestManag",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2007,
#          end = 2016,
#          schema = schema_forest_manag,
#          archive = "20-pembangunan-sumber-hutan-dan-pemeliharaan-pemuliharaan-alam-sekitar-2007-2016.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/pembangunan-sumber-hutan-dan-pemeliharaan-pemuliharaan-alam-sekitar-2007-2016",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          note= "schema does not work! issue: wide id / enrichment planting includes poor forest stand, degraded and open areas (former log landing areas, former logging camp sites, skid trails and shifting cultivation areas); data for Forest Eco-Park and State Park Forest as well as Education Forest (beginning 2014) are cumulative, while Planting of Medicinal Plants are current.")
#
#
# schema_forest_manag_08_17<-
#   makeSchema(list(
#     header = list(row = 4),
#     meta = list(del = NULL, na = NULL, dec= NULL),
#     variables =
#       list(territory =
#              list(type = "id", value = "malaysia"),
#            year =
#              list(type = "id", col= 2),
#            commodities =
#              list(type = "id", row= c(3:10), col= NULL),
#            harvested  =
#              list(type = "measured", unit = "ha", factor = 1, col = 3),
#            planted =
#              list(type = "measured", unit = "ha", factor = 1, col = c(5,10)))))
#
#
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "forestManag",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2008,
#          end = 2017,
#          schema = schema_forest_manag_08_17,
#          archive = "pembangunan-sumber-hutan-dan-pemeliharaan---pemuliharaan-alam-sekitar-2008-2017.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/pembangunan-sumber-hutan-dan-pemeliharaan-pemuliharaan-alam-sekitar-2007-2017",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          note= "schema does not work! issue: wide id / enrichment planting includes poor forest stand, degraded and open areas (former log landing areas, former logging camp sites, skid trails and shifting cultivation areas); data for Forest Eco-Park and State Park Forest as well as Education Forest (beginning 2014) are cumulative, while Planting of Medicinal Plants are current. ")
#
#
# schema_headcount_Selangor_dist <-
#   makeSchema(
#     list(
#       header = list(row = 3, rel = F),
#       meta = list(del =NULL, na = NULL, dec= NULL),
#       variables =
#         list(territory =
#                list(type = "id", value = NULL,
#                     row = NULL, col = 2, split = NULL, rel = F, dist = F),
#              year =
#                list(type = "id", value = NULL,
#                     row = NULL, col = 1, split = NULL, rel = F, dist = F),
#              commodities =
#                list(type = "id", value = NULL,
#                     row = 4, col = c(3:16), split = NULL, rel = F, dist = F),
#              headcount =
#                list(type = "measured", unit = "n", factor = 1,
#                     row = NULL, col = c(3:16), rel = F,
#                     key = NULL, value = NULL))))
#
#
#
# regTable(nation = "Malaysia",
#          level = 3,
#          subset = "headcount",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2010,
#          end = 2013,
#          schema = schema_headcount_Selangor_dist,
#          archive = "33---bilangan-ternakan-kategori-ruminan-mengikut-daerah-di-negeri-selangor.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/bilangan-ternakan-kategori-ruminan-mengikut-daerah-di-negeri-selangor/resource/653203ce-78fa-4c39-a0ab-0b7ca4258f45?inner_span=True",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
# schema_herbs_selangor <-makeSchema(
#   list(clusters =
#          list(row = 5, col = 1, width = NULL, height = NULL,
#               id = "territory"),
#        header = list(row = 1, rel = T),
#        meta = list(dec = ",", del = NULL, na = c("-")),
#        variables = list(
#          territory =
#            list(type = "id", value = "Selangor"),
#          year =
#            list(type = "id", value = NULL, split = NULL,
#                 row = NULL, col = 1, rel = F, dist = FALSE),
#          commodities =
#            list(type = "id", value = NULL, split = NULL,
#                 row = 5, col = c(2:21), rel = F, dist = FALSE),
#          planted =
#            list(type = "measured", unit = "ha", factor = 1,
#                 row = NULL, col = c(2:21), rel = F,
#                 key = NULL, value = NULL))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "herbs",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2010,
#          end = 2013,
#          schema = schema_herbs_selangor,
#          archive = "39---keluasan-tanaman-herba-dan-rempah-ratus-mengikut-jenis-tanaman-di-negeri-selangor-1.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/keluasan-tanaman-herba-dan-rempah-ratus-mengikut-jenis-tanaman-di-negeri-selangor/resource/dc022aab-f2dd-4500-be7e-5a3d9283f113",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
# schema_vegetables_selangor <-makeSchema(
#   list(
#     header = list(row = 4),
#     meta = list(dec = "\\,", del = NULL, na = "-"),
#     variables = list(
#       territory =
#         list(type = "id", value = "selangor"),
#       year =
#         list(type = "id", value = NULL, split = NULL,
#              row = NULL, col = 1, rel = F, dist = FALSE),
#       commodities =
#         list(type = "id", value = NULL, split = NULL,
#              row = 4, col = c(2:35), rel = F, dist = FALSE),
#       production =
#         list(type = "measured", unit = "t", factor = 1,
#              row = NULL, col = c(2:35), rel = F,
#              key = NULL, value = NULL))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "vegetables",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2010,
#          end = 2013,
#          schema = schema_vegetables_selangor,
#          archive = "40---keluasan-tanaman-sayur-sayuran-mengikut-jenis-tanaman-di-negeri-selangor.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/jumlah-penduduk-bandar-luar-bandar-dan-kepadatan-penduduk-mengikut-daerah-negeri-selangor-1994-2017/resource/5a8f0c75-ed09-459e-97dd-a1ebcb613627",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
# schema_fruits_selangor <-makeSchema(
#   list(
#     header = list(row = 4),
#     meta = list(dec = "\\,", del = NULL, na = "-"),
#     variables = list(
#       territory =
#         list(type = "id", value = "selangor"),
#       year =
#         list(type = "id", value = NULL, split = NULL,
#              row = NULL, col = 1, rel = F, dist = FALSE),
#       commodities =
#         list(type = "id", value = NULL, split = NULL,
#              row = 4, col = c(2:33), rel = F, dist = FALSE),
#       production =
#         list(type = "measured", unit = "t", factor = 1,
#              row = NULL, col = c(2:33), rel = F,
#              key = NULL, value = NULL))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "fruits",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2010,
#          end = 2013,
#          schema = schema_vegetables_selangor,
#          archive = "41---keluasan-tanaman-buah-buahan-mengikut-jenis-tanaman-di-negeri-selangor.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/keluasan-tanaman-buah-buahan-mengikut-jenis-tanaman-di-negeri-selangor/resource/67fe8735-f8fe-4c66-bb37-87eb8afe968c?inner_span=True",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
# schema_crops_selangor_dist <-
#   makeSchema(
#     list(
#       header = list(row = 4, rel = FALSE),
#       meta = list(del = "\\,", dec = "\\."),
#       variables =
#         list(
#           territory =
#             list(type = "id", value = NULL,
#                  row = 4, col = c(3:11)),
#           year =
#             list(type = "id", value = NULL,
#                  row = NULL, col = 1),
#           commodities =
#             list(type = "id", value = NULL,
#                  row = NULL, col = c(2:11)),
#           planted =
#             list(type = "measured", unit = "ha", factor = 1,
#                  row = NULL, col = (3:11), rel = FALSE,
#                  key = NULL, value = NULL))))
#
#
# regTable(nation = "Malaysia",
#          level = 3,
#          subset = "cropsselangor",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2010,
#          end = 2013,
#          schema = schema_crops_selangor_dist,
#          archive = "42---keluasan-jenis-tanaman-mengikut-daerah-di-negeri-selangor.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/keluasan-jenis-tanaman-mengikut-daerah-di-negeri-selangor/resource/639684fb-3a50-419c-ae60-5b741f3c1d2d",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = NULL,
#          update = myUpdate)
#
#
# #wide id key and value!
#
# schema_kelatan_floricult_dist <-
#   makeSchema(list(
#     header = list(row = 4),
#     variables =
#       list(territory =
#              list(type = "id", col = c(4:13), row = 4),
#            year =
#              list(type = "id", value = NULL,
#                   row = NULL, col = 1),
#            commodities =
#              list(type = "id",
#                   row = NULL , col = 2),
#            planted =
#              list(type = "measured", unit = "ha", factor = 1,
#                   row = NULL, col = c(4:13),
#                   key = "Maklumat /\nInforamtion", value = "LUAS BERTANAM (Hektar)"),
#            harvested  =
#              list(type = "measured", unit = "ha", factor = 1,
#                   row = NULL, col =c(4:13),
#                   key = "Maklumat /\nInforamtion", value = "LUAS BERHASIL  (Hektar)"),
#            production =
#              list(type = "measured", unit = "t", factor =0.001,
#                   row = NULL, col= c(4:13),
#                   key = "Maklumat /\nInforamtion", value = "PENGELUARAN (KG)"))))
#
#
#
# regTable(nation = "Malaysia",
#          level = 2,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset= "floricult",
#          begin = 2015,
#          end = 2016,
#          schema =schema_kelatan_floricult_dist,
#          archive = "perangkaan-jenis-tanaman-mengikut-daerah-di-negeri-kelantan-tahun-2015-dan-2016-2.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/perangkaan-jenis-tanaman-mengikut-daerah-di-negeri-kelantan/resource/6b2b6e19-70e8-4518-a4bd-c3d90fbcef27",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink ="unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work, key and value, wide id",
#          update = myUpdate)
#
#
# schema_kelatan_crops <-
#   makeSchema(list(
#     header = list(row = 4),
#     meta = list(del = "\\,", na = "0"),
#     variables =
#       list(
#         territory =
#           list(type = "id", value = "Kelatan"),
#         year =
#           list(type = "id", col = 1),
#         commodities =
#           list(type = "id", col = 2, split = "(?<=\\/)[[:space:]].+"),
#         planted =
#           list(type = "measured", unit = "ha", factor = 1,
#                col = 5),
#         harvested  =
#           list(type = "measured", unit = "ha", factor = 1,
#                col = 4),
#         production =
#           list(type = "measured", unit = "t", factor = 0.001,
#                col = 6))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset= "cropsKelatan",
#          begin = 2015,
#          end = 2016,
#          schema = schema_kelatan_crops,
#          archive = "20-kelantan---pengeluaran-tanaman-dan-iat-2015-dan-2016.xls",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/pengeluaran-tanaman-dan-iat-di-negeri-kelantan/resource/97a8c58d-d3d1-4e4e-a075-dafdba99b4d6",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink ="unknown",
#          metadataPath = "unknown",
#          notes = NULL,
#          update = myUpdate)
#
#
# schema_kelatan_rice_dist <-
#   makeSchema(list(
#     header = list(row = 4),
#     meta = list(del = NULL, dec= "\\.", na = "0"),
#     variables =
#       list(
#         territory =
#           list(type = "id", col= 2),
#         year =
#           list(type = "id", col = 1),
#         commodities =
#           list(type = "id",value = "Rice"),
#         planted =
#           list(type = "measured", unit = "ha", factor = 1,
#                col = 4),
#         harvested  =
#           list(type = "measured", unit = "ha", factor = 1,
#                col = 5),
#         production =
#           list(type = "measured", unit = "t", factor = 0.001,
#                col = 6))))
#
#
# regTable(nation = "malaysia",
#          level = 2,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset= "riceKelatan",
#          begin = 2015,
#          end = 2016,
#          schema = schema_kelatan_rice_dist,
#          archive = "19-kelantan---perangkaan-tanaman-padi-2015-dan-2016.xls",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/perangkaan-tanaman-padi-di-negeri-kelantan/resource/fcc3ed8a-49c5-4590-8b96-ec3c362669db",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink ="http://www.data.gov.my/data/en_US/dataset/perangkaan-tanaman-padi-di-negeri-kelantan/resource/fcc3ed8a-49c5-4590-8b96-ec3c362669db",
#          metadataPath = "I:/MAS/01_data/LUCKINet/areal database/adb_tables/incoming/Annika/Malaysia/meta",
#          notes = NULL,
#          update = myUpdate)
#
#
#
# #does not work
# #just wide id
# input<-read.csv("4-kelantan---penanaman-dan-pengeluaran-kenaf-2015.csv", header= F)
#
# schema_kelatan_kenaf_dist <-
#   makeSchema(list(
#     clusters =
#       list(row = 4, col = 1, id = "commodities"),
#     header = list(row = 5),
#     variables =
#       list(
#         territory =
#           list(type = "id", row = 5, col= c(2:8)),
#         year =
#           list(type = "id", value = "2015"),
#         commodities =
#           list(type = "id",value = "kenaf"),
#         planted =
#           list(type = "measured", unit = "ha", factor = 1, row = 7,
#                col = c(2:8)),
#         harvested  =
#           list(type = "measured", unit = "ha", factor = 1, row = 9,
#                col = c(2:8)),
#         production =
#           list(type = "measured", unit = "t", factor = 1,
#                col = c(2:8), row = 10))))
#
# #output<-reorganise(input,schema_kelatan_kenaf_dist )
#
# regTable(nation = "malaysia",
#          level = 3,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset= "kenafKelatan",
#          begin = 2015,
#          end = 2015,
#          schema = schema_kelatan_kenaf_dist,
#          archive = "4-kelantan---penanaman-dan-pengeluaran-kenaf-2015.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/perangkaan-tanaman-padi-di-negeri-kelantan/resource/fcc3ed8a-49c5-4590-8b96-ec3c362669db",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink ="unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work, just wide id",
#          update = myUpdate)
#
#
# schema_crops_kelatan_17<-
#   makeSchema(list(
#     clusters =
#       list(row = 4, col = 1, id = "territory"),
#     header = list(row = c(4,5), merge= T),
#     variables =
#       list(
#         territory =
#           list(type = "id", value= "kelatan"),
#         year =
#           list(type = "id", value = "2017"),
#         commodities =
#           list(type = "id", col= 2),
#         planted =
#           list(type = "measured", unit = "ha", factor = 1,
#                col = 4),
#         harvested  =
#           list(type = "measured", unit = "ha", factor = 1, row = NULL,
#                col = 5),
#         production =
#           list(type = "measured", unit = "t", factor = 1,
#                col = 6, row = NULL))))
#
# regTable(nation = "malaysia",
#          level = 2,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset= "cropsKelatan",
#          begin = 2017,
#          end = 2017,
#          schema = schema_crops_kelatan_17,
#          archive = "statistik-tanaman-mengikut-kategori-untuk-dalam-projek-dan-luar-projek-bagi-negeri-kelantan-tah.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/statistik-tanaman-mengikut-kategori-untuk-dalam-projek-dan-luar-projek-bagi-negeri-kelantan/resource/bf6854f6-0fe7-4a4f-a001-5d6efcfeec75",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = NULL,
#          update = myUpdate)
#
#
# schema_Logs_swamp_sarawak <-
#   makeSchema(list(
#     clusters =
#       list(row = 2, col = 1, id = "territory"),
#     header = list(row = 2, rel= F),
#     variables =
#       list(
#         territory =
#           list(type = "id", value = "sarawak"),
#         year =
#           list(type = "id", col = 1),
#         commodities =
#           list(type = "id", row = 2, col= c(2:12),rel= F ),
#         production =
#           list(type = "measured", unit = "ha", factor = 1,
#                row = NULL, col = c(2:12)))))
#
#
# regTable(nation = "malaysia",
#          level = 2,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2000,
#          end = 2017,
#          subset = "LogsSwamp",
#          schema = schema_Logs_swamp_sarawak,
#          archive = "log-production-of-swamp-species-from-2000-to-2017.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?organization=sarawak-state-government&_organization_limit=0&groups=pertanian",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = NULL,
#          update = myUpdate)
#
#
# schema_Logs_hill_swamp_sarawak <-
#   makeSchema(list(
#     clusters =
#       list(row = 2, col = 1,
#            id = "territory"),
#     header = list(row = 2),
#     variables =
#       list(
#         territory =
#           list(type = "id", value = "sarawak"),
#         year =
#           list(type = "id", col = 1),
#         commodities =
#           list(type = "id", row = 2 , col= c(2:4)),
#         production =
#           list(type = "measured", unit = "m3", factor = 1,
#                row = NULL, col = c(2:4)))))
#
# regTable(nation = "malaysia",
#          level = 2,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset= "logsHillSwamp",
#          begin = 2000,
#          end = 2018,
#          schema = schema_Logs_hill_swamp_sarawak,
#          archive = "stats-of-log-production-and-forest-revenue-type.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?organization=sarawak-state-government&_organization_limit=0&groups=pertanian",
#          nextUpdate = "unknown",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = NULL,
#          update = myUpdate)
#
#
# #same splitt problem like schema_headcount_melaka
# #input <- read_csv("mys_2_headcountMelaka_2015_2017_data.gov.my.csv",col_names = FALSE)
# #output <- reorganise(input = input, schema = schema_headcount_melaka_15_17)
#
#
# schema_headcount_melaka_15_17 <-
#   makeSchema(
#     list(clusters =
#            list(row = 4, col = 1,
#                 id = "territory"),
#          header = list(row = c(4:7)),
#          meta = list(del = NULL, dec = NULL, na = NULL),
#          variables =
#            list(
#              territory =
#                list(type = "id", value = "melaka"),
#              year =
#                list(type = "id", value = NULL,
#                     row = c(4:6), col = c(2,4,6)),
#              commodities =
#                list(type = "id", value = NULL,
#                     row = NULL, col = 1),
#              headcount =
#                list(type = "measured", unit = "n", factor = 1,
#                     row= 7, col= c(2,4,6) ))))
#
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "headcountMelaka",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2015,
#          end = 2017,
#          schema = schema_headcount_melaka_15_17,
#          archive = "perangkaan-ternakan-negeri-melaka.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?_organization_limit=0&groups=pertanian&organization=melaka-state-government",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = NULL,
#          update = myUpdate)
#
#
# #input<-read.csv("keluasan-bagi-tanaman-utama-2014---2016.csv", header= F)
# #output<-reorganise(input, schema_crops_melaka_14_16)
#
# schema_crops_melaka_14_16 <-
#   makeSchema(
#     list(clusters =
#            list(row = 4, col = 1,
#                 id = "territory"),
#          header = list(row = 4),
#          meta = list(del = NULL, dec = NULL, na = NULL),
#          variables =
#            list(
#              territory =
#                list(type = "id", value = "melaka"),
#              year =
#                list(type = "id", value = NULL,
#                     row = NULL, col = 1),
#              commodities =
#                list(type = "id", value = NULL,
#                     row = 4, col = c(3:9)),
#              planted =
#                list(type = "measured", unit = "ha", factor = 1,
#                     row= NULL, col= c(3:9)))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "cropsMelaka",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2015,
#          end = 2017,
#          schema = schema_crops_melaka_14_16,
#          archive = "2015-2017-keluasan-tanah-bagi-tanaman-utama.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?_organization_limit=0&groups=pertanian&organization=melaka-state-government",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = NULL,
#          update = myUpdate)
#
# #same splitt proplem like schema_crops_melaka_14_16
#
# ##input<-read.csv("perangkaan-ternakan-negeri-melaka-2014-2016.csv", header= F)
# ##output<-reorganise(input, schema_crops_melaka)
#
# # schema_crops_melaka <-
# #   makeSchema(
# #     list(clusters =
# #            list(row = 5, col = 1,
# #                 id = "territory"),
# #        header = list(row = 1, rel = T),
# #        meta = list(del = NULL, dec = "\\.", na = NULL),
# #          variables =
# #          list(
# #            territory =
# #              list(type = "id", value = "melaka"),
# #            year =
# #              list(type = "id", value = NULL,
# #                   row = 5, col = c(2:4)),
# #           commodities =
# #              list(type = "id", value = NULL,
# #                   row = NULL, col = 1, split = "(?<=/).*"),
# #           planted =
# #              list(type = "measured", unit = "ha", factor = 1,
# #                   row = NULL, col = c(2:4)))))
# #
# # regTable(nation = "Malaysia",
# #          level = 2,
# #          subset = "crops_Melaka",
# #          dSeries = "data.gov.my",
# #          gSeries = "gadm",
# #          begin = 2015,
# #          end = 2017,
# #          schema = schema_crops_melaka,
# #          archive = "2015-2017-keluasan-tanah-bagi-tanaman-utama.xlsx",
# #          archiveLink = "http://www.data.gov.my/data/en_US/dataset?_organization_limit=0&groups=pertanian&organization=melaka-state-government",
# #          updateFrequency = "unknown",
# #          metadataLink = "unknown",
# #          metadataPath = "unknown",
# #          notes = NULL,
# #          update = myUpdate)
#
#
# #input<-read.csv("pengeluaran-komoditi-pertanian-utama-2014-2016.csv", header= F)
# #output<-reorganise(input, schema_crops_prod_melaka_14_16)
#
# schema_crops_prod_melaka_14_16 <-
#   makeSchema(
#     list(clusters =
#            list(row = 4, col = 1,
#                 id = "territory"),
#          header = list(row = 1, rel = T),
#          meta = list(del = NULL, dec = "\\.", na = NULL),
#          variables =
#            list(
#              territory =
#                list(type = "id", value = "melaka"),
#              year =
#                list(type = "id", value = NULL,
#                     row = NULL, col = 1),
#              commodities =
#                list(type = "id", value = NULL,
#                     row = 4, col = c(3:9)),
#              production =
#                list(type = "measured", unit = "ha", factor = 1,
#                     row = NULL, col = c(3:9)))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "cropsProdMelaka",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2014,
#          end = 2016,
#          schema = schema_crops_prod_melaka_14_16,
#          archive = "pengeluaran-komoditi-pertanian-utama-2014-2016.xls",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?_organization_limit=0&groups=pertanian&organization=melaka-state-government",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = NULL,
#          update = myUpdate)
#
#
# #Splitt issue  "Tahun 2015", "Tanaman Kontan Cash Crops"; "Padi Paddy"
#
# #input<-read.csv("pengeluaran-komoditi-pertanian-utama.csv", header= F)
# #output<-reorganise(input, schema_crops_prod_melaka_15_17)
#
#
# schema_crops_prod_melaka_15_17 <-
#   makeSchema(
#     list(clusters =
#            list(row = c(7,9,11,13,15,17,19), col = 1,
#                 id = "commodities"),
#          header = list(row = 4),
#          variables =
#            list(
#              territory =
#                list(type = "id", value = "melaka"),
#              year =
#                list(type = "id",
#                     row = 5, col = c(3:5), dist= T),
#              commodities =
#                list(type = "id",
#                     row = c(7,9,11,13,15,17,19), col = 1),
#              production =
#                list(type = "measured", unit = "t", factor = 1,
#                     row = NULL, col = c(3:5)))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "cropsProdMelaka",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2015,
#          end = 2017,
#          schema = schema_crops_prod_melaka_15_17,
#          archive = "pengeluaran-komoditi-pertanian-utama.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?_organization_limit=0&groups=pertanian&organization=melaka-state-government",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = NULL,
#          update = myUpdate)
#
# schema_pineapple_plan_kedah_17 <-
#   makeSchema(
#     list(meta = list(del = "//,", dec ="//.", na = NULL),
#          header = list(row = 4),
#          variables =
#            list(
#              territory =
#                list(type = "id", col= 2),
#              year =
#                list(type = "id", col = 1),
#              commodities =
#                list(type = "id", value = "pineapple"),
#              planted =
#                list(type = "measured", unit = "ha", factor = 1,
#                     row = NULL, col = 4))))
#
#
# regTable(nation = "Malaysia",
#          level = 3,
#          subset = "pineappleKedah",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2017,
#          end = 2017,
#          schema = schema_pineapple_plan_kedah_17,
#          archive = "perangkaan-tanaman-nanas-negeri-kedah-mengikut-daerah-tahun-2017-1-1.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?_organization_limit=0&groups=pertanian&organization=kedah-state-government",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = NULL,
#          update = myUpdate)
#
#
#
# schema_rubber_kedah_13_16 <-
#   makeSchema(
#     list(meta = list(del = "//,", dec ="//.", na = NULL),
#          header = list(row = 4),
#          variables =
#            list(
#              territory =
#                list(type = "id", value= "kedah"),
#              year =
#                list(type = "id", col = 1),
#              commodities =
#                list(type = "id", value = "rubber"),
#              planted =
#                list(type = "measured", unit = "ha", factor = 1,
#                     row = NULL, col = 3),
#              production =
#                list(type = "measured", unit = "t", factor = 1,
#                     row = NULL, col = 4))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "rubberKedah",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2013,
#          end = 2016,
#          schema = schema_rubber_kedah_13_16,
#          archive = "perangkaan-getah-di-negeri-kedah-2013-2016-1.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?_organization_limit=0&groups=pertanian&organization=kedah-state-government",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = NULL,
#          update = myUpdate)
#
#
#
# #hier hat die tabelle einen Formatierungsfehler
# ##input<-read.csv("keluasan-dan-pengeluaran-padi-kawasan-mada-2014-2017.csv", header= F)
#
# schema_rice_kedah_2014_2017 <-
#   makeSchema(
#     list(cluster= list(row= c(15,17,20,23), col= 1),
#          meta = list(del = "//,", dec ="//.", na = NULL),
#          header = list(row = c(7:13), merge = T),
#          variables =
#            list(
#              territory =
#                list(type = "id", value= "kedah"),
#              year =
#                list(type = "id", col = 1),
#              commodities =
#                list(type = "id", value = "rubber"),
#              planted =
#                list(type = "measured", unit = "ha", factor = 1,
#                     row = NULL, col = 3),
#              production =
#                list(type = "measured", unit = "t", factor = 1,
#                     row = NULL, col = 4))))
#
# #output<-reorganise(input, schema_rice_kedah_2014_2017)
#
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "rice",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2014,
#          end = 2017,
#          schema =schema_rice_kedah_2014_2017,
#          archive = "keluasan-dan-pengeluaran-padi-kawasan-mada-2014-2017.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?_organization_limit=0&groups=pertanian&organization=kedah-state-government",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work: table has formatting error / issue:feature request: merge argument for variables",
#          update = myUpdate)
#
# #sehr messy! funktioniert noch nicht
# ##input<-read.csv("perangkaan-kelapa-sawit-tahun-2014-2017.csv", header= F)
#
#
# schema_palmoil_kedah_2014_2017 <-
#   makeSchema(
#     list(
#       meta = list(del = "//,", dec ="//.", na = NULL),
#       header = list(row = c(1:4), merge= T),
#       variables =
#         list(
#           territory =
#             list(type = "id", value= "kedah"),
#           year =
#             list(type = "id", col = 5, row= c(2:5)),
#           commodities =
#             list(type = "id", value = "palmoil"),
#           planted =
#             list(type = "measured", unit = "ha", factor = 1,
#                  row = 9, col = c(2:5)),
#           harvested =
#             list(type = "measured", unit = "ha", factor = 1,
#                  row = 13, col = c(2:5)),
#           production =
#             list(type = "measured", unit = "t", factor = 1,
#                  row = 22, col = c(2:5)),
#           yield =
#             list(type = "measured", unit = "t/ha/yr", factor = 1,
#                  row = 16, col = c(2:5)))))
#
# #output<-reorganise(input, schema_palmoil_kedah_2014_2017)
#
# regTable(nation = "Malaysia",
#          level = 2,
#          subset = "palmoilKedah",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2014,
#          end = 2017,
#          schema = schema_palmoil_kedah_2014_2017,
#          archive = "perangkaan-kelapa-sawit-tahun-2014-2017.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?_organization_limit=0&groups=pertanian&organization=kedah-state-government",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = "schema does not work",
#          update = myUpdate)
#
#
# schema_crops_pinang_2010_2020 <-
#   makeSchema(
#     list(clusters =
#            list(row = 3, col = 1, id = "territory"),
#          header = list(row = 4),
#          meta = list(dec= "\\."),
#          variables =
#            list(
#              territory =
#                list(type = "id", value = "Pinang"),
#              year =
#                list(type = "id",row = 4, col = c(2:12)),
#              commodities =
#                list(type = "id",col = 1, split = "(?<=\\/)[[:space:]].+"),
#              production =
#                list(type = "measured", unit = "t", factor = 1000, col = c(2:12)))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset = "cropsPinang2",
#          begin = 2010,
#          end = 2020,
#          schema = schema_crops_pinang_2010_2020,
#          archive = "2017----unjuran-pengeluaran-hasil-tanaman-000-tan-metrik-pulau-pinang-2010---2020-2.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?organization=penang-state-government&_organization_limit=0&groups=pertanian",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          notes = "shows projections")
#
#
# schema_livestock_pinang_dist<-
#   makeSchema(
#     list(
#       header = list(row = 2),
#       meta = list(dec= "\\."),
#       variables =
#         list(
#           territory =
#             list(type = "id", col = 1),
#           year =
#             list(type = "id",row = 2, col = c(4,5)),
#           commodities =
#             list(type = "id",col = 2),
#           headcount =
#             list(type = "measured", unit = "n", factor = 1, col = c(4,5)))))
#
#
# regTable(nation = "Malaysia",
#          level = 3,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset = "headcountPinang",
#          begin = 2016,
#          end = 2017,
#          schema = schema_livestock_pinang_dist,
#          archive = "2017--statistik-perbandingan-ternakan.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?organization=penang-state-government&_organization_limit=0&groups=pertanian",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
#
# schema_crops_pinang_al3_2017 <-
#   makeSchema(
#     list(clusters =
#            list(row = 1, col = 1, id = "year"),
#          header = list(row = 2),
#          variables =
#            list(
#              territory =
#                list(type = "id", col = 1),
#              year =
#                list(type = "id", value = "2017"),
#              commodities =
#                list(type = "id", col = 3),
#              harvested =
#                list(type = "measured", unit = "ha", factor = 1,
#                     col = 6),
#              planted =
#                list(type = "measured", unit = "ha", factor = 1,
#                     col = 7),
#              production =
#                list(type = "measured", unit = "t", factor = 0.001,
#                     col = 8),
#              yield =
#                list(type = "measured", unit = "kg/ha", factor = 0.001,
#                     col = 13))))
#
#
# regTable(nation = "Malaysia",
#          level = 3,
#          subset = "cropsPinang",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2017,
#          end = 2017,
#          schema = schema_crops_pinang_al3_2017,
#          archive = "2017---statistik-keluasan-tanaman-mengikut-daerah-di-pulau-pinang.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?organization=penang-state-government&_organization_limit=0&groups=pertanian",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate)
#
# #input<-read.csv("unjuranpengeluaran2013-2017.csv", header= F)
# #output<-reorganise(input,schema_crops_johor)
# #wie Tabelle 7(vignette), funktioniert nicht
#
# schema_crops_johor <-
#   makeSchema(
#     list(clusters =
#            list(row = 4, col = 1, id = "territory"),
#          header = list(row = 4),
#          variables =
#            list(
#              territory =
#                list(type = "id", value = "johor"),
#              year =
#                list(type = "id", col= 1),
#              commodities =
#                list(type = "id", row= 4, col = c(3:7)),
#              planted =
#                list(type = "measured", unit = "ha", factor = 1,
#                     col = c(3:7), key ="MAKLUMAT\nInformation", value = "Keluasan (Hektar)\nArea (Hectarage)"),
#              production =
#                list(type = "measured", unit = "t", factor = 1,
#                     col = c(3:7), key ="MAKLUMAT\nInformation", value = "Kuantiti (Tan Metrik)\nQuantity (Metric Tonnes)"))))
#
# regTable(nation = "Malaysia",
#          level = 2,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset = "cropsJohor",
#          begin = 2013,
#          end = 2017,
#          schema = schema_crops_johor,
#          archive = "unjuranpengeluaran2013-2017.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?organization=pejabat-pertanian-negeri-johor&_organization_limit=0&groups=pertanian",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          notes = "schema does not work, issue: key and value, wide id")
#
#
#
# #input<-read.csv("stnj2016-tanamansayur.csv", header= F)
# #output<-reorganise(input,schema_veggies_johor_dist)
# #wie Tabelle 7(vignette), funktioniert nicht
#
# schema_veggies_johor_dist<-
#   makeSchema(
#     list(
#       header = list(row = 4),
#       variables =
#         list(
#           territory =
#             list(type = "id", col= 2),
#           year =
#             list(type = "id", col= 1),
#           commodities =
#             list(type = "id", row= 4, col = c(4:37)),
#           planted =
#             list(type = "measured", unit = "ha", factor = 1,
#                  col = c(4:37), key ="MAKLUMAT\nInformation", value = "Keluasan (Hektar)\nArea (Hectarage)"),
#           production =
#             list(type = "measured", unit = "t", factor = 1,
#                  col = c(4:37), key ="MAKLUMAT\nInformation", value = "Kuantiti (Tan Metrik)\nQuantity (Metric Tonnes)"))))
#
#
# regTable(nation = "Malaysia",
#          level = 3,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset = "veggiesJohor",
#          begin = 2016,
#          end = 2016,
#          schema = schema_crops_johor,
#          archive = "stnj2016-tanamansayur.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?organization=pejabat-pertanian-negeri-johor&_organization_limit=0&groups=pertanian",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          notes = "schema does not work, issue: key and value, wide id")
#
# regTable(nation = "Malaysia",
#          level = 3,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset = "veggiesJohor",
#          begin = 2017,
#          end = 2017,
#          schema = schema_crops_johor,
#          archive = "stnj2017-tanamansayur.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?organization=pejabat-pertanian-negeri-johor&_organization_limit=0&groups=pertanian",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          notes = "schema does not work, issue: key and value, wide id")
#
#
# #input<-read.csv("stnj2016-tanamantanaman-ladang.csv", header= F)
# #output<-reorganise(input,schema_veggies_johor_dist)
# #wie Tabelle 7(vignette), funktioniert nicht
#
# schema_crops_johor_dist<-
#   makeSchema(
#     list(
#       header = list(row = 4),
#       variables =
#         list(
#           territory =
#             list(type = "id", col= 2),
#           year =
#             list(type = "id", col= 1),
#           commodities =
#             list(type = "id", row= 4, col = c(4:10)),
#           planted =
#             list(type = "measured", unit = "ha", factor = 1,
#                  col = c(4:10), key ="MAKLUMAT\nInformation", value = "Keluasan (Hektar)\nArea (Hectarage)"),
#           production =
#             list(type = "measured", unit = "t", factor = 1,
#                  col = c(4:10), key ="MAKLUMAT\nInformation", value = "Kuantiti (Tan Metrik)\nQuantity (Metric Tonnes)"))))
#
#
# regTable(nation = "Malaysia",
#          level = 3,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset = "cropsJohor",
#          begin = 2016,
#          end = 2016,
#          schema = schema_crops_johor,
#          archive = "stnj2016-tanamantanaman-ladang.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?organization=pejabat-pertanian-negeri-johor&_organization_limit=0&groups=pertanian",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          notes = "schema does not work, issue: key and value, wide id")
#
# regTable(nation = "Malaysia",
#          level = 3,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset = "cropsJohor",
#          begin = 2017,
#          end = 2017,
#          schema = schema_crops_johor,
#          archive = "stnj2017-tanamantanaman-ladang.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?organization=pejabat-pertanian-negeri-johor&_organization_limit=0&groups=pertanian",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          notes = "schema does not work, issue: key and value, wide id")
#
#
# schema_spices_johor_dist<-
#   makeSchema(
#     list(
#       meta = list(dec = NULL, del = NULL, na = "0.00"),
#       header = list(row = 4),
#       variables =
#         list(
#           territory =
#             list(type = "id", col= 2),
#           year =
#             list(type = "id", col= 1),
#           commodities =
#             list(type = "id", row= 4, col = c(4:19)),
#           planted =
#             list(type = "measured", unit = "ha", factor = 1,
#                  col = c(4:15), key ="MAKLUMAT\nInformation", value = "Luas Bertanam (Hektar) Planted Area (Hectarage)"),
#           harvested =
#             list(type = "measured", unit = "ha", factor = 1,
#                  col = c(4:15), key ="MAKLUMAT\nInformation", value = "Luas Berhasil (Hektar) Harvested Area (Hectarage)"),
#           production =
#             list(type = "measured", unit = "t", factor = 1,
#                  col = c(4:15), key ="MAKLUMAT\nInformation", value = "Pengeluaran (Metrik Tan) Production (Metric Tonnes)"))))
#
#
# regTable(nation = "Malaysia",
#          level = 3,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset = "spicesJohor",
#          begin = 2016,
#          end = 2016,
#          schema = schema_spices_johor_dist,
#          archive = "stnj2016-tanamanrempahratus.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?organization=pejabat-pertanian-negeri-johor&_organization_limit=0&groups=pertanian",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          notes = "schema does not work, issue: key and value, wide id")
#
# regTable(nation = "Malaysia",
#          level = 3,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset = "spicesJohor",
#          begin = 2017,
#          end = 2017,
#          schema = schema_spices_johor_dist,
#          archive = "stnj2017-tanamanrempahratus.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?organization=pejabat-pertanian-negeri-johor&_organization_limit=0&groups=pertanian",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          notes = "schema does not work, issue: key and value, wide id")
#
#
# schema_cash_crops_johor_dist<-
#   makeSchema(
#     list(
#       meta = list(dec = NULL, del = NULL, na = "0.00"),
#       header = list(row = 4),
#       variables =
#         list(
#           territory =
#             list(type = "id", col= 2),
#           year =
#             list(type = "id", col= 1),
#           commodities =
#             list(type = "id", row= 4, col = c(4:9)),
#           planted =
#             list(type = "measured", unit = "ha", factor = 1,
#                  col = c(4:9), key ="MAKLUMAT\nInformation", value = "Luas Bertanam (Hektar) Planted Area (Hectarage)"),
#           harvested =
#             list(type = "measured", unit = "ha", factor = 1,
#                  col = c(4:9), key ="MAKLUMAT\nInformation", value = "Luas Berhasil (Hektar) Harvested Area (Hectarage)"),
#           production =
#             list(type = "measured", unit = "t", factor = 1,
#                  col = c(4:9), key ="MAKLUMAT\nInformation", value = "Pengeluaran (Metrik Tan) Production (Metric Tonnes)"))))
#
#
# regTable(nation = "Malaysia",
#          level = 3,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset = "cashcropsJohor",
#          begin = 2016,
#          end = 2016,
#          schema = schema_cash_crops_johor_dist,
#          archive = "stnj2016-tanamantanaman-industri.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?organization=pejabat-pertanian-negeri-johor&_organization_limit=0&groups=pertanian",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          notes = "schema does not work, issue: key and value, wide id")
#
#
# schema_cash_crops_johor_dist_2017<-
#   makeSchema(
#     list(
#       meta = list(dec = NULL, del = NULL, na = "0.00"),
#       header = list(row = 4),
#       variables =
#         list(
#           territory =
#             list(type = "id", col= 2),
#           year =
#             list(type = "id", col= 1),
#           commodities =
#             list(type = "id", row= 4, col = c(4:13)),
#           planted =
#             list(type = "measured", unit = "ha", factor = 1,
#                  col = c(4:13), key ="MAKLUMAT\nInformation", value = "Luas Bertanam (Hektar) Planted Area (Hectarage)"),
#           harvested =
#             list(type = "measured", unit = "ha", factor = 1,
#                  col = c(4:13), key ="MAKLUMAT\nInformation", value = "Luas Berhasil (Hektar) Harvested Area (Hectarage)"),
#           production =
#             list(type = "measured", unit = "t", factor = 1,
#                  col = c(4:13), key ="MAKLUMAT\nInformation", value = "Pengeluaran (Metrik Tan) Production (Metric Tonnes)"))))
#
#
# regTable(nation = "Malaysia",
#          level = 3,
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          subset = "cashcropsJohor",
#          begin = 2017,
#          end = 2017,
#          schema = schema_cash_crops_johor_dist_2017,
#          archive = "stnj2017-tanamantanaman-industri.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset?organization=pejabat-pertanian-negeri-johor&_organization_limit=0&groups=pertanian",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = myUpdate,
#          notes = "schema does not work, issue: key and value, wide id")
#
#
#
#
#
# #split problem: everything but special charakter within wide id
#
# #input<-read.csv("bancian-2015-2018.csv", header= F)
# #output<-reorganise(input,schema_headcount_sembilian_dist)
#
#
# schema_headcount_sembilian_dist<-
#   makeSchema(list(
#     header = list(row = c(1,2), merge= T),
#     meta = list(del = NULL, na = NULL),
#     variables =
#       list(
#         territory =
#           list(type = "id", row = 1, col= c(3,5,7,9,11,13,15), split=NULL),
#         year =
#           list(type = "id", col = 1),
#         commodities =
#           list(type = "id", col= 2),
#         headcount =
#           list(type = "measured", unit = "n", factor = 1,
#                col = c(4,6,8,10,12,14,16)))))
#
# regTable(nation = "Malaysia",
#          level = 3,
#          subset = "headcountSembilan",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2015,
#          end = 2018,
#          schema = schema_headcount_sembilian_dist,
#          archive = "bancian-2015-2018.csv",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/ringkasan-bancian-ternakan-di-negeri-sembilan/resource/e5c9fc6c-152c-4c3a-9ed6-4d5e589a00b1",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = NULL,
#          update = myUpdate)
#
#
# #input<-read.csv("keluasan-pertanian-dan-tanaman.csv", header= F)
# #output<-reorganise(input,schema_crops_terrenganu_dist)
#
# schema_crops_terrenganu_dist<-
#   makeSchema(list(
#     header = list(row = 6),
#     meta = list(del = NULL, dec= "//.", na = "TIDAK DIPEROLEHI"),
#     variables =
#       list(
#         territory =
#           list(type = "id", col= 2),
#         year =
#           list(type = "id", col = 1),
#         commodities =
#           list(type = "id", col= 3),
#         planted =
#           list(type = "measured", unit = "ha", factor = 1,
#                col = 6))))
#
# regTable(nation = "Malaysia",
#          level = 3,
#          subset = "cropsTerrenganu",
#          dSeries = "data.gov.my",
#          gSeries = "gadm",
#          begin = 2013,
#          end = 2016,
#          schema = schema_crops_terrenganu_dist,
#          archive = "keluasan-pertanian-dan-tanaman.xlsx",
#          archiveLink = "http://www.data.gov.my/data/en_US/dataset/keluasan-pertanian-dan-tanaman-negeri-terengganu-2013-2016/resource/b349181c-b6d7-4580-b81c-7a419496c835",
#          updateFrequency = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          notes = NULL,
#          update = myUpdate)


# harmonise commodities ----
#
for(i in seq_along(ds)){

  tibble(new = get_variable(variable = "commodities", dataseries = ds[i])) %>%
    match_ontology(table = ., columns = "new", dataseries = ds[i], ontology = ontoDir)

}




# normalise geometries ----
#
normGeometry(nation = thisNation,
             pattern = gs[],
             outType = "gpkg",
             update = updateTables)


# normalise census tables ----
#
normTable(pattern = ds[1],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)

