# livestock ----
qs_animals_products_20231026_txt <-
  read_delim("00_data/04_census_data/adb_tables/stage1/usda/qs.animals_products_20231026.txt.gz",
             delim = "\t", escape_double = FALSE,
             trim_ws = TRUE)

test <- qs_animals_products_20231026_txt %>%
  filter(GROUP_DESC == "LIVESTOCK") %>%
  filter(COMMODITY_DESC == "SHEEP") %>%
  filter(UNIT_DESC == "HEAD") %>%
  filter(AGG_LEVEL_DESC == "STATE") %>%
  filter(STATISTICCAT_DESC != 'SALES' & STATISTICCAT_DESC != "SALES FOR SLAUGHTER" & STATISTICCAT_DESC != "LOSS, DEATH" &
           STATISTICCAT_DESC != "SALES IN CONVENTIONAL MARKETS" & STATISTICCAT_DESC != "SALES IN ORGANIC MARKETS" &
           STATISTICCAT_DESC != "SLAUGHTERED" & STATISTICCAT_DESC != "CAPACITY" & STATISTICCAT_DESC != "FARM USE") %>%
  filter(CLASS_DESC == "INCL LAMBS") %>%
  filter(REFERENCE_PERIOD_DESC == "FIRST OF JAN")


unique(test$GROUP_DESC)
unique(test$COMMODITY_DESC)
unique(test$UNIT_DESC)
unique(test$AGG_LEVEL_DESC)
unique(test$STATISTICCAT_DESC)
unique(test$CLASS_DESC)
unique(test$PRODN_PRACTICE_DESC)
unique(test$YEAR)
unique(test$REFERENCE_PERIOD_DESC)
unique(test$STATE_NAME)
unique(test$DOMAIN_DESC)
unique(test$REGION_DESC)

View(test)

# crops ----




# Converting US units:
# https://grains.org/markets-tools-data/tools/converting-grain-units/
# https://www.extension.iastate.edu/agdm/wholefarm/html/c6-80.html
# https://www.foodbankcny.org/assets/Documents/Fruit-conversion-chart.pdf
# https://www.agric.gov.ab.ca/app19/calc/crop/bushel2tonne.jsp




# Extracting crops data ----
dataPath_crops_survey <- (paste0(inputDir, "qs.crops_20220129.txt/qs.crops_20220129.txt"))
#crops_survey_data <- readLines(dataPath_crops_survey)
crops_survey_data <- read.delim(dataPath_crops_survey, header = TRUE, sep = "\t", dec = ".")

unique(crops_survey_data$YEAR) # need tp filter values from 1900

# 1. I remove data from before 1900.
crops_survey_data <- crops_survey_data[(crops_survey_data$YEAR > 1899),]

# Before proceeding I need to separate Census from Survey data!!

crops_census <- crops_survey_data[(crops_survey_data$SOURCE_DESC == "CENSUS"),]

crops_survey <- crops_survey_data[(crops_survey_data$SOURCE_DESC == "SURVEY"),]

# Survey crop data ----
# I to make the data only on level 2, because some of the values for some regions
# are combined and there is no way I can related to a geometry in this way.
# Only Survey data need to be filtered by STATE

# crops_census_l2 <- crops_census[(crops_census$AGG_LEVEL_DESC == "STATE"),]

crops_survey_l2 <- crops_survey[(crops_survey$AGG_LEVEL_DESC == "STATE"),]

# With Survey data I can proceed
# Now I will explore the data and see how to proceed with the subset:

unique(crops_survey_l2$GROUP_DESC)

crops_survey_l2_CROPSTOTAL <- crops_survey_l2[(crops_survey_l2$GROUP_DESC == "CROP TOTALS"),]

unique(crops_survey_l2_CROPSTOTAL$COMMODITY_DESC)

# Conclusion is that CROP TOTAL does not have what we need.
# Proceeding with the next GROUP_DESC:

crops_survey_l2_FIELD <- crops_survey_l2[(crops_survey_l2$GROUP_DESC == "FIELD CROPS") ,]

# I need to understand whether commodity FIELD CROP TOTALS contains total number for all the other
# write.csv(crops_survey_l2_FIELD, file = (paste0(outputDir, "FIELD_crops_to check.csv")))

# FIELD CROPS TOTAL include total numbers, but also value for potatoes - I think they need to be excluded for now.
# I need to be careful with CLASS_DESC collumn - right after the commodities:
# some commodities have many subcategories and also total number in the same table!!

# 2. Now I remove FIELD_CROPS_TOTAL_ and also make one file, with just field crops for later.
# FIeld CORPS TOTAL includes also potatoes for some reason
crops_field_crops <- crops_survey_l2_FIELD[(crops_survey_l2_FIELD$COMMODITY_DESC == "FIELD CROP TOTALS"),]
write.csv(crops_field_crops, file = (paste0(outputDir, "FIELD_CROPS_TOTAL_ONLY.csv")))

crops_survey_l2_FIELD_no_totals <- crops_survey_l2_FIELD[(crops_survey_l2_FIELD$COMMODITY_DESC != "FIELD CROP TOTALS"),]


unique(crops_survey_l2_FIELD_no_totals$COMMODITY_DESC)
unique(crops_survey_l2_FIELD_no_totals$UNIT_DESC) # -> I need to think about which units to extract: maybe it matters more in some other fields..

unique(crops_survey_l2_FIELD_no_totals$STATISTICCAT_DESC)

# Now extracting production practices - ALL, and then again with STATISTICCAT_DESC -

crops_survey_l2_FIELD_prod <- crops_survey_l2_FIELD_no_totals[(crops_survey_l2_FIELD_no_totals$PRODN_PRACTICE_DESC == "ALL PRODUCTION PRACTICES"),]
unique(crops_survey_l2_FIELD_prod$STATISTICCAT_DESC)

# Now I extract only harvested, planted, yield and production related values.
crops_survey_l2_FIELD_prod_area <- crops_survey_l2_FIELD_prod[((crops_survey_l2_FIELD_prod$STATISTICCAT_DESC == "AREA HARVESTED") | (crops_survey_l2_FIELD_prod$STATISTICCAT_DESC == "AREA PLANTED, NET") | (crops_survey_l2_FIELD_prod$STATISTICCAT_DESC == "AREA PLANTED") | (crops_survey_l2_FIELD_prod$STATISTICCAT_DESC == "PRODUCTION") | (crops_survey_l2_FIELD_prod$STATISTICCAT_DESC == "YIELD")),]

unique(crops_survey_l2_FIELD_prod_area$REFERENCE_PERIOD_DESC)

# before extracting only the year values, I will check what if the values sum up

# write.csv(crops_survey_l2_FIELD_prod_area, file = (paste0(outputDir, "FIELD_CROPS_YEAR_TO_CHECK.csv")))
# Conclusion is, that I need only YEAR

# Now I extract values only for REFERENCE.. = YEAR

crops_survey_l2_FIELD_prod_area_year <- crops_survey_l2_FIELD_prod_area[(crops_survey_l2_FIELD_prod_area$REFERENCE_PERIOD_DESC == "YEAR"),]

unique(crops_survey_l2_FIELD_prod_area_year$DOMAIN_DESC)

# I will extract only corn to understand what is the difference in DOMAIN_DESC

#crops_survey_l2_FIELD_prod_area_year_corn <- crops_survey_l2_FIELD_prod_area_year[(crops_survey_l2_FIELD_prod_area_year$COMMODITY_DESC == "CORN"),]

#write.csv(crops_survey_l2_FIELD_prod_area_year_corn, file = (paste0(filePaths, "corn_to data_explore.csv")))

# From exploring the file it seems to me that only numbers for DOMAIN_DESC == TOTAL are relevant:

crops_survey_l2_FIELD_prod_area_year_TOTAL <- crops_survey_l2_FIELD_prod_area_year[(crops_survey_l2_FIELD_prod_area_year$DOMAIN_DESC == "TOTAL"),]

unique(crops_survey_l2_FIELD_prod_area_year_TOTAL$UNIT_DESC)

# Before removing: GALLONS, GALLONS/TAP, I need to check what they are refering to.
# 480 LB bales are used only for cotton -> thus need to extract only cotton!

crops_480_LB <- crops_survey_l2_FIELD_prod_area_year_TOTAL[(crops_survey_l2_FIELD_prod_area_year_TOTAL$UNIT_DESC == "480 LB BALES"),]

unique(crops_480_LB$COMMODITY_DESC)
unique(crops_480_LB$UNIT_DESC)

unique(crops_survey_l2_FIELD_prod_area_year_TOTAL$UNIT_DESC)

crops_cotton <- crops_survey_l2_FIELD_prod_area_year_TOTAL[
  ((crops_survey_l2_FIELD_prod_area_year_TOTAL$COMMODITY_DESC == "COTTON") &
   (crops_survey_l2_FIELD_prod_area_year_TOTAL$UNIT_DESC != "LB / NET PLANTED ACRE") &
     (crops_survey_l2_FIELD_prod_area_year_TOTAL$UNIT_DESC != "$")
   ),]

unique(crops_cotton$UNIT_DESC)

crops_cotton_01 <- crops_cotton [(
  crops_cotton$CLASS_DESC != "COTTONSEED"
),]

crops_cotton_02 <- crops_cotton [(
  crops_cotton$CLASS_DESC == "COTTONSEED"
),]

write.csv(crops_cotton_01, file = (paste0(outputDir, "usda_cotton_survey_l2.csv")))
write.csv(crops_cotton_02, file = (paste0(outputDir, "usda_cottonSeed_survey_l2.csv")))


# Removing cotton from the general data to continue exploring the units

crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON <- crops_survey_l2_FIELD_prod_area_year_TOTAL[(crops_survey_l2_FIELD_prod_area_year_TOTAL$COMMODITY_DESC != "COTTON"),]

