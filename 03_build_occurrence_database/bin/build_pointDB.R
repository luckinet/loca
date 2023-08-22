# script description ----
#
# This is the main script for building a database of occurrence/in-situ data for
# all landuse dimensions of LUCKINet.


# authors ----
#
# Peter Pothmann, Steffen Ehrmann, Konrad Adler, Caterina Barasso,
# Ruben Remelgado


# version ----
# 1.0.0 (June 2023)


# script arguments ----
#
currentModule <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))
source(paste0(dirname(currentModule), "/01_boot_framework.R"))


# 1. start database and set some meta information ----
#
if(!testDirectoryExists(occurrenceDBDir)){
  start_occurrenceDB(root = occurrenceDBDir)
}

# gazetteer for territory names
countries <- get_concept(class = "al1", ontology = gazDir) %>%
  arrange(label)


# 2. build database ----
#
# source(paste0(mdl0302, "src/00_template.R"))
#
harmonise map

### done ---- (currently they all still need to be run and harmonized with the ontology)
source(paste0(mdl0302, "src/agris2018.R"))
source(paste0(mdl0302, "src/aleza2018.R"))
source(paste0(mdl0302, "src/amir1991.R"))
source(paste0(mdl0302, "src/anderson-teixeira2014.R"))
source(paste0(mdl0302, "src/anderson-teixeira2018.R"))
source(paste0(mdl0302, "src/anderson2003.R"))
source(paste0(mdl0302, "src/annighöfer2015.R"))
source(paste0(mdl0302, "src/asigbaase2019.R"))
source(paste0(mdl0302, "src/ausCovera.R"))
source(paste0(mdl0302, "src/ausCoverb.R"))
source(paste0(mdl0302, "src/ballauff2021.R"))
source(paste0(mdl0302, "src/bastin2017.R"))
source(paste0(mdl0302, "src/bayas2021.R"))
# source(paste0(mdl0302, "src/batjes2021.R"))    no commodities -> as they distinguish soil profiles by biome, we should try to find these information and make use of them as "landcover" at least.
source(paste0(mdl0302, "src/beyrs2015.R"))
source(paste0(mdl0302, "src/biodivInternational.R"))
# source(paste0(mdl0302, "src/BIOTA.R")) # PP
source(paste0(mdl0302, "src/bioTime.R"))
source(paste0(mdl0302, "src/blaser2018.R"))
source(paste0(mdl0302, "src/bordin2021.R"))
source(paste0(mdl0302, "src/borer2019.R"))
source(paste0(mdl0302, "src/bosch2008.R"))
source(paste0(mdl0302, "src/broadbent2021.R"))
source(paste0(mdl0302, "src/bücker2010.R"))
source(paste0(mdl0302, "src/caci.R"))
source(paste0(mdl0302, "src/camara2019.R"))
source(paste0(mdl0302, "src/camara2020.R"))
source(paste0(mdl0302, "src/capaverde2018.R"))
source(paste0(mdl0302, "src/caughlin2016.R"))
source(paste0(mdl0302, "src/cawa.R"))
source(paste0(mdl0302, "src/chain-guadarrama2017.R"))
source(paste0(mdl0302, "src/coleman2008.R"))
source(paste0(mdl0302, "src/crain2018.R"))
source(paste0(mdl0302, "src/craven2018.R"))
source(paste0(mdl0302, "src/cropHarvest.R"))
source(paste0(mdl0302, "src/dataman.R"))
# davalos2016 - skip for now, they use UNODOC data, try to get the orginal data from UN
source(paste0(mdl0302, "src/davila-lara2017.R"))
source(paste0(mdl0302, "src/deblécourt2017.R"))
source(paste0(mdl0302, "src/declercq2012.R"))
source(paste0(mdl0302, "src/dejonge2014.R"))
source(paste0(mdl0302, "src/descals2020.R"))
source(paste0(mdl0302, "src/desousa2020.R"))
source(paste0(mdl0302, "src/doughty2015.R"))
source(paste0(mdl0302, "src/esc.R"))
source(paste0(mdl0302, "src/ehbrecht2021.R"))
source(paste0(mdl0302, "src/empres.R"))
source(paste0(mdl0302, "src/fang2021.R"))
source(paste0(mdl0302, "src/faye2019.R"))
source(paste0(mdl0302, "src/feng2022.R"))
source(paste0(mdl0302, "src/firn2020.R"))
source(paste0(mdl0302, "src/flores-moreno2017.R"))
source(paste0(mdl0302, "src/ForestGEO.R"))
source(paste0(mdl0302, "src/franklin2015.R"))
source(paste0(mdl0302, "src/franklin2018.R"))
source(paste0(mdl0302, "src/fritz2017.R"))
source(paste0(mdl0302, "src/gallhager2017.R"))
source(paste0(mdl0302, "src/gashu2021.R"))
source(paste0(mdl0302, "src/gebert2019.R"))
source(paste0(mdl0302, "src/genesys.R"))
source(paste0(mdl0302, "src/GFSAD30.R"))
source(paste0(mdl0302, "src/gibson2011.R"))
source(paste0(mdl0302, "src/glato2017.R"))
source(paste0(mdl0302, "src/GLOBE.R"))
source(paste0(mdl0302, "src/grosso2013.R"))
source(paste0(mdl0302, "src/Grump.R"))
source(paste0(mdl0302, "src/guitet2015.R"))
source(paste0(mdl0302, "src/haarhoff2019.R"))
source(paste0(mdl0302, "src/habel2020.R"))
source(paste0(mdl0302, "src/haeni2016.R"))
source(paste0(mdl0302, "src/hardy2019.R"))
source(paste0(mdl0302, "src/hengl2020.R"))
source(paste0(mdl0302, "src/hilpold2018.R"))
source(paste0(mdl0302, "src/hoffman2019.R"))
source(paste0(mdl0302, "src/hogan2018.R"))
source(paste0(mdl0302, "src/hudson2016.R"))
source(paste0(mdl0302, "src/hylander2018.R"))
source(paste0(mdl0302, "src/infys.R"))
source(paste0(mdl0302, "src/ingrisch2014.R"))
source(paste0(mdl0302, "src/jackson2021.R"))
source(paste0(mdl0302, "src/jolivot2021.R"))
source(paste0(mdl0302, "src/jonas2020.R"))
source(paste0(mdl0302, "src/jordan2020.R"))
source(paste0(mdl0302, "src/juergens2012.R"))
source(paste0(mdl0302, "src/jung2016.R"))
source(paste0(mdl0302, "src/karlsson2017.R"))
source(paste0(mdl0302, "src/kebede2019.R"))
source(paste0(mdl0302, "src/kenefic2015.R"))
source(paste0(mdl0302, "src/kenefic2019.R"))
source(paste0(mdl0302, "src/knapp2021.R"))
source(paste0(mdl0302, "src/kormann2018.R"))
source(paste0(mdl0302, "src/koskinen2018.R"))
source(paste0(mdl0302, "src/lamond2014.R"))
source(paste0(mdl0302, "src/landpks.R"))
source(paste0(mdl0302, "src/lauenroth2019.R"))
source(paste0(mdl0302, "src/ledig2019.R"))
source(paste0(mdl0302, "src/ledo2019.R"))
source(paste0(mdl0302, "src/leduc2021.R"))
source(paste0(mdl0302, "src/lesiv2020.R"))
source(paste0(mdl0302, "src/li2018.R"))
source(paste0(mdl0302, "src/llorente2018.R"))
source(paste0(mdl0302, "src/lucas.R"))
source(paste0(mdl0302, "src/maas2015.R"))
source(paste0(mdl0302, "src/mandal2016.R"))
source(paste0(mdl0302, "src/mapBiomas.R"))
source(paste0(mdl0302, "src/mchairn2014.R"))
source(paste0(mdl0302, "src/mchairn2021.R"))
source(paste0(mdl0302, "src/mckee2015.R"))
source(paste0(mdl0302, "src/meddens2017.R"))
source(paste0(mdl0302, "src/merschel2014.R"))
source(paste0(mdl0302, "src/mgap.R"))
source(paste0(mdl0302, "src/mitchard2014.R"))
source(paste0(mdl0302, "src/moghaddam2014.R"))
source(paste0(mdl0302, "src/monro2017.R"))
source(paste0(mdl0302, "src/moonlight2020.R"))
source(paste0(mdl0302, "src/nalley2020.R"))
source(paste0(mdl0302, "src/nyirambangutse2017.R"))
source(paste0(mdl0302, "src/ofsa.R"))
source(paste0(mdl0302, "src/ogle2007.R"))
source(paste0(mdl0302, "src/oldfield2018.R"))
source(paste0(mdl0302, "src/oliva2020.R"))
source(paste0(mdl0302, "src/osuri2019.R"))
source(paste0(mdl0302, "src/oswald2016.R"))
source(paste0(mdl0302, "src/ouedraogo2016.R"))
source(paste0(mdl0302, "src/pärn2018.R"))
source(paste0(mdl0302, "src/pennington.R"))
source(paste0(mdl0302, "src/perrino2012.R"))
source(paste0(mdl0302, "src/piponiot2016.R"))
source(paste0(mdl0302, "src/plantVillage.R"))
source(paste0(mdl0302, "src/ploton2020.R"))
source(paste0(mdl0302, "src/potapov2021.R"))
source(paste0(mdl0302, "src/quisehuatl-medina2020.R"))
source(paste0(mdl0302, "src/raley2017.R"))
source(paste0(mdl0302, "src/raman2006.R"))
source(paste0(mdl0302, "src/ratnam2019.R"))
source(paste0(mdl0302, "src/raymundo2018.R"))
source(paste0(mdl0302, "src/robichaud2017.R"))
source(paste0(mdl0302, "src/roman2021.R"))
source(paste0(mdl0302, "src/SAMPLES.R"))
source(paste0(mdl0302, "src/sanches2018.R"))
source(paste0(mdl0302, "src/sanchez-azofeita2017.R"))
source(paste0(mdl0302, "src/schepaschenko.R"))
source(paste0(mdl0302, "src/schneider2020.R"))
source(paste0(mdl0302, "src/schooley2005.R"))
# source(paste0(mdl0302, "src/see2022.R")) source(paste0(mdl0302, "src/see2016a.R")) source(paste0(mdl0302, "src/see2016c.R")) source(paste0(mdl0302, "src/see2016b.R"))
source(paste0(mdl0302, "src/seo2014.R"))
source(paste0(mdl0302, "src/shooner2018.R"))
source(paste0(mdl0302, "src/silva2019.R"))
source(paste0(mdl0302, "src/sinasson2016.R"))
source(paste0(mdl0302, "src/srdb.R"))
source(paste0(mdl0302, "src/stevens2011.R")) # PP - ready
source(paste0(mdl0302, "src/sullivan2018.R")) # PP - ready
source(paste0(mdl0302, "src/surendra2021.R")) # PP - ready
source(paste0(mdl0302, "src/szantoi2020.R")) # PP - ready
source(paste0(mdl0302, "src/szantoi2021.R")) # PP - ready
# source(paste0(mdl0302, "src/szyniszewska2019.R"))
source(paste0(mdl0302, "src/tateishi2014.R"))
source(paste0(mdl0302, "src/tedonzong2021.R"))
source(paste0(mdl0302, "src/teixeira2015.R"))
source(paste0(mdl0302, "src/thornton2014.R"))
source(paste0(mdl0302, "src/truckenbrodt2017.R"))
source(paste0(mdl0302, "src/vieilledent2016.R"))
source(paste0(mdl0302, "src/vijay2016.R"))
source(paste0(mdl0302, "src/vilanova2018.R"))
source(paste0(mdl0302, "src/wei2018.R"))
source(paste0(mdl0302, "src/wenden2016.R"))
source(paste0(mdl0302, "src/westengen2014.R"))
source(paste0(mdl0302, "src/wood2016.R"))
source(paste0(mdl0302, "src/woollen2017.R"))
source(paste0(mdl0302, "src/wortmann2019.R"))
source(paste0(mdl0302, "src/wortmann2020.R"))
source(paste0(mdl0302, "src/zhang1999.R")) fix sp



