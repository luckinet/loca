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



