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
getOption("viewer")(rmarkdown::render(input = paste0(currentModule, "/README.md")))


# script arguments ----
#
source(paste0(dirname(currentModule), "/01_boot_framework.R"))


# 1. start database or set path of current build ----
#
start_arealDB(root = censusDBDir, gazetteer = gazDir)

countries <- get_concept(x = tibble(class = "al1"), ontology = gazDir) %>%
  arrange(label)

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
source(paste0(mdl0301, "src/ds_fao.R"))#                                        done     | - |  |
source(paste0(mdl0301, "src/ds_countrystat.R"))#                                done     | - |  |
source(paste0(mdl0301, "src/ds_agriwanet.R"))#                                  done     | - |  |
source(paste0(mdl0301, "src/ds_eurostat.R"))#                                   done     | - |  |
source(paste0(mdl0301, "src/ds_unodc.R"))#                                      done     | - |  |
# source(paste0(mdl0301, "src/ds_agromaps.R"))                                  ignored  | x | outdated or redundant with the more detailed data below |
# source(paste0(mdl0301, "src/ds_agCensus.R"))                                  ignored  | x | outdated or redundant with the more detailed data below |
# source(paste0(mdl0301, "src/ds_spam.R"))                                      consider | x |  |
# source(paste0(mdl0301, "src/ds_gaul.R"))                                      ignored  | x | outdated or redundant with the more detailed data below |
# source(paste0(mdl0301, "src/ds_worldbank.R"))                                 ignored  | - | no useful data found so far |


## per nation ----

### africa----
source(paste0(mdl0301, "src/algeria.R"))#                                       done     |  |  |
source(paste0(mdl0301, "src/angola.R"))#                                        done     | x | spam/agCensus/worldbank available, not integrated |
source(paste0(mdl0301, "src/benin.R"))#                                         done     |  |  |
source(paste0(mdl0301, "src/botswana.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/burkinaFaso.R"))#                                   done     |  |  |
source(paste0(mdl0301, "src/burundi.R"))#                                       done     |  |  |
source(paste0(mdl0301, "src/cameroon.R"))#                                      done     |  |  |
source(paste0(mdl0301, "src/capeVerde.R"))#                                     empty    |  |  |
source(paste0(mdl0301, "src/centralAfricanRepublic.R"))#                        empty    |  |  |
source(paste0(mdl0301, "src/chad.R"))#                                          empty    |  |  |
source(paste0(mdl0301, "src/comoros.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/côtedivoire.R"))#                                   done     |  |  |
source(paste0(mdl0301, "src/democraticRepublicCongo.R"))#                       empty    |  |  |
source(paste0(mdl0301, "src/djibouti.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/egypt.R"))#                                         done     | x | CAPMAS available, not integrated |
source(paste0(mdl0301, "src/equatorialGuinea.R"))#                              empty    |  |  |
source(paste0(mdl0301, "src/eritrea.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/eswatini.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/ethiopia.R"))#                                      done     | x | spam/worldbank/csa available, not integrated |
source(paste0(mdl0301, "src/gabon.R"))#                                         done     |  | Most data is harmonised. ProdCassava and prodBanana are not, because they have different geometries. |
source(paste0(mdl0301, "src/gambia.R"))#                                        done     |  |  |
source(paste0(mdl0301, "src/ghana.R"))#                                         done     |  |  |
source(paste0(mdl0301, "src/guinea.R"))#                                        empty    |  |  |
source(paste0(mdl0301, "src/guineaBissau.R"))#                                  done     |  |  |
source(paste0(mdl0301, "src/kenya.R"))#                                         done     | x | spam/agCensus available, not integrated; from coutryStat only level 1 are normalised. Level 2 and Level 3 have geometries which mach AgCensus, thus they are not normalised. |
source(paste0(mdl0301, "src/lesotho.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/liberia.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/libya.R"))#                                         empty    |  |  |
source(paste0(mdl0301, "src/madagascar.R"))#                                    done     |  | level 1, 2 and 3 are harmonised. Level 4 and 5 are not registered in the gadm gpkg. |
source(paste0(mdl0301, "src/malawi.R"))#                                        done     |  |  |
source(paste0(mdl0301, "src/mali.R"))#                                          done     |  |  |
source(paste0(mdl0301, "src/mauritania.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/mauritius.R"))#                                     empty    |  |  |
source(paste0(mdl0301, "src/morocco.R"))#                                       done     | x | maroc-maps available, not integrated, cannabis =ignore |
source(paste0(mdl0301, "src/mozambique.R"))#                                    done     | x | spam/masa available, not integrated |
source(paste0(mdl0301, "src/namibia.R"))#                                       done     |  |  |
source(paste0(mdl0301, "src/niger.R"))#                                         done     |  |  |
source(paste0(mdl0301, "src/nigeria.R"))#                                       done     | x | agCensus available, not integrated |
source(paste0(mdl0301, "src/republicCongo.R"))#                                 done     |  |  |
source(paste0(mdl0301, "src/rwanda.R"))#                                        done     |  |  |
source(paste0(mdl0301, "src/sãoToméPríncipe.R"))#                               empty    |  |  |
source(paste0(mdl0301, "src/senegal.R"))#                                       done     |  |  |
source(paste0(mdl0301, "src/seychelles.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/sierraLeone.R"))#                                   empty    |  |  |
source(paste0(mdl0301, "src/somalia.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/southAfrica.R"))#                                   done     |  | spam/agCensus available, not integrated |
source(paste0(mdl0301, "src/southSudan.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/sudan.R"))#                                         wip      |  | only halfway integrated |
source(paste0(mdl0301, "src/tanzania.R"))#                                      done     |  | One table does not have clear territories. |
source(paste0(mdl0301, "src/togo.R"))#                                          done     |  |  |
source(paste0(mdl0301, "src/tunisia.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/uganda.R"))#                                        done     |  |  |
source(paste0(mdl0301, "src/westernSahara.R"))#                                 empty    |  |  |
source(paste0(mdl0301, "src/zambia.R"))#                                        done     |  |  |
source(paste0(mdl0301, "src/zimbabwe.R"))#                                      done     |  |  |


