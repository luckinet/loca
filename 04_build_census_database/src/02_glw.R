# ----
# geography : Global
# period    : 2000 - 2015
# dataseries: Gridded Livestock of the World (https://dataverse.harvard.edu/dataverse/glw)
# variables :
#   - land      : -
#   - crops     : -
#   - livestock : number_heads
#   - technology: -
#   - social    : -
# sampling  : survey, census
# spatial   : gaul0, gaul1, gaul2, ... (national specific)
# authors   : Steffen Ehrmann
# date      : 2024-04-03
# status    : normalize, done
# comment   : need to extract data based on gaul and not based on gadm, as is done currently, version 3 and 4
# ----

thisNation <- "global"


# 1. dataseries ----
#
ds <- c("glw3", "glw4")
gs <- c("gadm")

regDataseries(name = ds[1],
              description = "Gridded Livestock of the World version 3",
              homepage = "https://doi.org/10.1038/sdata.2018.227",
              version = "3.0.0",
              licence_link = "http://creativecommons.org/licenses/by/4.0/")

regDataseries(name = ds[2],
              description = "Gridded Livestock of the World version 4",
              homepage = "https://doi.org/10.1038/sdata.2018.227",
              version = "4.0.0",
              licence_link = "http://creativecommons.org/licenses/by/4.0/")


# 2. geometries ----
#
# based on GADM 3.6


# 3. tables ----
#
if(build_crops){
  ## crops ----

}

if(build_livestock){
  ## livestock ----

  schema_glw3 <-
    setFormat(na_values = c("")) %>%
    setIDVar(name = "year", columns = 11) %>%
    setIDVar(name = "method", value = "") %>%
    setIDVar(name = "animal", columns = 8) %>%
    setObsVar(name = "number_heads", columns = 13)

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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           metadataPath = "unavailable",
           overwrite = TRUE)

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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           metadataPath = "unavailable",
           overwrite = TRUE)

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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           metadataPath = "unavailable",
           overwrite = TRUE)

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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           metadataPath = "unavailable",
           overwrite = TRUE)

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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           metadataPath = "unavailable",
           overwrite = TRUE)

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
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://dataverse.harvard.edu/dataverse/glw_3",
           metadataPath = "unavailable",
           overwrite = TRUE)

  # schema_glw4 <-
  # setIDVar(name = "al1", columns = 1) %>%
  #   setIDVar(name = "al2", columns = 2) %>%
  #   setIDVar(name = "al3", columns = 3) %>%
  #   setIDVar(name = "al4", columns = 4) %>%
  #   setIDVar(name = "al5", columns = 5) %>%
  #   setIDVar(name = "al6", columns = 6) %>%
  #   setIDVar(name = "year", columns = 11) %>%
  # setIDVar(name = "methdod", value = "") %>%
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
  # downloadDate = ymd("2019-10-10"),
           # metadataLink = "https://dataverse.harvard.edu/dataverse/glw_4",
  #          metadataPath = "unavailable",
  #          overwrite = TRUE)

  normTable(pattern = ds[1],
            ontoMatch = "animal",
            beep = 10)

}

if(build_landuse){
  ## landuse ----

}
