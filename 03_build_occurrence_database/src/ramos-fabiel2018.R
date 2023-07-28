# script arguments ----
#
thisDataset <- "Ramos-Fabiel2018"
description <- "Despite the recent rapid growth of tropical dry forest succession ecology, most studies on this topic have focused on plant community attribute recovery, whereas animal community successional dynamics has been largely overlooked, and the few existing studies have used taxonomic approaches. Here, we analyze the successional changes in the bee community in a Mexican tropical dry forest, by integrating taxonomic (species, genus, and family diversity) and functional (sociability, nesting strategy, and body size) information for bees. Over one year, in a successional chronosequence (2–67 years after abandonment) we collected 469 individual bees, representing five families, 36 genera, and 69 species. Linear modeling showed decreases in taxonomic diversity with succession, more strongly so for species. Bee species turnover along succession ranged from moderate to high, decreasing slightly at intermediate stages. An RLQ analysis (ordination method that allows relating environmental variables with functional attributes) revealed clear relations between bee functional traits and the plant community. RLQ axis 1 was positively related to vegetation structural and diversity variables, and to eusociality, while solitary, parasociality, and ground nesting was negatively associated with it. Early successional fallows attract mostly solitary and parasocial bees; older fallows tend to attract eusocial bees with aerial nesting. The continuous taxonomic turnover observed by us and the functional analysis suggest that the disappearance of old fallows from agricultural landscapes would likely result in significant reductions and even local extinctions of particular bee guilds. Considering the low viability of preserving large mature tropical dry forest tracts, the conservation of older successional stands emerges as a crucial component of landscape management.Abstract in Spanish is available with online material."
url <- "https://doi.org/10.1111/btp.12619, https://doi.org/10.5061/dryad.28hv53f"
license <- ""


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1744742951.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-07"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Ramos-Fabiel et al DataBase.xlsx"))


# pre-process data ----
#
data <- data[-c(10:13),]
# transform coordinates
chd = "°"
chm = "'"
chs = "\""

temp <- data %>%
  mutate(y = as.numeric(char2dms(data$Latitude, chd = chd, chm = chm, chs = chs)),
         x = as.numeric(char2dms(data$Longitude, chd = chd, chm = chm, chs = chs)))

# add Dates
# We sampled the bee community bimonthly over one year (July 2010–May 2011)
# DATES: July 2010, September 2010, November 2010, Januar 2011, March 2011, May 2011

temp$date <- paste(paste0("7-2010_9-2010_11-2010_1-2011_3-2011_4-2011"))
temp <- temp %>% separate_rows(date, sep= "_") %>% separate(date, sep = "-", c("month", "year"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Mexico",
    x = NA_real_,
    y = NA_real_,
    geometry = NA,
    epsg = 4326,
    area = `Site size`,
    date = ymd(paste(year, month, "01", sep = "-")),
    externalID = NA_character_,
    externalValue = NA_character_,
    irrigated = NA,
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

