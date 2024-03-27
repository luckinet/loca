# script description ----
#
# This is the main script for building a database of occurrence/in-situ data for
# all landuse dimensions of LUCKINet.
#
## authors
# Peter Pothmann, Steffen Ehrmann, Caterina Barasso
#
## script version
# 0.0.7
#
## documentation
# file.edit(paste0(dir_docs, "/documentation/05_build_occurrence_database.md"))


# 1. start database and set some meta information ----
#
odb_init(root = dir_occurr, ontology = path_onto)

path_odb_onto <- getOption("ontology_path")

# licenses
# "https://data.jrc.ec.europa.eu/licence/com_reuse"
# "https://www.gnu.org/licenses/gpl-3.0.txt"
# "https://creativecommons.org/licenses/by/4.0/"
# "https://creativecommons.org/licenses/by-nc-sa/3.0/"


# 2. build database ----
#
# source(paste0(dir_mdl05, "src/00_template.R"))
# script                                                       | sort | fix | harmonize | comment
# source(paste0(dir_mdl05, "src/agris2018.R"))                 |      |     | harmonize | forest, experimental
# source(paste0(dir_mdl05, "src/amir1991.R"))                  |      |     | harmonize | crop, wheat
# source(paste0(dir_mdl05, "src/anderson2003.R"))              |      |     | harmonize | crop, general
# source(paste0(dir_mdl05, "src/anderson-teixeira2014.R"))     |      |     | harmonize | forest
# source(paste0(dir_mdl05, "src/anderson-teixeira2018.R"))     |      |     | harmonize | forest
# source(paste0(dir_mdl05, "src/annighöfer2015.R"))            |      |     | harmonize | forest, oak
# source(paste0(dir_mdl05, "src/alemayehu2019.R"))             |      |     | harmonize | general
# source(paste0(dir_mdl05, "src/aleza2018.R"))                 |      |     | harmonize | crop, shea tree
# source(paste0(dir_mdl05, "src/asigbaase2019.R"))             |      |     | harmonize | crop, cocoa-agroforestry
# source(paste0(dir_mdl05, "src/auscovera.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/auscoverb.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/bagchi2017.R"))                |      |     | harmonize |
# source(paste0(dir_mdl05, "src/ballauff2021.R"))              |      |     | harmonize | rubber
source(paste0(dir_mdl05, "src/bastin2017.R"))
# source(paste0(dir_mdl05, "src/batjes2021.R"))                |      |     |           | no commodities -> as they distinguish soil profiles by biome, we should try to find these information and make use of them as "landcover" at least.
# source(paste0(dir_mdl05, "src/bayas2017.R"))                 |      |     | harmonize |
# source(paste0(dir_mdl05, "src/bayas2021.R"))                 |      |     | harmonize |
# source(paste0(dir_mdl05, "src/beenhouwer2013.R"))            |      |     |           | everything needs to be done
# source(paste0(dir_mdl05, "src/beyrs2015.R"))                 |      |     | harmonize | forest, temperate
# source(paste0(dir_mdl05, "src/bigearthnet.R"))               |      |     |           |
# source(paste0(dir_mdl05, "src/biodivinternational.R"))       | sort |     |           |
# source(paste0(dir_mdl05, "src/biota.R"))                     | sort |     |           |
# source(paste0(dir_mdl05, "src/biotime.R"))                   |      |     | harmonize |
# source(paste0(dir_mdl05, "src/bisseleua2013.R"))             |      |     | harmonize | cocoa -> some important meta-data are missing
# source(paste0(dir_mdl05, "src/blaser2018.R"))                |      |     | harmonize | crop, agroforest
# source(paste0(dir_mdl05, "src/bocquet2019.R"))               |      | fix |           | assign all values - part of Radiant MLHub - i skip this for now
# source(paste0(dir_mdl05, "src/bordin2021.R"))                |      |     | harmonize | forest, subtropical
# source(paste0(dir_mdl05, "src/borer2019.R"))                 |      |     | harmonize | grassland
# source(paste0(dir_mdl05, "src/bosch2008.R"))                 |      |     | harmonize | grassland, soil moisture
# source(paste0(dir_mdl05, "src/breizhcrops.R"))               |      |     |           |
# source(paste0(dir_mdl05, "src/bright2019.R"))                |      | fix |           | meta-data and harmonization are missing
# source(paste0(dir_mdl05, "src/broadbent2021.R"))             |      |     | harmonize | grassland, leaf-trait analysis
# source(paste0(dir_mdl05, "src/budburst.R"))                  |      |     | harmonize |
# source(paste0(dir_mdl05, "src/bücker2010.R"))                |      |     | harmonize | forest, tropical montane cloud forest
# source(paste0(dir_mdl05, "src/caci.R"))                      |      |     | harmonize | crop, general
# source(paste0(dir_mdl05, "src/californiaCrops.R"))           |      |     |           | needs a lot of work
# source(paste0(dir_mdl05, "src/camara2019.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/camara2020.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/capaverde2018.R"))             |      |     | harmonize | forest, undisturbed
# source(paste0(dir_mdl05, "src/caughlin2016.R"))              |      |     | harmonize |
# source(paste0(dir_mdl05, "src/cawa.R"))                      |      |     | harmonize |
# source(paste0(dir_mdl05, "src/crain2018.R"))                 |      |     | harmonize | crops, wheat
# source(paste0(dir_mdl05, "src/coleman2008.R"))               |      |     | harmonize | vegetation
# source(paste0(dir_mdl05, "src/conrad2019.R"))                |      | fix |           | meta-data missing
# source(paste0(dir_mdl05, "src/chain-guadarrama2017.R"))      |      |     | harmonize | forest, undisturbed
# source(paste0(dir_mdl05, "src/craven2018.R"))                |      |     | harmonize | forest, hawaii
# source(paste0(dir_mdl05, "src/crowther2019.R"))              |      |     | harmonize | the labels for the points are missing
# source(paste0(dir_mdl05, "src/cv4a.R"))                      |      |     |           |
# source(paste0(dir_mdl05, "src/dataman.R"))                   | sort |     |           |
# source(paste0(dir_mdl05, "src/davila-lara2017.R"))           | sort |     |           |
# source(paste0(dir_mdl05, "src/deblécourt2017.R"))            | sort |     |           |
# source(paste0(dir_mdl05, "src/declercq2012.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/degroote2019.R"))              |      |     | harmonize |
# source(paste0(dir_mdl05, "src/dejonge2014.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/descals2020.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/desousa2020.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/doughty2015.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/drakos2020.R"))                |      |     | harmonize |
# source(paste0(dir_mdl05, "src/dutta2014.R"))                 |      |     |           | everything needs to be done
# source(paste0(dir_mdl05, "src/esc.R"))                       | sort |     |           |
# source(paste0(dir_mdl05, "src/ehbrecht2021.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/ehrmann2017.R"))               |      |     |           | everything needs to be done
# source(paste0(dir_mdl05, "src/empres.R"))                    | sort |     |           |
# source(paste0(dir_mdl05, "src/eurocrops.R"))                 |      |     | harmonize |
# source(paste0(dir_mdl05, "src/eurosat.R"))                   |      |     | harmonize |
# source(paste0(dir_mdl05, "src/falster2015.R"))               |      |     |           | dates are in: baad_metadate.csv, needs extraction by hand
# source(paste0(dir_mdl05, "src/fang2021.R"))                  | sort |     |           |
# source(paste0(dir_mdl05, "src/faye2019.R"))                  | sort |     |           |
# source(paste0(dir_mdl05, "src/feng2022.R"))                  | sort |     |           |
# source(paste0(dir_mdl05, "src/firn2020.R"))                  | sort |     |           |
# source(paste0(dir_mdl05, "src/flores-moreno2017.R"))         | sort |     |           |
# source(paste0(dir_mdl05, "src/forestgeo.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/franklin2015.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/franklin2018.R"))              | sort |     |           |
source(paste0(dir_mdl05, "src/fritz2017.R"))
# source(paste0(dir_mdl05, "src/gafc.R"))                      |      |     |           |
# source(paste0(dir_mdl05, "src/gallhager2017.R"))             | sort |     |           |
# source(paste0(dir_mdl05, "src/gashu2021.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/gbif.R"))                      |      | fix |           | needs to be redone
# source(paste0(dir_mdl05, "src/gebert2019.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/genesys.R"))                   |      |     | harmonize |
# source(paste0(dir_mdl05, "src/gfsad30.R"))                   |      |     | harmonize |
# source(paste0(dir_mdl05, "src/gibson2011.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/glato2017.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/globe.R"))                     |      |     | harmonize |
# source(paste0(dir_mdl05, "src/gofc-gold.R"))                 |      |     | harmonize |
# source(paste0(dir_mdl05, "src/grosso2013.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/grump.R"))                     | sort |     |           |
# source(paste0(dir_mdl05, "src/guitet2015.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/gyga.R"))                      |      |     | harmonize |
# source(paste0(dir_mdl05, "src/haarhoff2019.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/habel2020.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/haeni2016.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/hardy2019.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/hengl2020.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/hilpold2018.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/hoffman2019.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/hogan2018.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/hudson2016.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/hunt2013.R"))                  |      | fix |           | everything needs to be done
# source(paste0(dir_mdl05, "src/hylander2018.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/infys.R"))                     | sort |     |           |
# source(paste0(dir_mdl05, "src/ingrisch2014.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/iscn.R"))                      |      |     | harmonize | assign all values
# source(paste0(dir_mdl05, "src/jackson2021.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/jin2021.R"))                   |      | fix |           | everything needs to be done
# source(paste0(dir_mdl05, "src/jolivot2021.R"))               |      |     | harmonize |
# source(paste0(dir_mdl05, "src/jonas2020.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/jordan2020.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/juergens2012.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/jung2016.R"))                  | sort |     |           |
# source(paste0(dir_mdl05, "src/karlsson2017.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/kebede2019.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/kenefic2015.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/kenefic2019.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/kim2020.R"))                   |      | fix |           | this may be problematic because apparently the coordinates indicate only a region, not the actual plots
# source(paste0(dir_mdl05, "src/knapp2021.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/kormann2018.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/koskinen2018.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/krause2021.R"))                |      | fix |           | only peatland -> but this is def. also needed and it is part of the ontology
# source(paste0(dir_mdl05, "src/lamond2014.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/landpks.R"))                   | sort |     |           |
# source(paste0(dir_mdl05, "src/lauenroth2019.R"))             | sort |     |           |
# source(paste0(dir_mdl05, "src/lasky2015.R"))                 |      | fix |           | everything needs to be done
# source(paste0(dir_mdl05, "src/ledig2019.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/ledo2019.R"))                  | sort |     |           |
# source(paste0(dir_mdl05, "src/leduc2021.R"))                 | sort |     |           |
source(paste0(dir_mdl05, "src/lesiv2020.R"))
# source(paste0(dir_mdl05, "src/li2018.R"))                    | sort |     |           |
# source(paste0(dir_mdl05, "src/llorente2018.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/lpis.R"))                      |      |     | harmonize |
source(paste0(dir_mdl05, "src/lucas.R"))
# source(paste0(dir_mdl05, "src/maas2015.R"))                  | sort |     |           |
# source(paste0(dir_mdl05, "src/mandal2016.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/mapbiomas.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/marin2013.R"))                 |      | fix |           | conversion of coordinates to decimal needed
# source(paste0(dir_mdl05, "src/martinezsanchez2024.R"))       |      |     | harmonize |
# source(paste0(dir_mdl05, "src/mchairn2014.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/mchairn2021.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/mckee2015.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/meddens2017.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/mendoza2016.R"))               |      |     | harmonize |
# source(paste0(dir_mdl05, "src/merschel2014.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/mgap.R"))                      | sort |     |           |
# source(paste0(dir_mdl05, "src/mitchard2014.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/moghaddam2014.R"))             | sort |     |           |
# source(paste0(dir_mdl05, "src/monro2017.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/moonlight2020.R"))             | sort |     |           |
# source(paste0(dir_mdl05, "src/nalley2020.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/nthiwa2020.R"))                |      | fix |           | some meta-data missing
# source(paste0(dir_mdl05, "src/nyirambangutse2017.R"))        | sort |     |           |
# source(paste0(dir_mdl05, "src/ofsa.R"))                      | sort |     |           |
# source(paste0(dir_mdl05, "src/ogle2007.R"))                  | sort |     |           |
# source(paste0(dir_mdl05, "src/oldfield2018.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/oliva2020.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/osm.R"))                       |      | fix |           | where is the folder?
# source(paste0(dir_mdl05, "src/osuri2019.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/oswald2016.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/ouedraogo2016.R"))             | sort |     |           |
# source(paste0(dir_mdl05, "src/pärn2018.R"))                  | sort |     |           |
# source(paste0(dir_mdl05, "src/pennington.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/perrino2012.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/piponiot2016.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/plantvillage.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/ploton2020.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/potapov2021.R"))               |      |     | harmonize |
# source(paste0(dir_mdl05, "src/quisehuatl-medina2020.R"))     | sort |     |           |
# source(paste0(dir_mdl05, "src/raley2017.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/raman2006.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/ramos-fabiel2018.R"))          |      | fix |           | coordinates and target variable seems to be missing?!
# source(paste0(dir_mdl05, "src/ratnam2019.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/raymundo2018.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/reiner2018.R"))                |      | fix |           | everything missing
# source(paste0(dir_mdl05, "src/rineer2021.R"))                |      | fix |           | everything needs to be done
# source(paste0(dir_mdl05, "src/robichaud2017.R"))             | sort |     |           |
# source(paste0(dir_mdl05, "src/roman2021.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/samples.R"))                   | sort |     |           |
# source(paste0(dir_mdl05, "src/sanches2018.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/sanchez-azofeita2017.R"))      | sort |     |           |
# source(paste0(dir_mdl05, "src/schepaschenko.R"))             |      |     | harmonize |
# source(paste0(dir_mdl05, "src/schneider2020.R"))             | sort |     |           |
# source(paste0(dir_mdl05, "src/schooley2005.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/see2016.R"))                   |      |     | harmonize |
# source(paste0(dir_mdl05, "src/see2022.R"))                   |      |     | harmonize |
# source(paste0(dir_mdl05, "src/sen4cap.R"))                   |      | fix |           |
# source(paste0(dir_mdl05, "src/seo2014.R"))                   | sort |     |           |
# source(paste0(dir_mdl05, "src/shooner2018.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/silva2019.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/sinasson2016.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/splot.R"))                     |      |     |           | clarify which values to use
# source(paste0(dir_mdl05, "src/srdb.R"))                      | sort |     |           |
# source(paste0(dir_mdl05, "src/stanimirova2023.R"))           |      |     | harmonize |
# source(paste0(dir_mdl05, "src/stevens2011.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/sullivan2018.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/surendra2021.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/szantoi2020.R"))               |      |     | harmonize |
# source(paste0(dir_mdl05, "src/szantoi2021.R"))               |      |     | harmonize |
# source(paste0(dir_mdl05, "src/szyniszewska2019.R"))          | sort |     |           |
# source(paste0(dir_mdl05, "src/tateishi2014.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/tedonzong2021.R"))             | sort |     |           |
# source(paste0(dir_mdl05, "src/teixeira2015.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/thornton2014.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/trettin2017.R"))               |      | fix |           | some metadata missing
# source(paste0(dir_mdl05, "src/truckenbrodt2017.R"))          | sort |     |           |
# source(paste0(dir_mdl05, "src/vanhooft2015.R"))              |      | fix |           | meta-data missing
# source(paste0(dir_mdl05, "src/vieilledent2016.R"))           | sort |     |           |
# source(paste0(dir_mdl05, "src/vijay2016.R"))                 | sort |     |           |
# source(paste0(dir_mdl05, "src/vilanova2018.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/weber2011.R"))                 |      | fix |           | meta-data missing
# source(paste0(dir_mdl05, "src/wei2018.R"))                   | sort |     |           |
# source(paste0(dir_mdl05, "src/wenden2016.R"))                | sort |     |           |
# source(paste0(dir_mdl05, "src/westengen2014.R"))             | sort |     |           |
# source(paste0(dir_mdl05, "src/wood2016.R"))                  | sort |     |           |
# source(paste0(dir_mdl05, "src/woollen2017.R"))               | sort |     |           |
# source(paste0(dir_mdl05, "src/wortmann2019.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/wortmann2020.R"))              | sort |     |           |
# source(paste0(dir_mdl05, "src/zhang1999.R"))                 |      | fix |           | sp


