# ----
# title        : calculate FAO land-use areas
# authors      : Steffen Ehrmann
# version      : 0.8.0
# date         : 2024-03-27
# description  : _INSERT
# documentation: -
# ----
message("\n---- FAO Landcover areas ----")

# 1. make paths ----
#
_INSERT <- str_replace(_INSERT, "\\{_INSERT\\}", _INSERT)

# 2. load data ----
#
unzip(exdir = tempdir(), zipfile = paste0(dataDir, "censusDB/adb_tables/stage1/Inputs_LandUse_E_All_Data_(Normalized).zip"))

countries <- read_rds(file = paste0(dataDir, "tables/countries.rds"))
ontology <- read_rds(file = paste0(dataDir, "tables/ontology.rds"))
fao_landuse <- read_csv(paste0(tempdir(), "/Inputs_LandUse_E_All_Data_(Normalized).csv"), locale = locale(encoding = "WINDOWS-1252"))

# 3. data processing ----
#
## _INSERT ----
message(" --> _INSERT")

luckinet_fao_countries <- fao_landuse %>%
  select(Area, `Area Code`) %>%
  distinct() %>%
  filter(!Area %in% c("China")) %>%
  # adapt FAO names to LUCKINet names
  mutate(unit = case_when(Area == "Bolivia (Plurinational State of)" ~ "Bolivia",
                          Area == "Brunei Darussalam" ~ "Brunei",
                          Area == "Cabo Verde" ~ "Cape Verde",
                          Area == "China, Hong Kong SAR" ~ "Hong Kong",
                          Area == "China, Macao SAR" ~ "Macao",
                          Area == "China, mainland" ~ "China",
                          Area == "China, Taiwan Province of" ~ "Taiwan",
                          Area == "Congo" ~ "Republic of Congo",
                          Area == "Côte d'Ivoire" ~ "Côte D'ivoire",
                          Area == "Czechia" ~ "Czech Republic",
                          Area == "Democratic People's Republic of Korea" ~ "North Korea",
                          Area == "Falkland Islands (Malvinas)" ~ "Falkland Islands",
                          Area == "French Guyana" ~ "French Guiana",
                          Area == "Holy See" ~ "Vatican",
                          Area == "Iran (Islamic Republic of)" ~ "Iran",
                          Area == "Lao People's Democratic Republic" ~ "Laos",
                          Area == "North Macedonia" ~ "Macedonia",
                          Area == "Pitcairn Islands" ~ "Pircarin",
                          Area == "Republic of Korea" ~ "South Korea",
                          Area == "Republic of Moldova" ~ "Moldova",
                          Area == "Russian Federation" ~ "Russia",
                          Area == "Saint Helena, Ascension and Tristan da Cunha" ~ "Saint Helena",
                          Area == "Saint-Martin (French part)" ~ "Saint Martin",
                          Area == "Sao Tome and Principe" ~ "São Tomé and Príncipe",
                          Area == "Sint Maarten (Dutch part)" ~ "Sint Maarten",
                          Area == "Syrian Arab Republic" ~ "Syria",
                          Area == "United Kingdom of Great Britain and Northern Ireland" ~ "United Kingdom",
                          Area == "United Republic of Tanzania" ~ "Tanzania",
                          Area == "Venezuela (Bolivarian Republic of)" ~ "Venezuela",
                          Area == "Viet Nam" ~ "Vietnam",
                          Area == "Wallis and Futuna Islands" ~ "Wallis and Futuna",
                          TRUE ~ Area))
luckinet_fao_countries <- countries %>%
  full_join(luckinet_fao_countries, by = "unit") %>%
  filter(!is.na(continent))

fao_landuse <- fao_landuse %>%
  filter(`Area Code` %in% luckinet_fao_countries$`Area Code`) %>%
  filter(`Item Code` %in% c(na.omit(unique(ontology$mappings$RL)), "6601", "6670")) %>%
  filter(Element != "Carbon stock in living biomass")

landuse_fao <- fao_landuse %>%
  mutate(Value = Value * 1000) %>%
  pivot_wider(id_cols = c(Area, Year), names_from = Item, values_from = Value) %>%
  pivot_longer(cols = `Arable land`:`Coastal waters`, names_to = "type", values_to = "area") %>%
  mutate(prop = round(area/`Land area` * 100), 2) %>%
  select(unit = Area, land_area = `Land area`, type, area, prop, year = Year) %>%
  filter(!is.na(prop)) %>%
  mutate(type_short = case_when(type == "Arable land"~"arable land",
                                type == "Land under permanent crops"~"perm. crops",
                                type == "Land under perm. meadows and pastures"~"perm. grazing",
                                type == "Forest land"~"forest land",
                                type == "Naturally regenerating forest"~"naturally regen. \nforest",
                                type == "Planted Forest"~"planted forest",
                                type == "Other land"~"other land",
                                type == "Primary Forest"~"primary forest",
                                type == "Land under temporary crops"~"temp. crops",
                                type == "Land with temporary fallow"~"fallow",
                                type == "Inland waters"~"water bodies",
                                type == "Land under temp. meadows and pastures"~"temp. grazing",
                                type == "Land under protective cover"~"prot. cover",
                                type == "Coastal waters"~"coastal waters"),
         type_short = factor(type_short,
                             levels = c("arable land", "temp. crops", "perm. crops", "fallow",
                                        "prot. cover", "temp. grazing", "perm. grazing",
                                        "forest land", "primary forest", "naturally regen. \nforest",
                                        "planted forest", "other land", "water bodies",
                                        "coastal waters")))

# 4. write output ----
#
write_rds(x = landuse_fao, paste0(dataDir, "tables/landuse_fao.rds"))

# beep(sound = 10)
message("\n     ... done")
