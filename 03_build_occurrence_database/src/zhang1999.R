# script arguments ----
#
thisDataset <- "Zhang1999"
description <- "Limited precipitation restricts yield of winter wheat (Triticum aestivum L.) grown in the North China Plain. Water stress effects on yield can be avoided or minimized by application of irrigation. We examined the multiseasonal irrigation experiments in four locations of the piedmont and lowland in the region, and developed crop water-stress sensitivity index, relationship between seasonal evapotranspiration (ET) and yield, and crop water production functions. By relating relative yield to relative ET deficit, we found that the crop was more sensitive to water stress from stem elongation to heading and from heading to milking. For limited irrigation, irrigation is recommended during the stages sensitive to water stress. Grain yield was 258–322 g m−2 in the piedmont and 260–280 g m−2 in the lowland under rainfed conditions. The corresponding seasonal ET was 242–264 mm in the piedmont and 247–281 mm in the lowland. Irrigation significantly increased seasonal ET and therefore grain yield as a result of increased kernel numbers per m−2 and kernels per ear. On average, one irrigation increased grain yield by 21–43% and two to four irrigations by 60–100%. Grain yield was linearly related to seasonal ET with a slope of 1.15 kg m−3 in the lowland and 1.73 kg m−3 in the piedmont. Water-use efficiency was 0.98–1.22 kg m−3 for rainfed wheat and 1.20–1.40 kg m−3 for the wheat irrigated 2–4 times. Grain yield response to the amount of irrigation (IRR) was developed using a quadratic function and used to analyze different irrigation scenarios. To achieve the maximum grain yield, IRR was 240 mm in the piedmont and 290 mm in the lowland. When the maximum net profit was achieved, IRR was 195 mm and 250 mm in the piedmont and lowland, respectively. The yield response curve to IRR showed a plateau over a large range of IRR, indicating a great potential in saving IRR while maintaining reasonable high levels of grain yield. "
url <- "https://doi.org/10.1007/s002710050069 https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1007_s002710050069-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("3021-12-17"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv2(paste0(thisPath, "Zhang1999.csv"))


# pre-process data ----
#
data <- data %>% mutate(
  x = as.numeric(char2dms(paste0(data$long,'E'), chd = 'd', chm = 'm')),
  y = as.numeric(char2dms(paste0(data$lat,'N'), chd = 'd', chm = 'm')))

# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "China",
    x = x,
    y = y,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = year,
    # month = NA_real_,
    # day = NA_integer_,
    externalID = as.character(ID),
    externalValue = commodities,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field sampling",
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
