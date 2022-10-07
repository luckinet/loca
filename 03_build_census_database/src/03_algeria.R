# script arguments ----
#
thisNation <- "Algeria"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("ONS")
gs <- c("gadm")

regDataseries(name = ds[1],
              description = "Office National des Statistiques",
              homepage = "http://www.ons.dz/",
              licence_link = "",
              licence_path = "",
              update = updateTables)



# register geometries ----
#

# register census tables ----
#
schema_alg_01 <-
  setFormat(thousand = ",") %>%
  setFilter(rows = .find("Total", col = 1), invert = TRUE) %>%
  setIDVar(name = "al1", value = "Algeria") %>%
  setIDVar(name = "year", columns = c(2:11), rows = 2) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:11), top = 1)

regTable(nation = "alg",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_alg_01,
         begin = 2000,
         end = 2009,
         archive = "Cheptel2000-2009-2.pdf",
         archiveLink = "https://www.ons.dz/IMG/pdf/Cheptel2000-2009-2.pdf",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://www.ons.dz/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


# harmonise commodities ----
#
for(i in seq_along(ds)){

  tibble(new = get_variable(variable = "commodities", dataseries = ds[i])) %>%
    match_ontology(columns = "new", dataseries = ds[i])

}


# normalise geometries ----
#
# not needed


# normalise census tables ----
#
normTable(pattern = ds[1],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)


