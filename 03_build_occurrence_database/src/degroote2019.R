# script arguments ----
#
thisDataset <- "DeGroote2019"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "S037842901930704X.bib"))

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

description <- "The development and deployment of high-yielding stress tolerant maize hybrids are important components of the efforts to increase maize productivity in eastern Africa. This study was conducted to: i) evaluate selected, stress-tolerant maize hybrids under farmers’ conditions; ii) identify farmers’ selection criteria in selecting maize hybrids; and iii) have farmers evaluate the new varieties according to those criteria. Two sets of trials, one with 12 early-to-intermediate maturing and the other with 13 intermediate-to-late maturing hybrids, improved for tolerance to multiple stresses common in farmers’ fields in eastern Africa (drought, northern corn leaf blight, gray leaf spot, common rust, maize streak virus), were evaluated on-farm under smallholder farmers’ conditions in a total of 42 and 40 environments (site-year-management combinations), respectively, across Kenya, Uganda, Tanzania and Rwanda in 2016 and 2017. Farmer-participatory variety evaluation was conducted at 27 sites in Kenya and Rwanda, with a total of 2025 participating farmers. Differential performance of the hybrids was observed under low-yielding (<3t ha−1) and high-yielding (>3t ha−1) environments. The new stress-tolerant maize hybrids had a much better grain-yield performance than the best commercial checks under smallholder farmer growing environments but had a comparable grain-yield performance under optimal conditions. These hybrids also showed better grain-yield stability across the testing environments, providing an evidence for the success of the maize-breeding approach. In addition, the new stress- tolerant varieties outperformed the internal genetic checks, indicating genetic gain under farmers’ conditions. Farmers gave high importance to grain yield in both farmer-stated preferences (through scores) and farmer-revealed preferences of criteria (revealed by regressing the overall scores on the scores for the individual criteria). The top-yielding hybrids in both maturity groups also received the farmers’ highest overall scores. Farmers ranked yield, early maturity, cob size and number of cobs as the most important traits for variety preference. The criteria for the different hybrids did not differ between men and women farmers. Farmers gave priority to many different traits in addition to grain yield, but this may not be applicable across all maize-growing regions. Farmer-stated importance of the different criteria, however, were quite different from farmer- revealed importance. Further, there were significant differences between men and women in the revealed-importance of the criteria. We conclude that incorporating farmers’ selection criteria in the stage-gate advancement process of new hybrids by the breeders is useful under the changing maize-growing environments in sub-Saharan Africa, and recommended to increase the turnover of new maize hybrids."
url <- "https://data.mendeley.com/datasets/jf6wxs2788/1, https://doi.org/10.1016/j.fcr.2019.107693"
license <- "CC BY-NC 3.0"

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("2022-10-28"),
           type = "static",
           licence = license,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           path = occurrenceDBDir)

# read dataset ----
#

data <- read_sav(file = paste0(thisPath, "STMA 2016_17 File 4_Plot level data yield and mean pve trait scores achive v6.sav"))


# manage ontology ---
#
newConcepts <- tibble(target = ,
                      new = ,
                      class = ,
                      description = ,
                      match = ,
                      certainty = )

luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        date = Sys.Date(),
                        homepage = url,
                        license = license,
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = newConcepts$new,
                         target = get_concept(x = newConcepts %>% select(label = target), ontology = luckiOnto),
                         source = thisDataset,
                         description = newConcepts$description,
                         match = newConcepts$match,
                         certainty = newConcepts$certainty,
                         ontology = luckiOnto, matchDir = paste0(occurrenceDBDir, "01_concepts/"))


# harmonise data ----
#
# carry out optional corrections and validations ...


# ... and then reshape the input data into the harmonised format
#
# column         type            description
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
# date           [POSIXct]    *  see lubridate-package. These can be very easily
#                                created for instance with dmy(SURV_DATE), if
#                                its in day/month/year format
# externalID     [character]     the external ID of the input data
# externalValue  [character]  *  the external target label
# irrigated      [logical]       the irrigation status, in case it is provided
# presence       [logical]       whether the data are 'presence' data (TRUE), or
#                                whether they are 'absence' data (i.e., that the
#                                data point indicates the value in externalValue
#                                is not present) (FALSE)
# LC1/2/3_orig   [character]     if externalValue is associated with one or more
#                                landcover values, provide them here
# sample_type    [character]  *  "field", "visual interpretation", "experience",
#                                "meta study" or "modelled"
# collector      [character]  *  "expert", "citizen scientist" or "student"
# purpose        [character]  *  "monitoring", "validation", "study" or
#                                "map development"
#
# - columns with a * are obligatory, i.e., their default value below needs to be
# replaced

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = NA_character_,
    x = Long_DD,
    y = Latt_DD,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste0(YEAR, "-01-01")),
    externalID = NA_character_,
    externalValue = "maize",
    irrigated = NA,
    presence = F,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = NA_character_,
    collector = NA_character_,
    purpose = NA_character_) %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated,presence, LC1_orig, LC2_orig,
         LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(path = occurrenceDBDir, name = thisDataset)

write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
