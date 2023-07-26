# India ----
#
## agCensus ----
#
# regGeometry(nation = "India",
#             gSeries = "agCensus",
#             level = 2,
#             nameCol = "STATE",
#             archive = "india.zip|india_st.shp",
#             archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
#             updateFrequency = "notPlanned",
#             update = TRUE)
#
# regGeometry(nation = "India",
#             gSeries = "agCensus",
#             level = 3,
#             nameCol = "DISTRICT",
#             archive = "india.zip|india_ds.shp",
#             archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
#             updateFrequency = "notPlanned",
#             update = TRUE)
#
# schema_agCensus1 <- makeSchema()
#
# regTable(nation = "India",
#          level = 3,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1991,
#          end = 2003,
#          archive = "India.zip|india-george-raw.level3.plantedArea.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1995,
#          end = 2006,
#          archive = "India.zip|India95-06.level2.plantedArea.general.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "soy",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1970,
#          end = 2008,
#          archive = "India.zip|IndiaSoy.level2.1970-2008.prod.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "soy",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1970,
#          end = 2008,
#          archive = "India.zip|IndiaSoy.level2.1970-2008.harvarea.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "soy",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1970,
#          end = 2008,
#          archive = "India.zip|IndiaSoy.level2.1970-2008.yield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "grazingArea",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1992,
#          end = 2007,
#          archive = "India.zip|IndiaPasture.grazingland.level2.1992-2007.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "maize",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1950,
#          end = 2006,
#          archive = "India.zip|IndiaStatewiseMaize.level2.1950-2006.prod.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "maize",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1950,
#          end = 2006,
#          archive = "India.zip|IndiaStatewiseMaize.level2.1950-2006.harvarea.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "maize",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1950,
#          end = 2006,
#          archive = "India.zip|IndiaStatewiseMaize.level2.1950-2006.yield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "forest",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1950,
#          end = 2006,
#          archive = "India.zip|NationalLandUse50-06.level1.plantedArea&Forest.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)


## spam ----
#
# regTable(nation = "India",
#          level = 3,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2000,
#          end = 2012,
#          archive = "India.zip|all crops for india.level3.HarvProdYield.2000-2012.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "PidgeonPeas",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaGrasspea.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "SpikedMillet",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiasmallMillet.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "Barley",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaBarley.level2.1977-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "castorSeed",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaCastorSeed.level2.1977-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "cocoa",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaCocoa.level2.1977-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "coffee",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaCoffee.level2.1977-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "cotton",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaCotton.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "cottonSolo",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaCottonsolo.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "bengalGram",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaBengalGram.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "groundNut",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaGroundNut.level2.1997-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "horseGram",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaHorsegram.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "greatMillet",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaGreatMillet.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "juteMesta",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaJuteMesta.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "grassPea",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaGrasspea.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "linseed",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaLinseed.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "maize",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaMaize.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "lentil",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaLentil.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "moongBeans",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaMoongBeans.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "moth",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaMoth.level2.1997-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "nigerSeeds",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaNigerseed.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "otherCrops",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1987,
#          end = 2003,
#          archive = "India.zip|IndiaotherCrops.level2.1987-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "smallMillet",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiasmallMillet.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "rapeSeed",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaRapesseedMustard.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "rice",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1997,
#          end = 2003,
#          archive = "India.zip|IndiaRice.level2.1997-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "rubber",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1976,
#          end = 2003,
#          archive = "India.zip|IndiaRubber.level2.1976-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "saffllower",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaSafflower.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "sanhamp",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaSanhamp.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "sesamum",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaSesamum.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "sugarCane",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1977,
#          end = 2003,
#          archive = "India.zip|Sugarcane.xls",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "soy",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaSoy.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "sunFlower",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaSunflower.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "tea",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaTea.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "tobacco",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaTobacco.level2.1997-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "urad",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaUrad.level2.1998-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)
#
# regTable(nation = "India",
#          level = 2,
#          subset = "wheat",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1998,
#          end = 2003,
#          archive = "India.zip|IndiaWheat.level2.1977-2003.harvareaProdYield.csv",
#          update = myOverwrite,
#          overwrite = myOverwrite)


