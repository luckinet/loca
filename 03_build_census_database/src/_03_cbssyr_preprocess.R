# author and date of creation ----
#
# Steffen Ehrmann, 07.06.2021


# script description ----
#
# This script looks through all syrian files and checks whether they can be
# reorganised with a schema.


# load packages ----
#
# module load foss/2019b R/4.0.0-2
library(tabshiftr)
library(checkmate)
library(readr)
library(stringr)
library(purrr)
library(tidyr)
library(dplyr, warn.conflicts = FALSE)
library(pdftools)
library(ggplot2)

# open problems
# 1. some values (of potatoe, 2013) are multiplied with a certain ratio (e.g., 2), in at least three tables concerning production (perhaps in all of them)
# 2. some values are missing, even though they should be there
# 3. missmatch between names of the territories
# 4. there are data in the final table, that are not in the original ones
# 5. barley is completely empty for 2013
# 6. infered 0s, that should not exist, for example cotton in 1999 (see false zero in the PDF)
# 7. record "-" different than a 0



# set paths ----
#
projDir <- select_path(idivnb283 = "/media/se87kuhe/external1/projekte/LUCKINet/",
                       frontend1 = "/data/idiv_meyer/01_projects/LUCKINet/")
dataDir <- paste0(projDir, "01_data/")
incoming <- paste0(DBDir, "adb_tables/incoming/per_nation/syria/csvs")

# Agricultural animals ----
#
cbs_animals <- list.files(path = paste0(DBDir, "/adb_tables/stage2/"), pattern = "syr_2_animal_", full.names = TRUE)

schema_ungulates <-
  setCluster(id = "type", left = 1, top = .find("Total")) %>%
  setFilter(rows = .find(by = is.numeric, col = 1), invert = TRUE) %>%
  setIDVar(name = "al1", value = "syria") %>%
  setIDVar(name = "al2", columns = 1)

schema_cattle <- schema_ungulates %>%
  setObsVar(name = "headcount", unit = "n", columns = 8)

schema_sheep <- schema_ungulates %>%
  setObsVar(name = "headcount", unit = "n", columns = 12)

schema_goats <- schema_ungulates %>%
  setObsVar(name = "headcount", unit = "n", columns = 11)

schema_buffalo <- schema_ungulates %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

schema_other <- schema_ungulates %>%
  setIDVar(name = "commodities", columns = c(2:6), rows = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:6))

schema_poultry <-
  setCluster(id = "type", left = 1, top = .find("Chicken")) %>%
  setFilter(rows = .find(by = is.numeric, col = 1), invert = TRUE) %>%
  setIDVar(name = "al1", value = "syria") %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(2:11), rows = 1) %>%
  setObsVar(name = "headcount", unit = "n", columns = c(2:11))

schema_bees <-
  setCluster(id = "type", left = 6, top = .find("Bee Hives")) %>%
  setFilter(rows = .find(by = is.numeric, col = 1), invert = TRUE) %>%
  setIDVar(name = "al1", value = "syria") %>%
  setIDVar(name = "al2", columns = 1) %>%
  setObsVar(name = "hives", unit = "n", columns = .find("Total"))

diagnostics <- NULL

