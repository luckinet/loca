# script arguments ----
#
thisDataset <- "Mishra1995"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1007_BF00189163-citation.ris"))

regDataset(name = thisDataset,
           description = "Experiments were conducted during the winter seasons of 1983–1984 and 1984–1985 to identify suitable irrigation regimes s for wheat grown after rice in soils with naturally fluctuating shallow water table (SWT) at a depth of 0.4 to 0.9 m and medium water table (MWT) at a depth of 0.8 to 1.3 m. Based on physiological stages, the crop was subjected to six irrigation regimes viz., rainfed (I0); irrigation only at crown root initiation (I1); at only crown root initiation and milk (I2); at crown root initiation, maximum tillering and milk (I3); at crown root initiation, maximum tillering, flowering and milk (I4); and at crown root initiation, maximum tillering, flowering milk and dough (I5). Tube-well water with an EC <0.4 dsm−1 was used for irrigation. Based on 166 mm effective precipitation during the cropping season, 1983–1984 was designated as a wet year and 1984–1985 with 51 mm as a dry year. The change in profile soil water content ΔW (depletion) in the wet year was less (23%) under SWT and 10% under MWT as compared to the dry year. The ground water contribution (GWC) to evapotranspiration (ET) was 58% under SWT and 42% under MWT conditions in both the years. The GWC in the wet year was 20% under SWT and 23% under MWT. Of the total net water use (NWU), about 85% was ET and 15% drainage losses. The NWU was highest (641 and 586 mm) in I5 under SWT and MWT conditions, respectively, but not the yield (5069 kg ha−1). Compared to I5, NWU in I2 treatment decreased by 10% in the wet and 25% in the dry year. A similar trend was observed in the I3 treatment under MWT condition. However, there was no statistically significant difference between yields of the I1 to I5 treatments of either water table depth during the wet year. This was also true during the dry year for the I2 to I5 treatments. Under SWT, in I2, the grain yield was 5130 kg ha−1 and under I3 regime, 5200 kg ha−1. Under MWT in I3, the yield was 5188 kg ha−1 and under I4 regime, 5218 kg ha−1. Thus it appears that in the Tarai region where the water table remains shallow (<0.9 m) and medium (<1.3 m) for most of the wheat growing season applications of more than 120 and 180 mm irrigation under SWT and MWT conditions, respectively were not necessary. Irrigation given only at crown root initiation and milk stages under shallow water table conditions, and at crown root initiation, maximum tillering and milk stages under medium water table conditions, appears to be as effective as frequent irrigations.",
           url = "https://link.springer.com/article/10.1007/BF00189163",
           download_date = "2022-01-13",
           type = "static",
           licence = NA_character_,
           contact = NA_character_,
           disclosed = "no",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_delim(paste0(thisPath, "mishra1995.csv"), delim = ";", trim_ws = T)

# harmonise data ----
#
# transform coordinates
chd = substr(data$lat, 3, 3)[1]
chm = substr(data$lat, 6, 6)[1]

temp <- data %>%
  mutate(y = as.numeric(char2dms(paste0(data$lat,'N'), chd = "°")),
         x = as.numeric(char2dms(paste0(data$long,'E'), chd = chd, chm = "'")))

temp <- temp %>%
  mutate(
    fid = row_number(),
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = "India",
    luckinetID = 243,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = commodities,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())

# before preparing data for storage, test that all required variables are available
assertNames(x = names(temp),
            must.include = c("datasetID", "fid", "country", "x", "y", "epsg",
                             "year", "month", "day", "irrigated",
                             "externalID", "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                             "sample_type", "collector", "purpose"))


# write output ----
#
saveDataset(object = temp, dataset = thisDataset)