# Australia ----
#
## agCensus----
#
# schema_agCensus1 <- makeSchema()
#
# regTable(nation = "Australia",
#          level = 2,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2006,
#          end = 2006,
#          archive = "australia.zip|Australia_Area_2006.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 2,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2007,
#          end = 2007,
#          archive = "australia.zip|Australia_Area_2007.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 2,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2008,
#          end = 2008,
#          archive = "australia.zip|Australia_Area__Prod_2008.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "australia.zip|Australia_level3_area_2009.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "australia.zip|Australia_level3_prod_2009.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "australia.zip|Australia_level3_area_2010.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "australia.zip|Australia_level3_prod_2010.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 2,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2006,
#          end = 2006,
#          archive = "australia.zip"|"Australia_Prod_2006.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 2,
#          subset = "fuits&others",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2007,
#          end = 2007,
#          archive = "australia.zip"|"Australia_Prod_2007.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 2,
#          subset = "fuits&others",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2008,
#          end = 2008,
#          archive = "australia.zip"|"Australia_Prod_2008.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 2,
#          subset = "fuits&others",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "australia.zip"|"Australia_Prod_2009.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 2,
#          subset = "fuits&others",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "australia.zip"|"Australia_Prod_2010.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
## spam ----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Australia",
#          level = 1,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|Australia_level1_areaProdYieldHeadcount_2013-2014.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "victoria",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_victoria.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "victoria",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_victoria.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "australianCapitalTerritory",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_australianCapitalTerritory.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "australianCapitalTerritory",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_australianCapitalTerritory.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "newWales",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_newWales.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "newWales",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_newWales.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "northernTerritory",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_northernTerritory.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "northernTerritory",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_northernTerritory.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "queensland",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_queensland.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "queensland",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_queensland.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "southAustralia",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_southAustralia.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "southAustralia",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_southAustralia.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "tasmania",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_tasmania.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "tasmania",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_tasmania.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "westernAustralia",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2010-11_westernAustralia.csv",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Australia",
#          level = 3,
#          subset = "westernAustralia",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "australia.zip|australia_level2_AreaProdYieldHeacount_2013-14_westernAustralia.csv",
#          update = updateTables,
#          overwrite = overwriteTables)


# United States of America ----
#
## agCensus ----
#
# regGeometry(nation = "United States of America",
#             gSeries = "agCensus",
#             level = 3,
#             nameCol = "AGCONMLC",
#             archive = "nass.zip|CoGenAll_D02.shp",
#             archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
#             updateFrequency = "notPlanned",
#             update = TRUE)
#
# regGeometry(nation = "United States of America",
#             gSeries = "agCensus",
#             level = 2,
#             nameCol = "AGSTNMLC",
#             archive = "nass.zip|StGenAll_D02.shp",
#             archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
#             updateFrequency = "notPlanned",
#             update = TRUE)


# Mexico ----
#
## spam ----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Mexico",
#          level = 3,
#          subset= "perm",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = schema_spam1,
#          begin = 2009,
#          end = 2009,
#          archive = "LAC.zip|AGRICOLA_SIAP_2009_2010_2011.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 3,
#          subset= "temp",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = schema_spam1,
#          begin = 2009,
#          end = 2009,
#          archive = "LAC.zip|AGRICOLA_SIAP_2009_2010_2011.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 3,
#          subset= "perm",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = schema_spam1,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|AGRICOLA_SIAP_2009_2010_2011.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 3,
#          subset= "temp",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = schema_spam1,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|AGRICOLA_SIAP_2009_2010_2011.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 3,
#          subset= "perm",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = schema_spam1,
#          begin = 2011,
#          end = 2011,
#          archive = "LAC.zip|AGRICOLA_SIAP_2009_2010_2011.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 3,
#          subset= "temp",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = schema_spam1,
#          begin = 2011,
#          end = 2011,
#          archive = "LAC.zip|AGRICOLA_SIAP_2009_2010_2011.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# schema_spam2 <- makeSchema()
#
# regTable(nation = "Mexico",
#          level = 2,
#          subset= "fallTemp",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = schema_spam2,
#          begin = 1980,
#          end = 2015,
#          archive = "LAC.zip|MAIZ_PV-OI_1980_2015.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 2,
#          subset= "springTemp",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = schema_spam2,
#          begin = 1980,
#          end = 2015,
#          archive = "LAC.zip|MAIZ_PV-OI_1980_2015.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 2,
#          subset= "springPerm",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = schema_spam2,
#          begin = 1980,
#          end = 2015,
#          archive = "LAC.zip|MAIZ_PV-OI_1980_2015.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mexico",
#          level = 2,
#          subset= "fallPerm",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = schema_spam2,
#          begin = 1980,
#          end = 2015,
#          archive = "LAC.zip|MAIZ_PV-OI_1980_2015.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# schema_spam3 <- makeSchema()
#
# regTable(nation = "Mexico",
#          level = 2,
#          subset= "maize",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = schema_spam3,
#          begin = 1980,
#          end = 2014,
#          archive = "LAC.zip|maiz_grano_1980-2014.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)

