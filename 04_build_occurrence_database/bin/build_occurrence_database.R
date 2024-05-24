# ----
# title        : build occurrence database (module 5)
# version      : 0.7.0
# description  : This is the main script for building a database of occurrence/in-situ data for all land-use dimensions of LUCKINet.
# license      : https://creativecommons.org/licenses/by-sa/4.0/
# authors      : Peter Pothmann, Steffen Ehrmann, Caterina Barasso
# date         : 2024-03-27
# documentation: file.edit(paste0(dir_docs, "/documentation/04_build_occurrence_database.md"))
# ----

# 1. start database and set some meta information ----
#
odb_init(root = dir_occurr_wip, ontology = path_onto)

check out all the other european countries that are not yet in "EuroCrops/Schneider2023": https://agridata.ec.europa.eu/extensions/iacs/iacs.html

# licenses
# https://data.jrc.ec.europa.eu/licence/com_reuse
# https://www.gnu.org/licenses/gpl-3.0.txt
# https://creativecommons.org/licenses/by/4.0/
# https://creativecommons.org/licenses/by-nc-sa/3.0/
# https://creativecommons.org/publicdomain/zero/1.0

# 2. build database ----
#
# source(paste0(dir_occur_mdl, "src/00_template.R"))
#
# source(paste0(dir_occur_mdl, "src/agris2018.R"))
# source(paste0(dir_occur_mdl, "src/alemayehu2019.R"))
# source(paste0(dir_occur_mdl, "src/aleza2018.R"))
# source(paste0(dir_occur_mdl, "src/amir1991.R"))
# source(paste0(dir_occur_mdl, "src/anderson-teixeira2014.R"))
# source(paste0(dir_occur_mdl, "src/anderson-teixeira2018.R"))
# source(paste0(dir_occur_mdl, "src/anderson2003.R"))
# source(paste0(dir_occur_mdl, "src/annighöfer2015.R"))
# source(paste0(dir_occur_mdl, "src/asigbaase2019.R"))
# source(paste0(dir_occur_mdl, "src/auscovera.R"))
# source(paste0(dir_occur_mdl, "src/auscoverb.R"))
# source(paste0(dir_occur_mdl, "src/ausplots.R"))
# source(paste0(dir_occur_mdl, "src/bagchi2017.R"))
# source(paste0(dir_occur_mdl, "src/ballauff2021.R"))
source(paste0(dir_occur_mdl, "src/bastin2017.R"))
# source(paste0(dir_occur_mdl, "src/batjes2021.R"))
source(paste0(dir_occur_mdl, "src/bayas2017.R"))
source(paste0(dir_occur_mdl, "src/bayas2021.R"))
# source(paste0(dir_occur_mdl, "src/beenhouwer2013.R"))
# source(paste0(dir_occur_mdl, "src/beyrs2015.R"))
# source(paste0(dir_occur_mdl, "src/bigearthnet.R"))
# source(paste0(dir_occur_mdl, "src/biodivinternational.R"))
# source(paste0(dir_occur_mdl, "src/biota.R"))
# source(paste0(dir_occur_mdl, "src/biotime.R"))
# source(paste0(dir_occur_mdl, "src/bisseleua2013.R"))
# source(paste0(dir_occur_mdl, "src/blaser2018.R"))
# source(paste0(dir_occur_mdl, "src/bocquet2019.R"))
# source(paste0(dir_occur_mdl, "src/bordin2021.R"))
# source(paste0(dir_occur_mdl, "src/borer2019.R"))
# source(paste0(dir_occur_mdl, "src/bosch2008.R"))
# source(paste0(dir_occur_mdl, "src/bright2019.R"))
# source(paste0(dir_occur_mdl, "src/broadbent2021.R"))
# source(paste0(dir_occur_mdl, "src/bücker2010.R"))
# source(paste0(dir_occur_mdl, "src/budburst.R"))
# source(paste0(dir_occur_mdl, "src/caci.R"))
# source(paste0(dir_occur_mdl, "src/californiaCrops.R"))
# source(paste0(dir_occur_mdl, "src/camara2019.R"))
# source(paste0(dir_occur_mdl, "src/camara2020.R"))
# source(paste0(dir_occur_mdl, "src/capaverde2018.R"))
# source(paste0(dir_occur_mdl, "src/caughlin2016.R"))
# source(paste0(dir_occur_mdl, "src/cawa.R"))
# source(paste0(dir_occur_mdl, "src/crain2018.R"))
# source(paste0(dir_occur_mdl, "src/coleman2008.R"))
# source(paste0(dir_occur_mdl, "src/conrad2019.R"))
# source(paste0(dir_occur_mdl, "src/chain-guadarrama2017.R"))
# source(paste0(dir_occur_mdl, "src/craven2018.R"))
source(paste0(dir_occur_mdl, "src/cropharvest.R"))
# source(paste0(dir_occur_mdl, "src/crowther2019.R"))
# source(paste0(dir_occur_mdl, "src/cv4a.R"))
# source(paste0(dir_occur_mdl, "src/dataman.R"))
# source(paste0(dir_occur_mdl, "src/davila-lara2017.R"))
# source(paste0(dir_occur_mdl, "src/deblécourt2017.R"))
# source(paste0(dir_occur_mdl, "src/declercq2012.R"))
# source(paste0(dir_occur_mdl, "src/degroote2019.R"))
# source(paste0(dir_occur_mdl, "src/dejonge2014.R"))
# source(paste0(dir_occur_mdl, "src/descals2020.R"))
# source(paste0(dir_occur_mdl, "src/desousa2020.R"))
# source(paste0(dir_occur_mdl, "src/doughty2015.R"))
# source(paste0(dir_occur_mdl, "src/drakos2020.R"))
# source(paste0(dir_occur_mdl, "src/dutta2014.R"))
# source(paste0(dir_occur_mdl, "src/esc.R"))
# source(paste0(dir_occur_mdl, "src/ehbrecht2021.R"))
source(paste0(dir_occur_mdl, "src/ehrmann2017.R"))
# source(paste0(dir_occur_mdl, "src/empres.R"))
source(paste0(dir_occur_mdl, "src/eurosat.R"))
# source(paste0(dir_occur_mdl, "src/falster2015.R"))
# source(paste0(dir_occur_mdl, "src/fang2021.R"))
# source(paste0(dir_occur_mdl, "src/faye2019.R"))
# source(paste0(dir_occur_mdl, "src/feng2022.R"))
# source(paste0(dir_occur_mdl, "src/firn2020.R"))
# source(paste0(dir_occur_mdl, "src/flores-moreno2017.R"))
# source(paste0(dir_occur_mdl, "src/forestgeo.R"))
# source(paste0(dir_occur_mdl, "src/franklin2015.R"))
# source(paste0(dir_occur_mdl, "src/franklin2018.R"))
source(paste0(dir_occur_mdl, "src/fritz2017.R"))
# source(paste0(dir_occur_mdl, "src/gafc.R"))
# source(paste0(dir_occur_mdl, "src/gallhager2017.R"))
source(paste0(dir_occur_mdl, "src/garcia2022.R"))
# source(paste0(dir_occur_mdl, "src/gashu2021.R"))
# source(paste0(dir_occur_mdl, "src/gbif.R"))
# source(paste0(dir_occur_mdl, "src/gebert2019.R"))
# source(paste0(dir_occur_mdl, "src/genesys.R"))
source(paste0(dir_occur_mdl, "src/gfsad30.R"))
# source(paste0(dir_occur_mdl, "src/gibson2011.R"))
# source(paste0(dir_occur_mdl, "src/glato2017.R"))
# source(paste0(dir_occur_mdl, "src/globe.R"))
source(paste0(dir_occur_mdl, "src/gofc-gold.R"))
# source(paste0(dir_occur_mdl, "src/grosso2013.R"))
# source(paste0(dir_occur_mdl, "src/grump.R"))
# source(paste0(dir_occur_mdl, "src/guitet2015.R"))
# source(paste0(dir_occur_mdl, "src/gyga.R"))
# source(paste0(dir_occur_mdl, "src/haarhoff2019.R"))
# source(paste0(dir_occur_mdl, "src/habel2020.R"))
# source(paste0(dir_occur_mdl, "src/haeni2016.R"))
# source(paste0(dir_occur_mdl, "src/hardy2019.R"))
# source(paste0(dir_occur_mdl, "src/hengl2020.R"))
# source(paste0(dir_occur_mdl, "src/hilpold2018.R"))
# source(paste0(dir_occur_mdl, "src/hoffman2019.R"))
# source(paste0(dir_occur_mdl, "src/hogan2018.R"))
# source(paste0(dir_occur_mdl, "src/hudson2016.R"))
# source(paste0(dir_occur_mdl, "src/hunt2013.R"))
# source(paste0(dir_occur_mdl, "src/hylander2018.R"))
# source(paste0(dir_occur_mdl, "src/infys.R"))
# source(paste0(dir_occur_mdl, "src/ingrisch2014.R"))
# source(paste0(dir_occur_mdl, "src/iscn.R"))
# source(paste0(dir_occur_mdl, "src/jackson2021.R"))
# source(paste0(dir_occur_mdl, "src/jin2021.R"))
source(paste0(dir_occur_mdl, "src/jolivot2021.R"))
# source(paste0(dir_occur_mdl, "src/jonas2020.R"))
# source(paste0(dir_occur_mdl, "src/jordan2020.R"))
# source(paste0(dir_occur_mdl, "src/juergens2012.R"))
# source(paste0(dir_occur_mdl, "src/jung2016.R"))
# source(paste0(dir_occur_mdl, "src/karlsson2017.R"))
# source(paste0(dir_occur_mdl, "src/kebede2019.R"))
# source(paste0(dir_occur_mdl, "src/kenefic2015.R"))
# source(paste0(dir_occur_mdl, "src/kenefic2019.R"))
# source(paste0(dir_occur_mdl, "src/kim2020.R"))                   | this may be problematic because apparently the coordinates indicate only a region, not the actual plots
# source(paste0(dir_occur_mdl, "src/knapp2021.R"))
# source(paste0(dir_occur_mdl, "src/kormann2018.R"))
# source(paste0(dir_occur_mdl, "src/koskinen2018.R"))
# source(paste0(dir_occur_mdl, "src/krause2021.R"))                | only peatland -> but this is def. also needed and it is part of the ontology
# source(paste0(dir_occur_mdl, "src/lamond2014.R"))
# source(paste0(dir_occur_mdl, "src/landpks.R"))
# source(paste0(dir_occur_mdl, "src/lauenroth2019.R"))
# source(paste0(dir_occur_mdl, "src/lasky2015.R"))
# source(paste0(dir_occur_mdl, "src/ledig2019.R"))
# source(paste0(dir_occur_mdl, "src/ledo2019.R"))
# source(paste0(dir_occur_mdl, "src/leduc2021.R"))
source(paste0(dir_occur_mdl, "src/lesiv2020.R"))
# source(paste0(dir_occur_mdl, "src/li2018.R"))
# source(paste0(dir_occur_mdl, "src/llorente2018.R"))
source(paste0(dir_occur_mdl, "src/lpis_austria.R"))
source(paste0(dir_occur_mdl, "src/lpis_czechia.R"))
source(paste0(dir_occur_mdl, "src/lpis_denmark.R"))
source(paste0(dir_occur_mdl, "src/lpis_estonia.R"))
source(paste0(dir_occur_mdl, "src/lpis_latvia.R"))
source(paste0(dir_occur_mdl, "src/lpis_slovakia.R"))
source(paste0(dir_occur_mdl, "src/lpis_slovenia.R"))
source(paste0(dir_occur_mdl, "src/lucas.R"))
# source(paste0(dir_occur_mdl, "src/maas2015.R"))
# source(paste0(dir_occur_mdl, "src/mandal2016.R"))
# source(paste0(dir_occur_mdl, "src/mapbiomas.R"))
# source(paste0(dir_occur_mdl, "src/marin2013.R"))                 | conversion of coordinates to decimal needed
# source(paste0(dir_occur_mdl, "src/martinezsanchez2024.R"))
# source(paste0(dir_occur_mdl, "src/mchairn2014.R"))
# source(paste0(dir_occur_mdl, "src/mchairn2021.R"))
# source(paste0(dir_occur_mdl, "src/mckee2015.R"))
# source(paste0(dir_occur_mdl, "src/meddens2017.R"))
# source(paste0(dir_occur_mdl, "src/mendoza2016.R"))
# source(paste0(dir_occur_mdl, "src/merschel2014.R"))
# source(paste0(dir_occur_mdl, "src/mgap.R"))
# source(paste0(dir_occur_mdl, "src/mitchard2014.R"))
# source(paste0(dir_occur_mdl, "src/moghaddam2014.R"))
# source(paste0(dir_occur_mdl, "src/monro2017.R"))
# source(paste0(dir_occur_mdl, "src/moonlight2020.R"))
# source(paste0(dir_occur_mdl, "src/nalley2020.R"))
# source(paste0(dir_occur_mdl, "src/nthiwa2020.R"))                | some meta-data missing
# source(paste0(dir_occur_mdl, "src/nyirambangutse2017.R"))
# source(paste0(dir_occur_mdl, "src/ofsa.R"))
# source(paste0(dir_occur_mdl, "src/ogle2007.R"))
# source(paste0(dir_occur_mdl, "src/oldfield2018.R"))
# source(paste0(dir_occur_mdl, "src/oliva2020.R"))
# source(paste0(dir_occur_mdl, "src/osm.R"))                       | where is the folder?
# source(paste0(dir_occur_mdl, "src/osuri2019.R"))
# source(paste0(dir_occur_mdl, "src/oswald2016.R"))
# source(paste0(dir_occur_mdl, "src/ouedraogo2016.R"))
# source(paste0(dir_occur_mdl, "src/pärn2018.R"))
# source(paste0(dir_occur_mdl, "src/pennington.R"))
# source(paste0(dir_occur_mdl, "src/perrino2012.R"))
# source(paste0(dir_occur_mdl, "src/piponiot2016.R"))
# source(paste0(dir_occur_mdl, "src/plantvillage.R"))
# source(paste0(dir_occur_mdl, "src/ploton2020.R"))
# source(paste0(dir_occur_mdl, "src/potapov2021.R"))
# source(paste0(dir_occur_mdl, "src/quisehuatl-medina2020.R"))
# source(paste0(dir_occur_mdl, "src/raley2017.R"))
# source(paste0(dir_occur_mdl, "src/raman2006.R"))
# source(paste0(dir_occur_mdl, "src/ramos-fabiel2018.R"))          | coordinates and target variable seems to be missing?!
# source(paste0(dir_occur_mdl, "src/ratnam2019.R"))
# source(paste0(dir_occur_mdl, "src/raymundo2018.R"))
# source(paste0(dir_occur_mdl, "src/reiner2018.R"))
source(paste0(dir_occur_mdl, "src/remelgado2020.R"))
# source(paste0(dir_occur_mdl, "src/rineer2021.R"))
# source(paste0(dir_occur_mdl, "src/robichaud2017.R"))
# source(paste0(dir_occur_mdl, "src/roman2021.R"))
source(paste0(dir_occur_mdl, "src/rpg_france.R"))
source(paste0(dir_occur_mdl, "src/rußwurm2020.R"))
# source(paste0(dir_occur_mdl, "src/samples.R"))
# source(paste0(dir_occur_mdl, "src/sanches2018.R"))
# source(paste0(dir_occur_mdl, "src/sanchez-azofeita2017.R"))
source(paste0(dir_occur_mdl, "src/schepaschenko.R"))
# source(paste0(dir_occur_mdl, "src/schneider2020.R"))
source(paste0(dir_occur_mdl, "src/schneider2023.R"))
# source(paste0(dir_occur_mdl, "src/schooley2005.R"))
# source(paste0(dir_occur_mdl, "src/schulze2020.R"))
# source(paste0(dir_occur_mdl, "src/schulze2023.R"))
source(paste0(dir_occur_mdl, "src/see2016.R"))
source(paste0(dir_occur_mdl, "src/see2022.R"))
# source(paste0(dir_occur_mdl, "src/sen4cap.R"))
# source(paste0(dir_occur_mdl, "src/seo2014.R"))
# source(paste0(dir_occur_mdl, "src/shooner2018.R"))
# source(paste0(dir_occur_mdl, "src/silva2019.R"))
# source(paste0(dir_occur_mdl, "src/sinasson2016.R"))
# source(paste0(dir_occur_mdl, "src/splot.R"))                     | clarify which values to use
# source(paste0(dir_occur_mdl, "src/srdb.R"))
source(paste0(dir_occur_mdl, "src/stanimirova2023.R"))
# source(paste0(dir_occur_mdl, "src/stevens2011.R"))
# source(paste0(dir_occur_mdl, "src/sullivan2018.R"))
# source(paste0(dir_occur_mdl, "src/surendra2021.R"))
source(paste0(dir_occur_mdl, "src/szantoi2020.R"))
source(paste0(dir_occur_mdl, "src/szantoi2021.R"))
# source(paste0(dir_occur_mdl, "src/szyniszewska2019.R"))
# source(paste0(dir_occur_mdl, "src/tateishi2014.R"))
# source(paste0(dir_occur_mdl, "src/tedonzong2021.R"))
# source(paste0(dir_occur_mdl, "src/teixeira2015.R"))
# source(paste0(dir_occur_mdl, "src/thornton2014.R"))
# source(paste0(dir_occur_mdl, "src/trettin2017.R"))               | some metadata missing
# source(paste0(dir_occur_mdl, "src/truckenbrodt2017.R"))
# source(paste0(dir_occur_mdl, "src/vanhooft2015.R"))              | meta-data missing
# source(paste0(dir_occur_mdl, "src/vieilledent2016.R"))
# source(paste0(dir_occur_mdl, "src/vijay2016.R"))
# source(paste0(dir_occur_mdl, "src/vilanova2018.R"))
# source(paste0(dir_occur_mdl, "src/weber2011.R"))                 | meta-data missing
# source(paste0(dir_occur_mdl, "src/wei2018.R"))
# source(paste0(dir_occur_mdl, "src/wenden2016.R"))
# source(paste0(dir_occur_mdl, "src/westengen2014.R"))
# source(paste0(dir_occur_mdl, "src/wood2016.R"))
# source(paste0(dir_occur_mdl, "src/woollen2017.R"))
# source(paste0(dir_occur_mdl, "src/wortmann2019.R"))
# source(paste0(dir_occur_mdl, "src/wortmann2020.R"))
# source(paste0(dir_occur_mdl, "src/zhang1999.R"))

