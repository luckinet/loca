# script arguments ----
#
thisNation <- "Europe"
# source(paste0(mdl0301, "src/96_preprocess_eurostat.R"))

# flag information: https://ec.europa.eu/eurostat/data/database/information
flags <- tibble(flag = c("b", "c", "d", "e", "f", "n", "p", "r", "s", "u", "z"),
                value = c("break in time series", "confidential",
                          "definition differs, see metadata", "estimated",
                          "forecast", "not significatn", "provisional",
                          "revised", "Eurostat estimate", "low reliability",
                          "not applicable"))

# https://ec.europa.eu/eurostat/documents/3859598/15193590/KS-GQ-22-010-EN-N.pdf


# 1. dataseries ----
#
ds <- c("eurostat")
gs <- c("nuts")

regDataseries(name = ds[1],
              description = "Statistical office of the European Union",
              homepage = "https://ec.europa.eu/eurostat/web/main/home",
              version = "2023.12.12",
              licence_link = "unknown")

regDataseries(name = gs[1],
              description = "Nomenclature des unités territoriales statistiques",
              homepage = "https://ec.europa.eu/eurostat/web/nuts/background",
              version = "2021",
              licence_link = "https://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/administrative-units-statistical-units/nuts")


# 2. geometries ----
#
regGeometry(gSeries = gs[1],
            label = list(al1 = "CNTR_CODE"),
            ancillary = list(name_ltn = "NAME_LATN", name_lcl = "NUTS_NAME"),
            archive = "ref-nuts-2021-01m.shp.zip|NUTS_RG_01M_2021_3035_LEVL_0.shp",
            archiveLink = "https://gisco-services.ec.europa.eu/distribution/v2/nuts/download/ref-nuts-2021-01m.shp.zip",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "unknown",
            overwrite = TRUE)

regGeometry(gSeries = gs[1],
            label = list(al1 = "CNTR_CODE", al2 = "NUTS_ID"),
            ancillary = list(name_ltn = "NAME_LATN", name_lcl = "NUTS_NAME"),
            archive = "ref-nuts-2021-01m.shp.zip|NUTS_RG_01M_2021_3035_LEVL_1.shp",
            archiveLink = "https://gisco-services.ec.europa.eu/distribution/v2/nuts/download/ref-nuts-2021-01m.shp.zip",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "unknown",
            overwrite = TRUE)

regGeometry(gSeries = gs[1],
            label = list(al1 = "CNTR_CODE", al3 = "NUTS_ID"),
            ancillary = list(name_ltn = "NAME_LATN", name_lcl = "NUTS_NAME"),
            archive = "ref-nuts-2021-01m.shp.zip|NUTS_RG_01M_2021_3035_LEVL_2.shp",
            archiveLink = "https://gisco-services.ec.europa.eu/distribution/v2/nuts/download/ref-nuts-2021-01m.shp.zip",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "unknown",
            overwrite = TRUE)

regGeometry(gSeries = gs[1],
            label = list(al1 = "CNTR_CODE", al4 = "NUTS_ID"),
            ancillary = list(name_ltn = "NAME_LATN", name_lcl = "NUTS_NAME"),
            archive = "ref-nuts-2021-01m.shp.zip|NUTS_RG_01M_2021_3035_LEVL_3.shp",
            archiveLink = "https://gisco-services.ec.europa.eu/distribution/v2/nuts/download/ref-nuts-2021-01m.shp.zip",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "unknown",
            overwrite = TRUE)

normGeometry(pattern = gs[1],
             # query = "where CNTR_CODE = 'EL'",
             beep = 10)


# 3. tables ----
#
schema_eurostat <-
  setFormat(na_values = ":", flags = flags, decimal = ".") %>%
  setIDVar(name = "year", columns = .find(fun = is.numeric, row = 1), rows = 1)

schema_al1 <- schema_eurostat %>%
  setIDVar(name = "al1", columns = .find(pattern = "^geo", row = 1))

