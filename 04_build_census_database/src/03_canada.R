# ----
# geography : Canada
# period    : 1921 - 2021
# dataseries: Statistics Canada (https://www.statcan.gc.ca/eng/start)
# variables :
#   - land      : hectares_covered
#   - crops     : hectares_harvested
#   - livestock : number_heads, colonies
#   - technology: -
#   - social    : -
# sampling  : survey, census
# spatial   : Nation, Province, Census Division, Census Consolidated Subdivisions
# authors   : Steffen Ehrmann
# date      : 2024-03-27
# status    : normalize, done
# comment   : -
# ----

# other material:
# - overview of land use, tenure and management: https://www150.statcan.gc.ca/n1/pub/95-634-x/2017001/article/54903-eng.htm
# - land tenure: https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210023401
# - greenhouse database: https://www.statcan.gc.ca/en/lode/databases/odg
# - 2001 agricultural census at fine spatial level (but available only in html): https://www150.statcan.gc.ca/n1/pub/95f0301x/4151237-eng.htm
#
# source(paste0(mdl0301, "src/96_preprocess_statcan.R")) the filtering here is not fully correct, needs to be revised before publication
thisNation <- "Canada"

ds <- c("statcan")
gs <- c("gadm", "statcan")


# 1. dataseries ----
#
regDataseries(name = ds[1],
              description = "Statistics Canada",
              homepage = "https://www.statcan.gc.ca/eng/start",
              version = "2023.12",
              licence_link = "https://www.statcan.gc.ca/eng/reference/licence")


# 2. geometries ----
#
regGeometry(al1 = !!thisNation, # provinces/territories
            gSeries = gs[2],
            label = list(al2 = "PRENAME"),
            archive = "lpr_000b21a_e.zip|lpr_000b21a_e.shp",
            archiveLink = "https://www12.statcan.gc.ca/census-recensement/2021/geo/sip-pis/boundary-limites/files-fichiers/lpr_000b21a_e.zip",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "unknown")

# regGeometry(al1 = !!thisNation, # census agricultural regions
#             gSeries = gs[2],
#             label = list(al3 = "CARENAME"),
#             archive = "lcar000b21a_e.zip|lcar000b21a_e.shp",
#             archiveLink = "https://www12.statcan.gc.ca/census-recensement/2021/geo/sip-pis/boundary-limites/files-fichiers/lcar000b21a_e.zip",
#             updateFrequency = "unknown")

regGeometry(al1 = !!thisNation,  # census divisions
            gSeries = gs[2],
            label = list(al3 = "CDNAME"),
            archive = "lcd_000b21a_e.zip|lcd_000b21a_e.shp",
            archiveLink = "https://www12.statcan.gc.ca/census-recensement/2021/geo/sip-pis/boundary-limites/files-fichiers/lcd_000b21a_e.zip",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "unknown")

regGeometry(al1 = !!thisNation,  # census consolidated subdivisions
            gSeries = gs[2],
            label = list(al4 = "CCSNAME"),
            archive = "lccs000b21a_e.zip|lccs000b21a_e.shp",
            archiveLink = "https://www12.statcan.gc.ca/census-recensement/2021/geo/sip-pis/boundary-limites/files-fichiers/lccs000b21a_e.zip",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "unknown")

normGeometry(pattern = gs[2],
             beep = 10)


# 3. tables ----
#
schema_statcan <-
  setIDVar(name = "al1", value = "Canada") %>%
  setIDVar(name = "al2", columns = .find(pattern = "GEO$", row = 1)) %>%
  setIDVar(name = "year", columns = .find(pattern = "REF_DATE", row = 1))

schema_statcan_census <- schema_statcan %>%
  setIDVar(name = "method", value = "census") %>%
  setIDVar(name = "al3", columns = .find(pattern = "GEO3", row = 1), split = "^(.*),[^,]*$") %>%
  setIDVar(name = "al4", columns = .find(pattern = "GEO4", row = 1), split = "^(.*),[^,]*$")

schema_statcan_survey <- schema_statcan %>%
  setIDVar(name = "method", value = "survey")