unique(crops_survey_l2_FIELD_prod_area_year_TOTAL$UNIT_DESC)
unique(crops_survey_l2_FIELD_prod_area_year_TOTAL$STATISTICCAT_DESC)

# Removing $ unit from the data frame:
crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR <- crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON[(crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON$UNIT_DESC != "$"),]

# Exploring BU unit - subset for Barley
# BU is a unit for production for certain crops!!
# Therefore, I will extract BU in one table for the crops! And need to check bu/acre and bu/planted net
# I do not understand the difference between NET planted area and Planted area

crops_BU <- crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR[(crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$UNIT_DESC == "BU"),]

unique(crops_BU$COMMODITY_DESC)

# from exploring the crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR data:
# Beans and Rice , and some other crops need to be extracted separately together: they use LB and CWT for units:

crops_field_crops_LB <- crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR[(
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "BEANS") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "RICE") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "SUNFLOWER") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "CANOLA") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "CHICKPEAS") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "HOPS") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "LENTILS") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "LEGUMES") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "MUSTARD") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "PEANUTS") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "MINT") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "PEAS") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "SAFFLOWER") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "TARO") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "TOBACCO")
    ),]

unique(crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC)

crops_field_crops_LB_01 <- crops_field_crops_LB [(
  (crops_field_crops_LB$UNIT_DESC != "LB / NET PLANTED ACRE") &
    (crops_field_crops_LB$UNIT_DESC != "CWT")
),]

crops_field_crops_LB_02 <- crops_field_crops_LB [(
  crops_field_crops_LB$UNIT_DESC == "CWT"
),]

write.csv(crops_field_crops_LB_01, file = (paste0(outputDir, "usda_field_crops_LB_survey_l2.csv")))
write.csv(crops_field_crops_LB_02, file = (paste0(outputDir, "usda_field_crops_CWT_survey_l2.csv")))

crops_BU_crops <- crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR[
  ((crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "BARLEY") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "OATS") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "SOYBEANS") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "WHEAT") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "CORN") |
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "SORGHUM") |
    (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "FLAXSEED") |
    (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "MILLET") |
    (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "RYE")
  ),]

crops_BU_crops01 <- crops_BU_crops[(crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "BARLEY"),]

write.csv(crops_BU_crops01, file = (paste0(outputDir, "usda_field_crops_BU_barley_survey_l2.csv")))

crops_BU_crops02 <- crops_BU_crops[((crops_BU_crops$COMMODITY_DESC == "OATS") &
                                     (crops_BU_crops$UNIT_DESC !=  "BU / NET PLANTED ACRE")),]

write.csv(crops_BU_crops02, file = (paste0(outputDir, "usda_field_crops_BU_oats_survey_l2.csv")))

crops_BU_crops03 <- crops_BU_crops[(
  (crops_BU_crops$COMMODITY_DESC == "SOYBEANS") |
    (crops_BU_crops$COMMODITY_DESC == "WHEAT")
),]

crops_BU_crops03_00 <- crops_BU_crops03[(
  (crops_BU_crops03$UNIT_DESC =="ACRES") |
    (crops_BU_crops03$UNIT_DESC == "BU") |
    (crops_BU_crops03$UNIT_DESC == "BU / ACRE")
),]

write.csv(crops_BU_crops03_00, file = (paste0(outputDir, "usda_field_crops_BU_soyWheat_survey_l2.csv")))

crops_BU_crops04 <- crops_BU_crops[(
  (crops_BU_crops$COMMODITY_DESC == "CORN") |
    (crops_BU_crops$COMMODITY_DESC == "SORGHUM") ),]

crops_BU_crops05 <- crops_BU_crops04[(
    (crops_BU_crops04$UNIT_DESC != "TONS") &
    (crops_BU_crops04$UNIT_DESC != "TONS / ACRE") &
      (crops_BU_crops04$UNIT_DESC !=  "BU / NET PLANTED ACRE")
),]

write.csv(crops_BU_crops05, file = (paste0(outputDir, "usda_field_crops_BU_cornSorg_survey_l2.csv")))

crops_BU_crops05 <- crops_BU_crops[(
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "FLAXSEED") |
    (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "RYE")
),]

write.csv(crops_BU_crops05, file = (paste0(outputDir, "usda_field_crops_BU_ryeFlax_survey_l2.csv")))

crops_BU_crops06 <- crops_BU_crops[(crops_BU_crops$COMMODITY_DESC == "MILLET"),]

write.csv(crops_BU_crops06, file = (paste0(outputDir, "usda_field_crops_BU_millet_survey_l2.csv")))

crops_tons <- crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR[(
  (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "HAY & HAYLAGE") |
    (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "HAY") |
    (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "HAYLAGE") |
    (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "SUGARBEETS") |
    (crops_survey_l2_FIELD_prod_area_year_TOTAL_noCOTTON_noDOLLAR$COMMODITY_DESC == "SUGARCANE")
),]

write.csv(crops_tons, file = (paste0(outputDir, "usda_field_crops_tons_survey_l2.csv")))

## Going back to GROUP_DESC:Vegetables ----

crops_survey_l2_veg <- crops_survey_l2[(crops_survey_l2$GROUP_DESC == "VEGETABLES") ,]

unique(crops_survey_l2_veg$COMMODITY_DESC) # all commodities

unique(crops_survey_l2_veg$PRODN_PRACTICE_DESC) # only all production practices
# Filtering the vegetbales:
crops_survey_l2_veg_prac <- crops_survey_l2_veg[
  (crops_survey_l2_veg$PRODN_PRACTICE_DESC == "ALL PRODUCTION PRACTICES"),]

unique(crops_survey_l2_veg_prac$STATISTICCAT_DESC) # only harv, prod, plant, yield
# Filtering area harv, plan, yield, prod

crops_survey_l2_veg_prac_area <- crops_survey_l2_veg_prac[(
  (crops_survey_l2_veg_prac$STATISTICCAT_DESC == "AREA HARVESTED") |
  (crops_survey_l2_veg_prac$STATISTICCAT_DESC == "AREA PLANTED") |
  (crops_survey_l2_veg_prac$STATISTICCAT_DESC == "YIELD") |
  (crops_survey_l2_veg_prac$STATISTICCAT_DESC == "PRODUCTION")
),]

unique(crops_survey_l2_veg_prac_area$UNIT_DESC) # need to remove $, CWT net planted area, PCT, tons/net, hills/acre, pct by grde
# Filtering out the units

crops_survey_l2_veg_prac_area_unit <- crops_survey_l2_veg_prac_area[(
  (crops_survey_l2_veg_prac_area$UNIT_DESC == "ACRES") |
  (crops_survey_l2_veg_prac_area$UNIT_DESC == "CWT / ACRE") |
  (crops_survey_l2_veg_prac_area$UNIT_DESC == "LB / ACRE") |
  (crops_survey_l2_veg_prac_area$UNIT_DESC == "LB") |
  (crops_survey_l2_veg_prac_area$UNIT_DESC == "CWT") |
  (crops_survey_l2_veg_prac_area$UNIT_DESC == "TONS") |
  (crops_survey_l2_veg_prac_area$UNIT_DESC == "TONS / ACRE")
  ),]

unique(crops_survey_l2_veg_prac_area_unit$FREQ_DESC) # I need only annual
# FIltering out the annual values:

crops_survey_l2_veg_prac_area_unit_year <- crops_survey_l2_veg_prac_area_unit[(
  (crops_survey_l2_veg_prac_area_unit$FREQ_DESC == "ANNUAL")
),]

# Checking if the final file is good to go:

write.csv(crops_survey_l2_veg_prac_area_unit_year, file = (paste0(outputDir, "usda_vegetables_l2.csv")))

# Now I need to subset specific commodities, because of different units:

crops_veg_LB <- crops_survey_l2_veg_prac_area_unit_year[(
  (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "GINGER ROOT")
),]

write.csv(crops_veg_LB, file = (paste0(outputDir, "usda_vegetables_gignger_root_l2.csv")))

crops_veg_tons <- crops_survey_l2_veg_prac_area_unit_year[(
  (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "ARTICHOKES") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "ASPARAGUS") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "BEANS") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "BEETS") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "BROCCOLI") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "CABBAGE") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "CARROTS") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "CAULIFLOWER") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "CELERY") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "CUCUMBERS") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "GARLIC") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "LETTUCE") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "MELONS") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "ONIONS") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "PEAS") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "PEPPERS") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "PUMPKINS") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "SPINACH") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "SQUASH") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "SWEET CORN") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "SWEET POTATOES")
),]

crops_veg_tons_01 <- crops_veg_tons [(
  (crops_veg_tons$UNIT_DESC != "CWT") &
    (crops_veg_tons$UNIT_DESC != "CWT / ACRE")
),]

write.csv(crops_veg_tons_01, file = (paste0(outputDir, "usda_vegetables_tons_l2.csv")))

crops_veg_cwt <- crops_survey_l2_veg_prac_area_unit_year[(
  (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "BRUSSELS SPROUTS") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "EGGPLANT") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "ESCAROLE & ENDIVE") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "GREENS") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "OKRA") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "POTATOES") |
    (crops_survey_l2_veg_prac_area_unit_year$COMMODITY_DESC == "RADISHES")
),]

write.csv(crops_veg_cwt, file = (paste0(outputDir, "usda_vegetables_cwt_l2.csv")))

## Extrcating fruits and tree nuts! ----

unique(crops_survey_l2$GROUP_DESC)

crops_fruits <- crops_survey_l2[(crops_survey_l2$GROUP_DESC == "FRUIT & TREE NUTS"),]

unique(crops_fruits$COMMODITY_DESC) # removing Totals

crops_fruits_noTot <- crops_fruits[(
  (crops_fruits$COMMODITY_DESC != "NON-CITRUS FRUIT & TREE NUTS TOTALS") &
    (crops_fruits$COMMODITY_DESC != "CITRUS TOTALS") &
    (crops_fruits$COMMODITY_DESC != "FRUIT & TREE NUT TOTALS")
),]

