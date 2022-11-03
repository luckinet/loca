# script arguments ----
#
thisNation <- "Europe"

updateTables <- TRUE
overwriteTables <- TRUE


# load metadata ----
#
# source(paste0(mdl0301, "src/02_eurostat_preprocess.R"))

# flag information: https://ec.europa.eu/eurostat/data/database/information
flags <- tibble(flag = c("b", "c", "d", "e", "f", "n", "p", "r", "s", "u", "z"),
                value = c("break in time series", "confidential",
                          "definition differs, see metadata", "estimated",
                          "forecast", "not significatn", "provisional",
                          "revised", "Eurostat estimate", "low reliability",
                          "not applicable"))


# register dataseries ----
#
ds <- c("eurostat")
gs <- c("gadm", "eurostat")

regDataseries(name = ds[1],
              description = "Statistical office of the European Union",
              homepage = "https://ec.europa.eu/eurostat/web/main/home",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)


# register geometries ----
#
regGeometry(gSeries = gs[2],
            label = "al1",
            nameCol = "CNTR_CODE",
            archive = "ref-nuts-2016-03m.shp.zip|Eurostat_NUTS_Level0.gpkg",
            archiveLink = "https://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/administrative-units-statistical-units/nuts#nuts16",
            updateFrequency = "unknown",
            update = updateTables,
            overwrite = overwriteTables)

regGeometry(gSeries = gs[2],
            label = "al2",
            nameCol = "CNTR_CODE|NUTS_NAME",
            archive = "ref-nuts-2016-03m.shp.zip|Eurostat_NUTS_Level1.gpkg",
            archiveLink = "https://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/administrative-units-statistical-units/nuts#nuts16",
            updateFrequency = "unknown",
            update = updateTables,
            overwrite = overwriteTables)

regGeometry(gSeries = gs[2],
            label = "al3",
            nameCol = "CNTR_CODE|NUTS_NAME",
            archive = "ref-nuts-2016-03m.shp.zip|Eurostat_NUTS_Level2.gpkg",
            archiveLink = "https://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/administrative-units-statistical-units/nuts#nuts16",
            updateFrequency = "unknown",
            update = updateTables,
            overwrite = overwriteTables)

# the following is a collection of geometries that were discarded as
# "not_*.gpkg" part of a respective country.
#
# regGeometry(nation = "NUTS_NAME", # use name column and not country code (which is finland)
#             subset = "åland", # subset necessary to register new geometry as subset of eurostat level 1
#             gSeries = "eurostat",
#             label = "al1",
#             nameCol = "CNTR_CODE|NUTS_NAME",
#             archive = "_2__eurostat_not-finland.gpkg",
#             archiveLink = "",
#             updateFrequency = "unknown",
#             update = TRUE,
#             overwrite = FALSE)
#
# regGeometry(nation = "CNTR_CODE",
#             subset = "slovakia",
#             gSeries = "eurostat",
#             label = "al1",
#             nameCol = "CNTR_CODE|NUTS_NAME",
#             archive = "_2__eurostat_not-slovakia.gpkg",
#             archiveLink = "",
#             updateFrequency = "unknown",
#             update = TRUE,
#             overwrite = FALSE)
#
# regGeometry(nation = "CNTR_CODE",
#             subset = "slovenia",
#             gSeries = "eurostat",
#             label = "al1",
#             nameCol = "CNTR_CODE|NUTS_NAME",
#             archive = "_2__eurostat_not-slovenia.gpkg",
#             archiveLink = "",
#             updateFrequency = "unknown",
#             update = TRUE,
#             overwrite = FALSE)
#
# # extra layer for overview of french oversea departments
# regGeometry(nation = "CNTR_CODE",
#             subset = "france",
#             gSeries = "eurostat",
#             label = "al1",
#             nameCol = "CNTR_CODE|NUTS_NAME",
#             archive = "_2__eurostat_not-france.gpkg",
#             archiveLink = "",
#             updateFrequency = "unknown",
#             update = TRUE,
#             overwrite = FALSE)
#
# regGeometry(nation = "CNTR_CODE",
#             subset = "romania",
#             gSeries = "eurostat",
#             label = "al1",
#             nameCol = "CNTR_CODE|NUTS_NAME",
#             archive = "_2__eurostat_not-romania.gpkg",
#             archiveLink = "",
#             updateFrequency = "unknown",
#             update = TRUE,
#             overwrite = FALSE)


