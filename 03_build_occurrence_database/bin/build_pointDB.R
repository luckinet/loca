# script description ----
#
# This is the main script for building a database of occurrence/in-situ data for
# all landuse dimensions of LUCKINet.


# authors ----
#
# Peter Pothmann, Steffen Ehrmann, Konrad Adler, Caterina Barasso,
# Ruben Remelgado


# Documentation ----
#
currentModule <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))
getOption("viewer")(rmarkdown::render(input = paste0(currentModule, "/README.md")))


# script arguments ----
#
source(paste0(dirname(currentModule), "/01_boot_framework.R"))


# start database and set some meta information ----
#
start_occurrenceDB(root = occurrenceDBDir)

# ontology for land-use and crop commodity concepts
luckiOnto <- load_ontology(path = ontoDir)

# gazetteer for territory names
gaz <- load_ontology(path = gazDir)
countries <- get_concept(x = tibble(class = "al1"), ontology = gaz) %>%
  arrange(label)



finalise LUCAS ontology and check with bastin2017
check git for replacements of sp, should be in an old commit --> # library(sp) i need this library for the char2dms function | where do you need this? wondering whether we could find another workaround to avoid the package altogether --> I need this for the char2dms function. So basically whenever the coordinates are in degrees instead of decimal. And this is in multiple scripts (around 10-15 I guess) the ones i found: deju1992.R, olivia2020.R
how about missing time-periods?



# Abkürzungen
# checked: check for area, fid variable, publication year (Name), and duplicates (Distinct)
# ready: ready to run everything, including save Dataset

# build dataseries ----
#
# source(paste0(mdl0202, "src/00_template.R"))

source(paste0(mdl0202, "src/lucas.R"))

