# script arguments ----
#
thisDataset <- "Juergens2012"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Juergens_2012.bib"))

regDataset(name = thisDataset,
           description = "The international, interdisciplinary biodiversity research project BIOTA AFRICA initiated a standardized biodiversity monitoring network along climatic gradients across the African continent. Due to an identified lack of adequate monitoring designs, BIOTA AFRICA developed and implemented the standardized BIOTA Biodiversity Observatories, that meet the following criteria (a) enable long-term monitoring of biodiversity, potential driving factors, and relevant indicators with adequate spatial and temporal resolution, (b) facilitate comparability of data generated within different ecosystems, (c) allow integration of many disciplines, (d) allow spatial up-scaling, and (e) be applicable within a network approach. A BIOTA Observatory encompasses an area of 1 km2 and is subdivided into 100 1-ha plots. For meeting the needs of sampling of different organism groups, the hectare plot is again subdivided into standardized subplots, whose sizes follow a geometric series. To allow for different sampling intensities but at the same time to characterize the whole square kilometer, the number of hectare plots to be sampled depends on the requirements of the respective discipline. A hierarchical ranking of the hectare plots ensures that all disciplines monitor as many hectare plots jointly as possible. The BIOTA Observatory design assures repeated, multidisciplinary standardized inventories of biodiversity and its environmental drivers, including options for spatial up- and downscaling and different sampling intensities. BIOTA Observatories have been installed along climatic and landscape gradients in Morocco, West Africa, and southern Africa. In regions with varying land use, several BIOTA Observatories are situated close to each other to analyze management effects.",
           url = "https://doi.org/10.1007/s10661-011-1993-y",
           download_date = "2021-09-17",
           type = "static",
           licence = "CC-BY",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_tsv(paste0(thisPath, "Juergens_2012.tab"), skip = 47)


# manage ontology ---
#
matches <- tibble(new = c(unique(data$`Land use (Type and history)`)),
                  old = c("Permanent grazing", "Permanent grazing", "Permanent grazing", "Forests",
                          "Forests", "Permanent grazing", "Permanent grazing", "Permanent grazing",
                          "Permanent grazing", "Permanent grazing", "Permanent grazing", "Permanent grazing",
                          "Permanent grazing", "Permanent grazing", "Permanent grazing", NA,
                          "Permanent grazing", "Permanent grazing", NA, "Permanent grazing",
                          NA, "Permanent grazing", "Permanent grazing", "Permanent grazing",
                          "Permanent grazing","Permanent grazing","Permanent grazing","Permanent grazing"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 2)



# harmonise data ----
#
data$`Years (With vascular plant data)`[13] <- "2004-2009" # this comes as error in the input data

years <- data %>%
  select(years = `Years (With vascular plant data)`)
years <- map_df(.x = seq_along(years$years), .f = function(ix){
  temp <- str_split(years[ix, ], ",")[[1]]
  out <- map(seq_along(temp), function(iy){
    if(str_detect(string = temp[iy], pattern = "-")){
      temp2 <- str_split(string = temp[iy], pattern = "-")[[1]]
      temp2 <- temp2[1]:temp2[2]
    } else {
      temp2 <- temp[iy]
    }
    if(all(temp2 == "")) NULL else trimws(temp2)
  }) %>% unlist()
  tibble(years = paste0(out, collapse = ", "))
})


temp <- data %>%
  mutate(
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    year = years$years,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    presence = TRUE,
    area = 1000000,
    type = "areal",
    country = Country,
    irrigated = FALSE,
    externalID = `Sample label (Observatory No.)`,
    externalValue = `Land use (Type and history)`,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    geometry = NA,
    collector = "expert",
    purpose = "monitoring",
    epsg = 4326) %>%
  separate_rows(year, sep = ", ") %>%
  mutate(
    year = as.numeric(year),
    day = as.integer(day)) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
