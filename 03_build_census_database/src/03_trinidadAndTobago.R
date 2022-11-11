# script arguments ----
#
thisNation <- "Trinidad and Tobago"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("faoDatalab", "spam")
gs <- c("gadm", "spam")


# register geometries ----
#

# register census tables ----
#
# faoDatalab ----
# The table has -Tobago, Trinidad- as two regions. "Tobago" is a gadm geometry, but "Trinidad" is not
# Thus some commodities have two ObsVar for the production. The table can be normalised on level 1.
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
         update = updateTables,
         overwrite = overwriteTables)

# spam ----
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Trinidad and Tobago",
#          level = 2,
#          subset = "pigs",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "selectedCrops",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "Trinidad",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "Tobago",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Tobago Agri Report- Tables 1-7.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "Forest",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2004,
#          end = 2004,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "Trinidad",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "Tobago",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Tobago Agri Report- Tables 1-7.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "flowers",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "pigs",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "smallRuminants",
#          dSeries = ds[2],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)


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
