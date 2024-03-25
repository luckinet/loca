# script arguments ----
#
thisNation <- "India"


# 1. dataseries ----
#
ds <- c("mospi", "indis")
gs <- c("gadm")

regDataseries(name = "mospi",
              description = "Ministry of statistic and program implementation, government of India",
              homepage = "http://mospi.nic.in/",
              version = "2024.01",
              licence_link = "unknown")

regDataseries(name = "indis",
              description = "Indiastat Districts",
              homepage = "https://www.indiastatdistricts.com/",
              version = "2024.01",
              licence_link = "unknown")


# 2. geometries ----
#
regGeometry(nation = !!thisNation,
            gSeries = gs[],
            label = list(al_ = ""),
            archive = "|",
            archiveLink = _INSERT,
            downloadDate = _INSERT,
            updateFrequency = _INSERT)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  schema_crops <- setCluster(id = _INSERT) %>%
    setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
              na_values = _INSERT) %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "") %>%
    setIDVar(name = "crop", ) %>%
    setObsVar(name = "hectares_harvested", ) %>%
    setObsVar(name = "tons_produced", ) %>%
    setObsVar(name = "kiloPerHectare_yield", )

  regTable(nation = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_crops,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           downloadDate = ymd(_INSERT),
           updateFrequency = _INSERT,
           metadataLink = _INSERT,
           metadataPath = _INSERT,
           overwrite = TRUE)

  normTable(pattern = ds[],
            ontoMatch = "crop",
            beep = 10)
}

if(build_livestock){
  ## livestock ----

  schema_livestock <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "") %>%
    setIDVar(name = "animal", )  %>%
    setObsVar(name = "number_heads", )

  regTable(nation = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_livestock,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           downloadDate = ymd(_INSERT),
           updateFrequency = _INSERT,
           metadataLink = _INSERT,
           metadataPath = _INSERT,
           overwrite = TRUE)

  normTable(pattern = ds[],
            ontoMatch = "animal",
            beep = 10)
}

if(build_landuse){
  ## landuse ----

  schema_landuse <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "landuse", ) %>%
    setObsVar(name = "hectares_covered", )

  regTable(nation = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_landuse,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           downloadDate = ymd(_INSERT),
           updateFrequency = _INSERT,
           metadataLink = _INSERT,
           metadataPath = _INSERT,
           overwrite = TRUE)

  normTable(pattern = ds[],
            ontoMatch = "landuse",
            beep = 10)
}


#### test schemas
#
# myRoot <- paste0(census_dir, "tables/stage2/")
# myFile <- ""
# input <- read_csv(file = paste0(myRoot, myFile),
#                   col_names = FALSE,
#                   col_types = cols(.default = "c"))
#
# schema <-
# validateSchema(schema = schema, input = input)
#
# output <- reorganise(input = input, schema = schema)
#
# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script


# 4. normalise geometries ----
#
normGeometry(pattern = gs[])


# 5. normalise census tables ----
#
normTable(pattern = ds[],
          ontoMatch = )


