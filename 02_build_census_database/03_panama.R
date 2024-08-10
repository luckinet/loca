# ----
# geography : Panama
# period    : _INSERT
# dataseries: Instituto Nacional de Estadística y Censo (INEC) (https://www.inec.gob.pa/)
# variables :
#   - land      : _INSERT
#   - crops     : _INSERT
#   - livestock : _INSERT
#   - technology: _INSERT
#   - social    : _INSERT
# sampling  : survey, census
# spatial   : _INSERT
# authors   : Steffen Ehrmann, Katya Perez Guzman
# date      : 2024-05-14
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisNation <- "Panama"


need to download agriculture stats, only livestock available so far
census 2001: https://www.inec.gob.pa/publicaciones/Default3.aspx?ID_PUBLICACION=1206&ID_CATEGORIA=20&ID_SUBCATEGORIA=75
census 2011: https://www.inec.gob.pa/publicaciones/Default2.aspx?ID_CATEGORIA=15&ID_SUBCATEGORIA=60
crops1 1999-2023: https://www.inec.gob.pa/publicaciones/Default2.aspx?ID_CATEGORIA=4&ID_SUBCATEGORIA=12
crops2 2001-2023: https://www.inec.gob.pa/publicaciones/Default2.aspx?ID_CATEGORIA=4&ID_SUBCATEGORIA=11

# 1. dataseries ----
#
ds <- c("inec_pa")
gs <- c("gadm")

regDataseries(name = ds[1],
              description = "Instituto Nacional de Estadística y Censo",
              homepage = "https://www.inec.gob.pa/",
              version = "2014.05",
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

  ### 2001 - 2022 - cattle lvl2 ----
  P0705547520231115134209Cuadro 1 Vacuno.csv

  ### 2001 - 2022 - pigs lvl2 ----
  P0705547520231115134515Cuadro 3 Porcino.csv

  ### 2001 - 2022 - chicken lvl2 ----
  P0705547520231115135148Cuadro 5, Gallinas.csv

  ### 2021 - cattle, classes lvl2 ----
  P0414032720220506094028CUADRO 3.xls

  ### 2021 - pigs, sex lvl2 ----
  P0705547520220506131414CUADRO 13.xls

  ### 2021 - chicken, activity lvl2 ----
  P0414032720220506133222CUADRO 20.xls

  ### 2021 - milk and eggs ----
  P0862619320220506133442CUADRO 23.xls

  ### 2020 - cattle, class lvl2 ----
  P0705547520210423155449CUADRO 2.XLS

  ### 2020 - pigs, sex lvl2 ----
  P053342420210423130235CUADRO 12.xls

  ### 2020 - chicken, activity lvl2 ----
  P00140176420210423131120CUADRO 18.xls

  ### 2019 - cattle, class lvl2 ----
  P053342420201113144221CUADRO 2.XLS

  ### 2019 - pigs, sex lvl2 ----
  P0774740120201113150542CUADRO 12.xls

  ### 2019 - chicken, activity lvl2 ----
  P0289562520201113152237CUADRO 18.xls

  ### 2018 - cattle, class lvl2 ----
  P9541Cuadro -2.XLS

  ### 2018 - pigs, sex lvl2 ----
  P9541Cuadro -15.xls

  ### 2018 - chicken, activity lvl2 ----
  P9541Cuadro -23.xls

  ### 2017 - cattle, class lvl2 ----
  P8931Cuadro-3.XLS

  ### 2017 - pigs, sex lvl2 ----
  P8931Cuadro-22.xls

  ### 2017 - chicken, activity lvl2 ----
  P8931Cuadro-31.xls

  ### 2016 - cattle, class lvl2 ----
  P8161312-02.xls

  ### 2016 - pigs, sex lvl2 ----
  P8161312-06.xls

  ### 2016 - chicken, activity lvl2 ----
  P8161312-09.xls

  ### 2015 - cattle, class lvl2 ----
  P7421312-02.xls

  ### 2015 - pigs, sex lvl2 ----
  P7421312-06.xls

  ### 2015 - chicken, activity lvl2 ----
  P7421312-09.xls

  ### 2014 - cattle, class lvl2 ----
  P6701312-02.xls

  ### 2014 - pigs, sex lvl2 ----
  P6701312-06.xls

  ### 2014 - chicken, activity lvl2 ----
  P6701312-09.xls

  ### 2013 - cattle, class lvl2 ----
  P5891312-02.XLS

  ### 2013 - pigs, sex lvl2 ----
  P5891312-06.xls

  ### 2013 - chicken, activity lvl2 ----
  P5891312-09.xls

  ### 2012 - cattle, class lvl2 ----
  P5341312-02.XLS

  ### 2012 - pigs, sex lvl2 ----
  P5341312-06.xls

  ### 2012 - chicken, activity lvl2 ----
  P5341312-09.XLS

  ### 2010 - cattle, class lvl2 ----
  P4681312-02.pdf

  ### 2010 - pigs, sex lvl2 ----
  P4681312-08.pdf

  ### 2009 - cattle, class lvl2 ----
  P4671312-02.pdf

  ### 2009 - pigs, sex lvl2 ----
  P4671312-08.pdf

  ### 2008 - cattle, class lvl2 ----
  P1871312-02.pdf

  ### 2008 - pigs, sex lvl2 ----
  P1871312-08.pdf

  ### 2007 - cattle, class lvl2 ----
  P4661312-02.pdf

  ### 2007 - pigs, sex lvl2 ----
  P4661312-05.pdf

  ### 2006 - cattle, class lvl2 ----
  P4651312-02.pdf

  ### 2006 - pigs, sex lvl2 ----
  P4651312-05.pdf

  ### 2005 - cattle, class lvl2 ----
  P4641312-02.pdf

  ### 2005 - pigs, sex lvl2 ----
  P4641312-04.pdf

  ### 2003 - cattle, class lvl2 ----
  P4631312-02.pdf

  ### 2003 - pigs, sex lvl2 ----
  P4631312-04.pdf

  ### 2002 - cattle, class lvl2 ----
  P4541312-02.pdf

  ### 2002 - pigs, sex lvl2 ----
  P4541312-04.pdf

  ### 1982 - 2002 - cattle lvl2 ----
  P4541312-01.pdf

  ### 1982 - 2002 - pigs lvl2 ----
  P4541312-03.pdf

  ### 1982 - 2002 - chicken lvl2 ----
  P4541312-05.pdf




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
