# conversion of imperial units ----
#
# Acres to hectares, BU of wheat to metric tonnes, yield of bu/ac to kg/ha
# Converting US units:
# https://grains.org/markets-tools-data/tools/converting-grain-units/
# https://www.extension.iastate.edu/agdm/wholefarm/html/c6-80.html
# https://www.foodbankcny.org/assets/Documents/Fruit-conversion-chart.pdf
# https://www.agric.gov.ab.ca/app19/calc/crop/bushel2tonne.jsp

# geometries ----
#
geoms <- list.files(path = paste0(census_dir, "adb_geometries/stage1"), pattern = "StCoGenAll17_WGS84WMAS", full.names = TRUE)
unzip(zipfile = geoms, exdir = paste0(census_dir, "adb_geometries/stage1/processing"))

states <- list.files(path = paste0(census_dir, "adb_geometries/stage1/processing"), pattern = "St.*shp$", full.names = TRUE)
states <- map(.x = seq_along(states), .f = function(ix){

  st_read(dsn = states[ix])

}) %>%
  bind_rows()

st_write(obj = states, dsn = paste0(census_dir, "adb_geometries/stage2/United States of America_al2__usda.gpkg"))

counties <- list.files(path = paste0(census_dir, "adb_geometries/stage1/processing"), pattern = "Co.*shp$", full.names = TRUE)
counties <- map(.x = seq_along(counties), .f = function(ix){

  st_read(dsn = counties[ix])

}) %>%
  bind_rows()

st_write(obj = counties, dsn = paste0(census_dir, "adb_geometries/stage2/United States of America_al3__usda.gpkg"))

unlink(paste0(census_dir, "adb_geometries/stage1/processing"), recursive = TRUE)

# livestock (heads) ----
qs_animals_products_20231026_txt <-
  read_delim("00_data/04_census_data/adb_tables/stage1/usda/qs.animals_products_20231026.txt.gz",
             delim = "\t", escape_double = FALSE,
             trim_ws = TRUE)

livestock_census <- qs_animals_products_20231026_txt %>%
  filter(SOURCE_DESC == "CENSUS") %>%
  filter(CLASS_DESC == "ALL CLASSES" | CLASS_DESC == "INCL CALVES") %>%
  filter(PRODN_PRACTICE_DESC == "ALL PRODUCTION PRACTICES") %>%
  filter(STATISTICCAT_DESC == "INVENTORY") %>%
  filter(UNIT_DESC == "HEAD") %>%
  filter(DOMAIN_DESC == "TOTAL") %>%
  filter(AGG_LEVEL_DESC == "COUNTY")

write_csv(x = livestock_census,
          file = paste0(census_dir, "adb_tables/stage2/UnitedStatesofAmerica_censusLivestock_1997_2018_usda.csv"))

livestock_survey <- qs_animals_products_20231026_txt %>%
  filter(SOURCE_DESC == "SURVEY") %>%
  filter(CLASS_DESC == "ALL CLASSES" | CLASS_DESC == "INCL LAMBS" | CLASS_DESC == "INCL CALVES") %>% # this column doesn't allow a "TOTAL" for CHICKENS...
  filter(PRODN_PRACTICE_DESC == "ALL PRODUCTION PRACTICES") %>%
  filter(STATISTICCAT_DESC == "INVENTORY") %>%
  filter(UNIT_DESC == "HEAD") %>%
  filter(DOMAIN_DESC == "TOTAL") %>%
  filter(AGG_LEVEL_DESC == "COUNTY")

write_csv(x = livestock_survey,
          file = paste0(census_dir, "adb_tables/stage2/UnitedStatesofAmerica_surveyLivestock_1919_2023_usda.csv"))

# crops (areas) ----
qs_crops_20231026_txt <-
  read_delim("00_data/04_census_data/adb_tables/stage1/usda/qs.crops_20231026.txt.gz",
             delim = "\t", escape_double = FALSE,
             trim_ws = TRUE)

crops_census <- qs_crops_20231026_txt %>%
  filter(SOURCE_DESC == "CENSUS") %>%
  filter(AGG_LEVEL_DESC == "COUNTY") %>%
  filter(UNIT_DESC == "ACRES") %>%
  filter(DOMAIN_DESC == "TOTAL")

write_csv(x = crops_census,
          file = paste0(census_dir, "adb_tables/stage2/UnitedStatesofAmerica_censusCrops_1997_2017_usda.csv"))

crops_survey <- qs_crops_20231026_txt %>%
  filter(SOURCE_DESC == "SURVEY") %>%
  filter(AGG_LEVEL_DESC == "COUNTY") %>%
  filter(UNIT_DESC == "ACRES") %>%
  filter(DOMAIN_DESC == "TOTAL")

write_csv(x = crops_survey,
          file = paste0(census_dir, "adb_tables/stage2/UnitedStatesofAmerica_surveyLCrops_1909_2022_usda.csv"))


# environmental survey ----
# qs_environmental_20231026_txt <-
#   read_delim("00_data/04_census_data/adb_tables/stage1/usda/qs.environmental_20231026.txt.gz",
#              delim = "\t", escape_double = FALSE,
#              trim_ws = TRUE)



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
#
########
#
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