if(build_crops){
  ## crops ----
  schema_statcan01 <- schema_statcan %>%
    setIDVar(name = "crop", columns = .find(pattern = "Selected crops", row = 1)) %>%
    setObsVar(name = "hectares_harvested", columns = .find(pattern = "VALUE", row = 1),
              key = .find(pattern = "Unit of measure", row = 1), value = "Hectares")

  ### various crops (historic) ----
  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "censusSelectedCropsHistoric",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan01,
           begin = 1921,
           end = 2021,
           archive = "32100154-eng.zip|32100154.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100154-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100154_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210015401",
           overwrite = TRUE)

  ### field crops and hay ----
  schema_statcan_census01 <- schema_statcan_census %>%
    setIDVar(name = "crop", columns = .find(pattern = "Hay and field crops", row = 1)) %>%
    setObsVar(name = "hectares_harvested", columns = .find(pattern = "VALUE", row = 1),
              key = .find(pattern = "Unit of measure", row = 1), value = "Hectares")

    regTable(al1 = !!thisNation,
           label = "al4",
           subset = "censusFieldCropsHay",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_census01,
           begin = 2011,
           end = 2016,
           archive = "32100416-eng.zip|32100416.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100416-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100416_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210041601",
           overwrite = TRUE)

  ### principal crops ----
  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "principalCropsSmallArea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 1976,
           end = 2022,
           archive = "32100002-eng.zip|32100002.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100002-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100002_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210000201",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "principalCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 1908,
           end = 2023,
           archive = "32100359-eng.zip|32100359.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100359-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100359_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210035901",
           overwrite = TRUE)

  ### potatoes ----
  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "potatoes",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 1908,
           end = 2023,
           archive = "32100358-eng.zip|32100358.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100358-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100358_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210035801",
           overwrite = TRUE)

  ### fruit ----
  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "surveyFruits",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 1926,
           end = 2022,
           archive = "32100364-eng.zip|32100364.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100364-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100364_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210036401",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "censusFruit",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 2011,
           end = 2016,
           archive = "32100417-eng.zip|32100417.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100417-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100417_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210041701",
           overwrite = TRUE)

  ### vegetables ----
  # regTable(al1 = !!thisNation,
  #          label = "al2",
  #          subset = "surveyVegetablesHistoric",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_default,
  #          begin = 1940,
  #          end = 1996,
  #          archive = "32100263-eng.zip|32100263.csv",
  #          archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100263-eng.zip",
  #          updateFrequency = "annual",
  #          downloadDate = ymd("2019-10-10"),
  #          metadataLink = "32100263_MetaData.csv",
  #          metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210026301",
  #          overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "surveyVegetables",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 1940,
           end = 2022,
           archive = "32100365-eng.zip|32100365.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100365-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100365_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210036501",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "censusVegetables",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 2011,
           end = 2016,
           archive = "32100418-eng.zip|32100418.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100418-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100418_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210041801",
           overwrite = TRUE)

  ### fruit and vegetables (organic) ----
  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "surveyFruitVegetablesOrganic",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 2019,
           end = 2022,
           archive = "32100212-eng.zip|32100212.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100212-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100212_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210021201",
           overwrite = TRUE)

  ### corn and soybean (gmo) ----
  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "censusVegetables",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 2011,
           end = 2016,
           archive = "32100042-eng.zip|32100042.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100042-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100042_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210004201",
           overwrite = TRUE)

  ### greenhouse and mushrooms ----
  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "surveyGreenhouse",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 1955,
           end = 2022,
           archive = "32100456-eng.zip|32100456.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100456-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100456_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210045601",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "SurveyMushrooms",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 1964,
           end = 2022,
           archive = "32100356-eng.zip|32100356.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100356-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100356_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210035601",
           overwrite = TRUE)

  schema_statcan_shroom_hist <- schema_statcan %>%
    setIDVar(name = "crop", columns = .find(pattern = "Selected crops", row = 1)) %>%
    setObsVar(name = "hectares_harvested", columns = .find(pattern = "VALUE", row = 1),
              key = .find(pattern = "Unit of measure", row = 1), value = "Hectares")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "censusGreenhouseMushroomsHistoric",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_shroom_hist,
           begin = 1981,
           end = 2021,
           archive = "32100159-eng.zip|32100159.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100159-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100159_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210015901",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "censusGreenhouseMushrooms",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 2011,
           end = 2016,
           archive = "32100420-eng.zip|32100420.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100420-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100420_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042001",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "censusMushrooms",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 2021,
           end = 2021,
           archive = "32100361-eng.zip|32100361.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100361-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100361_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210036101",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "censusGreenhouse",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 2021,
           end = 2021,
           archive = "32100360-eng.zip|32100360.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100360-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100360_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210036001",
           overwrite = TRUE)

  ### sod and nurseries ----
  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "surveyNuerseries",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 2007,
           end = 2022,
           archive = "32100029-eng.zip|32100029.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100029-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100029_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210002901",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "censusSodNurseries",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 2011,
           end = 2016,
           archive = "32100419-eng.zip|32100419.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100419-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100419_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210041901",
           overwrite = TRUE)

  # this is part of landuse in 2021
  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "censusChristmastrees",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 2011,
           end = 2016,
           archive = "32100421-eng.zip|32100421.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100421-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100421_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042101",
           overwrite = TRUE)

  ### flowers ----
  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "surveyFlowers",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 2016,
           end = 2022,
           archive = "32100452-eng.zip|32100452.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100452-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100452_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210045201",
           overwrite = TRUE)

  normTable(pattern = ds[1],
            ontoMatch = "crop",
            beep = 10)

}