# register census tables ----
#
schema_eurostat <-
  setFormat(na_values = ":", flags = flags, decimal = ".") %>%
  setIDVar(name = "year", columns = .find(fun = is.numeric, row = 1), rows = 1)

schema_al1 <- schema_eurostat %>%
  setIDVar(name = "al1", columns = .find(pattern = "^geo", row = 1))

schema_al2 <- schema_eurostat %>%
  setIDVar(name = "al2", columns = .find(pattern = "^geo", row = 1))

schema_al3 <- schema_eurostat %>%
  setIDVar(name = "al3", columns = .find(pattern = "^geo", row = 1))


## Animal populations (agr_r_animal) ----
#
schema_agrranimal <- schema_al3 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al3",
         subset = "agrranimal",
         dSeries = ds[1],
         gSeries = gs[2],
         schema = schema_agrranimal,
         begin = 1977,
         end = 2020,
         archive = "agr_r_animal.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/agr_r_animal/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/apro_anip_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


## Crop production by NUTS 2 regions (apro_cpnhr) ----
#
schema_aprocpnhr <- schema_al3 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "harvested", factor = 1000, columns = .find(fun = is.numeric, row = 1),
            key = 6, value = "Area (cultivation/harvested/production) (1000 ha)") %>%
  setObsVar(name = "production", factor = 1000, columns = .find(fun = is.numeric, row = 1),
            key = 6, value = "Harvested production (1000 t)")

regTable(un_region = thisNation,
         label = "al3",
         subset = "aprocpnhr",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2000,
         end = 2021,
         schema = schema_aprocpnhr,
         archive = "apro_cpnhr.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/apro_cpnhr/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/apro_cp_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Crop production by NUTS 2 regions - historical data (apro_cpnhr_h) ----
#
schema_aprocpnhrh <- schema_al3 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "harvested", factor = 1000, columns = .find(fun = is.numeric, row = 1),
            key = 6, value = "Area (cultivation/harvested/production) (1000 ha)") %>%
  setObsVar(name = "production", factor = 1000, columns = .find(fun = is.numeric, row = 1),
            key = 6, value = "Harvested production (1000 t)")

regTable(un_region = thisNation,
         label = "al3",
         subset = "aprocpnhrh",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 1975,
         end = 1999,
         schema = schema_aprocpnhrh,
         archive = "apro_cpnhr_h.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/apro_cpnhr_h/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/apro_cp_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Poultry - annual data (apro_ec_poula) ----
#
schema_aproecpoula <- schema_al1 %>%
  setFilter(rows = .find(pattern = "CH", col = 5)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al1",
         subset = "aproecpoula",
         dSeries = ds[1],
         gSeries = gs[2],
         schema = schema_aproecpoula,
         begin = 1967,
         end = 2021,
         archive = "apro_ec_poula.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/apro_ec_poula/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/apro_anip_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Candidate countries and potential candidates: agricultural (cpc_agmain) ----
#
schema_cpcagmain <- schema_al1 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 1000, columns = .find(fun = is.numeric, row = 1),
            key = 3, value = "crop_production") %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = .find(fun = is.numeric, row = 1),
            key = 3, value = "livestock") %>%
  setObsVar(name = "area", unit = "ha", factor = 1000, columns = .find(fun = is.numeric, row = 1),
            key = 3, value = "area")

regTable(un_region = thisNation,
         label = "al1",
         subset = "cpcagmain",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2005,
         end = 2019,
         schema = schema_cpcagmain,
         archive = "cpc_agmain.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/cpc_agmain/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/cpc_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Livestock: number of farms and heads (ef_ls_ovaareg) ----
#
schema_eflsovaareg <- schema_al3 %>%
  setFilter(rows = .find(pattern = "NR", col = 5)) %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 7)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al3",
         subset = "eflsovaareg",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 1990,
         end = 2007,
         schema = schema_eflsovaareg,
         archive = "ef_ls_ovaareg.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_ls_ovaareg/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# Main livestock indicators (ef_lsk_main) ----
#
schema_eflskmain <- schema_al3 %>%
  setFilter(rows = .find(pattern = "THS_HD", col = 5)) %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 7)) %>%
  setFilter(rows = .find(pattern = "A", col = 9)) %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 11)) %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 13)) %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 15)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al3",
         subset = "eflskmain",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2013,
         end = 2016,
         schema = schema_eflskmain,
         archive = "ef_lsk_main.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_lsk_main/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Irrigation: number of farms, areas (ef_lu_ofirrig) ----
