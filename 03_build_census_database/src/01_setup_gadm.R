# create folders into which to sort incoming data ----
dir.create(paste0(censusDBDir, "incoming/per_nation/"))
dir.create(paste0(censusDBDir, "incoming/per_dataseries/"))

for(i in seq_along(countries$label)){
  dir.create(paste0(censusDBDir, "incoming/per_nation/", countries$label[i]))

  dir.create(paste0(censusDBDir, "incoming/per_nation/", countries$label[i], "/csv"))
  dir.create(paste0(censusDBDir, "incoming/per_nation/", countries$label[i], "/raw"))
  dir.create(paste0(censusDBDir, "incoming/per_nation/", countries$label[i], "/geom"))
}

# register dataseries ----
#
regDataseries(name = "gadm",
              description = "Database of Global Administrative Areas",
              homepage = "https://gadm.org/index.html",
              licence_link = "https://gadm.org/license.html",
              licence_path = "not available",
              update = TRUE)


# register geometries ----
#
regGeometry(gSeries = "gadm",
            label = "al1",
            nameCol = "NAME_0",
            archive = "gadm36_levels_gpkg.zip|gadm36_levels.gpkg",
            archiveLink = "https://biogeo.ucdavis.edu/data/gadm3.6/gadm36_levels_gpkg.zip",
            updateFrequency = "unknown",
            update = TRUE)

regGeometry(gSeries = "gadm",
            label = "al2",
            nameCol = "NAME_0|NAME_1",
            archive = "gadm36_levels_gpkg.zip|gadm36_levels.gpkg",
            archiveLink = "https://biogeo.ucdavis.edu/data/gadm3.6/gadm36_levels_gpkg.zip",
            updateFrequency = "unknown",
            update = TRUE)

regGeometry(gSeries = "gadm",
            label = "al3",
            nameCol = "NAME_0|NAME_1|NAME_2",
            archive = "gadm36_levels_gpkg.zip|gadm36_levels.gpkg",
            archiveLink = "https://biogeo.ucdavis.edu/data/gadm3.6/gadm36_levels_gpkg.zip",
            updateFrequency = "unknown",
            update = TRUE)

regGeometry(gSeries = "gadm",
            label = "al4",
            nameCol = "NAME_0|NAME_1|NAME_2|NAME_3",
            archive = "gadm36_levels_gpkg.zip|gadm36_levels.gpkg",
            archiveLink = "https://biogeo.ucdavis.edu/data/gadm3.6/gadm36_levels_gpkg.zip",
            updateFrequency = "unknown",
            update = TRUE)


# normalise geometries ----
#
normGeometry(pattern = "gadm",
             al1 = c("Argentina" , "Brazil", "Bolivia", "Paraguay"), # change here the countries for which you want to (re)build the geometries
             outType = "gpkg",
             update = TRUE)
