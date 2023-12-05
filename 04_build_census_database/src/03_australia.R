# script arguments ----
#
# source(paste0(mdl0301, "src/96_preprocess_abs.R"))
thisNation <- "Australia"

ds <- c("abs")
gs <- c("gadm36", "asgs")


# 1. dataseries ----
#
regDataseries(name = ds[1],
              description = "Australia Bureau of Statistics",
              homepage = "https://www.abs.gov.au/",
              licence_link = "https://creativecommons.org/licenses/by/3.0/au/",
              licence_path = "unknown")

regDataseries(name = gs[2],
              description = "Australian Statistical Geography Standard",
              homepage = "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/latest-release",
              licence_link = "https://creativecommons.org/licenses/by/3.0/au/",
              licence_path = "unknown")


# 2. geometries ----
#
regGeometry(nation = !!thisNation,
            gSeries = gs[2],
            label = list(al1 = "AUS_NAME_2021"),
            archive = "ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip|ASGS_2021_Main_Structure_GDA2020.gpkg",
            archiveLink = "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip",
            updateFrequency = "quinquennial",
            nextUpdate = "2026-01-01",
            overwrite = TRUE)

regGeometry(nation = !!thisNation,
            gSeries = gs[2],
            label = list(al1 = "AUS_NAME_2021", al2 = "STATE_NAME_2021"),
            archive = "ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip|ASGS_2021_Main_Structure_GDA2020.gpkg",
            archiveLink = "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip",
            updateFrequency = "quinquennial",
            nextUpdate = "2026-01-01",
            overwrite = TRUE)

regGeometry(nation = !!thisNation,
            gSeries = gs[2],
            label = list(al1 = "AUS_NAME_2021", al2 = "STATE_NAME_2021", al3 = "SA4_NAME_2021"),
            archive = "ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip|ASGS_2021_Main_Structure_GDA2020.gpkg",
            archiveLink = "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip",
            updateFrequency = "quinquennial",
            nextUpdate = "2026-01-01",
            overwrite = TRUE)

regGeometry(nation = !!thisNation,
            gSeries = gs[2],
            label = list(al1 = "AUS_NAME_2021", al2 = "STATE_NAME_2021", al3 = "SA4_NAME_2021", al4 = "SA2_NAME_2021"),
            archive = "ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip|ASGS_2021_Main_Structure_GDA2020.gpkg",
            archiveLink = "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip",
            updateFrequency = "quinquennial",
            nextUpdate = "2026-01-01",
            overwrite = TRUE)