# source(paste0(modlDir, "src/amir1991.R"))
# source(paste0(modlDir, "src/anderson-teixeira2014.R")) # PP
# source(paste0(modlDir, "src/anderson-teixeira2018.R")) # PP
# source(paste0(modlDir, "src/anderson2003.R")) # PP
# source(paste0(modlDir, "src/annighöfer2015.R")) # PP
source(paste0(modlDir, "src/aleza2018.R")) # PP - ready
source(paste0(modlDir, "src/asigbaase2019.R")) # PP - ready
source(paste0(modlDir, "src/ausCovera.R")) # PP - ready
source(paste0(modlDir, "src/ausCoverb.R")) # PP - ready
# source(paste0(modlDir, "src/ballauff2021.R")) # PP
# source(paste0(modlDir, "src/bastin2017.R"))
# source(paste0(modlDir, "src/bayas2017.R")) this actually needs to be corrected, based on the 'cover' of cropland
# source(paste0(modlDir, "src/bayas2021.R")) # PP
# source(paste0(modlDir, "src/beyrs2015.R")) # PP
# source(paste0(modlDir, "src/BIOTA.R")) # PP
source(paste0(modlDir, "src/bioTime.R")) # PP - ready
# source(paste0(modlDir, "src/blaser2018.R")) # PP
source(paste0(modlDir, "src/borer2019.R")) # PP - ready
source(paste0(modlDir, "src/bordin2021.R")) # PP - ready
source(paste0(modlDir, "src/bosch2008.R")) # PP - ready
source(paste0(modlDir, "src/bücker2010.R")) # PP - ready
source(paste0(modlDir, "src/broadbent2021.R")) # PP - ready
source(paste0(modlDir, "src/caci.R")) # PP - ready
source(paste0(modlDir, "src/camara2019.R")) # PP - ready
source(paste0(modlDir, "src/capaverde2018.R")) # PP - ready
ource(paste0(modlDir, "src/caughlin2016.R")) # PP - ready
source(paste0(mdl0202, "src/cawa.R")) # PP - ready
source(paste0(modlDir, "src/coleman2008.R")) # PP - ready
# source(paste0(modlDir, "src/craven2018.R"))
source(paste0(modlDir, "src/crain2018.R")) # PP - ready
source(paste0(modlDir, "src/cropHarvest.R")) # make ontology
source(paste0(modlDir, "src/dataman.R")) # PP - ready
source(paste0(modlDir, "src/davila-lara2017.R")) # PP - ready
source(paste0(modlDir, "src/declercq2012.R")) # PP - ready
source(paste0(modlDir, "src/deblécourt2017.R")) # PP - ready
source(paste0(modlDir, "src/deju1992.R")) # PP  -- only 3 observations, maybe delete?
source(paste0(modlDir, "src/dejonge2014.R")) # PP - ready
source(paste0(modlDir, "src/doughty2015.R")) # PP - ready
source(paste0(modlDir, "src/desousa2020.R")) # PP - ready
source(paste0(modlDir, "src/ehbrecht2021.R")) # PP - ready
source(paste0(modlDir, "src/esc.R")) # PP - ready
source(paste0(modlDir, "src/euroCrops.R"))
source(paste0(modlDir, "src/falster2015.R")) # PP - ready
source(paste0(modlDir, "src/fang2021.R")) # PP - ready
source(paste0(modlDir, "src/faye2019.R")) # PP - ready
source(paste0(modlDir, "src/feng2022.R")) # PP - ready
source(paste0(modlDir, "src/firn2020.R")) # PP - ready
source(paste0(modlDir, "src/flores-moreno2017.R")) # PP - ready
source(paste0(modlDir, "src/franklin2015.R")) # PP - ready
source(paste0(modlDir, "src/franklin2018.R")) # PP - ready
source(paste0(modlDir, "src/gallhager2017.R")) # PP - ready
source(paste0(modlDir, "src/gashu2021.R")) # PP - ready
source(paste0(modlDir, "src/gebert2019.R")) # PP - ready
source(paste0(mdl0202, "src/genesys.R")) # PP - check with countries
source(paste0(mdl0202, "src/GFSAD30.R")) # PP - ready
source(paste0(modlDir, "src/glato2017.R")) # PP - ready
source(paste0(modlDir, "src/GLOBE.R")) # PP - ready
source(paste0(modlDir, "src/grosso2013.R")) # PP - ready
source(paste0(modlDir, "src/Grump.R")) # PP - ready
# source(paste0(modlDir, "src/guitet2015.R")) # PP
source(paste0(modlDir, "src/habel2020.R")) # PP - ready
source(paste0(modlDir, "src/haeni2016.R")) # PP - ready
source(paste0(modlDir, "src/hardy2019.R")) # PP - ready
source(paste0(modlDir, "src/hogan2018.R")) # PP - ready
source(paste0(modlDir, "src/hilpold2018.R")) # PP - ready
source(paste0(modlDir, "src/hylander2018.R")) # PP - ready
source(paste0(modlDir, "src/hudson2016.R")) # PP - ready
source(paste0(modlDir, "src/infys.R")) # PP - ready
source(paste0(modlDir, "src/ingrisch2014.R")) # PP - ready
source(paste0(modlDir, "src/jackson2021.R")) # PP - ready
source(paste0(modlDir, "src/jonas2020.R")) # PP - ready
source(paste0(modlDir, "src/jordan2020.R")) # PP - ready
source(paste0(modlDir, "src/jung2016.R")) # PP - ready
source(paste0(modlDir, "src/karlsson2017.R")) # PP - ready
source(paste0(modlDir, "src/kebede2019.R")) # PP - ready
source(paste0(modlDir, "src/kenefic2015.R")) # PP - ready
source(paste0(modlDir, "src/kenefic2019.R")) # PP - ready
source(paste0(modlDir, "src/knapp2021.R")) # PP - ready
source(paste0(modlDir, "src/kormann2018.R")) # PP - ready
source(paste0(mdl0202, "src/koskinen2018.R")) # PP - ready
source(paste0(modlDir, "src/lamond2014.R")) # PP - ready
source(paste0(modlDir, "src/ledig2019.R")) #  PP - ready

