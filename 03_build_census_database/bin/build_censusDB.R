# script description ----
#
# This is the main script for building a database of (national and sub-national)
# census data for all landuse dimensions of LUCKINet.


# authors ----
#
# Tsvetelina Tomova, Steffen Ehrmann, Peter Pothmann


# Documentation ----
#
currentModule <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))
# getOption("viewer")(rmarkdown::render(input = paste0(currentModule, "/README.md")))


# script arguments ----
#
source(paste0(dirname(currentModule), "/01_boot_framework.R"))


# 1. start database or set path of current build ----
#
start_arealDB(root = censusDBDir,
              gazetteer = gazDir, top = "al1",
              ontology = list("commodity" = ontoDir,
                              "land use" = ontoDir))


# prepare GADM, in case it's not yet available
if(!testFileExists(x = paste0(censusDBDir, "adb_geometries/stage1/gadm36_levels_gpkg.zip"))){
  source(paste0(mdl0301, "src/01_setup_gadm.R"))
}


# 2. build dataseries ----
#
# source(paste0(mdl0301, "src/00_template.R"))

## documentation
## script name                                                                  status   | incoming | comments |

## per dataseries ----
source(paste0(mdl0301, "src/02_fao.R"))#                                        done     | - |  |
# source(paste0(mdl0301, "src/02_countrystat.R"))                               done     | - |  |
# source(paste0(mdl0301, "src/02_agriwanet.R"))                                 done     | - |  |
source(paste0(mdl0301, "src/02_eurostat.R"))#                                   done     | - |  |
# source(paste0(mdl0301, "src/02_unodc.R"))                                     done     | - |  |
# source(paste0(mdl0301, "src/02_agromaps.R"))                                  ignored  | x | outdated or redundant with the more detailed data below |
# source(paste0(mdl0301, "src/02_agCensus.R"))                                  ignored  | x | outdated or redundant with the more detailed data below |
# source(paste0(mdl0301, "src/02_spam.R"))                                      consider | x |  |
# source(paste0(mdl0301, "src/02_gaul.R"))                                      ignored  | x | outdated or redundant with the more detailed data below |
# source(paste0(mdl0301, "src/02_worldbank.R"))                                 ignored  | - | no useful data found so far |


## per nation ----