#
schema_efluofirrig <- schema_al3 %>%
    setFilter(rows = .find(pattern = "HA", col = 5)) %>%
    setFilter(rows = .find(pattern = "A", col = 7)) %>%
    setIDVar(name = "commodities", columns = 2) %>%
    setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al3",
         subset = "efluofirrig",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 1990,
         end = 2007,
         schema = schema_efluofirrig,
         archive = "ef_lu_ofirrig.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_lu_ofirrig/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Fallow land and set-aside land: number of farms and areas (ef_lu_ofsetasid) ----
#
schema_efluofsetasid <- schema_al1 %>%
  setFilter(rows = .find(pattern = "HA", col = 5)) %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 7)) %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1), factor = 1000)

regTable(un_region = thisNation,
         label = "al1",
         subset = "efluofsetasid",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 1990,
         end = 2007,
         schema = schema_efluofsetasid,
         archive = "ef_lu_ofsetasid.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_lu_ofsetasid/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/ef_sims.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Farmland: number of farms and areas (ef_lu_ovcropaa) ----
#
schema_efluovcropaa <- schema_al3 %>%
  setFilter(rows = .find(pattern = "HA", col = 5)) %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 7)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1), factor = 1000)

regTable(un_region = thisNation,
         label = "al3",
         subset = "efluovcropaa",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 1990,
         end = 2007,
         schema = schema_efluovcropaa,
         archive = "ef_lu_ovcropaa.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_lu_ovcropaa/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/ef_sims.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Crops by classes of utilised agricultural area (ef_lus_allcrops) ----
#
schema_eflusallcrops <- schema_al3 %>%
  setFilter(rows = .find(pattern = "HA", col = 5)) %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 7)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1), factor = 1000)

regTable(un_region = thisNation,
         label = "al3",
         subset = "eflusallcrops",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2013,
         end = 2016,
         schema = schema_eflusallcrops,
         archive = "ef_lus_allcrops.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_lus_allcrops/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/ef_sims.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Main farm land use by NUTS 2 regions (ef_lus_main) ----
#
schema_eflusmain <- schema_al3 %>%
  setFilter(rows = .find(pattern = "HA", col = 5)) %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 7)) %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 11)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1), factor = 1000)

regTable(un_region = thisNation,
         label = "al3",
         subset = "eflusmain",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2013,
         end = 2016,
         schema = schema_eflusmain,
         archive = "ef_lus_main.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_lus_main/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/ef_sims.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Special areas and other farmland (ef_lus_spare) ----
#
schema_eflussparea <- schema_al3 %>%
  setFilter(rows = .find(pattern = "HA", col = 5)) %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 7)) %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1), factor = 1000)

regTable(un_region = thisNation, label = "al3",
         subset = "eflussparea",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2013,
         end = 2016,
         schema = schema_eflussparea,
         archive = "ef_lus_sparea.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_lus_sparea/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/ef_sims.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Livestock: number of farms and heads (ef_olsaareg) ----
#
schema_efolsaareg <- schema_al3 %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 5)) %>%
  setFilter(rows = .find(pattern = "head", col = 2)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "headcount", unit = "n", columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al3",
         subset = "efolsaareg",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2005,
         end = 2013,
         schema = schema_efolsaareg,
         archive = "ef_olsaareg.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_olsaareg/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Land use: number of farms and areas (ef_oluaareg) ----
#
schema_efoluaareg <- schema_al3 %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 5)) %>%
  setFilter(rows = .find(pattern = "ha", col = 2)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1), factor = 1000)

