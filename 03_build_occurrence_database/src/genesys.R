# script arguments ----
#
thisDataset <- "Genesys"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description = "Genesys is a database which allows users to explore the world’s crop diversity conserved in genebanks through a single website."
url = "https://www.genesys-pgr.org/"
licence = "dataset specific"

# reference ----
#
bib <- bibentry(bibtype = "Misc",
                title = "Genesys Passport data",
                url = "https://www.genesys-pgr.org/",
                author = "Genesys",
                year = "2020")

regDataset(name = thisDataset,
           description = description,
           url = url,
           type = "dynamic",
           licence = licence,
           bibliography = bib,
           download_date = "2020-03-16",
           contact = "see reference for data",
           disclosed = "yes",
           update = TRUE)


# preprocess data ----
#
genesysFiles <- list.files(thisPath, full.names = TRUE)[-1]


# read dataset ----
#
data <- map(genesysFiles, read_excel)
data <- bind_rows(data)

# manage ontology ---
#
onto <- read_csv2(paste0(thisPath, "ontology.csv"))

newConcepts <- tibble(target = onto$target,
                      new = onto$new,
                      class = onto$class,
                      description = NA,
                      match = "close",
                      certainty = 3)


luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        date = Sys.Date(),
                        homepage = url,
                        license = license,
                        ontology = luckiOnto)

luckiOnto <- new_concept(new = c("astragalus", "sainfoin", "amaranth", "breadfruit", "sapodilla", "velvet bean"),
                         broader = c("_0901", "_05", "_02", "_06", "_06", "_08"),
                         class = "commodity",
                         description = NA,
                          ontology = luckiOnto)

luckiOnto <- new_mapping(new = newConcepts$new,
                         target = get_concept(x = newConcepts %>% select(label = target), ontology = luckiOnto),
                         source = thisDataset,
                         description = newConcepts$description,
                         match = newConcepts$match,
                         certainty = newConcepts$certainty,
                         ontology = luckiOnto, matchDir = paste0(occurrenceDBDir, "concepts/"))


# harmonise data ----
#
cnts <- tibble(iso_a3 = unique(data$ORIGCTY)) %>%
  filter(!is.na(iso_a3)) %>%
  left_join(countries, by = "iso_a3") %>%
  filter(!is.na(unit))

temp <- data %>%
  mutate(ACQDATE = gsub("--", "01", ACQDATE)) %>%
  drop_na(DECLONGITUDE, DECLATITUDE, ACQDATE) %>%
  distinct(DECLONGITUDE, DECLATITUDE, ACQDATE, CROPNAME, .keep_all = TRUE) %>%
  mutate(
    type = "point",
    geometry = NA,
    area = NA_real_,
    fid = row_number(),
    x = DECLONGITUDE,
    y = DECLATITUDE,
    date = ymd(ACQDATE),
    datasetID = thisDataset,
    iso_a3 = ORIGCTY,
    country = ORIGCTY,
    presence = T,
    irrigated = NA_character_,
    externalID = ACCENUMB,
    externalValue = CROPNAME,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring",
    epsg = 4326) %>%
    drop_na(date) %>%
  left_join(cnts %>% select(iso_a3, unit), by = "iso_a3") %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")