# 3. tie everything together ----
source(paste0(dir_mdl05, "src/99_make_database.R"))


# 4. and check whether it's all as expected ----
source(paste0(dir_mdl05, "src/99_test-output.R"))


# 5. finally, update the luckinet-profile ----
profile <- load_profile(name = model_name, version = model_version)

profile$occurrenceDB <- DB_version
write_profile(name = model_name, version = model_version, parameters = profile)




# 98. scrutinise issue and make a decision:
#
## time periods missing ----
# source(paste0(dir_mdl05, "src/adina2017.R"))
# source(paste0(dir_mdl05, "src/alvarez-davila2017.R")) 200 -forest- needs clarification (mail)
# source(paste0(dir_mdl05, "src/bauters2019.R"))        15 -forest-
# source(paste0(dir_mdl05, "src/chaudhary2016.R"))      1008 -forest-
# source(paste0(dir_mdl05, "src/döbert2017.R"))         180 -forest-
# source(paste0(dir_mdl05, "src/draper2021.R"))         1240 -forest-
# source(paste0(dir_mdl05, "src/ibanez2018.R"))         434 -forest-
# source(paste0(dir_mdl05, "src/ibanez2020.R"))         51 -forest-
# source(paste0(dir_mdl05, "src/keil2019.R"))
# source(paste0(dir_mdl05, "src/lewis2013.R"))          260 -forest-
# source(paste0(dir_mdl05, "src/menge2019.R"))          44 -forest-
# source(paste0(dir_mdl05, "src/morera-beita2019.R"))   20 -forest-
# source(paste0(dir_mdl05, "src/parizzi2017.R"))
# source(paste0(dir_mdl05, "src/potts2017.R"))
# source(paste0(dir_mdl05, "src/sankaran2007.R"))       854 -forest-
# source(paste0(dir_mdl05, "src/sarti2020.R"))
# source(paste0(dir_mdl05, "src/scarcelli2019.R"))      168 -yam-
# source(paste0(dir_mdl05, "src/trettin2020.R"))        17 -mangrove-
# source(paste0(dir_mdl05, "src/zhao2014.R"))           2897 -cropland-
#
## hard to get data ----
# source(paste0(dir_mdl05, "src/ausplots.R")) some of the Vegetation-Communities_*.csv files could be interesting, but I think it's quite the hassle to extract these data and harmonize them with the ontology
# source(paste0(dir_mdl05, "src/ma2020.R")) read data from pdf
# source(paste0(dir_mdl05, "src/timesen2crop.R")) coordinates not readily available
#
## data need to be sampled from GeoTiff ----
# source(paste0(dir_mdl05, "src/wcda.R"))
# source(paste0(dir_mdl05, "src/xu2020.R"))
# https://github.com/corentin-dfg/Satellite-Image-Time-Series-Datasets




## final decision reached (here only with reason for exclusion) ----
sort into "03 build occurrence database.md"
# Sheils2019      missing cor now in contact authors
# OBrian2019      missing cor of plots --> moved to discarded
# Waha2016        no explicit spatial data available that go beyond admin level 2 of the GADM dataset
# wang2020        only experiment site coordinates, not on plot level - has many grazing data with coordinates and dates available
# liangyun2019    this is a reinterpretation of GOFC-GOLD and GFSAD30 datasets to the LCCS, which is thus unsuitable for us, since we'd have to reinterpret the reinterpretation, when we can instead work with GOFC-GOLD --> no it is more then that i think, they also use water LC data of WWF, do u want me to put it to review?
# reetsch2020     coordinates of farms (houshold survey) not the actual fields
# conabio         this seems to be primarily on the number of plant occurrences, and I don't see a way to easily extract information on landcover or even land use
