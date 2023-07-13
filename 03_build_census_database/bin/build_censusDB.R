# script description ----
#
# This is the main script for building a database of (national and sub-national)
# census data for all crop and livestock commodities and land-use dimensions of
# LUCKINet.


# authors ----
#
# Tsvetelina Tomova, Steffen Ehrmann, Peter Pothmann, Felipe Melges, Abdual, Evegenia, Cheng


# version ----
# 1.0.0 (June 2023)


# script arguments ----
#
currentModule <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))
source(paste0(dirname(currentModule), "/01_boot_framework.R"))


# 1. start database or set path of current build ----
#
start_arealDB(root = censusDBDir,
              gazetteer = gazDir, top = "al1",
              ontology = list("commodity" = ontoDir,
                              "land use" = ontoDir))

# prepare GADM, in case it's not yet available
# source(paste0(mdl0301, "src/01_setup_gadm.R"))


# 2. build database ----
#
# source(paste0(mdl0301, "src/00_template.R"))

## per dataseries ----

source(paste0(mdl0301, "src/02_fao.R"))
source(paste0(mdl0301, "src/02_agriwanet.R"))
source(paste0(mdl0301, "src/02_countrystat.R"))
source(paste0(mdl0301, "src/02_eurostat.R"))
source(paste0(mdl0301, "src/02_unodc.R"))

### outdated or redundant with the more detailed data below ----
# source(paste0(mdl0301, "src/02_agromaps.R"))
# source(paste0(mdl0301, "src/02_agCensus.R"))
# source(paste0(mdl0301, "src/02_spam.R"))
# source(paste0(mdl0301, "src/02_gaul.R"))
# source(paste0(mdl0301, "src/02_worldbank.R"))


## per nation ----
#
source(paste0(mdl0301, "src/03_argentina.R"))
source(paste0(mdl0301, "src/03_bolivia.R"))
source(paste0(mdl0301, "src/03_brazil.R"))
source(paste0(mdl0301, "src/03_paraguay.R"))


### wip ---- (sorted by area of agricultural land)
source(paste0(mdl0301, "src/03_china.R"))
source(paste0(mdl0301, "src/03_unitedStatesOfAmerica.R")) wip
source(paste0(mdl0301, "src/03_australia.R"))
source(paste0(mdl0301, "src/03_russia.R"))
source(paste0(mdl0301, "src/03_india.R"))
source(paste0(mdl0301, "src/03_saudiArabia.R"))                                 loads of gas data available, not fully integrated
source(paste0(mdl0301, "src/03_mongolia.R"))
source(paste0(mdl0301, "src/03_mexico.R"))
source(paste0(mdl0301, "src/03_southAfrica.R"))                                 spam/agCensus available, not integrated
source(paste0(mdl0301, "src/03_nigeria.R"))                                     gCensus available, not integrated
source(paste0(mdl0301, "src/03_sudan.R"))                                       only halfway integrated
source(paste0(mdl0301, "src/03_indonesia.R"))                                   Geometries level 3, when we have numbering system and identical names
source(paste0(mdl0301, "src/03_canada.R"))                                      Removed three tables with units of number for production. One table in the script has "bee colonies" - I think should be removed from script.
source(paste0(mdl0301, "src/03_angola.R"))                                      spam/agCensus/worldbank available, not integrated
source(paste0(mdl0301, "src/03_chad.R"))
source(paste0(mdl0301, "src/03_colombia.R"))                                    spam available, not integrated
source(paste0(mdl0301, "src/03_niger.R"))
source(paste0(mdl0301, "src/03_iran.R"))
source(paste0(mdl0301, "src/03_somalia.R"))
source(paste0(mdl0301, "src/03_ukraine.R"))
source(paste0(mdl0301, "src/03_mozambique.R"))                                  spam/masa available, not integrated









