# script arguments ----
#
thisNation <- "Philippines"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- FALSE
overwriteTables <- FALSE


# register dataseries ----
#
ds <- c("psa")
gs <- c("gadm", "phillgis")

# regDataseries(name = "phillgis",
#               description = "Philippine GIS Data Clearinghouse",
#               homepage = "http://philgis.org/",
#               licence_link = "unknown",
#               licence_path = "not available",
#               update = myUpdate)
#
# regDataseries(name = "psa",
#               description = "Philippine Statistics Authority",
#               homepage = "https://psa.gov.ph/",
#               licence_link = "unknown",
#               licence_path = "not available",
#               update = myUpdate)


# register geometries ----
#
# phillgis ----
# regGeometry(nation = "Philippines",
#             gSeries = gs[2],
#             level = 4,
#             nameCol = "REGION|PROVINCE|NAME_2",
#             archive = "philippines.zip|MuniCities.shp",
#             archiveLink = "http://philgis.org/country-vector-and-raster-datasets",#
#             nextUpdate = "",
#             updateFrequency = "notPlanned",
#             update = TRUE)
#
# regGeometry(nation = "Philippines",
#             gSeries = gs[2],
#             level = 3,
#             nameCol = "REGION|PROVINCE",
#             archive = "philippines.zip|Provinces.shp",
#             archiveLink = "http://philgis.org/country-vector-and-raster-datasets",
#             nextUpdate = "",
#             updateFrequency = "notPlanned",
#             update = TRUE)
#
# regGeometry(nation = "Philippines",
#             gSeries = gs[2],
#             level = 2,
#             nameCol = "REGION",
#             archive = "philippines.zip|Regions.shp",
#             archiveLink = "http://philgis.org/country-vector-and-raster-datasets",##             nextUpdate = "",
#             nextUpdate = "",
#             updateFrequency = "notPlanned",
#             update = TRUE)


# register census tables ----
#
# psa ----
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


# harmonise commodities ----
#
for(i in seq_along(ds)){

  tibble(new = get_variable(variable = "commodities", dataseries = ds[i])) %>%
    match_ontology(table = ., columns = "new", dataseries = ds[i], ontology = ontoDir)

}


# normalise geometries ----
#
normGeometry(nation = thisNation,
             pattern = gs[2],
             outType = "gpkg",
             update = updateTables)


# normalise census tables ----
#
normTable(pattern = ds[1],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)

