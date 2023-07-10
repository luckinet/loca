# script arguments ----
#
thisDataset <- "Knapp2021"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibentry(
  bibtype = "Misc",
  title = "Stanislaus-Tuolumne Experimental Forest ‘Methods of Cutting’ study plots 8-11: 88+ years of forest composition",
  institution = "Forest Service Research Data Archive",
  doi = "https://doi.org/10.2737/RDS-2021-0061",
  year = "2021",
  author = c(
    person(c("Eric E.", "Knapp")),
    person(c("Robert L.", "Carlson"))
  )
)

regDataset(name = thisDataset,
           description = "To study the effects of different logging methods on composition and growth of stands, early U.S. Forest Service scientists, including silviculturist Duncan Dunning, established ‘Methods of Cutting’ (MOC) plots in forest stands of varying composition and productivity throughout California. Four of these plots, all fully or partially on what is now the Stanislaus-Tuolumne Experimental Forest (Stanislaus National Forest), were established in old-growth mixed conifer stands in 1928 and 1929. Each plot was about 10 acres in size. All trees were mapped, and data on species, diameter, and height were taken prior to logging. Patches of shrubs, tree regeneration, and downed logs were mapped on at least some plots in the initial surveys. In combination, these data provide a measure of the composition of such forests at the time. Data from MOC plots, including MOC plots 8-11 on the Stanislaus National Forest, were used in numerous early publications, including yield, stand, and volume tables. Tree data were collected again in 1934 and 1939 and then plots were abandoned when research priorities changed. The MOC plots 8-11 were re-discovered in 2005. The plot infrastructure remained nearly intact, and many numbered tree tags were still in place. Data from surveys and remeasurements taken in the 1920’s and 1930’s were found in the National Archives in San Bruno, CA. Trees were remapped and some of the original variables remeasured once again between 2007 and 2016 to address new questions about forest change, downed log and snag change, and fire-forest structure interactions over time. These four MOC plots are among the oldest mostly intact forest research plots known to exist in California. The geodatabase included in this data publication contains the location and data from trees measured in the 1928-1929, 1934, 1939 and the 2007-2016 surveys of MOC plots 8, 9, 10 and 11.",
           url = "https://doi.org/10.2737/RDS-2021-0061",
           download_date = "2022-01-22",
           type = "static",
           licence = NA_character_,
           contact = NA_character_,
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- bind_rows(read_csv(paste0(thisPath, "RDS-2021-0061/Data/STEF_MOCPlots_8_9_10_11_Trees_2007_2016.csv")),
                           read_csv(paste0(thisPath, "RDS-2021-0061/Data/STEF_MOCPlots_8_9_10_11_Trees_1928-1939.csv")))


# harmonise data ----
#


temp <- data %>%
  drop_na(X_UTM, Y_UTM) %>%
  distinct(X_UTM, Y_UTM, Measurement_Yr, .keep_all = TRUE) %>%
  st_as_sf(., coords = c("X_UTM", "Y_UTM"), crs =  st_crs("EPSG:32610")) %>%
  st_transform(.,crs = "EPSG:4326") %>%
  mutate(
    fid = row_number(),
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2],
    date = ymd(paste0(Measurement_Yr, "-01-01")),
    datasetID = thisDataset,
    country = "USA",
    irrigated = F,
    externalID = NA_character_,
    externalValue = "Naturally regenerating forest",
    presence = F,
    type = "point",
    area = NA_real_,
    geometry = geometry,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