### americas ----
source(paste0(mdl0301, "src/antiguaandBarbuda.R"))#                             empty    |  |  |
source(paste0(mdl0301, "src/argentina.R"))#                                     done     |  |  |
source(paste0(mdl0301, "src/bahamas.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/barbados.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/belize.R"))#                                        done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/bolivia.R"))#                                       done     |  |  |
source(paste0(mdl0301, "src/brazil.R"))#                                        done     |  |  |
source(paste0(mdl0301, "src/canada.R"))                                        wip      |  | Removed three tables with units of number for production. One table in the script has "bee colonies" - I think should be removed from script.
source(paste0(mdl0301, "src/chile.R"))#                                         done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/colombia.R"))#                                      done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/costaRica.R"))#                                     done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/cuba.R"))#                                          done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/dominica.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/dominicanRepublic.R"))#                             done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/ecuador.R"))#                                       done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/elSalvador.R"))#                                    done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/grenada.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/guatemala.R"))#                                     done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/guyana.R"))#                                        empty    |  |  |
source(paste0(mdl0301, "src/haiti.R"))#                                         done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/honduras.R"))#                                      done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/jamaica.R"))#                                       done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/mexico.R"))                                        wip      | x | spam available, not integrated |
source(paste0(mdl0301, "src/nicaragua.R"))#                                     done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/panama.R"))#                                        done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/paraguay.R"))#                                      done     |  |  |
source(paste0(mdl0301, "src/peru.R"))#                                          done     |  | UNODC level 4 is not normalised. spam available, not integrated  |
source(paste0(mdl0301, "src/saintKittsandNevis.R"))#                            empty    |  |  |
source(paste0(mdl0301, "src/saintLucia.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/saintVincentandtheGrenadines.R"))#                  empty    |  |  |
source(paste0(mdl0301, "src/suriname.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/trinidadAndTobago.R"))#                             done     | x | spam available, not integrated  |
source(paste0(mdl0301, "src/unitedStatesOfAmerica.R"))                         wip      |  | USDA is integrated. |
source(paste0(mdl0301, "src/uruguay.R"))#                                       done     | x | spam available, not integrated |
source(paste0(mdl0301, "src/venezuela.R"))#                                     done     | x | spam available, not integrated |


