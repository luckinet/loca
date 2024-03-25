# script description ----
#
# This is the main script for building a database of (national and sub-national)
# census data for all crop and livestock commodities and land-use dimensions of
# LUCKINet.

## authors ----
# Steffen Ehrmann, Tsvetelina Tomova, Peter Pothmann
#
## data managers ----
# Felipe Melges, Annika Ertel, Caroline Busse, Abdualmaged Al-Hemiary,
# Evegenia Yolkina, Yang Xueqing

## version ----
# 1.0.0


## documentation ----
# file.edit(paste0(dir_docs, "/documentation/03 census database v1.0.0.md"))

## open tasks and change-log ----
# file.edit(paste0(dir_docs, "/milestones/03 build census database.md"))


# 1. start database or set path of current build ----
#
adb_init(root = dir_census, version = paste0(model_name, model_version),
         licence = "https://creativecommons.org/licenses/by-sa/4.0/",
         gazetteer = path_gaz, top = "al1",
         ontology = list("crop" = path_onto, "animal" = path_onto, "use" = path_onto),
         author = list(cre = model_info$authors$cre,
                       aut = model_info$authors$aut$census,
                       ctb = model_info$authors$ctb$census))

build_crops <- model_info$module_use$crops
build_livestock <- model_info$module_use$livestock
build_landuse <- model_info$module_use$landuse

# prepare GADM, in case it's not yet available
# source(paste0(dir_mdl04, "src/01_setup_gadm.R"))


# 2. build database ----
#
# source(paste0(dir_mdl04, "src/00_template.R"))

# script                                                           | adm lvl  | dataseries  | comment (which variables)

## per dataseries (02) ----
#
### global ----
source(paste0(dir_mdl04, "src/02_fao.R"))#
source(paste0(dir_mdl04, "src/02_glw.R"))#
# source(paste0(dir_mdl04, "src/X02_countrystat.R"))
# source(paste0(dir_mdl04, "src/02_unodc.R"))                          | > 3      | unodc       | crops (illicit)

### regional ----
source(paste0(dir_mdl04, "src/02_agriwanet.R"))#                       | 2        | agriwanet   | crops, livestock
source(paste0(dir_mdl04, "src/02_eurostat.R"))#                        | 3        | eurostat    | crops, livestock, land use


### outdated or redundant with the more detailed data below ----
# source(paste0(dir_mdl04, "src/X02_agCensus.R"))
# source(paste0(dir_mdl04, "src/X02_agromaps.R"))
# source(paste0(dir_mdl04, "src/X02_gaul.R"))
# source(paste0(dir_mdl04, "src/X02_spam.R"))
# source(paste0(dir_mdl04, "src/X02_worldbank.R"))


## per nation (03) ----
#
### northern africa ----
# source(paste0(dir_mdl04, "src/X03_algeria.R"))                       | 1        | ons         | ?
# source(paste0(dir_mdl04, "src/X03_egypt.R"))                         | 2        | capmas      | crops & livestock
# source(paste0(dir_mdl04, "src/X03_libya.R"))                         |          | bscl        | ?
# source(paste0(dir_mdl04, "src/X03_morocco.R"))                       | 3        | hpc, marma  | many tables, unclear
# source(paste0(dir_mdl04, "src/X03_sudan.R"))                         | 1        | cbs, ocha   | crops, livestock, land use
# source(paste0(dir_mdl04, "src/X03_tunisia.R"))                       |          |             | empty
# source(paste0(dir_mdl04, "src/X03_westernSahara.R"))                 |          |             | empty

