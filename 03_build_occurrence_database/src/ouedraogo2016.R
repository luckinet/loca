# script arguments ----
#
thisDataset <- "Ouedraogo2016"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_13652745104.bib"))

regDataset(name = thisDataset,
           description = "Understanding the environmental determinants of forests deciduousness i.e. proportion of deciduous trees in a forest stand, is of great importance when predicting the impact of ongoing global climate change on forests. In this study, we examine (i) how forest deciduousness varies in relation to rainfall and geology, and (ii) whether the influence of geology on deciduousness could be related to differences in soil fertility and water content between geological substrates. The study was conducted in mixed moist semi-deciduous forests in the northern part of the Congo basin. We modelled the response of forest deciduousness to the severity of the dry season across four contrasting geological substrates (sandstone, alluvium, metamorphic and basic rocks). For this, we combined information on forest composition at genus level based on commercial forest inventories (62 624 0.5 ha plots scattered over 6 million of ha), leaf habit, and rainfall and geological maps. We further examined whether substrates differ in soil fertility and water-holding capacity using soil data from 37 pits in an area that was, at the time, relatively unexplored. Forest deciduousness increased with the severity of the dry season, and this increase strongly varied with the geological substrate. Geology was found to be three times more important than the rainfall regime in explaining the total variation in deciduousness. The four substrates differed in soil properties, with higher fertility and water-holding capacity on metamorphic and basic rocks than on sandstone and alluvium. The increase in forest deciduousness was stronger on the substrates that formed resource-rich clay soils (metamorphic and basic rocks) than on substrates that formed resource-poor sandy soils (sandstone and alluvium). Synthesis. We found evidence that tropical forest deciduousness is the result of both the competitive advantage of deciduous species in climates with high rainfall seasonality, and the persistence of evergreen species on resource-poor soils. Our findings offer a clear illustration of well-known theoretical leaf carbon economy models, explaining the patterns in the dominance of evergreen versus deciduous species. And, this large-scale assessment of the interaction between climate and geology in determining forest deciduousness may help to improve future predictions of vegetation distribution under climate change scenarios. In central Africa, forest is likely to respond differently to variation in rainfall and/or evapotranspiration depending on the geological substrate.",
           url = "https://doi.org/10.1111/1365-2745.12589",
           download_date = "2022-01-10",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_delim(paste0(thisPath, "plot.txt"), delim = ";")


# manage ontology ---
#
matches <- tibble(new = "moist semi-deciduous forests",
                  old = c("Naturally regenerating forest"))

newConcept(new = matches$new,
           broader = "Forests",
           class = "forest type",
           source = thisDataset)

getConcept(label_en = matches$new) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#
data <- data %>% mutate(year = "2007_2008_2009_2010_2011_2012_2013_2014_2015") %>%
  separate_rows(year, sep= "_")

temp <- data %>%
  mutate(
    fid = row_number(),
    type = "point",
    x = plot_x,
    y = plot_y,
    geometry = NA,
    year = as.numeric(year),
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    country = "Cameroon, Central African Republic, Republic of Congo",
    irrigated = FALSE,
    area = surf,
    presence = TRUE,
    externalID = plot,
    externalValue = matches$new,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