# Paraguay ----
#
## spam ----
#
# schema_pry2 <- setCluster(id = "commodity", top = c(17, 54, 96, 135, 173, 211, 250, 288, 327, 366, 404, 442, 480, 518), left = 1, height = 20) %>%
#   setIDVar(name = "al2", columns = 1) %>%
#   setIDVar(name = "year", columns = .find(col = c(2, 5, 8, 11, 14), relative = TRUE), rows = 1, split = "(?<=\\/).*") %>%
#   setIDVar(name = "commodity", columns = 1, rows = c(11, 48, 90, 133, 167, 205, 242, 280, 319, 358, 396, 434, 472, 512), split = "(?<=\\: ).*") %>%
#   setObsVar(name = "harvested", unit = "ha", columns = .find(col = c(2, 5, 8, 11, 14), relative = TRUE) , top = 2) %>%
#   setObsVar(name = "production", unit = "t", columns = .find(col = c(3, 6, 9, 12, 15), relative = TRUE), top = 2) %>%
#   setObsVar(name = "yield", unit = "kg/ha", columns = .find(col = c(4, 7, 10, 13, 16), relative = TRUE), top = 2)
#
# regTable(nation = "Paraguay",
#          subset = "crops",
#          label = "al2",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = schema_pry2,
#          begin = 2008,
#          end = 2012,
#          archive = "Paraguay_2016.04.25.xlsx",
#          archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0",
#          updateFrequency = "not planned",
#          nextUpdate = "unknown",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)
#

# Brazil ----
#
## spam ----
#
# regTable(nation = !!thisNation,
#          label = "al3",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = meta_spam52,
#          begin = 2006,
#          end = 2006,
#          archive = "woodSichra_Brazil_data.rar|Brazilmun_key_Pasture2006.dbf",
#          archiveLink = "https://www.dropbox.com/sh/wmfktyq34on5jbn/AACrD6p2HjVZH2EwaMPS04Xua?dl=0",
#          updateFrequency = "not planned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = updateTables)


# Angola ----
#
## spam ----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Angola",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2011,
#          archive = "angola.zip|level2_2009-2011_HarvArea.csv",
#          update = myUpdate,
#          overwrite = myoverwrite)
#
# regTable(nation = "Angola",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2011,
#          archive = "angola.zip|level2_2009-2011_prod.csv",
#          update = myUpdate,
#          overwrite = myoverwrite)
#
# regTable(nation = "Angola",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1999,
#          end = 2012,
#          archive = "angola.zip|level2_1999-2012_ProdHarvAreaYield.csv",
#          update = myUpdate,
#          overwrite = myoverwrite)
#
## agCensus ----
#
# regGeometry(nation = "Angola",
#             gSeries = "agCensus",
#             level = 3,
#             nameCol = "NAME2_",
#             archive = "angola.zip|afr_ad1.shp",
#             archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
#             updateFrequency = "notPlanned",
#             update = updateTables)
#
# regGeometry(nation = "Angola",
#             gSeries = "agCensus",
#             level = 2,
#             nameCol = "NAME1_",
#             archive = "angola.zip|afr_ad2.shp",
#             archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
#             updateFrequency = "notPlanned",
#             update = updateTables)
#
# schema_agCensus1 <- makeSchema()
#
# regTable(nation = "Angola",
#          level = 2,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1967,
#          end = 1968,
#          archive = "angola.zip|angola_1968_level2_harvProdYield.csv",
#          update = myUpdate,
#          overwrite = myoverwrite)


