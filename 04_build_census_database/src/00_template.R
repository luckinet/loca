# script arguments ----
#
thisNation <- _INSERT


# 1. dataseries ----
#
ds <- c(_INSERT)
gs <- c(_INSERT)

regDataseries(name = ds[],
              description = _INSERT,
              homepage = _INSERT,
              version = _INSERT,
              licence_link = _INSERT)


# 2. geometries ----
#
regGeometry(nation = !!thisNation, # or any other "class = value" combination from the gazetteer
            gSeries = gs[],
            label = list(al_ = ""),
            archive = "|",
            archiveLink = _INSERT,
            downloadDate = _INSERT,
            updateFrequency = _INSERT)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  schema_crops <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", ) %>%
    setObsVar(name = "harvested", )

  regTable(nation = !!thisNation, # or any other "class = value" combination from the gazetteer
           label = "al_", # this should be the name of a level in the gazetteer
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_crops,
           begin = _INSERT, # first year in the table
           end = _INSERT, # last year in the table
           archive = _INSERT, # the name of this table in our database
           archiveLink = _INSERT, # where this table can be found online
           updateFrequency = _INSERT,
           nextUpdate = _INSERT,
           metadataPath = _INSERT,
           metadataLink = _INSERT)

  normTable(pattern = ds[],
            ontoMatch = "crop",
            beep = 10)
}

if(build_livestock){
  ## livestock ----

  schema_livestock <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "animal", )  %>%
    setObsVar(name = "headcount", )

  regTable(nation = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_livestock,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           updateFrequency = _INSERT,
           nextUpdate = _INSERT,
           metadataPath = _INSERT,
           metadataLink = _INSERT)

  normTable(pattern = ds[],
            ontoMatch = "animal",
            beep = 10)
}

if(build_landuse){
  ## landuse ----

  schema_landuse <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "landuse", ) %>%
    setObsVar(name = "area", )

  regTable(nation = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_landuse,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           updateFrequency = _INSERT,
           nextUpdate = _INSERT,
           metadataPath = _INSERT,
           metadataLink = _INSERT)

  normTable(pattern = ds[],
            ontoMatch = "landuse",
            beep = 10)
}


#### test schemas
#
# myRoot <- paste0(census_dir, "tables/stage2/")
# myFile <- ""
# input <- read_csv(file = paste0(myRoot, myFile),
#                   col_names = FALSE,
#                   col_types = cols(.default = "c"))
#
# schema <-
# validateSchema(schema = schema, input = input)
#
# output <- reorganise(input = input, schema = schema)
#
# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script


# 4. normalise geometries ----
#
# normGeometry(pattern = gs[],
#              outType = "gpkg")


# 5. normalise census tables ----
#
# normTable(pattern = ds[],
#           ontoMatch = )
