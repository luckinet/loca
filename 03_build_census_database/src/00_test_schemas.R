# script description ----
#
# This document serves as a testground for schemas. Please report issues to
# https://github.com/luckinet/tabshiftr/issues


# set paths ----
#
myRoot <- paste0(dataDir, "censusDB/adb_tables/stage2/")


# set input ----
#
myFile <- "rus_3_planted91_2008_2020_rosstat.csv"
schema <- schema_planted


# data processing ----
#
input <- read_csv(file = paste0(myRoot, myFile),
                  col_names = FALSE,
                  col_types = cols(.default = "c"))

# input <- read.csv(file = paste0(myRoot, myFile),
#                   header = FALSE,
#                   strip.white = TRUE,
#                   as.is = TRUE,
#                   na.strings = schema@format$na,
#                   encoding = "UTF-8") %>%
#   as_tibble()

validateSchema(schema = schema, input = input)

output <- reorganise(input = input, schema = schema)








input <- input[1:43,]
schema <- setCluster(id = "al3", left = 1, top = c(2, 12)) %>%
  setFormat(decimal = ".") %>%
  setIDVar(name = "al3", columns = 1, rows = c(2, 12)) %>%
  setIDVar(name = "year", columns = c(2, 3), rows = .find(row = 2, relative = TRUE)) %>%
  setIDVar(name = "commodities", columns = 1) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2, 3))