source(paste0(mdl0202, "src/ledo2019.R")) # PP - ready
source(paste0(modlDir, "src/leduc2021.R")) # PP - ready
source(paste0(modlDir, "src/llorente2018.R")) # PP - ready
source(paste0(modlDir, "src/maas2015.R")) # PP - ready
source(paste0(modlDir, "src/mandal2016.R")) # PP - ready
source(paste0(modlDir, "src/MapBiomas.R")) # PP - ready
source(paste0(modlDir, "src/merschel2014.R")) # PP - ready
source(paste0(modlDir, "src/mgap.R")) # PP - ready
source(paste0(modlDir, "src/monro2017.R")) # PP - ready
# source(paste0(modlDir, "src/mitchard2014.R"))# PP
source(paste0(modlDir, "src/nalley2020.R")) # PP - ready
source(paste0(modlDir, "src/nthiwa2020.R")) # PP - ready
source(paste0(modlDir, "src/moghaddam2014.R")) # PP - ready
source(paste0(modlDir, "src/ofsa.R")) # PP - ready
source(paste0(modlDir, "src/oldfield2018.R")) # PP
source(paste0(modlDir, "src/oliva2020.R")) # PP - checked -- coordinates transform with sp
source(paste0(modlDir, "src/oswald2016.R")) # PP - ready
source(paste0(mdl0202, "src/pärn2018.R"))  # PP - ready
source(paste0(modlDir, "src/perrino2012.R")) # PP - ready
source(paste0(modlDir, "src/plantVillage.R")) # PP - ready
source(paste0(modlDir, "src/quisehuatl-medina2020.R")) # PP - ready
source(paste0(modlDir, "src/raley2017.R")) # PP - ready
source(paste0(modlDir, "src/ratnam2019.R")) # PP - ready
source(paste0(modlDir, "src/raymundo2018.R")) # PP - ready
source(paste0(modlDir, "src/robichaud2017.R")) # PP - ready
source(paste0(modlDir, "src/schooley2005.R")) # PP - ready
source(paste0(modlDir, "src/seo2014.R")) # PP - ready
source(paste0(modlDir, "src/shooner2018.R")) # PP - ready
source(paste0(modlDir, "src/silva2019.R")) # PP - ready
source(paste0(modlDir, "src/sinasson2016.R")) # PP - ready
source(paste0(modlDir, "src/stevens2011.R")) # PP - ready
source(paste0(modlDir, "src/sullivan2018.R")) # PP - ready
source(paste0(mdl0202, "src/srdb.R")) # PP - ready
source(paste0(mdl0202, "src/szantoi2020.R")) # PP - ready
source(paste0(mdl0202, "src/szantoi2021.R")) # PP - ready
source(paste0(modlDir, "src/tateishi2014.R"))# PP - ready
source(paste0(modlDir, "src/tedonzong2021.R"))  # PP - ready
source(paste0(modlDir, "src/teixeira2015.R")) # PP - ready
source(paste0(modlDir, "src/trettin2017.R"))  # PP - ready
source(paste0(modlDir, "src/truckenbrodt2017.R")) # PP - ready
source(paste0(modlDir, "src/vanhooft2015.R")) # PP - ready
source(paste0(modlDir, "src/vieilledent2016.R")) # PP - ready
source(paste0(modlDir, "src/vijay2016.R")) # PP - ready
source(paste0(mdl0202, "src/wei2018.R")) # PP - ready
source(paste0(modlDir, "src/westengen2014.R")) # PP - ready
source(paste0(modlDir, "src/woollen2017.R")) # PP - ready
source(paste0(modlDir, "src/wortmann2020.R")) # PP - ready
source(paste0(modlDir, "src/wortmann2019.R")) # PP - ready
source(paste0(modlDir, "src/zhang1999.R")) # PP - ready


