# Important notes for the abbreviations in some of the Mali datasets:

#  OPIB: Office du Perimetre Irrigue de Baguineda
#  ORM: Office Riz Morti (Morti Rice Development Authority)
#  ODRS:Office de development Rural de Selingue ( consists of 2 regions, 4 circles, 19 communes: Sikasso and Kulikoro
#  ORS:
#  PAPAM: Programme d'amélioration de la productivité agricole au Mali:  Project for fostering agricultural productivity)
#	 OHVN: Office de la Haute Vallée du Niger

# script arguments ----
#
thisNation <- "Mali"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("countrySTAT")
gs <- c("gadm36")


# register dataseries ----
#


# register geometries ----
#


# register census tables ----
#
## countrystat ----
schema_mli_00 <-  setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Mali") %>%
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 7)

schema_mli_01 <- schema_mli_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 8)

regTable(nation = "mli",
         subset = "plantedCereal",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2012,
         end = 2016,
         schema = schema_mli_01,
         archive = "D3S_40617977594520356017565769637062649422.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_02 <- schema_mli_00 %>%
  setObsVar(name = "production", unit = "t", columns = 8)

regTable(nation = "mli",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1984,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_83840964298373381894763270952490130824.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "productionCrops",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2012,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_46155480739372929259066091202297882471.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodCashew",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_15455870914506460846530411990908928316.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodGroundnuts",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_61265708303007563306810304403076606657.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodCarotts",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_79692591369996402264682706674379917828.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodLemonsLimes",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_42289791046405504365558222624233121114.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodGreenGarlic",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_47686855719211968708733187603197792249.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodCabbage",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_16111974766278534758895308968406322533.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodGreenBeans",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_82569749278739173266250996088873996428.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodCucumberGherkin",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_11897821335690106226093531984323198809.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodArabicGum",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_59550558379064856768972439309521179540.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodSheanuts",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_87836766405232107327776940717210347125.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodPumpkins",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_30313777834597879148847808179696304762.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodOkra",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_24338251484113335486103171043228449385.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodGuineafowls",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_46015907052670327397009519187516881160.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodOrange",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_76007066959434678268909184936938050033.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodOnion",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_441669557353372878644799636676040301.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodStringBeans",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_21419431443976210915329692958706576489.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = updateTables)

regTable(nation = "mli",
         subset = "prodTangerineMadarin",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_61961433064035910756286731879193699104.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodLettuceChicory",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_15878702689808094438386491672612909336.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodMango",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_88894051347762550436596512322719330915.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodMelon",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_67880751389056520125440610521215807455.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodCarrotsTurnips",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_47096268962468810968474824537111924992.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodPotatoes",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_22199027967092778434855459781170058492.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodPapaya",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_11613482289724617137791454943632900057.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodParsley",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_20781018491305130476167964866178355147.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodSesame",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_38191067424477207985011608099504425786.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodTomato",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_3667443122217105484790065685120137249.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodGuava",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_02,
         archive = "D3S_76203404282763509305584578475077878963.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_03 <- schema_mli_00 %>%
  setIDVar(name = "commodities", columns = 2, rows = 2, split = "(?<=de).*(?=\\()") %>%
  setObsVar(name = "production", unit = "t", columns = 8)

regTable(nation = "mli",
         level = 2,
         subset = "prodPimenta",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_03,
         begin = 2006,
         end = 2016,
         archive = "D3S_89193707286040590434750853649124439950.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         subset = "prodGreenChiliePepper",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_03,
         archive = "D3S_91465366842919317307617505102418531788.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_04 <- schema_mli_00 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 8)

regTable(nation = "mli",
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2001,
         end = 2016,
         schema = schema_mli_04,
         archive = "D3S_44620364085479546728995004508103425085.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mli_05 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Mali") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_mli_06 <- schema_mli_05 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "mli",
         level = 1,
         subset = "prodCerealODRS",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_06,
         begin = 2012,
         end = 2016,
         archive = "D3S_91256602243480103827663702405814866308.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         level = 1,
         subset = "prodFiberCrops",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_06,
         begin = 2000,
         end = 2016,
         archive = "D3S_83736957859665475895301682256249256949.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         level = 1,
         subset = "prodCropsOPIB",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_06,
         begin = 2012,
         end = 2016,
         archive = "D3S_3542744044146716784851237483812469996.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         level = 1,
         subset = "prodVegetablesORM",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_06,
         begin = 2012,
         end = 2016,
         archive = "D3S_35992639466152724174815120072098233097.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         level = 1,
         subset = "prodCerealsOPIB",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_06,
         begin = 2015,
         end = 2015,
         archive = "D3S_4780183670111131107668548066687224124.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         level = 1,
         subset = "prodCottonSeed",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_06,
         begin = 2000,
         end = 2016,
         archive = "D3S_48940830077063832264695465657185433271.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         level = 1,
         subset = "prodORS",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_06,
         begin = 2012,
         end = 2016,
         archive = "D3S_54998206533103954436586407432924612189.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         level = 1,
         subset = "prodVegetablesODRS",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_06,
         begin = 2012,
         end = 2016,
         archive = "D3S_62164455275502433207089183715199261339.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         level = 1,
         subset = "prodVegetableORS",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_06,
         begin = 2012,
         end = 2016,
         archive = "D3S_69756632045203166806004668079295079923.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         level = 1,
         subset = "prodVegFruitsOPIB",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_06,
         begin = 2012,
         end = 2016,
         archive = "D3S_75254721445141355374714025296976146940.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         level = 1,
         subset = "prodCropsORM",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_06,
         begin = 2012,
         end = 2016,
         archive = "D3S_74699943075820797944949331775209824050.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         level = 1,
         subset = "prodPrimaryCrops",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_06,
         begin = 1984,
         end = 2016,
         archive = "D3S_75878231531464747248327981059174033871.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         level = 1,
         subset = "prodSesBeansNutsODRS",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_06,
         begin = 2012,
         end = 2016,
         archive = "D3S_81319888677617489488866281511474120692.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         level = 1,
         subset = "prodZoneOHVN",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_06,
         begin = 2005,
         end = 2016,
         archive = "D3S_81616835647057225887690441405800291562.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         level = 1,
         subset = "prodCropsOHVN",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_06,
         begin = 2012,
         end = 2016,
         archive = "D3S_83414265023895494705289385751329572868.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_07 <- schema_mli_05 %>%
  setObsVar(name = "planted", unit = "ha", columns = 6)

regTable(nation = "mli",
         level = 1,
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_07,
         begin = 2005,
         end = 2008,
         archive = "D3S_20364268385657330258416382997594382159.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_08 <- schema_mli_00 %>%
  setObsVar(name = "headcount", unit = "n", columns = 8)

regTable(nation = "mli",
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2006,
         end = 2016,
         schema = schema_mli_08,
         archive = "D3S_23394832598499509186526136194414131639.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_09 <- schema_mli_05 %>%
  setObsVar(name = "headcount", unit = "n",  columns = 6)

regTable(nation = "mli",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_09,
         begin = 2006,
         end = 2016,
         archive = "D3S_43396223662231552394995631044427789774.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unkown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_10 <- schema_mli_00 %>%
  setIDVar(name = "al2", columns = 5) %>%
  setObsVar(name = "production", unit = "t", columns = 8)

regTable(nation = "mli",
         level = 2,
         subset = "prodPrimaryCultures",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_10,
         begin = 1984,
         end = 2016,
         archive = "D3S_43885916107355407346463808848780391784.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_11 <- schema_mli_05 %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = 6)

regTable(nation = "mli",
         level = 1,
         subset = "yieldGrowthBeansPAPAM",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_11,
         begin = 2015,
         end = 2016,
         archive = "D3S_5128631651339947144946338445472382590.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_12 <- schema_mli_05 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "mli",
         level = 1,
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_12,
         begin = 1984,
         end = 2016,
         archive = "D3S_64868895403810291808935565066883465110.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_13 <- schema_mli_05 %>%
  setObsVar(name = "production Seeds", unit = "t", columns = 6)

regTable(nation = "mli",
         level = 1,
         subset = "prodSeedsQuantity",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_13,
         begin = 2008,
         end = 2009,
         archive = "D3S_24947214276648459737698308719386577633.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_14 <- schema_mli_00 %>%
  setObsVar(name = "production Seeds", unit = "t", columns  = 8)

regTable(nation = "mli",
         level = 2,
         subset = "prodSeedsQuantity",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_14,
         begin = 2008,
         end = 2008,
         archive = "D3S_72328478409652772498016003403017943325.xlsx",
         archiveLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mali.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mli_15 <-
  setIDVar(name = "al2", columns = 4) %>%
  setIDVar(name = "year", columns = 2)

schema_mli_16 <- schema_mli_15 %>%
  setIDVar(name = "commodities", columns = 6) %>%
  setObsVar(name = "planted", unit = "ha", columns = 7)

regTable(nation = "mli",
         level = 2,
         subset = "plantCereals",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_16,
         begin = 2004,
         end = 2004,
         archive = "133MRA075.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA075&tr=947",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA075&tr=947",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mli_17 <-
  setIDVar(name = "al1", value = "Mali") %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 4) %>%
  setObsVar(name = "planted", unit = "ha", columns = 5)

regTable(nation = "mli",
         level = 1,
         subset = "plantLegume",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_17,
         begin = 2004,
         end = 2004,
         archive = "133MRA081.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA081&tr=947",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA081&tr=947",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mli",
         level = 1,
         subset = "plantIndustrialCulture",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_17,
         begin = 2004,
         end = 2004,
         archive = "133MRA086.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA086&tr=947",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA086&tr=947",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_18 <- schema_mli_15 %>%
  setIDVar(name = "commodities", value = "cowpea") %>%
  setObsVar(name = "planted", unit = "ha", columns = 5)

regTable(nation = "mli",
         level = 2,
         subset = "plantCowpea",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_18,
         begin = 2004,
         end = 2004,
         archive = "133MRA084.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA084&tr=947",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA084&tr=947",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mli_19 <-
  setIDVar(name = "al3", columns = 4) %>%
  setIDVar(name = "year", columns = 2)

schema_mli_20 <- schema_mli_19 %>%
  setIDVar(name = "commodities", value = "chikens") %>%
  setObsVar(name = "headcount", unit = "n", columns = 5)

regTable(nation = "mli",
         level = 3,
         subset = "livestockBirds",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_20,
         begin = 2004,
         end = 2004,
         archive = "133MRA120.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA120&tr=947",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA120&tr=947",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_21 <- schema_mli_19 %>%
  setIDVar(name = "commodities", value = "sorghum") %>%
  setObsVar(name = "planted", unit = "ha", columns = 5)

regTable(nation = "mli",
         level = 3,
         subset = "plantSorghum",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_21,
         begin = 2004,
         end = 2004,
         archive = "133MRA249.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA249&tr=947",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA249&tr=947",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_22 <- schema_mli_19 %>%
  setIDVar(name = "commodities", value = "rice") %>%
  setObsVar(name = "planted", unit = "ha", columns = 5)

regTable(nation = "mli",
         level = 3,
         subset = "plantRice",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_22,
         begin = 2004,
         end = 2004,
         archive = "133MRA250.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA250&tr=947",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA250&tr=947",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_23 <- schema_mli_19 %>%
  setIDVar(name = "commodities", value = "cowpea") %>%
  setObsVar(name = "planted", unit = "ha", columns = 5)

regTable(nation = "mli",
         level = 3,
         subset = "plantCowpea",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_23,
         begin = 2004,
         end = 2004,
         archive = "133MRA251.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA251&tr=947",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA251&tr=947",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_24 <- schema_mli_19 %>%
  setIDVar(name = "commodities", value = "millet") %>%
  setObsVar(name = "planted", unit = "ha", columns = 5)

regTable(nation = "mli",
         level = 3,
         subset = "plantMillet",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_24,
         begin = 2004,
         end = 2004,
         archive = "133MRA252.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA252&tr=947",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA252&tr=947",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_25 <- schema_mli_19 %>%
  setIDVar(name = "commodities", value = "maize") %>%
  setObsVar(name = "planted", unit = "ha", columns = 5)

regTable(nation = "mli",
         level = 3,
         subset = "plantMaize",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_25,
         begin = 2004,
         end = 2004,
         archive = "133MRA253.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA253&tr=947",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA253&tr=947",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mli_26 <- schema_mli_19 %>%
  setIDVar(name = "commodities", value = "Groundnuts") %>%
  setObsVar(name = "planted", unit = "ha", columns = 5)

regTable(nation = "mli",
         level = 3,
         subset = "plantGroundNuts",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mli_26,
         begin = 2004,
         end = 2004,
         archive = "133MRA256.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA256&tr=947",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=MLI&ta=133MRA256&tr=947",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


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


# normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg",
#              update = updateTables)

normGeometry(pattern = gs[],
             outType = "gpkg",
             update = updateTables)


# normalise census tables ----
#
## in case the output shall be examined before writing into the DB
# testing <- normTable(nation = thisNation,
#                      update = FALSE,
#                      keepOrig = TRUE)
#
# only needed if FAO datasets have not been integrated before
# normTable(pattern = "fao",
#           outType = "rds",
#           update = updateTables)

normTable(pattern = ds[],
          ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)