# register census tables ----
#
if(build_crops){
  ## crops ----

  ### indis ----


  ### mospi ----
#   # yields are recorded with unit quintals per hectare. I need a factor of 100 to convert to kg per hectare
#   # Merging argument works for columns and not rows.
#   schema_ind_06 <- setCluster(id = "commodities", left = c(2:9, 11:12, 14, 17:21), top = 14, height = 9) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "year", columns = 1) %>%
#     setIDVar(name = "commodities", columns = c(2:9, 11:12, 14, 17:21), rows = 11) %>%
#     setObsVar(name = "yield", factor = 100, columns = c(2:9, 11:12, 14, 17:21), top = 5)
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "yield",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_06,
#            begin = 2001,
#            end = 2009,
#            archive = "yield_2001-2009_l1_l2.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.4_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_06_01 <- schema_ind_06 %>%
#     setCluster(id = "commodities", left = c(23:24, 26:38), top = 14, height = 9) %>%
#     setIDVar(name = "commodities", columns = c(23:24, 26:38), rows = 9) %>%
#     setObsVar(name = "yield", factor = 100, columns = c(23:24, 26:38), top = 5)
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "yield02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_06_01,
#            begin = 2001,
#            end = 2009,
#            archive = "yield_2001-2009_l1_l2.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.4_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   # yields are recorded with unit- quintals per hectare. I need a factor of 100 to convert to kg per hectare
#   schema_ind_07 <- setCluster(id = "al1", left = 1, top = 13, height = 16) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "year", columns = 1) %>%
#     setIDVar(name = "commodities", columns = c(2:10, 11:13, 16:20, 22:27, 29:30, 32:36), rows = 11) %>%
#     setObsVar(name = "yield", factor = 100, columns = c(2:10, 11:13, 16:20, 22:27, 29:30, 32:36))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "yield",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_07,
#            begin = 2002,
#            end = 2016,
#            archive = "yield_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.4_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   # Had to make a separate schems for Banana and potato yield, because they are in Mt/ha, and not in quintals/ha, like the other commodities.
#   schema_ind_08 <- schema_ind_07 %>%
#     setIDVar(name = "commodities", columns = c(28, 31), rows = 11) %>%
#     setObsVar(name = "yield", factor = 1000, columns = c(28, 31))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "yieldBananaPotato",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_08,
#            begin = 2002,
#            end = 2016,
#            archive = "yield_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.4_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_09 <- setCluster(id = "year", left = 1, top = 26, height = 38) %>%
#     setFilter(rows = .find("Union", col = 1, invert = TRUE)) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2009") %>%
#     setIDVar(name = "commodities", columns = c(2:12, 14, 17:21), rows = 11) %>%
#     setObsVar(name = "yield", factor = 100, columns = c(2:12, 14, 17:21))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "yield",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_09,
#            begin = 2009,
#            end = 2009,
#            archive = "yield_2001-2009_l1_l2.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.4_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_09_00 <- schema_ind_09 %>%
#     setIDVar(name = "commodities", columns = c(23:24, 26:38), rows = 9) %>%
#     setObsVar(name = "yield", factor = 100, columns = c(23:24, 26:38))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "yield02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_09_00,
#            begin = 2009,
#            end = 2009,
#            archive = "yield_2001-2009_l1_l2.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.4_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_10 <- setCluster(id = "al1", left = 1, top = 11, height = 37) %>%
#     setFilter(rows = .find("Union..", col = 1, invert = TRUE)) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", columns = c(2:41, 47:61, 72:96, 102:166), rows = 8) %>%
#     setIDVar(name = "commodities", columns = .find(is.character, row = 7), rows = 7) %>%
#     setObsVar(name = "yield", columns = c(2:41, 47:61, 72:96, 102:166), top = 4)
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "yield",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_10,
#            begin = 2010,
#            end = 2014,
#            archive = "yield_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.4_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   # Jute and Mesta each have a column with ObsVar, but they also appear together in other column. The combined column is in the schema. Maybe it should be removed.
#   # There is a region here called "other" I put "ignore"
#   schema_ind_11 <- setCluster(id = "year", left = 1, top = 8, height = 23) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2015") %>%
#     setIDVar(name = "commodities", columns = c(2:17, 19:34), rows = 6) %>%
#     setObsVar(name = "yield", columns = c(2:17, 19:34))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "yield",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_11,
#            begin = 2015,
#            end = 2015,
#            archive = "yield_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.4_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   # Jute and Mesta each have a column with ObsVar, but they also appear together in other column. The combined column is in the schema. Maybe it should be removed.
#   schema_ind_12 <- schema_ind_11 %>%
#     setFilter(rows = .find("All-India", col = 1, invert = TRUE)) %>%
#     setCluster(id = "year", left = 1, top = 10, height = 23) %>%
#     setIDVar(name = "year", value = "2016") %>%
#     setIDVar(name = "commodities", columns = c(2:17, 19:34), rows = 7)
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "yield",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_12,
#            begin = 2016,
#            end = 2016,
#            archive = "yield_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.4_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_13 <- setCluster(id = "al1", left = 1, top = 11, height = 15) %>%
#     setFormat(flags = data.frame(flag = "P", value = "Provisional")) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "year", columns = 1) %>%
#     setIDVar(name = "commodities", columns = c(2:9, 11:13, 16:20), rows = 9) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2:9, 11:13, 16:20))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "planted",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_13,
#            begin = 2002,
#            end = 2016,
#            archive = "area_crop_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_13_00 <- schema_ind_13 %>%
#     setIDVar(name = "commodities", columns = c(22:36), rows = 8) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(22:36))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "planted02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_13_00,
#            begin = 2002,
#            end = 2016,
#            archive = "area_crop_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_14 <- setCluster(id = "al1", left = 1, top = 13, height = 10) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "year", columns = 1) %>%
#     setIDVar(name = "commodities", columns = c(2:9, 11:12, 14, 17:21), rows = 10) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2:9, 11:12, 14, 17:21))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "planted",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_14,
#            begin = 2001,
#            end = 2009,
#            archive = "area_crops_2001-2009_l1_l2.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_14_00 <- schema_ind_14 %>%
#     setIDVar(name = "commodities", columns = c(23:24), rows = 8) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(23:24))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "planted02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_14_00,
#            begin = 2001,
#            end = 2009,
#            archive = "area_crops_2001-2009_l1_l2.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_14_01 <- schema_ind_14 %>%
#     setIDVar(name = "commodities", columns = c(26:38), rows = 9) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(26:38))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "planted03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_14_01,
#            begin = 2001,
#            end = 2009,
#            archive = "area_crops_2001-2009_l1_l2.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_15 <- setCluster(id = "year", left = 1, top = 25, height = 38) %>%
#     setFilter(rows = .find("Union..", col = 1, invert = TRUE)) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2009") %>%
#     setIDVar(name = "commodities", columns = c(2:9, 11:12, 14, 17:21), rows = 10) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2:9, 11:12, 14, 17:21))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "planted",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_15,
#            begin = 2009,
#            end = 2009,
#            archive = "area_crops_2001-2009_l1_l2.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_15_00 <- schema_ind_15 %>%
#     setIDVar(name = "commodities", columns = c(23:24), rows = 8) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(23:24))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "planted02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_15_00,
#            begin = 2009,
#            end = 2009,
#            archive = "area_crops_2001-2009_l1_l2.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_15_01 <- schema_ind_15 %>%
#     setIDVar(name = "commodities", columns = c(26:38), rows = 9) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(26:38))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "planted03",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_15_01,
#            begin = 2009,
#            end = 2009,
#            archive = "area_crops_2001-2009_l1_l2.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_16 <-  setCluster(id = "year", left = 1, top = 16, height = 38) %>%
#     setFilter(rows = .find("Union..", col = 1, invert = TRUE)) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2010") %>%
#     setIDVar(name = "commodities", columns = c(2:9, 11:13, 16:20), rows = 11) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2:9, 11:13, 16:20))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "planted",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_16,
#            begin = 2010,
#            end = 2010,
#            archive = "area_crop_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_16_00 <- schema_ind_16 %>%
#     setIDVar(name = "commodities", columns = c(26:38), rows = 10) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(26:38))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "planted02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_16_00,
#            begin = 2010,
#            end = 2010,
#            archive = "area_crop_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_17 <- setCluster(id = "year", left = 1, top = 14, height = 38) %>%
#     setFilter(rows = .find("Union..", col = 1, invert = TRUE)) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2011") %>%
#     setIDVar(name = "commodities", columns = c(2:9, 11:13, 16:20), rows = 9) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2:9, 11:13, 16:20))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "planted",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_17,
#            begin = 2011,
#            end = 2011,
#            archive = "area_crop_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_17_00 <- schema_ind_17 %>%
#     setIDVar(name = "commodities", columns = c(22:36), rows = 8) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(22:36))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "planted02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_17_00,
#            begin = 2011,
#            end = 2011,
#            archive = "area_crop_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_18 <- schema_ind_17 %>%
#     setCluster(id = "year", left = 1, top = 13, height = 38) %>%
#     setIDVar(name = "year", value = "2012") %>%
#     setIDVar(name = "commodities", columns = c(2:9, 11:13, 16:20), rows = 9) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2:9, 11:13, 16:20))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "planted",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_18,
#            begin = 2012,
#            end = 2012,
#            archive = "area_crop_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_18_00 <- schema_ind_18 %>%
#     setIDVar(name = "commodities", columns = c(22:35), rows = 8) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(22:35))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "planted",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_18_00,
#            begin = 2012,
#            end = 2012,
#            archive = "area_crop_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_19 <- schema_ind_18 %>%
#     setIDVar(name = "year", value = "2013")
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "planted",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_19,
#            begin = 2013,
#            end = 2013,
#            archive = "area_crop_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_19_00 <- schema_ind_18_00 %>%
#     setIDVar(name = "year", value = "2013")
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "planted02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_19_00,
#            begin = 2013,
#            end = 2013,
#            archive = "area_crop_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   # Jute and Mesta each have a column with ObsVar, but they also appear together in other column. The combined column is in the schema. Maybe it should be removed.
#   schema_ind_20 <- setCluster(id = "year", left = 1, top = 8, height = 29) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2014") %>%
#     setIDVar(name = "commodities", columns = c(2:10, 12:16, 19:27, 29:45), rows = 6) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2:10, 12:16, 19:27, 29:45))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "planted",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_20,
#            begin = 2014,
#            end = 2014,
#            archive = "area_crop_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   # Jute and Mesta each have a column with ObsVar, but they also appear together in other column. The combined column is in the schema. Maybe it should be removed.
#   schema_ind_21 <- setCluster(id = "year", left = 1, top = 9, height = 30) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2015") %>%
#     setIDVar(name = "commodities", columns = c(2:16, 19:27, 29:36), rows = 7) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2:16, 19:27, 29:36))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "planted",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_21,
#            begin = 2015,
#            end = 2015,
#            archive = "area_crop_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   # Jute and Mesta each have a column with ObsVar, but they also appear together in other column. The combined column is in the schema. Maybe it should be removed.
#   schema_ind_22 <- setCluster(id = "year", left = 1, top = 9, height = 23) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2016") %>%
#     setIDVar(name = "commodities", columns = c(2:16, 19:27, 29:35), rows = 7) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2:16, 19:27, 29:35))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "planted",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_22,
#            begin = 2016,
#            end = 2016,
#            archive = "area_crop_2002-2016_l1_l2.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.2_0.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
# # From all tables I extracted separately "Cotton" and "Jute and Mesta", because they have different units.
#   # Cotton units are original in 1000 bales (each bale is 170kg), that is why the factor for Cotton is 170.
#   #
#   # Jute and Mesta units are original in 1000 bales (each bale is 180kg), that is why the factor for Jute and Mesta is 180.
#
#   #schema not working
#   schema_ind_23 <- setCluster(id = "al1", left = 1, top = 12, height = 10) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "year", columns = 1) %>%
#     setIDVar(name = "commodities", columns = c(2:9, 11:12, 14), rows = 9) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(2:9, 11:12, 14))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "production",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_23,
#            begin = 2001,
#            end = 2009,
#            archive = "production_2001-2009.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_23_00 <- schema_ind_23 %>%
#     setIDVar(name = "commodities", columns = c(17:21, 27:38), rows = 8) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(17:21, 27:38))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "production02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_23_00,
#            begin = 2001,
#            end = 2009,
#            archive = "production_2001-2009.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_24 <- setCluster(id = "al1", left = 23, top = 12, height = 10) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "year", columns = 1) %>%
#     setIDVar(name = "commodities", columns = 23, rows = 6) %>%
#     setObsVar(name = "production", factor = 170, columns = 23)
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "prodCotton",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_24,
#            begin = 2001,
#            end = 2009,
#            archive = "production_2001-2009.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_25 <- setCluster(id = "commodities", left = c(24, 26), top = 12, height = 10) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "year", columns = 1) %>%
#     setIDVar(name = "commodities", columns = c(24, 26), rows = c(6, 8)) %>%
#     setObsVar(name = "production", factor = 180, columns = c(24, 26))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "prodJuteMesta",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_25,
#            begin = 2001,
#            end = 2009,
#            archive = "production_2001-2009.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_26 <- setCluster(id = "year", left = 1, top = 24, height = 38) %>%
#     setFilter(rows = .find("Union..", col = 1, invert = TRUE)) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2009") %>%
#     setIDVar(name = "commodities", columns = c(2:9, 11:12, 14), rows = 9) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(2:9, 11:12, 14))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "production",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_26,
#            begin = 2009,
#            end = 2009,
#            archive = "production_2001-2009.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_26_00 <- schema_ind_26 %>%
#     setIDVar(name = "commodities", columns = c(17:21, 27:38), rows = 8) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(17:21, 27:38))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "production02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_26_00,
#            begin = 2009,
#            end = 2009,
#            archive = "production_2001-2009.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_27 <- schema_ind_26 %>%
#     setIDVar(name = "commodities", columns = 23, rows = 6) %>%
#     setObsVar(name = "production", factor = 170, columns = 23)
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "prodCotton",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_27,
#            begin = 2009,
#            end = 2009,
#            archive = "production_2001-2009.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_28 <- schema_ind_26 %>%
#     setCluster(id = "commodities", left = c(24, 26), top = 24) %>%
#     setIDVar(name = "commodities", columns = c(24, 26), rows = c(6, 8)) %>%
#     setObsVar(name = "production", factor = 180, columns = c(24, 26))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "prodJuteMesta",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_28,
#            begin = 2009,
#            end = 2009,
#            archive = "production_2001-2009.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3_2.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_ind_29 <- setCluster(id = "al1", left = 1, top = 13, height = 17) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "year", columns = 1) %>%
#     setIDVar(name = "commodities", columns = c(2:9, 11:13, 16:20, 25:36), rows = 10) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(2:9, 11:13, 16:20, 25:36))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "production",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_29,
#            begin = 2002,
#            end = 2017,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_30 <- schema_ind_29 %>%
#     setIDVar(name = "commodities", columns = 22, rows = 10) %>%
#     setObsVar(name = "production", factor = 170, columns = 22)
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "prodCotton",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_30,
#            begin = 2002,
#            end = 2017,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_31 <- schema_ind_29 %>%
#     setIDVar(name = "commodities", rows = 10, columns = c(23:24)) %>%
#     setObsVar(name = "production", factor = 180, columns = c(23:24))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "prodJuteMesta",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_31,
#            begin = 2002,
#            end = 2017,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_ind_32 <- setCluster(id = "year", left = 1, top = 16, height = 38) %>%
#     setFilter(rows = .find("Union..", col = 1, invert = TRUE)) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2010") %>%
#     setIDVar(name = "commodities", columns = c(2:9, 11:13, 16:20, 25:36), rows = 10) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(2:9, 11:13, 16:20, 25:36))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "production",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_32,
#            begin = 2010,
#            end = 2010,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_33 <- schema_ind_32 %>%
#     setIDVar(name = "commodities", columns = 22, rows = 10) %>%
#     setObsVar(name = "production", factor = 170, columns = 22)
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "prodCotton",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_33,
#            begin = 2010,
#            end = 2010,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_34 <- schema_ind_32 %>%
#     setIDVar(name = "commodities", columns = c(23, 24), rows = 10) %>%
#     setObsVar(name = "production", factor = 180, columns = c(23, 24))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "prodJuteMesta",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_34,
#            begin = 2010,
#            end = 2010,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_35 <- schema_ind_32 %>%
#     setIDVar(name = "year", value = "2011")
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "production",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_35,
#            begin = 2011,
#            end = 2011,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_36 <- schema_ind_35 %>%
#     setIDVar(name = "commodities", columns = 22, rows = 10) %>%
#     setObsVar(name = "production", factor = 170, columns = 22)
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "prodCotton",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_36,
#            begin = 2011,
#            end = 2011,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_37 <- schema_ind_35 %>%
#     setIDVar(name = "commodities", columns = c(23, 24), rows = 10) %>%
#     setObsVar(name = "production", factor = 180, columns = c(23, 24))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "prodJuteMesta",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_37,
#            begin = 2011,
#            end = 2011,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_38 <- schema_ind_32 %>%
#     setCluster(id = "year", left = 1, top = 15, height = 38) %>%
#     setIDVar(name = "year", value = "2012")
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "production",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_38,
#            begin = 2012,
#            end = 2012,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_39 <- schema_ind_38 %>%
#     setIDVar(name = "commodities", columns = 22, rows = 10) %>%
#     setObsVar(name = "production", factor = 170, columns = 22)
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "prodCotton",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_39,
#            begin = 2012,
#            end = 2012,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_40 <- schema_ind_38 %>%
#     setIDVar(name = "commodities", columns = c(23, 24), rows = 10) %>%
#     setObsVar(name = "production", factor = 180, columns = c(23, 24))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "prodJuteMesta",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_40,
#            begin = 2012,
#            end = 2012,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_41 <- schema_ind_38 %>%
#     setIDVar(name = "year", value = "2013")
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "production",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_41,
#            begin = 2013,
#            end = 2013,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_42 <- schema_ind_41 %>%
#     setIDVar(name = "commodities", columns = 22, rows = 10) %>%
#     setObsVar(name = "production", factor = 170, columns = 22)
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "prodCotton",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_42,
#            begin = 2013,
#            end = 2013,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_43 <- schema_ind_41 %>%
#     setIDVar(name = "commodities", columns = c(23, 24), rows = 10) %>%
#     setObsVar(name = "production", factor = 180, columns = c(23, 24))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "prodJuteMesta",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_43,
#            begin = 2013,
#            end = 2013,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_ind_44 <- setCluster(id = "year", left = 1, top = 8, height = 22) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2014") %>%
#     setIDVar(name = "commodities", columns = c(2:10, 12:16, 19:29, 34:46), rows = 6) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(2:10, 12:16, 19:29, 34:46))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "production",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_44,
#            begin = 2014,
#            end = 2014,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_45 <- schema_ind_44 %>%
#     setIDVar(name = "commodities", columns = 30, rows = 6) %>%
#     setObsVar(name = "production", factor = 170, columns = 30)
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "prodCotton",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_45,
#            begin = 2014,
#            end = 2014,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_46 <- schema_ind_44 %>%
#     setIDVar(name = "commodities", columns = c(31, 32), rows = 6) %>%
#     setObsVar(name = "production", factor = 180, columns = c(31, 32))
#
#   regTable(nation - "ind",
#            level = 2,
#            subset = "prodJuteMesta",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_46,
#            begin = 2014,
#            end = 2014,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_ind_47 <- setCluster(id = "year", left = 1, top = 8, height = 22) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2015") %>%
#     setIDVar(name = "commodities", columns = c(2:15, 19:27, 29, 34:38), rows = 6) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(2:15, 19:27, 29, 34:38))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "production",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_47,
#            begin = 2015,
#            end = 2015,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_48 <- schema_ind_47 %>%
#     setIDVar(name = "commodities", columns = 30, rows = 6) %>%
#     setObsVar(name = "production", factor = 170, columns = 30)
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "prodCotton",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_48,
#            begin = 2015,
#            end = 2015,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_49 <- schema_ind_47 %>%
#     setIDVar(name = "commodities", columns = c(31, 32), rows = 6) %>%
#     setObsVar(name = "production", factor = 180, columns = c(31, 32))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "prodJuteMesta",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_49,
#            begin = 2015,
#            end = 2015,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#
#   schema_ind_50 <- setCluster(id = "year", left = 1, top = 9, height = 23) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2016") %>%
#     setIDVar(name = "commodities", columns = c(2:15, 19:27, 29, 34:39), rows = 7) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(2:15, 19:27, 29, 34:39))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "production",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_50,
#            begin = 2016,
#            end = 2016,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_51 <- schema_ind_50 %>%
#     setIDVar(name = "commodities", columns = 30, rows = 7) %>%
#     setObsVar(name = "production", factor = 170, columns = 30)
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "prodCotton",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_51,
#            begin = 2016,
#            end = 2016,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_52 <- schema_ind_50 %>%
#     setIDVar(name = "commodities", columns = c(31, 32), rows = 7) %>%
#     setObsVar(name = "production", factor = 180, columns = c(31, 32))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "prodJuteMesta",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_52,
#            begin = 2016,
#            end = 2016,
#            archive = "production_l1_l2_2002_2017.xlsx",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-8.3%20.xlsx",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2017/177",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_53 <- setCluster(id = "commodities", left = 1, top = 16, height = 38) %>%
#     setFilter(rows = .find("Union..", col = 1, invert = TRUE)) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", columns = c(2:5, 7, 9), rows = 10) %>%
#     setIDVar(name = "commodities", value = "flowers") %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2:4)) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(5, 7, 9))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "flowers",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_53,
#            begin = 2007,
#            end = 2009,
#            archive = "flowers_l2_2007_2009.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-9.3.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/178",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_54 <- setCluster(id = "commodities", left = 1, top = 12, height = 38) %>%
#     setFilter(rows = .find("Union..", col = 1, invert = TRUE)) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", columns = c(2, 5, 8, 11, 14, 17, 20, 23), rows = 8) %>%
#     setIDVar(name = "commodities", value = "flowers") %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2, 5, 8, 11, 14, 17, 20, 23)) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(3, 6, 9, 12, 15, 18, 21, 24))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "flowers",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_54,
#            begin = 2008,
#            end = 2015,
#            archive = "flowers_l2_2008_2015.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table9.3.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2016/178",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   # both table for Spices have units for yield. Both tables note that units are tonne/hectare. There is some differencies between the values.
#   # For example: table 2008-2009 has value 5000, table 2009-2015 have value 5.
#   schema_ind_55 <- setCluster(id = "al1", left = 1, top = 14, height = 17) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "year", columns = c(2, 6), rows = 8) %>%
#     setIDVar(name = "commodities", columns = 1) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2, 6)) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(3, 7)) %>%
#     setObsVar(name = "yield", factor = 1000, columns = c(4, 8))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "spices",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_55,
#            begin = 2008,
#            end = 2009,
#            archive = "spices_l1_2008_2009.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-9.4.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/178",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_56 <- setCluster(id = "al1", left = 1, top = 10, height = 17) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "year", columns = c(2, 5, 8, 11, 14, 17, 20), rows = 8) %>%
#     setIDVar(name = "commodities", columns = 1) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2, 5, 8, 11, 14, 17, 20)) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(3, 6, 9, 12, 15, 18, 21)) %>%
#     setObsVar(name = "yield", factor = 1000, columns = c(4, 7, 10, 13, 16, 19, 22))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "spices",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_56,
#            begin = 2009,
#            end = 2015,
#            archive = "spices_l1_2009_2015.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table9.4.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2016/178",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_57 <- setCluster(id = "year", left = 1, top = 23, height = 38) %>%
#     setFilter(rows = .find("Union..", col = 1, invert = TRUE)) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2009") %>%
#     setIDVar(name = "commodities", columns = c(4:11), rows = 7) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(4, 6, 8, 10)) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(5, 7, 9, 11))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "nuts",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_57,
#            begin = 2009,
#            end = 2009,
#            archive = "NUTS_l2_2009.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-9.7.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/178",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   # schema not working, not sure why.
#   schema_ind_58 <- setCluster(id = "al1", left = 1, top = 10, height = 38) %>%
#     setFilter(rows = .find("Union..", col = 1, invert = TRUE)) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", columns = c(2:61), rows = 8) %>%
#     setIDVar(name = "commodities",  columns = c(7, 19, 31, 43, 55), rows = 6) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2:7, 14:19, 26:31, 38:43, 50:55)) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(8:13, 20:25, 32:37, 44:49, 56:61))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "nuts",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_58,
#            begin = 2010,
#            end = 2015,
#            archive = "NUTS_l2_2010_2015_l1_2002_2015.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table9.7.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2016/178",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_59 <- setCluster(id = "al1", left = 1, top = 9, height = 15) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "year", columns = 1) %>%
#     setIDVar(name = "commodities", columns = c(2:11), rows = 7) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2, 4, 6, 8, 10)) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(3, 5, 7, 9, 11))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "nuts",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_59,
#            begin = 2002,
#            end = 2015,
#            archive = "NUTS_l2_2010_2015_l1_2002_2015.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table9.7.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2016/178",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_60 <- setCluster(id = "year", left = 2, top = 23, height = 38) %>%
#     setFilter(rows = .find("Union..", col = 1, invert = TRUE)) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2009") %>%
#     setIDVar(name = "commodities", columns = c(2:15), rows = 7) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2, 4, 6, 8, 10, 12, 14)) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(3, 5, 7, 9, 11, 13, 15))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "fruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_60,
#            begin = 2009,
#            end = 2009,
#            archive = "fruits_l2_2009.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-9.5.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/178",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_60_00 <- schema_ind_60 %>%
#     setCluster(id = "year", left = 4, top = 112, height = 38) %>%
#     setIDVar(name = "commodities", columns = c(4:13), rows = 96) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(4, 6, 8, 10, 12)) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(5, 7, 9, 11, 13))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "fruits02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_60_00,
#            begin = 2009,
#            end = 2009,
#            archive = "fruits_l2_2009.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-9.5.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/178",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_61 <- setCluster(id = "al1", left = 1, top = 12, height = 38) %>%
#     setFilter(rows = .find("Union..", col = 1, invert = TRUE)) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", columns = c(2:145), rows = 8) %>%
#     setIDVar(name = "commodities", columns = .find(is.character, row = 7), rows = 7) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100, 102, 104, 106, 108, 110, 112, 114, 116, 118, 120, 122, 124, 126, 128, 130, 132, 134, 136, 138, 140, 142, 144), top = 5) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 133, 135, 137, 139, 141, 143, 145), top = 6)
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "fruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_61,
#            begin = 2010,
#            end = 2015,
#            archive = "fruits_detailed_l2_2010-2015_l1_2002_2015.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table9.5.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2016/178",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_62 <- setCluster(id = "al1", left = 1, top = 9, height = 15) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "year", columns = 1) %>%
#     setIDVar(name = "commodities", columns = c(2:27), rows = 7) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26)) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "fruits",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_62,
#            begin = 2002,
#            end = 2015,
#            archive = "fruits_detailed_l2_2010-2015_l1_2002_2015.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table9.5.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2016/178",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_63 <- setCluster(id = "year", left = 4, top = 23, height = 38) %>%
#     setFilter(rows = .find("Union..", col = 1, invert = TRUE)) %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", value = "2009") %>%
#     setIDVar(name = "commodities", columns = c(4:15), rows = 7) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(4, 6, 8, 10, 12, 14)) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(5, 7, 9, 11, 13, 15))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "vegetables",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_630,
#            begin = 2009,
#            end = 2009,
#            archive = "veg_detailed_l2_2009.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-9.6.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/178",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_63_00 <- schema_ind_63 %>%
#     setCluster(id = "year", left = 4, top = 112, height = 38) %>%
#     setIDVar(name = "commodities", columns = c(4:13), rows = 96) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(4, 6, 8, 10, 12)) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(5, 7, 9, 11, 13))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "vegetables02",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_63_00,
#            begin = 2009,
#            end = 2009,
#            archive = "veg_detailed_l2_2009.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-9.6.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/178",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_64 <- setCluster(id = "al1", left = 1, top = 9, height = 14) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "year", columns = 1) %>%
#     setIDVar(name = "commodities", columns = c(2:23), rows = 7) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22)) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23))
#
#   regTable(nation = "ind",
#            level = 1,
#            subset = "vegetables",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_64,
#            begin = 2002,
#            end = 2015,
#            archive = "veg_detailed_l2_2010-2015_l1_2002_2015.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table9.6.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2016/178",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)
#
#   schema_ind_65 <- setCluster(id = "al1", left = 1, top = 13, height = 38) %>%
#     setFilter(rows = .find("Union..", col = 1, invert = TRUE)) %>%
#     setIDVar(name = "al1", value = "India") %>%
#     setIDVar(name = "al2", columns = 1) %>%
#     setIDVar(name = "year", columns = c(2:133), rows = 8) %>%
#     setIDVar(name = "commodities", columns = .find(is.character, row = 7), rows = 7) %>%
#     setObsVar(name = "planted", factor = 1000, columns = c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100, 102, 104, 106, 108, 110, 112, 114, 116, 118, 120, 122, 124, 126, 128, 130, 132)) %>%
#     setObsVar(name = "production", factor = 1000, columns = c(3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 133))
#
#   regTable(nation = "ind",
#            level = 2,
#            subset = "vegetables",
#            dSeries = ds[1],
#            gSeries = gs[1],
#            schema = schema_ind_65,
#            begin = 2010,
#            end = 2015,
#            archive = "veg_detailed_l2_2010-2015_l1_2002_2015.xls",
#            archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table9.6.xls",
#            updateFrequency = "unknown",
#            nextUpdate = "unknown",
#            metadataLink = "http://mospi.nic.in/statistical-year-book-india/2016/178",
#            metadataPath = "unknown",
#            update = updateTables,
#            overwrite = overwriteTables)

  normTable(pattern = paste0("crops*", ds[1]),
            ontoMatch = "crop",
            beep = 10)

}

