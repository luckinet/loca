# script arguments ----
#
thisNation <- "Yemen"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("csoYemen")
gs <- c("gadm36")


# register dataseries ----
#
# ! see 02_faoDataLab.R !
#
regDataseries(name = ds[2],
              description = "Central Statistical Organization",
              homepage = "https://www.ncsi.gov.om/Pages/NCSI.aspx",
              licence_link = "",
              licence_path = "",
              update = updateTables)


# register geometries ----
#
## ocha ----
regGeometry(nation = "Yemen",
            gSeries = "ocha",
            level = 1,
            nameCol = "ADM0_EN",
            archive = "yem_adm_govyem_cso_ochayemen_20191002_shp.zip|yem_admbnda_adm0_govyem_cso_20191002.shp",
            archiveLink = "https://data.humdata.org/dataset/yemen-admin-boundaries",
            updateFrequency = "unknown",
            update = myUpdate)

regGeometry(nation = "Yemen",
            gSeries = "ocha",
            level = 2,
            nameCol = "ADM1_En",
            archive = "yem_adm_govyem_cso_ochayemen_20191002_shp.zip|yem_admbnda_adm1_govyem_cso_20191002.shp",
            archiveLink = "https://data.humdata.org/dataset/yemen-admin-boundaries",
            updateFrequency = "unknown",
            update = myUpdate)

regGeometry(nation = "Yemen",
            gSeries = "ocha",
            level = 3,
            nameCol = "ADM2_EN",
            archive = "yem_adm_govyem_cso_ochayemen_20191002_shp.zip|yem_admbnda_adm2_govyem_cso_20191002.shp",
            archiveLink = "https://data.humdata.org/dataset/yemen-admin-boundaries",
            updateFrequency = "unknown",
            update = myUpdate)

regGeometry(nation = "Yemen",
            gSeries = "ocha",
            level = 4,
            nameCol = "ADM3_EN",
            archive = "yem_adm_govyem_cso_ochayemen_20191002_shp.zip|yem_admbnda_adm3_govyem_cso_20191002.shp",
            archiveLink = "https://data.humdata.org/dataset/yemen-admin-boundaries",
            updateFrequency = "unknown",
            update = myUpdate)


# 3. register census tables ----
#
## crops ----
if(build_crops){

}

## livestock ----
if(build_livestock){

}

## landuse ----
if(build_landuse){

}


#### test schemas

# myRoot <- paste0(dataDir, "censusDB/adb_tables/stage2/")
# myFile <- ""
# schema <-
#
# input <- read_csv(file = paste0(myRoot, myFile),
#                   col_names = FALSE,
#                   col_types = cols(.default = "c"))
#
# validateSchema(schema = schema, input = input)
#
# output <- reorganise(input = input, schema = schema)
#
# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script


# 4. normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg",
#              update = updateTables)

# normGeometry(pattern = gs[],
#              outType = "gpkg",
#              update = updateTables)


# 5. normalise census tables ----
#
## in case the output shall be examined before writing into the DB
# testing <- normTable(nation = thisNation,
#                      update = FALSE,
#                      keepOrig = TRUE)

# normTable(pattern = ds[],
#           ontoMatch = ,
#           outType = "rds",
#           update = updateTables)
