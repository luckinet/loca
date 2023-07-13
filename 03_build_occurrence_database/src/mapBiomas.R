# script arguments ----
#
thisDataset <- "mapBiomas"
description <- "A total of 85,152 random stratified samples were generated for validation of the MapBiomas annual maps. The samples were visually inspected using Landsat images assigning the land use and land cover class for each year from 1985 to 2018."
url <- "https://doi.org/ https://mapbiomas.org/en/validation-points"
licence <- "CC BY-SA 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "MapBiomasBib.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-10-10"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- st_read(dsn = paste0(thisPath, "mapbiomas_pontos_85k_nb_tidy"))

data <- data %>% mutate(LCC = paste(Y1985, Y1986, Y1987, Y1988, Y1989, Y1990, Y1991, Y1992, Y1993, Y1994, Y1995, Y1996, Y1997, Y1998, Y1999, Y2000, Y2001, Y2002, Y2003, Y2004, Y2005, Y2006, Y2007, Y2008, Y2009, Y2010, Y2011, Y2012, Y2013, Y2014, Y2015, Y2016, Y2017, Y2018, sep =  "_" ))

data <- data %>% separate_rows(LCC, sep = "_") %>%
  mutate(year = rep(1985:2018, 255456))

data <- data %>%
  mutate(LCC = na_if(LCC, c(0, 27))) %>%
  drop_na(LCC)


# harmonise data ----
#
temp <- data %>%
  distinct(LAT, LON, year, LCC, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = LON,
    y = LAT,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste(year, "-01-01")),
    externalID = as.character(ID),
    externalValue = LCC,
    attr_1 = NA_character_, "column: Y1985 till Y2018",
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = TRUE,
    sample_type = "visual interpretation",
    collector = "expert",
    purpose = "validation") %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated, presence,
         sample_type, collector, purpose, everything())


# harmonize with ontology ----
#
new_source(name = thisDataset,
           description = description,
           homepage = url,
           date = Sys.Date(),
           license = licence,
           ontology = ontoDir)

# newConcepts <- tibble(target = c("Herbaceous associations", NA, "Open spaces with little or no vegetation",
#                                  "Forests", "Temporary grazing", "Forests",
#                                  "Heterogeneous semi-natural areas", "Forests", NA,
#                                  "Open spaces with little or no vegetation", "Open spaces with little or no vegetation", "Temporary cropland",
#                                  "Planted Forest", "Open spaces with little or no vegetation", "Urban fabric",
#                                  "Permanent cropland", "Marine wetlands", "Mine, dump and construction sites",
#                                  "Open spaces with little or no vegetation", "sugarcane", "WETLANDS",
#                                  NA),
#                       new = unique(prep$LCC),
#                       class = c("landcover", NA, "landcover",
#                                 "landcover", "land-use", "landcover",
#                                 "landcover", "landcover", NA,
#                                 "landcover", "landcover group", "landcover",
#                                 "land-use", "landcover", "landcover",
#                                 "landcover", "landcover", "landcover",
#                                 "landcover", "commodity", "landcover group",
#                                 NA),
#                       description = NA,
#                       match = "close",
#                       certainty = 3)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
