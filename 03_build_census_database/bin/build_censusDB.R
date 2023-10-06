# script description ----
#
# This is the main script for building a database of (national and sub-national)
# census data for all crop and livestock commodities and land-use dimensions of
# LUCKINet.
currentModule <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))

## authors ----
# Tsvetelina Tomova, Steffen Ehrmann, Peter Pothmann, Felipe Melges,
# Abdual, Evegenia, Cheng

## version ----
# 1.0.0 (June 2023)

## documentation ----
# getOption("viewer")(rmarkdown::render(input = paste0(currentModule, "/README.md")))

## open tasks and change-log ----
# file.edit(paste0(projDocs, "/LUCKINet/milestones/03 build census database.md"))


# 0. setup ----
#
source(paste0(dirname(currentModule), "/01_boot_framework.R"))


# 1. start database or set path of current build ----
#
start_arealDB(root = census_dir,
              gazetteer = gaz_path, top = "al1",
              ontology = list("crop" = onto_path, "animal" = onto_path, "landuse" = onto_path))

# prepare GADM, in case it's not yet available
# source(paste0(mdl0301, "src/01_setup_gadm.R"))


# 2. build database ----
#
# source(paste0(mdl0301, "src/00_template.R"))

## per dataseries (02) ----
#
### global ----
source(paste0(mdl0301, "src/02_fao.R"))
source(paste0(mdl0301, "src/02_glw.R"))
source(paste0(mdl0301, "src/02_countrystat.R"))
source(paste0(mdl0301, "src/02_unodc.R"))

### regional ----
source(paste0(mdl0301, "src/02_agriwanet.R"))
source(paste0(mdl0301, "src/02_eurostat.R"))


### outdated or redundant with the more detailed data below ----
# source(paste0(mdl0301, "src/_02_agromaps.R"))
# source(paste0(mdl0301, "src/_02_agCensus.R"))
# source(paste0(mdl0301, "src/_02_spam.R"))
# source(paste0(mdl0301, "src/_02_gaul.R"))
# source(paste0(mdl0301, "src/_02_worldbank.R"))


## per nation (03) ----
#
### northern africa ----
source(paste0(mdl0301, "src/_03_algeria.R"))
source(paste0(mdl0301, "src/_03_egypt.R"))                                       CAPMAS available, not integrated
# source(paste0(mdl0301, "src/_03_libya.R"))
source(paste0(mdl0301, "src/_03_morocco.R"))                                     maroc-maps available, not integrated, cannabis =ignore
# source(paste0(mdl0301, "src/_03_sudan.R")) wip
# source(paste0(mdl0301, "src/_03_tunisia.R"))
# source(paste0(mdl0301, "src/_03_westernSahara.R"))

### eastern africa ----
source(paste0(mdl0301, "src/_03_burundi.R"))
# source(paste0(mdl0301, "src/_03_comoros.R"))
# source(paste0(mdl0301, "src/_03_djibouti.R"))
# source(paste0(mdl0301, "src/_03_eritrea.R"))
source(paste0(mdl0301, "src/_03_ethiopia.R"))                                    spam/worldbank/csa available, not integrated
source(paste0(mdl0301, "src/_03_kenya.R"))                                       spam/agCensus available, not integrated; from coutryStat only level 1 are normalised. Level 2 and Level 3 have geometries which mach AgCensus, thus they are not normalised.
source(paste0(mdl0301, "src/_03_madagascar.R"))                                  level 1, 2 and 3 are harmonised. Level 4 and 5 are not registered in the gadm gpkg.
source(paste0(mdl0301, "src/_03_malawi.R"))
# source(paste0(mdl0301, "src/_03_mauritius.R"))
# source(paste0(mdl0301, "src/_03_mozambique.R"))
source(paste0(mdl0301, "src/_03_rwanda.R"))
# source(paste0(mdl0301, "src/_03_seychelles.R"))
# source(paste0(mdl0301, "src/_03_somalia.R"))
# source(paste0(mdl0301, "src/_03_southSudan.R"))
source(paste0(mdl0301, "src/_03_uganda.R"))
source(paste0(mdl0301, "src/_03_tanzania.R"))                                    One table does not have clear territories.
source(paste0(mdl0301, "src/_03_zambia.R"))
source(paste0(mdl0301, "src/_03_zimbabwe.R"))