for(i in seq_along(cbs_animals)){

  thisFile <- cbs_animals[i]
  temp <- tail(str_split(thisFile, "/")[[1]], 1)
  temp <- str_split(temp, "_")[[1]]

  if(temp[4] == "CATTLE"){

    thisSchema <- schema_cattle %>%
      setIDVar(name = "commodities", value = temp[4]) %>%
      setIDVar(name = "year", value = temp[5])

  } else if(temp[4] == "SHEEP"){

    thisSchema <- schema_sheep %>%
      setIDVar(name = "commodities", value = temp[4]) %>%
      setIDVar(name = "year", value = temp[5])

  } else if(temp[4] == "GOATS"){

    thisSchema <- schema_goats %>%
      setIDVar(name = "commodities", value = temp[4]) %>%
      setIDVar(name = "year", value = temp[5])

  } else if(temp[4] == "BUFFALO"){

    thisSchema <- schema_buffalo %>%
      setIDVar(name = "commodities", value = temp[4]) %>%
      setIDVar(name = "year", value = temp[5])

  } else if(temp[4] == "OTHER"){

    thisSchema <- schema_other %>%
      setIDVar(name = "year", value = temp[5])

  } else if(temp[4] == "POULTRY"){

    thisSchema <- schema_poultry %>%
      setIDVar(name = "year", value = temp[5])

  } else if(temp[4] == "BEE"){

    thisSchema <- schema_bees %>%
      setIDVar(name = "commodities", value = temp[4]) %>%
      setIDVar(name = "year", value = temp[5])

  }

  if(temp[5] %in% c(2006:2009)){
    thisArchive <- paste0(temp[5], "_Agricultural animals.xls")
  } else if(temp[5] %in% c(2014)) {
    thisArchive <- "2014_Agristatistics.pdf"
  } else {
    thisArchive <- paste0(temp[5], "_Agricultural animals.pdf")
  }


  diag <- regTable(nation = "Syria",
                   level = 2,
                   subset = thisSub,
                   dSeries = "cbs",
                   gSeries = "gadm",
                   schema = thisSchema,
                   begin = as.numeric(temp[5]),
                   end = as.numeric(temp[5]),
                   archive = thisArchive,
                   archiveLink = "unknown",
                   updateFrequency = "annually",
                   nextUpdate = "unknown",
                   metadataLink = "unknown",
                   metadataPath = "unknown",
                   update = updateTables,
                   overwrite = overwriteTables)

  diagnostics <- bind_rows(diagnostics, diag)

  # input <- read_csv(file = thisFile,
  #                   col_names = FALSE,
  #                   col_types = cols(.default = "c"))
  #
  # output <- reorganise(input = input,
  #                      schema = thisSchema)

}

# Crops and vegetables ----
#
cbs_crops <- list.files(path = paste0(DBDir, "/adb_tables/stage2/"), pattern = "syr_2_crops_", full.names = TRUE)

schema_crops <-
  setCluster(id = "irrigation", left = c(2, 5, 8), top = .find()) %>%
  setFilter(rows = .find(by = is.numeric, col = 1), invert = TRUE) %>%
  setIDVar(name = "irrigation", value = c("total", "non-irrigated", "irrigated")) %>%
  setIDVar(name = "al1", value = "syria") %>%
  setIDVar(name = "al2", columns = 1) %>%
  setObsVar(name = "yield", unit = "t/ha", factor = 1000, columns = 1, relative = TRUE) %>%
  setObsVar(name = "production", unit = "t", columns = 2, relative = TRUE) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 3, relative = TRUE)

for(i in seq_along(cbs_crops)){

  thisFile <- cbs_crops[i]
  temp <- tail(str_split(thisFile, "/")[[1]], 1)
  temp <- str_split(temp, "_")[[1]]

  thisSchema <- schema_crops %>%
    setIDVar(name = "commodities", value = temp[4]) %>%
    setIDVar(name = "year", value = thisYear)

  input <- read_csv(file = thisFile,
                    col_names = FALSE,
                    col_types = cols(.default = "c"))

  output <- reorganise(input = input,
                       schema = thisSchema)

}

# Fruit trees and forests ----
#
cbs_fruit <- list.files(path = paste0(DBDir, "adb_tables/stage1/"), pattern = "syr_2_orch_", full.names = TRUE)

schema_orch <-
  setCluster(id = "irrigation", left = c(2, 6, 10), top = .find()) %>%
  setFilter(rows = .find(by = is.numeric, col = 1), invert = TRUE) %>%
  setIDVar(name = "irrigation", value = c("total", "non-irrigated", "irrigated")) %>%
  setIDVar(name = "al1", value = "syria") %>%
  setIDVar(name = "al2", columns = 1) %>%
  setObsVar(name = "production", unit = "t", columns = 1, relative = TRUE) %>%
  setObsVar(name = "trees_with_fruits", unit = "n", columns = 2, relative = TRUE) %>%
  setObsVar(name = "trees_total", unit = "n", columns = 3, relative = TRUE) %>%
  setObsVar(name = "planted", unit = "ha", columns = 4, relative = TRUE)