### wip ----
source(paste0(mdl0302, "src/alemayehu2019.R")) sort in from old scheme
source(paste0(mdl0302, "src/bayas2017.R")) this actually needs to be corrected, based on the 'cover' of cropland
source(paste0(mdl0302, "src/bagchi2017.R")) continue harmonizing
source(paste0(mdl0302, "src/beenhouwer2013.R")) everything needs to be done
source(paste0(mdl0302, "src/BigEarthNet.R")) everything needs to be done
source(paste0(mdl0302, "src/bisseleua2013.R")) some important meta-data are missing
source(paste0(mdl0302, "src/bocquet2019.R")) assign all values - part of Radiant MLHub - i skip this for now
source(paste0(mdl0302, "src/breizhCrops.R")) in principle done, but only one area implemented so far
source(paste0(mdl0302, "src/bright2019.R")) meta-data and harmonization are missing
source(paste0(mdl0302, "src/budburst.R")) continue harmonizing
source(paste0(mdl0302, "src/californiaCrops.R")) needs a lot of work
source(paste0(mdl0302, "src/conrad2019.R")) meta-data missing
source(paste0(mdl0302, "src/crowther2019.R")) the labels for the points are missing
source(paste0(mdl0302, "src/degroote2019.R")) continue harmonizing
source(paste0(mdl0302, "src/dutta2014.R")) everything needs to be done
source(paste0(mdl0302, "src/drakos2020.R")) this is interesting and needs to be scrutinised further
source(paste0(mdl0302, "src/ehrmann2017.R")) everything needs to be done
source(paste0(mdl0302, "src/euroCrops.R")) everything needs to be done
source(paste0(mdl0302, "src/eurosat.R")) everything needs to be done
source(paste0(mdl0302, "src/falster2015.R")) dates are in: baad_metadate.csv, needs extraction by hand
source(paste0(mdl0302, "src/gbif.R")) needs to be redone
source(paste0(mdl0302, "src/gofc-gold.R")) some meta-data still missing and some provessing (there may be duplicates here)
source(paste0(mdl0302, "src/gyga.R")) some meta-data still missing and some provessing
source(paste0(mdl0302, "src/hunt2013.R")) everything needs to be done
source(paste0(mdl0302, "src/iscn.R")) assign all values
source(paste0(mdl0302, "src/jin2021.R")) everything needs to be done
source(paste0(mdl0302, "src/krause2021.R")) only peatland -> but this is def. also needed and it iss part of the ontology
source(paste0(mdl0302, "src/kim2020.R")) this may be problematic because apparently the coordinates indicate only a region, not the actual plots
source(paste0(mdl0302, "src/lasky2015.R")) everything needs to be done
source(paste0(mdl0302, "src/marin2013.R")) conversion of coordinates to decimal needed
source(paste0(mdl0302, "src/mendoza2016.R")) continue harmonizing
source(paste0(mdl0302, "src/nthiwa2020.R")) some meta-data missing
source(paste0(mdl0302, "src/osm.R")) where is the folder?
source(paste0(mdl0302, "src/ramos-fabiel2018.R")) fix coordinates and target variable seems to be missing?!
source(paste0(mdl0302, "src/reiner2018.R")) everything missing
source(paste0(mdl0302, "src/rineer2021.R")) everything needs to be done
source(paste0(mdl0302, "src/sen4cap.R")) data missing
source(paste0(mdl0302, "src/splot.R")) clarify which values to use
source(paste0(mdl0302, "src/trettin2017.R"))  some metadata missing
source(paste0(mdl0302, "src/vanhooft2015.R")) meta-data missing
source(paste0(mdl0302, "src/weber2011.R")) meta-data missing