### central africa ----
source(paste0(mdl0301, "src/03_angola.R"))
source(paste0(mdl0301, "src/_03_cameroon.R"))
# source(paste0(mdl0301, "src/_03_centralAfricanRepublic.R"))
# source(paste0(mdl0301, "src/_03_chad.R"))
source(paste0(mdl0301, "src/_03_republicCongo.R"))
# source(paste0(mdl0301, "src/_03_democraticRepublicCongo.R"))
# source(paste0(mdl0301, "src/_03_equatorialGuinea.R"))
source(paste0(mdl0301, "src/_03_gabon.R"))                                       Most data is harmonised. ProdCassava and prodBanana are not, because they have different geometries.
# source(paste0(mdl0301, "src/_03_sãoToméPríncipe.R"))

### southern africa ----
# source(paste0(mdl0301, "src/_03_botswana.R"))
# source(paste0(mdl0301, "src/_03_eswatini.R"))
# source(paste0(mdl0301, "src/_03_lesotho.R"))
source(paste0(mdl0301, "src/_03_namibia.R"))
# source(paste0(mdl0301, "src/_03_southAfrica.R"))

### western africa ----
source(paste0(mdl0301, "src/_03_benin.R"))
source(paste0(mdl0301, "src/_03_burkinaFaso.R"))
# source(paste0(mdl0301, "src/_03_capeVerde.R"))
source(paste0(mdl0301, "src/_03_côtedivoire.R"))
source(paste0(mdl0301, "src/_03_gambia.R"))
source(paste0(mdl0301, "src/_03_ghana.R"))
# source(paste0(mdl0301, "src/_03_guinea.R"))
source(paste0(mdl0301, "src/_03_guineaBissau.R"))
# source(paste0(mdl0301, "src/_03_liberia.R"))
source(paste0(mdl0301, "src/_03_mali.R"))
# source(paste0(mdl0301, "src/_03_mauritania.R"))
source(paste0(mdl0301, "src/03_niger.R"))
source(paste0(mdl0301, "src/03_nigeria.R"))
source(paste0(mdl0301, "src/_03_senegal.R"))
# source(paste0(mdl0301, "src/_03_sierraLeone.R"))
source(paste0(mdl0301, "src/_03_togo.R"))

### northern america ----
source(paste0(mdl0301, "src/_03_canada.R")) wip
source(paste0(mdl0301, "src/_03_unitedStatesOfAmerica.R")) wip

### central america ----
# source(paste0(mdl0301, "src/_03_belize.R"))
# source(paste0(mdl0301, "src/_03_costaRica.R"))
# source(paste0(mdl0301, "src/_03_elSalvador.R"))
# source(paste0(mdl0301, "src/_03_guatemala.R"))
# source(paste0(mdl0301, "src/_03_honduras.R"))
# source(paste0(mdl0301, "src/_03_mexico.R"))
# source(paste0(mdl0301, "src/_03_nicaragua.R"))
# source(paste0(mdl0301, "src/_03_panama.R"))

### carribean ----
# source(paste0(mdl0301, "src/_03_antiguaandBarbuda.R"))
# source(paste0(mdl0301, "src/_03_bahamas.R"))
# source(paste0(mdl0301, "src/_03_barbados.R"))
# source(paste0(mdl0301, "src/_03_cuba.R"))
# source(paste0(mdl0301, "src/_03_dominica.R"))
# source(paste0(mdl0301, "src/_03_dominicanRepublic.R"))
# source(paste0(mdl0301, "src/_03_grenada.R"))
source(paste0(mdl0301, "src/03_haiti.R"))
# source(paste0(mdl0301, "src/_03_jamaica.R"))
# source(paste0(mdl0301, "src/_03_saintKittsandNevis.R"))
# source(paste0(mdl0301, "src/_03_saintLucia.R"))
# source(paste0(mdl0301, "src/_03_saintVincentandtheGrenadines.R"))
source(paste0(mdl0301, "src/_03_trinidadAndTobago.R"))                           spam available, not integrated