### eastern africa ----
# source(paste0(dir_mdl04, "src/03_burundi.R"))                        |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/X03_comoros.R"))                       |  |  |
# source(paste0(dir_mdl04, "src/X03_djibouti.R"))                      |  |  |
# source(paste0(dir_mdl04, "src/X03_eritrea.R"))                       |  |  |
# source(paste0(dir_mdl04, "src/03_ethiopia.R"))                       |          |             | see 02_countryStat and 02_faoDataLab
# source(paste0(dir_mdl04, "src/03_kenya.R"))                          |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/03_madagascar.R"))                     |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/03_malawi.R"))                         |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/X03_mauritius.R"))                     |  |  |
# source(paste0(dir_mdl04, "src/03_mozambique.R"))                     | 2        | masa        | see 02_countryStat
# source(paste0(dir_mdl04, "src/03_rwanda.R"))                         |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/X03_seychelles.R"))                    |  |  |
# source(paste0(dir_mdl04, "src/X03_somalia.R"))                       |  |  |
# source(paste0(dir_mdl04, "src/X03_southSudan.R"))                    |  |  |
# source(paste0(dir_mdl04, "src/03_uganda.R"))                         |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/03_tanzania.R"))                       |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/03_zambia.R"))                         |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/03_zimbabwe.R"))                       |          |             | see 02_faoDataLab

### central africa ----
# source(paste0(dir_mdl04, "src/03_angola.R"))                         |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/03_cameroon.R"))                       |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/X03_centralAfricanRepublic.R"))        |  |  |
# source(paste0(dir_mdl04, "src/X03_chad.R"))                          |  |  |
# source(paste0(dir_mdl04, "src/03_republicCongo.R"))                  | ?        | cnsee       | see 02_countryStat
# source(paste0(dir_mdl04, "src/03_democraticRepublicCongo.R"))        |  |  |
# source(paste0(dir_mdl04, "src/X03_equatorialGuinea.R"))              |  |  |
# source(paste0(dir_mdl04, "src/03_gabon.R"))                          |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/X03_sãoToméPríncipe.R"))               |  |  |

### southern africa ----
# source(paste0(dir_mdl04, "src/_03_botswana.R"))                      |  |  |
# source(paste0(dir_mdl04, "src/_03_eswatini.R"))                      |  |  |
# source(paste0(dir_mdl04, "src/_03_lesotho.R"))                       |  |  |
# source(paste0(dir_mdl04, "src/03_namibia.R"))                        |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/_03_southAfrica.R"))                   |  |  |

### western africa ----
# source(paste0(dir_mdl04, "src/03_benin.R"))                          |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/03_burkinaFaso.R"))                    |          |             | see 02_countryStat and 02_faoDataLab
# source(paste0(dir_mdl04, "src/_03_capeVerde.R"))                     |  |  |
# source(paste0(dir_mdl04, "src/03_côtedivoire.R"))                    |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/03_gambia.R"))                         |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/03_ghana.R"))                          |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/_03_guinea.R"))                        |  |  |
# source(paste0(dir_mdl04, "src/03_guineaBissau.R"))                   |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/_03_liberia.R"))                       |  |  |
# source(paste0(dir_mdl04, "src/03_mali.R"))                           |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/_03_mauritania.R"))                    |  |  |
# source(paste0(dir_mdl04, "src/03_niger.R"))                          |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/03_nigeria.R"))                        |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/03_senegal.R"))                        |          |             | see 02_countryStat and 02_faoDataLab
# source(paste0(dir_mdl04, "src/_03_sierraLeone.R"))                   |  |  |
# source(paste0(dir_mdl04, "src/03_togo.R"))                           |          |             | see 02_countryStat

### northern america ----
source(paste0(dir_mdl04, "src/03_canada.R"))#                          | 4          | statcan   | crops, livestock, landuse
source(paste0(dir_mdl04, "src/03_unitedStatesOfAmerica.R"))#           | 3          | usda      | crops, livestock

### central america ----
# source(paste0(dir_mdl04, "src/_03_belize.R"))                        |  |  |
# source(paste0(dir_mdl04, "src/_03_costaRica.R"))                     |  |  |
# source(paste0(dir_mdl04, "src/03_elSalvador.R"))                     |          |             | see 02_faoDataLab
# source(paste0(dir_mdl04, "src/_03_guatemala.R"))                     |  |  |
# source(paste0(dir_mdl04, "src/_03_honduras.R"))                      |  |  |
# source(paste0(dir_mdl04, "src/_03_mexico.R")) wip                    |  |  |
# source(paste0(dir_mdl04, "src/_03_nicaragua.R"))                     |  |  |
# source(paste0(dir_mdl04, "src/_03_panama.R"))                        |  |  |