# source(paste0(modlDir, "src/descals2020.R")) # - PP i corrected the year of publication  - run this script again
# source(paste0(modlDir, "src/fritz2017.R"))
# source(paste0(modlDir, "src/jolivot2021.R"))
# source(paste0(modlDir, "src/ouedraogo2016.R"))
# source(paste0(modlDir, "src/lesiv2020.R"))
# source(paste0(modlDir, "src/mchairn2014.R"))
# source(paste0(modlDir, "src/mchairn2021.R"))
# source(paste0(modlDir, "src/potapov2021.R"))
# source(paste0(modlDir, "src/schepaschenko.R"))
# source(paste0(modlDir, "src/szyniszewska2019.R"))
# source(paste0(modlDir, "src/wenden2016.R"))
source(paste0(modlDir, "src/breizhCrops.R"))            # in principle done, but only one area implemented so far
source(paste0(modlDir, "src/californiaCrops.R"))         # needs a lot of work
source(paste0(modlDir, "src/biodivInternational.R"))         # assign all values
source(paste0(modlDir, "src/landpks.R"))                     # extract info from 'land_use', 'grazed', 'grazing' and 'flooding'
source(paste0(modlDir, "src/li2018.R"))                      # make dates
source(paste0(modlDir, "src/splot.R"))                       # clarify which values to use
source(paste0(modlDir, "src/thornton2014.R"))                # make ontology, dates need a fix


# already integrated by Caterina, skip for now but ontology harmonisation is still missing

source(paste0(mdl0202, "src/conrad2019.R")) # Woher kommen die Daten, würde gerne zumindest die Publikation angeben?
source(paste0(mdl0202, "src/gbif.R"))
source(paste0(mdl0202, "src/osm.R")) # where is the folder?
source(paste0(mdl0202, "src/sen4cap.R")) # no data in folder


# tie everything together ----
source(paste0(mdl0202, "src/99_make_database.R"))


# and check whether it's all as expected ----
source(paste0(mdl0202, "src/99_test-output.R"))


# finally, update the luckinet-profile ----
profile <- load_profile(root = dataDir, name = model_name, version = model_version)

profile$occurrenceDB <- DB_version
write_profile(root = dataDir, name = model_name, version = model_version,
              parameters = profile)

# work in process ----
#

# source(paste0(modlDir, "src/beenhouwer2013.R")) # try to find those citations with the most data on coffee and cacao
# source(paste0(modlDir, "src/bocquet2019.R")) # assign all values - part of Radiant MLHub - i skip this for now
# source(paste0(modlDir, "src/drakos2020.R")) # this is interesting and needs to be scrutinised further
# 2965 -landcover- 1983 -descrp- source(paste0(modlDir, "src/gofc-gold.R")) # assign all values --> this one is done i think, the  only in-situ data I found was the data made by tateishi2014 which is harmonised
# source(paste0(modlDir, "src/hunt2013.R")) # find reference and clean data, make ontology
# 96722 -vegetation_class- source(paste0(modlDir, "src/iscn.R")) # assign all values -- here I do not find any LULC variables
# source(paste0(modlDir, "src/jin2021.R")) # only small section of the land, so probably not worth the effort
# davalos2016 - skip for now, they use UNODOC data, try to get the orginal data from UN

########
# prio 2
########


########
# prio 3
########