### asia ----
source(paste0(mdl0301, "src/afghanistan.R"))#                                   done     |  |  |
source(paste0(mdl0301, "src/armenia.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/azerbaijan.R"))#                                    done     |  |  |
source(paste0(mdl0301, "src/bahrain.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/bangladesh.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/bhutan.R"))#                                        done     |  |  |
source(paste0(mdl0301, "src/brunei.R"))#                                        empty    |  |  |
source(paste0(mdl0301, "src/cambodia.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/china.R"))                                         wip      | x | Script needs to be tested. So far tables are all ready. |
source(paste0(mdl0301, "src/cyprus.R"))#                                        empty    |  |  |
source(paste0(mdl0301, "src/georgia.R"))#                                       empty    |  | partly in ds_eurostat |
source(paste0(mdl0301, "src/india.R"))#                                         done     | x | spam/agCensus available, not integrated |
source(paste0(mdl0301, "src/indonesia.R"))#                                     done     |  | Geometries level 3, when we have numbering system and identical names |
source(paste0(mdl0301, "src/iran.R"))#                                          empty    |  |  |
source(paste0(mdl0301, "src/iraq.R"))#                                          wip      |  | loads of cso data available, not fully integrated. |
source(paste0(mdl0301, "src/israel.R"))#                                        empty    |  |  |
source(paste0(mdl0301, "src/japan.R"))#                                         done     |  | missing data on livetsock |
source(paste0(mdl0301, "src/jordan.R"))#                                        wip      |  | loads of dos data available, not fully integrated |
# source(paste0(mdl0301, "src/kazakhstan.R"))                                   empty    |  | entirely included in ds_agriwanet |
source(paste0(mdl0301, "src/kuwait.R"))#                                        empty    |  |  |
# source(paste0(mdl0301, "src/kygyzstan.R"))                                    empty    |  | entirely included in ds_agriwanet |
source(paste0(mdl0301, "src/laos.R"))#                                          done     |  |  |
source(paste0(mdl0301, "src/lebanon.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/macao.R"))#                                         empty    |  |  |
source(paste0(mdl0301, "src/malaysia.R"))#                                      wip      |  | loads of dosm/data.giv.my/midc data available, not fully integrated |
source(paste0(mdl0301, "src/maldives.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/mongolia.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/myanmar.R"))#                                       done     |  |  |
source(paste0(mdl0301, "src/nepal.R"))#                                         empty    |  |  |
source(paste0(mdl0301, "src/northKorea.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/oman.R"))#                                          empty    |  | website available |
source(paste0(mdl0301, "src/pakistan.R"))#                                      done     |  |  |
source(paste0(mdl0301, "src/palestine.R"))#                                     empty    |  |  |
source(paste0(mdl0301, "src/philippines.R"))#                                   wip      |  | requires test-normalisation |
source(paste0(mdl0301, "src/qatar.R"))#                                         empty    |  | website available |
source(paste0(mdl0301, "src/saudiArabia.R"))#                                   wip      |  | loads of gas data available, not fully integrated |
source(paste0(mdl0301, "src/singapore.R"))#                                     empty    |  |  |
source(paste0(mdl0301, "src/southKorea.R"))#                                    wip      |  | forest data missing, schemas missing |
source(paste0(mdl0301, "src/sriLanka.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/syria.R"))#                                         wip      |  | requires a lot of work to extract tables (makes sense to develope an automatic routine)  |
source(paste0(mdl0301, "src/taiwan.R"))#                                        done     |  |  |
# source(paste0(mdl0301, "src/tajikistan.R"))                                   empty    |  | entirely included in ds_agriwanet |
source(paste0(mdl0301, "src/thailand.R"))#                                      done     | x | nso available, not integrated |
source(paste0(mdl0301, "src/timorLeste.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/turkey.R"))#                                        empty    |  | agCensus available, not integrated |
# source(paste0(mdl0301, "src/turkmenistan.R"))                                 empty    |  | entirely included in ds_agriwanet |
source(paste0(mdl0301, "src/unitedArabEmirates.R"))#                            empty    |  |  |
# source(paste0(mdl0301, "src/uzbekistan.R"))                                   empty    |  | entirely included in ds_agriwanet |
source(paste0(mdl0301, "src/vietnam.R"))#                                       empty    |  |  |
source(paste0(mdl0301, "src/yemen.R"))#                                         done     |  | there may be more data available locally |