### hard to get data ----
# source(paste0(mdl0302, "src/AusPlots.R")) some of the Vegetation-Communities_*.csv files could be interesting, but I think it's quite the hassle to extract these data and harmonize them with the ontology
# source(paste0(mdl0302, "src/ma2020.R")) read data from pdf
# source(paste0(mdl0302, "src/timesen2crop.R")) coordinates not readily available

#### data need to be sampled from GeoTiff ----
# source(paste0(mdl0302, "src/WCDA.R"))
# source(paste0(mdl0302, "src/xu2020.R"))
# https://github.com/corentin-dfg/Satellite-Image-Time-Series-Datasets


# 3. tie everything together ----
source(paste0(mdl0302, "src/99_make_database.R"))


# 4. and check whether it's all as expected ----
source(paste0(mdl0302, "src/99_test-output.R"))


# 5. finally, update the luckinet-profile ----
profile <- load_profile(root = dataDir, name = model_name, version = model_version)

profile$occurrenceDB <- DB_version
write_profile(root = dataDir, name = model_name, version = model_version,
              parameters = profile)




### unavailable or not usable ----
# in the following there is a list with the reference-key and a description of
# why this reference is not usable, even though it should contain useful data;
# please check the corresponding bibiography (unused.bib) for details on the
# dataset/study/...
#
#### site-level coordinates instead of plot-level coordinates
# | reference | details |
# | :- | :- |
# |  |  |
# |  |  |
#
#### coordinates or other spatial information missing entirely
# | reference | details |
# | :- | :- |
# |  |  |
# |  |  |
#
#### temporal information missing entirely
# | reference | details |
# | :- | :- |
# | Brown2020 |  |
# | Hou2017 |  |
# |  |  |
#
#### (reinterpreted) data from another dataset
# | reference | details |
# | :- | :- |
# |  |  |
# |  |  |