### africa----
source(paste0(mdl0301, "src/03_algeria.R"))#                                       done     |  |  |
source(paste0(mdl0301, "src/03_angola.R"))#                                        done     | x | spam/agCensus/worldbank available, not integrated |
source(paste0(mdl0301, "src/03_benin.R"))#                                         done     |  |  |
source(paste0(mdl0301, "src/03_botswana.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/03_burkinaFaso.R"))#                                   done     |  |  |
source(paste0(mdl0301, "src/03_burundi.R"))#                                       done     |  |  |
source(paste0(mdl0301, "src/03_cameroon.R"))#                                      done     |  |  |
source(paste0(mdl0301, "src/03_capeVerde.R"))#                                     empty    |  |  |
source(paste0(mdl0301, "src/03_centralAfricanRepublic.R"))#                        empty    |  |  |
source(paste0(mdl0301, "src/03_chad.R"))#                                          empty    |  |  |
source(paste0(mdl0301, "src/03_comoros.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/03_côtedivoire.R"))#                                   done     |  |  |
source(paste0(mdl0301, "src/03_democraticRepublicCongo.R"))#                       empty    |  |  |
source(paste0(mdl0301, "src/03_djibouti.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/03_egypt.R"))#                                         done     | x | CAPMAS available, not integrated |
source(paste0(mdl0301, "src/03_equatorialGuinea.R"))#                              empty    |  |  |
source(paste0(mdl0301, "src/03_eritrea.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/03_eswatini.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/03_ethiopia.R"))#                                      done     | x | spam/worldbank/csa available, not integrated |
source(paste0(mdl0301, "src/03_gabon.R"))#                                         done     |  | Most data is harmonised. ProdCassava and prodBanana are not, because they have different geometries. |
source(paste0(mdl0301, "src/03_gambia.R"))#                                        done     |  |  |
source(paste0(mdl0301, "src/03_ghana.R"))#                                         done     |  |  |
source(paste0(mdl0301, "src/03_guinea.R"))#                                        empty    |  |  |
source(paste0(mdl0301, "src/03_guineaBissau.R"))#                                  done     |  |  |
source(paste0(mdl0301, "src/03_kenya.R"))#                                         done     | x | spam/agCensus available, not integrated; from coutryStat only level 1 are normalised. Level 2 and Level 3 have geometries which mach AgCensus, thus they are not normalised. |
source(paste0(mdl0301, "src/03_lesotho.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/03_liberia.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/03_libya.R"))#                                         empty    |  |  |
source(paste0(mdl0301, "src/03_madagascar.R"))#                                    done     |  | level 1, 2 and 3 are harmonised. Level 4 and 5 are not registered in the gadm gpkg. |
source(paste0(mdl0301, "src/03_malawi.R"))#                                        done     |  |  |
source(paste0(mdl0301, "src/03_mali.R"))#                                          done     |  |  |
source(paste0(mdl0301, "src/03_mauritania.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/03_mauritius.R"))#                                     empty    |  |  |
source(paste0(mdl0301, "src/03_morocco.R"))#                                       done     | x | maroc-maps available, not integrated, cannabis =ignore |
source(paste0(mdl0301, "src/03_mozambique.R"))#                                    done     | x | spam/masa available, not integrated |
source(paste0(mdl0301, "src/03_namibia.R"))#                                       done     |  |  |
source(paste0(mdl0301, "src/03_niger.R"))#                                         done     |  |  |
source(paste0(mdl0301, "src/03_nigeria.R"))#                                       done     | x | agCensus available, not integrated |
source(paste0(mdl0301, "src/03_republicCongo.R"))#                                 done     |  |  |
source(paste0(mdl0301, "src/03_rwanda.R"))#                                        done     |  |  |
source(paste0(mdl0301, "src/03_sãoToméPríncipe.R"))#                               empty    |  |  |
source(paste0(mdl0301, "src/03_senegal.R"))#                                       done     |  |  |
source(paste0(mdl0301, "src/03_seychelles.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/03_sierraLeone.R"))#                                   empty    |  |  |
source(paste0(mdl0301, "src/03_somalia.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/03_southAfrica.R"))#                                   done     |  | spam/agCensus available, not integrated |
source(paste0(mdl0301, "src/03_southSudan.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/03_sudan.R"))#                                         wip      |  | only halfway integrated |
source(paste0(mdl0301, "src/03_tanzania.R"))#                                      done     |  | One table does not have clear territories. |
source(paste0(mdl0301, "src/03_togo.R"))#                                          done     |  |  |
source(paste0(mdl0301, "src/03_tunisia.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/03_uganda.R"))#                                        done     |  |  |
source(paste0(mdl0301, "src/03_westernSahara.R"))#                                 empty    |  |  |
source(paste0(mdl0301, "src/03_zambia.R"))#                                        done     |  |  |
source(paste0(mdl0301, "src/03_zimbabwe.R"))#                                      done     |  |  |


### americas ----
source(paste0(mdl0301, "src/03_antiguaandBarbuda.R"))#                             empty    |  |  |
source(paste0(mdl0301, "src/03_argentina.R"))#                                     done     |  |  |
source(paste0(mdl0301, "src/03_bahamas.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/03_barbados.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/03_belize.R"))#                                        done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_bolivia.R"))#                                       done     |  |  |
source(paste0(mdl0301, "src/03_brazil.R"))#                                        done     |  |  |
source(paste0(mdl0301, "src/03_canada.R"))                                        wip      |  | Removed three tables with units of number for production. One table in the script has "bee colonies" - I think should be removed from script.
source(paste0(mdl0301, "src/03_chile.R"))#                                         done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_colombia.R"))#                                      done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_costaRica.R"))#                                     done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_cuba.R"))#                                          done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_dominica.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/03_dominicanRepublic.R"))#                             done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_ecuador.R"))#                                       done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_elSalvador.R"))#                                    done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_grenada.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/03_guatemala.R"))#                                     done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_guyana.R"))#                                        empty    |  |  |
source(paste0(mdl0301, "src/03_haiti.R"))#                                         done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_honduras.R"))#                                      done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_jamaica.R"))#                                       done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_mexico.R"))                                        wip      | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_nicaragua.R"))#                                     done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_panama.R"))#                                        done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_paraguay.R"))#                                      done     |  |  |
source(paste0(mdl0301, "src/03_peru.R"))#                                          done     |  | UNODC level 4 is not normalised. spam available, not integrated  |
source(paste0(mdl0301, "src/03_saintKittsandNevis.R"))#                            empty    |  |  |
source(paste0(mdl0301, "src/03_saintLucia.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/03_saintVincentandtheGrenadines.R"))#                  empty    |  |  |
source(paste0(mdl0301, "src/03_suriname.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/03_trinidadAndTobago.R"))#                             done     | x | spam available, not integrated  |
source(paste0(mdl0301, "src/03_unitedStatesOfAmerica.R"))                         wip      |  | USDA is integrated. |
source(paste0(mdl0301, "src/03_uruguay.R"))#                                       done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/03_venezuela.R"))#                                     done     | x | spam available, not integrated |


