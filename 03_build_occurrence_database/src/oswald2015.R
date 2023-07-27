# script arguments ----
#
thisDataset <- "Oswald2015"
description <- "Aim To evaluate the roles of Quaternary (< 2.6 Ma) climatic stability and geologic barriers (i.e. the Andes Mountains) in shaping the modern community composition and patterns of endemism in Neotropical dry forest bird communities. Location Marañón Valley and Tumbes, north-western Peru. Methods: We recorded presence and abundance of species in six dry forest bird communities on either side of the Andes Mountains. We used the data to calculate the beta diversity and phylogenetic beta diversity across regional and local scales. We compared the observed results to randomly permuted communities to determine if the communities were significantly more or less similar than we would expect by chance. Mantel tests evaluated whether beta diversity and phylogenetic beta diversity measures were correlated and whether there was a correlation between spatial distance and community diversity. Results: Bird community composition, including abundance, is highly heterogeneous in north-western Peru, even at relatively local scales. Communities on either side of the Andes are significantly different based on beta diversity and phylogenetic beta diversity. Communities subjected to more historical climatic fluctuations share a more similar species composition than communities that are relatively buffered from climatic change. Main conclusions:The Andes structure dry forest bird communities in north-western Peru. Greater community similarity in climatically unstable areas may be the product of formerly more continuous forest and/or movement of species among communities. In climatically stable regions, species turnover is not different from random expectations, which may reflect habitat loss and increased homogenization from anthropogenic landscape changes. Both the Andes and the historical (Quaternary) climatic regimes of north-western Peru are likely responsible for the high endemism and distributions of its dry forest bird communities."
url <- "https://doi.org/10.1111/jbi.12605 https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1365269943.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-10"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(path = paste0(thisPath, "Oswald_et_al_2015_dryad.56p0f.xlsx"), sheet = 1)


# pre-process data ----
#
exceltime <- data[!grepl("OCT", data$Date),]
exceltime$Date <- as.Date(as.numeric(exceltime$Date), origin = "1899-12-30")
exceltime <- exceltime %>% mutate(
  year = year(Date),
  month = month(Date),
  day = day(Date))

# String Dates
temp <- data %>% separate(Date, sep = " ", into = c("DateN", "times")) %>%
  mutate(ID = row_number()) %>% filter(grepl("OCT", data$Date))
temp <- temp %>% separate(DateN, sep = "-", into = c("day", "month", "year"))
temp$month <- gsub("OCT", "10", temp$month)
temp$year <- temp$year[temp$year == 11] <- 2011
temp <- temp %>% mutate(
  month = as.numeric(month),
  day = as.numeric(day))

temp <- bind_rows(temp, exceltime)

# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Peru",
    x = `Latitude Decimal Degrees`,
    y = `Longitude Decimal Degrees`,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste0(year, month, day)),
    externalID = NA_character_,
    externalValue = "Naturally Regenerating Forest",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
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
