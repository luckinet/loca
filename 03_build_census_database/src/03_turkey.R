# script arguments ----
#
thisNation <- "Cyprus"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- FALSE
overwriteTables <- FALSE


# register dataseries ----
#
ds <- c("agCensus")
gs <- c("gadm", "agCensus")

regDataseries(name = "",
              description = "",
              homepage = "",
              licence_link = "",
              licence_path = "",
              update = updateTables)


# register geometries ----
#
regGeometry(nation = "",
            gSeries = "",
            level = 2,
            nameCol = "",
            archive = "|",
            archiveLink = "",
            nextUpdate = "",
            updateFrequency = "",
            update = updateTables)


# register census tables ----
#
# regTable(nation = "Turkey",
#          level = 3,
#          dSeries = ds[1],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2001,
#          end = 2001,
#          archive = "turkey.zip|Turkey_census.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Turkey",
#          level = 3,
#          dSeries = ds[1],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "turkey.zip|Turkey_2015.04.01.xlsx",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Turkey",
#          level = 3,
#          dSeries = ds[1],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "turkey.zip|Turkey_2015.04.01.xlsx",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Turkey",
#          level = 3,
#          dSeries = ds[1],
#          gSeries = gs[2],
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "turkey.zip|Turkey_2015.04.01.xlsx",
#          update = myUpdate,
#          overwrite = myOverwrite)


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

