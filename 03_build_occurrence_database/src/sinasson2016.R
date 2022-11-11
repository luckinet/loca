# script arguments ----
#
thisDataset <- "Sinasson2016"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "pericles_1744742949.ris"))

regDataset(name = thisDataset,
           description = "Harvesting of Non-Timber Forest Products (NTFPs) can threaten target species, especially those with limited distribution and density. Exploited species also face threats from habitat fragmentation, fire, and invasive species. We assessed the impact of human disturbances and invasive species on the population of a key multipurpose NTFP species, Mimusops andongensis, in Lama Forest reserve (Benin). The densities of adult trees and regenerative stems decreased with increasing degradation. Mimusops andongensis contributed less to total tree density with increasing human disturbance. There were significantly fewer M. andongensis recruits with increasing cover of invasive Chromolaena odorata. Smaller diameter individuals predominated in non-degraded and moderately degraded sites while in degraded sites, the structure showed a negative exponential trend with the density of small diameter individuals being less than two trees/ha. Larger individuals were also rare in degraded sites. The low density of both mature trees and seedlings in degraded sites may undermine the long-term viability of M. andongensis, despite existing protection against NTFP harvesting and other anthropogenic pressures. Management should emphasize facilitating recruitment subsidies and limiting the presence of C. odorata. ",
           url = "https://doi.org/10.5061/dryad.d1m02",
           download_date = "2022-05-30",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#
data <- read_excel(paste0(thisPath, "Data_Impact of Forest Degradation and Invasive species on Mimusops andongensis in Lama Forest Reserve in Benin.xlsx"), sheet = 4) %>%
  left_join(., read_excel(paste0(thisPath, "Data_Impact of Forest Degradation and Invasive species on Mimusops andongensis in Lama Forest Reserve in Benin.xlsx"), sheet = 1), by = "Plot")



# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
matches <- tibble(new = c(unique(data$Vegetation_type)),
                  old = c("Naturally Regenerating Forest", "Undisturbed Forest", "Naturally Regenerating Forest", "Naturally Regenerating Forest"))


getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = ,
             source = thisDataset,
             certainty = )


# harmonise data ----
#
# carry out optional corrections and validations ...

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    type = "areal",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    year = "1988_1989_1990_1991_1992_1993_1994_1995_1996_1997_1998_1999_2000_2001_2002_2003_2004_2005_2006_2007_2008_2009_2010_2011_2012_2013_2014_2015",
    month = NA_real_,
    day = NA_integer_,
    country = "Benin",
    irrigated = F,
    area = 1500,
    presence = T,
    externalID = NA_character_,
    externalValue = Vegetation_type,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year),
         fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
