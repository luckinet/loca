# ----
# geography : Global
# period    : (1947)1995 - 2018
# dataseries: FAO Data Lab (https://www.fao.org/datalab/en)
# authors   : Steffen Ehrmann
# date      : 2024-03-27
# variables :
#   - land      : -
#   - crops     : hectares_harvested, tons_produced
#   - livestock : -
#   - technology: -
#   - social    : -
# spatial   : Nation (GADM0), GADM1, GADM2
# ----

thisNation <- "global"


# 1. register dataseries ----
#
ds <- c("faoDatalab")
gs <- c("gadm36")

regDataseries(name = ds[3],
              description = "FAO Data Lab",
              homepage = "https://www.fao.org/datalab/en",
              licence_link = "unknown",
              licence_path = "not available")


# 2. register geometries ----
#


# 3. register census tables ----
#
if(build_crops){
  ## crops ----

  ### Burkina Faso ----
  schema_bfa_14 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 6) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 10,
              key = 11, value = "Hectares") %>%
    setObsVar(name = "production", unit = "t", columns = 10,
              key = 11, value = "Metric Tonnes")

  regTable(nation = "bfa",
           level = 2,
           subset = "productionHarvested",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_bfa_14,
           begin = 1995,
           end = 2018,
           archive = "Burkina Faso - Sub-National Level 1.csv",
           archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Burkina%20Faso%20-%20Sub-National%20Level%201.csv",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Burkina%20Faso.pdf",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_bfa_15 <-
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 6) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 10,
              key = 11, value = "Hectares") %>%
    setObsVar(name = "production", unit = "t", columns = 10,
              key = 11, value = "Metric Tonnes")

  regTable(nation = "bfa",
           level = 3,
           subset = "productionHarvested",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_bfa_15,
           begin = 2008,
           end = 2018,
           archive = "Burkina Faso - Sub-National Level 2.csv",
           archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Burkina%20Faso%20-%20Sub-National%20Level%202.csv",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Burkina%20Faso.pdf",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### El Salvador ----
  schema_slv_01 <-
    setIDVar(name = "al2",columns = 3 ) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 6) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 10,
              key = 11, value = "Hectares") %>%
    setObsVar(name = "production", unit = "t", columns = 10,
              key = 11, value = "Metric Tonnes")

  regTable(nation = "slv",
           level = 2,
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_slv_01,
           begin = 2010,
           end = 2017,
           archive = "El Salvador - Sub-National Level 2.csv",
           archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/El%20Salvador%20-%20Sub-National%20Level%202.csv",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20El%20Salvador.pdf",
           metadataPath = "unknown",
           overwrite = TRUE)

  # the following table does not have a proper regions, we do not have geometries for them
  # regTable(nation = "slv",
  #         level = 2,
  #         subset = "crops",
  #         dSeries = ds[1],
  #         gSeries = "",
  #         schema = schema_slv_faoDatalab_01,
  #         begin = 2010,
  #         end = 2017,
  #         archive = "El Salvador - Sub-National Level 1.csv",
  #         archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/El%20Salvador%20-%20Sub-National%20Level%201.csv",
  #         updateFrequency = "annually",
  #         nextUpdate = "unknown",
  #         metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20El%20Salvador.pdf",
  #         metadataPath = "unknown",
  #         overwrite = TRUE)

  ### Ethiopia ----
  schema_eth_01 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 6) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 10,
              key = 11, value = "Hectares") %>%
    setObsVar(name = "production", unit = "t", columns = 10,
              key = 11, value = "Metric Tonnes")

  regTable(nation = "eth",
           level = 2,
           subset = "productionHarvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_eth_01,
           begin = 2007,
           end = 2018,
           archive = "Ethiopia - Sub-National Level 1.csv",
           archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Ethiopia%20-%20Sub-National%20Level%201.csv",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Ethiopia.pdf",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Haiti ----
  schema_hti_06 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", columns = 6) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 10,
              key = 11, value = "Hectares") %>%
    setObsVar(name = "production", unit = "t", columns = 10,
              key = 11, value = "Metric Tonnes")

  regTable(nation = "hti",
           level = 2,
           subset = "productionHarvested",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_hti_06,
           begin = 2014,
           end = 2016,
           archive = "Haiti - Sub-National Level 1.csv",
           archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Haiti%20-%20Sub-National%20Level%201.csv",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Haiti.pdf",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Indonesia ----
  schema_idn_faoDatalab_01 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 6) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 10,
              key = 11, value = "Hectares") %>%
    setObsVar(name = "production", unit = "t", columns = 10,
              key = 11, value = "Metric Tonnes")

  regTable(nation = "idn",
           level = 2,
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_idn_faoDatalab_01,
           begin = 1993,
           end = 2019,
           archive = "Indonesia - Sub-National Level 1.csv",
           archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Indonesia%20-%20Sub-National%20Level%201.csv",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Indonesia.pdf",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Laos ----
  schema_lao_01 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = c(6, 5), merge = "-") %>%
    setObsVar(name = "harvested", unit = "ha", columns = 10,
              key = 11, value = "Hectares") %>%
    setObsVar(name = "production", unit = "t", columns = 10,
              key = 11, value = "Metric Tonnes")

  regTable(narion = "lao",
           level = 2,
           subset = "prodHarvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_lao_01,
           begin = 2009,
           end = 2018,
           archive = "Laos - Sub-National Level 1.csv",
           archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Laos%20-%20Sub-National%20Level%201.csvhttp://www.fao.org/datalab/website/web/sites/default/files/2020-10/Laos%20-%20Sub-National%20Level%201.csv",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Laos.pdf",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Pakistan ----
  schema_pak_01 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 6) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 10,
              key = 11, value = "Hectares") %>%
    setObsVar(name = "production", unit = "t", columns = 10,
              key = 11, value = "Metric Tonnes")

  regTable(nation = "pak",
           level = 2,
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_pak_01,
           begin = 1947,
           end = 2017,
           archive = "Pakistan - Sub-National Level 1.csv",
           archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Pakistan%20-%20Sub-National%20Level%201.csv",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Pakistan.pdf",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Senegal ----
  schema_sen_07 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 6) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 10,
              key = 11, value = "Hectares") %>%
    setObsVar(name = "production", unit = "t", columns = 10,
              key = 11, value = "Metric Tonnes")

  regTable(nation = "sen",
           level = 2,
           subset = "productionHarvested",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_sen_07,
           begin = 2009,
           end = 2019,
           archive = "Senegal - Sub-National Level 1.csv",
           archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Senegal%20-%20Sub-National%20Level%201.csv",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Senegal_0.pdf",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Trinidad and Tobago ----
  schema_tto_01 <-
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "production", unit = "t", columns = 10)

  regTable(nation = "tto",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tto_01,
           begin = 2012,
           end = 2017,
           archive = "Trinidad & Tobago - Sub-National Level 1.csv",
           archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Trinidad%20%26%20Tobago%20-%20Sub-National%20Level%201.csv",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Ethiopia.pdf",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Yemen ----
  schema_yem_faoDatalab_01 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 6) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 10,
              key = 11, value = "Hectares") %>%
    setObsVar(name = "production", unit = "t", columns = 10,
              key = 11, value = "Metric Tonnes")

  regTable(nation = "yem",
           level = 2,
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_yem_faoDatalab_01,
           begin = 2009,
           end = 2019,
           archive = "Yemen - Sub-National Level 1.csv",
           archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Yemen%20-%20Sub-National%20Level%201.csv",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Yemen.pdf",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Zimbabwe ----
  schema_zwe_01 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 7) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 10,
              key = 9, value = "Harvested Area") %>%
    setObsVar(name = "production", unit = "t", columns = 10,
              key = 9, value = "Production")

  regTable(nation = "zwe",
           level = 2,
           subset = "harvestProd",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_zwe_01,
           begin = 2012,
           end = 2015,
           archive = "Zimbabwe - Sub-National Level 1.csv",
           archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Zimbabwe%20-%20Sub-National%20Level%201.csv",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Zimbabwe.pdf",
           metadataPath = "unknown",
           overwrite = TRUE)

}

## livestock ----
if(build_livestock){

}

## landuse ----
if(build_landuse){

}


# 4. normalise geometries ----
#
# not needed


# 5. normalise census tables ----
#
normTable(pattern = ,
          ontoMatch = "",
          outType = "rds",
          beep = 10)


