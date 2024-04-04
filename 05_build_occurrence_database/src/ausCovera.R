# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : http://qld.auscover.org.au/public/html/field/
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisDataset <- "ausCovera"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- bibentry(bibtype =  "Misc",
                author = person("Joint Remote Sensing Research Program"),
                year = 2016,
                title = "Biomass Plot Library - National collation of stem inventory data and biomass estimation, Australian field sites",
                organization = "Terrestrial Ecosystem Research Network",
                url = "https://portal.tern.org.au/biomass-plot-library-field-sites/23218")

data_path <- paste0(dir_input, "biolib_sitelist.csv")
data <- read_csv(file = data_path)


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)

other <- data %>%
  select(obsID, _INSERT)

schema_INSERT <-
  setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
            na_values = _INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "externalID", columns = _INSERT) %>%
  setIDVar(name = "open", type = "l", value = _INSERT) %>%
  setIDVar(name = "type", value = _INSERT) %>%
  setIDVar(name = "x", type = "n", columns = _INSERT) %>%
  setIDVar(name = "y", type = "n", columns = _INSERT) %>%
  setIDVar(name = "geometry", columns = _INSERT) %>%
  setIDVar(name = "date", columns = _INSERT) %>%
  setIDVar(name = "irrigated", type = "l", value = _INSERT) %>%
  setIDVar(name = "present", type = "l", value = _INSERT) %>%
  setIDVar(name = "sample_type", value = _INSERT) %>%
  setIDVar(name = "collector", value = _INSERT) %>%
  setIDVar(name = "purpose", value = _INSERT) %>%
  setObsVar(name = "concept", type = "c", columns = _INSERT)

# temp <- data %>%
#   distinct(longitude, latitude, estdate, .keep_all = T) %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "areal",
#     country = "Austraila",
#     x = longitude,
#     y = latitude,
#     geometry = NA,
#     epsg = 4326,
#     area = sitearea_ha * 10000,
#     date = ymd(estdate),
#     externalID = FID,
#     externalValue = "Forests",
#     irrigated = FALSE,
#     presence = FALSE,
#     sample_type = "field",
#     collector = "expert",
#     purpose = "validation") %>%
#   select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
#          externalID, externalValue, irrigated, presence,
#          sample_type, collector, purpose, everything())


temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "The Biomass Plot Library is a collation of stem inventory data across federal, state and local government departments, universities, private companies and other agencies. It was motivated by the need for calibration/validation data to underpin national mapping of above-ground biomass from integration of Landsat time-series, ICESat/GLAS lidar, and ALOS PALSAR bacscatter data under the auspices of the JAXA Kyoto & Carbon (K&C) Initiative (Armston et al., 2016). At the time of Version 1.0 publication 1,073,837 hugs of 839,866 trees across 1,467 species had been collated. This has resulted from 16,391 visits to 12,663 sites across most of Australia's bioregions. Data provided for each project by the various source organisation were imported to a PostGIS database in their native form and then translated to a common set of tree, plot and site level observations with explicit plot footprints where available. Data can be downloaded from https://field.jrsrp.com/ by selecting the combinations Tree biomass and Site Level, Tree Biomass and Tree Level.",
           homepage = "http://qld.auscover.org.au/public/html/field/",
           date = dmy("13-05-2022"),
           license = "https://creativecommons.org/licenses/by/4.0/",
           ontology = path_onto_odb)

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = path_onto_odb)

out <- list(harmonised = out, extra = other)


message(" --> writing output")
saveRDS(object = out, file = paste0(dir_occurr, "output/", thisDataset, ".rds"))
saveBIB(object = bib, file = paste0(dir_occurr, "references.bib"))

beep(sound = 10)
message("\n     ... done")