source(paste0(mdl0301, "src/03_belize.R"))                                      spam available, not integrated
source(paste0(mdl0301, "src/03_chile.R"))                                       spam available, not integrated
source(paste0(mdl0301, "src/03_costaRica.R"))                                   spam available, not integrated
source(paste0(mdl0301, "src/03_cuba.R"))                                        spam available, not integrated
source(paste0(mdl0301, "src/03_dominicanRepublic.R"))                           spam available, not integrated
source(paste0(mdl0301, "src/03_ecuador.R"))                                     spam available, not integrated
source(paste0(mdl0301, "src/03_egypt.R"))                                       CAPMAS available, not integrated
source(paste0(mdl0301, "src/03_elSalvador.R"))                                  spam available, not integrated
source(paste0(mdl0301, "src/03_ethiopia.R"))                                    spam/worldbank/csa available, not integrated
source(paste0(mdl0301, "src/03_gabon.R"))                                       Most data is harmonised. ProdCassava and prodBanana are not, because they have different geometries.
source(paste0(mdl0301, "src/03_guatemala.R"))                                   spam available, not integrated
source(paste0(mdl0301, "src/03_haiti.R"))                                       spam available, not integrated
source(paste0(mdl0301, "src/03_honduras.R"))                                    spam available, not integrated
source(paste0(mdl0301, "src/03_jamaica.R"))                                     spam available, not integrated
source(paste0(mdl0301, "src/03_kenya.R"))                                       spam/agCensus available, not integrated; from coutryStat only level 1 are normalised. Level 2 and Level 3 have geometries which mach AgCensus, thus they are not normalised.
source(paste0(mdl0301, "src/03_madagascar.R"))                                  level 1, 2 and 3 are harmonised. Level 4 and 5 are not registered in the gadm gpkg.
source(paste0(mdl0301, "src/03_morocco.R"))                                     maroc-maps available, not integrated, cannabis =ignore
source(paste0(mdl0301, "src/03_nicaragua.R"))                                   spam available, not integrated
source(paste0(mdl0301, "src/03_panama.R"))                                      spam available, not integrated
source(paste0(mdl0301, "src/03_peru.R"))                                        UNODC level 4 is not normalised. spam available, not integrated
source(paste0(mdl0301, "src/03_tanzania.R"))                                    One table does not have clear territories.
source(paste0(mdl0301, "src/03_trinidadAndTobago.R"))                           spam available, not integrated
source(paste0(mdl0301, "src/03_uruguay.R"))                                     spam available, not integrated
source(paste0(mdl0301, "src/03_venezuela.R"))                                   spam available, not integrated
source(paste0(mdl0301, "src/03_afghanistan.R"))
source(paste0(mdl0301, "src/03_algeria.R"))
source(paste0(mdl0301, "src/03_azerbaijan.R"))
source(paste0(mdl0301, "src/03_benin.R"))
source(paste0(mdl0301, "src/03_bhutan.R"))
source(paste0(mdl0301, "src/03_burkinaFaso.R"))
source(paste0(mdl0301, "src/03_burundi.R"))
source(paste0(mdl0301, "src/03_cameroon.R"))
source(paste0(mdl0301, "src/03_côtedivoire.R"))
source(paste0(mdl0301, "src/03_gambia.R"))
source(paste0(mdl0301, "src/03_ghana.R"))
source(paste0(mdl0301, "src/03_guineaBissau.R"))
source(paste0(mdl0301, "src/03_iraq.R"))                                        loads of cso data available, not fully integrated.
source(paste0(mdl0301, "src/03_japan.R"))                                       missing data on livetsock
source(paste0(mdl0301, "src/03_jordan.R"))                                      loads of dos data available, not fully integrated
source(paste0(mdl0301, "src/03_laos.R"))
source(paste0(mdl0301, "src/03_malawi.R"))
source(paste0(mdl0301, "src/03_malaysia.R"))                                    loads of dosm/data.giv.my/midc data available, not fully integrated
source(paste0(mdl0301, "src/03_mali.R"))
source(paste0(mdl0301, "src/03_myanmar.R"))
source(paste0(mdl0301, "src/03_namibia.R"))
source(paste0(mdl0301, "src/03_pakistan.R"))
source(paste0(mdl0301, "src/03_philippines.R"))                                 requires test-normalisation
source(paste0(mdl0301, "src/03_portugal.R"))                                    ine available, not included
source(paste0(mdl0301, "src/03_republicCongo.R"))
source(paste0(mdl0301, "src/03_rwanda.R"))
source(paste0(mdl0301, "src/03_senegal.R"))
source(paste0(mdl0301, "src/03_southKorea.R"))                                  forest data missing, schemas missing
source(paste0(mdl0301, "src/03_syria.R"))                                       requires a lot of work to extract tables (makes sense to develope an automatic routine)
source(paste0(mdl0301, "src/03_taiwan.R"))
source(paste0(mdl0301, "src/03_thailand.R"))                                    nso available, not integrated
source(paste0(mdl0301, "src/03_togo.R"))
source(paste0(mdl0301, "src/03_turkey.R"))                                      agCensus available, not integrated
source(paste0(mdl0301, "src/03_uganda.R"))
source(paste0(mdl0301, "src/03_yemen.R"))                                       there may be more data available locally
source(paste0(mdl0301, "src/03_zambia.R"))
source(paste0(mdl0301, "src/03_zimbabwe.R"))
source(paste0(mdl0301, "src/03_newZealand.R"))                                  error: registering geometries, two schemas need two filters!


  ### empty ----