if(build_livestock){
  ## livestock ----

  ### other livestock ----
  schema_statcan_survey_otherLivestock <- schema_statcan_survey %>%
    setIDVar(name = "animal", columns = .find(pattern = "Selected livestock", row = 1)) %>%
    setObsVar(name = "number_heads", columns = .find(pattern = "VALUE", row = 1),
              key = .find(pattern = "Unit of measure", row = 1), value = "Number of animals")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "otherLivestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_survey_otherLivestock,
           begin = 1921,
           end = 2021,
           archive = "32100155-eng.zip|32100155.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100155-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "32100155_MetaData.csv",
           metadataLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210015501",
           overwrite = TRUE)

  schema_statcan_census_otherLivestock <- schema_statcan_census %>%
    setIDVar(name = "animal", columns = .find(pattern = "Other livestock", row = 1)) %>%
    setObsVar(name = "number_heads", columns = .find(pattern = "VALUE", row = 1),
              key = .find(pattern = "Unit of measure", row = 1), value = "Number of animals")

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "otherLivestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_census_otherLivestock,
           begin = 2011,
           end = 2016,
           archive = "32100427-eng.zip|32100427.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100427-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100427_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210042701",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "otherLivestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_census_otherLivestock,
           begin = 2021,
           end = 2021,
           archive = "32100373-eng.zip|32100373.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100373-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100373_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210037301",
           overwrite = TRUE)

  ### cattle ----
  schema_statcan_survey_cattle <- schema_statcan_survey %>%
    setFilter(rows = .find(pattern = "At July 1", col = 5)) %>%
    setIDVar(name = "animal", columns = .find(pattern = "Livestock", row = 1)) %>%
    setObsVar(name = "number_heads", factor = 1000, columns = .find(pattern = "VALUE", row = 1),
              key = .find(pattern = "Farm type", row = 1), value = "On all cattle operations")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "cattle",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_survey_cattle,
           begin = 1931,
           end = 2023,
           archive = "32100130-eng.zip|32100130.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100130-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "32100130_MetaData.csv",
           metadataLink = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210013001",
           overwrite = TRUE)

  schema_statcan_census_cattle <- schema_statcan_census %>%
    setIDVar(name = "animal", columns = .find(pattern = "Cattle and calves", row = 1)) %>%
    setObsVar(name = "number_heads", columns = .find(pattern = "VALUE", row = 1),
              key = .find(pattern = "Unit of measure", row = 1), value = "Number of animals")

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "cattle",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_census_cattle,
           begin = 2011,
           end = 2016,
           archive = "32100424-eng.zip|32100424.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100424-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100424_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042401",
           overwrite = TRUE)

  schema_statcan_census_cattle2 <- schema_statcan_census %>%
    setIDVar(name = "animal", columns = .find(pattern = "Cattle", row = 1)) %>%
    setObsVar(name = "number_heads", columns = .find(pattern = "VALUE", row = 1),
              key = .find(pattern = "Unit of measure", row = 1), value = "Number of animals")

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "cattle",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_census_cattle2,
           begin = 2021,
           end = 2021,
           archive = "32100370-eng.zip|32100370.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100370-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100370_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210037001",
           overwrite = TRUE)

  ### pigs ----
  schema_statcan_survey_pig <- schema_statcan_survey %>%
    setFilter(rows = .find(pattern = "At July 1", col = 5)) %>%
    setIDVar(name = "animal", columns = .find(pattern = "Livestock", row = 1)) %>%
    setObsVar(name = "number_heads", columns = .find(pattern = "VALUE", row = 1))

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "pigs",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_survey_pig,
           begin = 2008,
           end = 2023,
           archive = "32100160-eng.zip|32100160.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100160-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "32100160_MetaData.csv",
           metadataLink = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210016001",
           overwrite = TRUE)

  schema_statcan_census_pigs <- schema_statcan_census %>%
    setIDVar(name = "animal", columns = .find(pattern = "Pigs", row = 1)) %>%
    setObsVar(name = "number_heads", columns = .find(pattern = "VALUE", row = 1),
              key = .find(pattern = "Unit of measure", row = 1), value = "Number of animals")

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "pigs",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_census_pigs,
           begin = 2011,
           end = 2016,
           archive = "32100426-eng.zip|32100426.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100426-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100426_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042601",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "pigs",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_census_pigs,
           begin = 2021,
           end = 2021,
           archive = "32100372-eng.zip|32100372.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100372-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100372_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210037201",
           overwrite = TRUE)

  ### sheep  ----
  schema_statcan_survey_sheep <- schema_statcan_survey %>%
    setFilter(rows = .find(pattern = "At July 1", col = 5)) %>%
    setIDVar(name = "animal", columns = .find(pattern = "Livestock", row = 1)) %>%
    setObsVar(name = "number_heads", columns = .find(pattern = "VALUE", row = 1))

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "sheep",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_survey_sheep,
           begin = 1906,
           end = 2023,
           archive = "32100129-eng.zip|32100129.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100129-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "32100129_MetaData.csv",
           metadataLink = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210012901",
           overwrite = TRUE)

  schema_statcan_census_sheep <- schema_statcan_census %>%
    setIDVar(name = "animal", columns = .find(pattern = "Sheep and lambs", row = 1)) %>%
    setObsVar(name = "number_heads", columns = .find(pattern = "VALUE", row = 1),
              key = .find(pattern = "Unit of measure", row = 1), value = "Number of animals")

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "sheep",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_census_sheep,
           begin = 2011,
           end = 2016,
           archive = "32100425-eng.zip|32100425.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100425-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100425_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042501",
           overwrite = TRUE)

  schema_statcan_census_sheep2 <- schema_statcan_census %>%
    setIDVar(name = "animal", columns = .find(pattern = "Sheep", row = 1)) %>%
    setObsVar(name = "number_heads", columns = .find(pattern = "VALUE", row = 1),
              key = .find(pattern = "Unit of measure", row = 1), value = "Number of animals")

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "sheep",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_census_sheep2,
           begin = 2021,
           end = 2021,
           archive = "32100371-eng.zip|32100371.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100371-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100371_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210037101",
           overwrite = TRUE)

  ### poultry ----
  schema_statcan_survey_poultry <- schema_statcan_survey %>%
    setIDVar(name = "animal", columns = .find(pattern = "Commodity", row = 1)) %>%
    setObsVar(name = "number_heads", columns = .find(pattern = "VALUE", row = 1))

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "poultry",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_survey_poultry,
           begin = 1970,
           end = 2023,
           archive = "32100120-eng.zip|32100120.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100120-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "32100120_MetaData.csv",
           metadataLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210012001",
           overwrite = TRUE)

  schema_statcan_census_poultry <- schema_statcan_census %>%
    setIDVar(name = "animal", columns = .find(pattern = "Poultry inventory", row = 1)) %>%
    setObsVar(name = "number_heads", columns = .find(pattern = "VALUE", row = 1),
              key = .find(pattern = "Unit of measure", row = 1), value = "Number of birds")

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "poultry",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_census_poultry,
           begin = 2011,
           end = 2016,
           archive = "32100428-eng.zip|32100428.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100428-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100428_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042801",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "poultry",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_census_poultry,
           begin = 2021,
           end = 2021,
           archive = "32100374-eng.zip|32100374.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100374-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100374_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210037401",
           overwrite = TRUE)

  ### bees ----
  schema_statcan_survey_bees <- schema_statcan_survey %>%
    setIDVar(name = "animal", value = "bees") %>%
    setObsVar(name = "colonies", columns = .find(pattern = "VALUE", row = 1),
              key = .find(pattern = "Estimates", row = 1), value = "Colonies")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "bees",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_survey_bees,
           begin = 1924,
           end = 2022,
           archive = "32100353-eng.zip|32100353.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100353-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "32100353_MetaData.csv",
           metadataLink = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210035301",
           overwrite = TRUE)

  schema_statcan_census_bees <- schema_statcan_census %>%
    setIDVar(name = "animal", columns = .find(pattern = "Bees", row = 1)) %>%
    setObsVar(name = "colonies", columns = .find(pattern = "VALUE", row = 1),
              key = .find(pattern = "Unit of measure", row = 1), value = "Number")

  regTable(al1 = !!thisNation, fix 96_preprocess_statcan.R
           label = "al4",
           subset = "bees",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_census_bees,
           begin = 2011,
           end = 2016,
           archive = "32100432-eng.zip|32100432.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100432-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100432_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210043201",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "bees",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_census_bees,
           begin = 2021,
           end = 2021,
           archive = "32100378-eng.zip|32100378.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100378-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100378_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210037801",
           overwrite = TRUE)

  ### mink, fox ----
  schema_statcan_survey_mink <- schema_statcan_survey %>%
    setIDVar(name = "animal", columns = .find(pattern = "Type of animal", row = 1)) %>%
    setObsVar(name = "number_heads", columns = .find(pattern = "VALUE", row = 1),
              key = .find(pattern = "Supply and disposition", row = 1), value = "On farms at December 31")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "minkFox",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_statcan_survey_mink,
           begin = 1970,
           end = 2020,
           archive = "32100116-eng.zip|32100116.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100116-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100116_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210011601",
           overwrite = TRUE)

  normTable(pattern = ds[1],
            ontoMatch = "animal",
            beep = 10)
}

