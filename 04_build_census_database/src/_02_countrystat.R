# script arguments ----
#
thisNation <- "global"

ds <- c("countryStat")


# 1. register dataseries ----
#
regDataseries(name = ds[1],
              description = "CountrySTAT - Food and Agriculture Data Network",
              homepage = "http://www.fao.org/in-action/countrystat/background/en/",
              licence_link = "Creative Commons Attribution License (cc-by)",
              licence_path = "https://creativecommons.org/licenses/by/4.0/",
              update = TRUE)


# 2. register geometries ----
#


# 3. register census tables ----
#
if(build_crops){
  ## crops ----

  ### Afghanistan ----
  schema_afg_00 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_afg_01 <- schema_afg_00 %>%
    setObsVar(name = "planted", unit = "ha", columns = 6)

  regTable(nation = "afg",
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2011,
           end = 2012,
           schema = schema_afg_01,
           archive = "002SPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AFG&ta=002SPD016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AFG&ta=002SPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "afg",
           subset = "plantedFruit",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2011,
           end = 2012,
           schema = schema_afg_01,
           archive = "002YPD018.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AFG&ta=002YPD018&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AFG&ta=002YPD018&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_afg_02 <- schema_afg_00 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "afg",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2011,
           end = 2012,
           schema = schema_afg_02,
           archive = "002SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AFG&ta=002SPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AFG&ta=002SPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "afg",
           subset = "prodFruit",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2011,
           end = 2012,
           schema = schema_afg_02,
           archive = "002YPD012.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AFG&ta=002YPD012&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AFG&ta=002YPD012&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_afg_03 <- schema_afg_00 %>%
    setIDVar(name = "commodities", value = "cotton") %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "afg",
           subset = "plantCotton",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2007,
           end = 2012,
           schema = schema_afg_03,
           archive = "002YPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AFG&ta=002YPD016&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AFG&ta=002YPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_afg_04 <- schema_afg_00 %>%
    setIDVar(name = "commodities", value = "cotton") %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "afg",
           subset = "prodCotton",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2007,
           end = 2012,
           schema = schema_afg_04,
           archive = "002YPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AFG&ta=002YPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AFG&ta=002YPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_afg_05 <-
    setIDVar(name = "al2", columns = 4) %>%
    setIDVar(name = "year", value = "2012") %>%
    setIDVar(name = "commodities", value = "wheat") %>%
    setIDVar(name = "irrigation", columns = 2) %>%
    setObsVar(name = "planted", unit = "ha", columns = 5)

  regTable(nation = "afg",
           subset = "plantedWheat",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2012,
           end = 2012,
           schema = schema_afg_05,
           archive = "002YAG006.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AFG&ta=002YAG006&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AFG&ta=002YAG006&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_afg_06 <- schema_afg_05 %>%
    setObsVar(name = "production", unit = "t", columns = 5)

  regTable(nation = "afg",
           subset = "productionWheat",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2012,
           end = 2012,
           schema = schema_afg_06,
           archive = "002YAG007.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AFG&ta=002YAG007&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AFG&ta=002YAG007&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_afg_07 <- setCluster(id = "al1", left = 1, top = 6) %>%
    setIDVar(name = "al1", value = "Afganistan") %>%
    setIDVar(name = "al2", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 7) %>%
    setObsVar(name = "planted", unit = "ha", columns = 8,
              key = 3, value = "Area sown") %>%
    setObsVar(name = "production", unit = "t", columns = 8,
              key = 3, value = "Production quantity")

  regTable(nation = "afg",
           level = 2,
           subset = "plantedProduction",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_afg_07,
           begin = 2011,
           end = 2017,
           archive = "D3S_10114595064952080697794873676816346291.xlsx",
           archiveLink = "http://afghanistan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://afghanistan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_afg_08 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setFilter(rows = .find("^(01).*", col = 4)) %>%
    setIDVar(name = "al1", value = "Afghanistan") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6,
              key = 9, value = "Ha") %>%
    setObsVar(name = "production", unit = "t", columns = 6,
              key = 9, value = "ton")

  regTable(nation = "afg",
           level = 1,
           subset = "harvestedProduction",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_afg_08,
           begin = 1996,
           end = 2017,
           archive = "D3S_65467169898754035496670157166329888248.xlsx",
           archiveLink = "http://afghanistan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://afghanistan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Angola ----
  schema_ago_00 <-
    setIDVar(name = "al2", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "methdod", value = "")

  schema_ago_01 <- schema_ago_00 %>%
    setIDVar(name = "crop", columns = 3) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "ago",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2001,
           end = 2014,
           schema = schema_ago_01,
           archive = "007SPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD015&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_ago_02 <- schema_ago_00 %>%
    setIDVar(name = "crop", columns = 3) %>%
    setObsVar(name = "planted", unit = "ha", columns = 6)

  regTable(nation = "ago",
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2001,
           end = 2014,
           schema = schema_ago_02,
           archive = "007SPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_ago_03 <- schema_ago_00 %>%
    setIDVar(name = "crop", columns = 3) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "ago",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2001,
           end = 2014,
           schema = schema_ago_03,
           archive = "007SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "ago",
           subset = "prodAnimalFeed",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2001,
           end = 2009,
           schema = schema_ago_03,
           archive = "007SPD025.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD025&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD025&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_ago_05 <- schema_ago_00 %>%
    setIDVar(name = "crop", columns = 3) %>%
    setObsVar(name = "production seeds", unit = "t", columns = 6)

  regTable(nation = "ago",
           subset = "prodSeeds",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2001,
           end = 2012,
           schema = schema_ago_05,
           archive = "007SPD020.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD020&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD020&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_ago_06 <- setCluster (id = "al1", left = 1, top = 6) %>%
    setIDVar(name = "al1", value = "Angola") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", columns = 5)

  schema_ago_07 <- schema_ago_06 %>%
    setObsVar(name = "planted", unit = "ha", columns = 6,
              key = 3, value = "Area sown")%>%
    setObsVar(name = "harvested", unit = "ha", columns = 6,
              key = 3, value = "Area Harvested")

  regTable(nation = "ago",
           level = 1,
           subset = "plantedHarvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ago_07,
           begin = 2002,
           end = 2015,
           archive = "D3S_74775277060499247506914652101975304319.xlsx",
           archiveLink = "http://angola.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_ago_08 <- schema_ago_06 %>%
    setFilter(rows = .find("^(01).*", col = 4)) %>%
    setObsVar(name = "production", unit = "t", columns = 6,
              key = 3, value = "Production quantity") %>%
    setObsVar(name = "production seeds", unit = "t", columns = 6,
              key = 3, value = "Seeds quantity")

  regTable(nation = "ago",
           level = 1,
           subset = "prodAndSeeds",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ago_08,
           begin = 2001,
           end = 2015,
           archive = "D3S_52070384980890289555543361154639173281.xlsx",
           archiveLink = "http://angola.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://angola.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Azerbaijan ----
  schema_aze_00 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Azerbajan") %>%
    setIDVar(name = "al3", columns = 7) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_aze_01 <- schema_aze_00 %>%
    setObsVar(name = "production", unit = "t", columns = 8)

  regTable(nation = "aze",
           level = 3,
           subset = "prodSunflowerSeed",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_10248420883178907369094868757589902490.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodVeggies",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_12224806142493793487954769146082203164.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodCotton",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_12698114879809960278957735947777498063.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodTobacco",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_12712524468523666527987381149841041490.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodOnion",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_18696984451109188538116687464868644942.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodWheat",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_22941363045489904594643126700926274282.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodCabbage",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_26860192787217942614854288655382658468.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodPeas",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_27191148553752583015354820266216034917.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodCarrot",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_28500389987510043008366463664264139833.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodPotato",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_37923183925043064677976978511481671880.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodCucumber",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_39221751057568690085293409431550089548.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodBeetroot",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_43110830973738492998989145154428861288.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodPumpkin",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_4314130552901646347333598085225287184.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodMillet",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2004,
           end = 2016,
           archive = "D3S_49607641036324409295386400847249072730.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodPulses",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_53247988949080298237596089558321806630.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodEggplant",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2008,
           end = 2016,
           archive = "D3S_53776474889446179286731807392107015745.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodRice",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_57167362774735075266532153350575451399.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodRye",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_58387788752824735326991062796831528529.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodOats",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_7207097427571993158210009864158551940.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodMaize",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_77634731152829802144924840676869982034.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodSugarbeet",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_85455494975936453375769930645199694419.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodBarley",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_86199146512465720088148109327709648595.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodTomato",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_88457043471293305938318143124408035177.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "prodGarlic",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_01,
           begin = 2000,
           end = 2016,
           archive = "D3S_91005722802266241178689750603338638411.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_aze_02 <- schema_aze_00 %>%
    setObsVar(name = "planted", unit = "ha", columns = 8)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedPeas",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_11251288191872334188395168702836280323.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedPulses",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_11481650741499473328123731570827544607.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedCranberry",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_15836597983396038649002116622229237402.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedChestnut",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_17249789001066540587842053505306349086.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedAlmond",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_19090628764424799329039701227859774537.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedCabbage",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_1980874252862947086428160763718091942.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedSunflower",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_20068911980326618759082407249536874508.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedTobacco",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_20174090984486537338865825323082048009.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedPear",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_20484314042018213344882270259798266071.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedMelon",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_24451017326551570295354682309690402650.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedPlums",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_25658779859453702286446487547346253318.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedPersimmon",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_2767643349948990524671578215161271121.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedOtherCereals",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2015,
           archive = "D3S_28225538092995219827067708044064236560.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedCarrots",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_34036361506315788347660550093300646626.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedTea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_34477805994772201056926785157490358416.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedTomato",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_35162040381448981298511558801410330554.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedApple",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_35925389160525804987638672523384099427.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedRye",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_41278766255323705296047218802409441043.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedCotton",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_41335411833921680679085820964609817831.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedOnion",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_42419427370253223857994733351043803710.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedOats",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_42645073448809448008434322428338629438.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedOrange",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_44424136285576720066779280065913948692.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedHazlenut",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_46922039494707950946932832306137298634.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedGarlic",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_49057721807263018125003724953502539695.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedFig",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_50723279702453328228621302300673107310.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedRice",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_54510311727665164858046625998940748835.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedPotato",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_56328919626365837397016312284828084333.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedPistachio",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_64839138249866438628535014024258155694.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedVeggies",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_66624542208974998526879669610952542602.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedMaize",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_68355556545324825045935780162875279561.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedWheat",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_70110611981449468836748406173719601012.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedOlives",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_71663422339537783538434735183481323299.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedBeetroot",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_7209356795022710436559693914823223209.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedSugarbeet",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_78491283161697002128593142391685990889.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedWatermelon",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2008,
           end = 2016,
           archive = "D3S_78630367135245090958687243974679862000.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedMillet",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_78839631509758759408310464002140103356.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "plantedLemon",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_02,
           begin = 2000,
           end = 2016,
           archive = "D3S_85880941302236262157099134065092787115.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_aze_03 <- schema_aze_00 %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = 8)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldMaize",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_14553740422579974115586357587658547365.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldOrange",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_16337973804574490268469748536058490340.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldWalnut",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_18298888513207843735184166840215886970.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldPomegranate",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_19550498279594591114890166053886872994.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldSourCherry",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_20003588527212008527913820248186418037.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldBerries",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_20914157186384999036186896353840809174.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldKiwi",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_23749539544851875695596441793782518274.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldHazlenut",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_29212837727166983157538293437501597159.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldVeggies",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_29432360598627111558153380906331866861.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldCucumber",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_33541880265197023025286239695492126647.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldTomato",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_33867465023920358746798271346907992829.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldCabbage",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_35106113088646196468841958832842627311.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldPlum",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_36462178486907241997164729854641560872.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldSorghum",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_3736397897668189847653857442188992162.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldLemon",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_43701891658376602637029087119345569066.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldApricot",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_50084937707094189577744973998851194315.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldFeykhoa",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_51212001385897845267278060996321412589.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldBarley",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_51484534919123903144764409561114873457.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldCotton",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_56353324623748322907022625770421565388.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldTea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_56353328775822873397232265484439351322.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldCherry",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_57134588269406906147814226225811468433.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldCranberry",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_58017529942974335645260293981726027588.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldRice",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_5822581790587148017201551671322359510.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldPulses",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_58973617627482196018163697996575253439.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldSunflower",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_6335062253766116586827797810601100425.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldChestnut",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_63647340725904545386937876532737046468.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldSugarbeet",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_69376293297231140668412060704118739502.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldPotato",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_7128661484891833109214903468154685004.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldTangerine",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_71388973442071433806128218996745778707.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldOats",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_72275119694950758964713405490590314413.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldWheat",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_79374288486370041485814027019609401968.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldRye",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_8003633932175750624791186777037709943.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldGrapes",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_80446523263129518897531097181929886698.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldPistachio",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_8093658423158853866611531048940648429.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldTobacco",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_82176310046552406837603445834788956674.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldPersimmon",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_84684966358468985975155572388946045450.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldMillet",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_86804386995793242965411624320201151263.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "aze",
           level = 3,
           subset = "yieldOlive",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_aze_03,
           begin = 2000,
           end = 2016,
           archive = "D3S_89856388170329157756371574833496324975.xlsx",
           archiveLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://azerbaijan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Benin ----
  schema_ben_00 <-
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_ben_01 <- schema_ben_00 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "ben",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1995,
           end = 2012,
           schema = schema_ben_01,
           archive = "053SPD110.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BEN&ta=053SPD110&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BEN&ta=053SPD110&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_ben_03 <- setCluster (id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Benin") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_ben_04 <- schema_ben_03 %>%
    setFilter(rows = .find("^(01).*", col = 4)) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "ben",
           level = 1,
           subset = "productionCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ben_04,
           begin = 1995,
           end = 2015,
           archive = "D3S_41740911309657383405693317877964610672.xlsx",
           archiveLink = "http://benin.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://benin.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Bhutan ----
  schema_btn_00 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_btn_01 <- schema_btn_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "btn",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2000,
           end = 2012,
           schema = schema_btn_01,
           archive = "018SPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD015&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_btn_02 <- schema_btn_00 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "btn",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2000,
           end = 2012,
           schema = schema_btn_02,
           archive = "018SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD010&tr=-2",
           updateFrequency = "daily",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_btn_04 <-
    setIDVar(name = "al1", value = "Bhutan") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3) %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "btn",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_btn_04,
           begin = 2005,
           end = 2013,
           archive = "018CPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BTN&ta=018CPD016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BTN&ta=018CPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Burkina Faso ----
  schema_bfa_00 <-
    setIDVar(name = "al2", columns = 5) %>%
    setIDVar(name = "year", columns = 3) %>%
    setIDVar(name = "commodities", columns = 2)

  schema_bfa_01 <- schema_bfa_00 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "bfa",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1984,
           end = 2011,
           schema = schema_bfa_01,
           archive = "233SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233SPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233SPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bfa_02 <-
    setIDVar(name = "al3", columns = 5) %>%
    setIDVar(name = "year", columns = 3) %>%
    setIDVar(name = "commodities", columns = 2)

  schema_bfa_03 <- schema_bfa_02 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "bfa",
           subset = "prodCereals",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1993,
           end = 2012,
           schema = schema_bfa_03,
           archive = "233EPA01.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BFA&tr=21",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "bfa",
           subset = "prodOther",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1993,
           end = 2012,
           schema = schema_bfa_03,
           archive = "233EPA02.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA02&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA02&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "bfa",
           subset = "prodCash",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1993,
           end = 2012,
           schema = schema_bfa_03,
           archive = "233EPA03.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA03&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA03&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "bfa",
           subset = "prodVeggies",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1993,
           end = 2012,
           schema = schema_bfa_03,
           archive = "233EPA04.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA04&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA04&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)


  schema_bfa_04 <-
    setIDVar(name = "al3", columns = 4) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 6) %>%
    setObsVar(name = "production", unit = "t", columns = 7)

  regTable(nation = "bfa",
           subset = "prodTreeFruit",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1993,
           end = 2012,
           schema = schema_bfa_04,
           archive = "233EPA005.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BFA&tr=21",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bfa_05 <- schema_bfa_00 %>%
    setObsVar(name = "planted", unit = "ha", columns = 6)

  regTable(nation = "bfa",
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1984,
           end = 2011,
           schema = schema_bfa_05,
           archive = "233SPD16.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233SPD16&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233SPD16&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bfa_06 <-
    setIDVar(name = "al3",columns = 4) %>%
    setIDVar(name = "year",columns = 5) %>%
    setIDVar(name = "commodities", columns = 2) %>%
    setObsVar(name = "planted", unit = "ha", columns = 6)

  regTable(nation = "bfa",
           subset = "plantedCereals",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1993,
           end = 2012,
           schema = schema_bfa_06,
           archive = "233EPA06.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA06&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA06&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "bfa",
           subset = "plantedOther",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1993,
           end = 2012,
           schema = schema_bfa_06,
           archive = "233EPA07.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA07&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA07&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "bfa",
           subset = "plantedCash",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1993,
           end = 2012,
           schema = schema_bfa_06,
           archive = "233EPA08.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA08&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA08&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "bfa",
           subset = "plantedVeggies",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1993,
           end = 2012,
           schema = schema_bfa_06,
           archive = "233EPA09.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA09&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA09&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  # the unit is not specified in the metadata. I assume kg/ha, because for example, the values go up to 35 000 for potatoes.
  schema_bfa_07 <- schema_bfa_02 %>%
    setObsVar(name = "yield", unit = "kg/ha", columns = 6)

  regTable(nation = "bfa",
           subset = "yieldother",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1993,
           end = 2012,
           schema = schema_bfa_07,
           archive = "233EPA12.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA12&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA12&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "bfa",
           subset = "yieldRoot",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1993,
           end = 2012,
           schema = schema_bfa_07,
           archive = "233EPA13.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA13&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA13&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "bfa",
           subset = "yieldCash",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1993,
           end = 2012,
           schema = schema_bfa_07,
           archive = "233EPA14.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA14&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA14&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  # following table does not have any values filled in for the ObsVars
  regTable(nation = "bfa",
           subset = "yieldFruit",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1993,
           end = 2012,
           schema = schema_bfa_07,
           archive = "233EPA15.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA15&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA15&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bfa_08 <- setCluster (id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Burkina Faso") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_bfa_09 <- schema_bfa_08 %>%
    setFilter(rows = .find("^(01).*", col = 4)) %>%
    setObsVar(name = "production", unit = "t", columns = 6,
              key = 3, value = "Production quantity") %>%
    setObsVar(name = "production seeds", unit = "t", columns = 6,
              key = 3, value = "Seeds quantity")

  regTable(nation = "bfa",
           level = 1,
           subset = "prodAndSeeds",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bfa_09,
           begin = 1984,
           end = 2013,
           archive = "D3S_46481989252513598874824440938653879317.xlsx",
           archiveLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bfa_10 <- schema_bfa_08 %>%
    setFilter(rows = .find("^(01).*", col = 4)) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "bfa",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bfa_10,
           begin = 2014,
           end = 2016,
           archive = "D3S_37934833331568832037553091478602125982.xlsx",
           archiveLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bfa_11 <- schema_bfa_08 %>%
    setObsVar(name = "planted", unit = "ha", columns = 6)

  regTable(nation = "bfa",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bfa_11,
           begin = 1984,
           end = 2013,
           archive = "D3S_62980309661879018415558450627323164577.xlsx",
           archiveLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Burundi ----
  #following table has been manually edditied: "." have been removed from values
  #and when ever needed "0" has been added to point out the number is thousand,
  #not hundred. # In the original table when a number was recorder like "2.08" it
  #means it is 2080, according to comparison with the rest of the data for that
  #specific commodity.
  schema_bdi_01 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "bdi",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2000,
           end = 2014,
           schema = schema_bdi_01,
           archive = "029SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029SPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029SPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bdi_02 <-
    setIDVar(name = "al1", value = "Burundi") %>%
    setIDVar(name = "year", columns = 3)

  schema_bdi_03 <- schema_bdi_02 %>%
    setFilter(rows = .find("Canne..", col = 2)) %>%
    setIDVar(name = "commodities", columns = 2) %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "prodSugar",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_03,
           begin = 2000,
           end = 2011,
           archive = "029ANCICAN001.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCICAN001&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCICAN001&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bdi_04 <- schema_bdi_02 %>%
    setIDVar(name = "commodities", value = "palm oil") %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "prodPalmOil",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_04,
           begin = 2000,
           end = 2011,
           archive = "029ANCIPA001.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCIPA001&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCIPA001&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bdi_05 <- schema_bdi_02 %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", value = "palm oil tree") %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "plantPalmOil",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_05,
           begin = 2000,
           end = 2011,
           archive = "029ANCIPA002.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCIPA002&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCIPA002&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bdi_06 <- schema_bdi_02 %>%
    setIDVar(name = "commodities", value = "green tea") %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "prodGreenTea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_06,
           begin = 2000,
           end = 2011,
           archive = "029ANCITH001.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH001&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH001&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bdi_07 <- schema_bdi_02 %>%
    setIDVar(name = "commodities", value = "dry tea") %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "prodDryTea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_07,
           begin = 2000,
           end = 2011,
           archive = "029ANCITH003.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH003&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH003&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bdi_08 <- schema_bdi_02 %>%
    setFilter(rows = .find("totale..", col = 2)) %>%
    setIDVar(name = "commodities", value = "tea") %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "plantTeaIndustrialBlocks",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_08,
           begin = 2000,
           end = 2011,
           archive = "029ANCITH006.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH006&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH006&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bdi_09 <- schema_bdi_02 %>%
    setFilter(rows = .find("Total", col = 2)) %>%
    setIDVar(name = "commodities", value = "tea") %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "plantTea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_09,
           begin = 2000,
           end = 2011,
           archive = "029ANCITH007.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH007&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH007&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bdi_10 <- schema_bdi_02 %>%
    setFilter(rows = .find("Total", col = 2)) %>%
    setIDVar(name = "commodities", value = "green leaf tea") %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "prodGreenLeafTea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_10,
           begin = 2000,
           end = 2011,
           archive = "029ANCITH008.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH008&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH008&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "bdi",
           level = 1,
           subset = "prodTeaBlocks",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_10,
           begin = 2000,
           end = 2011,
           archive = "029ANCITH009.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH009&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANCITH009&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bdi_12 <-
    setIDVar(name = "al1", value = "Burundi") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_bdi_13 <- schema_bdi_12 %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_13,
           begin = 2000,
           end = 2015,
           archive = "029CPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "bdi",
           level = 1,
           subset = "prodSugarCotton",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_13,
           begin = 2000,
           end = 2015,
           archive = "029CPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD015&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bdi_14 <- schema_bdi_12 %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_14,
           begin = 2000,
           end = 2015,
           archive = "029CPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bdi_16 <- schema_bdi_14 %>%
    setFilter(rows = .find("Total", col = 3)) %>%
    setIDVar(name = "commodities", value = "tea")

  regTable(nation = "bdi",
           level = 1,
           subset = "plantTea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_16,
           begin = 2000,
           end = 2015,
           archive = "029ISP002.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ISP002&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ISP002&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bdi_17 <- schema_bdi_16 %>%
    setIDVar(name = "commodities", value = "cotton")

  regTable(nation = "bdi",
           level = 1,
           subset = "plantCotton",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_17,
           begin = 2000,
           end = 2015,
           archive = "029ISP001.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ISP001&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ISP001&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Cameroon ----
  schema_cmr_00 <-
    setIDVar(name = "al1", value = "Cameroon") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_cmr_02 <- schema_cmr_00 %>%
    setFilter(rows = .find("^(01.*)", col = 4)) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "cmr",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_cmr_02,
           begin = 1998, # values for crops only appear from 1998 till 2013. From 1972 there is only values for meat production
           end = 2013,
           archive = "D3S_33201134027644764608945955567209261075.xlsx",
           archiveLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_cmr_03 <- schema_cmr_00 %>%
    setCluster (id = "al1", left = 1, top = 5) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "cmr",
           level = 1,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_cmr_03,
           begin = 1998,
           end = 2011,
           archive = "D3S_29933140404043573946251569470594162607.xlsx",
           archiveLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Côte D'ivoire ----
  schema_civ_00 <-
    setIDVar(name = "al1", value = "Côte D'ivoire") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_civ_01 <- schema_civ_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 4)

  regTable(nation = "civ",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 1,
           begin = 1990,
           end = 2011,
           schema = schema_civ_01,
           archive = "107CPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=CIV&tr=21",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_civ_02 <- schema_civ_00 %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "civ",
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 1,
           begin = 1990,
           end = 2011,
           schema = schema_civ_02,
           archive = "107CPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=CIV&tr=21",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_civ_03 <- schema_civ_00 %>%
    setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "civ",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 1,
           begin = 1990,
           end = 2015,
           schema = schema_civ_03,
           archive = "D3S_48500900596605739428635404918425882889.xlsx",
           archiveLink = "http://cote-divoire.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://cote-divoire.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_civ_05 <-
    setIDVar(name = "al1", value = "Côte D'ivoire") %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 4) %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = 5)

  regTable(nation = "civ",
           level = 1,
           subset = "yield",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_civ_05,
           begin = 2006,
           end = 2006,
           archive = "107AAN063.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN063&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN063&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "civ",
           level = 1,
           subset = "yield",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_civ_05,
           begin = 2005,
           end = 2005,
           archive = "107AAN053.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN053&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN053&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_civ_06 <-
    setIDVar(name = "al1", value = "Côte D'ivoire") %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 6) %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = 7)

  regTable(nation = "civ",
           level = 1,
           subset = "yield",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_civ_06,
           begin = 2007,
           end = 2007,
           archive = "107AAN073.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN073&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN073&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "civ",
           level = 1,
           subset = "yield",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_civ_06,
           begin = 2008,
           end = 2008,
           archive = "107AAN083.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN083&tr=-2h",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=CIV&ta=107AAN083&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Ethiopia ----
  schema_eth_02 <- setCluster (id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Ethiopia") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_eth_03 <- schema_eth_02 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "eth",
           level = 1,
           subset = "harvested",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_eth_03,
           begin = 2001,
           end = 2012,
           archive = "D3S_13965499136371106974771720318823722561.xlsx",
           archiveLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_eth_06 <- schema_eth_02 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "eth",
           level = 1,
           subset = "production",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_eth_06,
           begin = 2001,
           end = 2010,
           archive = "D3S_12880669803077121117116692195004375319.xlsx",
           archiveLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Gabon ----
  schema_gab_01 <- setCluster(id = "al1", left = 1, top = 4) %>%
    setIDVar(name = "al1", value = "Gabon") %>%
    setIDVar(name = "al3", columns = 7) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "production", unit = "t", columns = 10, factor = 0.001)

  regTable(nation = "gab",
           level = 3,
           subset = "prodBanana",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gab_01,
           begin = 2017,
           end = 2017,
           archive = "D3S_8457400501264228087190576087673488452.xlsx",
           archiveLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://gabon.countrystat.org/search-and-visualize-data/en",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "gab",
           level = 3,
           subset = "prodCassava",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gab_01,
           begin = 2017,
           end = 2017,
           archive = "D3S_65765297683544622395831926883574866218.xlsx",
           archiveLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gab_03 <-
    setIDVar(name = "al1", value = "Gabon") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3) %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "gab",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gab_03,
           begin = 1985,
           end = 2005,
           archive = "074CPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GAB&ta=074CPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GAB&ta=074CPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "gab",
           level = 1,
           subset = "prodCashCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gab_03,
           begin = 1985,
           end = 2005,
           archive = "089MPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GAB&ta=089MPD010&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GAB&ta=089MPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gab_04 <- schema_gab_03 %>%
    setIDVar(name = "commodities", columns = 4)

  regTable(nation = "gab",
           level = 1,
           subset = "prodVeggies",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gab_04,
           begin = 1985,
           end = 2005,
           archive = "089MPD011.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GAB&ta=089MPD011&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GAB&ta=089MPD011&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Ghana ----
  schema_gha_00 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_gha_01 <- schema_gha_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "gha",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2000,
           end = 2011,
           schema = schema_gha_01,
           archive = "081SPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GHA&ta=081SPD015&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GHA&ta=081SPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gha_02 <- schema_gha_00 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "gha",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2000,
           end = 2014,
           schema = schema_gha_02,
           archive = "081SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GHA&ta=081SPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GHA&ta=081SPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gha_03 <-
    setIDVar(name = "al1", value = "Ghana") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_gha_04 <- schema_gha_03 %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "gha",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gha_04,
           begin = 2000,
           end = 2013,
           archive = "081CPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GHA&ta=081CPD016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GHA&ta=081CPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gha_06 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Ghana") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "planted", unit = "ha", columns = 6,
              key = 3, value = "Area sown") %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6,
              key = 3, value = "Area Harvested")

  regTable(nation = "gha",
           level = 1,
           subset = "plantHarvest",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gha_06,
           begin = 2000,
           end = 2015,
           archive = "D3S_61223869755777817475090755630404562896.xlsx",
           archiveLink = "http://ghana.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://ghana.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  # The years are recoreded per agriculture season: 1947/48, 1948/49.
  schema_gha_07 <- schema_gha_00 %>%
    setIDVar(name = "commodities", value = "cocoa") %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "gha",
           subset = "prodCocoa",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1948,
           end = 2008,
           schema = schema_gha_07,
           archive = "081SPD033.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GHA&ta=081SPD033&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GHA&ta=081SPD033&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Gambia ----
  schema_gmb_00 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_gmb_01 <- schema_gmb_00 %>%
    setFilter(rows = .find("Kombo Saint Mary", col = 3), invert = TRUE) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "gmb",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1988,
           end = 2001,
           schema = schema_gmb_01,
           archive = "075SPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD015&tr=-2",
           updateFrequency = "annally",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gmb_02 <- schema_gmb_00 %>%
    setObsVar(name = "planted", unit = "ha", columns = 6)

  regTable(nation = "gmb",
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1988,
           end = 2012,
           schema = schema_gmb_02,
           archive = "075SPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gmb_03 <- schema_gmb_00 %>%
    setFilter(rows = .find("Kombo Saint Mary", col = 3), invert = TRUE) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "gmb",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1988,
           end = 2012,
           schema = schema_gmb_03,
           archive = "075SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gmb_04 <-
    setIDVar(name = "al1", value = "Gambia") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  # units are not explicitally specified. Here I assume it is kg/ha
  schema_gmb_05 <- schema_gmb_04 %>%
    setObsVar(name = "yield", unit = "kg/ha", columns = 4)

  regTable(nation = "gmb",
           subset = "yield",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 1,
           begin = 1987,
           end = 2010,
           schema = schema_gmb_05,
           archive = "075CPD011.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CPD011&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CPD011&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gmb_06 <- schema_gmb_04 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 4)

  regTable(nation = "gmb",
           level = 1,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gmb_06,
           begin = 1987,
           end = 2000,
           archive = "075CPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CPD015&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gmb_07 <- schema_gmb_04 %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "gmb",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gmb_07,
           begin = 1987,
           end = 2011,
           archive = "075CPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CPD016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gmb_09 <-
    setFilter(rows = .find("Kombo..", col = 3)) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_gmb_10 <- schema_gmb_09 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "gmb",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1988,
           end = 2012,
           schema = schema_gmb_10,
           archive = "075SPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gmb_11 <- schema_gmb_09 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "gmb",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 1988,
           end = 2012,
           schema = schema_gmb_11,
           archive = "075SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Guinea-Bissau ----
  schema_gnb_00 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_gnb_01 <- schema_gnb_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "gnb",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1988,
           end = 2011,
           schema = schema_gnb_01,
           archive = "175SPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD015&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gnb_02 <- schema_gnb_00 %>%
    setObsVar(name = "planted", unit = "ha", columns = 6)

  regTable(nation = "gnb",
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1988,
           end = 2011,
           schema = schema_gnb_02,
           archive = "175SPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD016&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gnb_03 <- schema_gnb_00 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "gnb",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1988,
           end = 2010,
           schema = schema_gnb_03,
           archive = "175SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD010&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gnb_05 <-
    setIDVar(name = "al1", value = "Guinea-Bissau") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_gnb_06 <- schema_gnb_05 %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "gnb",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gnb_06,
           begin = 1988,
           end = 2011,
           archive = "175CPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD016&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gnb_07 <- schema_gnb_05 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 4)

  regTable(nation = "gnb",
           level = 1,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gnb_07,
           begin = 1988,
           end = 2011,
           archive = "175CPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD015&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gnb_08 <- schema_gnb_05 %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "gnb",
           level = 1,
           subset = "prodAnimalFeed",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gnb_08,
           begin = 1988,
           end = 2011,
           archive = "175CPD025.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD025&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD025&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gnb_09 <- schema_gnb_05 %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "gnb",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gnb_09,
           begin = 1988,
           end = 2013,
           archive = "175CPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Haiti ----
  schema_hti_00 <-
  setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "methdod", value = "")

  schema_hti_01 <- schema_hti_00 %>%
    setIDVar(name = "crop", columns = 5) %>%
    setObsVar(name = "planted", unit = "ha", columns = 6)

  regTable(nation = "hti",
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2010,
           end = 2010,
           schema = schema_hti_01,
           archive = "093SPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=HTI&tr=-2",
           nextUpdate = "unknown",
           updateFrequency = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_hti_02 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Haiti") %>%
    setIDVar(name = "al2", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", columns = 7) %>%
    setObsVar(name = "planted", unit = "ha", columns = 8)

  regTable(nation = "hti",
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2009,
           end = 2009,
           schema = schema_hti_02,
           archive = "D3S_76193321223846437098690907333482998658.xlsx",
           archiveLink = "http://haiti.countrystat.org/search-and-visualize/fr/",
           nextUpdate = "unknown",
           updateFrequency = "unknown",
           metadataLink = "http://haiti.countrystat.org/search-and-visualize/fr/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_hti_04 <- setCluster(id = "al1", left = 1, top = 4) %>%
    setIDVar(name = "al1", value = "Haiti") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", columns = 5)

  schema_hti_05 <- schema_hti_04 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "hti",
           level = 1,
           subset = "productionRice",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_hti_05,
           begin = 1975,
           end = 1996,
           archive = "D3S_89554542458867715096793523733851553598.xlsx",
           archiveLink = "http://haiti.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://haiti.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "hti",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_hti_05,
           begin = 2013,
           end = 2013,
           archive = "D3S_87946494224330745715761960034533027374.xlsx",
           archiveLink = "http://haiti.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://haiti.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "hti",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_hti_05,
           begin = 2000,
           end = 2016,
           archive = "D3S_46783234352504305878898071105501995686.xlsx",
           archiveLink = "http://haiti.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://haiti.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Kenya ----
  schema_ken_00 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_ken_01 <- schema_ken_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "ken",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = "agCensus",
           level = 2,
           begin = 2006,
           end = 2008,
           schema = schema_ken_01,
           archive = "114SPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=KEN&ta=114SPD015&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=KEN&ta=114SPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_ken_02 <- schema_ken_00 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "ken",
           subset = "production",
           dSeries = ds[1],
           gSeries = "agCensus",
           level = 2,
           begin = 2006,
           end = 2008,
           schema = schema_ken_02,
           archive = "114SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=KEN&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=KEN&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_ken_03 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Kenya") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_ken_04 <- schema_ken_03 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6,
              key = 3, value = "Area Harvested") %>%
    setObsVar(name = "planted", unit = "ha", columns = 6,
              key = 3, value = "Area sown")

  regTable(nation = "ken",
           subset = "harvestedPlanted",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 1,
           begin = 2001,
           end = 2013,
           schema = schema_ken_04,
           archive = "D3S_62065387851102482797729027739141358167.xlsx",
           archiveLink = "http://kenya.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://kenya.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_ken_05 <- schema_ken_03 %>%
    setFilter(rows = .find("^(01.)", col = 4)) %>%
    setObsVar(name = "production", unit = "t", columns = 6,
              key = 3, value = "Production quantity") %>%
    setObsVar(name = "production seeds", unit = "t", columns = 6,
              key = 3, value = "Seeds quantity")

  regTable(nation = "ken",
           level = 1,
           subset = "prodAndProdSeeds",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ken_05,
           begin = 2001,
           end = 2013,
           archive = "D3S_25597083389488464538871539034222710277.xlsx",
           archiveLink = "http://kenya.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://kenya.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Madagascar----
  schema_mdg_01 <- setCluster(id = "al1", left = 1, top = 4) %>%
    setIDVar(name = "al1", value = "Madagascar") %>%
    setIDVar(name = "al2", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 7) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 8)

  regTable(nation = "mdg",
           level = 2,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_01,
           begin = 1964,
           end = 1986,
           archive = "D3S_64447202218806652856166856495301933616.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mdg_02 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Madagascar") %>%
    setIDVar(name = "al4", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 7) %>%
    setObsVar(name = "production", unit = "t", columns = 8,
              key = 11, value = "ton") %>%
    setObsVar(name = "planted", unit = "ha", columns = 8,
              key = 11, value = "Ha")

  regTable(nation = "mdg",
           level = 4,
           subset = "prodPlan",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_02,
           begin = 2009,
           end = 2009,
           archive = "D3S_90674278993076353238958707605935270416.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mdg_03 <- setCluster(id = "al1", left = 1, top = 4) %>%
    setIDVar(name = "al1", value = "Madagascar") %>%
    setIDVar(name = "al2", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 7) %>%
    setObsVar(name = "production", unit = "t", columns = 8)

  regTable(nation = "mdg",
           level = 2,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_03,
           begin = 1964,
           end = 1986,
           archive = "D3S_56243535853101845546695163161899719705.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mdg_04 <- setCluster(id = "al1",  left = 1, top = 4) %>%
    setIDVar(name = "al1", value = "Madagascar") %>%
    setIDVar(name = "al3", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 7) %>%
    setObsVar(name = "production", unit = "t", columns = 8)

  regTable(nation = "mdg",
           level = 3,
           subset = "produOther",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_04,
           begin = 2012,
           end = 2015,
           archive = "D3S_69161223103187681656425352443316296374.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  # table is not registered, because geometries are level 5, which is not registered too
  # schema_mdg_05 <- setCluster(id = "al1", left = 1, top = 4) %>%
  #   setIDVar(name = "al1", value = "Madagascar") %>%
  #   setIDVar(name = "al4", columns = 7) %>%
  #   setIDVar(name = "year", columns = 1) %>%
  #   setIDVar(name = "commodities", columns = 5) %>%
  #   setObsVar(name = "production", unit = "t", columns = 8)
  #
  # regTable(nation = "mdg",
  #          level = 5,
  #          subset = "produSugarcane",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_mdg_05,
  #          begin = 1974,
  #          end = 2016,
  #          archive = "D3S_69897740550557345037453757881787160018.xlsx",
  #          archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
  #          metadataPath = "unknown",
  #
  #          overwrite = TRUE)

  schema_mdg_06 <- setCluster(id = "al1", left = 1, top = 4) %>%
    setIDVar(name = "al1", value = "Madagascar") %>%
    setIDVar(name = "al4", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 7) %>%
    setObsVar(name = "production", unit = "t", columns = 8)

  regTable(nation = "mdg",
           level = 4,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_06,
           begin = 2005,
           end = 2005,
           archive = "D3S_64550167087486273416409038358197674790.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mdg_07 <- setCluster(id = "commodities", left = 1, top = 4) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "al4", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", value = "maize") %>%
    setObsVar(name = "production", unit = "t", columns = 8)

  regTable(nation = "mdg",
           level = 4,
           subset = "prodCorn",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_07,
           begin = 1993,
           end = 1999,
           archive = "D3S_2209040883653499635201010819365329327.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mdg_08 <- setCluster(id = "commodities", left = 1, top = 5) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "al4", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", value = "maize") %>%
    setObsVar(name = "planted", unit = "ha", columns = 8)

  regTable(nation = "mdg",
           level = 4,
           subset = "plantedCorn",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_08,
           begin = 1993,
           end = 1999,
           archive = "D3S_53236967799045296118166719066459221351.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mdg_09 <- setCluster(id = "al1", left = 1, top = 4) %>%
    setIDVar(name = "al1", value = "Madagascar") %>%
    setIDVar(name = "al3", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 7) %>%
    setObsVar(name = "production", unit = "t", columns = 8)

  regTable(nation = "mdg",
           level = 3,
           subset = "prodRice",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_09,
           begin = 2005,
           end = 2015,
           archive = "D3S_69093813980769613567730207623041333933.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mdg_12 <- setCluster(id = "commodities", left = 1, top = 5) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "al4", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", value = "cassava") %>%
    setObsVar(name = "production", unit = "t", columns = 8)

  regTable(nation = "mdg",
           level = 4,
           subset = "prodCassava",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_12,
           begin = 1991,
           end = 1999,
           archive = "D3S_64323403588591749304889734404410682082.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mdg_13 <- setCluster(id = "commodities", left = 1, top = 5) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "al4", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", value = "Sweet potatoes") %>%
    setObsVar(name = "production", unit = "t", columns = 8)

  regTable(nation = "mdg",
           level = 4,
           subset = "prodPotatoSweet",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_13,
           begin = 1993,
           end = 1999,
           archive = "D3S_24607441580531584646795471104708030468.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mdg_14 <- setCluster(id = "commodities", left = 1, top = 5) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "al4", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", value = "Sweet potatoes") %>%
    setObsVar(name = "planted", unit = "ha", columns = 8)

  regTable(nation = "mdg",
           level = 4,
           subset = "planPotatoSweet",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_14,
           begin = 1993,
           end = 1999,
           archive = "D3S_16987491657371657307271353806247405972.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mdg_16 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Madagascar") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 7) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 8)

  regTable(nation = "mdg",
           level = 1,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_16,
           begin = 2000,
           end = 2011,
           archive = "D3S_28097412657599123237112416345720099629.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mdg_17 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Madagascar") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 7) %>%
    setObsVar(name = "production", unit = "t", columns = 8)

  regTable(nation = "mdg",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_17,
           begin = 2000,
           end = 2015,
           archive = "D3S_31975385462921452156966460605287658352.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mdg",
           level = 1,
           subset = "productionOthers",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_17,
           begin = 2000,
           end = 2010,
           archive = "D3S_73070711206484549165884078528559759933.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Malawi ----
  schema_mwi_00 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Malawi") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_mwi_02 <- schema_mwi_00 %>%
    setFilter(rows = .find("^(01..)", col = 4)) %>%
    setObsVar(name = "production", unit = "t", columns = 6,
              key = 3, value = "Production quantity") %>%
    setObsVar(name = "production seeds", unit = "t", columns = 6,
              key = 3, value = "Seeds quantity")

  regTable(nation = "mwi",
           level = 1,
           subset = "prodAndProdSeeds",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mwi_02,
           begin = 1983,
           end = 2016,
           archive = "D3S_36347240044015309795312780492448875425.xlsx",
           archiveLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mwi_03 <- schema_mwi_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "mwi",
           level = 1,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mwi_03,
           begin = 1983,
           end = 2013,
           archive = "D3S_50384267447891200108277099862048539897.xlsx",
           archiveLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Mali ----
  #  OPIB: Office du Perimetre Irrigue de Baguineda
  #  ORM: Office Riz Morti (Morti Rice Development Authority)
  #  ODRS:Office de development Rural de Selingue ( consists of 2 regions, 4 circles, 19 communes: Sikasso and Kulikoro
  #  ORS:
  #  PAPAM: Programme d'amélioration de la productivité agricole au Mali:  Project for fostering agricultural productivity)
  #	 OHVN: Office de la Haute Vallée du Niger
   schema_mli_00 <-  setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Mali") %>%
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 7)

  schema_mli_01 <- schema_mli_00 %>%
    setObsVar(name = "planted", unit = "ha", columns = 8)

  regTable(nation = "mli",
           subset = "plantedCereal",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2012,
           end = 2016,
           schema = schema_mli_01,
           archive = "D3S_40617977594520356017565769637062649422.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_02 <- schema_mli_00 %>%
    setObsVar(name = "production", unit = "t", columns = 8)

  regTable(nation = "mli",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1984,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_83840964298373381894763270952490130824.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "productionCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2012,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_46155480739372929259066091202297882471.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodCashew",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_15455870914506460846530411990908928316.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodGroundnuts",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_61265708303007563306810304403076606657.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodCarotts",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_79692591369996402264682706674379917828.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodLemonsLimes",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_42289791046405504365558222624233121114.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodGreenGarlic",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_47686855719211968708733187603197792249.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodCabbage",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_16111974766278534758895308968406322533.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodGreenBeans",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_82569749278739173266250996088873996428.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodCucumberGherkin",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_11897821335690106226093531984323198809.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodArabicGum",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_59550558379064856768972439309521179540.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodSheanuts",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_87836766405232107327776940717210347125.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodPumpkins",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_30313777834597879148847808179696304762.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodOkra",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_24338251484113335486103171043228449385.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodOrange",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_76007066959434678268909184936938050033.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodOnion",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_441669557353372878644799636676040301.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodStringBeans",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_21419431443976210915329692958706576489.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodTangerineMadarin",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_61961433064035910756286731879193699104.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodLettuceChicory",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_15878702689808094438386491672612909336.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodMango",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_88894051347762550436596512322719330915.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodMelon",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_67880751389056520125440610521215807455.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodCarrotsTurnips",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_47096268962468810968474824537111924992.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodPotatoes",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_22199027967092778434855459781170058492.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodPapaya",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_11613482289724617137791454943632900057.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodParsley",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_20781018491305130476167964866178355147.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodSesame",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_38191067424477207985011608099504425786.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodTomato",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_3667443122217105484790065685120137249.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodGuava",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_76203404282763509305584578475077878963.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_03 <- schema_mli_00 %>%
    setIDVar(name = "commodities", columns = 2, rows = 2, split = "(?<=de).*(?=\\()") %>%
    setObsVar(name = "production", unit = "t", columns = 8)

  regTable(nation = "mli",
           level = 2,
           subset = "prodPimenta",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_03,
           begin = 2006,
           end = 2016,
           archive = "D3S_89193707286040590434750853649124439950.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           subset = "prodGreenChiliePepper",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_03,
           archive = "D3S_91465366842919317307617505102418531788.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_04 <- schema_mli_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 8)

  regTable(nation = "mli",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2001,
           end = 2016,
           schema = schema_mli_04,
           archive = "D3S_44620364085479546728995004508103425085.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)


  schema_mli_05 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Mali") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_mli_06 <- schema_mli_05 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "mli",
           level = 1,
           subset = "prodCerealODRS",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_06,
           begin = 2012,
           end = 2016,
           archive = "D3S_91256602243480103827663702405814866308.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           level = 1,
           subset = "prodFiberCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_06,
           begin = 2000,
           end = 2016,
           archive = "D3S_83736957859665475895301682256249256949.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           level = 1,
           subset = "prodCropsOPIB",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_06,
           begin = 2012,
           end = 2016,
           archive = "D3S_3542744044146716784851237483812469996.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           level = 1,
           subset = "prodVegetablesORM",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_06,
           begin = 2012,
           end = 2016,
           archive = "D3S_35992639466152724174815120072098233097.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           level = 1,
           subset = "prodCerealsOPIB",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_06,
           begin = 2015,
           end = 2015,
           archive = "D3S_4780183670111131107668548066687224124.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           level = 1,
           subset = "prodCottonSeed",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_06,
           begin = 2000,
           end = 2016,
           archive = "D3S_48940830077063832264695465657185433271.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           level = 1,
           subset = "prodORS",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_06,
           begin = 2012,
           end = 2016,
           archive = "D3S_54998206533103954436586407432924612189.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           level = 1,
           subset = "prodVegetablesODRS",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_06,
           begin = 2012,
           end = 2016,
           archive = "D3S_62164455275502433207089183715199261339.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           level = 1,
           subset = "prodVegetableORS",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_06,
           begin = 2012,
           end = 2016,
           archive = "D3S_69756632045203166806004668079295079923.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           level = 1,
           subset = "prodVegFruitsOPIB",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_06,
           begin = 2012,
           end = 2016,
           archive = "D3S_75254721445141355374714025296976146940.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           level = 1,
           subset = "prodCropsORM",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_06,
           begin = 2012,
           end = 2016,
           archive = "D3S_74699943075820797944949331775209824050.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           level = 1,
           subset = "prodPrimaryCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_06,
           begin = 1984,
           end = 2016,
           archive = "D3S_75878231531464747248327981059174033871.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           level = 1,
           subset = "prodSesBeansNutsODRS",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_06,
           begin = 2012,
           end = 2016,
           archive = "D3S_81319888677617489488866281511474120692.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           level = 1,
           subset = "prodZoneOHVN",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_06,
           begin = 2005,
           end = 2016,
           archive = "D3S_81616835647057225887690441405800291562.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           level = 1,
           subset = "prodCropsOHVN",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_06,
           begin = 2012,
           end = 2016,
           archive = "D3S_83414265023895494705289385751329572868.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_07 <- schema_mli_05 %>%
    setObsVar(name = "planted", unit = "ha", columns = 6)

  regTable(nation = "mli",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_07,
           begin = 2005,
           end = 2008,
           archive = "D3S_20364268385657330258416382997594382159.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_10 <- schema_mli_00 %>%
    setIDVar(name = "al2", columns = 5) %>%
    setObsVar(name = "production", unit = "t", columns = 8)

  regTable(nation = "mli",
           level = 2,
           subset = "prodPrimaryCultures",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_10,
           begin = 1984,
           end = 2016,
           archive = "D3S_43885916107355407346463808848780391784.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_11 <- schema_mli_05 %>%
    setObsVar(name = "yield", unit = "kg/ha", columns = 6)

  regTable(nation = "mli",
           level = 1,
           subset = "yieldGrowthBeansPAPAM",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_11,
           begin = 2015,
           end = 2016,
           archive = "D3S_5128631651339947144946338445472382590.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_12 <- schema_mli_05 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "mli",
           level = 1,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_12,
           begin = 1984,
           end = 2016,
           archive = "D3S_64868895403810291808935565066883465110.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_13 <- schema_mli_05 %>%
    setObsVar(name = "production Seeds", unit = "t", columns = 6)

  regTable(nation = "mli",
           level = 1,
           subset = "prodSeedsQuantity",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_13,
           begin = 2008,
           end = 2009,
           archive = "D3S_24947214276648459737698308719386577633.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_14 <- schema_mli_00 %>%
    setObsVar(name = "production Seeds", unit = "t", columns  = 8)

  regTable(nation = "mli",
           level = 2,
           subset = "prodSeedsQuantity",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_14,
           begin = 2008,
           end = 2008,
           archive = "D3S_72328478409652772498016003403017943325.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)


  schema_mli_15 <-
    setIDVar(name = "al2", columns = 4) %>%
    setIDVar(name = "year", columns = 2)

  schema_mli_16 <- schema_mli_15 %>%
    setIDVar(name = "commodities", columns = 6) %>%
    setObsVar(name = "planted", unit = "ha", columns = 7)

  regTable(nation = "mli",
           level = 2,
           subset = "plantCereals",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_16,
           begin = 2004,
           end = 2004,
           archive = "133MRA075.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA075&tr=947",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA075&tr=947",
           metadataPath = "unknown",

           overwrite = TRUE)


  schema_mli_17 <-
    setIDVar(name = "al1", value = "Mali") %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 4) %>%
    setObsVar(name = "planted", unit = "ha", columns = 5)

  regTable(nation = "mli",
           level = 1,
           subset = "plantLegume",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_17,
           begin = 2004,
           end = 2004,
           archive = "133MRA081.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA081&tr=947",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA081&tr=947",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mli",
           level = 1,
           subset = "plantIndustrialCulture",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_17,
           begin = 2004,
           end = 2004,
           archive = "133MRA086.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA086&tr=947",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA086&tr=947",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_18 <- schema_mli_15 %>%
    setIDVar(name = "commodities", value = "cowpea") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5)

  regTable(nation = "mli",
           level = 2,
           subset = "plantCowpea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_18,
           begin = 2004,
           end = 2004,
           archive = "133MRA084.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA084&tr=947",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA084&tr=947",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_21 <- schema_mli_19 %>%
    setIDVar(name = "commodities", value = "sorghum") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5)

  regTable(nation = "mli",
           level = 3,
           subset = "plantSorghum",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_21,
           begin = 2004,
           end = 2004,
           archive = "133MRA249.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA249&tr=947",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA249&tr=947",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_22 <- schema_mli_19 %>%
    setIDVar(name = "commodities", value = "rice") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5)

  regTable(nation = "mli",
           level = 3,
           subset = "plantRice",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_22,
           begin = 2004,
           end = 2004,
           archive = "133MRA250.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA250&tr=947",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA250&tr=947",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_23 <- schema_mli_19 %>%
    setIDVar(name = "commodities", value = "cowpea") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5)

  regTable(nation = "mli",
           level = 3,
           subset = "plantCowpea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_23,
           begin = 2004,
           end = 2004,
           archive = "133MRA251.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA251&tr=947",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA251&tr=947",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_24 <- schema_mli_19 %>%
    setIDVar(name = "commodities", value = "millet") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5)

  regTable(nation = "mli",
           level = 3,
           subset = "plantMillet",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_24,
           begin = 2004,
           end = 2004,
           archive = "133MRA252.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA252&tr=947",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA252&tr=947",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_25 <- schema_mli_19 %>%
    setIDVar(name = "commodities", value = "maize") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5)

  regTable(nation = "mli",
           level = 3,
           subset = "plantMaize",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_25,
           begin = 2004,
           end = 2004,
           archive = "133MRA253.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA253&tr=947",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA253&tr=947",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_26 <- schema_mli_19 %>%
    setIDVar(name = "commodities", value = "Groundnuts") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5)

  regTable(nation = "mli",
           level = 3,
           subset = "plantGroundNuts",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_26,
           begin = 2004,
           end = 2004,
           archive = "133MRA256.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA256&tr=947",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA256&tr=947",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Mozambique ----
  schema_moz_01 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "planted", unit = "ha", columns = 6)

  regTable(nation = "moz",
           subset = "plantedCorn",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin =1997,
           end = 2013,
           schema = schema_moz_01,
           archive = "144SPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144SPD016&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144SPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_moz_02 <-
    setIDVar(name = "al2", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "moz",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2002,
           end = 2008,
           schema = schema_moz_02,
           archive = "144SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144SPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144SPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)


  schema_moz_03 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Mozambique") %>%
    setIDVar(name = "al2", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 7) %>%
    setObsVar(name = "production", unit = "t", columns = 8)

  regTable(nation = "moz",
           subset = "prodTamarind",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2014,
           end = 2018,
           schema = schema_moz_03,
           archive = "D3S_88291338084031042717655195593699838072.xlsx",
           archiveLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_moz_05 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Mozambique") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "moz",
           level = 1,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_moz_05,
           begin = 2002,
           end = 2012,
           archive = "D3S_81484070807992882047118128674261842078.xlsx",
           archiveLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_moz_07 <-
    setIDVar(name = "al1", value = "Mozambique") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_moz_08 <- schema_moz_07 %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "moz",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_moz_08,
           begin = 2002,
           end = 2012,
           archive = "144CPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144CPD016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144CPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_moz_09 <- schema_moz_07 %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "moz",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gd[1],
           schema = schema_moz_09,
           begin = 2002,
           end = 2012,
           archive = "144CPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144CPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144CPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Namibia ----
  schema_nam_01 <-
    setIDVar(name = "al1", value = "Namibia") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 4)

  regTable(nation = "nam",
           level = 1,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_nam_01,
           begin = 2002,
           end = 2003,
           archive = "147CPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=NAM&ta=147CPD015&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=NAM&ta=147CPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Niger ----
  schema_ner_00 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "methdod", value = "")

  schema_ner_01 <- schema_ner_00 %>%
    setIDVar(name = "crop", columns = 5) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "ner",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2000,
           end = 2011,
           schema = schema_ner_01,
           archive = "158SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD010&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_ner_02 <- schema_ner_00 %>%
    setIDVar(name = "crop", columns = 5) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "ner",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2000,
           end = 2011,
           schema = schema_ner_02,
           archive = "158SPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD015&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_ner_03 <- schema_ner_00 %>%
    setIDVar(name = "crop", columns = 5) %>%
    setObsVar(name = "planted", unit = "ha", columns = 6)

  regTable(nation = "ner",
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1996,
           end = 2002,
           schema = schema_ner_03,
           archive = "158SPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD016&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Nigeria ----
  schema_nga_00 <-
    setIDVar(name = "al2", columns = 4) %>%
    setIDVar(name = "year", columns = 5) %>%
    setIDVar(name = "methdod", value = "")

  schema_nga_01 <- schema_nga_00 %>%
    setIDVar(name = "crop", columns = 2) %>%
    setObsVar(name = "planted", unit = "ha", columns = 6)

  regTable(nation = "nga",
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1995,
           end = 2012,
           schema = schema_nga_01,
           archive = "159SPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=NGA&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_nga_02 <- schema_nga_00 %>%
    setIDVar(name = "crop", columns = 2) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "nga",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1995,
           end = 2012,
           schema = schema_nga_02,
           archive = "159SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=NGA&tr=21",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)


  schema_nga_03 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Nigeria") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "methdod", value = "")

  schema_nga_04 <- schema_nga_03 %>%
    setIDVar(name = "crop", columns = 5) %>%
    setObsVar(name = "planted", unit = "ha", columns = 6,
              key = 3, value = "Area sown") %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6,
              key = 3, value = "Area Harvested")

  regTable(nation = "nga",
           level = 1,
           subset = "plantedHarvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_nga_04,
           begin = 1995,
           end = 2017,
           archive = "D3S_18068359945866645835594090130523560210.xlsx",
           archiveLink = "http://nigeria.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://nigeria.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Republic of Congo ----
  schema_cog_00 <-
    setIDVar(name = "al1", value = "Republic of Congo") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_cog_01 <- schema_cog_00 %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "cog",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_cog_01,
           begin = 2001,
           end = 2010,
           archive = "046CPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_cog_02 <- schema_cog_00 %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "cog",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_cog_02,
           begin = 1985,
           end = 1996,
           archive = "046CPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Rwanda ----
  schema_rwa_01 <-
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "rwa",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 2007,
           end = 2009,
           schema = schema_rwa_01,
           archive = "184SPD110.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=RWA&ta=184SPD110&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=RWA&ta=184SPD110&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_rwa_02 <-
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setIDVar(name = "season", columns = 7) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 8)

  regTable(nation = "rwa",
           level = 3,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_rwa_02,
           begin = 2007,
           end = 2010,
           archive = "184MIN001.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=RWA&ta=184MIN001&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=RWA&ta=184MIN001&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_rwa_03 <-
    setIDVar(name = "al1", value = "Rwanda") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_rwa_04 <- schema_rwa_03 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 4)

  regTable(nation = "rwa",
           level = 1,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_rwa_04,
           begin = 2002,
           end = 2013,
           archive = "184CPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD015&tr=-2",
           updateFrequency = "daily",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_rwa_05 <- schema_rwa_03 %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "rwa",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_rwa_05,
           begin = 2002,
           end = 2013,
           archive = "184CPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=RWA&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_rwa_06 <- schema_rwa_03 %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "rwa",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_rwa_06,
           begin = 2002,
           end = 2013,
           archive = "184CPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD016&tr=-2",
           updateFrequency = "daily",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Senegal ----
  schema_sen_02 <- setCluster(id = "year", left = 1, top = 6) %>%
    setFilter(rows = .find("Senegal", col = 3), invert = TRUE) %>%
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", value = "2017") %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "planted", unit = "ha", columns = 8,
              key = 7, value = "Production value") %>%
    setObsVar(name = "production", unit = "t", columns = 8,
              key = 7, value = "Production quantity") %>%
    setObsVar(name = "yield", unit = "Kg/ha", columns = 8,
              key = 7, value = "Yield")

  regTable(nation = "sen",
           subset = "plantedProdYield",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2017,
           end = 2017,
           schema = schema_sen_02,
           archive = "D3S_34926228041252392115081506989814244913.xlsx",
           archiveLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_sen_03 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Senegal") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_sen_04 <- schema_sen_03 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "sen",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_sen_04,
           begin = 2011,
           end = 2017,
           archive = "D3S_41060683618196319745076994969183224823.xlsx",
           archiveLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_sen_06 <- schema_sen_03 %>%
    setFilter(rows = .find("^(01).*", col = 4)) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6,
              key = 3, value = "Area Harvested") %>%
    setObsVar(name = "production", unit = "t", columns = 6,
              key = 3, value = "Production quantity")

  regTable(nation = "sen",
           level = 1,
           subset = "productionHarvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_sen_06,
           begin = 1997, #the table has data starting from 1990, but until 1997 there is only dairy and animal products.
           end = 2013,
           archive = "D3S_19046083079020706024675779238570537101.xlsx",
           archiveLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Tanzania ----
  schema_tza_00 <-
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  # It is unclear what the administrative units in the table bellow represent.
  schema_tza_01 <- schema_tza_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable( nation = "tza",
            subset = "harvested",
            dSeries = ds[1],
            gSeries = gs[1],
            level = 2,
            begin = 2008,
            end = 2012,
            schema = schema_tza_01,
            archive = "215SPD115.csv",
            archiveLink = "http://countrystat.org/home.aspx?c=TZA&ta=215SPD115&tr=-2",
            updateFrequency = "annually",
            nextUpdate = "unknown",
            metadataLink = "http://countrystat.org/home.aspx?c=TZA&ta=215SPD115&tr=-2",
            metadataPath = "unknown",

            overwrite = TRUE)

  schema_tza_02 <- schema_tza_00 %>%
    setIDVar(name = "al2", columns = 3) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "tza",
           subset = "prodCereal",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2003,
           end = 2005,
           schema = schema_tza_02,
           archive = "215SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TZA&ta=215SPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=TZA&ta=215SPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_tza_03 <- schema_tza_00 %>%
    setFilter(rows = .find("Administrative..", col = 3), invert = TRUE) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "tza",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 2003,
           end = 2005,
           schema = schema_tza_03,
           archive = "215SPD110.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TZA&ta=215SPD110&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=TZA&ta=215SPD110&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_tza_06 <-
    setIDVar(name = "al1", value = "Tanzania") %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 4) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 5)

  regTable(nation = "tza",
           level = 1,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tza_06,
           begin = 1981,
           end = 2012,
           archive = "215IPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TZA&ta=215IPD015&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=TZA&ta=215IPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Togo ----
  schema_tgo_00 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_tgo_01 <- schema_tgo_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "tgo",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2001,
           end = 2010,
           schema = schema_tgo_01,
           archive = "217SPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TGO&ta=217SPD015&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=TGO&ta=217SPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_tgo_02 <- schema_tgo_00 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "tgo",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2001,
           end = 2011,
           schema = schema_tgo_02,
           archive = "217SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TGO&ta=217SPD010&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=TGO&ta=217SPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_tgo_03 <-
    setIDVar(name = "al1", value = "Togo") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_tgo_04 <- schema_tgo_03 %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "tgo",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tgo_04,
           begin = 2001,
           end = 2014,
           archive = "217CPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TGO&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_tgo_05 <- schema_tgo_03 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 4)

  regTable(nation = "tgo",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tgo_05,
           begin = 2001,
           end = 2017,
           archive = "217CPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TGO&ta=217CPD015&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=TGO&ta=217CPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_tgo_06 <- schema_tgo_03 %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "tgo",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tgo_06,
           begin = 2001,
           end = 2017,
           archive = "217CPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TGO&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Uganda ----
  schema_uga_01 <-
    setIDVar(name = "al4", columns = 2) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "beans") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 4, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 4, value = "Production Total (Total_cod_5)")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdBeans",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_01,
           begin = 2008,
           end = 2008,
           archive = "226MCR030.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR030&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR030&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_uga_02 <-
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "cowPea") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 2, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 2, value = "Production Total")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdCowPea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_02,
           begin = 2008,
           end = 2008,
           archive = "226MCR019.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR019&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR019&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_uga_03 <-
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "maize") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 2, value = "Area (Total)") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 2, value = "Production(Total)")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdMaize",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_03,
           begin = 2008,
           end = 2008,
           archive = "226MCR011.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR011&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR011&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_uga_04 <-
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "millet") %>%
    setObsVar(name = "planted1", unit = "ha", columns = 5,
              key = 2, value = "Area01") %>%
    setObsVar(name = "planted2", unit = "ha", columns = 5,
              key = 2, value = "Area02") %>%
    setObsVar(name = "planted3", unit = "ha", columns = 5,
              key = 2, value = "Area03") %>%
    setObsVar(name = "production1", unit = "t", columns = 5,
              key = 2, value =  "Production01") %>%
    setObsVar(name = "production2", unit = "t", columns = 5,
              key = 2, value =  "Production02") %>%
    setObsVar(name = "production3", unit = "t", columns = 5,
              key = 2, value =  "Production (Second season)")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdMillet",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_04,
           begin = 2008,
           end = 2008,
           archive = "226MCR012.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR012&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR012&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_uga_05 <-
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "potatoSweet") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 2, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 2, value = "Production Total")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdPotatoSweet",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_05,
           begin = 2008,
           end = 2008,
           archive = "226MCR013.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR013&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR013&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_uga_06 <-
    setIDVar(name = "al4", columns = 2) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "potato Irish") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 4, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 4, value = "Production Total")

  regTable(nation - "uga",
           level = 4,
           subset = "plantProdPotatoIrish",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_06,
           begin = 2008,
           end = 2008,
           archive = "226MCR014.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR014&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR014&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_uga_07 <-
    setIDVar(name = "al4", columns = 2) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "cassava") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 4, value = "Area (Total)") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 4, value = "Production Total")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdCassava",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_07,
           begin = 2008,
           end = 2008,
           archive = "226MCR015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR015&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_uga_08 <-
    setIDVar(name = "al4", columns = 2) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "banana Sweet") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 4, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 4, value = "Production Total")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdBananaSweet",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_08,
           begin = 2008,
           end = 2008,
           archive = "226MCR016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_uga_09 <-
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "pigeon Pea") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 2, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 2, value = "Production Total")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdPigeonPea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_09,
           begin = 2008,
           end = 2008,
           archive = "226MCR018.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR018&tr=-2",
           updateFrequency = "annuallu",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR018&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_uga_10 <-
    setIDVar(name = "al4", columns = 2) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "peas") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 4, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 4, value = "Production Total")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdPeas",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_10,
           begin = 2008,
           end = 2008,
           archive = "226MCR017.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR017&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR017&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_uga_11 <-
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "sorghum") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 2, value = "Area") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 2, value = "Production")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdSorghum",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_11,
           begin = 2008,
           end = 2008,
           archive = "226MCR010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_uga_12 <-
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "bananaBeer") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 2, value = "Area Total") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 2, value = "Production Total")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdBananaBeer",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_12,
           begin = 2008,
           end = 2008,
           archive = "226MCR006.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR006&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR006&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_uga_13 <-
    setFilter(rows = .find("Uganda", col = 1), invert = TRUE) %>%
    setIDVar(name = "al4", columns = 2) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "rice") %>%
    setObsVar(name = "planted", unit = "ha", columns = 5,
              key = 3, value = "Total_cod_4") %>%
    setObsVar(name = "production", unit = "t", columns = 5,
              key = 3, value = "Total_cod_5")

  regTable(nation = "uga",
           level = 4,
           subset = "plantProdRice",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_13,
           begin = 2008,
           end = 2008,
           archive = "226MCR009.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR009&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226MCR009&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_uga_16 <- schema_uga_14 %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "uga",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_16,
           begin = 1980,
           end = 2014,
           archive = "226CPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Zambia ----
  schema_zmb_00 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_zmb_01 <- schema_zmb_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "zmb",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2000,
           end = 2004,
           schema = schema_zmb_01,
           archive = "251SPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD015&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD015&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_zmb_02 <- schema_zmb_00 %>%
    setObsVar(name = "planted", unit = "ha", columns = 6)

  regTable(nation = "zmb",
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2000,
           end = 2015,
           schema = schema_zmb_02,
           archive = "251SPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD016&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_zmb_03 <- schema_zmb_00 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "zmb",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2000,
           end = 2015,
           schema = schema_zmb_03,
           archive = "251SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

}

if(build_livestock){
  ## livestock ----

  ### Afghanistan ----
  schema_afg_09 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Afghanistan") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "afg",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_afg_09,
           begin = 2008,
           end = 2017,
           archive = "D3S_88891781345618619869029979355574441072.xlsx",
           archiveLink = "http://afghanistan.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://afghanistan.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Angola ----
  schema_ago_04 <- schema_ago_00 %>%
    setIDVar(name = "animal", columns = 3) %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "ago",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2005,
           end = 2013,
           schema = schema_ago_04,
           archive = "007SPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD035&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD035&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Bhutan ----
  schema_btn_03 <- schema_btn_00 %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "btn",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin=  2000,
           end = 2012,
           schema = schema_btn_03,
           archive = "018SPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD035&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD035&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Burkina Faso ----
  schema_bfa_12 <- schema_bfa_08 %>%
    setFilter(rows = .find("Live animals", col = 3)) %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "bfa",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bfa_12,
           begin = 1990,
           end = 2013,
           archive = "D3S_3280676867047913049002268615569497300.xlsx",
           archiveLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_bfa_13 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setFilter(row = .find("Live animals", col = 3)) %>%
    setIDVar(name = "al1", value = "Burkina Faso") %>%
    setIDVar(name = "al2", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 7) %>%
    setObsVar(name = "headcount", unit = "n", columns = 8)

  regTable(nation = "bfa",
           level = 2,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bfa_13,
           begin = 2003,
           end = 2009,
           archive = "D3S_91744175275246691887564531755662702755.xlsx",
           archiveLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Burundi ----
  schema_bdi_15 <- schema_bdi_12 %>%
    setObsVar(name = "headcount", unit = "n", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_15,
           begin = 2000,
           end = 2014,
           archive = "029CPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD035&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029CPD035&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Cameroon ----
  schema_cmr_01 <- schema_cmr_00 %>%
    setFilter(rows = .find("Live animals", col = 3)) %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "cmr",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_cmr_01,
           begin = 1972,
           end = 2012,
           archive = "D3S_13560733286226780367962256534287463659.xlsx",
           archiveLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://cameroon.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Côte D'ivoire ----
  schema_civ_04 <- schema_civ_00 %>%
    setObsVar(name = "headcount", unit = "n", columns = 4)

  regTable(nation = "civ",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 1,
           begin = 1990,
           end = 2013,
           schema = schema_civ_04,
           archive = "107CPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=CIV&tr=21",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Ethiopia ----
  schema_eth_04 <- schema_eth_02 %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "eth",
           level = 1,
           subset = "livestockFemale",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_eth_04,
           begin = 2001,
           end = 2012,
           archive = "D3S_31356853048140928389096807767536393185.xlsx",
           archiveLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Gabon ----
  schema_gab_02 <- setCluster(id = "al1", left = 1, top = 4) %>%
    setIDVar(name = "al1", value = "Gabon") %>%
    setIDVar(name = "al2", columns = 7) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "headcount", unit = "n", columns = 8)

  regTable(nation = "gab",
           level = 2,
           subset = "livestockSheep",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_gab_02,
           begin = 2016,
           end = 2016,
           archive = "D3S_57648567727655310905327383039455470511.xlsx",
           archiveLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "gab",
           level = 2,
           subset = "livestockCattle",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gab_02,
           begin = 2016,
           end = 2016,
           archive = "D3S_23325858178721846295138541247501227448.xlsx",
           archiveLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "gab",
           level = 2,
           subset = "livestockGoats",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gab_02,
           begin = 2016,
           end = 2016,
           archive = "D3S_69779645070170687227615176335215745700.xlsx",
           archiveLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Ghana ----
  schema_gha_05 <- schema_gha_03 %>%
    setObsVar(name = "headcount", unit = "n", columns = 4)

  regTable(nation = "gha",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gha_05,
           begin = 2000,
           end = 2014,
           archive = "081CPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GHA&ta=081CPD035&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GHA&ta=081CPD035&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Guinea-Bissau ----
  schema_gnb_04 <- schema_gnb_00 %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "gnb",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1986,
           end = 2011,
           schema = schema_gnb_04,
           archive = "175SPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD035&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD035&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_gnb_10 <- schema_gnb_05 %>%
    setObsVar(name = "headcount", unit = "n", columns = 4)

  regTable(nation = "gnb",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gnb_10,
           begin = 1986,
           end = 2011,
           archive = "175CPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD035&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD035&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Haiti ----
  schema_hti_03 <- schema_hti_00 %>%
    setIDVar(name = "animal", columns = 5) %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "hti",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2010,
           end = 2010,
           schema = schema_hti_03,
           archive = "093SPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=HTI&tr=-2",
           nextUpdate = "unknown",
           updateFrequency = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Kenya ----
  schema_ken_06 <-
    setIDVar(name = "al2", columns = 4) %>%
    setIDVar(name = "al3", columns = 6) %>%
    setIDVar(name = "year", value = "2009") %>%
    setIDVar(name = "commodities", columns = 2) %>%
    setObsVar(name = "headcount", unit = "n", columns = 7)

  regTable(nation = "ken",
           level = 3,
           subset = "livestockCattle",
           dSeries = ds[1],
           gSeries = "agCensus",
           schema = schema_ken_06,
           begin = 2009,
           end = 2009,
           archive = "114AAC020.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=KEN&ta=114AAC020&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=KEN&ta=114AAC020&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_ken_07 <-
    setIDVar(name = "al1", value = "Kenya") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_ken_08 <- schema_ken_07 %>%
    setObsVar(name = "headcount", unit = "n", columns = 4)

  regTable(nation = "ken",
           level = 1,
           subset = "livetsock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ken_08,
           begin = 2000,
           end = 2013,
           archive = "114CPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=KEN&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=KEN&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Madagascar----
  schema_mdg_10 <- setCluster(id = "al1", left = 1, top = 4) %>%
    setIDVar(name = "al1", value = "Madagascar") %>%
    setIDVar(name = "al3", columns = 7) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "headcount", unit = "n", columns = 8)

  regTable(nation = "mdg",
           level = 3,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_10,
           begin = 2001,
           end = 2011,
           archive = "D3S_32688635813502157228252815877542769026.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)


  schema_mdg_11 <- setCluster(id = "al1", left = 1, top = 4) %>%
    setIDVar(name = "al1", value = "Madagascar") %>%
    setIDVar(name = "al4", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 7) %>%
    setObsVar(name = "headcount", unit = "n", columns = 10)

  regTable(nation = "mdg",
           level = 4,
           subset = "cattle",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_11,
           begin = 2005,
           end = 2005,
           archive = "D3S_39116713278667949858222495511498067186.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  regTable(nation = "mdg",
           level = 4,
           subset = "pig",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_11,
           begin = 2005,
           end = 2005,
           archive = "D3S_91328084517343533575926590442843060311.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Malawi ----
  schema_mwi_01 <- schema_mwi_00 %>%
    setFilter(rows = .find("Live..", col = 3)) %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "mwi",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mwi_01,
           begin = 1975,
           end = 2015,
           archive = "D3S_35222218128324229028659037819008500474.xlsx",
           archiveLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Mali ----
  regTable(nation = "mli",
           subset = "prodGuineafowls",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_02,
           archive = "D3S_46015907052670327397009519187516881160.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_08 <- schema_mli_00 %>%
    setObsVar(name = "headcount", unit = "n", columns = 8)

  regTable(nation = "mli",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2006,
           end = 2016,
           schema = schema_mli_08,
           archive = "D3S_23394832598499509186526136194414131639.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_09 <- schema_mli_05 %>%
    setObsVar(name = "headcount", unit = "n",  columns = 6)

  regTable(nation = "mli",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_09,
           begin = 2006,
           end = 2016,
           archive = "D3S_43396223662231552394995631044427789774.xlsx",
           archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unkown",
           metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_mli_19 <-
    setIDVar(name = "al3", columns = 4) %>%
    setIDVar(name = "year", columns = 2)

  schema_mli_20 <- schema_mli_19 %>%
    setIDVar(name = "commodities", value = "chikens") %>%
    setObsVar(name = "headcount", unit = "n", columns = 5)

  regTable(nation = "mli",
           level = 3,
           subset = "livestockBirds",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mli_20,
           begin = 2004,
           end = 2004,
           archive = "133MRA120.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA120&tr=947",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA120&tr=947",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Mozambique ----
  schema_moz_04 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Mozambique") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "headcount", unit = "n",  columns = 6)

  regTable(nation = "moz",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_moz_04,
           begin = 2005,
           end = 2012,
           archive = "D3S_8351228261982721895422674204631154074.xlsx",
           archiveLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_moz_06 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Mozambique") %>%
    setIDVar(name = "al2", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 7) %>%
    setObsVar(name = "headcount", unit = "n", columns = 8)

  regTable(nation = "moz",
           level = 2,
           subset = "livestockCattle",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_moz_06,
           begin = 2014,
           end = 2018,
           archive = "D3S_45144279647651940626724760324953181850.xlsx",
           archiveLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Niger ----
  schema_ner_00 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "methdod", value = "")

  schema_ner_04 <- schema_ner_00 %>%
    setIDVar(name = "animal", columns = 5) %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "ner",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1970,
           end = 2010,
           schema = schema_ner_04,
           archive = "158SPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD035&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD035&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Nigeria ----
  schema_nga_05 <- schema_nga_03 %>%
    setFilter(rows = .find("Live..", col = 3)) %>%
    setIDVar(name = "animal", columns = 5) %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "nga",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_nga_05,
           begin = 2000,
           end = 2010,
           archive = "D3S_36052193455802116654692282592282918066.xlsx",
           archiveLink = "http://nigeria.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://nigeria.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Republic of Congo ----
  schema_cog_03 <- schema_cog_00 %>%
    setObsVar(name = "headcount", unit = "n", columns = 4)

  regTable(nation = "cog",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_cog_03,
           begin = 1988,
           end = 2010,
           archive = "046CPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD035&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD035&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Rwanda ----
  schema_rwa_07 <- schema_rwa_03 %>%
    setObsVar(name = "headcount", unit = "n", columns = 4)

  regTable(nation = "rwa",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_rwa_07,
           begin = 1999,
           end = 2012,
           archive = "184CPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD035&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD035&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Senegal ----
  schema_sen_01 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "sen",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1997,
           end = 2011,
           schema = schema_sen_01,
           archive = "195WIP008.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=SEN&ta=195WIP008&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=SEN&ta=195WIP008&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_sen_05 <- schema_sen_03 %>%
    setFilter(rows = .find("Live..", col = 3)) %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "sen",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_sen_05,
           begin = 1997,
           end = 2012,
           archive = "D3S_36304856734075633687706538763899072144.xlsx",
           archiveLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Tanzania ----
  schema_tza_04 <- schema_tza_00 %>%
    setIDVar(name = "al2", columns = 3) %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "tza",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2003,
           end = 2009,
           schema = schema_tza_04,
           archive = "215SPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TZA&tr=21",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Togo ----
  schema_tgo_07 <- schema_tgo_03 %>%
    setObsVar(name = "headcount", unit = "n", columns = 4)

  regTable(nation = "tgo",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tgo_07,
           begin = 2000,
           end = 2014,
           archive = "217CPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TGO&ta=217CPD035&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=TGO&ta=217CPD035&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Uganda ----
  schema_uga_14 <-
    setIDVar(name = "al1", value = "Uganda") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_uga_15 <- schema_uga_14 %>%
    setObsVar(name = "headcount", unit = "n", columns = 4)

  regTable(nation = "uga",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_15,
           begin = 2003,
           end = 2012,
           archive = "226CPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_uga_17 <-
    setIDVar(name = "al1", value = "Uganda") %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", value = "camels") %>%
    setObsVar(name = "headcount", unit = "n", columns = 3,
              key = 2, value = "UGANDA")

  regTable(nation = "uga",
           level = 1,
           subset = "livestockCamels",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_17,
           begin = 2008,
           end = 2008,
           archive = "226M08007.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226M08007&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226M08007&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_uga_18 <-
    setFilter(rows = .find("UGANDA", col = 4)) %>%
    setIDVar(name = "al1", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", columns = 2) %>%
    setObsVar(name = "beehives", unit = "n", columns = 5)

  regTable(nation = "uga",
           level = 1,
           subset = "beehives",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_uga_18,
           begin = 2008,
           end = 2008,
           archive = "226M08005.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=UGA&ta=226M08005&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=UGA&ta=226M08005&tr=-22",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Zambia ----
  schema_zmb_04 <- schema_zmb_00 %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "zmb",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2000,
           end = 2008,
           schema = schema_zmb_04,
           archive = "251SPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD035&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=ZMB&ta=251SPD035&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)
}

if(build_landuse){
  ## landuse ----

  ### Benin ----
  schema_ben_02 <- schema_ben_00 %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "ben",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 2000,
           end = 2013,
           schema = schema_ben_02,
           archive = "053SPD135.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BEN&ta=053SPD135&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BEN&ta=053SPD135&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_ben_05 <- schema_ben_03 %>%
    setFilter(rows = .find("Live..", col = 3)) %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "ben",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ben_05,
           begin = 2000,
           end = 2013,
           archive = "D3S_31065608234090692436490577176461964860.xlsx",
           archiveLink = "http://benin.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://benin.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Bhutan ----
  schema_btn_05 <-
    setIDVar(name = "al1", value = "Bhutan") %>%
    setIDVar(name = "year", value = "2010") %>%
    setIDVar(name = "commodities", columns = 3) %>%
    setObsVar(name = "area", unit = "ha", factor = 1000, columns = 4)

  regTable(nation = "btn",
           subset = "landUse",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 1,
           begin = 2010,
           end = 2010,
           schema = schema_btn_05,
           archive = "018CLI010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BTN&ta=018CLI010&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BTN&ta=018CLI010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Burundi ----
  # table has different types of forest lands, which are not distinguishable in
  # the ontology, therefore I am taking the Total areas.
  schema_bdi_11 <- schema_bdi_02 %>%
    setFilter(rows = .find("TOTAL", col = 2)) %>%
    setIDVar(name = "commodities", value = "forest land") %>%
    setObsVar(name = "area", unit = "ha", columns = 4)

  regTable(nation = "bdi",
           level = 1,
           subset = "forestArea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_bdi_11,
           begin = 2001,
           end = 2011,
           archive = "029ANSYL001.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANSYL001&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BDI&ta=029ANSYL001&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Ethiopia ----
  schema_eth_05 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Ethiopia") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3) %>%
    setObsVar(name = "area", unit = "ha", factor = 1000, columns = 6)

  regTable(nation = "eth",
           level = 1,
           subset = "landUse",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_eth_05,
           begin = 2001,
           end = 2012,
           archive = "D3S_14746020610584912317797721515709421344.xlsx",
           archiveLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://ethiopia.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Gambia ----
  schema_gmb_08 <-
    setIDVar(name = "al1", value = "Gambia") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3) %>%
    setObsVar(name = "area", unit = "ha", columns = 4, factor = 1000)

  regTable(nation = "gmb",
           level = 1,
           subset = "landuse",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gmb_08,
           begin = 1983,
           end = 2011,
           archive = "075CLI010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CLI010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CLI010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Kenya ----
  schema_ken_09 <- schema_ken_07 %>%
    setObsVar(name = "area", unit = "ha", factor = 1000, columns = 4)

  regTable(nation = "ken",
           level = 1,
           subset = "landUse",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ken_09,
           begin = 2007,
           end = 2007,
           archive = "114CLI010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=KEN&ta=114CLI010&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=KEN&ta=114CLI010&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Madagascar----
  schema_mdg_15 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setFilter(rows = .find("Madagascar", col = 3), invert = TRUE) %>%
    setIDVar(name = "al1", value = "Madagascar") %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "area", unit = "ha", columns = 6)

  regTable(nation = "mdg",
           level = 3,
           subset = "forestArea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mdg_15,
           begin = 1990,
           end = 2013,
           archive = "D3S_16053360586544061987204659261297125058.xlsx",
           archiveLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://madagascar.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",

           overwrite = TRUE)

  ### Tanzania ----
  schema_tza_05 <-
    setIDVar(name = "al1", value = "Tanzania") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3) %>%
    setObsVar(name = "area", unit = "ha", columns = 4)

  regTable(nation = "tza",
           level = 1,
           subset = "landuse",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tza_05,
           begin = 2000,
           end = 2015,
           archive = "215CLI010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TZA&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=TZA&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

  schema_tza_07 <-
    setFilter(rows = .find("Total..", col = 2), invert = TRUE) %>%
    setIDVar(name = "al2", columns = 4) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "commodities", columns = 2) %>%
    setObsVar(name = "area", unit = "ha", columns = 5)

  regTable(nation = "tza",
           level = 2,
           subset = "landuse",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tza_07,
           begin = 2008,
           end = 2008,
           archive = "215MLO004.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TZA&ta=215MLO004&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=TZA&ta=215MLO004&tr=-2",
           metadataPath = "unknown",

           overwrite = TRUE)

}


# 4. normalise geometries ----
#
# not needed


# 5. normalise census tables ----
#
## in case the output shall be examined before writing into the DB
# testing <- normTable(nation = thisNation,
#                      update = FALSE,
#                      keepOrig = TRUE)

normTable(pattern = ds[],
          ontoMatch = ,
          outType = "rds")
