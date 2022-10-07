# script arguments ----
#
thisNation <- "Yemen"
assertSubset(x = thisNation, choices = countries$label)

updateTables <- TRUE
overwriteTables <- TRUE


# register dataseries ----
#
ds <- c("faoDatalab", "csoYemen")
gs <- c("gadm")

regDataseries(name = ds[2],
              description = "Central Statistical Organization",
              homepage = "https://www.ncsi.gov.om/Pages/NCSI.aspx",
              licence_link = "",
              licence_path = "",
              update = updateTables)

# register geometries ----
#
# # OCHA
# regGeometry(nation = "Yemen",
#             gSeries = "OCHA",
#             level = 1,
#             nameCol = "ADM0_EN",
#             archive = "yem_adm_govyem_cso_ochayemen_20191002_shp.zip|yem_admbnda_adm0_govyem_cso_20191002.shp",
#             archiveLink = "https://data.humdata.org/dataset/yemen-admin-boundaries",
#             updateFrequency = "unknown",
#             update = myUpdate)
# regGeometry(nation = "Yemen",
#             gSeries = "OCHA",
#             level = 2,
#             nameCol = "ADM1_En",
#             archive = "yem_adm_govyem_cso_ochayemen_20191002_shp.zip|yem_admbnda_adm1_govyem_cso_20191002.shp",
#             archiveLink = "https://data.humdata.org/dataset/yemen-admin-boundaries",
#             updateFrequency = "unknown",
#             update = myUpdate)
# regGeometry(nation = "Yemen",
#             gSeries = "OCHA",
#             level = 3,
#             nameCol = "ADM2_EN",
#             archive = "yem_adm_govyem_cso_ochayemen_20191002_shp.zip|yem_admbnda_adm2_govyem_cso_20191002.shp",
#             archiveLink = "https://data.humdata.org/dataset/yemen-admin-boundaries",
#             updateFrequency = "unknown",
#             update = myUpdate)
# regGeometry(nation = "Yemen",
#             gSeries = "OCHA",
#             level = 4,
#             nameCol = "ADM3_EN",
#             archive = "yem_adm_govyem_cso_ochayemen_20191002_shp.zip|yem_admbnda_adm3_govyem_cso_20191002.shp",
#             archiveLink = "https://data.humdata.org/dataset/yemen-admin-boundaries",
#             updateFrequency = "unknown",
#             update = myUpdate)

# register census tables ----
#
## faoDatalab ----
schema_yem_faoDatalab_01 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 6) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 10,
            key = 11, value = "Hectares") %>%
  setObsVar(name = "production", unit = "t", columns = 10,
            key = 11, value = "Metric Tonnes")

regTable(nation = "yem",
         level = 2,
         subset = "crops",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_yem_faoDatalab_01,
         begin = 2009,
         end = 2019,
         archive = "Yemen - Sub-National Level 1.csv",
         archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Yemen%20-%20Sub-National%20Level%201.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Yemen.pdf",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


# harmonise commodities ----
#
for(i in seq_along(ds)){

  tibble(new = get_variable(variable = "commodities", dataseries = ds[i])) %>%
    match_ontology(table = ., columns = "new", dataseries = ds[i], ontology = ontoDir)

}


# normalise geometries ----
#
# not needed


# normalise census tables ----
#
normTable(pattern = ds[1],
          al1 = thisNation,
          outType = "rds",
          update = updateTables)

