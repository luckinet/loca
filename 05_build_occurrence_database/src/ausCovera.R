# script arguments ----
#
thisDataset <- "ausCovera"
description <- "The Biomass Plot Library is a collation of stem inventory data across federal, state and local government departments, universities, private companies and other agencies. It was motivated by the need for calibration/validation data to underpin national mapping of above-ground biomass from integration of Landsat time-series, ICESat/GLAS lidar, and ALOS PALSAR bacscatter data under the auspices of the JAXA Kyoto & Carbon (K&C) Initiative (Armston et al., 2016). At the time of Version 1.0 publication 1,073,837 hugs of 839,866 trees across 1,467 species had been collated. This has resulted from 16,391 visits to 12,663 sites across most of Australia's bioregions. Data provided for each project by the various source organisation were imported to a PostGIS database in their native form and then translated to a common set of tree, plot and site level observations with explicit plot footprints where available. Data can be downloaded from https://field.jrsrp.com/ by selecting the combinations Tree biomass and Site Level, Tree Biomass and Tree Level."
url <- "https://doi.org/ http://qld.auscover.org.au/public/html/field/" # doi, in case this exists and download url separated by empty space
licence <- "CC BY 4.0"


# reference ----
#
bib <- bibentry(bibtype =  "Misc",
                author = person("Joint Remote Sensing Research Program"),
                year = 2016,
                title = "Biomass Plot Library - National collation of stem inventory data and biomass estimation, Australian field sites",
                organization = "Terrestrial Ecosystem Research Network",
                url = "https://portal.tern.org.au/biomass-plot-library-field-sites/23218")

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("13-05-2022"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "biolib_sitelist.csv"))


# harmonise data ----
#
temp <- data %>%
  distinct(longitude, latitude, estdate, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Austraila",
    x = longitude,
    y = latitude,
    geometry = NA,
    epsg = 4326,
    area = sitearea_ha * 10000,
    date = ymd(estdate),
    externalID = FID,
    externalValue = "Forests",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)

# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
