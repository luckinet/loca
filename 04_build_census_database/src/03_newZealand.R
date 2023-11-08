# script arguments ----
#
# https://datafinder.stats.govt.nz/
# single file with all agricultural data: https://www.stats.govt.nz/large-datasets/csv-files-for-download/
# archived data (pdfs etc): https://cdm20045.contentdm.oclc.org/digital?page=1
# how to find old data not (yet) on the new website: https://www.stats.govt.nz/about-us/stats-nz-archive-website/
#
thisNation <- "New Zealand"

ds <- c("nzstat")
gs <- c("gadm36", "nzgis")


# 1. register dataseries ----
#
regDataseries(name = ds[1],
              description = "Stats NZ",
              homepage = "stats.govt.nz",
              licence_link = "unknown",
              licence_path = "not available")

# regDataseries(name = gs[2],
#               description = "Stats NZ",
#               homepage = "https://datafinder.stats.govt.nz",
#               licence_link = "unknown",
#               licence_path = "not available")


# 2. register geometries ----
#
# nzgis ----
# check whether the geometries are needed, because it's complicated. They have a separate file for each year
# regGeometry(gSeries = gs[2],
#             level = 3,
#             nameCol = "TA2019_V_1",
#             archive = "newZealand.zip|territorial-authority-2019-generalised.shp",
#             archiveLink = "https://datafinder.stats.govt.nz/layer/98755-territorial-authority-2019-generalised/",
#             nextUpdate = "unknown",
#             updateFrequency = "notPlanned",
#             overwrite = TRUE)
#
# regGeometry(gSeries = gs[2],
#             level = 2,
#             nameCol = "REGC2019_1",
#             archive = "newZealand.zip|regional-council-2019-generalised.shp",
#             archiveLink = "https://datafinder.stats.govt.nz/layer/98763-regional-council-2019-generalised/",
#             nextUpdate = "unknown",
#             updateFrequency = "notPlanned",
#             overwrite = TRUE)


# 3. register census tables ----
#
schema_nzstat_00 <- setCluster(id = "al1", left = 2, top = 3, height = 85) %>%
  setFormat(na_values = "..") %>%
  setIDVar(name = "al1", value = "New Zealand") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(2:6), rows = 3)

## crops ----
if(build_crops){

  ### nzstat ----
  regTable(nation = !!thisNation,
           label = "al2",
           subset = "",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2002,
           end = 2022,
           archive = "Horticulture by Regional Council.gz|TABLECODE7422_Data_5695fc2d-78c0-4bec-a65a-9fda3fbb4a93.csv",
           archiveLink = "", # where this table can be found online
           updateFrequency = "",
           nextUpdate = "",
           metadataPath = "",
           metadataLink = "")

}

## livestock ----
if(build_livestock){

  ### nzstat ----
  regTable(nation = !!thisNation,
           label = "al3",
           subset = "detailedLivestock",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 1990,
           end = 1996,
           archive = "AGR075601_20231109_055606_21.csv",
           archiveLink = "", # where this table can be found online
           updateFrequency = "",
           nextUpdate = "",
           metadataPath = "",
           metadataLink = "")

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "totalsLivestock",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 1990,
           end = 2022,
           archive = "AGR075701_20231109_055917_49.csv",
           archiveLink = "", # where this table can be found online
           updateFrequency = "",
           nextUpdate = "",
           metadataPath = "",
           metadataLink = "")

  # # ignored because detailed classes are not needed for now and totals are with more timesteps in the previous table
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "detailedLivestock",
  #          dSeries = ds[1],
  #          gSeries = gs[],
  #          schema = ,
  #          begin = 2002,
  #          end = 2022,
  #          archive = "Livestock Numbers by Regional Council.gz|TABLECODE7423_Data_997a98ba-6950-4239-8b95-a83665f3a589.csv",
  #          archiveLink = "", # where this table can be found online
  #          updateFrequency = "",
  #          nextUpdate = "",
  #          metadataPath = "",
  #          metadataLink = "")

}

## landuse ----
if(build_landuse){

  ### nzstat ----

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2001,
           end = 2018,
           archive = "Forestry by Regional Council.gz|TABLECODE7421_Data_039451bd-1495-4fc4-a4e3-df4fedf398df.csv",
           archiveLink = "", # where this table can be found online
           updateFrequency = "",
           nextUpdate = "",
           metadataPath = "",
           metadataLink = "")

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

normTable(pattern = ds[1],
          ontoMatch = "crop",
          outType = "rds",
          beep = 10)
