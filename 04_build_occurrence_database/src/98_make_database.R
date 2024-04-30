# script description ----
#
# This script loads each point data set, (re)calculates the area for occurrence
# records that are not areal, cleans coordinates and derives a quality code for
# each record.
message("\n---- compile overall database ----")


# NOTES
# create column spatial_info, spatial_unit_size (give in meters), probably NA,
# if the values are not available...
#
# for data to be relevant for caterina, it has to have information in the
# columns spatial_info/unit_size, data_collected == "expert" and purpose ==
# "validation"



# script arguments ----
#


# load data ----
#
files <- list.files(path = DBDir, pattern = ".rds")


# data processing ----
#
for(i in seq_along(files)){

  theName <- head(str_split(tail(files[i], 1), "[.]")[[1]], 1)
  message(" --> handling dataseries '", theName, "'")

  temp <- read_rds(paste0(DBDir, files[i]))

  message("    ... determining areas")
  temp <- calculate_precision(input = temp, area = TRUE)


  message("    ... cleaning coordinates")

  message("    ... check if coordinates fall in given country")
  temp <- temp %>% mutate( # I did not check if this works. My approach is to make a column with the country that the point intersects and then filter the point out if it is not the same country given in our harmonization
    intersection = as.integer(st_intersects(geometry, GADM_data)),
    area = if_else(is.na(intersection), '', GADM_data$country_name[intersection])) %>%
    filter(country == area)

  # using CoordinateCleaner and countrycode package --> add library(countrycode) to boot_framework
  # temp <- temp %%
  #    mutate(countrycode = countrycode(sourcevar = country, origin = "country.name", destination = "iso3c")) %>%
  #       clean_coordinates(
  #         lon = "x",
  #         lat = "y",
  #         countries = countrycode) # with country_ref and country_refcol we can also change the used dataset for this test to GADM

  # checks to run
  # - cc_sea --> this function only identifies non-terrestrial coordiantes
  #    - we can use: clean_coordinates(), but countries have to be in 3 digit ISO Code
  # - check whether coordinates are within the country border (potentially also with inverted coordinates) <-- done if my code works


  message("    ... determining quality code")
  out <- temp #%>%
    # make_QC(
    #   ...
    # )

  write_rds(x = out, file = paste0(DBDir, files[i]))

}

all_points <- files %>% map(.f = function(ix){
  read_rds(ix)
}) %>% bind_rows() %>%
  st_as_sf(coords = c("x", "y")) %>%
  drop_na(date, coords, ontology) # i would recommend to check for NA. I think I did not get them all with the harmonization.

# write output ----
#
# write_rds(x = all_points, file = paste0(DBDir, "luckinet_lu_occDB.rds"))
st_write(obj = all_points,
         dsn = paste0(DBDir, "luckinet_lu_occDB.gpkg"),
         delete_layer = TRUE)

message("---- done ----")
