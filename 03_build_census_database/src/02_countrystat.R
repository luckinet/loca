# script arguments ----
#
thisNation <- "global"
# assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("countrySTAT")

regDataseries(name = ds[1],
              description = "CountrySTAT - Food and Agriculture Data Network",
              homepage = "http://www.fao.org/in-action/countrystat/background/en/",
              licence_link = "Creative Commons Attribution License (cc-by)",
              licence_path = "https://creativecommons.org/licenses/by/4.0/",
              update = TRUE)


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
