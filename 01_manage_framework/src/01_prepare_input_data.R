# ----
# title        : prepare input data
# authors      : Steffen Ehrmann
# version      : 0.0.0
# date         : 2024-MM-DD
# description  : _INSERT
# documentation: -
# ----
message("\n---- prepare input data ----")

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
## prepare territorial basis ----
message(" --> downloading GADM")

## prepare landcover basis ----
message(" --> downloading ESA-CCI landcover")

# 4. write output ----
#
write_rds(x = _INSERT, file = _INSERT)

# beep(sound = 10)
message("\n     ... done")