### europe ----
# source(paste0(mdl0301, "src/albania.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/andorra.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/austria.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/belarus.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/belgium.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/bosniaandHerzegovina.R"))                         empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/bulgaria.R"))                                     empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/croatia.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/czechRepublic.R"))                                empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/denmark.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/estonia.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/finland.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/france.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/germany.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/greece.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/hungary.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/iceland.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/ireland.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/italy.R"))                                        empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/kosovo.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/latvia.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/liechtenstein.R"))                                empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/lithuania.R"))                                    empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/luxembourg.R"))                                   empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/macedonia.R"))                                    empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/malta.R"))                                        empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/moldova.R"))                                      empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/monaco.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/montenegro.R"))                                   empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/norway.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/poland.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/portugal.R"))                                     done     |  | entirely included in ds_eurostat, ine available, not included |
# source(paste0(mdl0301, "src/romania.R"))                                      empty    |  | entirely included in ds_eurostat |
source(paste0(mdl0301, "src/russia.R"))#                                        done     | - |  |
# source(paste0(mdl0301, "src/serbia.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/slovakia.R"))                                     empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/slovenia.R"))                                     empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/spain.R"))                                        empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/sweden.R"))                                       empty    |  | entirely included in ds_eurostat |
# source(paste0(mdl0301, "src/switzerland.R"))                                  empty    |  | entirely included in ds_eurostat |
source(paste0(mdl0301, "src/ukraine.R"))                                       wip      |  |  |
# source(paste0(mdl0301, "src/unitedKingdom.R"))                                empty    |  | entirely included in ds_eurostat |


### oceania ----
source(paste0(mdl0301, "src/australia.R"))#                                     done     |  | spam/agCensus available, not integrated |
source(paste0(mdl0301, "src/fiji.R"))#                                          empty    |  |  |
source(paste0(mdl0301, "src/kiribati.R"))#                                      empty    |  |  |
source(paste0(mdl0301, "src/micronesia.R"))#                                    empty    |  |  |
source(paste0(mdl0301, "src/nauru.R"))#                                         empty    |  |  |
source(paste0(mdl0301, "src/newCaledonia.R"))#                                  empty    |  |  |
source(paste0(mdl0301, "src/newZealand.R"))#                                    issue    |  | error: registering geometries, two schemas need two filters! |
source(paste0(mdl0301, "src/palau.R"))#                                         empty    |  |  |
source(paste0(mdl0301, "src/papuaNewGuinea.R"))#                                empty    |  |  |
source(paste0(mdl0301, "src/samoa.R"))#                                         empty    |  |  |
source(paste0(mdl0301, "src/solomonIslands.R"))#                                empty    |  |  |
source(paste0(mdl0301, "src/tonga.R"))#                                         empty    |  |  |
source(paste0(mdl0301, "src/tuvalu.R"))#                                        empty    |  |  |
source(paste0(mdl0301, "src/vanuatu.R"))#                                       empty    |  |  |


# tie everything together ----
source(paste0(mdl0301, "src/98_make_database.R"))


# and check whether it's all as expected ----
source(paste0(mdl0301, "src/99_test-output.R"))


# finally, update the luckinet-profile ----
profile <- load_profile(root = dataDir, name = model_name, version = model_version)

profile$censusDB_dir <- DB_version
write_profile(root = dataDir, name = model_name, version = model_version,
              parameters = profile)

