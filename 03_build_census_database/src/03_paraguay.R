# script arguments ----
#
thisNation <- "Paraguay"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("senacsa", "spam")
gs <- c("gadm", "spam")

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
schema_pry1 <- setCluster(id = "commodity", top = 2) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", columns = c(2:5), rows = 2) %>%
  setIDVar(name = "commodity", value = "bovinos") %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = c(2:5))

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
         nextUpdate = "unknown",
         metadataLink = "same as archive link",
         metadataPath = "anuario 2012.pdf",
         update = updateTables,
         overwrite = overwriteTables)

## spam ----
# chosing spam data here, because they contain the senacsa data we have available, and more
schema_pry2 <- setCluster(id = "commodity", top = c(17, 54, 96, 135, 173, 211, 250, 288, 327, 366, 404, 442, 480, 518), left = 1, height = 20) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", columns = c(2, 5, 8, 11, 14), row = 1, split = "(?<=\\/).*", relative = TRUE) %>%
  setIDVar(name = "commodity", columns = 1, rows = c(11, 48, 90, 133, 167, 205, 242, 280, 319, 358, 396, 434, 472, 512), split = "(?<=\\: ).*") %>%
  setObsVar(name = "harvested", unit = "ha", columns = c(2, 5, 8, 11, 14), rows = 2, relative = TRUE) %>%
  setObsVar(name = "production", unit = "t", columns = c(3, 6, 9, 12, 15), rows = 2, relative = TRUE) %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = c(4, 7, 10, 13, 16), rows = 2, relative = TRUE)

regTable(nation = "Paraguay",
         subset = "crops",
         label = "al2",
         dSeries = ds[2],
         gSeries = gs[2],
         schema = schema_pry2,
         begin = 2008,
         end = 2012,
         archive = "Paraguay_2016.04.25.xlsx",
         archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0",
         updateFrequency = "not planned",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


# normalise geometries ----
#
# not needed


# normalise census tables ----
#
normTable(pattern = ds[1],
          ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)

normTable(pattern = ds[2],
          ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)

