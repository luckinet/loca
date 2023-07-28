# script arguments ----
#
thisDataset <- "Raymundo2018"
description <- "Recent insights show that tropical forests are shifting in species composition, possibly due to changing environmental conditions. However, we still poorly understand the forest response to different environmental change drivers, which limits our ability to predict the future of tropical forests. Although some studies have evaluated drought effects on tree communities, we know little about the influence of increased water availability. Here, we evaluated how an increase in water availability caused by an artificial reservoir affected temporal changes in forest structure, species and functional diversity, and community-weighted mean traits. Furthermore, we evaluated how demographical groups (recruits, survivors and trees that died) contributed to these temporal changes in tropical dry forests. We present data for the dynamics of forest change over a 10-year period for 120 permanent plots that were far from the water’s edge before reservoir construction and are now close to the water’s edge (0–60 m). Plots close to the water’s edge had an abrupt increase in water availability, while distant plots did not. Plots close to the water’s edge showed an increase in species and functional diversity, and in the abundance of species with traits associated with low drought resistance (i.e., evergreen species with simple leaves and low wood density), whereas plots far from the water’s edge did not change. Changes in overall community metrics were mainly due to recruits rather than to survivors or dead trees. Overall stand basal area did not change because growth and recruitment were balanced by mortality. Synthesis. Our results showed that tropical dry forests can respond quickly to abrupt changes in environmental conditions. Temporal changes in vegetation metrics due to increased water availability were mainly attributed to recruits, suggesting that these effects are lasting and may become stronger over time. The lack of increase in basal area towards the water’s edge, and the shift towards higher abundance of soft-wooded species, could reduce the carbon stored and increase the forest’s vulnerability to extreme weather events. Further “accidental” large-scale field experiments like ours could provide more insights into forest responses and resilience to global change."
url <- "https://doi.org/10.1111/1365-2745.13031 https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "citation-325955139.bib"))

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
data <- read_xlsx(paste0(thisPath, "Data from Raymundo et al. (2018).xlsx"), sheet = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Brazil",
    x = X,
    y = Y,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = paste("2005_", "2006_", "2007_", "2008_", "2009_", "2010_", "2011_", "2012_", "2013_", "2014_", "2015"),
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = "Naturally Regenerating Forest",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
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