# 3. tie everything together ----
source(paste0(dir_occur_mdl, "src/99_make_database.R"))

# 4. and check whether it's all as expected ----
source(paste0(dir_occur_mdl, "src/99_test-output.R"))

# 5. finally, update the luckinet-profile ----
profile <- load_profile(name = model_name, version = model_version)

profile$occurrenceDB <- DB_version
write_profile(name = model_name, version = model_version, parameters = profile)

# 98. scrutinise issue and make a decision:
#
## time periods missing ----
# source(paste0(dir_occur_mdl, "src/adina2017.R"))
# source(paste0(dir_occur_mdl, "src/alvarez-davila2017.R")) 200 -forest- needs clarification (mail)
# source(paste0(dir_occur_mdl, "src/bauters2019.R"))        15 -forest-
# source(paste0(dir_occur_mdl, "src/chaudhary2016.R"))      1008 -forest-
# source(paste0(dir_occur_mdl, "src/döbert2017.R"))         180 -forest-
# source(paste0(dir_occur_mdl, "src/draper2021.R"))         1240 -forest-
# source(paste0(dir_occur_mdl, "src/ibanez2018.R"))         434 -forest-
# source(paste0(dir_occur_mdl, "src/ibanez2020.R"))         51 -forest-
# source(paste0(dir_occur_mdl, "src/keil2019.R"))
# source(paste0(dir_occur_mdl, "src/lewis2013.R"))          260 -forest-
# source(paste0(dir_occur_mdl, "src/menge2019.R"))          44 -forest-
# source(paste0(dir_occur_mdl, "src/morera-beita2019.R"))   20 -forest-
# source(paste0(dir_occur_mdl, "src/parizzi2017.R"))
# source(paste0(dir_occur_mdl, "src/potts2017.R"))
# source(paste0(dir_occur_mdl, "src/sankaran2007.R"))       854 -forest-
# source(paste0(dir_occur_mdl, "src/sarti2020.R"))
# source(paste0(dir_occur_mdl, "src/scarcelli2019.R"))      168 -yam-
# source(paste0(dir_occur_mdl, "src/trettin2020.R"))        17 -mangrove-
# source(paste0(dir_occur_mdl, "src/zhao2014.R"))           2897 -cropland-
#
## hard to get data ----
# source(paste0(dir_occur_mdl, "src/ma2020.R")) read data from pdf
# source(paste0(dir_occur_mdl, "src/timesen2crop.R")) coordinates not readily available
#
## data need to be sampled from GeoTiff ----
# source(paste0(dir_occur_mdl, "src/wcda.R"))
# source(paste0(dir_occur_mdl, "src/xu2020.R"))
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
