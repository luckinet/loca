# script arguments ----
#
thisDataset <- "Sinasson2016"
description <- "Harvesting of Non-Timber Forest Products (NTFPs) can threaten target species, especially those with limited distribution and density. Exploited species also face threats from habitat fragmentation, fire, and invasive species. We assessed the impact of human disturbances and invasive species on the population of a key multipurpose NTFP species, Mimusops andongensis, in Lama Forest reserve (Benin). The densities of adult trees and regenerative stems decreased with increasing degradation. Mimusops andongensis contributed less to total tree density with increasing human disturbance. There were significantly fewer M. andongensis recruits with increasing cover of invasive Chromolaena odorata. Smaller diameter individuals predominated in non-degraded and moderately degraded sites while in degraded sites, the structure showed a negative exponential trend with the density of small diameter individuals being less than two trees/ha. Larger individuals were also rare in degraded sites. The low density of both mature trees and seedlings in degraded sites may undermine the long-term viability of M. andongensis, despite existing protection against NTFP harvesting and other anthropogenic pressures. Management should emphasize facilitating recruitment subsidies and limiting the presence of C. odorata."
url <- "https://doi.org/10.5061/dryad.d1m02 https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_1744742949.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-05-30"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Data_Impact of Forest Degradation and Invasive species on Mimusops andongensis in Lama Forest Reserve in Benin.xlsx"), sheet = 4) %>%
  left_join(., read_excel(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Data_Impact of Forest Degradation and Invasive species on Mimusops andongensis in Lama Forest Reserve in Benin.xlsx"), sheet = 1), by = "Plot")



# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Benin",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = 1500,
    date = NA,
    year = "1988_1989_1990_1991_1992_1993_1994_1995_1996_1997_1998_1999_2000_2001_2002_2003_2004_2005_2006_2007_2008_2009_2010_2011_2012_2013_2014_2015",
    month = NA_real_,
    day = NA_integer_,
    externalID = NA_character_,
    externalValue = Vegetation_type,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year),
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
