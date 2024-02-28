# script arguments ----
#
# see "97_oldCode.R"
thisNation <- "Mexico"

updateTables <- FALSE
overwriteTables <- FALSE

ds <- c("")
gs <- c("")



# Hi all,
#
#
# I ve added various folders, data tables, and data-containing PDFs from the Mexican National Forest Inventory to
#  "I:\MAS\01_projects\LUCKINet\01_data\point_data\incoming\Priority datasets\INFyS - Mexican National Forest Inventory".
#  The subfolders "Plot data ..." contain various tables and explanatory metadata, most importantly, thousands of annual
#  forest plots across Mexico with plenty of metadata on those plots.
#
#
# Extracting all the relevant information from those will require a bit of digging, but it looks like these data should be relevant
# for each of your current focal projects:
#
# 1) For Ruben, because they contain many plot occurrences of specific forest and some other ecosystem types, and of plantations
# (the PDF "Anexo 6 clasificacion vegetacion" in the Annexes subfolder has an overview of the distinguished types)
#
# 2) For Steffen, because they contain subnational statistical data on forestry (mostly in PDFs), as well as point occurrences of
# different forest uses (also on some agricultural uses - e.g., check the sub-table "Impactos_ambientales" within the "INFyS_200..."
# Excel files)
#
# 2) For Caterina, because the plots inform on different land-cover types (mostly but not exclusively forests) - there also seems to
# be info on sub-pixel areas of different land-cover types within those plots (e.g., check the sub-tables "Cobertura..." within the
# "INFyS_200..." Excel files)
#
# Cheers,
# Carsten
#
# https://www.gob.mx/siap/acciones-y-programas/produccion-agricola-33119
# https://en.www.inegi.org.mx/temas/agricultura/


# 1. register dataseries ----
#
regDataseries(name = ds[],
              description = "",
              homepage = "",
              licence_link = "",
              licence_path = "",
              update = updateTables)


# 2. register geometries ----
#
regGeometry(nation = !!thisNation, # or any other "class = value" combination from the gazetteer
            gSeries = gs[],
            level = 2,
            nameCol = "",
            archive = "|",
            archiveLink = "",
            nextUpdate = "",
            updateFrequency = "",
            update = updateTables)


# 3. register census tables ----
#
## crops ----
if(build_crops){

}

## livestock ----
if(build_livestock){

}

## landuse ----
if(build_landuse){

}

schema_1 <- setCluster() %>%
  setFormat() %>%
  setIDVar(name = "al2", ) %>%
  setIDVar(name = "year", ) %>%
  setIDVar(name = "item", ) %>%
  setObsVar(name = "planted", unit = "ha", )

regTable(nation = !!thisNation, # or any other "class = value" combination from the gazetteer
         label = ,
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
         metadataPath = "",
         metadataLink = "",
         update = updateTables,
         overwrite = overwriteTables)


#### test schemas

# myRoot <- paste0(dataDir, "censusDB/adb_tables/stage2/")
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
#
# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script


# 4. normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg",
#              update = updateTables)

normGeometry(pattern = gs[],
             outType = "gpkg",
             update = updateTables)


# 5. normalise census tables ----
#
## in case the output shall be examined before writing into the DB
# testing <- normTable(nation = thisNation,
#                      update = FALSE,
#                      keepOrig = TRUE)
#
# only needed if FAO datasets have not been integrated before
# normTable(pattern = "fao",
#           outType = "rds",
#           update = updateTables)

normTable(pattern = ds[],
          ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)
