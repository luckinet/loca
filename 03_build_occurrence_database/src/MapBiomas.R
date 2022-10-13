# script arguments ----
#
thisDataset <- "MapBiomas"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "A total of 85,152 random stratified samples were generated for validation of the MapBiomas annual maps. The samples were visually inspected using Landsat images assigning the land use and land cover class for each year from 1985 to 2018."
url <- "https://mapbiomas.org/en/validation-points"
license <- "CC BY-SA 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "MapBiomasBib.bib"))


regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2022-10-10",
           type = "static",
           licence = license,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)



# read dataset ----
#
data <- st_read(dsn = paste0(thisPath, "mapbiomas_pontos_85k_nb_tidy"))

# pre-process data ----
#
prep <- data %>% mutate(LCC = paste(Y1985, Y1986, Y1987, Y1988, Y1989, Y1990, Y1991, Y1992, Y1993, Y1994, Y1995, Y1996, Y1997, Y1998, Y1999, Y2000, Y2001, Y2002, Y2003, Y2004, Y2005, Y2006, Y2007, Y2008, Y2009, Y2010, Y2011, Y2012, Y2013, Y2014, Y2015, Y2016, Y2017, Y2018, sep =  "_" ))

prep <- prep %>% separate_rows(LCC, sep = "_") %>%
  mutate(year = rep(1985:2018, 255456))

prep <- prep %>%
  mutate(LCC = na_if(LCC, c(0, 27))) %>%
  drop_na(LCC)




# manage ontology ---
#
newConcepts <- tibble(target = c("Herbaceous associations", NA, "Open spaces with little or no vegetation",
                                 "Forests", "Temporary grazing", "Forests",
                                 "Heterogeneous semi-natural areas", "Forests", NA,
                                 "Open spaces with little or no vegetation", "Open spaces with little or no vegetation", "Temporary cropland",
                                 "Planted Forest", "Open spaces with little or no vegetation", "Urban fabric",
                                 "Permanent cropland", "Marine wetlands", "Mine, dump and construction sites",
                                 "Open spaces with little or no vegetation", "sugarcane", "WETLANDS",
                                 NA),
                      new = unique(prep$LCC),
                      class = c("landcover", NA, "landcover",
                                "landcover", "land-use", "landcover",
                                "landcover", "landcover", NA,
                                "landcover", "landcover group", "landcover",
                                "land-use", "landcover", "landcover",
                                "landcover", "landcover", "landcover",
                                "landcover", "commodity", "landcover group",
                                NA),
                      description = NA,
                      match = "close",
                      certainty = 3)

luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        date = Sys.Date(),
                        homepage = url,
                        license = license,
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = newConcepts$new,
                         target = get_concept(x = newConcepts %>% select(label = target), ontology = luckiOnto),
                         source = thisDataset,
                         description = newConcepts$description,
                         match = newConcepts$match,
                         certainty = newConcepts$certainty,
                         ontology = luckiOnto, matchDir = paste0(occurrenceDBDir, "01_concepts/"))


# harmonise data ----
#

temp <- prep %>%
  distinct(LAT, LON, year, LCC, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = LON,
    y = LAT,
    geometry = NA,
    date = ymd(paste(year, "-01-01")),
    country = NA_character_,
    irrigated = NA,
    area = NA,
    presence = T,
    externalID = as.character(ID),
    externalValue = LCC,
    LC1_orig = "column: Y1985 till Y2018",
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "visual interpretation",
    collector = "expert",
    purpose = "validation",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