regTable(un_region = thisNation,
         label = "al3",
         subset = "efoluaareg",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2005,
         end = 2013,
         schema = schema_efoluaareg,
         archive = "ef_oluaareg.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_oluaareg/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## ENP-East Crop production (enpe_apro_cpnh1) ----
#
schema_enpeaprocpnh1 <- schema_al1 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 1000, columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al1",
         subset = "enpeaprocpnh1",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2005,
         end = 2019,
         schema = schema_enpeaprocpnh1,
         archive = "enpe_apro_cpnh1.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/enpe_apro_cpnh1/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/enpe_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## ENP-East Livestock (enpe_apro_mt_ls) ----
#
schema_enpeapromtls <- schema_al1 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al1",
         subset = "enpeapromtls",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2005,
         end = 2019,
         schema = schema_enpeapromtls,
         archive = "enpe_apro_mt_ls.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/enpe_apro_mt_ls/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/enpe_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## ENP-East Main farm land use (enpe_ef_lus_main) ----
#
schema_enpeeflusmain <- schema_al1 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "area", unit = "ha", factor = 1000, columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al1",
         subset = "enpeeflusmain",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2005,
         end = 2020,
         schema = schema_enpeeflusmain,
         archive = "enpe_ef_lus_main.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/enpe_ef_lus_main/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/enpe_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## ENP-East agricultural - historical data (enpr_agmain) ----
#
schema_enpragmain <- schema_al1 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 1000, columns = .find(fun = is.numeric, row = 1),
            key = 3, value = "crop_production") %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = .find(fun = is.numeric, row = 1),
            key = 3, value = "livestock") %>%
  setObsVar(name = "area", unit = "ha", factor = 1000, columns = .find(fun = is.numeric, row = 1),
            key = 3, value = "area")

regTable(un_region = thisNation,
         label = "al1",
         subset = "enpragmain",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2005,
         end = 2019,
         schema = schema_enpragmain,
         archive = "enpr_agmain.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/enpr_agmain/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/enpr_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## ENP-South Crop production (enps_apro_cpnh1) ----
#
schema_enpsaprocpnh1 <- schema_al1 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "production", unit = "t", factor = 1000, columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al1",
         subset = "enpsaprocpnh1",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2005,
         end = 2020,
         schema = schema_enpsaprocpnh1,
         archive = "enps_apro_cpnh1.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/enps_apro_cpnh1/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## ENP-South Livestock (enps_apro_mt_ls) ----
#
schema_enpsapromtls <- schema_al1 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al1",
         subset = "enpsapromtls",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2005,
         end = 2020,
         schema = schema_enpsapromtls,
         archive = "enps_apro_mt_ls.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/enps_apro_mt_ls/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## ENP-South Main farm land use (enps_ef_lus_main) ----
#
schema_enpseflusmain <- schema_al1 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1), factor = 1000)

regTable(un_region = thisNation,
         label = "al1",
         subset = "enpseflusmain",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2005,
         end = 2020,
         schema = schema_enpseflusmain,
         archive = "enps_ef_lus_main.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/enps_ef_lus_main/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Area of wooded land (for_area) ----
#
schema_forarea <- schema_al1 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1), factor = 1000)

