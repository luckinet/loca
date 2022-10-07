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

  # checks to run
  # - cc_sea
  # - check whether coodrinates are within the country border (potenially also with inverted coordinates)


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
  st_as_sf(coords = c("x", "y"))


# write output ----
#
# write_rds(x = all_points, file = paste0(DBDir, "luckinet_lu_occDB.rds"))
st_write(obj = all_points,
         dsn = paste0(DBDir, "luckinet_lu_occDB.gpkg"),
         delete_layer = TRUE)

message("---- done ----")
