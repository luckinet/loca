# script arguments ----
#
thisDataset <- "ausCovera"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibentry(bibtype =  "Misc",
                author = person("Joint Remote Sensing Research Program"),
                year = 2016,
                title = "Biomass Plot Library - National collation of stem inventory data and biomass estimation, Australian field sites",
                organization = "Terrestrial Ecosystem Research Network",
                url = "https://portal.tern.org.au/biomass-plot-library-field-sites/23218")

regDataset(name = thisDataset,
           description = "The Biomass Plot Library is a collation of stem inventory data across federal, state and local government departments, universities, private companies and other agencies. It was motivated by the need for calibration/validation data to underpin national mapping of above-ground biomass from integration of Landsat time-series, ICESat/GLAS lidar, and ALOS PALSAR bacscatter data under the auspices of the JAXA Kyoto & Carbon (K&C) Initiative (Armston et al., 2016). At the time of Version 1.0 publication 1,073,837 hugs of 839,866 trees across 1,467 species had been collated. This has resulted from 16,391 visits to 12,663 sites across most of Australia's bioregions. Data provided for each project by the various source organisation were imported to a PostGIS database in their native form and then translated to a common set of tree, plot and site level observations with explicit plot footprints where available. Data can be downloaded from https://field.jrsrp.com/ by selecting the combinations Tree biomass and Site Level, Tree Biomass and Tree Level",
           url = "http://qld.auscover.org.au/public/html/field/",
           download_date = "2022-05-13",
           type = "static", #
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# select your library: field -> select your dataset: ground lidar (2012 - 2016)
# select your library: field -> select your dataset: tree structure (2011 - 2016)
# select your library: field -> select your dataset: star transect (1996 - 2018)
#
# http://data.auscover.org.au/xwiki/bin/view/Field+Sites/Terrestrial+Laser+Scanner+Protocol+Web+Page
# http://data.auscover.org.au/xwiki/bin/view/Field+Sites/Tree+Structural+Characteristics+Protocol+Web+Page
# http://data.auscover.org.au/xwiki/bin/view/Field+Sites/Star+Transect+Protocol+Web+Page



# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#
data <- read_csv(file = paste0(thisPath, "biolib_sitelist.csv"))


# harmonise data ----
#
temp <- data %>%
  distinct(longitude, latitude, estdate, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = longitude,
    y = latitude,
    geometry = NA,
    date = ymd(estdate),
    country = "Austraila",
    irrigated = F,
    area = sitearea_ha * 10000,
    presence = F,
    externalID = FID,
    externalValue = "Forests",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "validation",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