regTable(un_region = thisNation,
         label = "al1",
         subset = "forarea",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 1990,
         end = 2020,
         schema = schema_forarea,
         archive = "for_area.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/for_area/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/for_sfm_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Protected forests (for_protect) ----
#
schema_forprotect <- schema_al1 %>%
  setFilter(rows = .find(pattern = "PRO$", col = 7)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "area", unit = "ha", factor = 1000, columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al1",
         subset = "forprotect",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 1990,
         end = 2015,
         schema = schema_forprotect,
         archive = "for_protect.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/for_protect/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/for_sfm_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Land covered by artificial surfaces by NUTS 2 regions (lan_lcv_art) ----
#
schema_lanlcvart <- schema_al3 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "area", unit = "ha", factor = 100, columns = .find(fun = is.numeric, row = 1),
            key = 6, value = "Square kilometre")

regTable(un_region = thisNation,
         label = "al3",
         subset = "lanlcvart",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2009,
         end = 2015,
         schema = schema_lanlcvart,
         archive = "lan_lcv_art.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/lan_lcv_art/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/lan_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Land cover for FAO Forest categories by NUTS 2 regions (lan_lcv_fao) ----
#
schema_lanlcvfao <- schema_al3 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "area", unit = "ha", factor = 100, columns = .find(fun = is.numeric, row = 1),
            key = 6, value = "Square kilometre")

regTable(un_region = thisNation,
         label = "al3",
         subset = "lanlcvfao",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2009,
         end = 2018,
         schema = schema_lanlcvfao,
         archive = "lan_lcv_fao.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/lan_lcv_fao/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/lan_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Land cover overview by NUTS 2 regions (lan_lcv_ovw) ----
#
schema_lanlcvovw <- schema_al3 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "area", unit = "ha", factor = 100, columns = .find(fun = is.numeric, row = 1),
            key = 6, value = "Square kilometre")

regTable(un_region = thisNation,
         label = "al3",
         subset = "lanlcvovw",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2009,
         end = 2015,
         schema = schema_lanlcvovw,
         archive = "lan_lcv_ovw.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/lan_lcv_ovw/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/lan_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Land use overview by NUTS 2 regions (lan_use_ovw) ----
#
schema_lanuseovw <- schema_al3 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "percent", unit = "%", columns = .find(fun = is.numeric, row = 1),
            key = 6, value = "Percentage") %>%
  setObsVar(name = "area", unit = "ha", factor = 100, columns = .find(fun = is.numeric, row = 1),
            key = 6, value = "Square kilometre")

regTable(un_region = thisNation,
         label = "al3",
         subset = "lanuseovw",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2009,
         end = 2015,
         schema = schema_lanuseovw,
         archive = "lan_use_ovw.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/lan_use_ovw/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/lan_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## ENP-South Crop production - historical data (med_ag2) ----
#
schema_medag2 <- schema_al1 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "production", unit = "t", columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al1",
         subset = "medag2",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2005,
         end = 2019,
         schema = schema_medag2,
         archive = "med_ag2.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/med_ag2/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## ENP-South Livestock - historical data (med_ag33) ----
#
schema_medag33 <- schema_al1 %>%
  setIDVar(name = "commodities", columns = 2)%>%
  setObsVar(name = "headcount", unit = "n", columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al1",
         subset = "medag33",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2005,
         end = 2018,
         schema = schema_medag33,
         archive = "med_ag33.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/med_ag33/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## ENP-South Poultry farming - historical data (med_ag34) ----
#
schema_medag34 <- schema_al1 %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al1",
         subset = "medag34",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2005,
         end = 2018,
         schema = schema_medag34,
         archive = "med_ag34.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/med_ag34/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## ENP-South Forest and irrigated land - historical data (med_en62) ----
#
schema_meden62 <- schema_al1 %>%
  setIDVar(name = "commodities", columns = 6) %>%
  setObsVar(name = "area", unit = "%", columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al1",
         subset = "meden62",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2005,
         end = 2018,
         schema = schema_meden62,
         archive = "med_en62.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/med_en62/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Apple and pears trees (area in ha) (orch_apples1) ----
#
schema_orchapples1 <- schema_al2 %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al2",
         subset = "orchapples1",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2002,
         end = 2017,
         schema = schema_orchapples1,
         archive = "orch_apples1.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/orch_apples1/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/orch_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Table grape vines (area in ha) (orch_grapes1) ----
#
schema_orchgrapes1 <- schema_al2 %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al2",
         subset = "orchgrapes1",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2012,
         end = 2017,
         schema = schema_orchgrapes1,
         archive = "orch_grapes1.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/orch_grapes1/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/orch_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Olive trees (area in ha) (orch_olives1) ----
#
schema_orcholives1 <- schema_al2 %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al2",
         subset = "orcholives1",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2012,
         end = 2017,
         schema = schema_orcholives1,
         archive = "orch_olives1.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/orch_olives1/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/orch_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Orange, lemon and small citrus fruit trees (orch_oranges1) ----
#
schema_orchoranges1 <- schema_al2 %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al2",
         subset = "orchoranges1",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2002,
         end = 2017,
         schema = schema_orchoranges1,
         archive = "orch_oranges1.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/orch_oranges1/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/orch_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## Peach and apricot trees (orch_peach1) ----
#
schema_orchpeach1 <- schema_al2 %>%
  setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = .find(fun = is.numeric, row = 1))

regTable(un_region = thisNation,
         label = "al2",
         subset = "orchpeach1",
         dSeries = ds[1],
         gSeries = gs[2],
         begin = 2012,
         end = 2017,
         schema = schema_orchpeach1,
         archive = "orch_peach1.tsv.gz",
         archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/orch_peach1/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/orch_esms.htm",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


# normalise geometries ----
#
normGeometry(pattern = gs[2],
             outType = "gpkg",
             update = updateTables)


# normalise census tables ----
#
normTable(pattern = ds[1],
          outType = "rds",
          update = updateTables)


# harmonise commodities ----
#
matchOntology(columns = "new",
              dataseries = ds[1],
              ontology = ontoDir)


