# script arguments ----
#
thisDataset <- "Lewis2013"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "rsj_rstb368.bib"))

regDataset(name = thisDataset,
           description = "We report above-ground biomass (AGB), basal area, stem density and wood mass density estimates from 260 sample plots (mean size: 1.2 ha) in intact closed-canopy tropical forests across 12 African countries. Mean AGB is 395.7 Mg dry mass ha−1 (95% CI: 14.3), substantially higher than Amazonian values, with the Congo Basin and contiguous forest region attaining AGB values (429 Mg ha−1) similar to those of Bornean forests, and significantly greater than East or West African forests. AGB therefore appears generally higher in palaeo- compared with neotropical forests. However, mean stem density is low (426 ± 11 stems ha−1 greater than or equal to 100 mm diameter) compared with both Amazonian and Bornean forests (cf. approx. 600) and is the signature structural feature of African tropical forests. While spatial autocorrelation complicates analyses, AGB shows a positive relationship with rainfall in the driest nine months of the year, and an opposite association with the wettest three months of the year; a negative relationship with temperature; positive relationship with clay-rich soils; and negative relationships with C : N ratio (suggesting a positive soil phosphorus–AGB relationship), and soil fertility computed as the sum of base cations. The results indicate that AGB is mediated by both climate and soils, and suggest that the AGB of African closed-canopy tropical forests may be particularly sensitive to future precipitation and temperature changes.",
           url = "https://royalsocietypublishing.org/doi/10.1098/rstb.2012.0295",
           download_date = "2022-01-19",
           type = "static",
           licence = "CC-BY 3.0",
           contact = "s.l.lewis@leeds.ac.uk",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "rstb20120295supp1-converted.xlsx"))


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    x = is.numeric(Lat),
    y = is.numeric(Long),
    year = NA_real_,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = Countryname,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = "Forest land",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())

# before preparing data for storage, test that all required variables are available
assertNames(x = names(temp),
            must.include = c("datasetID", "fid", "country", "x", "y", "epsg",
                             "year", "month", "day", "irrigated",
                             "externalID", "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                             "sample_type", "collector", "purpose"))


# write output ----
#
saveDataset(object = temp, dataset = thisDataset)
