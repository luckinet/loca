# script arguments ----
#
# source(paste0(mdl0301, "src/96_preprocess_abs.R"))
thisNation <- "Australia"

ds <- c("abs")
gs <- c("gadm", "asgc", "asgs")


# 1. dataseries ----
#
regDataseries(name = ds[1],
              description = "Australia Bureau of Statistics",
              homepage = "https://www.abs.gov.au/",
              version = "2023.12.04",
              licence_link = "https://creativecommons.org/licenses/by/3.0/au/")

regDataseries(name = gs[2],
              description = "Australian Standard Geographical Classification",
              homepage = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/1259.0.30.001Main+Features1July%202011?OpenDocument",
              version = "2011",
              licence_link = "https://creativecommons.org/licenses/by/3.0/au/") # older

regDataseries(name = gs[3],
              description = "Australian Statistical Geography Standard",
              homepage = "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/latest-release",
              version = "3.0.0",
              licence_link = "https://creativecommons.org/licenses/by/3.0/au/") # newer


# 2. geometries ----
#
regGeometry(al1 = !!thisNation,
            gSeries = gs[2],
            label = list(al2 = "STATE_CODE"),
            archive = "1259030001_ste11aaust_shape.zip|STE11aAust.shp",
            archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&1259030001_ste11aaust_shape.zip&1259.0.30.001&Data%20Cubes&D39E28B23F39F498CA2578CC00120E25&0&July%202011&14.07.2011&Latest",
            updateFrequency = "unknown",
            downloadDate = ymd("2019-10-10"),
            overwrite = TRUE)

regGeometry(al1 = !!thisNation,
            gSeries = gs[2],
            label = list(al2 = "STATE_CODE", al3 = "SD_NAME11"),
            archive = "1259030001_sd11aaust_shape.zip|SD11aAust.shp",
            archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&1259030001_sd11aaust_shape.zip&1259.0.30.001&Data%20Cubes&A2521D72ABA3D177CA2578CC0011FBFE&0&July%202011&14.07.2011&Latest",
            updateFrequency = "unknown",
            downloadDate = ymd("2019-10-10"),
            overwrite = TRUE)

normGeometry(pattern = gs[2],
             beep = 10)

regGeometry(al1 = !!thisNation,
            gSeries = gs[3],
            label = list(al1 = "AUS_NAME_2021"),
            archive = "ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip|ASGS_2021_Main_Structure_GDA2020.gpkg",
            archiveLink = "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip",
            updateFrequency = "quinquennial",
            downloadDate = ymd("2019-10-10"),
            overwrite = TRUE)

regGeometry(al1 = !!thisNation,
            gSeries = gs[3],
            label = list(al1 = "AUS_NAME_2021", al2 = "STATE_NAME_2021"),
            archive = "ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip|ASGS_2021_Main_Structure_GDA2020.gpkg",
            archiveLink = "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip",
            updateFrequency = "quinquennial",
            downloadDate = ymd("2019-10-10"),
            overwrite = TRUE)

regGeometry(al1 = !!thisNation,
            gSeries = gs[3],
            label = list(al1 = "AUS_NAME_2021", al2 = "STATE_NAME_2021", al3 = "SA4_NAME_2021"),
            archive = "ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip|ASGS_2021_Main_Structure_GDA2020.gpkg",
            archiveLink = "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip",
            updateFrequency = "quinquennial",
            downloadDate = ymd("2019-10-10"),
            overwrite = TRUE)

regGeometry(al1 = !!thisNation,
            gSeries = gs[3],
            label = list(al1 = "AUS_NAME_2021", al2 = "STATE_NAME_2021", al3 = "SA4_NAME_2021", al4 = "SA2_NAME_2021"),
            archive = "ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip|ASGS_2021_Main_Structure_GDA2020.gpkg",
            archiveLink = "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip",
            updateFrequency = "quinquennial",
            downloadDate = ymd("2019-10-10"),
            overwrite = TRUE)