unique(crops_fruits_noTot$STATISTICCAT_DESC) # need to extract areas
# Filtering area, yield, production

crops_fruits_noTot_area <- crops_fruits_noTot[(
  (crops_fruits_noTot$STATISTICCAT_DESC == "AREA HARVESTED") |
    (crops_fruits_noTot$STATISTICCAT_DESC == "AREA PLANTED") |
    (crops_fruits_noTot$STATISTICCAT_DESC == "YIELD") |
    (crops_fruits_noTot$STATISTICCAT_DESC == "PRODUCTION") |
    (crops_fruits_noTot$STATISTICCAT_DESC == "AREA BEARING")
),]

unique(crops_fruits_noTot_area$UNIT_DESC)
# Filtering units

crops_fruits_noTot_area_unit <- crops_fruits_noTot_area[(
  (crops_fruits_noTot_area$UNIT_DESC == "ACRES") |
    (crops_fruits_noTot_area$UNIT_DESC == "CWT / ACRE") |
    (crops_fruits_noTot_area$UNIT_DESC == "LB") |
    (crops_fruits_noTot_area$UNIT_DESC == "BU / ACRE") |
    (crops_fruits_noTot_area$UNIT_DESC == "TONS") |
    (crops_fruits_noTot_area$UNIT_DESC == "LB / ACRE") |
    (crops_fruits_noTot_area$UNIT_DESC == "TONS / ACRE") |
    (crops_fruits_noTot_area$UNIT_DESC == "CWT")
),]
# Filtering out only annual values:

crops_fruits_noTot_area_unit_year <- crops_fruits_noTot_area_unit[(
  crops_fruits_noTot_area_unit$REFERENCE_PERIOD_DESC == "YEAR"
),]

# Checking the result to see hwo to subset the data:
write.csv(crops_fruits_noTot_area_unit_year, file = (paste0(outputDir, "usda_friut_to_check_l2.csv")))

crops_apples <- crops_fruits_noTot_area_unit_year[(
  (crops_fruits_noTot_area_unit_year$COMMODITY_DESC == "APPLES") &
    (crops_fruits_noTot_area_unit_year$UNIT_DESC == "BU / ACRE")
),]
write.csv(crops_apples, file = (paste0(outputDir, "usda_apples_yield_BU_l2.csv")))

crops_peaches <- crops_fruits_noTot_area_unit_year[(
  (crops_fruits_noTot_area_unit_year$COMMODITY_DESC == "PEACHES") &
    (crops_fruits_noTot_area_unit_year$UNIT_DESC == "BU / ACRE")
),]
write.csv(crops_peaches, file = (paste0(outputDir, "usda_peaches_yield_BU_l2.csv")))

crops_strawberried <- crops_fruits_noTot_area_unit_year[
  (crops_fruits_noTot_area_unit_year$COMMODITY_DESC == "STRAWBERRIES"),]

crops_strawberried_01 <- crops_strawberried [(
  (crops_strawberried$UNIT_DESC == "CWT") |
    (crops_strawberried$UNIT_DESC == "CWT / ACRE")
),]

crops_strawberried_02 <- crops_strawberried [(
  (crops_strawberried$UNIT_DESC == "TONS") |
    (crops_strawberried$UNIT_DESC == "TONS / ACRE") |
    (crops_strawberried$UNIT_DESC == "ACRES")
),]

write.csv(crops_strawberried_01, file = (paste0(outputDir, "usda_strawbery_CWT_l2.csv")))
write.csv(crops_strawberried_02, file = (paste0(outputDir, "usda_strawbery_TONS_l2.csv")))

crops_apples_all <- crops_fruits_noTot_area_unit_year[(
  (crops_fruits_noTot_area_unit_year$COMMODITY_DESC == "APPLES") &
  (crops_fruits_noTot_area_unit_year$UNIT_DESC != "BU / ACRE")
  ),]

write.csv(crops_apples_all, file = (paste0(outputDir, "usda_apples_allother_l2.csv")))

crops_peaches_all <- crops_fruits_noTot_area_unit_year[(
  (crops_fruits_noTot_area_unit_year$COMMODITY_DESC == "PEACHES") &
    (crops_fruits_noTot_area_unit_year$UNIT_DESC != "BU / ACRE") &
    (crops_fruits_noTot_area_unit_year$UNIT_DESC != "LB")
  ),]

crops_peaches_all_02 <- crops_fruits_noTot_area_unit_year[(
  (crops_fruits_noTot_area_unit_year$COMMODITY_DESC == "PEACHES") &
    (crops_fruits_noTot_area_unit_year$UNIT_DESC == "LB")
),]

write.csv(crops_peaches_all_02, file = (paste0(outputDir, "usda_peaches_LB_l2.csv")))

write.csv(crops_peaches_all, file = (paste0(outputDir, "usda_peaches_allother_l2.csv")))


crops_noApple_noPeach_noStraw <- crops_fruits_noTot_area_unit_year[((
  crops_fruits_noTot_area_unit_year$COMMODITY_DESC != "PEACHES") &
    (crops_fruits_noTot_area_unit_year$COMMODITY_DESC != "APPLES") &
    (crops_fruits_noTot_area_unit_year$COMMODITY_DESC != "STRAWBERRIES")),]

write.csv(crops_noApple_noPeach_noStraw, file = (paste0(outputDir, "usda_friut_to_check_l2.csv")))


crops_fruits_tons <- crops_noApple_noPeach_noStraw[(
  (crops_noApple_noPeach_noStraw$UNIT_DESC == "TONS") |
    (crops_noApple_noPeach_noStraw$UNIT_DESC == "TONS / ACRE")
),]

write.csv(crops_fruits_tons, file = (paste0(outputDir, "usda_fruits_tons_survey.csv")))


crops_fruits_LB_acres <- crops_noApple_noPeach_noStraw[(
  (crops_noApple_noPeach_noStraw$UNIT_DESC == "ACRES") |
    (crops_noApple_noPeach_noStraw$UNIT_DESC == "LB / ACRE") |
    (crops_noApple_noPeach_noStraw$UNIT_DESC == "LB")
),]

crops_fruits_LB_acres_coffee <- crops_fruits_LB_acres[(
  crops_fruits_LB_acres$COMMODITY_DESC == "COFFEE"
),]

crops_fruits_LB_acres_noCoffee <- crops_fruits_LB_acres[(
  crops_fruits_LB_acres$COMMODITY_DESC != "COFFEE"
),]

write.csv(crops_fruits_LB_acres_noCoffee, file = (paste0(outputDir, "usda_fruits_acres_LB_survey.csv")))
write.csv(crops_fruits_LB_acres_coffee, file = (paste0(outputDir, "usda_coffee_LB_survey.csv")))


## Extracting Horticulture ----

unique(crops_survey_l2$GROUP_DESC)

crops_horti <- crops_survey_l2[(crops_survey_l2$GROUP_DESC == "HORTICULTURE"),]

# Exploring the commodities:
unique(crops_horti$COMMODITY_DESC)

# Exploring the units:
unique(crops_horti$UNIT_DESC)

# Exploring the area:
unique(crops_horti$STATISTICCAT_DESC)

# Filtering out areas to explore further the data set:
crops_horti_area <- crops_horti [(
  (crops_horti$STATISTICCAT_DESC == "PRODUCTION") |
    (crops_horti$STATISTICCAT_DESC == "AREA IN PRODUCTION") |
    (crops_horti$STATISTICCAT_DESC == "YIELD") |
    (crops_horti$STATISTICCAT_DESC == "AREA FILLED")
),]

unique(crops_horti_area$COMMODITY_DESC)

unique(crops_horti_area$UNIT_DESC)

unique(crops_horti_area$REFERENCE_PERIOD_DESC)

# Commodity and units are okei, I need to filter out the reference period:
crops_horti_area_year <- crops_horti_area[(
  crops_horti_area$REFERENCE_PERIOD_DESC == "YEAR"
),]

crops_horti_area_year_01 <- crops_horti_area_year [(
  crops_horti_area_year$COMMODITY_DESC != "FLORICULTURE TOTALS"
),]

# Writing horticulture:
write.csv(crops_horti_area_year_01, file = (paste0(outputDir, "usda_horticulture_survey.csv")))


# Extracting level 3 values for survey ----

unique(crops_survey$AGG_LEVEL_DESC)

crops_survey_County <- crops_survey[(crops_survey$AGG_LEVEL_DESC == "COUNTY"),]

unique(crops_survey_County$STATISTICCAT_DESC)

crops_survey_County_area_bearing <- crops_survey_County[
  (crops_survey_County$STATISTICCAT_DESC == "AREA BEARING"),]
unique(crops_survey_County_area_bearing$COMMODITY_DESC)
unique(crops_survey_County_area_bearing$UNIT_DESC)


crops_survey_County_AREA <- crops_survey_County[(
  (crops_survey_County$STATISTICCAT_DESC == "AREA HARVESTED") |
    (crops_survey_County$STATISTICCAT_DESC == "AREA PLANTED") |
    (crops_survey_County$STATISTICCAT_DESC == "PRODUCTION" ) |
    (crops_survey_County$STATISTICCAT_DESC == "YIELD")
),]

unique(crops_survey_County_AREA$COMMODITY_DESC)
unique(crops_survey_County_AREA$PRODN_PRACTICE_DESC)
unique(crops_survey_County_AREA$UTIL_PRACTICE_DESC)


crops_survey_state_corn <- crops_survey_County_AREA[
  ((crops_survey_County_AREA$COMMODITY_DESC == "CORN") &
  (crops_survey_County_AREA$YEAR == "2005")),]
write.csv(crops_survey_state_corn, file = (paste0(outputDir, "usda_corn_test_l3.csv")))