## time periods missing ----
#
# source(paste0(mdl0302, "src/adina2017.R"))
# source(paste0(mdl0302, "src/alvarez-davila2017.R")) 200 -forest- needs clarification (mail)
# source(paste0(mdl0302, "src/bauters2019.R"))        15 -forest-
# source(paste0(mdl0302, "src/chaudhary2016.R"))      1008 -forest-
# source(paste0(mdl0302, "src/döbert2017.R"))         180 -forest-
# source(paste0(mdl0302, "src/draper2021.R"))         1240 -forest-
# source(paste0(mdl0302, "src/ibanez2018.R"))         434 -forest-
# source(paste0(mdl0302, "src/ibanez2020.R"))         51 -forest-
# source(paste0(mdl0302, "src/keil2019.R"))
# source(paste0(mdl0302, "src/lewis2013.R"))          260 -forest-
# source(paste0(mdl0302, "src/menge2019.R"))          44 -forest-
# source(paste0(mdl0302, "src/morera-beita2019.R"))   20 -forest-
# source(paste0(mdl0302, "src/parizzi2017.R"))
# source(paste0(mdl0302, "src/potts2017.R"))
# source(paste0(mdl0302, "src/sankaran2007.R"))       854 -forest-
# source(paste0(mdl0302, "src/sarti2020.R"))
# source(paste0(mdl0302, "src/scarcelli2019.R"))      168 -yam-
# source(paste0(mdl0302, "src/trettin2020.R"))        17 -mangrove-
# source(paste0(mdl0302, "src/zhao2014.R"))           2897 -cropland-


