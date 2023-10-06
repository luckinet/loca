# script arguments ----
#
thisNation <- "global"

updateTables <- TRUE
overwriteTables <- TRUE


# 1. register dataseries ----
#
ds <- c("glw3", "glw4")
gs <- c("gadm36", "gadm41")

regDataseries(name = ds[1],
              description = "Gridded Livestock of the World version 3",
              homepage = "https://doi.org/10.1038/sdata.2018.227",
              licence_link = "http://creativecommons.org/licenses/by/4.0/",
              licence_path = "",
              update = updateTables)

regDataseries(name = ds[2],
              description = "Gridded Livestock of the World version 4",
              homepage = "https://doi.org/10.1038/sdata.2018.227",
              licence_link = "http://creativecommons.org/licenses/by/4.0/",
              licence_path = "",
              update = updateTables)


# 2. register geometries ----
#
# based on GADM 3.6

# 3. register census tables ----
#
## crops ----
if(build_crops){

}

## livestock ----
if(build_livestock){

  schema_glw3 <-
    setFormat(na_values = c("")) %>%
    setIDVar(name = "year", columns = 11) %>%
    setIDVar(name = "animal", columns = 8) %>%
    setObsVar(name = "headcount", unit = "n", columns = 13)

  schema_glw3_1 <- schema_glw3 %>%
    setIDVar(name = "al1", columns = 1)

  regTable(label = "al1",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_glw3_1,
           begin = 2006,
           end = 2011,
           archive = "gadm_36_glw3.csv.gz|gadm_36_glw3.csv",
           archiveLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           updateFrequency = "periodic",
           nextUpdate = "unknown",
           metadataLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           metadataPath = "unavailable",
           update = updateTables,
           overwrite = overwriteTables)

  schema_glw3_2 <- schema_glw3 %>%
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "al2", columns = 2)

  regTable(label = "al2",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_glw3_2,
           begin = 2000,
           end = 2015,
           archive = "gadm_36_glw3.csv.gz|gadm_36_glw3.csv",
           archiveLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           updateFrequency = "periodic",
           nextUpdate = "unknown",
           metadataLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           metadataPath = "unavailable",
           update = updateTables,
           overwrite = overwriteTables)

  schema_glw3_3 <- schema_glw3 %>%
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3)

  regTable(label = "al3",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_glw3_3,
           begin = 1985,
           end = 2015,
           archive = "gadm_36_glw3.csv.gz|gadm_36_glw3.csv",
           archiveLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           updateFrequency = "periodic",
           nextUpdate = "unknown",
           metadataLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           metadataPath = "unavailable",
           update = updateTables,
           overwrite = overwriteTables)

  schema_glw3_4 <- schema_glw3 %>%
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "al4", columns = 4)

  regTable(label = "al4",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_glw3_4,
           begin = 1997,
           end = 2015,
           archive = "gadm_36_glw3.csv.gz|gadm_36_glw3.csv",
           archiveLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           updateFrequency = "periodic",
           nextUpdate = "unknown",
           metadataLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           metadataPath = "unavailable",
           update = updateTables,
           overwrite = overwriteTables)

  schema_glw3_5 <- schema_glw3 %>%
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "al5", columns = 5)

  regTable(label = "al5",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_glw3_5,
           begin = 2000,
           end = 2014,
           archive = "gadm_36_glw3.csv.gz|gadm_36_glw3.csv",
           archiveLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           updateFrequency = "periodic",
           nextUpdate = "unknown",
           metadataLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           metadataPath = "unavailable",
           update = updateTables,
           overwrite = overwriteTables)

  schema_glw3_6 <- schema_glw3 %>%
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "al4", columns = 4) %>%
    setIDVar(name = "al5", columns = 5) %>%
    setIDVar(name = "al6", columns = 6)

  regTable(label = "al6",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_glw3_6,
           begin = 2001,
           end = 2012,
           archive = "gadm_36_glw3.csv.gz|gadm_36_glw3.csv",
           archiveLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           updateFrequency = "periodic",
           nextUpdate = "unknown",
           metadataLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           metadataPath = "unavailable",
           update = updateTables,
           overwrite = overwriteTables)


  # schema_glw4 <-
  # setIDVar(name = "al1", columns = 1) %>%
  #   setIDVar(name = "al2", columns = 2) %>%
  #   setIDVar(name = "al3", columns = 3) %>%
  #   setIDVar(name = "al4", columns = 4) %>%
  #   setIDVar(name = "al5", columns = 5) %>%
  #   setIDVar(name = "al6", columns = 6) %>%
  #   setIDVar(name = "year", columns = 11) %>%
  #   setIDVar(name = "animal", columns = 8) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = 13)
  #
  # regTable(label = "al6",
  #          subset = "livestock",
  #          dSeries = ds[2],
  #          gSeries = gs[2],
  #          schema = schema_glw4,
  #          begin = 2015,
  #          end = 2015,
  #          archive = "gadm_410_glw4.csv.gz|gadm_410_glw4.csv",
  #          archiveLink = "https://dataverse.harvard.edu/dataverse/glw_4",
  #          updateFrequency = "periodic",
  #          nextUpdate = "unknown",
  #          metadataLink = "https://dataverse.harvard.edu/dataverse/glw_4",
  #          metadataPath = "unavailable",
  #          update = updateTables,
  #          overwrite = overwriteTables)

}

## landuse ----
if(build_landuse){

}


# 4. normalise geometries ----
#
# not needed

# 5. normalise census tables ----
#
normTable(pattern = ds[1],
          ontoMatch = "animal",
          outType = "rds",
          beep = 10,
          update = updateTables)

