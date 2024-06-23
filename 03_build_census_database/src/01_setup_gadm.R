# ----
# title       : build census database - GADM
# description : this script integrates data of 'Database of Global Administrative Areas' (https://gadm.org/index.html)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-04-03
# version     : 1.0.0
# status      : done
# comment     : version 3.6
# ----
# geography   : Global
# spatial     : GADM0, GADM1, GADM2, GADM3, GADM4, GADM5
# period      : -
# variables   :
# - land      : -
# - crops     : -
# - livestock : -
# - tech      : -
# - social    : -
# sampling    : -
# ----

# register dataseries ----
#
regDataseries(name = "gadm",
              description = "Database of Global Administrative Areas v3.6",
              homepage = "https://gadm.org/index.html",
              version = "3.6",
              licence_link = "https://gadm.org/license.html")

# regDataseries(name = "gadm",
#               description = "Database of Global Administrative Areas v4.1",
#               homepage = "https://gadm.org/index.html",
#               version = "4.1",
#               licence_link = "https://gadm.org/license.html")


# register geometries ----
#
regGeometry(gSeries = "gadm",
            label = list(al1 = "NAME_0"),
            archive = "gadm36_levels_gpkg.zip|gadm36_levels.gpkg",
            archiveLink = "https://geodata.ucdavis.edu/gadm/gadm4.1/gadm36_levels_gpkg.zip",
            downloadDate = ymd("2024-01-04"),
            updateFrequency = "unknown")

regGeometry(gSeries = "gadm",
            label = list(al1 = "NAME_0", al2 = "NAME_1"),
            archive = "gadm36_levels_gpkg.zip|gadm36_levels.gpkg",
            archiveLink = "https://geodata.ucdavis.edu/gadm/gadm4.1/gadm36_levels_gpkg.zip",
            downloadDate = ymd("2024-01-04"),
            updateFrequency = "unknown")

regGeometry(gSeries = "gadm",
            label = list(al1 = "NAME_0", al2 = "NAME_1", al3 = "NAME_2"),
            archive = "gadm36_levels_gpkg.zip|gadm36_levels.gpkg",
            archiveLink = "https://geodata.ucdavis.edu/gadm/gadm4.1/gadm36_levels_gpkg.zip",
            downloadDate = ymd("2024-01-04"),
            updateFrequency = "unknown")

regGeometry(gSeries = "gadm",
            label = list(al1 = "NAME_0", al2 = "NAME_1", al3 = "NAME_2", al4 = "NAME_3"),
            archive = "gadm36_levels_gpkg.zip|gadm36_levels.gpkg",
            archiveLink = "https://geodata.ucdavis.edu/gadm/gadm4.1/gadm36_levels_gpkg.zip",
            downloadDate = ymd("2024-01-04"),
            updateFrequency = "unknown")

regGeometry(gSeries = "gadm",
            label = list(al1 = "NAME_0", al2 = "NAME_1", al3 = "NAME_2", al4 = "NAME_3", al5 = "NAME_4"),
            archive = "gadm36_levels_gpkg.zip|gadm36_levels.gpkg",
            archiveLink = "https://geodata.ucdavis.edu/gadm/gadm4.1/gadm36_levels_gpkg.zip",
            downloadDate = ymd("2024-01-04"),
            updateFrequency = "unknown")

regGeometry(gSeries = "gadm",
            label = list(al1 = "NAME_0", al2 = "NAME_1", al3 = "NAME_2", al4 = "NAME_3", al5 = "NAME_4", al6 = "NAME_5"),
            archive = "gadm36_levels_gpkg.zip|gadm36_levels.gpkg",
            archiveLink = "https://geodata.ucdavis.edu/gadm/gadm4.1/gadm36_levels_gpkg.zip",
            downloadDate = ymd("2024-01-04"),
            updateFrequency = "unknown")


# normalise geometries ----
#
normGeometry(pattern = "gadm",
             query = "where NAME_0 = 'Argentina'",
             beep = 10)