# From exploring the test file, I need to extract prod practices = ALL
# Not sure about the UTIL -> because for corn, all practices are only for area
# planted, grain and sillage, are for all the others.

crops_survey_County_AREA_Prod <- crops_survey_County_AREA[
  (crops_survey_County_AREA$PRODN_PRACTICE_DESC == "ALL PRODUCTION PRACTICES"),]

unique(crops_survey_County_AREA_Prod$UTIL_PRACTICE_DESC)
unique(crops_survey_County_AREA_Prod$UNIT_DESC)

crops_survey_County_AREA_Prod_reduced <- crops_survey_County_AREA_Prod[(
  (crops_survey_County_AREA_Prod$UNIT_DESC != "BU / NET PLANTED ACRE") &
    (crops_survey_County_AREA_Prod$UNIT_DESC != "LB / NET PLANTED ACRE") &
    (crops_survey_County_AREA_Prod$UNIT_DESC != "RUNNING BALES") &
    (crops_survey_County_AREA_Prod$UNIT_DESC != "TONS / NET PLANTED ACRE") &
    (crops_survey_County_AREA_Prod$UNIT_DESC != "CWT / NET PLANTED ACRE")
),]

unique(crops_survey_County_AREA_Prod_reduced$UNIT_DESC)

# Removing some of the units: bu / net planted acres, LB/ NET planted acre, running bales, tons/net planted acre,  "CWT / NET PLANTED ACRE",
# bu/planted acre (possibily remove it)
crops_survey_County_AREA_Prod_reduced <- crops_survey_County_AREA_Prod[(
  (crops_survey_County_AREA_Prod$UNIT_DESC != "BU / NET PLANTED ACRE") &
    (crops_survey_County_AREA_Prod$UNIT_DESC != "LB / NET PLANTED ACRE") &
    (crops_survey_County_AREA_Prod$UNIT_DESC != "RUNNING BALES") &
    (crops_survey_County_AREA_Prod$UNIT_DESC != "TONS / NET PLANTED ACRE") &
    (crops_survey_County_AREA_Prod$UNIT_DESC != "CWT / NET PLANTED ACRE") &
    (crops_survey_County_AREA_Prod$UNIT_DESC != "BU / PLANTED ACRE")
),]

unique(crops_survey_County_AREA_Prod_reduced$UNIT_DESC)

# checking what commodities are with BU/planted acre:
crops_survey_BU_planted <- crops_survey_County_AREA_Prod[(
  crops_survey_County_AREA_Prod$UNIT_DESC == "BU / PLANTED ACRE"
),]


# Lets try by commodity:
# commodities with BU and BU/ACRE: barley, flaxseed, oats, rye, soybeeans, wheat (has bu/planted acre..),
# commodities with CWT and LB/acre: beans(need to remove tons, tons/acre), lentils, rice, chickpeas.
# commodities with LB and LB/acre: canola, mustard, peanuts, safflower, sunflower, tobacco,
# commodities with tons and tons/acre : HAY & HAYLAGE (per dry mass), Hay, sugarbeets, sweet corn, sugarcane
# commodities with CWT and CWT/acre: potatoes, sweet potatoes, peppers,

# commodities that need to be alone: cotton
# commodities that need are weird: peas -> TONS + TONS/ACRE need to MINNESOTA, OHIO, OREGON, WASHINGTON, WISCONSIN,
#                                           CWT are need to be MONTANA, NORTH DAKOTA,
# commoditues that need to be alone: apples (only production and yield)
# commodities that need to be alone: peaches (tons and LB both are need, because they are for different years)
# commodities that need to be alone: corn and surghum( has BU and TONS I am guessing for different states...)
# commodities that need to be alone: pecans ( need to add area bearing)
# commodities that need to be alone: wheat  -need to keep only all classes!

crops_survey_County_AREA_Prod_comm <- crops_survey_County_AREA_Prod[
  (crops_survey_County_AREA_Prod$COMMODITY_DESC == "APPLES"),]

unique(crops_survey_County_AREA_Prod_comm$UNIT_DESC)

unique(crops_survey_County_AREA_Prod_comm$STATE_NAME)

### Crops with BU ----
crops_survey_BU_01 <- crops_survey_County_AREA_Prod_reduced[
  (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "BARLEY"),]

crops_survey_BU_02 <- crops_survey_County_AREA_Prod_reduced[(
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "RYE") |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "FLAXSEED")),]

crops_survey_BU_03 <- crops_survey_County_AREA_Prod_reduced[
  (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "SOYBEANS"),]

crops_survey_BU_04 <- crops_survey_County_AREA_Prod_reduced[
  (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "OATS"),]


unique(crops_survey_BU$UNIT_DESC)

write.csv(crops_survey_BU_01, file = (paste0(outputDir, "usda_BU_barley_l3.csv")))
write.csv(crops_survey_BU_02, file = (paste0(outputDir, "usda_BU_ryeFlaxseed_l3.csv")))
write.csv(crops_survey_BU_03, file = (paste0(outputDir, "usda_BU_soybeans_l3.csv")))
write.csv(crops_survey_BU_04, file = (paste0(outputDir, "usda_BU_oats_l3.csv")))


### Crops with CWT ----
crops_survey_CWT <- crops_survey_County_AREA_Prod_reduced[(
  (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "BEANS") |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "LENTILS") |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "RICE") |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "CHICKPEAS")
),]

unique(crops_survey_CWT$UNIT_DESC)
crops_survey_CWT_reduced <- crops_survey_CWT[(
  (crops_survey_CWT$UNIT_DESC != "TONS") &
    (crops_survey_CWT$UNIT_DESC != "TONS / ACRE")
),]

unique(crops_survey_CWT_reduced$UNIT_DESC)
write.csv(crops_survey_CWT_reduced, file = (paste0(outputDir, "usda_CWT_crops_l3.csv")))


### Crops with LB ----
# commodities with LB and LB/acre: canola, mustard, peanuts, safflower, sunflower, tobacco,
crops_survey_LB <- crops_survey_County_AREA_Prod_reduced[(
  (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "CANOLA") |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "MUSTARD") |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "PEANUTS") |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "SAFFLOWER") |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "SUNFLOWER") |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "TOBACCO")
),]
# removing oil and non-oil type from sunflower cathegory
crops_survey_LB_01 <- crops_survey_LB[(
  (crops_survey_LB$CLASS_DESC != "NON-OIL TYPE") &
    (crops_survey_LB$CLASS_DESC != "OIL TYPE")
),]

write.csv(crops_survey_LB_01, file = (paste0(outputDir, "usda_LB_crops_l3.csv")))

### Crops with tons
# commodities with tons and tons/acre : HAY & HAYLAGE (per dry mass), Hay, sugarbeets, sweet corn, sugarcane
crops_survey_tons <- crops_survey_County_AREA_Prod_reduced[(
  (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "HAY & HAYLAGE") |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "HAY") |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "SUGARBEETS") |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "SWEET CORN") |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "SUGARCANE") &
    (crops_survey_County_AREA_Prod_reduced$CLASS_DESC == "ALL CLASSES")
),]
crops_survey_tons_01 <- crops_survey_tons[(
  crops_survey_tons$CLASS_DESC == "ALL CLASSES"
),]

write.csv(crops_survey_tons_01, file = (paste0(outputDir, "usda_tons_crops_l3.csv")))



### Crops with CTW CTW/acre ----
# commodities with CWT and CWT/acre: potatoes, sweet potatoes, peppers,
crops_survey_CWT_acre <- crops_survey_County_AREA_Prod_reduced[(
  (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "POTATOES") |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "SWEET POTATOES") |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "PEPPERS")
),]
write.csv(crops_survey_CWT_acre, file = (paste0(outputDir, "usda_CWT_acre_crops_l3.csv")))

### Cotton ----
# commodities that need to be alone: cotton
crops_survey_cotton<- crops_survey_County_AREA_Prod_reduced[(
  (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "COTTON")
),]
write.csv(crops_survey_cotton, file = (paste0(outputDir, "usda_cotton_crops_l3.csv")))

### Peas ----
# commodities that need are weird: peas -> TONS + TONS/ACRE need to MINNESOTA, OHIO, OREGON, WASHINGTON, WISCONSIN,
#                                           CWT are need to be MONTANA, NORTH DAKOTA,
crops_survey_peas <- crops_survey_County_AREA_Prod_reduced[(
  crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "PEAS"
),]

crops_survey_peas_01 <- crops_survey_peas[(
    (crops_survey_peas$STATE_NAME == "MINNESOTA") |
      (crops_survey_peas$STATE_NAME == "OHIO") |
      (crops_survey_peas$STATE_NAME == "OREGON") |
      (crops_survey_peas$STATE_NAME == "WASHINGTON") |
      (crops_survey_peas$STATE_NAME == "WISCONSIN")
  ),]
write.csv(crops_survey_peas_01, file = (paste0(outputDir, "usda_peas_crops_l3_part01.csv")))

unique(crops_survey_peas_01$UNIT_DESC)

crops_survey_peas_02 <- crops_survey_peas[(
  (crops_survey_peas$STATE_NAME == "MONTANA") |
    (crops_survey_peas$STATE_NAME == "NORTH DAKOTA")
),]
write.csv(crops_survey_peas_02, file = (paste0(outputDir, "usda_peas_crops_l3_part02.csv")))
unique(crops_survey_peas_02$UNIT_DESC)

### Apples ----
# commoditues that need to be alone: apples (only production and yield)
crops_survey_apples <- crops_survey_County_AREA_Prod_reduced[(
  crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "APPLES"
),]
write.csv(crops_survey_apples, file = (paste0(outputDir, "usda_apples_crops_l3.csv")))

### Peaches ----
# commodities that need to be alone: peaches (tons and LB both are need, because they are for different years)