for(i in seq_along(cbs_fruit)){

  thisFile <- cbs_fruit[i]
  temp <- tail(str_split(thisFile, "/")[[1]], 1)
  temp <- str_split(temp, "_")[[1]]

  thisSchema <- schema_orch %>%
    setIDVar(name = "commodities", value = temp[4]) %>%
    setIDVar(name = "year", value = thisYear)

  input <- read_csv(file = thisFile,
                    col_names = FALSE,
                    col_types = cols(.default = "c"))

  output <- reorganise(input = input,
                       schema = thisSchema)

}


# Rain and land use ----
#
cbs_landuse <- list.files(path = paste0(DBDir, "/adb_tables/stage1/"), pattern = "syr_2_landuse_", full.names = TRUE)

for(i in seq_along(cbs_landuse)){

  thisFile <- cbs_landuse[i]
  temp <- tail(str_split(thisFile, "/")[[1]], 1)
  temp <- str_split(temp, "_")[[1]]

  input <- read_csv(file = thisFile,
                    col_names = FALSE,
                    col_types = cols(.default = "c"))

  output <- reorganise(input = input,
                       schema = thisSchema)

}


# Machines ----
#
# cbs_machines <- list.files(path = paste0(DBDir, "/adb_tables/stage1/"), pattern = "", full.names = TRUE)
#
# for(i in seq_along(cbs_machines)){
#
#   thisFile <- cbs_machines[i]
#   temp <- tail(str_split(thisFile, "/")[[1]], 1)
#   temp <- str_split(temp, "_")[[1]]
#
#   input <- read_csv(file = thisFile,
#                     col_names = FALSE,
#                     col_types = cols(.default = "c"))
#
#   output <- reorganise(input = input,
#                        schema = thisSchema)
#
# }


# Production tenure ----
#
# cbs_tenure <- list.files(path = paste0(DBDir, "/adb_tables/stage1/"), pattern = "", full.names = TRUE)
#
# for(i in seq_along(cbs_tenure)){
#
#   thisFile <- cbs_tenure[i]
#   temp <- tail(str_split(thisFile, "/")[[1]], 1)
#   temp <- str_split(temp, "_")[[1]]
#
#   input <- read_csv(file = thisFile,
#                     col_names = FALSE,
#                     col_types = cols(.default = "c"))
#
#   output <- reorganise(input = input,
#                        schema = thisSchema)
#
# }


# syria_1 <- list.files(path = incoming_syria, pattern = "syr_1_", full.names = TRUE)
#
# schema_trees <- setCluster(id = "commodities", left = .find("[ء-ي]+[ ]+[[:alpha:]]"), top = .find(("[ء-ي]+[ ]+[[:alpha:]"))) %>%
#   setIDVar(name = "commodities", ) %>%
#   setIDVar(name = "year", columns = 1) %>%
#   setIDVar(name = "al1", value = "Syria") %>%
#   setObsVar(name = "planted", columns = 1, relative = TRUE) %>%
#   setObsVar(name = "production", columns = 4, relative = TRUE)
#
#
# for(i in seq_along(syria_1)){
#
#   theFile <- syria_1[i]
#   input <- read_csv(file = theFile,
#                     col_names = FALSE,
#                     col_types = cols(.default = "c"))
#
#   output <- reorganise(input = input,
#                        schema = schema_trees)
# }



some additional ideas:
  - use inkscape to transform as svg
- use magick to interact with svg or
- parse xml (find out what tags are in the file, so far I found that <path> is for lines)


# set paths ----
#
# taken from parent script 'build_global_censusDB.R'
# DBDir <- "/media/se87kuhe/external1/projekte/LUCKINet/01_data/areal_data/censusDB_global/"

incoming_syria <- paste0(DBDir, "adb_tables/incoming/per_nation/syria/new_raw")

