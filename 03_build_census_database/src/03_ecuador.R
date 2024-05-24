# ----
# geography : Ecuador
# period    : _INSERT
# dataseries: Instituto Nacional de Estadística y Censos (https://www.ecuadorencifras.gob.ec/institucional/home/)
# variables :
#   - land      : _INSERT
#   - crops     : _INSERT
#   - livestock : _INSERT
#   - technology: _INSERT
#   - social    : _INSERT
# sampling  : survey, census
# spatial   : _INSERT
# authors   : Steffen Ehrmann, Katya Perez Guzman
# date      : 2024-05-22
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

census 2000: Resul_Nac_resu_Prov_CNACSV.zip

survey 2014: Indice de publicacion ESPAC-2014.xlsx
survey 2015: Indice de publicacion ESPAC 2015.zip
survey 2016: Indice de publicacion ESPAC 2016.xlsx
survey 2017: Indice_de publicacion_ESPAC_2017.xlsx
survey 2018: Tabulados ESPAC 2018.xlsx
survey 2019: Tabulados ESPAC 2019.xlsx
survey 2020: Tabulados ESPAC 2020.xlsx
survey 2021: Tabulados ESPAC 2021.xlsx
survey 2022: Tabulados ESPAC 2022.xlsx
survey 2023: Tabulados_ESPAC_2023.xlsx

tech 2012: Tabulados_2012.xlsx
tech 2013: Tabulados_Uso_Plaguicidas_en_la_Agricultura_2013.xlsx
tech 2014: Tabulados_Modulo_de_Uso_manejo_de_agroquimicos_2014.xlsx
tech 2015: TABULADOS_MÓDULO_AMBIENTAL_2015_ESPAC.xls
tech 2016: Tabulados CSV - INF_AMBIENTAL ESPAC 2016.zip
tech 2017: TAB_CSV_MOD_TEC_207.zip
tech 2018: MOD_AMB_TABU_2018_v1.2.xls
tech 2019: TABUL_MOD_AGROAMB_2019_1.xlsx
tech 2020: TABUL_MOD_AMB_2020_08.xlsx
tech 2021: TABUL_MOD_AMB_2021_19_06.xls
tech 2022: TAB_MOD_AMB_ESPAC_2022_vf.xlsx
tech 2023: TAB_MOD_AMB_ESPAC_2023_vF.XLSX


thisNation <- "Ecuador"

# 1. dataseries ----
#
ds <- c("inec")
gs <- c(_INSERT)

regDataseries(name = ds[],
              description = "Instituto Nacional de Estadística y Censos",
              homepage = "https://www.ecuadorencifras.gob.ec/institucional/home/",
              version = _INSERT,
              licence_link = _INSERT)


# 2. geometries ----
#
regGeometry(nation = !!thisNation,
            gSeries = gs[],
            label = list(al_ = ""),
            archive = "|",
            archiveLink = _INSERT,
            downloadDate = _INSERT,
            updateFrequency = _INSERT)

normGeometry(pattern = gs[],
             beep = 10)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  schema_crops <- setCluster(id = _INSERT) %>%
    setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
              na_values = _INSERT) %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "") %>%
    setIDVar(name = "crop", ) %>%
    setObsVar(name = "hectares_harvested", ) %>%
    setObsVar(name = "tons_produced", ) %>%
    setObsVar(name = "kiloPerHectare_yield", )

  regTable(nation = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_crops,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           downloadDate = ymd(_INSERT),
           updateFrequency = _INSERT,
           metadataLink = _INSERT,
           metadataPath = _INSERT,
           overwrite = TRUE)

  normTable(pattern = ds[],
            ontoMatch = "crop",
            beep = 10)
}

if(build_livestock){
  ## livestock ----

  schema_livestock <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "") %>%
    setIDVar(name = "animal", )  %>%
    setObsVar(name = "number_heads", )

  regTable(nation = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_livestock,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           downloadDate = ymd(_INSERT),
           updateFrequency = _INSERT,
           metadataLink = _INSERT,
           metadataPath = _INSERT,
           overwrite = TRUE)

  normTable(pattern = ds[],
            ontoMatch = "animal",
            beep = 10)
}

if(build_landuse){
  ## landuse ----

  schema_landuse <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "landuse", ) %>%
    setObsVar(name = "hectares_covered", )

  regTable(nation = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_landuse,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           downloadDate = ymd(_INSERT),
           updateFrequency = _INSERT,
           metadataLink = _INSERT,
           metadataPath = _INSERT,
           overwrite = TRUE)

  normTable(pattern = ds[],
            ontoMatch = "landuse",
            beep = 10)
}

#### test schemas
#
# myRoot <- paste0(census_dir, "tables/stage2/")
# myFile <- ""
# input <- read_csv(file = paste0(myRoot, myFile),
#                   col_names = FALSE,
#                   col_types = cols(.default = "c"))
#
# schema <-
# validateSchema(schema = schema, input = input)
#
# output <- reorganise(input = input, schema = schema)
#
# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script