# Belize ----
#
## spam ----
# meta_spam97 <- makeSchema(
#   #No period shown
#   list(clusters = list(top = 1, left = NULL, width = NULL, height = NULL,
#                        id = NULL),
#        variables = list(territories =
#                           list(type = "id", name = "al",
#                                row = NULL, col = c(al2 = 4), rel = FALSE),
#                         commodities =
#                           list(type = "id", name = NULL,
#                                row = 1, col = c(7:49), rel = FALSE),
#                         harvested =
#                           list(type = "values", unit = "ha", factor = 1,
#                                row = NULL, col = c(7:49), rel = FALSE,
#                                key = "Element", value = "Harvested Area"))))
#
# regTable(nation = "Belize",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = meta_spam97,
#          begin = 2005,
#          end = 2005,
#          archive = "LAC.zip|stat_area_2005.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)

# Chile ----
#
## spam ----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Chile",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2003,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "fruits",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "fruits",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2012,
#          end = 2015,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "ARICA Y PARINACOTA",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "atacama",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "coquimbo",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "araucania",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "o`higgins",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "valparaiso",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "biobio",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "maule",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          subset = "rmSantiago",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2012,
#          end = 2013,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2013,
#          end = 2014,
#          archive = "LAC.zip",
#          update = myUpdate)
#
# regTable(nation = "Chile",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2014,
#          end = 2015,
#          archive = "LAC.zip",
#          update = myUpdate)


# Columbia ----
#
## spam ----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Colombia",
#          level = 3,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2014,
#          archive = "LAC.zip|produccionagricola.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Colombia",
#          level = 2,
#          subset = "sesame",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1987,
#          end = 2012,
#          archive = "LAC.zip|anexos_ena_2010.xls",
#          update = myUpdate)
#
# regTable(nation = "Colombia",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|anexos_ena_2010.xls",
#          update = myUpdate)
#
# regTable(nation = "Colombia",
#          level = 2,
#          subset = "forest",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|anexos_ena_2010.xls",
#          update = myUpdate)
#
# regTable(nation = "Colombia",
#          level = 1,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2000,
#          end = 2012,
#          archive = "LAC.zip|Colombia_Irrigated_Rainfed.xlsx",
#          update = myUpdate)


# Costa Rica ----
#
## spam ----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "rice",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2005,
#          end = 2010,
#          archive = "LAC.zip|rptAreaYProduccion_arroz.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset = "rice",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2010,
#          archive = "LAC.zip|rptAreaYProduccion_arroz.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "rice",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "LAC.zip|rptAreaYProduccion_arroz.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "banana",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_banana.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "coffee",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_coffee.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "fruits",
#          dSeries = "spam",
#          gSeries = "spam"
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_fruits.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "tobacco",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_tobacco.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "sugarCane",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_sugarcane.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "rice",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_arroz.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "diverse",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_diverse.xls",
#          update = myUpdate)
#
# regTable(nation = "Costa Rica",
#          level = 2,
#          subset= "majorCrops",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2012,
#          archive = "LAC.zip|rptAreaYProduccion_majorcrops.xls",
#          update = myUpdate)


# Cuba ----
#
## spam ----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Cuba",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agricultura en Cifras Cuba 2010.xlsx",
#          update = myUpdate)


# Dominican Republic ----
#
## spam ----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Dominican Republic",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2014,
#          archive = "LAC.zip|2.14-Producci├│n-Anual-por-Regional-2010-2014..xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Dominican Republic",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2014,
#          archive = "LAC.zip|Superficie Cosechada Anual por Regional, 2010-2014.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Dominican Republic",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2014,
#          archive = "LAC.zip|Superficie Sembrada Anual por Regional, 2010-2014.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Dominican Republic",
#          level = 2,
#          subset = "bajoAmbiente",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2014,
#          archive = "LAC.zip|superficie_cultivada_bajo_ambiente_protegido__2009-2014.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)


