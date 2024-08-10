# ----
# title       : build census database
# description : This is the main script for building a database of (national and sub-national) census data for all crop and land-use dimensions of LUCKINet and all livestock dimensions of GPW.
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-03-27
# version     : 0.8.0
# status      : working (luts), working (gpw)
# comment     : file.edit(paste0(dir_docs, "/documentation/03_build_census_database.md"))
# ----

include zigas european dataset: https://zenodo.org/records/11058509

# set module-specific paths ----
#
dir_onto <- .get_path(module = "onto")
dir_census <- .get_path(module = "cens")
dir_census_data <- paste0(dir_census, "_data/")

path_onto <- paste0(dir_onto, "lucki_onto.rds")

# start database or set path of current build ----
#
adb_init(root = dir_census_data, version = paste0(model_name, model_version),
         licence = "https://creativecommons.org/licenses/by-sa/4.0/",
         gazetteer = path_gaz, top = "al1",
         ontology = list("crop" = path_onto, "animal" = path_onto, "use" = path_onto),
         author = list(cre = model_info$authors$cre,
                       aut = model_info$authors$aut$census,
                       ctb = model_info$authors$ctb$census))

build_crops <- model_info$module_use$crops
build_livestock <- model_info$module_use$livestock
build_landuse <- model_info$module_use$landuse

# prepare spatial basis ----
#
# source(paste0(dir_census, "01_setup_gadm.R"))


# build database ----
#
## per dataseries (02) ----
#
### global ----
source(paste0(dir_census, "02_fao.R"))
# source(paste0(dir_census, "02_glw.R"))
# source(paste0(dir_census, "02_countrystat.R"))
# source(paste0(dir_census, "02_unodc.R"))

### regional ----
source(paste0(dir_census, "02_agriwanet.R"))
source(paste0(dir_census, "02_eurostat.R"))

### outdated or redundant with the more detailed data below ----
# source(paste0(dir_census, "X02_agCensus.R"))
# source(paste0(dir_census, "X02_agromaps.R"))
# source(paste0(dir_census, "X02_gaul.R"))
# source(paste0(dir_census, "X02_spam.R"))
# source(paste0(dir_census, "X02_worldbank.R"))

## per nation (03) ----
#
### northern africa ----
source(paste0(dir_census, "03_algeria.R")) wip
source(paste0(dir_census, "03_egypt.R")) wip
source(paste0(dir_census, "03_libya.R")) wip
source(paste0(dir_census, "03_morocco.R")) wip
source(paste0(dir_census, "03_sudan.R")) wip
# source(paste0(dir_census, "03_tunisia.R"))
# source(paste0(dir_census, "03_westernSahara.R"))

### eastern africa ----
# source(paste0(dir_census, "03_burundi.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "X03_comoros.R"))
# source(paste0(dir_census, "X03_djibouti.R"))
# source(paste0(dir_census, "X03_eritrea.R"))
# source(paste0(dir_census, "03_ethiopia.R")) included in 02_countryStat and 02_faoDataLab
# source(paste0(dir_census, "03_kenya.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_madagascar.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_malawi.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "X03_mauritius.R"))
source(paste0(dir_census, "03_mozambique.R")) wip
# source(paste0(dir_census, "03_rwanda.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "X03_seychelles.R"))
# source(paste0(dir_census, "X03_somalia.R"))
# source(paste0(dir_census, "X03_southSudan.R"))
# source(paste0(dir_census, "03_tanzania.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_uganda.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_zambia.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_zimbabwe.R")) entirely included in 02_faoDataLab

### central africa ----
# source(paste0(dir_census, "03_angola.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_cameroon.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "X03_centralAfricanRepublic.R"))
# source(paste0(dir_census, "X03_chad.R"))
# source(paste0(dir_census, "03_republicCongo.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_democraticRepublicCongo.R"))
# source(paste0(dir_census, "X03_equatorialGuinea.R"))
# source(paste0(dir_census, "03_gabon.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "X03_sãoToméPríncipe.R"))

### southern africa ----
# source(paste0(dir_census, "_03_botswana.R"))
# source(paste0(dir_census, "_03_eswatini.R"))
# source(paste0(dir_census, "_03_lesotho.R"))
# source(paste0(dir_census, "03_namibia.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "_03_southAfrica.R"))