########
# Prio 4
########
# source(paste0(modlDir, "src/ma2020.R")) read data from pdf
# source(paste0(modlDir, "src/meddens2017.R")) read data from mdb
# 44 -forest- source(paste0(modlDir, "src/menge2019.R")) # make ontology
# 2 -cropland- source(paste0(modlDir, "src/mishra1995.R")) # make ontology
# 33 -forest- source(paste0(modlDir, "src/moonlight2020.R")) # make ontology
# 20 -forest- source(paste0(modlDir, "src/morera-beita2019.R")) # make ontology
# 15 -forest- source(paste0(modlDir, "src/nyirambangutse2017.R")) # make ontology
# 2 -cropland- source(paste0(modlDir, "src/orta2002.R")) # make ontology
# 87 -forest- source(paste0(modlDir, "src/osuri2019.R")) # make ontology
# 5 -cropland- source(paste0(modlDir, "src/oweis2000.R")) # make ontology
# 2 -cropland- source(paste0(modlDir, "src/pandey2001.R")) # make ontology
# 35 -forest- source(paste0(modlDir, "src/pennington.R")) # make ontology
# 13 -forest- source(paste0(modlDir, "src/piponiot2016.R")) # dates need a sequence between two columns, but no information on census repetition times given in publi.
# 13 -forest- source(paste0(modlDir, "src/raman2006.R")) # make ontology
# 9 -forest- source(paste0(modlDir, "src/ramos-fabiel2018.R")) # make ontology
# source(paste0(modlDir, "src/reiner2018.R")) needs a lot of cleaning
# source(paste0(modlDir, "src/rineer2021.R")) requires a lot of work to put all labels into a common file
# 34 -forest- source(paste0(modlDir, "src/sanchez-azofeita2017.R")) # make ontology
# 10 -forest- source(paste0(modlDir, "src/schneider2020.R")) # make ontology
# 2 -cropland- source(paste0(modlDir, "src/sharma1990.R")) # make ontology
# 2 -cropland- source(paste0(modlDir, "src/sharma2001.R")) # make ontology
# 12 -forest- source(paste0(modlDir, "src/souza2019.R")) # make ontology
# 76 -forest- source(paste0(modlDir, "src/surendra2021.R")) # make ontology
# 17 -mangrove- source(paste0(modlDir, "src/trettin2020.R")) # make ontology
# 17 -forest- source(paste0(modlDir, "src/wood2016.R")) # maybe wrong coordinates. study in Appalachia. Coordinates in South america
# 4 -cropland- source(paste0(modlDir, "src/zhang2002.R")) # make ontology
# 10 -maize- source(paste0(modlDir, "src/marin2013.R")) # assign all values


## time periods missing
#
# source(paste0(modlDir, "src/adina2017.R")) # dates missing
# 200 -forest- source(paste0(modlDir, "src/alvarez-davila2017.R")) # dates missing, needs clarification (mail)
# 11 -forest- source(paste0(modlDir, "src/brown2020.R")) # dates missing
# 230 -forest- source(paste0(modlDir, "src/baad.R")) # assign all values - dates are in: baad_metadate.csv, needs extraction by hand
# 15 -forest- source(paste0(modlDir, "src/bauters2019.R")) # dates missing
# 1008 -forest- source(paste0(modlDir, "src/chaudhary2016.R")) # make ontology, dates missing
# 180 -forest- source(paste0(modlDir, "src/döbert2017.R")) #
# 1240 -forest- source(paste0(modlDir, "src/draper2021.R")) # dates missing
# 2220 -landuse- source(paste0(modlDir, "src/gibson2011.R")) # dates missing
# 2087 -cropland- source(paste0(modlDir, "src/gyga.R")) # Dates missing, make ontology
# source(paste0(modlDir, "src/hoffman2019.R")) # dates missing
# 434 -forest- source(paste0(modlDir, "src/ibanez2018.R")) # make ontology, dates missing
# 51 -forest- source(paste0(modlDir, "src/ibanez2020.R")) # make ontology, dates missing
# 191562 -forest- source(paste0(modlDir, "src/ploton2020.R")) # no Dates
# 2897 -cropland- source(paste0(modlDir, "src/zhao2014.R")) # no Dates
# 260 -forest- source(paste0(modlDir, "src/lewis2013.R")) # make ontology, dates missing
# 218 -cropland- source(paste0(modlDir, "src/mendoza2016.R")) # dates missing , meta study
# 299 - source(paste0(modlDir, "src/see2016a.R")) # dates missing, the representiv column is missing. I THINK THIS DATASET IS PART OF FRITZ2017
# 175 - source(paste0(modlDir, "src/see2016c.R")) # dates missing, I THINK THIS DATASET IS PART OF FRITZ2017
# 49 - source(paste0(modlDir, "src/see2016b.R")) # dates missing I THINK THIS DATASET IS PART OF FRITZ2017
# source(paste0(modlDir, "src/see2022.R")) # dates missing
# 854 -forest- source(paste0(modlDir, "src/sankaran2007.R")) # dates missing
# 802 -landcover- source(paste0(modlDir, "src/hou2017.R")) # dates missing
# 1945 -sorghum- source(paste0(modlDir, "src/lasky2015.R")) # dates missing, assign all values
# 168 -yam- source(paste0(modlDir, "src/scarcelli2019.R")) # dates missing, assign all values
# 1945 -sorghum- source(paste0(modlDir, "src/crowther2019.R")) # dates missing, assign all values
# source(paste0(modlDir, "src/sarti2020.R")) # dates missing
# 14 -forest- source(paste0(modlDir, "src/potts2017.R")) # dates missing, assign all values
# source(paste0(mdl0202, "src/parizzi2017.R")) # dates missing
# 50 -forest- source(paste0(modlDir, "src/vilanova2018.R")) # dates missing, difficult to reconstruct, some times are given in the method section of the paper


