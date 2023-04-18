# create folders into which to sort incoming data ----
countries <- get_concept(table = tibble(class = "al1"), ontology = gazDir) %>%
  arrange(label)

dir.create(paste0(censusDBDir, "incoming/per_nation/"))
dir.create(paste0(censusDBDir, "incoming/per_dataseries/"))

for(i in seq_along(countries$label)){
  if(!testDirectoryExists(paste0(censusDBDir, "incoming/per_nation/", countries$label[i]))){
    dir.create(paste0(censusDBDir, "incoming/per_nation/", countries$label[i]))

    dir.create(paste0(censusDBDir, "incoming/per_nation/", countries$label[i], "/csv"))
    dir.create(paste0(censusDBDir, "incoming/per_nation/", countries$label[i], "/raw"))
    dir.create(paste0(censusDBDir, "incoming/per_nation/", countries$label[i], "/geom"))
  }
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
            label = list(al1 = "NAME_0"),
            archive = "gadm36_levels_gpkg.zip|gadm36_levels.gpkg",
            archiveLink = "https://geodata.ucdavis.edu/gadm/gadm4.1/gadm36_levels_gpkg.zip",
            updateFrequency = "unknown",
            update = TRUE)

regGeometry(gSeries = "gadm",
            label = list(al1 = "NAME_0", al2 = "NAME_1"),
            archive = "gadm36_levels_gpkg.zip|gadm36_levels.gpkg",
            archiveLink = "https://geodata.ucdavis.edu/gadm/gadm4.1/gadm36_levels_gpkg.zip",
            updateFrequency = "unknown",
            update = TRUE)

regGeometry(gSeries = "gadm",
            label = list(al1 = "NAME_0", al2 = "NAME_1", al3 = "NAME_2"),
            archive = "gadm36_levels_gpkg.zip|gadm36_levels.gpkg",
            archiveLink = "https://geodata.ucdavis.edu/gadm/gadm4.1/gadm36_levels_gpkg.zip",
            updateFrequency = "unknown",
            update = TRUE)

regGeometry(gSeries = "gadm",
            label = list(al1 = "NAME_0", al2 = "NAME_1", al3 = "NAME_2", al4 = "NAME_3"),
            archive = "gadm36_levels_gpkg.zip|gadm36_levels.gpkg",
            archiveLink = "https://geodata.ucdavis.edu/gadm/gadm4.1/gadm36_levels_gpkg.zip",
            updateFrequency = "unknown",
            update = TRUE)


# normalise geometries ----
#
normGeometry(pattern = "gadm",
             # query = "where NAME_0 = 'Estonia'", # change here the countries for which you want to (re)build the geometries
             beep = 10,
             outType = "gpkg",
             update = TRUE)