schema_al2 <- schema_eurostat %>%
  setIDVar(name = "al1", columns = .find(pattern = "^geo$", row = 1), split = "(.{2})") %>%
  setIDVar(name = "al2", columns = .find(pattern = "^geo", row = 1))

schema_al3 <- schema_eurostat %>%
  setIDVar(name = "al1", columns = .find(pattern = "^geo$", row = 1), split = "(.{2})") %>%
  setIDVar(name = "al2", columns = .find(pattern = "^geo$", row = 1), split = "(.{3})") %>%
  setIDVar(name = "al3", columns = .find(pattern = "^geo", row = 1))

if(build_crops){
  ## crops ----

  ### Crop production by NUTS 2 regions (apro_cpnhr) ----
  schema_aprocpnhr <- schema_al3 %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "crop", columns = 2) %>%
    setObsVar(name = "hectares_harvested", factor = 1000, columns = .find(fun = is.numeric, row = 1),
              key = 6, value = "Area (cultivation/harvested/production) (1000 ha)") %>%
    setObsVar(name = "hectares_covered", factor = 1000, columns = .find(fun = is.numeric, row = 1),
              key = 6, value = "Main area (1000 ha)") %>%
    setObsVar(name = "tons_produced", factor = 1000, columns = .find(fun = is.numeric, row = 1),
              key = 6, value = "Harvested production (1000 t)")

  regTable(un_region = thisNation,
           label = "al3",
           subset = "aprocpnhrCROP",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 2000,
           end = 2021,
           schema = schema_aprocpnhr,
           archive = "apro_cpnhr.tsv.gz",
           archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/apro_cpnhr/",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/apro_cp_esms.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Crop production by NUTS 2 regions - historical data (apro_cpnhr_h) ----
  schema_aprocpnhrh <- schema_al3 %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "crop", columns = 2) %>%
    setObsVar(name = "hectares_harvested", factor = 1000, columns = .find(fun = is.numeric, row = 1),
              key = 6, value = "Area (cultivation/harvested/production) (1000 ha)") %>%
    setObsVar(name = "tons_produced", factor = 1000, columns = .find(fun = is.numeric, row = 1),
              key = 6, value = "Harvested production (1000 t)")

  regTable(un_region = thisNation,
           label = "al3",
           subset = "aprocpnhrhCROP",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 1975,
           end = 1999,
           schema = schema_aprocpnhrh,
           archive = "apro_cpnhr_h.tsv.gz",
           archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/apro_cpnhr_h/",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/apro_cp_esms.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Apple and pears trees (area in ha) (orch_apples1) ----
  schema_orchapples1 <- schema_al2 %>%
    setIDVar(name = "method", value = "survey") %>%
    setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
    setIDVar(name = "crop", columns = 2) %>%
    setObsVar(name = "hectares_planted", columns = .find(fun = is.numeric, row = 1))

  regTable(un_region = thisNation,
           label = "al2",
           subset = "orchapples1CROP",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 2002,
           end = 2017,
           schema = schema_orchapples1,
           archive = "orch_apples1.tsv.gz",
           archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/orch_apples1/",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/orch_esms.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Table grape vines (area in ha) (orch_grapes1) ----
  schema_orchgrapes1 <- schema_al2 %>%
    setIDVar(name = "method", value = "survey") %>%
    setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
    setIDVar(name = "crop", columns = 2) %>%
    setObsVar(name = "hectares_planted", columns = .find(fun = is.numeric, row = 1))

  regTable(un_region = thisNation,
           label = "al2",
           subset = "orchgrapes1CROP",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 2012,
           end = 2017,
           schema = schema_orchgrapes1,
           archive = "orch_grapes1.tsv.gz",
           archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/orch_grapes1/",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/orch_esms.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Olive trees (area in ha) (orch_olives1) ----
  schema_orcholives1 <- schema_al2 %>%
    setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "crop", columns = 2) %>%
    setObsVar(name = "hectares_planted", columns = .find(fun = is.numeric, row = 1))

  regTable(un_region = thisNation,
           label = "al2",
           subset = "orcholives1CROP",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 2012,
           end = 2017,
           schema = schema_orcholives1,
           archive = "orch_olives1.tsv.gz",
           archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/orch_olives1/",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/orch_esms.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Orange, lemon and small citrus fruit trees (orch_oranges1) ----
  schema_orchoranges1 <- schema_al2 %>%
    setIDVar(name = "method", value = "survey") %>%
    setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
    setIDVar(name = "crop", columns = 2) %>%
    setObsVar(name = "hectares_planted", columns = .find(fun = is.numeric, row = 1))

  regTable(un_region = thisNation,
           label = "al2",
           subset = "orchoranges1CROP",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 2002,
           end = 2017,
           schema = schema_orchoranges1,
           archive = "orch_oranges1.tsv.gz",
           archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/orch_oranges1/",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/orch_esms.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Peach and apricot trees (orch_peach1) ----
  schema_orchpeach1 <- schema_al2 %>%
    setIDVar(name = "method", value = "survey") %>%
    setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
    setIDVar(name = "crop", columns = 2) %>%
    setObsVar(name = "hectares_planted", columns = .find(fun = is.numeric, row = 1))

  regTable(un_region = thisNation,
           label = "al2",
           subset = "orchpeach1CROP",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 2012,
           end = 2017,
           schema = schema_orchpeach1,
           archive = "orch_peach1.tsv.gz",
           archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/orch_peach1/",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/orch_esms.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### ENP-South Crop production (enps_apro_cpnh1)
  # schema_enpsaprocpnh1 <- schema_al1 %>%
  #   setIDVar(name = "crop", columns = 2) %>%
  #   setObsVar(name = "production", unit = "t", factor = 1000, columns = .find(fun = is.numeric, row = 1))
  #
  # regTable(un_region = thisNation,
  #          label = "al1",
  #          subset = "enpsaprocpnh1",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          begin = 2005,
  #          end = 2020,
  #          schema = schema_enpsaprocpnh1,
  #          archive = "enps_apro_cpnh1.tsv.gz",
  #          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/enps_apro_cpnh1/",
  #          updateFrequency = "annually",
  # downloadDate = ymd("2019-10-10"),
  #          metadataLink = "",
  #          metadataPath = "unknown",
  #          overwrite = TRUE)

  ### ENP-South Crop production - historical data (med_ag2)
  # schema_medag2 <- schema_al1 %>%
  #   setIDVar(name = "crop", columns = 2) %>%
  #   setObsVar(name = "production", unit = "t", columns = .find(fun = is.numeric, row = 1))
  #
  # regTable(un_region = thisNation,
  #          label = "al1",
  #          subset = "medag2",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          begin = 2005,
  #          end = 2019,
  #          schema = schema_medag2,
  #          archive = "med_ag2.tsv.gz",
  #          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/med_ag2/",
  #          updateFrequency = "annually",
  # downloadDate = ymd("2019-10-10"),
  #          metadataLink = "",
  #          metadataPath = "unknown",
  #          overwrite = TRUE)

  ### ENP-East Crop production (enpe_apro_cpnh1)
  # schema_enpeaprocpnh1 <- schema_al1 %>%
  #   setIDVar(name = "item", columns = 2) %>%
  #   setObsVar(name = "production", unit = "t", factor = 1000, columns = .find(fun = is.numeric, row = 1))
  #
  # regTable(un_region = thisNation,
  #          label = "al1",
  #          subset = "enpeaprocpnh1",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          begin = 2005,
  #          end = 2019,
  #          schema = schema_enpeaprocpnh1,
  #          archive = "enpe_apro_cpnh1.tsv.gz",
  #          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/enpe_apro_cpnh1/",
  #          updateFrequency = "annually",
  # downloadDate = ymd("2019-10-10"),
  #          metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/enpe_esms.htm",
  #          metadataPath = "unknown",
  #          overwrite = TRUE)

  normTable(pattern = paste0("CROP.*", ds[1]),
            ontoMatch = "crop",
            beep = 10)
}

if(build_livestock){
  ## livestock ----

  ### Animal populations (agr_r_animal) ----
  schema_agrranimal <- schema_al3 %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "animal", columns = 2) %>%
    setObsVar(name = "number_heads", factor = 1000, columns = .find(fun = is.numeric, row = 1))

  regTable(un_region = thisNation,
           label = "al3",
           subset = "agrranimal",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_agrranimal,
           begin = 1977,
           end = 2020,
           archive = "agr_r_animal.tsv.gz",
           archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/agr_r_animal/",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/apro_anip_esms.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### ENP-South Livestock (enps_apro_mt_ls)
  # schema_enpsapromtls <- schema_al1 %>%
  #   setIDVar(name = "animal", columns = 2) %>%
  #   setObsVar(name = "headcount", unit = "n", factor = 1000, columns = .find(fun = is.numeric, row = 1))
  #
  # regTable(un_region = thisNation,
  #          label = "al1",
  #          subset = "enpsapromtls",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          begin = 2005,
  #          end = 2020,
  #          schema = schema_enpsapromtls,
  #          archive = "enps_apro_mt_ls.tsv.gz",
  #          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/enps_apro_mt_ls/",
  #          updateFrequency = "annually",
  # downloadDate = ymd("2019-10-10"),
           # metadataLink = "",
  #          metadataPath = "unknown",
  #          overwrite = TRUE)

  ### ENP-South Livestock - historical data (med_ag33)
  # schema_medag33 <- schema_al1 %>%
  #   setIDVar(name = "animal", columns = 2)%>%
  #   setObsVar(name = "headcount", unit = "n", columns = .find(fun = is.numeric, row = 1))
  #
  # regTable(un_region = thisNation,
  #          label = "al1",
  #          subset = "medag33",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          begin = 2005,
  #          end = 2018,
  #          schema = schema_medag33,
  #          archive = "med_ag33.tsv.gz",
  #          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/med_ag33/",
  #          updateFrequency = "annually",
  # downloadDate = ymd("2019-10-10"),
  #          metadataLink = "",
  #          metadataPath = "unknown",
  #          overwrite = TRUE)

  ### ENP-South Poultry farming - historical data (med_ag34)
  # schema_medag34 <- schema_al1 %>%
  #   setIDVar(name = "animal", columns = 2) %>%
  #   setObsVar(name = "headcount", unit = "n", factor = 1000, columns = .find(fun = is.numeric, row = 1))
  #
  # regTable(un_region = thisNation,
  #          label = "al1",
  #          subset = "medag34",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          begin = 2005,
  #          end = 2018,
  #          schema = schema_medag34,
  #          archive = "med_ag34.tsv.gz",
  #          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/med_ag34/",
  #          updateFrequency = "annually",
  # downloadDate = ymd("2019-10-10"),
  #          metadataLink = "",
  #          metadataPath = "unknown",
  #          overwrite = TRUE)

  ### ENP-East Livestock (enpe_apro_mt_ls)
  # schema_enpeapromtls <- schema_al1 %>%
  #   setIDVar(name = "animal", columns = 2) %>%
  #   setObsVar(name = "headcount", unit = "n", factor = 1000, columns = .find(fun = is.numeric, row = 1))
  #
  # regTable(un_region = thisNation,
  #          label = "al1",
  #          subset = "enpeapromtls",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          begin = 2005,
  #          end = 2019,
  #          schema = schema_enpeapromtls,
  #          archive = "enpe_apro_mt_ls.tsv.gz",
  #          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/enpe_apro_mt_ls/",
  #          updateFrequency = "annually",
  # downloadDate = ymd("2019-10-10"),
           # metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/enpe_esms.htm",
  #          metadataPath = "unknown",
  #          overwrite = TRUE)

  normTable(pattern = paste0("agrranimal.*", ds[1]),
            ontoMatch = "animal",
            beep = 10)
}

if(build_landuse){
  ## landuse ----

  ### Land cover for FAO Forest categories by NUTS 2 regions (lan_lcv_fao) ----
  schema_lanlcvfao <- schema_al3 %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "use", columns = 2) %>%
    setObsVar(name = "hectares_covered", factor = 100, columns = .find(fun = is.numeric, row = 1),
              key = 6, value = "Square kilometre")

  regTable(un_region = thisNation,
           label = "al3",
           subset = "lanlcvfaoLU",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 2009,
           end = 2018,
           schema = schema_lanlcvfao,
           archive = "lan_lcv_fao.tsv.gz",
           archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/lan_lcv_fao/",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/lan_esms.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Land cover overview by NUTS 2 regions (lan_lcv_ovw) ----
  schema_lanlcvovw <- schema_al3 %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "use", columns = 2) %>%
    setObsVar(name = "hectares_covered", factor = 100, columns = .find(fun = is.numeric, row = 1),
              key = 6, value = "Square kilometre")

  regTable(un_region = thisNation,
           label = "al3",
           subset = "lanlcvovwLU",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 2009,
           end = 2015,
           schema = schema_lanlcvovw,
           archive = "lan_lcv_ovw.tsv.gz",
           archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/lan_lcv_ovw/",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/lan_esms.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_aprocpnhrLU <- schema_al3 %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "use", columns = 2) %>%
    setObsVar(name = "hectares_covered", factor = 1000, columns = .find(fun = is.numeric, row = 1),
              key = 6, value = "Main area (1000 ha)")

  regTable(un_region = thisNation,
           label = "al3",
           subset = "aprocpnhrLU",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 2000,
           end = 2021,
           schema = schema_aprocpnhrLU,
           archive = "apro_cpnhr.tsv.gz",
           archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/apro_cpnhr/",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/apro_cp_esms.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_aprocpnhrhLU <- schema_al3 %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "use", columns = 2) %>%
    setObsVar(name = "hectares_covered", factor = 1000, columns = .find(fun = is.numeric, row = 1),
              key = 6, value = "Main area (1000 ha)")

  regTable(un_region = thisNation,
           label = "al3",
           subset = "aprocpnhrhLU",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 1975,
           end = 1999,
           schema = schema_aprocpnhrhLU,
           archive = "apro_cpnhr_h.tsv.gz",
           archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/apro_cpnhr_h/",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/apro_cp_esms.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### Land use overview by NUTS 2 regions (lan_use_ovw)
  # !!! these seem to be different "uses" than what we consider uses !!!
  # schema_lanuseovw <- schema_al3 %>%
  #   setIDVar(name = "landuse", columns = 2) %>%
  #   setObsVar(name = "percent", unit = "%", columns = .find(fun = is.numeric, row = 1),
  #             key = 6, value = "Percentage") %>%
  #   setObsVar(name = "area", unit = "ha", factor = 100, columns = .find(fun = is.numeric, row = 1),
  #             key = 6, value = "Square kilometre")
  #
  # regTable(un_region = thisNation,
  #          label = "al3",
  #          subset = "lanuseovwLU",
  #          dSeries = ds[1],
  #          gSeries = gs[1],
  #          begin = 2009,
  #          end = 2015,
  #          schema = schema_lanuseovw,
  #          archive = "lan_use_ovw.tsv.gz",
  #          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/lan_use_ovw/",
  #          updateFrequency = "annually",
  # downloadDate = ymd("2019-10-10"),
  #          metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/lan_esms.htm",
  #          metadataPath = "unknown",
  #          overwrite = TRUE)

  normTable(pattern = paste0("LU.*", ds[1]),
            ontoMatch = "use",
            beep = 10)
}

## other tables ----

###  neighbouring countries (crop, livestock, landuse) ----

#### ENP-East agricultural - historical data (enpr_agmain) ----
# schema_enpragmain <- schema_al1 %>%
#   setIDVar(name = "item", columns = 2) %>%
#   setObsVar(name = "production", unit = "t", factor = 1000, columns = .find(fun = is.numeric, row = 1),
#             key = 3, value = "crop_production") %>%
#   setObsVar(name = "headcount", unit = "n", factor = 1000, columns = .find(fun = is.numeric, row = 1),
#             key = 3, value = "livestock")
#
# schema_enpragmain_lu <- schema_al1 %>%
#   setIDVar(name = "landuse", columns = 2) %>%
#   setObsVar(name = "area", unit = "ha", factor = 1000, columns = .find(fun = is.numeric, row = 1),
#             key = 3, value = "area")
#
# regTable(un_region = thisNation,
#          label = "al1",
#          subset = "enpragmain",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          begin = 2005,
#          end = 2019,
#          schema = schema_enpragmain,
#          archive = "enpr_agmain.tsv.gz",
#          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/enpr_agmain/",
#          updateFrequency = "annually",
# downloadDate = ymd("2019-10-10"),
#          metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/enpr_esms.htm",
#          metadataPath = "unknown",
#          overwrite = TRUE)
#
# regTable(un_region = thisNation,
#          label = "al1",
#          subset = "enpragmainLU",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          begin = 2005,
#          end = 2019,
#          schema = schema_enpragmain_lu,
#          archive = "enpr_agmain.tsv.gz",
#          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/enpr_agmain/",
#          updateFrequency = "annually",
# downloadDate = ymd("2019-10-10"),
#          metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/enpr_esms.htm",
#          metadataPath = "unknown",
#          overwrite = TRUE)

#### Candidate countries and potential candidates: agricultural (cpc_agmain) ----
# schema_cpcagmain <- schema_al1 %>%
#   setIDVar(name = "item", columns = 2) %>%
#   setObsVar(name = "production", unit = "t", factor = 1000, columns = .find(fun = is.numeric, row = 1),
#             key = 3, value = "crop_production") %>%
#   setObsVar(name = "headcount", unit = "n", factor = 1000, columns = .find(fun = is.numeric, row = 1),
#             key = 3, value = "livestock")
#
# schema_cpcagmain_lu <- schema_al1 %>%
#   setIDVar(name = "land use", columns = 2) %>%
#   setObsVar(name = "area", unit = "ha", factor = 1000, columns = .find(fun = is.numeric, row = 1),
#             key = 3, value = "area")
#
# regTable(un_region = thisNation,
#          label = "al1",
#          subset = "cpcagmain",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          begin = 2005,
#          end = 2019,
#          schema = schema_cpcagmain,
#          archive = "cpc_agmain.tsv.gz",
#          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/cpc_agmain/",
#          updateFrequency = "annually",
# downloadDate = ymd("2019-10-10"),
#          metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/cpc_esms.htm",
#          metadataPath = "unknown",
#          overwrite = TRUE)
#
# regTable(un_region = thisNation,
#          label = "al1",
#          subset = "cpcagmainLU",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          begin = 2005,
#          end = 2019,
#          schema = schema_cpcagmain_lu,
#          archive = "cpc_agmain.tsv.gz",
#          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/cpc_agmain/",
#          updateFrequency = "annually",
# downloadDate = ymd("2019-10-10"),
#          metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/cpc_esms.htm",
#          metadataPath = "unknown",
#          overwrite = TRUE)

### farm-level survey ----
# The values here are sampled in great detail from a subset of farms in the
# territorial units. They do disagree with the main survey/census values in
# many instances and should be included but labeled as "farm survey" in the
# data model

#### Main farm land use by NUTS 2 regions (ef_lus_main) ----
# schema_eflusmain <- schema_al3 %>%
#   setFilter(rows = .find(pattern = "HA", col = 5)) %>%
#   setFilter(rows = .find(pattern = "TOTAL", col = 7)) %>%
#   setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
#   setFilter(rows = .find(pattern = "TOTAL", col = 11)) %>%
#   setIDVar(name = "land use", columns = 2) %>%
#   setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1), factor = 1000)
#
# regTable(un_region = thisNation,
#          label = "al3",
#          subset = "eflusmainLU",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          begin = 2013,
#          end = 2016,
#          schema = schema_eflusmain,
#          archive = "ef_lus_main.tsv.gz",
#          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_lus_main/",
#          updateFrequency = "annually",
# downloadDate = ymd("2019-10-10"),
#          metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/ef_sims.htm",
#          metadataPath = "unknown",
#          overwrite = TRUE)

#### Crops by classes of utilised agricultural area (ef_lus_allcrops) ----
# schema_eflusallcrops <- schema_al3 %>%
#   setFilter(rows = .find(pattern = "HA", col = 5)) %>%
#   setFilter(rows = .find(pattern = "TOTAL", col = 7)) %>%
#   setIDVar(name = "land use", columns = 2) %>%
#   setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1), factor = 1000)
#
# regTable(un_region = thisNation,
#          label = "al3",
#          subset = "eflusallcrops",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          begin = 2013,
#          end = 2016,
#          schema = schema_eflusallcrops,
#          archive = "ef_lus_allcrops.tsv.gz",
#          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_lus_allcrops/",
#          updateFrequency = "annually",
# downloadDate = ymd("2019-10-10"),
#          metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/ef_sims.htm",
#          metadataPath = "unknown",
#          overwrite = TRUE)

#### Special areas and other farmland (ef_lus_spare) ----
# schema_eflussparea <- schema_al3 %>%
#   setFilter(rows = .find(pattern = "HA", col = 5)) %>%
#   setFilter(rows = .find(pattern = "TOTAL", col = 7)) %>%
#   setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
#   setIDVar(name = "land use", columns = 2) %>%
#   setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1), factor = 1000)
#
# regTable(un_region = thisNation,
#          label = "al3",
#          subset = "eflusspareaLU",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          begin = 2013,
#          end = 2016,
#          schema = schema_eflussparea,
#          archive = "ef_lus_sparea.tsv.gz",
#          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_lus_sparea/",
#          updateFrequency = "annually",
# downloadDate = ymd("2019-10-10"),
#          metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/ef_sims.htm",
#          metadataPath = "unknown",
#          overwrite = TRUE)

#### Fallow land and set-aside land: number of farms and areas (ef_lu_ofsetasid) ----
# schema_efluofsetasid <- schema_al1 %>%
#   setFilter(rows = .find(pattern = "HA", col = 5)) %>%
#   setFilter(rows = .find(pattern = "TOTAL", col = 7)) %>%
#   setFilter(rows = .find(pattern = "TOTAL", col = 9)) %>%
#   setIDVar(name = "land use", columns = 2) %>%
#   setObsVar(name = "production", unit = "t", factor = 1000, columns = .find(fun = is.numeric, row = 1))
#
# regTable(un_region = thisNation,
#          label = "al1",
#          subset = "efluofsetasidLU",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          begin = 1990,
#          end = 2007,
#          schema = schema_efluofsetasid,
#          archive = "ef_lu_ofsetasid.tsv.gz",
#          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_lu_ofsetasid/",
#          updateFrequency = "annually",
# downloadDate = ymd("2019-10-10"),
#          metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/ef_sims.htm",
#          metadataPath = "unknown",
#          overwrite = TRUE)

#### Irrigation: number of farms, areas (ef_lu_ofirrig) ----
# schema_efluofirrig <- schema_al3 %>%
#   setFilter(rows = .find(pattern = "HA", col = 5)) %>%
#   setFilter(rows = .find(pattern = "A", col = 7)) %>%
#   setIDVar(name = "land use", columns = 2) %>%
#   setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1))
#
# regTable(un_region = thisNation,
#          label = "al3",
#          subset = "efluofirrig",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          begin = 1990,
#          end = 2007,
#          schema = schema_efluofirrig,
#          archive = "ef_lu_ofirrig.tsv.gz",
#          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_lu_ofirrig/",
#          updateFrequency = "annually",
# downloadDate = ymd("2019-10-10"),
#          metadataLink = "",
#          metadataPath = "unknown",
#          overwrite = TRUE)

#### Farmland: number of farms and areas (ef_lu_ovcropaa) ----
# schema_efluovcropaa <- schema_al3 %>%
#   setFilter(rows = .find(pattern = "HA", col = 5)) %>%
#   setFilter(rows = .find(pattern = "TOTAL", col = 7)) %>%
#   setIDVar(name = "land use", columns = 2) %>%
#   setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1), factor = 1000)
#
# regTable(un_region = thisNation,
#          label = "al3",
#          subset = "efluovcropaa",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          begin = 1990,
#          end = 2007,
#          schema = schema_efluovcropaa,
#          archive = "ef_lu_ovcropaa.tsv.gz",
#          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_lu_ovcropaa/",
#          updateFrequency = "annually",
# downloadDate = ymd("2019-10-10"),
#          metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/ef_sims.htm",
#          metadataPath = "unknown",
#          overwrite = TRUE)

#### Land use: number of farms and areas (ef_oluaareg) ----
# schema_efoluaareg <- schema_al3 %>%
#   setFilter(rows = .find(pattern = "TOTAL", col = 5)) %>%
#   setFilter(rows = .find(pattern = "ha", col = 2)) %>%
#   setIDVar(name = "land use", columns = 2) %>%
#   setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1), factor = 1000)
#
# regTable(un_region = thisNation,
#          label = "al3",
#          subset = "efoluaareg",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          begin = 2005,
#          end = 2013,
#          schema = schema_efoluaareg,
#          archive = "ef_oluaareg.tsv.gz",
#          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/ef_oluaareg/",
#          updateFrequency = "annually",
# downloadDate = ymd("2019-10-10"),
#          metadataLink = "",
#          metadataPath = "unknown",
#          overwrite = TRUE)

#### ENP-East Main farm land use (enpe_ef_lus_main)
# schema_enpeeflusmain <- schema_al1 %>%
#   setIDVar(name = "land use", columns = 2) %>%
#   setObsVar(name = "area", unit = "ha", factor = 1000, columns = .find(fun = is.numeric, row = 1))
#
# regTable(un_region = thisNation,
#          label = "al1",
#          subset = "enpeeflusmainLU",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          begin = 2005,
#          end = 2020,
#          schema = schema_enpeeflusmain,
#          archive = "enpe_ef_lus_main.tsv.gz",
#          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/enpe_ef_lus_main/",
#          updateFrequency = "annually",
# downloadDate = ymd("2019-10-10"),
#          metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/enpe_esms.htm",
#          metadataPath = "unknown",
#          overwrite = TRUE)

#### ENP-South Main farm land use (enps_ef_lus_main)
# schema_enpseflusmain <- schema_al1 %>%
#   setIDVar(name = "land use", columns = 2) %>%
#   setObsVar(name = "area", unit = "ha", columns = .find(fun = is.numeric, row = 1), factor = 1000)
#
# regTable(un_region = thisNation,
#          label = "al1",
#          subset = "enpseflusmainLU",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          begin = 2005,
#          end = 2020,
#          schema = schema_enpseflusmain,
#          archive = "enps_ef_lus_main.tsv.gz",
#          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/enps_ef_lus_main/",
#          updateFrequency = "annually",
# downloadDate = ymd("2019-10-10"),
#          metadataLink = "",
#          metadataPath = "unknown",
#          overwrite = TRUE)

#### ENP-South Forest and irrigated land - historical data (med_en62)
# schema_meden62 <- schema_al1 %>%
#   setIDVar(name = "land use", columns = 6) %>%
#   setObsVar(name = "area", unit = "%", columns = .find(fun = is.numeric, row = 1))
#
# regTable(un_region = thisNation,
#          label = "al1",
#          subset = "meden62LU",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          begin = 2005,
#          end = 2018,
#          schema = schema_meden62,
#          archive = "med_en62.tsv.gz",
#          archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/med_en62/",
#          updateFrequency = "annually",
# downloadDate = ymd("2019-10-10"),
#          metadataLink = "",
#          metadataPath = "unknown",
#          overwrite = TRUE)
