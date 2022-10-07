# script arguments ----
#
thisNation <- "Oman"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- FALSE
overwriteTables <- FALSE


# register dataseries ----
#
ds <- c("nsci")
gs <- c("")

regDataseries(name = ds[1],
              description = "National Centre for Statistics and Information",
              homepage = "https://www.ncsi.gov.om/Pages/NCSI.aspx",
              licence_link = "",
              licence_path = "",
              update = updateTables)


# register geometries ----
#
regGeometry(gSeries = gs[],
            level = 2,
            nameCol = "",
            archive = "|",
            archiveLink = "",
            nextUpdate = "",
            updateFrequency = "",
            update = updateTables)


# register census tables ----
#
schema_1 <- setCluster() %>%
  setFormat() %>%
  setIDVar(name = "al2", ) %>%
  setIDVar(name = "year", ) %>%
  setIDVar(name = "commodities", ) %>%
  setObsVar(name = "planted", unit = "ha", )

regTable(nation = "", # or any other "class = value" combination from the gazetteer
         level = ,
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
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              al1 = thisNation,
#              outType = "gpkg",
#              update = updateTables)

normGeometry(pattern = gs[],
             # al1 = thisNation,
             outType = "gpkg",
             update = updateTables)


# normalise census tables ----
#
## in case the output shall be examined before writing into the DB
# testing <- normTable(nation = thisNation,
#                      update = FALSE,
#                      keepOrig = TRUE)
#
# only needed if FAO datasets have not been integrated before
# normTable(pattern = "fao",
#           al1 = thisNation,
#           outType = "rds",
#           update = updateTables)

normTable(pattern = ds[],
          # al1 = thisNation,
          outType = "rds",
          update = updateTables)