crops_survey_peaches <- crops_survey_County_AREA_Prod_reduced[(
  crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "PEACHES"
),]
write.csv(crops_survey_peaches, file = (paste0(outputDir, "usda_peaches_to_CHECK_crops_l3.csv")))

crops_survey_peaches_01 <- crops_survey_peaches[(
  crops_survey_peaches$UNIT_DESC == "TONS"
),]
unique(crops_survey_peaches$STATE_NAME)
write.csv(crops_survey_peaches_01, file = (paste0(outputDir, "usda_peaches_TONS_l3.csv")))

crops_survey_peaches_02 <- crops_survey_peaches[(
  crops_survey_peaches$UNIT_DESC == "LB"
),]
unique(crops_survey_peaches$STATE_NAME)
write.csv(crops_survey_peaches_02, file = (paste0(outputDir, "usda_peaches_LB_l3.csv")))

crops_survey_peaches_03 <- crops_survey_peaches[(
  crops_survey_peaches$UNIT_DESC == "BU / ACRE"
),]
unique(crops_survey_peaches$STATE_NAME)
write.csv(crops_survey_peaches_03, file = (paste0(outputDir, "usda_peaches_BU_ACRE_l3.csv")))

### Corn and sorghum ----
# commodities that need to be alone: corn and surghum( has BU and TONS I am guessing for different states...)

crops_survey_corn_sorghum <- crops_survey_County_AREA_Prod_reduced[(
  (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "CORN" ) |
    (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "SORGHUM")
),]
unique(crops_survey_corn_sorghum$UNIT_DESC)

write.csv(crops_survey_corn_sorghum, file = (paste0(outputDir, "usda_corn_TO_CHECK_l3.csv")))


crops_survey_corn_sorghum_01 <- crops_survey_corn_sorghum[(
  (crops_survey_corn_sorghum$UNIT_DESC == "BU") |
    (crops_survey_corn_sorghum$UNIT_DESC == "BU / ACRE")
),]
unique(crops_survey_corn_sorghum_01$COMMODITY_DESC)
write.csv(crops_survey_corn_sorghum_01, file = (paste0(outputDir, "usda_corn_sorghum_l3_part01.csv")))

crops_survey_corn_sorghum_02 <- crops_survey_corn_sorghum[(
  (crops_survey_corn_sorghum$UNIT_DESC == "TONS") |
    (crops_survey_corn_sorghum$UNIT_DESC == "TONS / ACRE") |
    (crops_survey_corn_sorghum$UNIT_DESC == "ACRES")
),]
unique(crops_survey_corn_sorghum_02$COMMODITY_DESC)
write.csv(crops_survey_corn_sorghum_02, file = (paste0(outputDir, "usda_corn_sorghum_l3_part02.csv")))

### Pecans ----
# commodities that need to be alone: pecans ( need to add area bearing)

crops_survey_pecans <- crops_survey_County[(
  crops_survey_County$COMMODITY_DESC == "PECANS"
),]
unique(crops_survey_pecans$YEAR)

write.csv(crops_survey_pecans, file = (paste0(outputDir, "usda_pecans_l3.csv")))

### Wheat ----
# commodities that need to be alone: wheat  - need to keep only all classes!
crops_survey_wheat <- crops_survey_County_AREA_Prod_reduced[
  (crops_survey_County_AREA_Prod_reduced$COMMODITY_DESC == "WHEAT" ),]
unique(crops_survey_wheat$CLASS_DESC)

crops_survey_wheat_01 <- crops_survey_wheat[(
  crops_survey_wheat$CLASS_DESC == "ALL CLASSES"
),]

write.csv(crops_survey_wheat_01, file = (paste0(outputDir, "usda_wheat_l3.csv")))

### Extracting puerto rico
unique(crops_survey$AGG_LEVEL_DESC)
crops_survey_puerto_rico <- crops_survey[(
  crops_survey$AGG_LEVEL_DESC == "PUERTO RICO & OUTLYING AREAS"
),]
unique(crops_survey_puerto_rico$UNIT_DESC)

crops_survey_puerto_rico_coffee <- crops_survey_puerto_rico[(
(crops_survey_puerto_rico$UNIT_DESC != "$") &
  (crops_survey_puerto_rico$UNIT_DESC != "$ / LB")
),]

write.csv(crops_survey_puerto_rico_coffee, file = (paste0(outputDir, "usda_coffee_puerto_l2.csv")))

# Crops Census data ----
unique(crops_census$GROUP_DESC)
unique(crops_census$AGG_LEVEL_DESC)

crops_census_state <- crops_census[(
  crops_census$AGG_LEVEL_DESC == "STATE" ),]
unique(crops_census_state$GROUP_DESC)
unique(crops_census_state$STATISTICCAT_DESC)

crops_census_state_area <- crops_census_state[(
  (crops_census_state$STATISTICCAT_DESC == "AREA HARVESTED") |
    (crops_census_state$STATISTICCAT_DESC == "PRODUCTION") |
    (crops_census_state$STATISTICCAT_DESC == "YIELD") |
    (crops_census_state$STATISTICCAT_DESC == "AREA BEARING") |
    (crops_census_state$STATISTICCAT_DESC == "AREA")
),]
unique(crops_census_state_area$UNIT_DESC)

### Extractign by TYPE ----
crops_census_state_area_veg <- crops_census_state_area[(
  crops_census_state_area$GROUP_DESC == "VEGETABLES"
),]

unique(crops_census_state_area_veg$COMMODITY_DESC)
unique(crops_census_state_area_veg$UNIT_DESC)

crops_census_state_area_veg_noTOT <- crops_census_state_area_veg [(
  (crops_census_state_area_veg$COMMODITY_DESC != "VEGETABLE TOTALS") &
    (crops_census_state_area_veg$COMMODITY_DESC != "VEGETABLES, OTHER") &
    (crops_census_state_area_veg$UNIT_DESC  != "OPERATIONS")
),]

unique(crops_census_state_area_veg_noTOT$COMMODITY_DESC)
unique(crops_census_state_area_veg_noTOT$UNIT_DESC)
unique(crops_census_state_area_veg_noTOT$STATISTICCAT_DESC)


crops_census_state_area_veg_noTOT_prod <- crops_census_state_area_veg_noTOT[(
  crops_census_state_area_veg_noTOT$STATISTICCAT_DESC == "PRODUCTION"
),]

unique(crops_census_state_area_veg_noTOT_prod$UNIT_DESC)
unique(crops_census_state_area_veg_noTOT_prod$COMMODITY_DESC)

### Production LB ----
crops_census_state_area_veg_noTOT_prod_LB <- crops_census_state_area_veg_noTOT_prod [(
  crops_census_state_area_veg_noTOT_prod$UNIT_DESC == "LB"
),]
unique(crops_census_state_area_veg_noTOT_prod_LB$COMMODITY_DESC)

write.csv(crops_census_state_area_veg_noTOT_prod_LB, file = (paste0(outputDir, "usda_census_LB_prod_l2.csv")))

### Production CWT ----
crops_census_state_area_veg_noTOT_prod_CWT <- crops_census_state_area_veg_noTOT_prod [(
  crops_census_state_area_veg_noTOT_prod$UNIT_DESC == "CWT"
),]
unique(crops_census_state_area_veg_noTOT_prod_CWT$COMMODITY_DESC)

write.csv(crops_census_state_area_veg_noTOT_prod_CWT, file = (paste0(outputDir, "usda_census_CWT_prod_l2.csv")))

### Production Tons ----
crops_census_state_area_veg_noTOT_prod_Tons <- crops_census_state_area_veg_noTOT_prod [(
  crops_census_state_area_veg_noTOT_prod$UNIT_DESC == "TONS"
),]
unique(crops_census_state_area_veg_noTOT_prod_Tons$COMMODITY_DESC)

write.csv(crops_census_state_area_veg_noTOT_prod_Tons, file = (paste0(outputDir, "usda_census_tons_prod_l2.csv")))

### Acres ----
crops_census_state_area_veg_noTOT_acres <- crops_census_state_area_veg_noTOT [(
  crops_census_state_area_veg_noTOT$UNIT_DESC == "ACRES"
),]

unique(crops_census_state_area_veg_noTOT_acres$COMMODITY_DESC)
unique(crops_census_state_area_veg_noTOT_acres$STATISTICCAT_DESC)

write.csv(crops_census_state_area_veg_noTOT_acres, file = (paste0(outputDir, "usda_census_acres_harv_l2.csv")))

### Yield ----
crops_census_state_area_veg_noTOT_yiels <- crops_census_state_area_veg_noTOT [(
  crops_census_state_area_veg_noTOT$UNIT_DESC == "CWT / ACRE"
),]

unique(crops_census_state_area_veg_noTOT_yiels$COMMODITY_DESC)
unique(crops_census_state_area_veg_noTOT_yiels$STATISTICCAT_DESC)

write.csv(crops_census_state_area_veg_noTOT_yiels, file = (paste0(outputDir, "usda_census_CWT-ACRE_yield_l2.csv")))

## Extracting county level ----
unique(crops_census$AGG_LEVEL_DESC)

crops_census_county <- crops_census[(
  crops_census$AGG_LEVEL_DESC == "COUNTY"
),]
unique(crops_census_county$GROUP_DESC)
unique(crops_census_county$COMMODITY_DESC)
unique(crops_census_county$UNIT_DESC)
unique(crops_census_county$STATISTICCAT_DESC)

#field crops:
crops_census_county_field <- crops_census_county[(
  crops_census_county$GROUP_DESC== "FIELD CROPS"
),]

unique(crops_census_county_field$UNIT_DESC)