### carribean ----
# source(paste0(dir_mdl04, "src/_03_antiguaandBarbuda.R"))             |  |  |
# source(paste0(dir_mdl04, "src/_03_bahamas.R"))                       |  |  |
# source(paste0(dir_mdl04, "src/_03_barbados.R"))                      |  |  |
# source(paste0(dir_mdl04, "src/_03_cuba.R"))                          |  |  |
# source(paste0(dir_mdl04, "src/_03_dominica.R"))                      |  |  |
# source(paste0(dir_mdl04, "src/_03_dominicanRepublic.R"))             |  |  |
# source(paste0(dir_mdl04, "src/_03_grenada.R"))                       |  |  |
# source(paste0(dir_mdl04, "src/03_haiti.R"))                          |          |             | see 02_countryStat and 02_faoDataLab
# source(paste0(dir_mdl04, "src/_03_jamaica.R"))                       |  |  |
# source(paste0(dir_mdl04, "src/_03_saintKittsandNevis.R"))            |  |  |
# source(paste0(dir_mdl04, "src/_03_saintLucia.R"))                    |  |  |
# source(paste0(dir_mdl04, "src/_03_saintVincentandtheGrenadines.R"))  |  |  |
# source(paste0(dir_mdl04, "src/03_trinidadAndTobago.R"))              |          |             | see 02_faoDataLab

### southern america ----
source(paste0(dir_mdl04, "src/03_argentina.R"))#                       | 3        | senasa      | crops, livestock, planted trees
source(paste0(dir_mdl04, "src/03_bolivia.R"))#                         | 2        | ine         | crops
source(paste0(dir_mdl04, "src/03_brazil.R"))#                          | 3        | ibge, mapb  | crops, livestock, land use
# source(paste0(dir_mdl04, "src/_03_chile.R"))                         |  |  |
# source(paste0(dir_mdl04, "src/03_colombia.R"))                       |          |             | see 02_unodc
# source(paste0(dir_mdl04, "src/_03_ecuador.R"))                       |  |  |
# source(paste0(dir_mdl04, "src/_03_guyana.R"))                        |  |  |
# source(paste0(dir_mdl04, "src/03_paraguay.R"))#                        | 2        | senacsa     | needs an update!
# source(paste0(dir_mdl04, "src/03_peru.R"))                           |          |             | see 02_unodc
# source(paste0(dir_mdl04, "src/_03_suriname.R"))                      |  |  |
# source(paste0(dir_mdl04, "src/_03_uruguay.R"))                       |  |  |
# source(paste0(dir_mdl04, "src/_03_venezuela.R"))                     |  |  |

### central asia ----
# source(paste0(dir_mdl04, "src/03_kazakhstan.R"))                     |          |             | entirely included in 02_agriwanet
# source(paste0(dir_mdl04, "src/03_kygyzstan.R"))                      |          |             | entirely included in 02_agriwanet
# source(paste0(dir_mdl04, "src/03_tajikistan.R"))                     |          |             | entirely included in 02_agriwanet
# source(paste0(dir_mdl04, "src/03_turkmenistan.R"))                   |          |             | entirely included in 02_agriwanet
# source(paste0(dir_mdl04, "src/03_uzbekistan.R"))                     |          |             | entirely included in 02_agriwanet

### eastern asia ----
# source(paste0(dir_mdl04, "src/_03_china.R")) wip                       | > 3      | cnki, nbs   | man tables, unclear
# source(paste0(dir_mdl04, "src/_03_macao.R"))                         |  |  |
# source(paste0(dir_mdl04, "src/_03_japan.R")) wip                       |          | suomu       | crops, land use
# source(paste0(dir_mdl04, "src/_03_mongolia.R"))                      |  |  |
# source(paste0(dir_mdl04, "src/_03_southKorea.R")) wip                  |          |             | crops, livestock
# source(paste0(dir_mdl04, "src/_03_northKorea.R"))                    |  |  |
# source(paste0(dir_mdl04, "src/_03_taiwan.R")) wip                      | 3        | tca         | crops, livestock

