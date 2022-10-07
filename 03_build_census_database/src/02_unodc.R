# script arguments ----
#
thisNation <- "global"
# assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
regDataseries(name = "UNODC",
              description = "UNODC and Illicit Crop Monitoring",
              homepage = "https://www.unodc.org/unodc/en/crop-monitoring/index.html",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)


# register geometries ----
#
# this has been moved to the country-specific protocols


# register census tables ----
#
# this has been moved to the country-specific protocols


# harmonise concepts ----
#
# this has been moved to the country-specific protocols


# normalise geometries ----
#
# this has been moved to the country-specific protocols


# normalise census tables ----
#
# this has been moved to the country-specific protocols

