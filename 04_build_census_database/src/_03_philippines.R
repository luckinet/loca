# script arguments ----
#
thisNation <- "Philippines"

updateTables <- FALSE
overwriteTables <- FALSE

ds <- c("psa")
gs <- c("gadm", "phillgis")


# register dataseries ----
#
regDataseries(name = ds[1],
              description = "Philippine Statistics Authority",
              homepage = "https://psa.gov.ph/",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)

regDataseries(name = gs[2],
              description = "Philippine GIS Data Clearinghouse",
              homepage = "http://philgis.org/",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)


# register geometries ----
#
## phillgis ----
regGeometry(nation = "Philippines",
            gSeries = gs[2],
            level = 4,
            nameCol = "REGION|PROVINCE|NAME_2",
            archive = "philippines.zip|MuniCities.shp",
            archiveLink = "http://philgis.org/country-vector-and-raster-datasets",#
            nextUpdate = "",
            updateFrequency = "notPlanned",
            update = TRUE)

regGeometry(nation = "Philippines",
            gSeries = gs[2],
            level = 3,
            nameCol = "REGION|PROVINCE",
            archive = "philippines.zip|Provinces.shp",
            archiveLink = "http://philgis.org/country-vector-and-raster-datasets",
            nextUpdate = "",
            updateFrequency = "notPlanned",
            update = TRUE)

regGeometry(nation = "Philippines",
            gSeries = gs[2],
            level = 2,
            nameCol = "REGION",
            archive = "philippines.zip|Regions.shp",
            archiveLink = "http://philgis.org/country-vector-and-raster-datasets",
            nextUpdate = "",
            updateFrequency = "notPlanned",
            update = TRUE)


# register census tables ----
#
## psa ----
regTable(nation = "phl",
         subset = "PaleyCornPlantedArea",
         level = 3,
         dSeries = ds[1],
         gSeries = gs[2],
         schema = ,
         begin = 1987,
         end = 2018,
         archive = "philippines.zip|2E4EAHC0.csv",
         archiveLink = "http://openstat.psa.gov.ph/PXWeb/pxweb/en/DB/DB__2E__CS/?tablelist=true&rxid=bdf9d8da-96f1-4100-ae09-18cb3eaeb313",
         updateFrequency = "unknown",
         nextUpdate = "",
         metadataLink = "http://openstat.psa.gov.ph/Metadata/Agriculture-Forestry-Fisheries/Crops",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "phl",
         subset = "PlantedHarvestedArea",
         level = 3,
         dSeries = ds[1],
         gSeries = gs[2],
         schema = ,
         begin = 2004,
         end = 2018,
         archive = "philippines.zip|2E4EAHO0.csv",
         archiveLink = "http://openstat.psa.gov.ph/PXWeb/pxweb/en/DB/DB__2E__CS/?tablelist=true&rxid=bdf9d8da-96f1-4100-ae09-18cb3eaeb313",
         updateFrequency = "unknown",
         nextUpdate = "",
         metadataLink = "http://openstat.psa.gov.ph/Metadata/Agriculture-Forestry-Fisheries/Crops",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "phl",
         subset = "PlantedHarvestedArea",
         level = 3,
         dSeries = ds[1],
         gSeries = gs[2],
         schema = ,
         begin = 1990,
         end = 2003,
         archive = "philippines.zip|2E4EAHO0(1).csv",
         archiveLink = "http://openstat.psa.gov.ph/PXWeb/pxweb/en/DB/DB__2E__CS/?tablelist=true&rxid=bdf9d8da-96f1-4100-ae09-18cb3eaeb313",
         updateFrequency = "unknown",
         nextUpdate = "",
         metadataLink = "http://openstat.psa.gov.ph/Metadata/Agriculture-Forestry-Fisheries/Crops",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "phl",
         subset = "Production",
         level = 3,
         dSeries = ds[1],
         gSeries = gs[2],
         schema = ,
         begin = 2004,
         end = 2018,
         archive = "philippines.zip|2E4EVCP1.csv",
         archiveLink = "http://openstat.psa.gov.ph/PXWeb/pxweb/en/DB/DB__2E__CS/?tablelist=true&rxid=bdf9d8da-96f1-4100-ae09-18cb3eaeb313",
         updateFrequency = "unknown",
         nextUpdate = "",
         metadataLink = "http://openstat.psa.gov.ph/Metadata/Agriculture-Forestry-Fisheries/Crops",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "phl",
         subset = "Production",
         level = 3,
         dSeries = ds[1],
         gSeries = gs[2],
         schema = ,
         begin = 1990,
         end = 2003,
         archive = "philippines.zip|2E4EVCP1.csv(1).csv",
         archiveLink = "http://openstat.psa.gov.ph/PXWeb/pxweb/en/DB/DB__2E__CS/?tablelist=true&rxid=bdf9d8da-96f1-4100-ae09-18cb3eaeb313",
         updateFrequency = "unknown",
         nextUpdate = "",
         metadataLink = "http://openstat.psa.gov.ph/Metadata/Agriculture-Forestry-Fisheries/Crops",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "phl",
         subset = "Grazing",
         level = 1,
         dSeries = ds[1],
         gSeries = gs[2],
         schema = ,
         begin = 1950,
         end = 2019,
         archive = "philippines.zip|2E4FILP0.csv",
         archiveLink = "http://openstat.psa.gov.ph/PXWeb/pxweb/en/DB/DB__2E__CS/?tablelist=true&rxid=bdf9d8da-96f1-4100-ae09-18cb3eaeb313",
         updateFrequency = "unknown",
         nextUpdate = "",
         metadataLink = "http://openstat.psa.gov.ph/Metadata/Agriculture-Forestry-Fisheries/Livestock",
         metadataPath = "unavailable",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "phl",
         subset = "Grazing",
         level = 3,
         dSeries = ds[1],
         gSeries = gs[2],
         schema = ,
         begin = 1994,
         end = 2019,
         archive = "philippines.zip|2E4FINL0.csv",
         archiveLink = "http://openstat.psa.gov.ph/PXWeb/pxweb/en/DB/DB__2E__CS/?tablelist=true&rxid=bdf9d8da-96f1-4100-ae09-18cb3eaeb313",
         updateFrequency = "unknown",
         nextUpdate = "",
         metadataLink = "http://openstat.psa.gov.ph/Metadata/Agriculture-Forestry-Fisheries/Livestock",
         metadataPath = "unavailable",
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


# normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg",
#              update = updateTables)

normGeometry(pattern = gs[],
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
#           outType = "rds",
#           update = updateTables)

normTable(pattern = ds[],
          ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)