### western africa ----
# source(paste0(dir_census, "03_benin.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_burkinaFaso.R")) included in 02_countryStat and 02_faoDataLab
# source(paste0(dir_census, "03_capeVerde.R"))
# source(paste0(dir_census, "03_côtedivoire.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_gambia.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_ghana.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_guinea.R"))
# source(paste0(dir_census, "03_guineaBissau.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_liberia.R"))
# source(paste0(dir_census, "03_mali.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_mauritania.R"))
# source(paste0(dir_census, "03_niger.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_nigeria.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_senegal.R")) included in 02_countryStat and 02_faoDataLab
# source(paste0(dir_census, "03_sierraLeone.R"))
# source(paste0(dir_census, "03_togo.R")) entirely included in 02_countryStat

### northern america ----
source(paste0(dir_census, "03_canada.R")) wip
source(paste0(dir_census, "03_unitedStatesOfAmerica.R"))

### central america ----
# source(paste0(dir_census, "03_belize.R"))
# source(paste0(dir_census, "03_costaRica.R"))
# source(paste0(dir_census, "03_elSalvador.R")) entirely included in 02_faoDataLab
# source(paste0(dir_census, "03_guatemala.R"))
# source(paste0(dir_census, "03_honduras.R"))
source(paste0(dir_census, "03_mexico.R")) wip
# source(paste0(dir_census, "03_nicaragua.R"))
# source(paste0(dir_census, "03_panama.R"))

### carribean ----
# source(paste0(dir_census, "03_antiguaandBarbuda.R"))
# source(paste0(dir_census, "03_bahamas.R"))
# source(paste0(dir_census, "03_barbados.R"))
# source(paste0(dir_census, "03_cuba.R"))
# source(paste0(dir_census, "03_dominica.R"))
# source(paste0(dir_census, "03_dominicanRepublic.R"))
# source(paste0(dir_census, "03_grenada.R"))
# source(paste0(dir_census, "03_haiti.R")) included in 02_countryStat and 02_faoDataLab
# source(paste0(dir_census, "03_jamaica.R"))
# source(paste0(dir_census, "03_saintKittsandNevis.R"))
# source(paste0(dir_census, "03_saintLucia.R"))
# source(paste0(dir_census, "03_saintVincentandtheGrenadines.R"))
# source(paste0(dir_census, "03_trinidadAndTobago.R")) entirely included in 02_faoDataLab

### southern america ----
source(paste0(dir_census, "03_argentina.R"))
source(paste0(dir_census, "03_bolivia.R"))
source(paste0(dir_census, "03_brazil.R"))
# source(paste0(dir_census, "03_chile.R"))
# source(paste0(dir_census, "03_colombia.R")) entirely included in 02_unodc
# source(paste0(dir_census, "03_ecuador.R"))
# source(paste0(dir_census, "03_guyana.R"))
source(paste0(dir_census, "03_paraguay.R")) wip
# source(paste0(dir_census, "03_peru.R")) entirely included in 02_unodc
# source(paste0(dir_census, "03_suriname.R"))
# source(paste0(dir_census, "03_uruguay.R"))
# source(paste0(dir_census, "03_venezuela.R"))

### central asia ----
# source(paste0(dir_census, "03_kazakhstan.R")) entirely included in 02_agriwanet
# source(paste0(dir_census, "03_kygyzstan.R")) entirely included in 02_agriwanet
# source(paste0(dir_census, "03_tajikistan.R")) entirely included in 02_agriwanet
# source(paste0(dir_census, "03_turkmenistan.R")) entirely included in 02_agriwanet
# source(paste0(dir_census, "03_uzbekistan.R")) entirely included in 02_agriwanet

### eastern asia ----
source(paste0(dir_census, "03_china.R")) wip
# source(paste0(dir_census, "03_macao.R"))
source(paste0(dir_census, "03_japan.R")) wip
# source(paste0(dir_census, "03_mongolia.R"))
source(paste0(dir_census, "03_southKorea.R")) wip
# source(paste0(dir_census, "03_northKorea.R"))
source(paste0(dir_census, "03_taiwan.R")) wip

### northern asia ----

### south-eastern asia ----
# source(paste0(dir_census, "03_brunei.R"))
# source(paste0(dir_census, "03_cambodia.R"))
source(paste0(dir_census, "03_indonesia.R")) wip
# source(paste0(dir_census, "03_laos.R")) included in 02_faoDataLab and 02_unodc
source(paste0(dir_census, "_03_malaysia.R")) wip
# source(paste0(dir_census, "03_myanmar.R")) entirely included in 02_unodc
source(paste0(dir_census, "03_philippines.R")) wip
# source(paste0(dir_census, "03_singapore.R"))
source(paste0(dir_census, "03_thailand.R")) wip
# source(paste0(dir_census, "03_timorLeste.R"))
# source(paste0(dir_census, "03_vietnam.R"))

