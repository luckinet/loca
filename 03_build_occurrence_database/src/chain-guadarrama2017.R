# script arguments ----
#
thisDataset <- "Chain-Guadarrama2017"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1600058741.bib")) # choose between ris_reader() or bibtex_reader()

# column         type            description
# name
# description    [character]   description of the data-set
# url            [character]   ideally the doi, but if it doesn't have one, the
#                              main source of the database
# donwload_date  [POSIXct]     the date (DD-MM-YYYY) on which the data-set was
#                              downloaded
# type           [character]   "dynamic" (when the data-set updates regularly)
#                              or "static"
# license        [character]   abbreviation of the license under which the
#                              data-set is published
# contact        [character]   if it's a paper that should be "see corresponding
#                              author", otherwise some listed contact
# disclosed      [logical]
# bibliography   [handl]       bibliography object from the 'handlr' package
# path           [character]   the path to the occurrenceDB

description <- "Quantifying relationships between plant functional traits and abiotic gradients is valuable for evaluating potential responses of forest communities to climate change. However, the trajectories of change expected to occur in tropical forest functional characteristics as a function of future climate variation are largely unknown. We modeled community level trait values of Costa Rican rain forests as a function of current and future climate, and quantified potential changes in functional composition."
url <- "https://doi.org/10.1111/ecog.02637"
license <- "CC0 1.0"

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2021-08-10",
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE,
           notes = "time period imprecise")


# read dataset ----
#
data <- read_delim(paste0(thisPath, "observed CWM traits.csv"), delim = ";", n_max = 127)

# harmonise data ----
#

temp <- data %>%
  distinct(lat, long, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = long,
    y = lat,
    date = NA,
    country = "Costa Rica",
    irrigated = NA,
    area = NA,
    presence = FALSE,
    externalID = PLOT,
    externalValue = "Undisturbed Forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated,presence, LC1_orig, LC2_orig,
         LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(path = occurrenceDBDir, name = thisDataset)

write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
