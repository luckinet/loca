# script arguments ----
#
thisDataset <- "Hardy2019"
description <- "The natural regeneration of tree species depends on seed and pollen dispersal. To assess if limited dispersal could be critical for the sustainability of selective logging practices, we performed parentage analyses in two Central African legume canopy species displaying contrasted floral and fruit traits: Distemonanthus benthamianus and Erythrophleum suaveolens. We also developed new tools linking forward dispersal kernels with backward migration rates to better characterize long-distance dispersal. Much longer pollen dispersal in D. benthamianus (mean distance dp=700m, mp=52% immigration rate in 6 km2 plot, s=7% selfing rate) than in E. suaveolens (dp=294m, mp=22% in 2 km2 plot, s=20%) might reflect different insect pollinators. At a local scale, secondary seed dispersal by vertebrates led to larger seed dispersal distances in the barochorous E. suaveolens (ds=175m) than in the wind-dispersed D. benthamianus (ds=71m). Yet, seed dispersal appeared much more fat-tailed in the latter species (15-25% seeds dispersing >500m), putatively due to storm winds (papery pods). The reproductive success was correlated to trunk diameter in E. suaveolens and crown dominance in D. benthamianus. Contrary to D. benthamianus, E. suaveolens underwent significant assortative mating, increasing further the already high inbreeding of its juveniles due to selfing, which seems offset by strong inbreeding depression. To achieve sustainable exploitation, seed and pollen dispersal distances did not appear limiting, but the natural regeneration of E. suaveolens might become insufficient if all trees above the minimum legal cutting diameter were exploited. This highlights the importance of assessing the diameter structure of reproductive trees for logged species."
url <- "https://doi.org/10.5061/dryad.668fk8r https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Hardy2019"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-05-30"),
           type = "static",
           licence = licence,
           contact = "yes",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data1 <- bind_rows(read_tsv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "NMpi_D_benthamianus_dataset1.txt"), col_names = F),
                   read_tsv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "NMpi_D_benthamianus_dataset3.txt"), col_names = F),
                   read_tsv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "NMpi_D_benthamianus_dataset3.txt"), col_names = F))
data1 <- data[-1,]

data2 <- bind_rows(read_tsv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "NMpi_E_suaveolens_dataset1.txt"), col_names = F),
                   read_tsv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "NMpi_E_suaveolens_dataset2.txt"), col_names = F),
                   read_tsv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "NMpi_E_suaveolens_dataset3.txt"), col_names = F))


# pre-process data ----
#
temp1 <- data1 %>%
  drop_na(X3, X4) %>%
  mutate(country = "Gabon",
         year = "10-2009_11-2009_12-2009_1-2010_2-2010_3-2010",
         externalValue = "Naturally Regenerating Forest") %>%
  st_as_sf(., coords = c("X3", "X3"), crs = CRS("EPSG:5223")) %>%
  st_transform(., crs = "EPSG:4326") %>%
  mutate(lon =  st_coordinates(.)[,1],
         lat = st_coordinates(.)[,2]) %>%
  as.data.frame()

temp2 <- data2 %>%
  mutate(country = "Cameroon",
         year = "NA-2012_NA-2013",
         externalValue = "Undisturbed Forest") %>%
  st_as_sf(., coords = c("X3", "X3"), crs = CRS("EPSG:32632")) %>%
  st_transform(., crs = "EPSG:4326") %>%
  mutate(lon =  st_coordinates(.)[,1],
         lat = st_coordinates(.)[,2]) %>%
  as.data.frame()


# harmonise data ----
#
temp <- bind_rows(temp1, temp2) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = lon,
    y = lat,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = NA_character_,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  separate(year, sep = "-", into = c("month", "year")) %>%
  distinct(year, month, x, y, .keep_all = T) %>%
  mutate(year = as.numeric(year),
         month = as.numeric(month),
         fid = row_number()) %>%
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