### northern asia ----

### south-eastern asia ----
# source(paste0(dir_mdl04, "src/_03_brunei.R"))                        |  |  |
# source(paste0(dir_mdl04, "src/_03_cambodia.R"))                      |  |  |
# source(paste0(dir_mdl04, "src/_03_indonesia.R")) wip                   | 4        | bps         | most is available at level 4, but not yet mobilized
# source(paste0(dir_mdl04, "src/03_laos.R"))                           |          |             | see 02_faoDataLab and 02_unodc
# source(paste0(dir_mdl04, "src/_03_malaysia.R")) wip                    | 3        | midc, dosm  | many tables, not fully integrated
# source(paste0(dir_mdl04, "src/03_myanmar.R"))                        |          |             | see 02_unodc
# source(paste0(dir_mdl04, "src/_03_philippines.R"))                   | 3        | psa         | crops, land use
# source(paste0(dir_mdl04, "src/_03_singapore.R"))                     |  |  |
# source(paste0(dir_mdl04, "src/_03_thailand.R"))                      | 2        | nso         | crops, land use
# source(paste0(dir_mdl04, "src/_03_timorLeste.R"))                    |  |  |
# source(paste0(dir_mdl04, "src/_03_vietnam.R"))                       |  |  |

### southern asia ----
# source(paste0(dir_mdl04, "src/03_afghanistan.R"))                    |          |             | see 02_countryStat and 02_unodc
# source(paste0(dir_mdl04, "src/_03_bangladesh.R"))                    |  |  |
# source(paste0(dir_mdl04, "src/03_bhutan.R"))                         |          |             | see 02_countryStat
source(paste0(dir_mdl04, "src/03_india.R"))#                           | ?        | ?           | work in progress
# source(paste0(dir_mdl04, "src/_03_iran.R"))                          |  |  |
# source(paste0(dir_mdl04, "src/_03_maldives.R"))                      |  |  |
# source(paste0(dir_mdl04, "src/_03_nepal.R"))                         |  |  |
# source(paste0(dir_mdl04, "src/03_pakistan.R"))                       |          |             | see 02_faoDataLab
# source(paste0(dir_mdl04, "src/_03_sriLanka.R"))                      |  |  |

### western asia ----
# source(paste0(dir_mdl04, "src/_03_türkiye.R"))                        |  |  |
# source(paste0(dir_mdl04, "src/_03_bahrain.R"))                       |  |  |
# source(paste0(dir_mdl04, "src/_03_kuwait.R"))                        |  |  |
# source(paste0(dir_mdl04, "src/_03_oman.R"))                          |  |  |
# source(paste0(dir_mdl04, "src/_03_qatar.R"))                         |  |  |
# source(paste0(dir_mdl04, "src/_03_saudiArabia.R")) wip                 | ?        | gas         | many tables, unclear
# source(paste0(dir_mdl04, "src/_03_unitedArabEmirates.R"))            |  |  |
# source(paste0(dir_mdl04, "src/X03_yemen.R"))                         |  |  |
# source(paste0(dir_mdl04, "src/_03_armenia.R"))                       |  |  |
# source(paste0(dir_mdl04, "src/03_azerbaijan.R"))                     |          |             | see 02_countryStat
# source(paste0(dir_mdl04, "src/_03_georgia.R"))                       |  |  |
# source(paste0(dir_mdl04, "src/_03_iraq.R")) wip                        | ?        | cso         | many tables, unclear
# source(paste0(dir_mdl04, "src/_03_israel.R"))                        |  |  |
# source(paste0(dir_mdl04, "src/_03_lebanon.R"))                       |  |  |
# source(paste0(dir_mdl04, "src/_03_palestine.R"))                     |  |  |
# source(paste0(dir_mdl04, "src/_03_jordan.R")) wip                      | ?        | dos         | many tables, unclear
# source(paste0(dir_mdl04, "src/_03_syria.R")) wip                       | 2        | cbssyr      | many tables, hard to get