### southern america ----
source(paste0(mdl0301, "src/03_argentina.R"))
source(paste0(mdl0301, "src/03_bolivia.R"))
source(paste0(mdl0301, "src/03_brazil.R"))
# source(paste0(mdl0301, "src/_03_chile.R"))
source(paste0(mdl0301, "src/03_colombia.R")) # only unodc so far, needs more data
# source(paste0(mdl0301, "src/_03_ecuador.R"))
# source(paste0(mdl0301, "src/_03_guyana.R"))
source(paste0(mdl0301, "src/03_paraguay.R")) # needs more data
source(paste0(mdl0301, "src/_03_peru.R")) wip
# source(paste0(mdl0301, "src/_03_suriname.R"))
# source(paste0(mdl0301, "src/_03_uruguay.R"))
# source(paste0(mdl0301, "src/_03_venezuela.R"))

### central asia ----
# source(paste0(mdl0301, "src/_03_kazakhstan.R")) entirely included in 02_agriwanet
# source(paste0(mdl0301, "src/_03_kygyzstan.R")) entirely included in 02_agriwanet
# source(paste0(mdl0301, "src/_03_tajikistan.R")) entirely included in 02_agriwanet
# source(paste0(mdl0301, "src/_03_turkmenistan.R")) entirely included in 02_agriwanet
# source(paste0(mdl0301, "src/_03_uzbekistan.R")) entirely included in 02_agriwanet

### eastern asia ----
source(paste0(mdl0301, "src/_03_china.R")) wip
# source(paste0(mdl0301, "src/_03_macao.R"))
source(paste0(mdl0301, "src/_03_japan.R")) missing data on livetsock
# source(paste0(mdl0301, "src/_03_mongolia.R"))
source(paste0(mdl0301, "src/_03_southKorea.R"))                                  forest data missing, schemas missing
# source(paste0(mdl0301, "src/_03_northKorea.R"))
source(paste0(mdl0301, "src/_03_taiwan.R"))

### northern asia ----

### south-eastern asia ----
# source(paste0(mdl0301, "src/_03_brunei.R"))
# source(paste0(mdl0301, "src/_03_cambodia.R"))
# source(paste0(mdl0301, "src/_03_indonesia.R")) Geometries level 3, when we have numbering system and identical names
source(paste0(mdl0301, "src/_03_laos.R"))
source(paste0(mdl0301, "src/_03_malaysia.R")) loads of dosm/data.giv.my/midc data available, not fully integrated
source(paste0(mdl0301, "src/_03_myanmar.R"))
source(paste0(mdl0301, "src/_03_philippines.R")) wip
# source(paste0(mdl0301, "src/_03_singapore.R"))
source(paste0(mdl0301, "src/_03_thailand.R"))                                    nso available, not integrated
# source(paste0(mdl0301, "src/_03_timorLeste.R"))
# source(paste0(mdl0301, "src/_03_vietnam.R"))

### southern asia ----
source(paste0(mdl0301, "src/_03_afghanistan.R"))
# source(paste0(mdl0301, "src/_03_bangladesh.R"))
source(paste0(mdl0301, "src/_03_bhutan.R"))
source(paste0(mdl0301, "src/_03_india.R")) wip
# source(paste0(mdl0301, "src/_03_iran.R"))
# source(paste0(mdl0301, "src/_03_maldives.R"))
# source(paste0(mdl0301, "src/_03_nepal.R"))
source(paste0(mdl0301, "src/_03_pakistan.R"))
# source(paste0(mdl0301, "src/_03_sriLanka.R"))

