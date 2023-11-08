# script arguments ----
#
# source(paste0(mdl0301, "src/96_preprocess_usda.R"))
thisNation <- "United States of America"

ds <- c("usda")
gs <- c("gadm36")


# 1. register dataseries ----
#
regDataseries(name = "usda",
              description = "US Dept. of Agriculture - National Agricultural Statistics Service",
              homepage = "https://www.nass.usda.gov/Quick_Stats/Lite/index.php",
              licence_link = "public domain",
              licence_path = "")


# 2. register geometries ----
#
# regGeometry(gSeries = gs[2],
#             label = list(al2 = ""),
#             archive = "",
#             archiveLink = "",
#             updateFrequency = "unknown",
#             overwrite = TRUE)

# regGeometry(gSeries = gs[2],
#             label = list(al3 = ""),
#             archive = "",
#             archiveLink = "",
#             updateFrequency = "unknown",
#             overwrite = TRUE)

# regGeometry(nation = !!thisNation, # or any other "class = value" combination from the gazetteer
#             gSeries = gs[],
#             label = list(al_ = ""),
#             archive = "|",
#             archiveLink = "",
#             nextUpdate = "",
#             updateFrequency = "",
#             overwrite = TRUE)


# 3. register census and survey tables ----
#
## crops ----
if(build_crops){

  ### usda ----
  #### census ----
  schema_qs_crops <-
    setFormat(na_values = "(D)", thousand = ",") %>%
    setIDVar(name = "al2", columns = ) %>%
    setIDVar(name = "al3", columns = ) %>%
    setIDVar(name = "methdod", value = "census") %>%
    setIDVar(name = "year", columns = ) %>%
    setIDVar(name = "commodities", columns = ) %>%
    setObsVar(name = "headcount", unit = "n", columns = )

  regTable(un_region = thisNation,
           label = "al3",
           subset = "censusCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_qs_crops,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20231026.txt.gz",
           archiveLink = "https://www.nass.usda.gov/datasets/qs.crops_20231103.txt.gz",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  #### survey ----
  schema_qs_crops <-
    setFormat(na_values = "(D)", thousand = ",") %>%
    setIDVar(name = "al2", columns = ) %>%
    setIDVar(name = "al3", columns = ) %>%
    setIDVar(name = "methdod", value = "survey") %>%
    setIDVar(name = "year", columns = ) %>%
    setIDVar(name = "commodities", columns = ) %>%
    setObsVar(name = "headcount", unit = "n", columns = )

  regTable(un_region = thisNation,
           label = "al3",
           subset = "surveyCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_qs_crops,
           begin = 1909,
           end = 2022,
           archive = "qs.crops_20231026.txt.gz",
           archiveLink = "https://www.nass.usda.gov/datasets/qs.crops_20231103.txt.gz",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

}

## livestock ----
if(build_livestock){

  ### usda ----
  #### census ----
  schema_qs_animal_products <-
    setFormat(na_values = "(D)", thousand = ",") %>%
    setIDVar(name = "al2", columns = ) %>%
    setIDVar(name = "al3", columns = ) %>%
    setIDVar(name = "methdod", value = "census") %>%
    setIDVar(name = "year", columns = ) %>%
    setIDVar(name = "commodities", columns = ) %>%
    setObsVar(name = "headcount", unit = "n", columns = )

  regTable(un_region = thisNation,
           label = "al3",
           subset = "censusLivestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_qs_animal_products,
           begin = 1997,
           end = 2018,
           archive = "qs.animals_products_20220129.txt.gz",
           archiveLink = "https://www.nass.usda.gov/datasets/qs.animals_products_20231103.txt.gz",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  #### survey ----
  schema_qs_animal_products <-
    setFormat(na_values = "(D)", thousand = ",") %>%
    setIDVar(name = "al2", columns = ) %>%
    setIDVar(name = "al3", columns = ) %>%
    setIDVar(name = "methdod", value = "survey") %>%
    setIDVar(name = "year", columns = ) %>%
    setIDVar(name = "commodities", columns = ) %>%
    setObsVar(name = "headcount", unit = "n", columns = )

  regTable(un_region = thisNation,
           label = "al3",
           subset = "surveyLivestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_qs_animal_products,
           begin = 1919,
           end = 2023,
           archive = "qs.animals_products_20220129.txt.gz",
           archiveLink = "https://www.nass.usda.gov/datasets/qs.animals_products_20231103.txt.gz",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

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
#              al1 = thisNation,
#              outType = "gpkg")

normGeometry(pattern = gs[],
             # al1 = thisNation,
             outType = "gpkg")


# 5. normalise census tables ----
#
## in case the output shall be examined before writing into the DB
# testing <- normTable(nation = thisNation,
#                      update = FALSE,
#                      keepOrig = TRUE)
#
# only needed if FAO datasets have not been integrated before
# normTable(pattern = "fao",
#           al1 = thisNation,
#           outType = "rds")

normTable(pattern = ds[],
          # al1 = thisNation,
          ontoMatch = "commodity",
          outType = "rds")