if(build_landuse){
  ## landuse ----

  schema_statcan_landuse <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "use", columns = 4) %>%
    setObsVar(name = "area", columns = 12)

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "censusLanduse",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 2011,
           end = 2016,
           archive = "32100406-eng.zip|32100406.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100406-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100406_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210040601",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "censusLanduse",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 2021,
           end = 2021,
           archive = "32100249-eng.zip|32100249.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100249-eng.zip",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100249_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210024901",
           overwrite = TRUE)

  ### land under glass ----
  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "greenhouseSpecialised",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 2007,
           end = 2022,
           archive = "32100019-eng.zip|32100019.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100019-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100019_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210001901",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "greenhouseTotal",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_default,
           begin = 2007,
           end = 2022,
           archive = "32100018-eng.zip|32100018.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100018-eng.zip",
           updateFrequency = "annual",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "32100018_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210001801",
           overwrite = TRUE)

  normTable(pattern = ds[1],
            ontoMatch = "use",
            beep = 10)
}


#### test schemas
#
# myRoot <- paste0(census_dir, "/tables/stage2/")
# myFile <- "Canada_al4_sheep_2021_2021_statcan.csv"
# schema <- schema_statcan_census_cattle
#
# input <- read_csv(file = paste0(myRoot, myFile),
#                   col_names = FALSE,
#                   col_types = cols(.default = "c"))
#
# validateSchema(schema = schema, input = input)
#
# output <- reorganise(input = input, schema = schema)

#### delete this section after finalising script

