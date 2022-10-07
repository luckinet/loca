# script arguments ----
#
thisNation <- "Afghanistan"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("countrySTAT", "UNODC")
gs <- c("gadm", "afg_SU")

regDataseries(name = ds[3],
              description = "Districts of Afghanistan, Stanford University Libraries",
              homepage = "https://library.stanford.edu/",
              licence_link = "https://earthworks.stanford.edu/catalog/stanford-yq852zn2316",
              licence_path = "not available",
              update = updateTables)


# register geometries ----
#
regGeometry(nation = "Afghanistan",
            gSeries = gs[2],
            level = 3,
            nameCol = "coc|nam|laa",
            archive = "afghanistan.zip|polbnda_afg.shp",
            archiveLink = "https://earthworks.stanford.edu/catalog/stanford-yq852zn2316",
            nextUpdate = "unknown",
            updateFrequency = "notplanned",
            update = updateTables,
            overwrite = overwriteTables)


# register census tables ----
#
# countrystat ----
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
         update = updateTables,
         overwrite = overwriteTables)

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
         update = updateTables,
         overwrite = overwriteTables)

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
         update = updateTables,
         overwrite = overwriteTables)

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
         update = updateTables,
         overwrite = overwriteTables)

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
         update = updateTables,
         overwrite = overwriteTables)

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
         update = updateTables,
         overwrite = overwriteTables)

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
         update = updateTables,
         overwrite = overwriteTables)

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
         update = updateTables,
         overwrite = overwriteTables)

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
         update = updateTables,
         overwrite = overwriteTables)

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
         update = updateTables,
         overwrite = overwriteTables)

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
         update = updateTables,
         overwrite = overwriteTables)

# UNODC ----
# Level 3 is inconsistent with the gadm dataset. Will not normalise it.
schema_afg_10 <-
  setFormat(thousand = ".") %>%
  setFilter(rows = .find("Total", col = 2), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", rows = 1, columns = c(3:18)) %>%
  setIDVar(name = "commodities", value = "poppy") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(3:18))

regTable(nation = "afg",
         level = 3,
         subset = "plantedPoppy",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_afg_10,
         begin = 1994,
         end = 2009,
         archive = "Afgh-opiumsurvey2009_web.pdf|p.140-147",
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_afg_11 <- schema_afg_10 %>%
  setFormat(thousand = ",") %>%
  setIDVar(name = "year", rows = 1, columns = c(3:13)) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(3:13))

regTable(nation = "afg",
         level = 3,
         subset = "plantedPoppyTwo",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_afg_11,
         begin = 2010,
         end = 2020,
         archive = "20210503_Executive_summary_Opium_Survey_2020_SMALL.pdf|p.14-21",
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_afg_12 <-
  setFilter(rows = c(38:44), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", rows = 3, columns = c(2:15)) %>%
  setIDVar(name = "commodities", value = "poppy") %>%
  setObsVar(name = "production", unit = "t", columns = c(2:15))

regTable(nation = "afg",
         level = 2,
         subset = "productionOpium",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_afg_12,
         begin = 2005,
         end = 2018,
         archive = "production_afgha_opium_2005_2018_lvl2.csv", # can't find the original pdf file containing this data
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_afg_13 <-
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", value = "2001") %>%
  setIDVar(name = "commodities", value = "poppy") %>%
  setObsVar(name = "planted", unit = "ha", columns = 5) %>%
  setObsVar(name = "yieldIrrigated", unit = "kg/ha", columns = 6) %>%
  setObsVar(name = "yieldRainFed", unit = "kg/ha", columns = 7) %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = 10)

regTable(nation = "afg",
         level = 3,
         subset = "plantProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_afg_13,
         begin = 2001,
         end = 2001,
         archive = "production_afgha_opium_2001.csv", # can't find the original pdf file containing this data
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_afg_14 <- schema_afg_13 %>%
  setFormat(thousand = ",") %>%
  setFilter(rows = .find("...Result", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", value = "2000") %>%
  setIDVar(name = "commodities", value = "poppy")

regTable(nation = "afg",
         level = 3,
         subset = "plantProdYield",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_afg_14,
         begin = 2000,
         end = 2000,
         archive = "production_afgha_opium_2000.csv", # can't find the original pdf file containing this data
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Afghanistan",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


# harmonise commodities ----
#
for(i in seq_along(ds)){

  tibble(new = get_variable(variable = "commodities", dataseries = ds[i])) %>%
    match_ontology(table = ., columns = "new", dataseries = ds[i], ontology = ontoDir)

}


# normalise geometries ----
#
# not needed


# normalise census tables ----
#
normTable(pattern = ds[1],
         al1 = thisNation,
         outType = "rds",
         update = updateTables)

normTable(pattern = ds[2],
         al1 = thisNation,
         outType = "rds",
         update = updateTables)
