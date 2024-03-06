# install.packages("tidyverse")
# install.packages("sf")
# install.packages("spData")
library(tidyverse)
library(sf)
library(spData)

# This script creates the internal object 'geom_countries' that serves as basis
# for all maps in LUCKINet.
#
# 1) The file countries.csv has been put together mostly "by hand"
#
# 2) the polygons are taken from the R package spData. Here various fields need to be corrected.
#
# 3) A full join on the column 'iso_a2' is carried out.

intPaths <- "/home/se87kuhe/Nextcloud/LUCKINet/data/"

myWorld <- spData::world
myWorld$iso_a2[myWorld$name_long == "France"] <- "FR"
myWorld$iso_a2[myWorld$name_long == "Norway"] <- "NO"
myWorld$iso_a2[myWorld$name_long == "Somaliland"] <- "SO"
myWorld$iso_a2[myWorld$name_long == "Northern Cyprus"] <- "CY"

countries <- read_csv(file = paste0(intPaths, "incoming/countries.csv"), col_types = "ccclccc")

geom_countries <- myWorld %>%
  select(iso_a2, name_long, geom) %>%
  as_tibble() %>%
  left_join(countries, by = "iso_a2") %>%
  select(nation, iso_a2, iso_a3, un_member, continent, region, subregion, geom) %>%
  st_sf()
