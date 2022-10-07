# script arguments ----
#
thisNation <- "South Africa"
assertSubset(x = thisNation, choices = countries$label) # ensure that nation is valid

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested


# register dataseries ----
#
ds <- c("spam", "agCensus")
gs <- c("gadm", "spam", "agCensus")


# register geometries ----
#
# agCensus ----
regGeometry(nation = "South Africa",
            gSeries = "agCensus",
            level = 3,
            nameCol = "NAME",
            archive = "south africa.zip|magbase.shp",
            archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
            nextUpdate = "unknown",
            updateFrequency = "notPlanned",
            update = updateTables)

regGeometry(nation = "South Africa",
            gSeries = "agCensus",
            level = 2,
            nameCol = "SAGEADMCDE",
            archive = "south africa.zip|safrica_ad1.shp",
            archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
            nextUpdate = "uknown",
            updateFrequency = "notPlanned",
            update = updateTables)


# register census tables ----
#

# # spam ----
# regTable(nation = "South Africa",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1975,
#          end = 2015,
#          archive = "southafrica.zip|1970-2015_level2_harvProd.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 2,
#          subset = "census",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2007,
#          archive = "southafrica.zip|2007_level2_harvProd_census.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2011,
#          archive = "southafrica.zip|2009-2011_level2_harvArea.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2011,
#          archive = "southafrica.zip|2009-2011_level2_Prod.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2015,
#          end = 2015,
#          archive = "southafrica.zip|2015_level1_HarvProdHeacount.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2016,
#          end = 2016,
#          archive = "southafrica.zip|2016_level1_HarvProdHeacount.csv",
#          update = myUpdate)
#
# # agCensus----
# regTable(nation = "South Africa",
#          level = 3,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1960,
#          end = 1993,
#          archive = "southafrica.zip|1960-1993_harvArea_Prod_level 3.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1911,
#          end = 1993,
#          archive = "southafrica.zip|crops general_level3_PlantedArea_1911-1993.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "forest",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1911,
#          end = 1993,
#          archive = "southafrica.zip|forest_level3_PlantedArea_1911-1993.csv",
#          update = myUpdate)
#
#
# schema_agCensus2 <- makeSchema()
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "freestates-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|freestates_2002_ProdHarvArea_level3_census.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "gauteng-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|gauteng_2002_ProdHarvArea_level3_census.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "kwazulu-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|kwazulu_2002_ProdHarvArea_level3_census.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "limpopo-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|limpopo_2002_ProdHarvArea_level3_census.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "mpumalanga-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|mpumalanga_2002_ProdHarvArea_level3_census.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "northernCape-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|northernCape_2002_ProdHarvArea_level3_census.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "northwest-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|northwest_2002_ProdHarvArea_level3_census.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "westernCape-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|westernape_2002_ProdHarvArea_level3_census.csv",
#          update = myUpdate)
#
# schema_agCensus3 <- makeSchema()
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "freestates-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus3,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|freestates_2002_headcount_level3_census.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "gauteng-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|gauteng_2002_headcount_level3_census.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "kwazulu-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|kwazulu_2002_headcount_level3_census.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "limpopo-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|limpopo_2002_headcount_level3_census.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "mpumalanga-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|mpumalanga_2002_headcount_level3_census.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "northernCape-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|northernCape_2002_headcount_level3_census.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "northwest-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|northwest_2002_headcount_level3_census.csv",
#          update = myUpdate)
#
# regTable(nation = "South Africa",
#          level = 3,
#          subset = "westernCape-census",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2002,
#          end = 2002,
#          archive = "southafrica.zip|westernape_2002_headcount_level3_census.csv",
#          update = myUpdate)


# harmonise commodities ----
#
for(i in seq_along(ds)){

  tibble(new = get_variable(variable = "commodities", dataseries = ds[i])) %>%
    match_ontology(table = ., columns = "new", dataseries = ds[i], ontology = ontoDir)

}


# normalise geometries ----
#
# normGeometry(nation = thisNation,
#              pattern = gs[3],
#              outType = "gpkg",
#              update = updateTables)


# normalise census tables ----
#
normTable(pattern = ds[1],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)

normTable(pattern = ds[2],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)

