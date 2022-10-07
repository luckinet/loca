# author and date of creation ----
#
# Tsvetelina Tomova, 09.09.2021

# script description ----
#
# This script looks through all Taiwanese files and preprocess them.

# load packages ----
library(luckiTools)
library(arealDB)
library(tabshiftr)
library(magrittr)
library(dplyr)
library(readr)
library(tidyr)


# set path
DBDir <- ("I:/MAS/01_projects/LUCKINet/01_data/areal_data/incoming/data_tsvetelina/Taiwan/")

# set up loop parameters
# need to uncomment when I use the for loop
#
years <- c(1999:2018)
types <- c("Agriculture/AGR_", "Forest/FOR_", "Livestock/LIV_")

# rename all files
for (year in years) {
   folder <- paste0 (DBDir, year, "/")
   for (type in types){
      filepath <- paste0(folder, type, year, "_original/")
      print(filepath)
      files <- list.files(path = filepath)
      files
      data <- read_file(files, encoding="UTF-8", stringsAsFactors=FALSE)
      file.rename(from = paste0(filepath, files), to = paste0(filepath, year, "_", files))
   }
}

# explore type and names of files from the incoming folder
# create csv table with overview of all files xlsx, xls, csv, from the incoming data folder

DBDir <- ("I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/taiwan/")
incoming_taiwan <- list.files(path = DBDir, recursive = TRUE)

incoming_taiwan

tibble <-data.frame(incoming_taiwan)
tibble

overview_table <- separate(data = tibble, col = "incoming_taiwan",
                 into = c("year", "sector", "originalORTranslated", "table"),
                 sep = "/", fill = "left")

write.csv(overview_table, paste0(DBDir, "taiwan_overview.csv"))

# schema attempts
schema_twn_template_00 <- setCluster(id = "commodities", left = c(5, 5),  top = c(4, 10),  width = c(4, 4), height = c(56,56))%>%
   setFilter(rows = c(5:32, 58), invert = TRUE) %>%
   setIDVar(name = "al3", columns = 14, row = 7, distinct = TRUE) %>%
   setIDVar(name = "year", value = "2011") %>%
   setIDVar(name = "commodities", columns = c(4, 10), rows = c(5, 5), relative = TRUE) %>%
   setObsVar(name = "planted", unit = "ha", columns = c(4, 10), top = c(10, 9), relative = FALSE)




schema_twn_template_01 <- setCluster(id = "comodities", left = c(4, 10),  top = c(5, 5),  width = c(4, 4), height = c(56,56))%>%
   setFilter(rows = c(5:26, 37, 58), invert = TRUE) %>%
   setIDVar(name = "al3", columns = 14, rows = c(27:61), distinct = TRUE) %>%
   setIDVar(name = "year", value = "2011") %>%
   setIDVar(name = "commodities", columns = c(4, 10), rows = c(5, 5)) %>%
   setObsVar(name = "planted", unit = "ha", columns = c(4, 10))

schema_twn_template <- setCluster(id = "comodities", left = c(4, 10),  top = c(27, 27),  width = c(4, 4), height = c(30, 30))%>%
   setFilter(rows = c(37, 58), invert = TRUE) %>%
   setIDVar(name = "al3", columns = 14, rows = c(27:61)) %>%
   setIDVar(name = "year", value = "2011") %>%
   setIDVar(name = "commodities", columns = c(4, 10), rows = c(5, 5)) %>% #, relative = TRUE) %>%
   setObsVar(name = "planted", unit = "ha", columns = c(4, 10))#, top = c(10, 9), relative = FALSE)


schema_twn_02 <- setCluster(id = "comodities", left = c(4, 10), top = c(27, 27))%>%
   setFilter(rows = .find("...Province", col = 14), invert = TRUE) %>%
   setIDVar(name = "al3", columns = 14) %>%
   setIDVar(name = "year", value = "2011") %>%
   setIDVar(name = "commodities", columns = c(4, 10), rows = c(5, 5)) %>%
   setObsVar(name = "planted", unit = "ha", columns = c(4, 10)) #, top = c(10, 9), relative = TRUE) #%>%
   # setObsVar(name = "harvested", unit = "ha", columns = c(5, 11), top = c(10, 9)) %>%
   # setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 12), top = c(10, 9)) %>%
   # setObsVar(name = "production", unit = "t", columns = c(7, 13), top = c(10, 10))



schema_twn_00 <- setCluster(id = "year", left = 4, top = 26, height = 34) %>%
   setFilter(rows = .find(".. Province", col = 21), invert = TRUE) %>%
   setIDVar(name = "al3", columns = 21) %>%
   setIDVar(name = "year", value = "2011") %>%
   setIDVar(name = "commodities", columns = c(4, 8, 13, 17), rows = 6) %>%
   setObsVar(name = "planted", unit = "ha", columns = c(4, 8, 13, 17)) %>%
   setObsVar(name = "harvested", unit = "ha", columns = c(5, 9, 14, 18)) %>%
   setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 10, 15, 19)) %>%
   setObsVar(name = "production", unit = "t", columns = c(7, 11, 16, 20))


schema_twn_0001 <- setCluster(id = "year", left = 4, top = 26, height = 34) %>%
   setFilter(rows = .find(".. Province", col = 14), invert = TRUE) %>%
   setIDVar(name = "al3", columns = 14) %>%
   setIDVar(name = "year", value = "2011") %>%
   setIDVar(name = "commodities", columns = c(4, 10), rows = 5) %>%
   setObsVar(name = "planted", unit = "ha", columns = c(4, 10)) %>%
   setObsVar(name = "harvested", unit = "ha", columns = c(5, 11)) %>%
   setObsVar(name = "yield", unit = "kg/ha", columns = c(6, 12)) %>%
   setObsVar(name = "production", unit = "t", columns = c(7, 13))




