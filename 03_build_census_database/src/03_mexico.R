# Hi all,
#
#
# I ve added various folders, data tables, and data-containing PDFs from the Mexican National Forest Inventory to "I:\MAS\01_projects\LUCKINet\01_data\point_data\incoming\Priority datasets\INFyS - Mexican National Forest Inventory". The subfolders "Plot data ..." contain various tables and explanatory metadata, most importantly, thousands of annual forest plots across Mexico with plenty of metadata on those plots.
#
#
# Extracting all the relevant information from those will require a bit of digging, but it looks like these data should be relevant for each of your current focal projects:
#
# 1) For Ruben, because they contain many plot occurrences of specific forest and some other ecosystem types, and of plantations (the PDF "Anexo 6 clasificacion vegetacion" in the Annexes subfolder has an overview of the distinguished types)
#
# 2) For Steffen, because they contain subnational statistical data on forestry (mostly in PDFs), as well as point occurrences of different forest uses (also on some agricultural uses - e.g., check the sub-table "Impactos_ambientales" within the "INFyS_200..." Excel files)
#
# 2) For Caterina, because the plots inform on different land-cover types (mostly but not exclusively forests) - there also seems to be info on sub-pixel areas of different land-cover types within those plots (e.g., check the sub-tables "Cobertura..." within the "INFyS_200..." Excel files)
#
# Cheers,
# Carsten

# script arguments ----
#
thisNation <- "Mexico"
assertSubset(x = thisNation, choices = countries$label) # ensure that nation is valid

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested


# register dataseries ----
#
ds <- c("spam")
gs <- c("spam")


regDataseries(name = ds[],
              description = "",
              homepage = "",
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

regTable(nation = "",
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

# spam----
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Mexico",
#          level = 3,
#          subset= "perm",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = schema_spam1,
#          begin = 2009,
#          end = 2009,
#          archive = "LAC.zip|AGRICOLA_SIAP_2009_2010_2011.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 3,
#          subset= "temp",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = schema_spam1,
#          begin = 2009,
#          end = 2009,
#          archive = "LAC.zip|AGRICOLA_SIAP_2009_2010_2011.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 3,
#          subset= "perm",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = schema_spam1,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|AGRICOLA_SIAP_2009_2010_2011.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 3,
#          subset= "temp",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = schema_spam1,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|AGRICOLA_SIAP_2009_2010_2011.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 3,
#          subset= "perm",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = schema_spam1,
#          begin = 2011,
#          end = 2011,
#          archive = "LAC.zip|AGRICOLA_SIAP_2009_2010_2011.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 3,
#          subset= "temp",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = schema_spam1,
#          begin = 2011,
#          end = 2011,
#          archive = "LAC.zip|AGRICOLA_SIAP_2009_2010_2011.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# schema_spam2 <- makeSchema()
#
# regTable(nation = "Mexico",
#          level = 2,
#          subset= "fallTemp",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = schema_spam2,
#          begin = 1980,
#          end = 2015,
#          archive = "LAC.zip|MAIZ_PV-OI_1980_2015.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 2,
#          subset= "springTemp",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = schema_spam2,
#          begin = 1980,
#          end = 2015,
#          archive = "LAC.zip|MAIZ_PV-OI_1980_2015.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 2,
#          subset= "springPerm",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = schema_spam2,
#          begin = 1980,
#          end = 2015,
#          archive = "LAC.zip|MAIZ_PV-OI_1980_2015.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 2,
#          subset= "fallPerm",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = schema_spam2,
#          begin = 1980,
#          end = 2015,
#          archive = "LAC.zip|MAIZ_PV-OI_1980_2015.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# schema_spam3 <- makeSchema()
#
# regTable(nation = "Mexico",
#          level = 2,
#          subset= "maize",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = schema_spam3,
#          begin = 1980,
#          end = 2014,
#          archive = "LAC.zip|maiz_grano_1980-2014.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)


# harmonise commodities ----
#
for(i in seq_along(ds)){

  tibble(new = get_variable(variable = "commodities", dataseries = ds[i])) %>%
    match_ontology(table = ., columns = "new", dataseries = ds[i], ontology = ontoDir)

}



# normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(nation = thisNation,
#              pattern = gs[],
#              outType = "gpkg",
#              update = updateTables)

normGeometry(nation = thisNation,
             pattern = gs[],
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
# normTable(nation = thisNation,
#           pattern = "fao",
#           source = "datID",
#           outType = "rds",
#           update = updateTables)

normTable(nation = thisNation,
          pattern = "",
          source = "datID",
          outType = "rds",
          update = updateTables)