# source(paste0(mdl0301, "src/03_antiguaandBarbuda.R"))
# source(paste0(mdl0301, "src/03_armenia.R"))
# source(paste0(mdl0301, "src/03_bahamas.R"))
# source(paste0(mdl0301, "src/03_bangladesh.R"))
# source(paste0(mdl0301, "src/03_barbados.R"))
# source(paste0(mdl0301, "src/03_bahrain.R"))
# source(paste0(mdl0301, "src/03_botswana.R"))
# source(paste0(mdl0301, "src/03_brunei.R"))
# source(paste0(mdl0301, "src/03_cambodia.R"))
# source(paste0(mdl0301, "src/03_capeVerde.R"))
# source(paste0(mdl0301, "src/03_centralAfricanRepublic.R"))
# source(paste0(mdl0301, "src/03_comoros.R"))
# source(paste0(mdl0301, "src/03_democraticRepublicCongo.R"))
# source(paste0(mdl0301, "src/03_djibouti.R"))
# source(paste0(mdl0301, "src/03_dominica.R"))
# source(paste0(mdl0301, "src/03_equatorialGuinea.R"))
# source(paste0(mdl0301, "src/03_eritrea.R"))
# source(paste0(mdl0301, "src/03_eswatini.R"))
# source(paste0(mdl0301, "src/03_fiji.R"))
# source(paste0(mdl0301, "src/03_georgia.R"))
# source(paste0(mdl0301, "src/03_grenada.R"))
# source(paste0(mdl0301, "src/03_guinea.R"))
# source(paste0(mdl0301, "src/03_guyana.R"))
# source(paste0(mdl0301, "src/03_israel.R"))
# source(paste0(mdl0301, "src/03_kiribati.R"))
# source(paste0(mdl0301, "src/03_kuwait.R"))
# source(paste0(mdl0301, "src/03_lebanon.R"))
# source(paste0(mdl0301, "src/03_lesotho.R"))
# source(paste0(mdl0301, "src/03_liberia.R"))
# source(paste0(mdl0301, "src/03_libya.R"))
# source(paste0(mdl0301, "src/03_macao.R"))
# source(paste0(mdl0301, "src/03_maldives.R"))
# source(paste0(mdl0301, "src/03_mauritania.R"))
# source(paste0(mdl0301, "src/03_mauritius.R"))
# source(paste0(mdl0301, "src/03_micronesia.R"))
# source(paste0(mdl0301, "src/03_nauru.R"))
# source(paste0(mdl0301, "src/03_nepal.R"))
# source(paste0(mdl0301, "src/03_newCaledonia.R"))
# source(paste0(mdl0301, "src/03_northKorea.R"))
# source(paste0(mdl0301, "src/03_oman.R"))
# source(paste0(mdl0301, "src/03_palau.R"))
# source(paste0(mdl0301, "src/03_palestine.R"))
# source(paste0(mdl0301, "src/03_papuaNewGuinea.R"))
# source(paste0(mdl0301, "src/03_qatar.R"))
# source(paste0(mdl0301, "src/03_saintKittsandNevis.R"))
# source(paste0(mdl0301, "src/03_saintLucia.R"))
# source(paste0(mdl0301, "src/03_saintVincentandtheGrenadines.R"))
# source(paste0(mdl0301, "src/03_samoa.R"))
# source(paste0(mdl0301, "src/03_sãoToméPríncipe.R"))
# source(paste0(mdl0301, "src/03_seychelles.R"))
# source(paste0(mdl0301, "src/03_sierraLeone.R"))
# source(paste0(mdl0301, "src/03_singapore.R"))
# source(paste0(mdl0301, "src/03_solomonIslands.R"))
# source(paste0(mdl0301, "src/03_southSudan.R"))
# source(paste0(mdl0301, "src/03_sriLanka.R"))
# source(paste0(mdl0301, "src/03_suriname.R"))
# source(paste0(mdl0301, "src/03_timorLeste.R"))
# source(paste0(mdl0301, "src/03_tonga.R"))
# source(paste0(mdl0301, "src/03_tunisia.R"))
# source(paste0(mdl0301, "src/03_tuvalu.R"))
# source(paste0(mdl0301, "src/03_unitedArabEmirates.R"))
# source(paste0(mdl0301, "src/03_vanuatu.R"))
# source(paste0(mdl0301, "src/03_vietnam.R"))
# source(paste0(mdl0301, "src/03_westernSahara.R"))

