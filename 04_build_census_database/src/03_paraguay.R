# script arguments ----
#
thisNation <- "Paraguay"

ds <- c("senacsa")
gs <- c("gadm")


# 1. register dataseries ----
#
regDataseries(name = ds[1],
              description = "Servico National de Calidad y Salud Animal",
              homepage = "http://www.senacsa.gov.py/",
              licence_link = "unknown",
              version = "2023.12")

# 2. register geometries ----
#


# 3. register census tables ----
#
## crops ----
if(build_crops){

}

## livestock ----
if(build_livestock){

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

## landuse ----
if(build_landuse){

}