# Ecuador ----
#
## spam ----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "permanentCrop",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "LAC.zip|bdd_espac_2009.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "permanentCrop",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|bdd_espac_2010.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "permanentCrop",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2011,
#          end = 2011,
#          archive = "LAC.zip|bdd_espac_2011.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "tempCrop",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "LAC.zip|bdd_espac_2009.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "tempCrop",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|bdd_espac_2010.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "tempCrop",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2011,
#          end = 2011,
#          archive = "LAC.zip|bdd_espac_2011.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "forest",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "LAC.zip|bdd_espac_2009.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "forest",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|bdd_espac_2010.zip",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Ecuador",
#          level = 2,
#          subset = "forest",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2011,
#          end = 2011,
#          archive = "LAC.zip|bdd_espac_2011.zip",
#          update = updateTables,
#          overwrite = overwriteTables)


# El Salvador ----
#
## spam ----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "El Salvador",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2006,
#          end = 2007,
#          archive = "LAC.zip|anuario de estadsticas agropecuarios 06-07.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "El Salvador",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2010,
#          archive = "LAC.zip|anuario estadstico 2009-2010.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "El Salvador",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "LAC.zip|anuario de estadisticas agropecuarias 2010-2011.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)


# Ethiopia ----
#
## spam ----
#
# regTable(nation = "Ethiopia",
#          level = 3,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2005,
#          end = 2007,
#          archive = "ethiopia.zip|prod.level3.2005-2007.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Ethiopia",
#          level = 3,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2005,
#          end = 2007,
#          archive = "ethiopia.zip|Harvarea.level3.2005-2007.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Ethiopia",
#          level = 3,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2011,
#          end = 2011,
#          archive = "ethiopia.zip|prodHarvarea.level3.2009.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Ethiopia",
#          level = 3,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "ethiopia.zip|prodHarvarea.level3.2009.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Ethiopia",
#          level = 3,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "ethiopia.zip|prodHarvarea.level3.2009.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Ethiopia",
#          level = 1,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2013,
#          end = 2013,
#          archive = "ethiopia.zip|Main crops 2013 - Production.level1.harv.prod.yiedl.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Ethiopia",
#          level = 1,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2001,
#          end = 2016,
#          archive = "ethiopia.zip|lvel1.yield.2001-2016.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)

# Guatemala ----
#
## spam ----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "sugarCane",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2011,
#          end = 2012,
#          archive = "LAC.zip|Guatemala_Production_2012.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "sugarCane",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2012,
#          end = 2013,
#          archive = "LAC.zip|Guatemala_Production_2013.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "rice",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2011,
#          end = 2012,
#          archive = "LAC.zip|Guatemala_Production_2012.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "rice",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2012,
#          end = 2013,
#          archive = "LAC.zip|Guatemala_Production_2013.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "teaCitronele",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2011,
#          end = 2012,
#          archive = "LAC.zip|Guatemala_Production_2012.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "teaCitronele",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2012,
#          end = 2013,
#          archive = "LAC.zip|Guatemala_Production_2013.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "forest",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2011,
#          end = 2012,
#          archive = "LAC.zip|Guatemala_Production_2012.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Guatemala",
#          level = 2,
#          subset = "forest",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2012,
#          end = 2013,
#          archive = "LAC.zip|Guatemala_Production_2013.xls",
#          update = updateTables,
#          overwrite = overwriteTables)


# Haiti ----
#
## spam----
#
# regTable(nation = "Haiti",
#          level = 3,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2012,
#          end = 2012,
#          archive = "LAC.zip|Superficie Agricole Utile occup├йe par les c├йr├йales, SAU par type de culture 2012 departement.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Haiti",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|Haiti_data_2010.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)


# Honduras ----
#
## spam----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Honduras",
#          level = 2,
#          subset = "coffee",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "LAC.zip|Coffee 3.1.3.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Honduras",
#          level = 2,
#          subset = "coffee",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "LAC.zip|Coffee 3.1.3.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Honduras",
#          level = 1,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1992,
#          end = 2010,
#          archive = "LAC.zip|Honduras_2017.10.18.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Honduras",
#          level = 1,
#          subset = "annualCrops",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2008,
#          archive = "LAC.zip|CULT ANUAL.pdf",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Honduras",
#          level = 1,
#          subset = "permCrops",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2007,
#          end = 2008,
#          archive = "LAC.zip|CULT PERM.pdf",
#          update = updateTables,
#          overwrite = overwriteTables)