### asia ----
source(paste0(mdl0301, "src/03_afghanistan.R"))#                                   done     |  |  |
source(paste0(mdl0301, "src/03_armenia.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/03_azerbaijan.R"))#                                    done     |  |  |
source(paste0(mdl0301, "src/03_bahrain.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/03_bangladesh.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/03_bhutan.R"))#                                        done     |  |  |
source(paste0(mdl0301, "src/03_brunei.R"))#                                        empty    |  |  |
source(paste0(mdl0301, "src/03_cambodia.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/03_china.R"))                                         wip      | x | Script needs to be tested. So far tables are all ready. |
source(paste0(mdl0301, "src/03_cyprus.R"))#                                        empty    |  |  |
source(paste0(mdl0301, "src/03_georgia.R"))#                                       empty    |  | partly in ds_eurostat |
source(paste0(mdl0301, "src/03_india.R"))#                                         done     | x | spam/agCensus available, not integrated |
source(paste0(mdl0301, "src/03_indonesia.R"))#                                     done     |  | Geometries level 3, when we have numbering system and identical names |
source(paste0(mdl0301, "src/03_iran.R"))#                                          empty    |  |  |
source(paste0(mdl0301, "src/03_iraq.R"))#                                          wip      |  | loads of cso data available, not fully integrated. |
source(paste0(mdl0301, "src/03_israel.R"))#                                        empty    |  |  |
source(paste0(mdl0301, "src/03_japan.R"))#                                         done     |  | missing data on livetsock |
source(paste0(mdl0301, "src/03_jordan.R"))#                                        wip      |  | loads of dos data available, not fully integrated |
# source(paste0(mdl0301, "src/03_kazakhstan.R"))                                   empty    |  | entirely included in ds_agriwanet |
source(paste0(mdl0301, "src/03_kuwait.R"))#                                        empty    |  |  |
# source(paste0(mdl0301, "src/03_kygyzstan.R"))                                    empty    |  | entirely included in ds_agriwanet |
source(paste0(mdl0301, "src/03_laos.R"))#                                          done     |  |  |
source(paste0(mdl0301, "src/03_lebanon.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/03_macao.R"))#                                         empty    |  |  |
source(paste0(mdl0301, "src/03_malaysia.R"))#                                      wip      |  | loads of dosm/data.giv.my/midc data available, not fully integrated |
source(paste0(mdl0301, "src/03_maldives.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/03_mongolia.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/03_myanmar.R"))#                                       done     |  |  |
source(paste0(mdl0301, "src/03_nepal.R"))#                                         empty    |  |  |
source(paste0(mdl0301, "src/03_northKorea.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/03_oman.R"))#                                          empty    |  | website available |
source(paste0(mdl0301, "src/03_pakistan.R"))#                                      done     |  |  |
source(paste0(mdl0301, "src/03_palestine.R"))#                                     empty    |  |  |
source(paste0(mdl0301, "src/03_philippines.R"))#                                   wip      |  | requires test-normalisation |
source(paste0(mdl0301, "src/03_qatar.R"))#                                         empty    |  | website available |
source(paste0(mdl0301, "src/03_saudiArabia.R"))#                                   wip      |  | loads of gas data available, not fully integrated |
source(paste0(mdl0301, "src/03_singapore.R"))#                                     empty    |  |  |
source(paste0(mdl0301, "src/03_southKorea.R"))#                                    wip      |  | forest data missing, schemas missing |
source(paste0(mdl0301, "src/03_sriLanka.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/03_syria.R"))#                                         wip      |  | requires a lot of work to extract tables (makes sense to develope an automatic routine)  |
source(paste0(mdl0301, "src/03_taiwan.R"))#                                        done     |  |  |
# source(paste0(mdl0301, "src/03_tajikistan.R"))                                   empty    |  | entirely included in ds_agriwanet |
source(paste0(mdl0301, "src/03_thailand.R"))#                                      done     | x | nso available, not integrated |
source(paste0(mdl0301, "src/03_timorLeste.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/03_turkey.R"))#                                        empty    |  | agCensus available, not integrated |
# source(paste0(mdl0301, "src/03_turkmenistan.R"))                                 empty    |  | entirely included in ds_agriwanet |
source(paste0(mdl0301, "src/03_unitedArabEmirates.R"))#                            empty    |  |  |
# source(paste0(mdl0301, "src/03_uzbekistan.R"))                                   empty    |  | entirely included in ds_agriwanet |
source(paste0(mdl0301, "src/03_vietnam.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/03_yemen.R"))#                                         done     |  | there may be more data available locally |