crops_census_county_field_unit <- crops_census_county_field [(
  (crops_census_county_field$UNIT_DESC == "ACRES") |
  (crops_census_county_field$UNIT_DESC == "BU") |
  (crops_census_county_field$UNIT_DESC == "CWT") |
  (crops_census_county_field$UNIT_DESC == "LB") |
  (crops_census_county_field$UNIT_DESC == "TONS") |
  (crops_census_county_field$UNIT_DESC == "BALES") |
  (crops_census_county_field$UNIT_DESC == "TONS, DRY BASIS")
),]
unique(crops_census_county_field_unit$STATISTICCAT_DESC)

crops_census_county_field_unit_noCAPA <- crops_census_county_field_unit [(
  crops_census_county_field_unit$STATISTICCAT_DESC != "CAPACITY"
),]

unique(crops_census_county_field_unit_noCAPA$COMMODITY_DESC)

crops_census_county_field_unit_noCAPA_commod <- crops_census_county_field_unit_noCAPA[(
  crops_census_county_field_unit_noCAPA$COMMODITY_DESC == "HAY"
),]
unique(crops_census_county_field_unit_noCAPA_commod$CLASS_DESC)
unique(crops_census_county_field_unit_noCAPA_commod$PRODN_PRACTICE_DESC)
unique(crops_census_county_field_unit_noCAPA_commod$STATISTICCAT_DESC)
unique(crops_census_county_field_unit_noCAPA_commod$UNIT_DESC)
unique(crops_census_county_field_unit_noCAPA_commod$YEAR)

# Checking by commodities
# acres + BU: BARLEY (need to remove irrigated), FLAXSEED (remove irrigated), OATS(irrigated),RYE(irrigated), SOYBEANS(irrig)
#             , MILLET(irrig), BUCKWHEAT(irrig), EMMER & SPELT(irrig), TRITICALE(irrig),
#             CAMELINA(irrig)
# acres + cwt + lb: BEANS (remove irrigated)
# acres + cwt: LENTILS(remove irrigated), RICE(irrigated), SWEET RICE (irrig), WILD RICE(irrig), CHICKPEAS(irrig)
# acres + lb: CANOLA (irrig), HOPS (irrig), PEANUTS(irrig), RAPESEED(irrig), SAFFLOWER(irrig), SUNFLOWER(irrig), TARO(irrig),
#             TOBACCO(irrg), AMARANTH, CRAMBE, GUAR(irrig), JOJOBA(irrig), LOTUS ROOT(irrig), SESAME(irrig), DILL(irriga)
#             LEGUMES(irrgi), GRASSES(irrig), MUSTARD(irrig), POPCORN(irrig), HERBS(irrig), GRASSES & LEGUMES, OTHER(irrig)
# acres + bales: cotton (need to remove pima and upland AND irrigated)
# acres + tons,dry mass: HAY & HAYLAGE (remove irrigated)
# acres + tons: HAY (remoce irrigated + all classes - has too many different Hay types), HAYLAGE(irrig, only ALL classes)
#               SUGARCANE(irrig + remove area not harvested), MISCANTHUS(irrig), SWITCHGRASS(irrig)
# acres + cwt + BU: PEAS(irrigated)
# acres + tons + lb: SUGARBEETS(irrig)
# acres: FIELD CROPS, OTHER(irrig)
# acres + bu + tons: SORGHUM(irrig and bu is for grain, ton is for silage)

# MINT (irrig AND some different class desciprtions) needs to be extracted alone and investigated
# WHEAT(irrig, + need only ALL classes!)
# acres + bu + tons + lb: CORN (irrig and removoe traditional or indian) - corn is weird so probably needs to be extracted alone

# Proceeding now:
# 1) removing irrigated, area not-harvested,
# 2) think about which not to include!!
# 3) check if then the

crops_census_county_field_unit_noCAPA_noIRRI <- crops_census_county_field_unit_noCAPA [(
  (crops_census_county_field_unit_noCAPA$PRODN_PRACTICE_DESC != "IRRIGATED") &
    (crops_census_county_field_unit_noCAPA$STATISTICCAT_DESC != "AREA NOT HARVESTED")
),]
unique(crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC)

crops_census_l3_acres <- crops_census_county_field_unit_noCAPA_noIRRI[(
  (crops_census_county_field_unit_noCAPA_noIRRI$UNIT_DESC == "ACRES") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "MINT") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "CORN") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "HAY") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "COTTON") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "WHEAT")
),]
unique(crops_census_l3_acres$COMMODITY_DESC)
unique(crops_census_l3_acres$STATISTICCAT_DESC)

write.csv(crops_census_l3_acres, file = (paste0(outputDir, "usda_census_field_crops_ACRES_l3.csv")))

crops_census_l3_bu <- crops_census_county_field_unit_noCAPA_noIRRI[(
  (crops_census_county_field_unit_noCAPA_noIRRI$UNIT_DESC == "BU") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "MINT") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "CORN") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "HAY") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "COTTON") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "WHEAT") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "GRAIN STORAGE CAPACITY")
),]
unique(crops_census_l3_bu$COMMODITY_DESC)
unique(crops_census_l3_bu$STATISTICCAT_DESC)

write.csv(crops_census_l3_bu, file = (paste0(outputDir, "usda_census_field_crops_prod_bu_l3.csv")))

crops_census_l3_cwt <- crops_census_county_field_unit_noCAPA_noIRRI[(
  (crops_census_county_field_unit_noCAPA_noIRRI$UNIT_DESC == "CWT") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "MINT") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "CORN") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "HAY") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "COTTON") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "WHEAT")
),]
unique(crops_census_l3_cwt$COMMODITY_DESC)
unique(crops_census_l3_cwt$STATISTICCAT_DESC)

write.csv(crops_census_l3_cwt, file = (paste0(outputDir, "usda_census_field_crops_prod_cwt_l3.csv")))

crops_census_l3_lb <- crops_census_county_field_unit_noCAPA_noIRRI[(
  (crops_census_county_field_unit_noCAPA_noIRRI$UNIT_DESC == "LB") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "MINT") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "CORN") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "HAY") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "COTTON") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "WHEAT")
),]
unique(crops_census_l3_lb$COMMODITY_DESC)
unique(crops_census_l3_lb$STATISTICCAT_DESC)

write.csv(crops_census_l3_lb, file = (paste0(outputDir, "usda_census_field_crops_prod_lb_l3.csv")))

crops_census_l3_tons <- crops_census_county_field_unit_noCAPA_noIRRI[(
  (crops_census_county_field_unit_noCAPA_noIRRI$UNIT_DESC == "TONS") |
    (crops_census_county_field_unit_noCAPA_noIRRI$UNIT_DESC == "TONS, DRY BASIS") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "MINT") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "CORN") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "HAY") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "COTTON") &
    (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC != "WHEAT")
),]
unique(crops_census_l3_tons$COMMODITY_DESC)
unique(crops_census_l3_tons$STATISTICCAT_DESC)

write.csv(crops_census_l3_tons, file = (paste0(outputDir, "usda_census_field_crops_prod_tons_l3.csv")))

#extracting wheat alone
crops_census_l3_wheat <- crops_census_county_field_unit_noCAPA_noIRRI [(
  (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC == "WHEAT") &
    (crops_census_county_field_unit_noCAPA_noIRRI$CLASS_DESC == "ALL CLASSES")
),]
unique(crops_census_l3_wheat$UNIT_DESC)

write.csv(crops_census_l3_wheat, file = (paste0(outputDir, "usda_census_wheat_harve_prod_l3.csv")))

# extracting mint
crops_census_l3_mint <- crops_census_county_field_unit_noCAPA_noIRRI[(
  (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC == "MINT") &
    (crops_census_county_field_unit_noCAPA_noIRRI$CLASS_DESC == "ALL CLASSES")
),]
unique(crops_census_l3_mint$UNIT_DESC)

write.csv(crops_census_l3_mint, file = (paste0(outputDir, "usda_census_mint_prod_harv_l3.csv")))

# extracting corn
crops_census_l3_corn <- crops_census_county_field_unit_noCAPA_noIRRI[(
  (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC == "CORN") &
    (crops_census_county_field_unit_noCAPA_noIRRI$CLASS_DESC == "ALL CLASSES") &
    (crops_census_county_field_unit_noCAPA_noIRRI$UNIT_DESC != "BU")
),]
unique(crops_census_l3_corn$UNIT_DESC)

write.csv(crops_census_l3_corn, file = (paste0(outputDir, "usda_census_corn_acres_tons_l3.csv")))

crops_census_l3_corn_01 <- crops_census_county_field_unit_noCAPA_noIRRI[(
  (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC == "CORN") &
    (crops_census_county_field_unit_noCAPA_noIRRI$CLASS_DESC == "ALL CLASSES") &
    (crops_census_county_field_unit_noCAPA_noIRRI$UNIT_DESC == "BU")
),]
unique(crops_census_l3_corn_01$UNIT_DESC)

write.csv(crops_census_l3_corn_01, file = (paste0(outputDir, "usda_census_corn_BU_l3.csv")))

# extracting hay
crops_census_l3_hay <- crops_census_county_field_unit_noCAPA_noIRRI[(
  (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC == "HAY") &
    (crops_census_county_field_unit_noCAPA_noIRRI$CLASS_DESC == "ALL CLASSES")
),]
unique(crops_census_l3_hay$UNIT_DESC)
write.csv(crops_census_l3_hay, file = (paste0(outputDir, "usda_census_hay_acres_tons_l3.csv")))

# extracting hay
crops_census_l3_cotton <- crops_census_county_field_unit_noCAPA_noIRRI[(
  (crops_census_county_field_unit_noCAPA_noIRRI$COMMODITY_DESC == "COTTON") &
    (crops_census_county_field_unit_noCAPA_noIRRI$CLASS_DESC == "ALL CLASSES")
),]
unique(crops_census_l3_cotton$UNIT_DESC)
write.csv(crops_census_l3_cotton, file = (paste0(outputDir, "usda_census_cotton_acres_bales_l3.csv")))