# Jamaica ----
#
## spam----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Jamaica",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = schema_spam1,
#          begin = 2005,
#          end = 2005,
#          archive = "LAC.zip|stat_area_2005.csv",
#          update = updateTables,
#          overwrite = overwriteTables)


# kenya ----
#
## spam----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Kenya",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = schema_spam1,
#          begin = 2006,
#          end = 2008,
#          archive = "kenya.zip|2006-2008_harvArea_level2.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Kenya",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = schema_spam1,
#          begin = 2006,
#          end = 2008,
#          archive = "kenya.zip|2006-2008_prod_level2.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
## agCensus----
#
# regGeometry(gSeries = "agCensus",
#             level = 3,
#             nameCol = "NAME2_",
#             archive = "angola.zip|afr_ad1.shp",
#             archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
#             nextUpdate = "unknown",
#             updateFrequency = "notPlanned",
#             update = TRUE)
#
# regGeometry(gSeries = "agCensus",
#             level = 2,
#             nameCol = "NAME1_",
#             archive = "angola.zip|afr_ad2.shp",
#             archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
#             nextUpdate = "unknown",
#             updateFrequency = "notPlanned",
#             update = TRUE)
#
# schema_agCensus1 <- makeSchema()
#
# regTable(nation = "Kenya",
#          level = 3,
#          subset = "wheat",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus1,
#          begin = 1964,
#          end = 2008,
#          archive = "kenya.zip|Kenya_Subnational_ProdHarvArea-1964-2008.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Kenya",
#          level = 3,
#          subset = "maize",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus1,
#          begin = 1964,
#          end = 2008,
#          archive = "kenya.zip|Kenya_Subnational_Maize_ProdHarvArea-1964-2008.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Kenya",
#          level = 3,
#          subset = "rice",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus1,
#          begin = 1964,
#          end = 2008,
#          archive = "kenya.zip|Kenya_Subnational_Rice_ProdHarvArea-1964-2008.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# schema_agCensus2 <- makeSchema()
#
# regTable(nation = "Kenya",
#          level = 2,
#          subset = "maize",
#          dSeries = "agCensus"
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2005,
#          end = 2008,
#          archive = "kenya.zip|Maize_Kenya_Prod_2005-2008.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Kenya",
#          level = 2,
#          subset = "rice",
#          dSeries = "agCensus",
#          gSeries = "agCensus"
#          schema = schema_agCensus2,
#          begin = 2005,
#          end = 2008,
#          archive = "kenya.zip|Rice_Kenya_ProdHarvArea_2005-2008.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Kenya",
#          level = 2,
#          subset = "wheat",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = schema_agCensus2,
#          begin = 2005,
#          end = 2008,
#          archive = "kenya.zip|Wheat_Kenya_ProdHarvArea_2005-2008.csv",
#          update = myUpdate,
#          overwrite = myOverwrite)


