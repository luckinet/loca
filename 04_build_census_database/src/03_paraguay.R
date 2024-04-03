# ----
# geography : _INSERT
# period    : _INSERT
# dataseries: _INSERT
# variables :
#   - land      : _INSERT
#   - crops     : _INSERT
#   - livestock : _INSERT
#   - technology: _INSERT
#   - social    : _INSERT
# sampling  : survey, census
# spatial   : _INSERT
# authors   : Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisNation <- "Paraguay"

# 1. dataseries ----
ds <- c("senacsa")
gs <- c("gadm")

regDataseries(name = ds[1],
              description = "Servico National de Calidad y Salud Animal",
              homepage = "http://www.senacsa.gov.py/",
              licence_link = "unknown",
              version = "2023.12")


# 2. geometries ----
#


# 3. tables ----
#
if(build_crops){
  ## crops ----

}

if(build_livestock){
  ## livestock ----

  ### senacsa ----
  schema_pry1 <- setCluster(id = "commodity", top = 2) %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", columns = c(2:5), rows = 2) %>%
    setIDVar(name = "animal", value = "bovinos") %>%
    setObsVar(name = "number_heads", factor = 1000, columns = c(2:5))

  regTable(nation = "Paraguay",
           subset = "bovinos",
           label = "al2",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_pry1,
           begin = 2009,
           end = 2012,
           archive = "anuario 2012.pdf",
           archiveLink = "http://www.senacsa.gov.py/index.php/informacion-publica/estadistica-pecuaria",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "same as archive link",
           metadataPath = "anuario 2012.pdf",
           update = updateTables,
           overwrite = overwriteTables)

  normTable(pattern = ds[1],
            ontoMatch = "animal",
            beep = 10)

}

if(build_landuse){
  ## landuse ----

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