### southern asia ----
# source(paste0(dir_census, "03_afghanistan.R")) included in 02_countryStat and 02_unodc
# source(paste0(dir_census, "_03_bangladesh.R"))
# source(paste0(dir_census, "03_bhutan.R")) entirely included in 02_countryStat
source(paste0(dir_census, "03_india.R"))
# source(paste0(dir_census, "_03_iran.R"))
# source(paste0(dir_census, "_03_maldives.R"))
# source(paste0(dir_census, "_03_nepal.R"))
# source(paste0(dir_census, "03_pakistan.R")) entirely included in 02_faoDataLab
# source(paste0(dir_census, "_03_sriLanka.R"))

### western asia ----
# source(paste0(dir_census, "03_armenia.R"))
# source(paste0(dir_census, "03_azerbaijan.R")) entirely included in 02_countryStat
# source(paste0(dir_census, "03_bahrain.R"))
# source(paste0(dir_census, "03_georgia.R"))
source(paste0(dir_census, "03_iraq.R")) wip
# source(paste0(dir_census, "03_israel.R"))
source(paste0(dir_census, "03_jordan.R")) wip
# source(paste0(dir_census, "03_kuwait.R"))
source(paste0(dir_census, "03_lebanon.R")) wip
# source(paste0(dir_census, "03_oman.R"))
# source(paste0(dir_census, "03_palestine.R"))
# source(paste0(dir_census, "03_qatar.R"))
source(paste0(dir_census, "03_saudiArabia.R")) wip
source(paste0(dir_census, "03_syria.R")) wip
# source(paste0(dir_census, "03_türkiye.R"))
# source(paste0(dir_census, "03_unitedArabEmirates.R"))
# source(paste0(dir_census, "03_yemen.R"))

### eastern europe ----
# source(paste0(dir_census, "_03_belarus.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_bulgaria.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_czechRepublic.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_hungary.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_moldova.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_poland.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_romania.R")) entirely included in 02_eurostat
source(paste0(dir_census, "03_russia.R"))
# source(paste0(dir_census, "_03_slovakia.R")) entirely included in 02_eurostat
source(paste0(dir_census, "_03_ukraine.R")) wip

### northern europe ----
# source(paste0(dir_census, "_03_denmark.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_estonia.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_finland.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_iceland.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_ireland.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_latvia.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_lithuania.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_norway.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_sweden.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_unitedKingdom.R")) entirely included in 02_eurostat

### southern europe ----
# source(paste0(dir_census, "_03_albania.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_andorra.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_bosniaandHerzegovina.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_croatia.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_cyprus.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_greece.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_italy.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_kosovo.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_malta.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_montenegro.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_macedonia.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_portugal.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_serbia.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_slovenia.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_spain.R")) entirely included in 02_eurostat

### western europe ----
# source(paste0(dir_census, "_03_austria.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_belgium.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_france.R")) entirely included in 02_eurostat
source(paste0(dir_census, "03_germany.R"))
# source(paste0(dir_census, "_03_liechtenstein.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_luxembourg.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_monaco.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_netherlands.R")) entirely included in 02_eurostat
# source(paste0(dir_census, "_03_switzerland.R")) entirely included in 02_eurostat

### australia and new zealand ----
source(paste0(dir_census, "03_australia.R"))
source(paste0(dir_census, "03_newZealand.R"))

### melanesia ----
# source(paste0(dir_census, "_03_fiji.R"))
# source(paste0(dir_census, "_03_newCaledonia.R"))
# source(paste0(dir_census, "_03_papuaNewGuinea.R"))
# source(paste0(dir_census, "_03_solomonIslands.R"))
# source(paste0(dir_census, "_03_vanuatu.R"))

### micronesia ----
# source(paste0(dir_census, "_03_kiribati.R"))
# source(paste0(dir_census, "_03_micronesia.R"))
# source(paste0(dir_census, "_03_nauru.R"))
# source(paste0(dir_census, "_03_palau.R"))

### polynesia ----
# source(paste0(dir_census, "_03_samoa.R"))
# source(paste0(dir_census, "_03_tonga.R"))
# source(paste0(dir_census, "_03_tuvalu.R"))


# tie everything together ----
# source(paste0(dir_census, "99_finalise_database.R"))
adb_backup()
adb_archive(outPath = dir_census_data, compress = TRUE)
