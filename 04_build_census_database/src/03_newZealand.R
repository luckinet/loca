# script arguments ----
#
# https://datafinder.stats.govt.nz/
# archived data (pdfs etc): https://cdm20045.contentdm.oclc.org/digital?page=1
# how to find old data not (yet) on the new website: https://www.stats.govt.nz/about-us/stats-nz-archive-website/
#
thisNation <- "New Zealand"

ds <- c("nzstat")
gs <- c("gadm", "nzGeo")


# 1. dataseries ----
#
regDataseries(name = ds[1],
              description = "Stats NZ",
              homepage = "stats.govt.nz",
              version = "2023.12",
              licence_link = "unknown")

regDataseries(name = gs[2],
              description = "NZ Geographic Data Service",
              homepage = "https://datafinder.stats.govt.nz/",
              version = "2023.12",
              licence_link = "unknown")


# 2. geometries ----
#
regGeometry(al1 = !!thisNation,
            gSeries = gs[2],
            label = list(al2 = "REGC2023_V1_00_NAME"), # REGional Council
            archive = "statsnz-regional-council-2023-clipped-generalised-GPKG.zip|regional-council-2023-clipped-generalised.gpkg",
            archiveLink = "https://datafinder.stats.govt.nz/layer/111181-regional-council-2023-clipped-generalised/",
            updateFrequency = "annual",
            downloadDate = ymd("2019-10-10"),
            overwrite = TRUE)

regGeometry(al1 = !!thisNation,
            gSeries = gs[2],
            label = list(al3 = "TA2023_V1_00_NAME"), # Territorial Authority
            archive = "statsnz-territorial-authority-2023-clipped-generalised-GPKG.zip|territorial-authority-2023-clipped-generalised.gpkg",
            archiveLink = "https://datafinder.stats.govt.nz/layer/111204-statistical-area-3-2023-clipped-generalised/",
            updateFrequency = "annual",
            downloadDate = ymd("2019-10-10"),
            overwrite = TRUE)

normGeometry(pattern = gs[2],
             beep = 10)

# 3. tables ----
#
if(build_crops){
  ## crops ----

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "horticulture",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2002,
           end = 2022,
           archive = "Horticulture by Regional Council.gz|TABLECODE7422_Data_5695fc2d-78c0-4bec-a65a-9fda3fbb4a93.csv",
           archiveLink = "https://nzdotstat.stats.govt.nz/wbos/index.aspx",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://nzdotstat.stats.govt.nz/wbos/index.aspx")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "grain",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2006,
           end = 2007,
           archive = "Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip|ag-prod-final-jun-07-tables1.xls",
           archiveLink = "https://www.stats.govt.nz/assets/Uploads/Agricultural-production-statistics/Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://www.stats.govt.nz/large-datasets/csv-files-for-download")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "grain",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2011,
           end = 2012,
           archive = "Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip|agprod-finaljun12-tables.xls",
           archiveLink = "https://www.stats.govt.nz/assets/Uploads/Agricultural-production-statistics/Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://www.stats.govt.nz/large-datasets/csv-files-for-download")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "grain",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2015,
           end = 2016,
           archive = "Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip|aps-jun16-final-tables.xls",
           archiveLink = "https://www.stats.govt.nz/assets/Uploads/Agricultural-production-statistics/Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://www.stats.govt.nz/large-datasets/csv-files-for-download")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "grain",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2016,
           end = 2017,
           archive = "Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip|agricultural-production-statistics-jun17-final-tables-v2.xlsx",
           archiveLink = "https://www.stats.govt.nz/assets/Uploads/Agricultural-production-statistics/Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://www.stats.govt.nz/large-datasets/csv-files-for-download")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "grain",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2017,
           end = 2018,
           archive = "Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip|agricultural-production-statistics-june-18-final.xlsx",
           archiveLink = "https://www.stats.govt.nz/assets/Uploads/Agricultural-production-statistics/Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://www.stats.govt.nz/large-datasets/csv-files-for-download")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "grain",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2018,
           end = 2019,
           archive = "Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip|agricultural-production-statistics-june-2019-final.xlsx",
           archiveLink = "https://www.stats.govt.nz/assets/Uploads/Agricultural-production-statistics/Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://www.stats.govt.nz/large-datasets/csv-files-for-download")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "grain",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2019,
           end = 2020,
           archive = "Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip|agricultural-production-statistics-june-2020-final.xlsx",
           archiveLink = "https://www.stats.govt.nz/assets/Uploads/Agricultural-production-statistics/Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://www.stats.govt.nz/large-datasets/csv-files-for-download")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "grain",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2021,
           end = 2022,
           archive = "Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip|agricultural-production-statistics-year-to-June-2022-final.xlsx",
           archiveLink = "https://www.stats.govt.nz/assets/Uploads/Agricultural-production-statistics/Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://www.stats.govt.nz/large-datasets/csv-files-for-download")

  normTable(pattern = ds[1],
            ontoMatch = "crop",
            beep = 10)

}