if(build_livestock){
  ## livestock ----

  ### indis ----


  ### mospi ----
  # # Total numbers here are for poultry!, not for all livestock.
  # schema_ind_01 <- setCluster(id = "al1", left = 1, top = 18, height = 38) %>%
  #   setFilter(rows = .find("Union..", col = , invert = TRUE1)) %>%
  #   setIDVar(name = "al1", value = "India") %>%
  #   setIDVar(name = "al2", columns = 1) %>%
  #   setIDVar(name = "year", columns = 1, rows = 17, split = ".*(?=\\()") %>%
  #   setIDVar(name = "commodities", rows = 7, columns = c(2:12, 14)) %>%
  #   setObsVar(name = "headcount", factor = 1000, columns = c(2:12, 14))
  #
  # regTable(nation = "ind",
  #          level = 2,
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ind_01,
  #          begin = 2007,
  #          end = 2007,
  #          archive = "Livestock-2007-Table-10.1.xls",
  #          archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table-10.1.xls",
  #          updateFrequency = "quinquennial",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://mospi.nic.in/statistical-year-book-india/2011/179",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ind_02 <- schema_ind_01 %>%
  #   setIDVar(name = "year", columns = 1, rows = 17)
  # # mules and donkeys are recorded together for year 2012
  # regTable(nation = "ind",
  #          level = 2,
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ind_02,
  #          begin = 2012,
  #          end = 2012,
  #          archive = "Livestock-2012-Table 10.1.xls",
  #          archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table%2010.1.xls",
  #          updateFrequency = "quinquennial",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://mospi.nic.in/statistical-year-book-india/2015/179",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # schema_ind_03 <- setCluster(id = "al1", left = 1, top = 12, height = 5) %>%
  #   setIDVar(name = "al1", value = "India") %>%
  #   setIDVar(name = "year", columns = 1) %>%
  #   setIDVar(name = "commodities", rows = 8, columns = c(2:12, 14)) %>%
  #   setObsVar(name = "headcount", factor = 1000, columns = c(2:12, 14))
  #
  # regTable(nation = "ind",
  #          level = 1,
  #          subset = "livestock",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ind_03,
  #          begin = 2003,
  #          end = 2012,
  #          archive = "Livestock-2012-Table 10.1.xls",
  #          archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table%2010.1.xls",
  #          updateFrequency = "quinquennial",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://mospi.nic.in/statistical-year-book-india/2015/179",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)

  normTable(pattern = ,
            ontoMatch = "animal",
            beep = 10)

}

