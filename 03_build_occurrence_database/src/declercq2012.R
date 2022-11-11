# script arguments ----
#
thisDataset <- "DeClercq2012"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1007_s10493-012-9587-0-citation.ris"))

regDataset(name = thisDataset,
           description = "The cattle tick Rhipicephalus microplus is currently invading the West African region, and little information is available on the spread of this exotic tick in this region. We set out a country-wide field survey to determine its current distribution in Benin. Ticks were collected on cattle from 106 farms selected by random sampling covering all regions of the country. Rhipicephalus annulatus was found on 70 % of all farms, R. decoloratus on 42 %, R. geigyi on 58 %, and R. microplus on 49 %. There is a clear geographic separation between the indigenous Rhipicephalus species and R. microplus. Rhipicephalus annulatus occurs mainly in the northern departments, but it was also observed in lower numbers in locations in the south. The presence of R. decoloratus is limited to the northern region, and in most locations, this tick makes up a small proportion of the collected ticks. The tick R. geigyi tends to be dominant, but occurs only in the four northern departments. The observations concerning R. microplus are entirely different, this species occurs in the southern and central region. The results of this survey confirm the invasive character and displacement properties of R. microplus, since in less than a decade it has colonized more than half of the country and has displaced indigenous ticks of the same genus in many of the sampled locations.",
           url = "https://doi.org/10.1007/s10493-012-9587-0",
           download_date = "2022-06-01",
           type = "static",
           licence = "",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_excel(paste0(thisPath, "Table 2 Geographic coordinates of the visited farms, collection data and collected ticks.xlsx"))


# harmonise data ----
#

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    year = year(Date),
    month = month(Date),
    day = day(Date),
    country = NA_character_,
    irrigated = F,
    area = NA_real_,
    presence = F,
    externalID = NA_character_,
    externalValue = "cattle",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
