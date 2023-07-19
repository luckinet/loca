# script arguments ----
#
thisDataset <- "DeGroote2019"
description <- "The development and deployment of high-yielding stress tolerant maize hybrids are important components of the efforts to increase maize productivity in eastern Africa. This study was conducted to: i) evaluate selected, stress-tolerant maize hybrids under farmers’ conditions; ii) identify farmers’ selection criteria in selecting maize hybrids; and iii) have farmers evaluate the new varieties according to those criteria. Two sets of trials, one with 12 early-to-intermediate maturing and the other with 13 intermediate-to-late maturing hybrids, improved for tolerance to multiple stresses common in farmers’ fields in eastern Africa (drought, northern corn leaf blight, gray leaf spot, common rust, maize streak virus), were evaluated on-farm under smallholder farmers’ conditions in a total of 42 and 40 environments (site-year-management combinations), respectively, across Kenya, Uganda, Tanzania and Rwanda in 2016 and 2017. Farmer-participatory variety evaluation was conducted at 27 sites in Kenya and Rwanda, with a total of 2025 participating farmers. Differential performance of the hybrids was observed under low-yielding (<3t ha−1) and high-yielding (>3t ha−1) environments. The new stress-tolerant maize hybrids had a much better grain-yield performance than the best commercial checks under smallholder farmer growing environments but had a comparable grain-yield performance under optimal conditions. These hybrids also showed better grain-yield stability across the testing environments, providing an evidence for the success of the maize-breeding approach. In addition, the new stress- tolerant varieties outperformed the internal genetic checks, indicating genetic gain under farmers’ conditions. Farmers gave high importance to grain yield in both farmer-stated preferences (through scores) and farmer-revealed preferences of criteria (revealed by regressing the overall scores on the scores for the individual criteria). The top-yielding hybrids in both maturity groups also received the farmers’ highest overall scores. Farmers ranked yield, early maturity, cob size and number of cobs as the most important traits for variety preference. The criteria for the different hybrids did not differ between men and women farmers. Farmers gave priority to many different traits in addition to grain yield, but this may not be applicable across all maize-growing regions. Farmer-stated importance of the different criteria, however, were quite different from farmer- revealed importance. Further, there were significant differences between men and women in the revealed-importance of the criteria. We conclude that incorporating farmers’ selection criteria in the stage-gate advancement process of new hybrids by the breeders is useful under the changing maize-growing environments in sub-Saharan Africa, and recommended to increase the turnover of new maize hybrids."
url <- "https://doi.org/10.1016/j.fcr.2019.107693 https://data.mendeley.com/datasets/jf6wxs2788/1"
license <- "CC BY-NC 3.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "S037842901930704X.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-10-28"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_sav(file = paste0(thisPath, "STMA 2016_17 File 4_Plot level data yield and mean pve trait scores achive v6.sav"))


# harmonise data ----
#
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
    presence = FALSE,
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
