library(tidyverse)
library(tabulizer)

dataDirec <- "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/indonesia/Aceh/"


## set the URL of the pdf file which you want to extract data
datatable <- extract_tables("I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/indonesia/Aceh/AcehFruitsProductionRegency13.pdf",
                            output = "data.frame",
                            method = "stream",
                            pages = 15)

## create data table
datatable_clean <- reduce(datatable, bind_rows)
## print data table
write_csv(datatable_clean, paste0(dataDirec, "AcehFruitsProductionRegency13-02.csv"))