## Issues with coordinates
#
# 6 -forest- source(paste0(mdl0202, "src/bagchi2017.R")) # assign all values PP - missing Information on projection


## needs initial screening ----
# source(paste0(modlDir, "src/01_keilXXXX_03.R"))
# source(paste0(modlDir, "src/02_AusPlots_03.R"))
# source(paste0(modlDir, "src/02_conabio_03.R"))
# source(paste0(modlDir, "src/02_empres_03.R")) # download defect - no metadata for  data file in folder

# source(paste0(modlDir, "src/02_timesen2crop_03.R")) # coordinates not readily available -> authors already contacted!
# source(paste0(modlDir, "src/02_deepglobe_03.R")) # hard to find the data, but I think it's not impossible, spend more time on this if some is left.


## too much work for now ----
# datasets that need to be extracted from (labelled georeferenced) tifs
# source(paste0(mdl0202, "src/eurosat.R"))
# source(paste0(mdl0202, "src/WCDA.R"))
# source(paste0(mdl0202, "src/haarhoff2019.R"))

## double check ----
# Tuck2014        liegt im discarded Ordner
# Wang2000        liegt im discarded Ordner
# reetsch2020     coordinates of farms (houshold survey) not the actual fields I would say (PP)

## final decision reached (here only with reason for exclusion) ----
# Sheils2019      missing cor now in contact authors (PP)
# OBrian2019      missing cor of plots --> moved to discarded
# CV4A            already included in cropHarvest as 'african_crops_kenya'
# GAFC            already included in cropHar  make ontologyvest as 'african_crops_tanzania'
# Waha2016        no explicit spatial data availble that go beyond admin level 2 of the GADM dataset
# Crotteau2019    no coordinates at all
# Roman2021       landcover that can't be disagregated into the required land-use types
# stephens2017    from 1911
# fyfe2015        probably too old and temporally too coarsely resolved
# budBurst        no clear vegetation patterns available in the data
# herzschuh2021   pollen data that I'd ignore for now
# harrington2019  only for 1985
# hayes2021       data not available digitally
# krause2021      only peatland
# rustowicz2020   need to get from tifs, which don't have a crs
# bright2019      no commodities
# Batjes          no commodities
# BigEarthNet     grid data
# camara2020      grid data

# source(paste0(modlDir, "src/pillet2017.R")) unclear CRS and actually only 6 sites
# source(paste0(modlDir, "src/ogle2014.R")) the coordinates here are from a regular raster, so this is a modelled data product
# source(paste0(modlDir, "src/liangyun2019.R")) this is a reinterpretation of GOFC-GOLD and GFSAD30 datasets to the LCCS, which is thus unsuitable for us, since we'd have to reinterpret the reinterpretation, when we can instead work with GOFC-GOLD
