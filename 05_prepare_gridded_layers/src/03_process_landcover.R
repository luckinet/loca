# ----
# title        : process landcover
# authors      : Steffen Ehrmann
# version      : 0.1.0
# date         : 2024-03-27
# description  : _INSERT
# documentation: -
# ----
message("\n---- process landcover ----")
split landcover layer into the groups of interest (water, urban, pristine) and
then use zonal statistics with the target resolution (1 km) to get the
sum/proportion of each layer per 1 km cell

# 1. make paths ----
#
_INSERT <- str_replace(_INSERT, "\\{_INSERT\\}", _INSERT)

# 2. load data ----
#
_INSERT <- read_rds(file = _INSERT)
tbl_INSERT <- read_csv(file = _INSERT)
vct_INSERT <- st_read(dsn = _INSERT)
rst_INSERT <- rast(_INSERT)

# 3. data processing ----
#
## derive percent water cover ----
message(" --> _INSERT")

## derive percent urban cover ----
message(" --> _INSERT")

## derive percent pristine cover ----
message(" --> _INSERT")

# 4. write output ----
#
write_rds(x = _INSERT, file = _INSERT)

# beep(sound = 10)
message("\n     ... done")