# load meta-data ----
#
# LUT of all tables
tables <- tibble(short = c("rain1_1", "rain1_2", "landuse", "landuse_arable", "copped_area", "fruit_trees", "cropped_prod", "fruit_prod"),
                 name = c("RAINFALL TABLE ACCORDING TO RAINFALL STATION DURING 10 YEARS", "RAINFALL TABLE ACCORDING TO RAINFALL STATION DURING 10 YEARS",
                          "LAND USE", "CULTIVATED LAND USE", "WINTER AND SUMMER CROPPED AREA FOR CROPS AND VEGETABLES",
                          "FRUIT TREES, WINTER AND SUMMER CROPPED AND VEGETABLES AREA", "WINTER AND SUMMER CROPPED PRODUCTION FOR CROPS AND VEGETABLES",
                          "FRUIT TREES, WINTER AND SUMMER CROPPED AND VEGETABLES PRODUCTION"),
                 tab = c("Table (1)", "Table (1/1)", "Table (2)", "Table (3)", "Table (4)", "Table (5)", "Table (6)", "Table (7)"),
                 file = c(rep("Rain and land use", 8))) %>%
  mutate(ID = seq_along(short)) %>%
  select(ID, everything())


# load data ----
#
allFiles <- list.files(path = incoming_syria, pattern = ".pdf", full.names = TRUE)


# data processing ----
#
checks <- map_dfr(.x = seq_along(allFiles), .f = function(ix){
  temp <- str_split(string = allFiles[ix], pattern = "\\/")[[1]]
  temp <- str_split(string = tail(temp, 1), pattern = "_")[[1]]
  tibble(year = temp[1], table = temp[2])
})

# 1. identify years and files ----
overview <- checks %>%
  mutate(occ = 1) %>%
  arrange(year) %>%
  pivot_wider(names_from = year, values_from = occ) %>%
  arrange(table)

# 2. process files ----
map(.x = seq_along(allFiles), .f = function(ix){

  # load the tables
  # temp <- pdf_text(pdf = allFiles[ix]) %>%
  #   # str_replace_all(pattern = "Wadi Aleyoun", replacement = "WadiAleyoun") %>%
  #   str_split(pattern = "\n")

  pos <- pdf_data(pdf = allFiles[ix])

  # extract name components
  name_comp <- tail(str_split(string = allFiles[ix], pattern = "\\/")[[1]], 1)
  tabYear <- str_split(string = name_comp, pattern = "_")[[1]][1]
  fileName <- str_split(string = name_comp, pattern = "_|[.]")[[1]][2]

  for(i in seq_along(pos)){

    # # turn pdftools-output into tibble
    thesePos <- pos[[i]]

    # get position of each text-box ...
    yPos <- tibble(y = sort(unique(thesePos$y)),
                   yPos = seq_along(y))
    xPos <- tibble(x = sort(unique(thesePos$x)),
                   xPos = seq_along(x))

    thesePos <- thesePos %>%
      left_join(yPos, by = "y") %>%
      left_join(xPos, by = "x") %>%
      mutate(type = if_else(is.na(as.numeric(text)), "char", "num"))

    # ggplot(thesePos, aes(x = xPos, y = yPos, size = width, colour = type)) +
    ggplot(thesePos, aes(x = xPos, y = yPos)) +
      geom_point() +
      scale_y_reverse()

    ggplot(thesePos, aes(x = x)) +
      geom_freqpoly(binwidth = 1)
    ggplot(thesePos, aes(x = y)) +
      geom_freqpoly(binwidth = 1)

    # ... and paste it into the output-matrix
    outMat <- matrix(nrow = length(unique(thesePos$y)), ncol = length(unique(thesePos$x)))
    for(j in seq_along(thesePos$text)){

      temp <- thesePos[j, ]
      outMat[temp$yPos, temp$xPos] <- temp$text

    }

    # make name ...
    tabName <- tables %>%
      filter(file == fileName & ID == i) %>%
      pull(short)
    outName <- paste0(paste0(c("syria", tabYear, tabName), collapse = "_"), ".csv")

    # ... and save
    as_tibble(outMat, .name_repair = "minimal") %>%
      write_csv(file = paste0(DBDir, "adb_tables/stage1/", outName), na = "", col_names = FALSE)

  }

})