## final decision reached (here only with reason for exclusion) ----
# Sheils2019      missing cor now in contact authors (PP)
# OBrian2019      missing cor of plots --> moved to discarded
# CV4A            already included in cropHarvest as 'african_crops_kenya'
# GAFC            already included in cropHarvest as 'african_crops_tanzania'
# Waha2016        no explicit spatial data availble that go beyond admin level 2 of the GADM dataset
# Crotteau2019    no coordinates at all
# stephens2017    historical data (1911)
# fyfe2015        historical data
# budBurst        no clear vegetation patterns available in the data
# herzschuh2021   pollen data that I'd ignore for now -> ok
# harrington2019  only for 1985
# hayes2021       data not available digitally
# rustowicz2020   need to get from tifs, which don't have a crs
# mishra1995      only experiment
# orta2002        only experiment site coordinates, not on plot level
# oweis2000       only experiment site coordinates, not on plot level
# pandey2001      only experiment site coordinates, not on plot level
# sharma1990      only experiment site coordinates, not on plot level
# sharma2001      only experiment site coordinates, not on plot level
# zhang2002       only experiment site coordinates, not on plot level
# souza2019       only experiment site coordinates, not on plot level
# caviglia2000    only experiment site coordinates, not on plot level
# bouthiba2008    only experiment site coordinates, not on plot level
# wang2020        only experiment site coordinates, not on plot level - has many grazing data with coordinates and dates available
# pillet2017      unclear CRS and actually only 6 sites
# liangyun2019    this is a reinterpretation of GOFC-GOLD and GFSAD30 datasets to the LCCS, which is thus unsuitable for us, since we'd have to reinterpret the reinterpretation, when we can instead work with GOFC-GOLD --> no it is more then that i think, they also use water LC data of WWF, do u want me to put it to review?
# tuck2014        coordinates missing, even though they are used for data preparation
# reetsch2020     coordinates of farms (houshold survey) not the actual fields
# conabio         this seems to be primarily on the number of plant occurrences, and I don't see a way to easily extract information on landcover or even land use