### eastern europe ----
# source(paste0(dir_mdl04, "src/_03_belarus.R"))                       |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_bulgaria.R"))                      |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_czechRepublic.R"))                 |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_hungary.R"))                       |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_moldova.R"))                       |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_poland.R"))                        |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_romania.R"))                       |          |             | entirely included in 02_eurostat
source(paste0(dir_mdl04, "src/03_russia.R")) wip                       | 3        | rosstat     | look for some more older data (should be available at lower level)
# source(paste0(dir_mdl04, "src/_03_slovakia.R"))                      |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_ukraine.R")) wip                     | > 3      | ukstat      | update tables

### northern europe ----
# source(paste0(dir_mdl04, "src/_03_denmark.R"))                       |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_estonia.R"))                       |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_finland.R"))                       |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_iceland.R"))                       |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_ireland.R"))                       |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_latvia.R"))                        |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_lithuania.R"))                     |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_norway.R"))                        |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_sweden.R"))                        |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_unitedKingdom.R"))                 |          |             | entirely included in 02_eurostat

### southern europe ----
# source(paste0(dir_mdl04, "src/_03_albania.R"))                       |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_andorra.R"))                       |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_bosniaandHerzegovina.R"))          |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_croatia.R"))                       |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_cyprus.R"))                        |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_greece.R"))                        |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_italy.R"))                         |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_kosovo.R"))                        |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_malta.R"))                         |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_montenegro.R"))                    |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_macedonia.R"))                     |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_portugal.R"))                      |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_serbia.R"))                        |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_slovenia.R"))                      |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_spain.R"))                         |          |             | entirely included in 02_eurostat

### western europe ----
# source(paste0(dir_mdl04, "src/_03_austria.R"))                       |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_belgium.R"))                       |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_france.R"))                        |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_germany.R"))                       |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_liechtenstein.R"))                 |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_luxembourg.R"))                    |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_monaco.R"))                        |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_netherlands.R"))                   |          |             | entirely included in 02_eurostat
# source(paste0(dir_mdl04, "src/_03_switzerland.R"))                   |          |             | entirely included in 02_eurostat

### australia and new zealand ----
source(paste0(dir_mdl04, "src/03_australia.R"))#                       | 3        | abs         | crop, livestock
source(paste0(dir_mdl04, "src/03_newZealand.R"))#                      | 3        | nzstat      | crop, livestock, landuse

### melanesia ----
# source(paste0(dir_mdl04, "src/_03_fiji.R"))                          |  |  |
# source(paste0(dir_mdl04, "src/_03_newCaledonia.R"))                  |  |  |
# source(paste0(dir_mdl04, "src/_03_papuaNewGuinea.R"))                |  |  |
# source(paste0(dir_mdl04, "src/_03_solomonIslands.R"))                |  |  |
# source(paste0(dir_mdl04, "src/_03_vanuatu.R"))                       |  |  |

### micronesia ----
# source(paste0(dir_mdl04, "src/_03_kiribati.R"))                      |  |  |
# source(paste0(dir_mdl04, "src/_03_micronesia.R"))                    |  |  |
# source(paste0(dir_mdl04, "src/_03_nauru.R"))                         |  |  |
# source(paste0(dir_mdl04, "src/_03_palau.R"))                         |  |  |

### polynesia ----
# source(paste0(dir_mdl04, "src/_03_samoa.R"))                         |  |  |
# source(paste0(dir_mdl04, "src/_03_tonga.R"))                         |  |  |
# source(paste0(dir_mdl04, "src/_03_tuvalu.R"))                        |  |  |



# 3. tie everything together ----
# source(paste0(dir_mdl04, "src/98_make_database.R"))
adb_backup()
adb_archive(outPath = dir_data, compress = TRUE)


# 4. and check whether it's all as expected ----
# source(paste0(dir_mdl04, "src/99_test-output.R"))


# 5. finally, update the luckinet-profile ----
profile <- load_profile(name = model_name, version = model_version)

profile$censusDB_dir <- model_version
write_profile(name = model_name, version = model_version, parameters = profile)