normGeometry(pattern = gs[3],
             beep = 10)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  # abs_crops <- setCluster() %>%
  #   setFormat() %>%
  #   setIDVar(name = "al2", ) %>%
  #   setIDVar(name = "al3", ) %>%
  #   setIDVar(name = "year", ) %>%
  #   setIDVar(name = "methdod", value = "") %>%
  #   setIDVar(name = "crop", ) %>%
  #   setObsVar(name = "harvested", unit = "ha", )

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "cropsHistoric",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 1861,
           end = 2011,
           archive = "7124 data cube.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&7124%20data%20cube.xls&7124.0&Data%20Cubes&EF15C557DF98A5F9CA257B2500137D3B&0&2010-11&06.03.2013&Latest",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7124.0 - Historical Selected Agriculture Commodities, by State (1861 to Present), 2010-11.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7124.0Quality%20Declaration02010-11?OpenDocument")

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2000,
           end = 2001,
           archive = "71250do\\d{3}_200001.zip",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7125.02000-01?OpenDocument",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7125.0 - Agricultural Commodities_ Small Area Data, Australia, 2000-01.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7125.0Explanatory%20Notes12000-01?OpenDocument")

  # tales not yet extracted from PDFs
  # regTable(al1 = !!thisNation,
  #          label = "al2",
  #          subset = "crops",
  #          dSeries = ds[1],
  #          gSeries = gs[],
  #          schema = schema_default,
  #          begin = 2000,
  #          end = 2001,
  #          archive = "71210_2000-01.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2000-01.pdf&7121.0&Publication&06E3CE2CA37B88A4CA256C8B0082B52D&22&2000-01&11.12.2002&Latest",
  #          updateFrequency = "annualy",
  # downloadDate = ymd("2019-10-10"),
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2000-01.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Technical%20Note12000-01?OpenDocument")
  #
  # regTable(al1 = !!thisNation,
  #          label = "al2",
  #          subset = "crops",
  #          dSeries = ds[1],
  #          gSeries = gs[],
  #          schema = schema_default,
  #          begin = 2001,
  #          end = 2002,
  #          archive = "71210_2001-02.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2001-02.pdf&7121.0&Publication&25748BBEEB23F06ACA256D64000387C0&23&2001-02&15.07.2003&Latest",
  #          updateFrequency = "annualy",
  # downloadDate = ymd("2019-10-10"),
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2001-02.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12001-02?OpenDocument")
  #
  # regTable(al1 = !!thisNation,
  #          label = "al2",
  #          subset = "crops",
  #          dSeries = ds[1],
  #          gSeries = gs[],
  #          schema = schema_default,
  #          begin = 2002,
  #          end = 2003,
  #          archive = "71210_2002-03.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2003-04.pdf&7121.0&Publication&952201D5714C10C3CA25702D0077C778&17&2003-04&28.06.2005&Latest",
  #          updateFrequency = "annualy",
  # downloadDate = ymd("2019-10-10"),
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2003-04.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12003-04?OpenDocument")
  #
  # regTable(al1 = !!thisNation,
  #          label = "al2",
  #          subset = "crops",
  #          dSeries = ds[1],
  #          gSeries = gs[],
  #          schema = schema_default,
  #          begin = 2003,
  #          end = 2004,
  #          archive = "71210_2003-04.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2001-02.pdf&7121.0&Publication&25748BBEEB23F06ACA256D64000387C0&23&2001-02&15.07.2003&Latest",
  #          updateFrequency = "annualy",
  # downloadDate = ymd("2019-10-10"),
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2001-02.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12001-02?OpenDocument")
  #
  # regTable(al1 = !!thisNation,
  #          label = "al2",
  #          subset = "crops",
  #          dSeries = ds[1],
  #          gSeries = gs[],
  #          schema = schema_default,
  #          begin = 2004,
  #          end = 2005,
  #          archive = "71210_2004-05.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2004-05.pdf&7121.0&Publication&8F58DC9F7662A518CA25719A00159051&0&2004-05&28.06.2006&Latest",
  #          updateFrequency = "annualy",
  # downloadDate = ymd("2019-10-10"),
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2004-05.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12004-05?OpenDocument")
  #
  # regTable(al1 = !!thisNation,
  #          label = "al2",
  #          subset = "crops",
  #          dSeries = ds[1],
  #          gSeries = gs[],
  #          schema = schema_default,
  #          begin = 2005,
  #          end = 2006,
  #          archive = "71210_2005-06.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2005-06.pdf&7121.0&Publication&393F8CDF359889C1CA257401000D5E7C&0&2005-06&04.03.2008&Latest",
  #          updateFrequency = "annualy",
  # downloadDate = ymd("2019-10-10"),
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2005-06.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12005-06?OpenDocument")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2005,
           end = 2006,
           archive = "71250do\\d{3}_200506.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7125.02005-06%20(Reissue)?OpenDocument",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7125.0 - Agricultural Commodities_ Small Area Data, Australia, 2005-06 (Reissue).html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7125.0Explanatory%20Notes12005-06%20(Reissue)?OpenDocument")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2006,
           end = 2007,
           archive = "71250do\\d{3}_200607.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7125.02006-07?OpenDocument",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7125.0 - Agricultural Commodities_ Small Area Data, Australia, 2006-07.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7125.0Explanatory%20Notes12006-07?OpenDocument")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2007,
           end = 2008,
           archive = "71210do002_200708.xls",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&71210do002_200708.xls&7121.0&Data%20Cubes&9EEECDE2C3C93909CA2575EE001AEB22&0&2007-08&10.07.2009&Latest",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2007-08.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12007-08?OpenDocument")

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2008,
           end = 2009,
           archive = "71210do005_200809.xls",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&71210do005_200809.xls&7121.0&Data%20Cubes&B83A2FBF60DF76ECCA257715000F482C&0&2008-09&03.05.2010&Latest",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2008-09.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12008-09?OpenDocument")

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2009,
           end = 2010,
           archive = "71210do002_200910.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do002_200910.xls&7121.0&Data%20Cubes&8C2584E45A294CF7CA2578B900179BF3&0&2009-10&27.06.2011&Latest",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2009-10.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12009-10?OpenDocument")

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2010,
           end = 2011,
           archive = "71210do\\d{3}_201011.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7121.02010-11?OpenDocument",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2010-11.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12010-11?OpenDocument")

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2011,
           end = 2012,
           archive = "7121_sa4.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&7121_sa4.xls&7121.0&Data%20Cubes&2A12B7C3D81288A6CA257BF00011B69A&0&2011-12&25.09.2013&Previous",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2011-12.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12011-12?OpenDocument")

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2012,
           end = 2013,
           archive = "71210do004_201213.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do004_201213.xls&7121.0&Data%20Cubes&418D030F7DC67269CA257D5C001E1BFE&0&2012-2013&24.09.2014&Previous",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2012-2013.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12012-2013?OpenDocument")

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2013,
           end = 2014,
           archive = "71210do004_201314.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do004_201314.xls&7121.0&Data%20Cubes&4040CCB8FAC02C4ACA257EC00012DD00&0&2013-14&15.09.2015&Previous",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2013-14.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12013-14?OpenDocument")

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2014,
           end = 2015,
           archive = "71210do006_201415.csv",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&71210do006_201415.csv&7121.0&Data%20Cubes&103EBFFAF190A5D8CA257F7E000F7D2C&0&2014-15&23.03.2016&Latest",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2014-15.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12014-15?OpenDocument")

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2015,
           end = 2016,
           archive = "7121do004_201516.csv",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&7121do004_201516.csv&7121.0&Data%20Cubes&3B9C809B49A11744CA2581C900105EE7&0&2015-16&31.10.2017&Previous",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2015-16.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12015-16?OpenDocument")

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2016,
           end = 2017,
           archive = "71210do005_201617.csv",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do005_201617.csv&7121.0&Data%20Cubes&00C367B548F5DD61CA2582910013A749&0&2016-17&21.05.2018&Previous",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2016-17.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12016-17?OpenDocument")

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2017,
           end = 2018,
           archive = "71210do005_201718.csv",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2017-18/71210do005_201718.csv",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "Agricultural Commodities, Australia methodology, 2017-18 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2017-18")

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2018,
           end = 2019,
           archive = "71210do005_201819.csv",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2018-19/71210do005_201819.csv",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "Agricultural Commodities, Australia methodology, 2018-19 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2018-19")

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2019,
           end = 2020,
           archive = "71210DO003_201920.csv",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2019-20/71210DO003_201920.csv",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "Agricultural Commodities, Australia methodology, 2019-20 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2019-20")

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2020,
           end = 2021,
           archive = "AGCDCASGS202021.xlsx",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2020-21/AGCDCASGS202021.xlsx",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "Agricultural Commodities, Australia methodology, 2020-21 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2020-21")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[],
           schema = schema_default,
           begin = 2021,
           end = 2022,
           archive = "AGCDCNAT_STATE202122.xlsx",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2021-22/AGCDCNAT_STATE202122.xlsx",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "Agricultural Commodities, Australia methodology, 2021-22 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2021-22")

  normTable(pattern = paste0("crops*", ds[1]),
            ontoMatch = "crop",
            beep = 10)
}

