# ----
# geography : Guatemala
# period    : _INSERT
# dataseries: Instituto Nacional de Estadística (https://www.ine.gob.gt/)
# variables :
#   - land      : _INSERT
#   - crops     : _INSERT
#   - livestock : _INSERT
#   - technology: _INSERT
#   - social    : _INSERT
# sampling  : survey, census
# spatial   : _INSERT
# authors   : Steffen Ehrmann, Katya Perez Guzman
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisNation <- "Guatemala"

# 1. dataseries ----
#
ds <- c(_INSERT)
gs <- c(_INSERT)

regDataseries(name = ds[],
              description = "Instituto Nacional de Estadística",
              homepage = "https://www.ine.gob.gt/",
              version = "2024.05",
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

  ### 2022 ----
  20230925223507YRSvO7OHib0rQxKDCTAl2fkXMl05g9Uz.xlsx

  ### 2021 ----
  20220929203318pmz6JaTgnMfcHSnujSfqzsBy5wVadgXk.xlsx
  20220929204723Y5kPyji9AVO5uRc1Wn03mX03oPg70Z47.xlsx

  ### 2020 ----
  20210930234547YFwPqR0P2L23elonGRCnkhwrkPEb6vOV.xlsx
  20210930234834p41WtmnIF0zQRIPoDSFETahEHwHIr67m.xlsx
  census: 20201021122800h2NuX0RKNUd61gZu7ox4PQXgDUDgLC9Y.xlsx, 20201021122608hU1E5mBYrw7qBqdWxofaZsj4rULMDiJe.xlsx

  ### 2019 ----
  20201203153942pWf6BcBWj8taVS3Q3mRKxgDsvwPejgH8.xls
  2020120315400165sDef81WJk5MFsNyTGTixWRitUrCLY7.xlsx
  census: 202001242058096rGNQ5SfAlepmPGfYTovW9MF6X2turyT.xlsx, 20200124210415Yd6FWtyVWNULqHYzwTiXcRaLAl8B8jul.xlsx

  ### 2018 ----
  20191204172814FaXwFKh8NYNiFivgBo98JEbaVMRUhaFG.xls
  20191204175527eLWpCfULaJgv2r4fEn6RGLqXy5knWzmf.xlsx

  ### 2017 ----
  20181217113352iZwkJLBrcyCmachhwmugKt4pf6cK8kRg.xlsx
  20190307114712YiGUHvBDjKOx7Egk9HdU8mkc6EvieRu2.xlsx
  census: 201902251050218FciGNFOtT2FJnkTOS0pTzPcDOW8FpLB.xlsx

  ### 2016 ----
  20171221143334AwqECVuEFsNSCmHu3ObGLbhZoraZXYgn.xlsx
  20171221144311hk9xzLjtlLyIqA5fF0FY3udjjRUQlTkq.xlsx

  ### 2015 ----
  20210420181946FCRG98JyTWVAtsV4Lmtyn43QFgTufmZg.xls
  202104201822336xSNIDAVwbsn6jm5In0PqXO32Xq1AXiH.xlsx
  census: emO14nj4jr5XWfNPqRNeFnEgRtxtdjJf.xls

  ### 2014 ----
  HZPTHSBF3XBRL2hninLQzq4UlS1xAJka.xlsx
  21TSHie6IEhLjD2XA495NeY0IAAuq8bw.xlsx

  ### 2013 ----
  P936GQqP9jjKcbHIMAmWmMwGx3uB5g3y.xls
  SlLAmYazqk1sRb3o2pWcmpmWagG1LSRh.xlsx

  ### 2012 ----
  Q4VfCRJpKNElzZllKSsSu3VcaocIdOm2.xls
  d48258kQFhTUssaXNcO368QGiHzi8LEg.xlsx

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

  ### 2022 ----
  20240111162413QDinUvuRa9GjopyXaTuNMXc3gd6Jq1Q1.xlsx
  20240111162744xw3o7aFuBMHCXaZspmFUXa5El8R614lW.xlsx

  ### 2021 ----
  20220929204126pINgR0Du1o9wh2BWJSX2JyrmTw3czqxA.xlsx
  20220929204329QlKHEHYjsnuXyJ0R0nU16Fo9SHmLER0z.xlsx (leche etc)

  ### 2020 ----
  20210930234703IbgVgHc5enyxiXopUTuxcrUzC5WPkzCr.xlsx
  2021093023480165sDef81WJk5MFsNyTGTixWRitUrCLY7.xlsx (leche etc)

  ### 2019 ----
  20201203153948NcFYbAN6bA92ZKRG7mLINYvyZoVmXEDA.xlsx
  20201203153948NcFYbAN6bA92ZKRG7mLINYvyZoVmXEDA.xlsx

  ### 2018 ----
  20191204181122F2bGNAvSXAHCJsfI1SReTg1sJMZq9Qfs.xlsx
  20191204181216hgLOHcPc581KbArSXSrM9y9mfoTiZYj0.xlsx

  ### 2017 ----
  20181217113648NvGE8QaDqrUN7CbitcK2fqc8Rt5wIvMj.xlsx
  201812171149490jPevoWKMXOZPJq5KpYU9Tlj4peGmEEd.xlsx

  ### 2016 ----
  20171221143759zN0UWvQW6NTAGBd8AIVDPF9PTxQhyJAX.xlsx
  20171221144006bb6vENc1cmPlBToSEEr6HESWdZk6tHFs.xlsx

  ### 2015 ----
  202104201821256F87AhmHSz23w98DinOdgRYLeXivIhIr.xlsx
  20210420182214FaXwFKh8NYNiFivgBo98JEbaVMRUhaFG.xlsx

  ### 2014 ----
  SieCAkRsZHceKJVml2PrK8Avthop8SN9.xlsx
  YY9JJvsMwU9pon1edjuH5jGKQ0cbbiLV.xlsx

  ### 2013 ----
  ocUUUUqa6b7a4AfM0z7MjzAfySPxxG4O.xlsx
  EjLpJJrDUMz20C7kNEvqFqiBihKUVARJ.xlsx

  ### 2012 ----
  I0yemVpY7b4peJM0OYtXdD3xfi0DaKdm.xlsx
  e1FIVB5nZH5vluQVa2VVWKKPtalsw6Ya.xlsx

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