if(build_landuse){
  ## landuse ----

  ### indis ----

  ### mospi ----
  # # units are in sq km, we need a factor of 100 to convert to hectares
  # schema_ind_04 <- setCluster(id = "al1", left = 1, top = 14) %>%
  #   setIDVar(name = "al1", value = "India") %>%
  #   setIDVar(name = "year", columns = 2) %>%
  #   setIDVar(name = "commodities", value = "forest cover") %>%
  #   setObsVar(name = "area", factor = 100, columns = 5)
  #
  # regTable(nation = "ind",
  #          level = 1,
  #          subset = "forestCover",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ind_04,
  #          begin = 1987,
  #          end = 2015,
  #          archive = "forest_l1_l2.xlsx",
  #          archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table%2033.1.xlsx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://mospi.nic.in/statistical-year-book-india/2018/202",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)
  #
  # # For the years 2009, 2011, 2013 the value of forest cover recorded for State Andra Pradesh was a sum up for Andra Pradesh and Telangana.
  # # For the year 2015 the two values were separated.
  # # units are in sq km, we need a factor of 100 to convert to hectares
  # schema_ind_05 <- setCluster(id = "commodities", left = 1, top = 14, height = 39) %>%
  #   setFilter(rows = .find("Union..", col = 1, invert = TRUE)) %>%
  #   setIDVar(name = "al2", columns = 1) %>%
  #   setIDVar(name = "year", columns = c(2:5), rows = 13) %>%
  #   setIDVar(name = "commodities", value = "forest cover") %>%
  #   setObsVar(name = "area", factor = 100, columns = c(2:5))
  #
  # regTable(nation = "ind",
  #          level = 2,
  #          subset = "forestCover",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          schema = schema_ind_05,
  #          begin = 2009,
  #          end = 2015,
  #          archive = "forest_l1_l2.xlsx",
  #          archiveLink = "http://mospi.nic.in/sites/default/files/statistical_year_book_india_2015/Table%2033.1.xlsx",
  #          updateFrequency = "unknown",
  #          nextUpdate = "unknown",
  #          metadataLink = "http://mospi.nic.in/statistical-year-book-india/2018/202",
  #          metadataPath = "unknown",
  #          update = updateTables,
  #          overwrite = overwriteTables)

}
