# script arguments ----
#
thisDataset <- "DeClercq2012"
description <- "The cattle tick Rhipicephalus microplus is currently invading the West African region, and little information is available on the spread of this exotic tick in this region. We set out a country-wide field survey to determine its current distribution in Benin. Ticks were collected on cattle from 106 farms selected by random sampling covering all regions of the country. Rhipicephalus annulatus was found on 70 % of all farms, R. decoloratus on 42 %, R. geigyi on 58 %, and R. microplus on 49 %. There is a clear geographic separation between the indigenous Rhipicephalus species and R. microplus. Rhipicephalus annulatus occurs mainly in the northern departments, but it was also observed in lower numbers in locations in the south. The presence of R. decoloratus is limited to the northern region, and in most locations, this tick makes up a small proportion of the collected ticks. The tick R. geigyi tends to be dominant, but occurs only in the four northern departments. The observations concerning R. microplus are entirely different, this species occurs in the southern and central region. The results of this survey confirm the invasive character and displacement properties of R. microplus, since in less than a decade it has colonized more than half of the country and has displaced indigenous ticks of the same genus in many of the sampled locations."
url <- "https://doi.org/10.1007/s10493-012-9587-0 https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "10.1007_s10493-012-9587-0-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-06-01"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Table 2 Geographic coordinates of the visited farms, collection data and collected ticks.xlsx"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = year(Date),
    # month = month(Date),
    # day = day(Date),
    externalID = NA_character_,
    externalValue = "cattle",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
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
