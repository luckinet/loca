# script arguments ----
#
thisDataset <- "Kenefic2019"
description <- "This data package contains crop tree, overstory, sapling, and regeneration data collected at the Penobscot Experimental Forest in Maine between 2008 and 2017. These data were collected as part of the project titled Rehabilitation of cutover mixedwood stands: An economic and silvicultural assessment of alternatives as described in Appendix C of FS-NRS-07-08-01 Silvicultural effects on composition, structure and growth of northern conifers in the Acadian Forest Region 2008 study plan (also known as the Compartment Management Study, see Kenefic et al. 2015). While the Rehabilitation study was conducted within two management units (MUs) of the Compartment Management Study (CMS) the data for the Rehabilitation study are independent of the CMS. The Rehabilitation study examined two levels of intervention treatments against controls in two stands that had been subjected to repeated commercial clearcutting harvests, last occurring 20 and 25 years before. The intervention treatments were 1) moderate treatment, in which crop trees were identified and released, and 2) intensive treatment, in which crop trees were released, unacceptable growing stock was removed, and fill planting of red spruce was conducted. Available data include crop tree species, locations, diameter at beast height (DBH), height, and mortality; overstory species, locations, and DBH; regeneration tally by species; and sapling species and DBH.",
url <- "https://doi.org/10.2737/RDS-2016-0024-2 https://"
licence <- ""


# reference ----
#
bib <- bib <- bibentry(
  bibtype = "Misc",
  title = "Overstory and regeneration data from the 'Rehabilitation of cutover mixedwood stands' study at the Penobscot Experimental Forest",
  year = "2019",
  doi = "https://doi.org/10.2737/RDS-2016-0024-2",
  institution = "Forest Service Research Data Archive",
  author = c(
    person(c("Laura S.", "Kenefic")),
    person(c("Kathryn M.", "Gerndt")),
    person(c("Joshua J.", "Puhlick")),
    person(c("Christian", "Kuehne"))))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("01-06-2022"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Data/PEF_RehabTbl_OverstoryPlotLocations.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    year = "2008_2009_2010_2011_2012_2013_2014_2015_016_2017",
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = LONGITUDE,
    y = LATITUDE ,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = "Planted Forest",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_")%>%
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
