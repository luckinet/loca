# script arguments ----
#
thisNation <- "Paraguay"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("senacsa", )
gs <- c("gadm36")


# register dataseries ----
#
regDataseries(name = ds[1],
              description = "Servico National de Calidad y Salud Animal",
              homepage = "http://www.senacsa.gov.py/",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)

# register geometries ----
#


# register census tables ----
#
## senacsa ----
# schema_pry1 <- setCluster(id = "commodity", top = 2) %>%
#   setIDVar(name = "al2", columns = 1) %>%
#   setIDVar(name = "year", columns = c(2:5), rows = 2) %>%
#   setIDVar(name = "commodity", value = "bovinos") %>%
#   setObsVar(name = "headcount", unit = "n", factor = 1000, columns = c(2:5))
#
# regTable(nation = "Paraguay",
#          subset = "bovinos",
#          label = "al2",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = schema_pry1,
#          begin = 2009,
#          end = 2012,
#          archive = "anuario 2012.pdf",
#          archiveLink = "http://www.senacsa.gov.py/index.php/informacion-publica/estadistica-pecuaria",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "same as archive link",
#          metadataPath = "anuario 2012.pdf",
#          update = updateTables,
#          overwrite = overwriteTables)



# normalise geometries ----
#
# not needed


# normalise census tables ----
#
normTable(pattern = ds[1],
          # ontoMatch = "commodity",
          outType = "rds",
          beep = 10,
          update = updateTables)