#vegetables
crops_census_county_veg <- crops_census_county[(
  crops_census_county$GROUP_DESC== "VEGETABLES"
),]
unique(crops_census_county_veg$UNIT_DESC)
crops_census_county_veg_unit <- crops_census_county_veg [(
  (crops_census_county_veg$UNIT_DESC == "ACRES") |
    (crops_census_county_veg$UNIT_DESC == "LB") |
    (crops_census_county_veg$UNIT_DESC == "CWT")
),]
unique(crops_census_county_veg_unit$COMMODITY_DESC)
unique(crops_census_county_veg_unit$STATISTICCAT_DESC)

crops_census_county_veg_unit_noTot <- crops_census_county_veg_unit [(
  (crops_census_county_veg_unit$STATISTICCAT_DESC != "AREA IN PRODUCTION") &
    (crops_census_county_veg_unit$COMMODITY_DESC != "VEGETABLE TOTALS")
),]
unique(crops_census_county_veg_unit_noTot$COMMODITY_DESC)
unique(crops_census_county_veg_unit_noTot$STATISTICCAT_DESC)

crops_census_LB <- crops_census_county_veg_unit_noTot [(
  crops_census_county_veg_unit_noTot$UNIT_DESC == "LB"
),]
unique(crops_census_LB$COMMODITY_DESC)

write.csv(crops_census_LB, file = (paste0(outputDir, "usda_census_veg_prod_LB_l3.csv")))

crops_census_CWT <- crops_census_county_veg_unit_noTot [(
  crops_census_county_veg_unit_noTot$UNIT_DESC == "CWT"
),]
unique(crops_census_CWT$COMMODITY_DESC)

write.csv(crops_census_CWT, file = (paste0(outputDir, "usda_census_veg_prod_CWT_l3.csv")))

crops_census_ACRES <- crops_census_county_veg_unit_noTot [(
  (crops_census_county_veg_unit_noTot$UNIT_DESC == "ACRES") &
    (crops_census_county_veg_unit_noTot$PRODN_PRACTICE_DESC != "IRRIGATED")
),]
unique(crops_census_ACRES$PRODN_PRACTICE_DESC)

write.csv(crops_census_ACRES, file = (paste0(outputDir, "usda_census_veg_harv_ACRES_l3.csv")))


#fruit and tree
crops_census_county_fruit <- crops_census_county[(
  crops_census_county$GROUP_DESC== "FRUIT & TREE NUTS"
),]

unique(crops_census_county_fruit$COMMODITY_DESC)
unique(crops_census_county_fruit$PRODN_PRACTICE_DESC)
unique(crops_census_county_fruit$STATISTICCAT_DESC)
unique(crops_census_county_fruit$UNIT_DESC)

crops_census_county_fruit_unit <- crops_census_county_fruit [(
  (crops_census_county_fruit$UNIT_DESC == "ACRES") |
    (crops_census_county_fruit$UNIT_DESC == "TONS")
),]
unique(crops_census_county_fruit_unit$COMMODITY_DESC)
unique(crops_census_county_fruit_unit$PRODN_PRACTICE_DESC)
unique(crops_census_county_fruit_unit$STATISTICCAT_DESC)

crops_census_county_fruit_unit_noTOT <- crops_census_county_fruit_unit [(
  (crops_census_county_fruit_unit$COMMODITY_DESC != "TREE NUT TOTALS") &
    (crops_census_county_fruit_unit$COMMODITY_DESC != "NON-CITRUS TOTALS") &
    (crops_census_county_fruit_unit$COMMODITY_DESC != "BERRY TOTALS") &
    (crops_census_county_fruit_unit$COMMODITY_DESC != "CITRUS TOTALS")
),]
unique(crops_census_county_fruit_unit_noTOT$STATISTICCAT_DESC)
unique(crops_census_county_fruit_unit_noTOT$COMMODITY_DESC)

crops_census_county_fruit_unit_noTOT_prod <- crops_census_county_fruit_unit_noTOT[
  (crops_census_county_fruit_unit_noTOT$UNIT_DESC == "TONS"),]

write.csv(crops_census_county_fruit_unit_noTOT_prod, file = (paste0(outputDir, "usda_census_friut_prod_l3.csv")))

crops_census_county_fruit_unit_noTOT_harv <- crops_census_county_fruit_unit_noTOT[
  (crops_census_county_fruit_unit_noTOT$STATISTICCAT_DESC == "AREA HARVESTED"),]

write.csv(crops_census_county_fruit_unit_noTOT_harv, file = (paste0(outputDir, "usda_census_friut_harv_l3.csv")))

crops_census_county_fruit_unit_noTOT_plant <- crops_census_county_fruit_unit_noTOT[(
  (crops_census_county_fruit_unit_noTOT$STATISTICCAT_DESC != "AREA HARVESTED") &
    (crops_census_county_fruit_unit_noTOT$STATISTICCAT_DESC != "PRODUCTION")),]

write.csv(crops_census_county_fruit_unit_noTOT_plant, file = (paste0(outputDir, "usda_census_friut_plant_l3.csv")))


#horticulture
crops_census_county_horti <- crops_census_county[(
  crops_census_county$GROUP_DESC== "HORTICULTURE"
),]
unique(crops_census_county_horti$COMMODITY_DESC)
unique(crops_census_county_horti$STATISTICCAT_DESC)

crops_census_county_horti_unit <- crops_census_county_horti[(
  crops_census_county_horti$STATISTICCAT_DESC != "SALES"
),]

crops_census_county_horti_unit_noTOT <- crops_census_county_horti_unit[(
  (crops_census_county_horti_unit$COMMODITY_DESC != "HORTICULTURE TOTALS") &
    (crops_census_county_horti_unit$COMMODITY_DESC != "BEDDING PLANT TOTALS") &
    (crops_census_county_horti_unit$COMMODITY_DESC != "FLORICULTURE TOTALS") &
    (crops_census_county_horti_unit$COMMODITY_DESC != "FRUIT TOTALS") &
    (crops_census_county_horti_unit$COMMODITY_DESC != "VEGETABLE TOTALS") &
    (crops_census_county_horti_unit$COMMODITY_DESC != "NURSERY TOTALS")
),]
unique(crops_census_county_horti_unit_noTOT$COMMODITY_DESC)
unique(crops_census_county_horti_unit_noTOT$UNIT_DESC)

crops_census_county_horti_unit_noTOT_acre_sqft <- crops_census_county_horti_unit_noTOT [(
  crops_census_county_horti_unit_noTOT$UNIT_DESC == "ACRES"
    #(crops_census_county_horti_unit_noTOT$UNIT_DESC == "SQ FT")
),]
unique(crops_census_county_horti_unit_noTOT_acre_sqft$COMMODITY_DESC)
unique(crops_census_county_horti_unit_noTOT_acre_sqft$YEAR)
unique(crops_census_county_horti_unit_noTOT_acre_sqft$STATE_NAME)

write.csv(crops_census_county_horti_unit_noTOT_acre_sqft, file = (paste0(outputDir, "usda_census_horti_acres_l3.csv")))

## Crop census puerto rice ----
crops_census_puerto <- crops_census[(
  crops_census$AGG_LEVEL_DESC == "PUERTO RICO & OUTLYING AREAS"
),]
unique(crops_census_puerto$GROUP_DESC)
unique(crops_census_puerto$COMMODITY_DESC)

# field crops
crops_census_puerto_field_crops <- crops_census_puerto [(
  crops_census_puerto$GROUP_DESC == "FIELD CROPS"
),]
unique(crops_census_puerto_field_crops$COMMODITY_DESC)

crops_census_puerto_field_crops_noTOT <- crops_census_puerto_field_crops [(
  crops_census_puerto_field_crops$COMMODITY_DESC != "FIELD CROP TOTALS"
),]
unique(crops_census_puerto_field_crops_noTOT$STATISTICCAT_DESC)

crops_census_puerto_field_crops_noTOT_area <- crops_census_puerto_field_crops_noTOT [(
  (crops_census_puerto_field_crops_noTOT$STATISTICCAT_DESC == "PRODUCTION") |
    (crops_census_puerto_field_crops_noTOT$STATISTICCAT_DESC == "AREA HARVESTED") &
    (crops_census_puerto_field_crops_noTOT$UNIT_DESC != "OPERATIONS")
),]
unique(crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC)

# exploring by commodity:

crops_census_puerto_field_crops_noTOT_area_comm <- crops_census_puerto_field_crops_noTOT_area [(
  crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "COTTON"),]

unique(crops_census_puerto_field_crops_noTOT_area_comm$UNIT_DESC)
unique(crops_census_puerto_field_crops_noTOT_area_comm$STATISTICCAT_DESC)
unique(crops_census_puerto_field_crops_noTOT_area_comm$CLASS_DESC)

# HAY : acres + cuerdas + tons, dry basis + lb  - also need some adjusting the class desc: too many different
# TARO : acres + lb AND all classes and giant

# WHEAT : cuerda + cwt
# GRASSES : cuerdas
# COTTON : cuerdas + cwt
# RICE : cuerdas + cwt
# BEANS: CWT + CUERDAS
# SUNFLOWER : cwt + cuerdas
# PEAS : cuedar + cwt
# SOYBEANS : cuerdas + cwt
# DASHEENS : cuerdas + cwt

# SILAGE : cuerdas + tons
# HAY & HAYLAGE : tons, dry basis + cuerdas
# HAYLAGE : cuerdas + tons, dry basis


# extracting commodities:

crops_census_puerto_field_crops_noTOT_area_01 <- crops_census_puerto_field_crops_noTOT_area[(
  (crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "COTTON") |
    (crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "WHEAT") |
    (crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "RICE") |
    (crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "DASHEENS") |
    (crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "SOYBEANS") |
    (crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "PEAS") |
    (crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "SUNFLOWER") |
    (crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "BEANS") |
    (crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "GRASSES")
),]
write.csv(crops_census_puerto_field_crops_noTOT_area_01, file = (paste0(outputDir, "usda_census_field_crops_puerto_01.csv")))


