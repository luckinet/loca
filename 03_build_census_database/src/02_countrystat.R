# script arguments ----
#
thisNation <- "global"

updateTables <- TRUE
overwriteTables <- TRUE


# 1. register dataseries ----
#
ds <- c("countryStat")

regDataseries(name = ds[1],
              description = "CountrySTAT - Food and Agriculture Data Network",
              homepage = "http://www.fao.org/in-action/countrystat/background/en/",
              licence_link = "Creative Commons Attribution License (cc-by)",
              licence_path = "https://creativecommons.org/licenses/by/4.0/",
              update = TRUE)


# 2. register geometries ----
#
# this has been moved to the country-specific protocols


# 3. register census tables ----
#
# this has been moved to the country-specific protocols


# 4. normalise geometries ----
#
# this has been moved to the country-specific protocols


# 5. normalise census tables ----
#
# this has been moved to the country-specific protocols