if(build_livestock){
  ## livestock ----

  schema_abs_livestockHistoric <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 1), rows = 1) %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = .find(fun = is.numeric, row = 1), top = 2)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "livestockHistoric",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_abs_livestockHistoric,
           begin = 1860,
           end = 2011,
           archive = "7124 data cube.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&7124%20data%20cube.xls&7124.0&Data%20Cubes&EF15C557DF98A5F9CA257B2500137D3B&0&2010-11&06.03.2013&Latest",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7124.0 - Historical Selected Agriculture Commodities, by State (1861 to Present), 2010-11.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7124.0Quality%20Declaration02010-11?OpenDocument")

  schema_abs_livestock2001 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", value = "2001") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2001,
           begin = 2000,
           end = 2001,
           archive = "71250do\\d{3}_200001.zip",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7125.02000-01?OpenDocument",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7125.0 - Agricultural Commodities_ Small Area Data, Australia, 2000-01.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7125.0Explanatory%20Notes12000-01?OpenDocument")

  # tales not yet extracted from PDFs
  # regTable(al1 = !!thisNation,
  #          label = "al2",
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[],
  #          schema = ,
  #          begin = 2000,
  #          end = 2001,
  #          archive = "71210_2000-01.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2000-01.pdf&7121.0&Publication&06E3CE2CA37B88A4CA256C8B0082B52D&22&2000-01&11.12.2002&Latest",
  #          updateFrequency = "annualy",
  # downloadDate = ymd("2019-10-10"),
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2000-01.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Technical%20Note12000-01?OpenDocument")
  #
  # regTable(al1 = !!thisNation,
  #          label = "al2",
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[],
  #          schema = ,
  #          begin = 2001,
  #          end = 2002,
  #          archive = "71210_2001-02.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2001-02.pdf&7121.0&Publication&25748BBEEB23F06ACA256D64000387C0&23&2001-02&15.07.2003&Latest",
  #          updateFrequency = "annualy",
  # downloadDate = ymd("2019-10-10"),
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2001-02.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12001-02?OpenDocument")
  #
  # regTable(al1 = !!thisNation,
  #          label = "al2",
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[],
  #          schema = ,
  #          begin = 2002,
  #          end = 2003,
  #          archive = "71210_2002-03.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2003-04.pdf&7121.0&Publication&952201D5714C10C3CA25702D0077C778&17&2003-04&28.06.2005&Latest",
  #          updateFrequency = "annualy",
  # downloadDate = ymd("2019-10-10"),
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2003-04.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12003-04?OpenDocument")
  #
  # regTable(al1 = !!thisNation,
  #          label = "al2",
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[],
  #          schema = ,
  #          begin = 2003,
  #          end = 2004,
  #          archive = "71210_2003-04.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2001-02.pdf&7121.0&Publication&25748BBEEB23F06ACA256D64000387C0&23&2001-02&15.07.2003&Latest",
  #          updateFrequency = "annualy",
  # downloadDate = ymd("2019-10-10"),
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2001-02.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12001-02?OpenDocument")
  #
  # regTable(al1 = !!thisNation,
  #          label = "al2",
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[],
  #          schema = ,
  #          begin = 2004,
  #          end = 2005,
  #          archive = "71210_2004-05.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2004-05.pdf&7121.0&Publication&8F58DC9F7662A518CA25719A00159051&0&2004-05&28.06.2006&Latest",
  #          updateFrequency = "annualy",
  # downloadDate = ymd("2019-10-10"),
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2004-05.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12004-05?OpenDocument")
  #
  # regTable(al1 = !!thisNation,
  #          label = "al2",
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[],
  #          schema = ,
  #          begin = 2005,
  #          end = 2006,
  #          archive = "71210_2005-06.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2005-06.pdf&7121.0&Publication&393F8CDF359889C1CA257401000D5E7C&0&2005-06&04.03.2008&Latest",
  #          updateFrequency = "annualy",
  # downloadDate = ymd("2019-10-10"),
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2005-06.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12005-06?OpenDocument")

  schema_abs_livestock2006 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", value = "2006") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2006,
           begin = 2005,
           end = 2006,
           archive = "71250do\\d{3}_200506.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7125.02005-06%20(Reissue)?OpenDocument",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7125.0 - Agricultural Commodities_ Small Area Data, Australia, 2005-06 (Reissue).html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7125.0Explanatory%20Notes12005-06%20(Reissue)?OpenDocument")

  schema_abs_livestock2007 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", value = "2007") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2007,
           begin = 2006,
           end = 2007,
           archive = "71250do\\d{3}_200607.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7125.02006-07?OpenDocument",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7125.0 - Agricultural Commodities_ Small Area Data, Australia, 2006-07.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7125.0Explanatory%20Notes12006-07?OpenDocument")

  schema_abs_livestock2008 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", value = "2008") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2008,
           begin = 2007,
           end = 2008,
           archive = "71210do002_200708.xls",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&71210do002_200708.xls&7121.0&Data%20Cubes&9EEECDE2C3C93909CA2575EE001AEB22&0&2007-08&10.07.2009&Latest",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2007-08.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12007-08?OpenDocument")

  schema_abs_livestock2009 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", value = "2009") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2009,
           begin = 2008,
           end = 2009,
           archive = "71210do005_200809.xls",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&71210do005_200809.xls&7121.0&Data%20Cubes&B83A2FBF60DF76ECCA257715000F482C&0&2008-09&03.05.2010&Latest",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2008-09.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12008-09?OpenDocument")

  schema_abs_livestock2010 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", value = "2010") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2010,
           begin = 2009,
           end = 2010,
           archive = "71210do002_200910.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do002_200910.xls&7121.0&Data%20Cubes&8C2584E45A294CF7CA2578B900179BF3&0&2009-10&27.06.2011&Latest",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2009-10.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12009-10?OpenDocument")

  schema_abs_livestock2011 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2011") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 5)

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2011,
           begin = 2010,
           end = 2011,
           archive = "71210do\\d{3}_201011.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7121.02010-11?OpenDocument",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2010-11.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12010-11?OpenDocument")

  schema_abs_livestock2012 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", value = "2012") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2012,
           begin = 2011,
           end = 2012,
           archive = "7121_sa4.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&7121_sa4.xls&7121.0&Data%20Cubes&2A12B7C3D81288A6CA257BF00011B69A&0&2011-12&25.09.2013&Previous",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2011-12.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12011-12?OpenDocument")

  schema_abs_livestock2013 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", value = "2013") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2013,
           begin = 2012,
           end = 2013,
           archive = "71210do004_201213.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do004_201213.xls&7121.0&Data%20Cubes&418D030F7DC67269CA257D5C001E1BFE&0&2012-2013&24.09.2014&Previous",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2012-2013.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12012-2013?OpenDocument")

  schema_abs_livestock2014 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", value = "2014") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2014,
           begin = 2013,
           end = 2014,
           archive = "71210do004_201314.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do004_201314.xls&7121.0&Data%20Cubes&4040CCB8FAC02C4ACA257EC00012DD00&0&2013-14&15.09.2015&Previous",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2013-14.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12013-14?OpenDocument")

  schema_abs_livestock2015 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", value = "2015") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2015,
           begin = 2014,
           end = 2015,
           archive = "71210do006_201415.csv",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&71210do006_201415.csv&7121.0&Data%20Cubes&103EBFFAF190A5D8CA257F7E000F7D2C&0&2014-15&23.03.2016&Latest",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2014-15.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12014-15?OpenDocument")

  schema_abs_livestock2016 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", value = "2016") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2016,
           begin = 2015,
           end = 2016,
           archive = "7121do004_201516.csv",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&7121do004_201516.csv&7121.0&Data%20Cubes&3B9C809B49A11744CA2581C900105EE7&0&2015-16&31.10.2017&Previous",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2015-16.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12015-16?OpenDocument")

  schema_abs_livestock2017 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", value = "2017") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2017,
           begin = 2016,
           end = 2017,
           archive = "71210do005_201617.csv",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do005_201617.csv&7121.0&Data%20Cubes&00C367B548F5DD61CA2582910013A749&0&2016-17&21.05.2018&Previous",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2016-17.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12016-17?OpenDocument")

  schema_abs_livestock2018 <-
    setFormat(thousand = ",") %>%
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", value = "2018") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2018,
           begin = 2017,
           end = 2018,
           archive = "71210do005_201718.csv",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2017-18/71210do005_201718.csv",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "Agricultural Commodities, Australia methodology, 2017-18 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2017-18")

  schema_abs_livestock2019 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", value = "2019") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2019,
           begin = 2018,
           end = 2019,
           archive = "71210do005_201819.csv",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2018-19/71210do005_201819.csv",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "Agricultural Commodities, Australia methodology, 2018-19 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2018-19")

  schema_abs_livestock2020 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", value = "2020") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 4)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2020,
           begin = 2019,
           end = 2020,
           archive = "71210DO003_201920.csv",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2019-20/71210DO003_201920.csv",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "Agricultural Commodities, Australia methodology, 2019-20 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2019-20")

  schema_abs_livestock2021 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "year", value = "2021") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 5)

  regTable(al1 = !!thisNation,
           label = "al4",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[3],
           schema = schema_abs_livestock2021,
           begin = 2020,
           end = 2021,
           archive = "AGCDCASGS202021.xlsx",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2020-21/AGCDCASGS202021.xlsx",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "Agricultural Commodities, Australia methodology, 2020-21 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2020-21")

  schema_abs_livestock2022 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "year", value = "2010") %>%
    setIDVar(name = "animal", columns = 1) %>%
    setObsVar(name = "number_heads", columns = 3)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_abs_livestock2022,
           begin = 2021,
           end = 2022,
           archive = "AGCDCNAT_STATE202122.xlsx",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2021-22/AGCDCNAT_STATE202122.xlsx",
           updateFrequency = "annualy",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "Agricultural Commodities, Australia methodology, 2021-22 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2021-22")

  normTable(pattern = paste0("livestock.*", ds[1]),
            ontoMatch = "animal",
            beep = 10)

}

if(build_landuse){
  ## landuse ----

}