normGeometry(pattern = gs[2],
             priority = "spatial",
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

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "cropsHistoric",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 1861,
           end = 2011,
           archive = "7124 data cube.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&7124%20data%20cube.xls&7124.0&Data%20Cubes&EF15C557DF98A5F9CA257B2500137D3B&0&2010-11&06.03.2013&Latest",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7124.0 - Historical Selected Agriculture Commodities, by State (1861 to Present), 2010-11.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7124.0Quality%20Declaration02010-11?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2000,
           end = 2001,
           archive = "71250do\\d{3}_200001.zip",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7125.02000-01?OpenDocument",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7125.0 - Agricultural Commodities_ Small Area Data, Australia, 2000-01.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7125.0Explanatory%20Notes12000-01?OpenDocument")

  # tales not yet extracted from PDFs
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "crops",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = schema_default,
  #          begin = 2000,
  #          end = 2001,
  #          archive = "71210_2000-01.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2000-01.pdf&7121.0&Publication&06E3CE2CA37B88A4CA256C8B0082B52D&22&2000-01&11.12.2002&Latest",
  #          updateFrequency = "annualy",
  #          nextUpdate = "unknown",
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2000-01.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Technical%20Note12000-01?OpenDocument")
  #
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "crops",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = schema_default,
  #          begin = 2001,
  #          end = 2002,
  #          archive = "71210_2001-02.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2001-02.pdf&7121.0&Publication&25748BBEEB23F06ACA256D64000387C0&23&2001-02&15.07.2003&Latest",
  #          updateFrequency = "annualy",
  #          nextUpdate = "unknown",
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2001-02.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12001-02?OpenDocument")
  #
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "crops",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = schema_default,
  #          begin = 2002,
  #          end = 2003,
  #          archive = "71210_2002-03.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2003-04.pdf&7121.0&Publication&952201D5714C10C3CA25702D0077C778&17&2003-04&28.06.2005&Latest",
  #          updateFrequency = "annualy",
  #          nextUpdate = "unknown",
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2003-04.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12003-04?OpenDocument")
  #
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "crops",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = schema_default,
  #          begin = 2003,
  #          end = 2004,
  #          archive = "71210_2003-04.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2001-02.pdf&7121.0&Publication&25748BBEEB23F06ACA256D64000387C0&23&2001-02&15.07.2003&Latest",
  #          updateFrequency = "annualy",
  #          nextUpdate = "unknown",
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2001-02.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12001-02?OpenDocument")
  #
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "crops",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = schema_default,
  #          begin = 2004,
  #          end = 2005,
  #          archive = "71210_2004-05.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2004-05.pdf&7121.0&Publication&8F58DC9F7662A518CA25719A00159051&0&2004-05&28.06.2006&Latest",
  #          updateFrequency = "annualy",
  #          nextUpdate = "unknown",
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2004-05.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12004-05?OpenDocument")
  #
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "crops",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = schema_default,
  #          begin = 2005,
  #          end = 2006,
  #          archive = "71210_2005-06.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2005-06.pdf&7121.0&Publication&393F8CDF359889C1CA257401000D5E7C&0&2005-06&04.03.2008&Latest",
  #          updateFrequency = "annualy",
  #          nextUpdate = "unknown",
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2005-06.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12005-06?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2005,
           end = 2006,
           archive = "71250do\\d{3}_200506.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7125.02005-06%20(Reissue)?OpenDocument",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7125.0 - Agricultural Commodities_ Small Area Data, Australia, 2005-06 (Reissue).html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7125.0Explanatory%20Notes12005-06%20(Reissue)?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2006,
           end = 2007,
           archive = "71250do\\d{3}_200607.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7125.02006-07?OpenDocument",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7125.0 - Agricultural Commodities_ Small Area Data, Australia, 2006-07.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7125.0Explanatory%20Notes12006-07?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2007,
           end = 2008,
           archive = "71210do002_200708.xls",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&71210do002_200708.xls&7121.0&Data%20Cubes&9EEECDE2C3C93909CA2575EE001AEB22&0&2007-08&10.07.2009&Latest",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2007-08.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12007-08?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2008,
           end = 2009,
           archive = "71210do005_200809.xls",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&71210do005_200809.xls&7121.0&Data%20Cubes&B83A2FBF60DF76ECCA257715000F482C&0&2008-09&03.05.2010&Latest",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2008-09.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12008-09?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2009,
           end = 2010,
           archive = "71210do002_200910.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do002_200910.xls&7121.0&Data%20Cubes&8C2584E45A294CF7CA2578B900179BF3&0&2009-10&27.06.2011&Latest",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2009-10.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12009-10?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2010,
           end = 2011,
           archive = "71210do\\d{3}_201011.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7121.02010-11?OpenDocument",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2010-11.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12010-11?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2011,
           end = 2012,
           archive = "7121_sa4.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&7121_sa4.xls&7121.0&Data%20Cubes&2A12B7C3D81288A6CA257BF00011B69A&0&2011-12&25.09.2013&Previous",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2011-12.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12011-12?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2012,
           end = 2013,
           archive = "71210do004_201213.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do004_201213.xls&7121.0&Data%20Cubes&418D030F7DC67269CA257D5C001E1BFE&0&2012-2013&24.09.2014&Previous",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2012-2013.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12012-2013?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2013,
           end = 2014,
           archive = "71210do004_201314.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do004_201314.xls&7121.0&Data%20Cubes&4040CCB8FAC02C4ACA257EC00012DD00&0&2013-14&15.09.2015&Previous",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2013-14.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12013-14?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2014,
           end = 2015,
           archive = "71210do006_201415.csv",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&71210do006_201415.csv&7121.0&Data%20Cubes&103EBFFAF190A5D8CA257F7E000F7D2C&0&2014-15&23.03.2016&Latest",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2014-15.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12014-15?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2015,
           end = 2016,
           archive = "7121do004_201516.csv",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&7121do004_201516.csv&7121.0&Data%20Cubes&3B9C809B49A11744CA2581C900105EE7&0&2015-16&31.10.2017&Previous",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2015-16.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12015-16?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2016,
           end = 2017,
           archive = "71210do005_201617.csv",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do005_201617.csv&7121.0&Data%20Cubes&00C367B548F5DD61CA2582910013A749&0&2016-17&21.05.2018&Previous",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2016-17.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12016-17?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2017,
           end = 2018,
           archive = "71210do005_201718.csv",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2017-18/71210do005_201718.csv",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "Agricultural Commodities, Australia methodology, 2017-18 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2017-18")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2018,
           end = 2019,
           archive = "71210do005_201819.csv",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2018-19/71210do005_201819.csv",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "Agricultural Commodities, Australia methodology, 2018-19 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2018-19")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2019,
           end = 2020,
           archive = "71210DO003_201920.csv",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2019-20/71210DO003_201920.csv",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "Agricultural Commodities, Australia methodology, 2019-20 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2019-20")

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2020,
           end = 2021,
           archive = "AGCDCASGS202021.xlsx",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2020-21/AGCDCASGS202021.xlsx",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "Agricultural Commodities, Australia methodology, 2020-21 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2020-21")

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2021,
           end = 2022,
           archive = "AGCDCNAT_STATE202122.xlsx",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2021-22/AGCDCNAT_STATE202122.xlsx",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
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
    setObsVar(name = "headcount", columns = .find(fun = is.numeric, row = 1), top = 2)

  regTable(nation = !!thisNation,
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
           nextUpdate = "unknown",
           metadataPath = "7124.0 - Historical Selected Agriculture Commodities, by State (1861 to Present), 2010-11.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7124.0Quality%20Declaration02010-11?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2000,
           end = 2001,
           archive = "71250do\\d{3}_200001.zip",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7125.02000-01?OpenDocument",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7125.0 - Agricultural Commodities_ Small Area Data, Australia, 2000-01.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7125.0Explanatory%20Notes12000-01?OpenDocument")

  # tales not yet extracted from PDFs
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = schema_default,
  #          begin = 2000,
  #          end = 2001,
  #          archive = "71210_2000-01.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2000-01.pdf&7121.0&Publication&06E3CE2CA37B88A4CA256C8B0082B52D&22&2000-01&11.12.2002&Latest",
  #          updateFrequency = "annualy",
  #          nextUpdate = "unknown",
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2000-01.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Technical%20Note12000-01?OpenDocument")
  #
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = schema_default,
  #          begin = 2001,
  #          end = 2002,
  #          archive = "71210_2001-02.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2001-02.pdf&7121.0&Publication&25748BBEEB23F06ACA256D64000387C0&23&2001-02&15.07.2003&Latest",
  #          updateFrequency = "annualy",
  #          nextUpdate = "unknown",
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2001-02.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12001-02?OpenDocument")
  #
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = schema_default,
  #          begin = 2002,
  #          end = 2003,
  #          archive = "71210_2002-03.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2003-04.pdf&7121.0&Publication&952201D5714C10C3CA25702D0077C778&17&2003-04&28.06.2005&Latest",
  #          updateFrequency = "annualy",
  #          nextUpdate = "unknown",
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2003-04.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12003-04?OpenDocument")
  #
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = schema_default,
  #          begin = 2003,
  #          end = 2004,
  #          archive = "71210_2003-04.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2001-02.pdf&7121.0&Publication&25748BBEEB23F06ACA256D64000387C0&23&2001-02&15.07.2003&Latest",
  #          updateFrequency = "annualy",
  #          nextUpdate = "unknown",
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2001-02.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12001-02?OpenDocument")
  #
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = schema_default,
  #          begin = 2004,
  #          end = 2005,
  #          archive = "71210_2004-05.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2004-05.pdf&7121.0&Publication&8F58DC9F7662A518CA25719A00159051&0&2004-05&28.06.2006&Latest",
  #          updateFrequency = "annualy",
  #          nextUpdate = "unknown",
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2004-05.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12004-05?OpenDocument")
  #
  # regTable(nation = !!thisNation,
  #          label = "al2",
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[2],
  #          schema = schema_default,
  #          begin = 2005,
  #          end = 2006,
  #          archive = "71210_2005-06.pdf",
  #          archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210_2005-06.pdf&7121.0&Publication&393F8CDF359889C1CA257401000D5E7C&0&2005-06&04.03.2008&Latest",
  #          updateFrequency = "annualy",
  #          nextUpdate = "unknown",
  #          metadataPath = "7121.0 - Agricultural Commodities, Australia, 2005-06.html",
  #          metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12005-06?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2005,
           end = 2006,
           archive = "71250do\\d{3}_200506.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7125.02005-06%20(Reissue)?OpenDocument",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7125.0 - Agricultural Commodities_ Small Area Data, Australia, 2005-06 (Reissue).html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7125.0Explanatory%20Notes12005-06%20(Reissue)?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2006,
           end = 2007,
           archive = "71250do\\d{3}_200607.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7125.02006-07?OpenDocument",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7125.0 - Agricultural Commodities_ Small Area Data, Australia, 2006-07.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7125.0Explanatory%20Notes12006-07?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2007,
           end = 2008,
           archive = "71210do002_200708.xls",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&71210do002_200708.xls&7121.0&Data%20Cubes&9EEECDE2C3C93909CA2575EE001AEB22&0&2007-08&10.07.2009&Latest",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2007-08.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12007-08?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2008,
           end = 2009,
           archive = "71210do005_200809.xls",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&71210do005_200809.xls&7121.0&Data%20Cubes&B83A2FBF60DF76ECCA257715000F482C&0&2008-09&03.05.2010&Latest",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2008-09.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12008-09?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2009,
           end = 2010,
           archive = "71210do002_200910.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do002_200910.xls&7121.0&Data%20Cubes&8C2584E45A294CF7CA2578B900179BF3&0&2009-10&27.06.2011&Latest",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2009-10.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12009-10?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2010,
           end = 2011,
           archive = "71210do\\d{3}_201011.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/7121.02010-11?OpenDocument",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2010-11.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12010-11?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2011,
           end = 2012,
           archive = "7121_sa4.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&7121_sa4.xls&7121.0&Data%20Cubes&2A12B7C3D81288A6CA257BF00011B69A&0&2011-12&25.09.2013&Previous",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2011-12.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12011-12?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2012,
           end = 2013,
           archive = "71210do004_201213.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do004_201213.xls&7121.0&Data%20Cubes&418D030F7DC67269CA257D5C001E1BFE&0&2012-2013&24.09.2014&Previous",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2012-2013.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12012-2013?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2013,
           end = 2014,
           archive = "71210do004_201314.xls",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do004_201314.xls&7121.0&Data%20Cubes&4040CCB8FAC02C4ACA257EC00012DD00&0&2013-14&15.09.2015&Previous",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2013-14.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12013-14?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2014,
           end = 2015,
           archive = "71210do006_201415.csv",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&71210do006_201415.csv&7121.0&Data%20Cubes&103EBFFAF190A5D8CA257F7E000F7D2C&0&2014-15&23.03.2016&Latest",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2014-15.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12014-15?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2015,
           end = 2016,
           archive = "7121do004_201516.csv",
           archiveLink = "https://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&7121do004_201516.csv&7121.0&Data%20Cubes&3B9C809B49A11744CA2581C900105EE7&0&2015-16&31.10.2017&Previous",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2015-16.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12015-16?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2016,
           end = 2017,
           archive = "71210do005_201617.csv",
           archiveLink = "https://www.abs.gov.au/AUSSTATS/subscriber.nsf/log?openagent&71210do005_201617.csv&7121.0&Data%20Cubes&00C367B548F5DD61CA2582910013A749&0&2016-17&21.05.2018&Previous",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "7121.0 - Agricultural Commodities, Australia, 2016-17.html",
           metadataLink = "https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7121.0Explanatory%20Notes12016-17?OpenDocument")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2017,
           end = 2018,
           archive = "71210do005_201718.csv",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2017-18/71210do005_201718.csv",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "Agricultural Commodities, Australia methodology, 2017-18 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2017-18")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2018,
           end = 2019,
           archive = "71210do005_201819.csv",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2018-19/71210do005_201819.csv",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "Agricultural Commodities, Australia methodology, 2018-19 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2018-19")

  regTable(nation = !!thisNation,
           label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2019,
           end = 2020,
           archive = "71210DO003_201920.csv",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2019-20/71210DO003_201920.csv",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "Agricultural Commodities, Australia methodology, 2019-20 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2019-20")

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2020,
           end = 2021,
           archive = "AGCDCASGS202021.xlsx",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2020-21/AGCDCASGS202021.xlsx",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "Agricultural Commodities, Australia methodology, 2020-21 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2020-21")

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_default,
           begin = 2021,
           end = 2022,
           archive = "AGCDCNAT_STATE202122.xlsx",
           archiveLink = "https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia/2021-22/AGCDCNAT_STATE202122.xlsx",
           updateFrequency = "annualy",
           nextUpdate = "unknown",
           metadataPath = "Agricultural Commodities, Australia methodology, 2021-22 financial year _ Australian Bureau of Statistics.html",
           metadataLink = "https://www.abs.gov.au/methodologies/agricultural-commodities-australia-methodology/2021-22")

  normTable(pattern = paste0("livestock*", ds[1]),
            ontoMatch = "animal",
            beep = 10)

}

if(build_landuse){
  ## landuse ----

}


#### test schemas

# myRoot <- paste0(census_dir, "/adb_tables/stage2/")
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