### western asia ----
source(paste0(mdl0301, "src/_03_turkey.R")) agCensus available, not integrated
# source(paste0(mdl0301, "src/_03_bahrain.R"))
# source(paste0(mdl0301, "src/_03_kuwait.R"))
# source(paste0(mdl0301, "src/_03_oman.R"))
# source(paste0(mdl0301, "src/_03_qatar.R"))
# source(paste0(mdl0301, "src/_03_saudiArabia.R")) loads of gas data available, not fully integrated
# source(paste0(mdl0301, "src/_03_unitedArabEmirates.R"))
source(paste0(mdl0301, "src/_03_yemen.R")) there may be more data available locally
# source(paste0(mdl0301, "src/_03_armenia.R"))
source(paste0(mdl0301, "src/_03_azerbaijan.R"))
# source(paste0(mdl0301, "src/_03_georgia.R"))
source(paste0(mdl0301, "src/_03_iraq.R")) loads of cso data available, not fully integrated.
# source(paste0(mdl0301, "src/_03_israel.R"))
# source(paste0(mdl0301, "src/_03_lebanon.R"))
# source(paste0(mdl0301, "src/_03_palestine.R"))
source(paste0(mdl0301, "src/_03_jordan.R")) loads of dos data available, not fully integrated
source(paste0(mdl0301, "src/_03_syria.R")) requires a lot of work to extract tables (makes sense to develope an automatic routine)

### eastern europe ----
# source(paste0(mdl0301, "src/_03_belarus.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_bulgaria.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_czechRepublic.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_hungary.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_poland.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_moldova.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_romania.R")) entirely included in 02_eurostat
source(paste0(mdl0301, "src/03_russia.R")) # look for some more older data (should be available at lower level)
# source(paste0(mdl0301, "src/_03_slovakia.R")) entirely included in 02_eurostat
source(paste0(mdl0301, "src/_03_ukraine.R")) wip

### northern europe ----
# source(paste0(mdl0301, "src/_03_denmark.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_estonia.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_finland.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_iceland.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_ireland.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_latvia.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_lithuania.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_norway.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_sweden.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_unitedKingdom.R")) entirely included in 02_eurostat

### southern europe ----
# source(paste0(mdl0301, "src/_03_albania.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_andorra.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_bosniaandHerzegovina.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_croatia.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_cyprus.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_greece.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_italy.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_kosovo.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_malta.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_montenegro.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_macedonia.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_portugal.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_serbia.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_slovenia.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_spain.R")) entirely included in 02_eurostat

### western europe ----
# source(paste0(mdl0301, "src/_03_austria.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_belgium.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_france.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_germany.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_liechtenstein.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_luxembourg.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_monaco.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_netherlands.R")) entirely included in 02_eurostat
# source(paste0(mdl0301, "src/_03_switzerland.R")) entirely included in 02_eurostat

### oceania ----
source(paste0(mdl0301, "src/_03_australia.R")) wip
source(paste0(mdl0301, "src/_03_newZealand.R")) wip
# source(paste0(mdl0301, "src/_03_samoa.R"))
# source(paste0(mdl0301, "src/_03_tonga.R"))
# source(paste0(mdl0301, "src/_03_tuvalu.R"))
# source(paste0(mdl0301, "src/_03_palau.R"))
# source(paste0(mdl0301, "src/_03_kiribati.R"))
# source(paste0(mdl0301, "src/_03_micronesia.R"))
# source(paste0(mdl0301, "src/_03_nauru.R"))
# source(paste0(mdl0301, "src/_03_vanuatu.R"))
# source(paste0(mdl0301, "src/_03_solomonIslands.R"))
# source(paste0(mdl0301, "src/_03_papuaNewGuinea.R"))
# source(paste0(mdl0301, "src/_03_fiji.R"))
# source(paste0(mdl0301, "src/_03_newCaledonia.R"))


# 3. tie everything together ----
source(paste0(mdl0301, "src/98_make_database.R"))


# 4. and check whether it's all as expected ----
source(paste0(mdl0301, "src/99_test-output.R"))


# 5. finally, update the luckinet-profile ----
profile <- load_profile(name = model_name, version = model_version)

profile$censusDB_dir <- model_version
write_profile(name = model_name, version = model_version, parameters = profile)