if(build_livestock){
  ## livestock ----

  schema_nzstat_livestock <-
    setFormat(na_values = c("..", "..C", "..S", "-")) %>%
    setIDVar(name = "al1", value = "New Zealand")

  schema_nzstat_livestock_detailed <- schema_nzstat_livestock %>%
    setFilter(rows = .find(is.na, col = 3, invert = TRUE)) %>%
    setIDVar(name = "al3", columns = 1) %>%
    setIDVar(name = "animal", columns = 2) %>%
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2), rows = 2) %>%
    setObsVar(name = "number_heads", columns = .find(fun = is.numeric, row = 2), top = 3)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "detailedLivestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_nzstat_livestock_detailed,
           begin = 1990,
           end = 1996,
           archive = "AGR075601_20231109_055606_21.csv",
           archiveLink = "https://infoshare.stats.govt.nz/Default.aspx",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://infoshare.stats.govt.nz/Default.aspx")

  schema_nzstat_livestock_totals <- schema_nzstat_livestock %>%
    setFilter(rows = .find(is.na, col = 3, invert = TRUE)) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "animal", columns = 2) %>%
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2), rows = 2) %>%
    setObsVar(name = "number_heads", columns = .find(fun = is.numeric, row = 2), top = 3)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "totalsLivestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_nzstat_livestock_totals,
           begin = 1990,
           end = 2022,
           archive = "AGR075701_20231109_055917_49.csv",
           archiveLink = "https://infoshare.stats.govt.nz/Default.aspx",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://infoshare.stats.govt.nz/Default.aspx")

  # # ignored because detailed classes are not needed for now and totals are with more time steps in the previous table
  # regTable(al1 = !!thisNation,
  #          label = "al2",
  #          subset = "detailedLivestock",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = schema_default,
  #          begin = 2002,
  #          end = 2022,
  #          archive = "Livestock Numbers by Regional Council.gz|TABLECODE7423_Data_997a98ba-6950-4239-8b95-a83665f3a589.csv",
  #          archiveLink = "", # where this table can be found online
  #          updateFrequency = "",
  #          nextUpdate = "",
  #          metadataPath = "",
  #          metadataLink = "")

  schema_nzstat_livestock_poultry <- schema_nzstat_livestock %>%
    setFilter(rows = .find(is.na, col = 3, invert = TRUE)) %>%
    setIDVar(name = "al3", columns = 1) %>%
    setIDVar(name = "year", value = "2002") %>%
    setIDVar(name = "animal", columns = c(3, 5, 7, 9), rows = 5) %>%
    setObsVar(name = "number_heads", columns = c(3, 5, 7, 9), top = 8)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "poultry",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_nzstat_livestock_poultry,
           begin = 2001,
           end = 2002,
           archive = "Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip|2-poultry-territorial.xls",
           archiveLink = "https://www.stats.govt.nz/assets/Uploads/Agricultural-production-statistics/Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://www.stats.govt.nz/large-datasets/csv-files-for-download")

  schema_nzstat_livestock_deer <- schema_nzstat_livestock %>%
    setFilter(rows = .find(is.na, col = 3, invert = TRUE)) %>%
    setIDVar(name = "al3", columns = 1) %>%
    setIDVar(name = "year", value = "2002") %>%
    setIDVar(name = "animal", columns = c(3, 5, 7, 9, 11), rows = 6) %>%
    setObsVar(name = "number_heads", columns = c(3, 5, 7, 9, 11), top = 9)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "deer",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_nzstat_livestock_deer,
           begin = 2001,
           end = 2002,
           archive = "Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip|4-deer-territorial.xls",
           archiveLink = "https://www.stats.govt.nz/assets/Uploads/Agricultural-production-statistics/Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://www.stats.govt.nz/large-datasets/csv-files-for-download")

  schema_nzstat_livestock_pigs <- schema_nzstat_livestock %>%
    setFilter(rows = .find(is.na, col = 3, invert = TRUE)) %>%
    setIDVar(name = "al3", columns = 1) %>%
    setIDVar(name = "year", value = "2002") %>%
    setIDVar(name = "animal", columns = c(3, 5, 7, 9), rows = 6) %>%
    setObsVar(name = "number_heads", columns = c(3, 5, 7, 9), top = 8)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "pigs",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_nzstat_livestock_pigs,
           begin = 2001,
           end = 2002,
           archive = "Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip|4-pigs-territorial.xls",
           archiveLink = "https://www.stats.govt.nz/assets/Uploads/Agricultural-production-statistics/Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://www.stats.govt.nz/large-datasets/csv-files-for-download")

  schema_nzstat_livestock_sheep <- schema_nzstat_livestock %>%
    setFilter(rows = .find(is.na, col = 2, invert = TRUE)) %>%
    setIDVar(name = "al3", columns = 1) %>%
    setIDVar(name = "year", value = "2002") %>%
    setIDVar(name = "animal", columns = c(2, 4, 6, 8, 10, 12, 14, 16, 18, 19), rows = 6) %>%
    setObsVar(name = "number_heads", columns = c(2, 4, 6, 8, 10, 12, 14, 16, 18, 19), top = 8)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "sheep",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_nzstat_livestock_sheep,
           begin = 2001,
           end = 2002,
           archive = "Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip|4-sheep-territorial.xls",
           archiveLink = "https://www.stats.govt.nz/assets/Uploads/Agricultural-production-statistics/Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://www.stats.govt.nz/large-datasets/csv-files-for-download")

  schema_nzstat_livestock_cattleBeef <- schema_nzstat_livestock %>%
    setFilter(rows = .find(is.na, col = 2, invert = TRUE)) %>%
    setIDVar(name = "al3", columns = 1) %>%
    setIDVar(name = "year", value = "2002") %>%
    setIDVar(name = "animal", columns = c(2, 4, 6, 8, 9, 10, 11, 13, 14, 16, 18, 19, 21), rows = 6) %>%
    setObsVar(name = "number_heads", columns = c(2, 4, 6, 8, 9, 10, 11, 13, 14, 16, 18, 19, 21), top = 8)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "cattleBeef",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_nzstat_livestock_cattleBeef,
           begin = 2001,
           end = 2002,
           archive = "Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip|5-beef-territorial.xls",
           archiveLink = "https://www.stats.govt.nz/assets/Uploads/Agricultural-production-statistics/Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://www.stats.govt.nz/large-datasets/csv-files-for-download")

  schema_nzstat_livestock_cattleDairy <- schema_nzstat_livestock %>%
    setFilter(rows = .find(is.na, col = 3, invert = TRUE)) %>%
    setIDVar(name = "al3", columns = 1) %>%
    setIDVar(name = "year", value = "2002") %>%
    setIDVar(name = "animal", columns = c(3, 5, 7, 9, 11, 13), rows = 7) %>%
    setObsVar(name = "number_heads", columns = c(3, 5, 7, 9, 11, 13), top = 9)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "cattleDairy",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_nzstat_livestock_cattleDairy,
           begin = 2001,
           end = 2002,
           archive = "Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip|5-dairy-territorial.xls",
           archiveLink = "https://www.stats.govt.nz/assets/Uploads/Agricultural-production-statistics/Agricultural-Production-Statistics-key-tables-from-APS-2002-2017.zip",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://www.stats.govt.nz/large-datasets/csv-files-for-download")

  normTable(pattern = ds[1],
            ontoMatch = "animal",
            beep = 10)

}

if(build_landuse){
  ## landuse ----

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "forest",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2001,
           end = 2018,
           archive = "Forestry by Regional Council.gz|TABLECODE7421_Data_039451bd-1495-4fc4-a4e3-df4fedf398df",
           archiveLink = "https://nzdotstat.stats.govt.nz/wbos/index.aspx",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "",
           metadataLink = "https://nzdotstat.stats.govt.nz/wbos/index.aspx")

  normTable(pattern = ds[1],
            ontoMatch = "landuse",
            beep = 10)
}

#### test schemas

myRoot <- paste0(census_dir, "/adb_tables/stage2/")
myFile <- "Russian Federation_al3_livestockAdygea_2008_2020_rosstat.csv"
schema <- schema_livestock

input <- read_csv(file = paste0(myRoot, myFile),
                  col_names = FALSE,
                  col_types = cols(.default = "c"))

validateSchema(schema = schema, input = input)

output <- reorganise(input = input, schema = schema)

#### delete this section after finalising script