### europe ----
# source(paste0(mdl0301, "src/03_albania.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_andorra.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_austria.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_belarus.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_belgium.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_bosniaandHerzegovina.R"))                         empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_bulgaria.R"))                                     empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_croatia.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_czechRepublic.R"))                                empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_denmark.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_estonia.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_finland.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_france.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_germany.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_greece.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_hungary.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_iceland.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_ireland.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_italy.R"))                                        empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_kosovo.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_latvia.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_liechtenstein.R"))                                empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_lithuania.R"))                                    empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_luxembourg.R"))                                   empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_macedonia.R"))                                    empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_malta.R"))                                        empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_moldova.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_monaco.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_montenegro.R"))                                   empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_norway.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_poland.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_portugal.R"))                                     done     |  | entirely included in ds_eurostat, ine available, not included |
# source(paste0(mdl0301, "src/03_romania.R"))                                      empty    |  | entirely included in ds_eurostat |
source(paste0(mdl0301, "src/03_russia.R"))#                                        done     | - |  |
# source(paste0(mdl0301, "src/03_serbia.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_slovakia.R"))                                     empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_slovenia.R"))                                     empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_spain.R"))                                        empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_sweden.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/03_switzerland.R"))                                  empty    |  | entirely included in ds_eurostat |
source(paste0(mdl0301, "src/03_ukraine.R"))                                       wip      |  |  |
# source(paste0(mdl0301, "src/03_unitedKingdom.R"))                                empty    |  | entirely included in ds_eurostat |


### oceania ----
source(paste0(mdl0301, "src/03_australia.R"))#                                     done     |  | spam/agCensus available, not integrated |
source(paste0(mdl0301, "src/03_fiji.R"))#                                          empty    |  |  |
source(paste0(mdl0301, "src/03_kiribati.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/03_micronesia.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/03_nauru.R"))#                                         empty    |  |  |
source(paste0(mdl0301, "src/03_newCaledonia.R"))#                                  empty    |  |  |
source(paste0(mdl0301, "src/03_newZealand.R"))#                                    issue    |  | error: registering geometries, two schemas need two filters! |
source(paste0(mdl0301, "src/03_palau.R"))#                                         empty    |  |  |
source(paste0(mdl0301, "src/03_papuaNewGuinea.R"))#                                empty    |  |  |
source(paste0(mdl0301, "src/03_samoa.R"))#                                         empty    |  |  |
source(paste0(mdl0301, "src/03_solomonIslands.R"))#                                empty    |  |  |
source(paste0(mdl0301, "src/03_tonga.R"))#                                         empty    |  |  |
source(paste0(mdl0301, "src/03_tuvalu.R"))#                                        empty    |  |  |
source(paste0(mdl0301, "src/03_vanuatu.R"))#                                       empty    |  |  |


# tie everything together ----
source(paste0(mdl0301, "src/98_make_database.R"))


# and check whether it's all as expected ----
source(paste0(mdl0301, "src/99_test-output.R"))


# finally, update the luckinet-profile ----
profile <- load_profile(root = dataDir, name = model_name, version = model_version)

profile$censusDB_dir <- DB_version
write_profile(root = dataDir, name = model_name, version = model_version,
              parameters = profile)