# Mozambique ----
#
## spam----
#
# regTable(nation = "Mozambique",
#          subset = "production",
#          level = 1,
#          dSeries = "spam",
#          gSeries = "mozgis",
#          schema = ,
#          begin = 2002,
#          end = 2008,
#          archive = "mozambique.zip|Mozambique_2002-08_Production_CountryStatAdm1.csv",
#          archiveLink = "https://www.dropbox.com/sh/wmfktyq34on5jbn/AAAfU-ZGdaj281Sl9BviAd-Aa/Stats_SPAM2005/SSA/Mozambique?dl=0&preview=Source.docx&subfolder_nav_tracking=1",
#          updateFrequency = "unknown",
#          metadataLink = "https://www.dropbox.com/sh/wmfktyq34on5jbn/AAAfU-ZGdaj281Sl9BviAd-Aa/Stats_SPAM2005/SSA/Mozambique?dl=0&preview=Source.docx&subfolder_nav_tracking=1",
#          #Note: The original link was http://www.ine.gov.mz/en/BulkDownload - no longer active, data given by spam Partners
#          metadataPath = "unavailable",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mozambique",
#          subset = "harvArea",
#          level = 1,
#          dSeries = "spam",
#          gSeries = "mozgis",
#          schema = ,
#          begin = 2002,
#          end = 2008,
#          archive = "mozambique.zip|Mozambique_2002-08_HarvArea_CountryStatAdm1.csv",
#          archiveLink = "https://www.dropbox.com/sh/wmfktyq34on5jbn/AAAfU-ZGdaj281Sl9BviAd-Aa/Stats_SPAM2005/SSA/Mozambique?dl=0&preview=Source.docx&subfolder_nav_tracking=1",
#          updateFrequency = "unknown",
#          metadataLink = "https://www.dropbox.com/sh/wmfktyq34on5jbn/AAAfU-ZGdaj281Sl9BviAd-Aa/Stats_SPAM2005/SSA/Mozambique?dl=0&preview=Source.docx&subfolder_nav_tracking=1",
#          #Note: The original link was http://www.ine.gov.mz/en/BulkDownload - no longer active, data given by spam Partners
#          metadataPath = "unavailable",
#          update = updateTables,
#          overwrite = overwriteTables)


# Nicaragua ----
#
## spam----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Nicaragua",
#          level = 3,
#          subset= "maize",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "LAC.zip|Ma├нz y Frijol ciclo 2010-2011 (CIAT).xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Nicaragua",
#          level = 3,
#          subset= "beans",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "LAC.zip|Ma├нz y Frijol ciclo 2010-2011 (CIAT).xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Nicaragua",
#          level = 3,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2001,
#          end = 2001,
#          archive = "LAC.zip|nicaragua granos municipios 2001.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Nicaragua",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2010,
#          end = 2011,
#          archive = "LAC.zip|Informe Final IV Cenagro.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)


# Nigeria ----
#
## agCensus ----
#
# schema_agCensus1 <- makeSchema()
#
# regTable(nation = "Nigeria",
#          level = 3,
#          subset = "Forestry",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2000,
#          end = 2018,
#          archive = "NGA.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          subset = "Forestry",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2000,
#          end = 2018,
#          archive = "NGA.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "nigeria.zip|NigeriaOtherCrops.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          subset = "cottonSeed",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2009,
#          end = 2011,
#          archive = "nigeria.zip|MergeAreaProduction.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          subset = "cottonSeed",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2009,
#          end = 2011,
#          archive = "nigeria.zip|MergeAreaProduction.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          subset = "cottonSeed",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2009,
#          end = 2011,
#          archive = "nigeria.zip|MergeAreaProduction.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          subset = "cottonSeed",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2009,
#          end = 2011,
#          archive = "nigeria.zip|MergeAreaProduction.xlsx",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "nigeria.zip|NASS-2011",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          subset = "sugarCane",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 1999,
#          end = 2010,
#          archive = "nigeria.zip|NASS-2011",
#          update = myUpdate)
#
# regTable(nation = "Nigeria",
#          level = 2,
#          subset = "oilPalm",
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "nigeria.zip|NASS-2011",
#          update = myUpdate)


# Panama ----
#
## spam----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Panama",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 1950,
#          end = 2011,
#          archive = "LAC.zip|P3641Cuadro18.xls",
#          update = myUpdate)
#
# regTable(nation = "Panama",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2001,
#          end = 2011,
#          archive = "LAC.zip|P3641Cuadro17.xls",
#          update = myUpdate)
#
# regTable(nation = "Panama",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2011,
#          end = 2011,
#          archive = "LAC.zip|P3641Cuadro16.xls",
#          update = myUpdate)
#
# regTable(nation = "Panama",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2011,
#          end = 2011,
#          archive = "LAC.zip|P3641Cuadro5.xls",
#          update = myUpdate)
#
# regTable(nation = "Panama",
#          level = 2,
#          subset = "perm",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2011,
#          end = 2011,
#          archive = "LAC.zip|P3641Cuadro15.xls",
#          update = myUpdate)


