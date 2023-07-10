# script arguments ----
#
thisDataset <- "BAAD"
description <- "Understanding how plants are constructed; i.e., how key size dimensions and the amount of mass invested in different tissues varies among individuals; is essential for modeling plant growth, estimating carbon stocks, and mapping energy fluxes in the terrestrial biosphere."
url <- "https://dx.doi.org/10.1890/14-1889.1 https://" # doi, in case this exists and download url separated by empty space
licence <- "CC BY 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1939917096.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("10-09-2019"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "baad_data/baad_data.csv"))


# harmonise data ----
#
# carry out optional corrections and validations ...


# ... and then reshape the input data into the harmonised format
#
# don't change the below setup and only insert the values it asks for. Only add
# new columns when they are a relevant attribute that gives additional
# information on the 'externalValue'. The values should then be recorded in
# 'attr_1' and the column 'attr_1_type' needs to contain the type of the
# attribute.
#
# column         type         *  description
# ------------------------------------------------------------------------------
# type           [character]  *  "point" or "areal" (when its from a plot,
#                                region, nation, etc)
# country        [character]  *  the country of observation
# x              [numeric]    *  x-value of centroid
# y              [numeric]    *  y-value of centroid
# geometry       [sf]            in case type = "areal", this should be the
#                                geometry column
# epsg           [numeric]    *  the EPSG code of the coordinates or geometry
# area           [numeric]       in case the features are from plots and the
#                                table gives areas but no 'geometry' is
#                                available
# date           [POSIXct]    *  date of the data collection; see lubridate
#                                package. These can be very easily created for
#                                instance with dmy(SURV_DATE), if it is in
#                                day/month/year format
# externalID     [character]     the external ID of the input data
# externalValue  [character]  *  the external target label
# irrigated      [logical]       the irrigation status, in case it is provided
# presence       [logical]       whether the data are 'presence' data (TRUE), or
#                                whether they are 'absence' data (i.e., that the
#                                data point indicates the value in externalValue
#                                is not present) (FALSE)
# sample_type    [character]  *  "field", "visual interpretation", "experience",
#                                "meta study" or "modelled"
# collector      [character]  *  "expert", "citizen scientist" or "student"
# purpose        [character]  *  "monitoring", "validation", "study" or
#                                "map development"
# attr_[n]       [character]     if externalValue is associated with one or more
#                                attributes that are relevant, provide them here
# attr_[n]_type  [character]     if attr[n] is defined, provide here the type
#                                (open definition)
#
# columns with a * are obligatory, i.e., their default value below needs to be
# replaced

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = NA_character_,
    x = NA_real_,
    y = NA_real_,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = NA_character_,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = NA,
    sample_type = NA_character_,
    collector = NA_character_,
    purpose = NA_character_) %>%
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