#### entirely included in 02_agriwanet ----
# source(paste0(mdl0301, "src/03_kazakhstan.R"))
# source(paste0(mdl0301, "src/03_kygyzstan.R"))
# source(paste0(mdl0301, "src/03_tajikistan.R"))
# source(paste0(mdl0301, "src/03_turkmenistan.R"))
# source(paste0(mdl0301, "src/03_uzbekistan.R"))

#### entirely included in 02_eurostat ----
# source(paste0(mdl0301, "src/03_albania.R"))
# source(paste0(mdl0301, "src/03_andorra.R"))
# source(paste0(mdl0301, "src/03_austria.R"))
# source(paste0(mdl0301, "src/03_belarus.R"))
# source(paste0(mdl0301, "src/03_belgium.R"))
# source(paste0(mdl0301, "src/03_bosniaandHerzegovina.R"))
# source(paste0(mdl0301, "src/03_bulgaria.R"))
# source(paste0(mdl0301, "src/03_croatia.R"))
# source(paste0(mdl0301, "src/03_czechRepublic.R"))
# source(paste0(mdl0301, "src/03_cyprus.R"))
# source(paste0(mdl0301, "src/03_denmark.R"))
# source(paste0(mdl0301, "src/03_estonia.R"))
# source(paste0(mdl0301, "src/03_finland.R"))
# source(paste0(mdl0301, "src/03_france.R"))
# source(paste0(mdl0301, "src/03_germany.R"))
# source(paste0(mdl0301, "src/03_greece.R"))
# source(paste0(mdl0301, "src/03_hungary.R"))
# source(paste0(mdl0301, "src/03_iceland.R"))
# source(paste0(mdl0301, "src/03_ireland.R"))
# source(paste0(mdl0301, "src/03_italy.R"))
# source(paste0(mdl0301, "src/03_kosovo.R"))
# source(paste0(mdl0301, "src/03_latvia.R"))
# source(paste0(mdl0301, "src/03_liechtenstein.R"))
# source(paste0(mdl0301, "src/03_lithuania.R"))
# source(paste0(mdl0301, "src/03_luxembourg.R"))
# source(paste0(mdl0301, "src/03_macedonia.R"))
# source(paste0(mdl0301, "src/03_malta.R"))
# source(paste0(mdl0301, "src/03_moldova.R"))
# source(paste0(mdl0301, "src/03_monaco.R"))
# source(paste0(mdl0301, "src/03_montenegro.R"))
# source(paste0(mdl0301, "src/03_norway.R"))
# source(paste0(mdl0301, "src/03_poland.R"))
# source(paste0(mdl0301, "src/03_romania.R"))
# source(paste0(mdl0301, "src/03_serbia.R"))
# source(paste0(mdl0301, "src/03_slovakia.R"))
# source(paste0(mdl0301, "src/03_slovenia.R"))
# source(paste0(mdl0301, "src/03_spain.R"))
# source(paste0(mdl0301, "src/03_sweden.R"))
# source(paste0(mdl0301, "src/03_switzerland.R"))
# source(paste0(mdl0301, "src/03_unitedKingdom.R"))


# 3. tie everything together ----
source(paste0(mdl0301, "src/98_make_database.R"))


# 4. and check whether it's all as expected ----
source(paste0(mdl0301, "src/99_test-output.R"))


# 5. finally, update the luckinet-profile ----
profile <- load_profile(root = dataDir, name = model_name, version = model_version)

profile$censusDB_dir <- model_version
write_profile(root = dataDir, name = model_name, version = model_version,
              parameters = profile)

