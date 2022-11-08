# script arguments ----
#
thisNation <- "Libya"
assertSubset(x = thisNation, choices = countries$label) # ensure that nation is valid

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested


# register dataseries ----
#
ds <- c("BSCL")
gs <- c("")


regDataseries(name = ds[1],
              description = "Bureau of Statistics and Census Libya",
              homepage = "http://bsc.ly/",
              notes = "data are public domain",
              update = updateTables)


# register geometries ----
#
# # UNITAR-UNOSAT
# regGeometry(nation = "Libya",
#             gSeries = "UNITAR-UNOSAT",
#             level = 1,
#             nameCol = "ADM0_EN",
#             archive = "ocha-romena-fd9fb749-5b68-4942-b5f9-115f20b5c00e.zip|lby_admbnda_adm0_unosat_lbsc_20180507.shp",
#             archiveLink = "",
#             updateFrequency = "unknown",
#             update = myUpdate)
# regGeometry(nation = "Libya",
#             gSeries = "UNITAR-UNOSAT",
#             level = 2,
#             nameCol = "ADM1_EN",
#             archive = "ocha-romena-fd9fb749-5b68-4942-b5f9-115f20b5c00e.zip|lby_admbnda_adm1_unosat_lbsc_20180507.shp",
#             archiveLink = "",
#             updateFrequency = "unknown",
#             update = myUpdate)
# regGeometry(nation = "Libya",
#             gSeries = "UNITAR-UNOSAT",
#             level = 3,
#             nameCol = "ADM2_EN",
#             archive = "ocha-romena-fd9fb749-5b68-4942-b5f9-115f20b5c00e.zip|lby_admbnda_adm2_unosat_lbsc_20180507.shp",
#             archiveLink = "",
#             updateFrequency = "unknown",
#             update = myUpdate)


# 3. register census tables ----
#
schema_1 <- setCluster() %>%
  setHeader() %>%
  setFormat() %>%
  setIDVar(name = "al2", ) %>%
  setIDVar(name = "year", ) %>%
  setIDVar(name = "commodities", ) %>%
  setObsVar(name = "planted", unit = "ha", )

regTable(level = ,
         subset = "",
         dSeries = ds[],
         gSeries = gs[],
         schema = ,
         begin = ,
         end = ,
         archive = "",
         archiveLink = "",
         updateFrequency = "",
         nextUpdate = "",
         metadataLink = "",
         metadataPath = "",
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