crops_census_puerto_field_crops_noTOT_area_02 <- crops_census_puerto_field_crops_noTOT_area[(
  (crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "SILAGE") |
    (crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "HAY & HAYLAGE") |
    (crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "HAYLAGE")),]
write.csv(crops_census_puerto_field_crops_noTOT_area_02, file = (paste0(outputDir, "usda_census_field_crops_puerto_02.csv")))

# FIELD CROPS, OTHER : acreas + cuerdas + cwt + lb
# CORN : acres + cuerdas + cwt + lb
# SUGARCANE : cuerdas + cwt + acres + lb

crops_census_puerto_field_crops_noTOT_area_03 <- crops_census_puerto_field_crops_noTOT_area[(
  (crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "FIELD CROPS, OTHER") |
    (crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "CORN") |
    (crops_census_puerto_field_crops_noTOT_area$COMMODITY_DESC == "SUGARCANE")
),]
crops_census_puerto_field_crops_noTOT_area_03_00 <- crops_census_puerto_field_crops_noTOT_area_03 [(
  (crops_census_puerto_field_crops_noTOT_area_03$UNIT_DESC == "CWT")|
    (crops_census_puerto_field_crops_noTOT_area_03$UNIT_DESC == "CUERDAS")
),]

write.csv(crops_census_puerto_field_crops_noTOT_area_03_00, file = (paste0(outputDir, "usda_census_field_crops_puerto_03.csv")))

crops_census_puerto_field_crops_noTOT_area_03_01 <- crops_census_puerto_field_crops_noTOT_area_03 [(
  (crops_census_puerto_field_crops_noTOT_area_03$UNIT_DESC == "ACRES")|
    (crops_census_puerto_field_crops_noTOT_area_03$UNIT_DESC == "LB")
),]

write.csv(crops_census_puerto_field_crops_noTOT_area_03_01, file = (paste0(outputDir, "usda_census_field_crops_puerto_04.csv")))


# vegetables
crops_census_puerto_veg <- crops_census_puerto [(
  crops_census_puerto$GROUP_DESC == "VEGETABLES"
),]
unique(crops_census_puerto_veg$COMMODITY_DESC)

crops_census_puerto_veg_noTOT <- crops_census_puerto_veg [(
  crops_census_puerto_veg$COMMODITY_DESC != "VEGETABLE TOTALS"
),]

unique(crops_census_puerto_veg_noTOT$CLASS_DESC)
unique(crops_census_puerto_veg_noTOT$UNIT_DESC)
unique(crops_census_puerto_veg_noTOT$STATISTICCAT_DESC)

crops_census_puerto_veg_noTOT_area <- crops_census_puerto_veg_noTOT [(
  (crops_census_puerto_veg_noTOT$STATISTICCAT_DESC == "AREA HARVESTED") |
    (crops_census_puerto_veg_noTOT$STATISTICCAT_DESC == "PRODUCTION")
),]
unique(crops_census_puerto_veg_noTOT_area$UNIT_DESC)

crops_census_puerto_veg_noTOT_area_noOPER <- crops_census_puerto_veg_noTOT_area [(
  crops_census_puerto_veg_noTOT_area$UNIT_DESC != "OPERATIONS"
),]
unique(crops_census_puerto_veg_noTOT_area_noOPER$COMMODITY_DESC)

crops_census_puerto_veg_noTOT_area_noOPER_01 <- crops_census_puerto_veg_noTOT_area_noOPER [(
  (crops_census_puerto_veg_noTOT_area_noOPER$UNIT_DESC == "ACRES") |
    (crops_census_puerto_veg_noTOT_area_noOPER$UNIT_DESC == "LB")
),]

write.csv(crops_census_puerto_veg_noTOT_area_noOPER_01, file = (paste0(outputDir, "usda_census_veg_puerto_01.csv")))

crops_census_puerto_veg_noTOT_area_noOPER_02 <- crops_census_puerto_veg_noTOT_area_noOPER [(
  (crops_census_puerto_veg_noTOT_area_noOPER$UNIT_DESC == "CUERDAS") |
    (crops_census_puerto_veg_noTOT_area_noOPER$UNIT_DESC == "CWT")
),]

write.csv(crops_census_puerto_veg_noTOT_area_noOPER_02, file = (paste0(outputDir, "usda_census_veg_puerto_02.csv")))


# fruit
crops_census_puerto_fruit <- crops_census_puerto [(
  (crops_census_puerto$GROUP_DESC == "FRUIT & TREE NUTS") |
    (crops_census_puerto$GROUP_DESC == "FRUIT TOTALS")
),]
unique(crops_census_puerto_fruit$COMMODITY_DESC)

crops_census_puerto_fruit_noTOT <- crops_census_puerto_fruit [(
  crops_census_puerto_fruit$COMMODITY_DESC != "FRUIT & TREE NUT TOTALS"
),]

unique(crops_census_puerto_fruit_noTOT$UNIT_DESC)
unique(crops_census_puerto_fruit_noTOT$STATISTICCAT_DESC)

crops_census_puerto_fruit_noTOT_unit_01 <- crops_census_puerto_fruit_noTOT [(
    (crops_census_puerto_fruit_noTOT$UNIT_DESC == "CUERDAS") |
    (crops_census_puerto_fruit_noTOT$UNIT_DESC == "CWT")
),]
unique(crops_census_puerto_fruit_noTOT_unit_01$UNIT)

crops_census_puerto_fruit_noTOT_unit_01_harvProd <- crops_census_puerto_fruit_noTOT_unit_01[(
  (crops_census_puerto_fruit_noTOT_unit_01$STATISTICCAT_DESC != "AREA BEARING & NON-BEARING") &
    (crops_census_puerto_fruit_noTOT_unit_01$STATISTICCAT_DESC != "AREA BEARING & NONBEARING")
),]

write.csv(crops_census_puerto_fruit_noTOT_unit_01_harvProd, file = (paste0(outputDir, "usda_census_fruit_puerto_01.csv")))

crops_census_puerto_fruit_noTOT_unit_01_plant <- crops_census_puerto_fruit_noTOT_unit_01[(
  (crops_census_puerto_fruit_noTOT_unit_01$STATISTICCAT_DESC == "AREA BEARING & NON-BEARING") |
    (crops_census_puerto_fruit_noTOT_unit_01$STATISTICCAT_DESC == "AREA BEARING & NONBEARING")
),]

write.csv(crops_census_puerto_fruit_noTOT_unit_01_plant, file = (paste0(outputDir, "usda_census_fruit_puerto_plant_01.csv")))

crops_census_puerto_fruit_noTOT_unit_02 <- crops_census_puerto_fruit_noTOT [(
  crops_census_puerto_fruit_noTOT$UNIT_DESC == "LB"
),]
write.csv(crops_census_puerto_fruit_noTOT_unit_02, file = (paste0(outputDir, "usda_census_fruit_puertoLB_02.csv")))

crops_census_puerto_fruit_noTOT_unit_03 <- crops_census_puerto_fruit_noTOT [(
   crops_census_puerto_fruit_noTOT$UNIT_DESC == "TONS" ),]
write.csv(crops_census_puerto_fruit_noTOT_unit_03, file = (paste0(outputDir, "usda_census_fruit_puerto_03.csv")))


# horticulture
crops_census_puerto_horti <- crops_census_puerto [(
  crops_census_puerto$GROUP_DESC == "HORTICULTURE"
),]
unique(crops_census_puerto_horti$COMMODITY_DESC)

crops_census_puerto_horti_noTOT <- crops_census_puerto_horti [(
  (crops_census_puerto_horti$COMMODITY_DESC != "BEDDING PLANT TOTALS") &
    (crops_census_puerto_horti$COMMODITY_DESC != "VEGETABLE TOTALS") &
    (crops_census_puerto_horti$COMMODITY_DESC != "HORTICULTURE TOTALS")
),]

unique(crops_census_puerto_horti_noTOT$COMMODITY_DESC)
unique(crops_census_puerto_horti_noTOT$UNIT_DESC)

crops_census_puerto_horti_noTOT_unti01 <- crops_census_puerto_horti_noTOT [
  (crops_census_puerto_horti_noTOT$UNIT_DESC == "CUERDAS" ),]

write.csv(crops_census_puerto_horti_noTOT_unti01, file = (paste0(outputDir, "usda_census_horti_puerto01.csv")))

crops_census_puerto_horti_noTOT_unti02 <- crops_census_puerto_horti_noTOT [
    (crops_census_puerto_horti_noTOT$UNIT_DESC == "SQ FT"),]

write.csv(crops_census_puerto_horti_noTOT_unti02, file = (paste0(outputDir, "usda_census_horti_puerto02.csv")))



# Old script
gunzip('I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/united_states/qs.census2007.txt.gz')
dataPath_2007 <- 'I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/united_states/qs.census2007.txt'
census_2007 <- readLines(dataPath_2007)

gunzip('I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/united_states/qs.census2007zipcode.txt.gz')
dataPath_2007_zip <- 'I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/united_states/qs.census2007zipcode.txt'
census_2007_zip <- readLines(dataPath_2007_zip)

gunzip('I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/united_states/qs.census2012.txt.gz')
dataPath_2012 <- 'I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/united_states/qs.census2012.txt'
census_2012 <- readLines(dataPath_2012)

gunzip('I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/united_states/qs.census2017.txt.gz')
dataPath_2017 <- 'I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/united_states/qs.census2017.txt'
census_2017 <- readLines(dataPath_2017)

gunzip('I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/united_states/qs.census2017zipcode.txt.gz')
dataPath_2017_zip <- 'I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/united_states/qs.census2017zipcode.txt'
census_2017_zip <- readLines(dataPath_2017_zip)

# load metadata