# Peru ----
#
## spam ----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Peru",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2009,
#          end = 2011,
#          archive = "LAC.zip|Peru_DownloadFromOEEE.xlsx",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Peru",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2012,
#          end = 2012,
#          archive = "LAC.zip|2012_data_produccion_agricola.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Peru",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2012,
#          end = 2012,
#          archive = "LAC.zip|2012_data_produccion_agricola.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Peru",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2012,
#          end = 2012,
#          archive = "LAC.zip|2012_data_produccion_agricola.xls",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Peru",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2012,
#          end = 2012,
#          archive = "LAC.zip|2012_data_produccion_agricola.xls",
#          update = updateTables,
#          overwrite = overwriteTables)


# South Africa ----
#
## spam ----
#
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
## agCensus ----
#
# regGeometry(nation = "South Africa",
#             gSeries = "agCensus",
#             level = 2,
#             nameCol = "SAGEADMCDE",
#             archive = "south africa.zip|safrica_ad1.shp",
#             archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
#             nextUpdate = "uknown",
#             updateFrequency = "notPlanned",
#             update = updateTables)
#
# regGeometry(nation = "South Africa",
#             gSeries = "agCensus",
#             level = 3,
#             nameCol = "NAME",
#             archive = "south africa.zip|magbase.shp",
#             archiveLink = "https://www.dropbox.com/sh/6usbrk1xnybs2vl/AADxC-vnSTAg_5_gMK6cW03ea?dl=0%22",
#             nextUpdate = "unknown",
#             updateFrequency = "notPlanned",
#             update = updateTables)
#
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


# Trinidad and Tobago ----
#
## spam ----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Trinidad and Tobago",
#          level = 2,
#          subset = "pigs",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "selectedCrops",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "Trinidad",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "Tobago",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Tobago Agri Report- Tables 1-7.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "Forest",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2004,
#          end = 2004,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "Trinidad",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "Tobago",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Tobago Agri Report- Tables 1-7.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "flowers",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "pigs",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Trinidad and Tobago",
#          level = 1,
#          subset = "smallRuminants",
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2006,
#          end = 2010,
#          archive = "LAC.zip|Agri Report 2006-2010 Tables 1-51.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)


# Turkey ----
#
## agCensus ----
#
# regTable(nation = "Turkey",
#          level = 3,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2001,
#          end = 2001,
#          archive = "turkey.zip|Turkey_census.xls",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Turkey",
#          level = 3,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "turkey.zip|Turkey_2015.04.01.xlsx",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Turkey",
#          level = 3,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "turkey.zip|Turkey_2015.04.01.xlsx",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Turkey",
#          level = 3,
#          dSeries = "agCensus",
#          gSeries = "agCensus",
#          schema = ,
#          begin = 2010,
#          end = 2010,
#          archive = "turkey.zip|Turkey_2015.04.01.xlsx",
#          update = myUpdate,
#          overwrite = myOverwrite)


# Uruguay ----
#
## spam ----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Uruguay",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2003,
#          end = 2011,
#          archive = "LAC.zip|DIEA-Anuario-2012web.xlsx",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Uruguay",
#          level = 2,
#          dSeries = "spam",
#          gSeries = "spam",
#          schema = ,
#          begin = 2011,
#          end = 2011,
#          archive = "LAC.zip|censo2011.xlsx",
#          update = myUpdate,
#          overwrite = myOverwrite)


# Venezuela ----
#
## spam ----
#
# schema_spam1 <- makeSchema()
#
# regTable(nation = "Venezuela",
#          level = 3,
#          dSeries = "spam",
#          gSeries = "spam",
#          variable = c("production"),
#          schema = ,
#          begin = 2008,
#          end = 2008,
#          archive = "LAC.zip|Venezuela_level2_2016.04.20_UWS.xlsx",
#          update = myUpdate,
#          overwrite = myOverwrite)
#
# regTable(nation = "Venezuela",
#          level = 3,
#          dSeries = "spam",
#          gSeries = "spam",
#          variable = c("planted_area"),
#          schema = ,
#          begin = 2008,
#          end = 2008,
#          archive = "LAC.zip|Venezuela_level2_2016.04.20_UWS.xlsx",
#          update = myUpdate,
#          overwrite = myOverwrite)


#  ----
#


#  ----
#


#  ----
#



