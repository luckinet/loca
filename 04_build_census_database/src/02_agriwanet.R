# script arguments ----
#

ds <- c("agriwanet")
gs <- c("gadm36")

# 1. dataseries ----
#
regDataseries(name = ds[1],
              description = "Agricultural Restructuring, Water Scarcity and the Adaptation to Climate Change in Central Asia",
              homepage = "https://doi.org/10.7802/2008",
              licence_link = "CC BY 4.0",
              licence_path = "not available")

# 2. geometries ----
#
# based on GADM 3.6



# 3. census tables ----
#
## crops ----
if(build_crops){

  schema_agriwanet1 <-
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "year", columns = 4) %>%
    setIDVar(name = "method", value = "yearbook") %>%
    setIDVar(name = "crop", columns = c(20:34), rows = 1) %>%
    setObsVar(name = "harvested", unit = "ha", factor = 1000, columns = c(20:34),
              key = 3, value = "all farms (not applic case) (10)")

  regTable(subset = "harvested",
           label = "al2",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_agriwanet1,
           begin = 1992,
           end = 2015,
           archive = "agriwanet_data_en_V1.0.csv",
           archiveLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
           metadataPath = "agriwanet_codebook_en.pdf",
           overwrite = TRUE)

  schema_agriwanet2 <-
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "year", columns = 4) %>%
    setIDVar(name = "method", value = "yearbook") %>%
    setIDVar(name = "crop", columns = c(35:49), rows = 1) %>%
    setObsVar(name = "production", unit = "t", factor = 1000, columns = c(35:49),
              key = 3, value = "all farms (not applic case) (10)")

  regTable(subset = "production",
           label = "al2",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_agriwanet2,
           begin = 1992,
           end = 2015,
           archive = "agriwanet_data_en_V1.0.csv",
           archiveLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
           metadataPath = "agriwanet_codebook_en.pdf",
           overwrite = TRUE)

  normTable(pattern = ds[1],
            ontoMatch = "crop",
            outType = "csv",
            beep = 10)

}

## livestock ----
if(build_livestock){

  schema_agriwanet3 <-
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "year", columns = 4) %>%
    setIDVar(name = "method", value = "yearbook") %>%
    setIDVar(name = "animal", columns = c(50:53), rows = 1) %>%
    setObsVar(name = "headcount", unit = "n", factor = 1000, columns = c(50:53),
              key = 3, value = "all farms (not applic case) (10)")

  regTable(subset = "livestock",
           label = "al2",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_agriwanet3,
           begin = 1992,
           end = 2015,
           archive = "agriwanet_data_en_V1.0.csv",
           archiveLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
           metadataPath = "agriwanet_codebook_en.pdf",
           overwrite = TRUE)

  normTable(pattern = paste0("livestock.*", ds[1]),
            ontoMatch = "animal",
            outType = "csv",
            beep = 10)

}

## landuse ----
if(build_landuse){

}
