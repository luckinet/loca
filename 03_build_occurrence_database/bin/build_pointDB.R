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
if(!testDirectoryExists(occurrenceDBDir)){
  start_occurrenceDB(root = occurrenceDBDir)
}

# ontology for land-use and crop commodity concepts
luckiOnto <- load_ontology(path = ontoDir)

# gazetteer for territory names
gaz <- load_ontology(path = gazDir)
countries <- get_concept(x = tibble(class = "al1"), ontology = gaz) %>%
  arrange(label)



# check git for replacements of sp, should be in an old commit -->
# library(sp) i need this library for the char2dms function | where do you need
# this? wondering whether we could find another workaround to avoid the package
# altogether --> I need this for the char2dms function. So basically whenever
# the coordinates are in degrees instead of decimal. And this is in multiple
# scripts (around 10-15 I guess) the ones i found: deju1992.R, olivia2020.R,
# ramos-fabiel2018.R, sanchez-azofeita2017.R, marin2013.R -> I think this
# could be a solution, will write a function tmr:
# https://gist.github.com/valentinitnelav/ea94fea68227e05c453e13c4f7b7716b, https://github.com/ropensci/parzer

# build dataseries ----
#
# source(paste0(mdl0302, "src/00_template.R"))

source(paste0(mdl0302, "src/lucas.R")) # finalize ontology
source(paste0(mdl0302, "src/bastin2017.R"))
source(paste0(mdl0302, "src/oliva2020.R")) # PP - checked -- coordinates transform with sp


###### wip

# Abkürzungen
# checked: check for area, fid variable, publication year (Name), and duplicates (Distinct)
# ready: ready to run everything, including save Dataset

# source(paste0(mdl0302, "src/amir1991.R"))
# source(paste0(mdl0302, "src/anderson-teixeira2014.R")) # PP
# source(paste0(mdl0302, "src/anderson-teixeira2018.R")) # PP
# source(paste0(mdl0302, "src/anderson2003.R")) # PP
# source(paste0(mdl0302, "src/annighöfer2015.R")) # PP
source(paste0(mdl0302, "src/aleza2018.R")) # PP - ready
source(paste0(mdl0302, "src/asigbaase2019.R")) # PP - ready
source(paste0(mdl0302, "src/ausCovera.R")) # PP - ready
source(paste0(mdl0302, "src/ausCoverb.R")) # PP - ready
# source(paste0(mdl0302, "src/ballauff2021.R")) # PP
# source(paste0(mdl0302, "src/bayas2017.R")) this actually needs to be corrected, based on the 'cover' of cropland
# source(paste0(mdl0302, "src/bayas2021.R")) # PP
# source(paste0(mdl0302, "src/beyrs2015.R")) # PP
# source(paste0(mdl0302, "src/BIOTA.R")) # PP
source(paste0(mdl0302, "src/biodivInternational.R"))  # PP - ready
source(paste0(mdl0302, "src/bioTime.R")) # PP - ready
# source(paste0(mdl0302, "src/blaser2018.R")) # PP
source(paste0(mdl0302, "src/borer2019.R")) # PP - ready
source(paste0(mdl0302, "src/bordin2021.R")) # PP - ready
source(paste0(mdl0302, "src/bosch2008.R")) # PP - ready
source(paste0(mdl0302, "src/bücker2010.R")) # PP - ready
source(paste0(mdl0302, "src/broadbent2021.R")) # PP - ready
source(paste0(mdl0302, "src/caci.R")) # PP - ready
source(paste0(mdl0302, "src/camara2019.R")) # PP - ready
source(paste0(mdl0302, "src/capaverde2018.R")) # PP - ready
ource(paste0(mdl0302, "src/caughlin2016.R")) # PP - ready
source(paste0(mdl0302, "src/cawa.R")) # PP - ready
source(paste0(mdl0302, "src/coleman2008.R")) # PP - ready
# source(paste0(mdl0302, "src/craven2018.R"))
source(paste0(mdl0302, "src/crain2018.R")) # PP - ready
source(paste0(mdl0302, "src/cropHarvest.R")) # make ontology
source(paste0(mdl0302, "src/dataman.R")) # PP - ready
source(paste0(mdl0302, "src/davila-lara2017.R")) # PP - ready
source(paste0(mdl0302, "src/declercq2012.R")) # PP - ready
source(paste0(mdl0302, "src/deblécourt2017.R")) # PP - ready
source(paste0(mdl0302, "src/deju1992.R")) # PP  -- only 3 observations, maybe delete?
source(paste0(mdl0302, "src/dejonge2014.R")) # PP - ready
source(paste0(mdl0302, "src/doughty2015.R")) # PP - ready
source(paste0(mdl0302, "src/desousa2020.R")) # PP - ready
source(paste0(mdl0302, "src/ehbrecht2021.R")) # PP - ready
source(paste0(mdl0302, "src/esc.R")) # PP - ready
source(paste0(mdl0302, "src/euroCrops.R"))
source(paste0(mdl0302, "src/falster2015.R")) # PP - ready
source(paste0(mdl0302, "src/fang2021.R")) # PP - ready
source(paste0(mdl0302, "src/faye2019.R")) # PP - ready
source(paste0(mdl0302, "src/feng2022.R")) # PP - ready
source(paste0(mdl0302, "src/firn2020.R")) # PP - ready
source(paste0(mdl0302, "src/flores-moreno2017.R")) # PP - ready
source(paste0(mdl0302, "src/ForestGEO.R"))  # PP - ready
source(paste0(mdl0302, "src/franklin2015.R")) # PP - ready
source(paste0(mdl0302, "src/franklin2018.R")) # PP - ready
source(paste0(mdl0302, "src/gallhager2017.R")) # PP - ready
source(paste0(mdl0302, "src/gashu2021.R")) # PP - ready
source(paste0(mdl0302, "src/gebert2019.R")) # PP - ready
source(paste0(mdl0302, "src/genesys.R")) # PP - check with countries
source(paste0(mdl0302, "src/GFSAD30.R")) # PP - ready
source(paste0(mdl0302, "src/glato2017.R")) # PP - ready
source(paste0(mdl0302, "src/GLOBE.R")) # PP - ready
source(paste0(mdl0302, "src/grosso2013.R")) # PP - ready
source(paste0(mdl0302, "src/Grump.R")) # PP - ready
# source(paste0(mdl0302, "src/guitet2015.R")) # PP
source(paste0(mdl0302, "src/habel2020.R")) # PP - ready
source(paste0(mdl0302, "src/haeni2016.R")) # PP - ready
source(paste0(mdl0302, "src/hardy2019.R")) # PP - ready
source(paste0(mdl0302, "src/hengl2020.R")) # PP - ready
source(paste0(mdl0302, "src/hogan2018.R")) # PP - ready
source(paste0(mdl0302, "src/hilpold2018.R")) # PP - ready
source(paste0(mdl0302, "src/hylander2018.R")) # PP - ready
source(paste0(mdl0302, "src/hudson2016.R")) # PP - ready
source(paste0(mdl0302, "src/infys.R")) # PP - ready
source(paste0(mdl0302, "src/ingrisch2014.R")) # PP - ready
source(paste0(mdl0302, "src/jackson2021.R")) # PP - ready
source(paste0(mdl0302, "src/jonas2020.R")) # PP - ready
source(paste0(mdl0302, "src/jordan2020.R")) # PP - ready
source(paste0(mdl0302, "src/jung2016.R")) # PP - ready
source(paste0(mdl0302, "src/karlsson2017.R")) # PP - ready
source(paste0(mdl0302, "src/kebede2019.R")) # PP - ready
source(paste0(mdl0302, "src/kenefic2015.R")) # PP - ready
source(paste0(mdl0302, "src/kenefic2019.R")) # PP - ready
source(paste0(mdl0302, "src/knapp2021.R")) # PP - ready
source(paste0(mdl0302, "src/kormann2018.R")) # PP - ready
source(paste0(mdl0302, "src/koskinen2018.R")) # PP - ready
source(paste0(mdl0302, "src/lamond2014.R")) # PP - ready
source(paste0(mdl0302, "src/ledig2019.R")) #  PP - ready
source(paste0(mdl0302, "src/ledo2019.R")) # PP - ready
source(paste0(mdl0302, "src/leduc2021.R")) # PP - ready
source(paste0(mdl0302, "src/llorente2018.R")) # PP - ready
source(paste0(mdl0302, "src/maas2015.R")) # PP - ready
source(paste0(mdl0302, "src/mandal2016.R")) # PP - ready
source(paste0(mdl0302, "src/MapBiomas.R")) # PP - ready
source(paste0(mdl0302, "src/marin2013.R")) # PP  -- conversion of coordinates to decimal needed
source(paste0(mdl0302, "src/meddens2017.R")) # PP - ready
source(paste0(mdl0302, "src/merschel2014.R")) # PP - ready
source(paste0(mdl0302, "src/mgap.R")) # PP - ready
source(paste0(mdl0302, "src/moghaddam2014.R")) # PP - ready
source(paste0(mdl0302, "src/monro2017.R")) # PP - ready
source(paste0(mdl0302, "src/moonlight2020.R")) # PP - ready
# source(paste0(mdl0302, "src/mitchard2014.R"))# PP
source(paste0(mdl0302, "src/nalley2020.R")) # PP - ready
source(paste0(mdl0302, "src/nthiwa2020.R")) # PP - ready
source(paste0(mdl0302, "src/nyirambangutse2017.R")) # PP - ready
source(paste0(mdl0302, "src/ofsa.R")) # PP - ready
source(paste0(mdl0302, "src/oldfield2018.R")) # PP
source(paste0(mdl0302, "src/osuri2019.R")) # PP - ready
source(paste0(mdl0302, "src/oswald2016.R")) # PP - ready
source(paste0(mdl0302, "src/pärn2018.R"))  # PP - ready
source(paste0(mdl0302, "src/pennington.R")) # PP - ready
source(paste0(mdl0302, "src/perrino2012.R")) # PP - ready
source(paste0(mdl0302, "src/plantVillage.R")) # PP - ready
source(paste0(mdl0302, "src/quisehuatl-medina2020.R")) # PP - ready
source(paste0(mdl0302, "src/raley2017.R")) # PP - ready
source(paste0(mdl0302, "src/raman2006.R")) # PP - ready
source(paste0(mdl0302, "src/ramos-fabiel2018.R")) # PP - ready -- coordinates transform with sp
source(paste0(mdl0302, "src/ratnam2019.R")) # PP - ready
source(paste0(mdl0302, "src/raymundo2018.R")) # PP - ready
source(paste0(mdl0302, "src/robichaud2017.R")) # PP - ready
source(paste0(mdl0302, "src/sanches2018.R")) # PP - ready
source(paste0(mdl0302, "src/sanchez-azofeita2017.R")) # PP - ready -- coordinates transform with sp
source(paste0(mdl0302, "src/schooley2005.R")) # PP - ready
source(paste0(mdl0302, "src/schneider2020.R")) # PP - ready
source(paste0(mdl0302, "src/seo2014.R")) # PP - ready
source(paste0(mdl0302, "src/shooner2018.R")) # PP - ready
source(paste0(mdl0302, "src/silva2019.R")) # PP - ready
source(paste0(mdl0302, "src/sinasson2016.R")) # PP - ready
source(paste0(mdl0302, "src/stevens2011.R")) # PP - ready
source(paste0(mdl0302, "src/sullivan2018.R")) # PP - ready
source(paste0(mdl0302, "src/surendra2021.R")) # PP - ready
source(paste0(mdl0302, "src/srdb.R")) # PP - ready
source(paste0(mdl0302, "src/szantoi2020.R")) # PP - ready
source(paste0(mdl0302, "src/szantoi2021.R")) # PP - ready
source(paste0(mdl0302, "src/tateishi2014.R"))# PP - ready
source(paste0(mdl0302, "src/tedonzong2021.R"))  # PP - ready
source(paste0(mdl0302, "src/teixeira2015.R")) # PP - ready
source(paste0(mdl0302, "src/trettin2017.R"))  # PP - ready
source(paste0(mdl0302, "src/truckenbrodt2017.R")) # PP - ready
source(paste0(mdl0302, "src/vanhooft2015.R")) # PP - ready
source(paste0(mdl0302, "src/vieilledent2016.R")) # PP - ready
source(paste0(mdl0302, "src/vijay2016.R")) # PP - ready
source(paste0(mdl0302, "src/wei2018.R")) # PP - ready
source(paste0(mdl0302, "src/westengen2014.R")) # PP - ready
source(paste0(mdl0302, "src/wood2016.R")) # PP - ready

source(paste0(mdl0302, "src/woollen2017.R")) # PP - ready
source(paste0(mdl0302, "src/wortmann2020.R")) # PP - ready
source(paste0(mdl0302, "src/wortmann2019.R")) # PP - ready
source(paste0(mdl0302, "src/zhang1999.R")) # PP - ready

# source(paste0(mdl0302, "src/descals2020.R")) # - PP i corrected the year of publication  - run this script again
# source(paste0(mdl0302, "src/fritz2017.R"))
# source(paste0(mdl0302, "src/jolivot2021.R"))
# source(paste0(mdl0302, "src/ouedraogo2016.R"))
# source(paste0(mdl0302, "src/lesiv2020.R"))
# source(paste0(mdl0302, "src/mchairn2014.R"))
# source(paste0(mdl0302, "src/mchairn2021.R"))
# source(paste0(mdl0302, "src/potapov2021.R"))
# source(paste0(mdl0302, "src/schepaschenko.R"))
# source(paste0(mdl0302, "src/szyniszewska2019.R"))
# source(paste0(mdl0302, "src/wenden2016.R"))
source(paste0(mdl0302, "src/breizhCrops.R"))            # in principle done, but only one area implemented so far
source(paste0(mdl0302, "src/californiaCrops.R"))         # needs a lot of work
source(paste0(mdl0302, "src/landpks.R"))                     # extract info from 'land_use', 'grazed', 'grazing' and 'flooding'
source(paste0(mdl0302, "src/li2018.R"))                      # make dates
source(paste0(mdl0302, "src/splot.R"))                       # clarify which values to use --> we can at least assign "Natural and semi-natural areas"
source(paste0(mdl0302, "src/thornton2014.R"))                # make ontology, dates need a fix
source(paste0(mdl0302, "src/gyga.R"))                        # wip



# already integrated by Caterina, skip for now but ontology harmonisation is still missing

source(paste0(mdl0302, "src/gbif.R"))
source(paste0(mdl0302, "src/osm.R")) # where is the folder?
source(paste0(mdl0302, "src/sen4cap.R")) # no data in folder


# tie everything together ----
source(paste0(mdl0302, "src/99_make_database.R"))


# and check whether it's all as expected ----
source(paste0(mdl0302, "src/99_test-output.R"))


# finally, update the luckinet-profile ----
profile <- load_profile(root = dataDir, name = model_name, version = model_version)

profile$occurrenceDB <- DB_version
write_profile(root = dataDir, name = model_name, version = model_version,
              parameters = profile)


# work in process ----
#
# source(paste0(mdl0302, "src/beenhouwer2013.R")) # try to find those citations with the most data on coffee and cacao
# source(paste0(mdl0302, "src/bocquet2019.R")) # assign all values - part of Radiant MLHub - i skip this for now
# source(paste0(mdl0302, "src/drakos2020.R")) # this is interesting and needs to be scrutinised further
# 2965 -landcover- 1983 -descrp- source(paste0(mdl0302, "src/gofc-gold.R")) # assign all values --> this one is done i think, the  only in-situ data I found was the data made by tateishi2014 which is harmonised
# source(paste0(mdl0302, "src/hunt2013.R")) # find reference and clean data, make ontology
# 96722 -vegetation_class- source(paste0(mdl0302, "src/iscn.R")) # assign all values -- here I do not find any LULC variables
# source(paste0(mdl0302, "src/jin2021.R")) # only small section of the land, so probably not worth the effort
# davalos2016 - skip for now, they use UNODOC data, try to get the orginal data from UN


########
# prio 2
########
# source(paste0(mdl0302, "src/keil2019.R"))      do this first! (I know Petr personally and his projects are extremely well documented, plus we can ask him on relatively short notice, if something is unclear)
# source(paste0(mdl0302, "src/conrad2019.R"))    Woher kommen die Daten, würde gerne zumindest die Publikation angeben?
# source(paste0(mdl0302, "src/ma2020.R"))        read data from pdf
# source(paste0(mdl0302, "src/piponiot2016.R"))  13 -forest- dates need a sequence between two columns, but no information on census repetition times given in publi.
# source(paste0(mdl0302, "src/reiner2018.R"))    needs a lot of cleaning
# source(paste0(mdl0302, "src/rineer2021.R"))    requires a lot of work to put all labels into a common file
# source(paste0(mdl0302, "src/bright2019.R"))    no commodities -> could be derived, as the species are given.
# source(paste0(mdl0302, "src/batjes2021.R"))    no commodities -> as they distinguish soil profiles by biome, we should try to find these information and make use of them as "landcover" at least.
# source(paste0(mdl0302, "src/ploton2020.R"))    no Dates 191562 -forest- -> since these are extremely many data, and they say that it's between 2000 and the early 2010s, we could also take the median, so let's say 2006 for all of them. Or contact the authors, but this is def. one dataset we need to include, due to the sheer size of the dataset.
# source(paste0(mdl0302, "src/bagchi2017.R"))    6 -forest- assign all values PP - missing Information on projection -> doesnt WGS84 fit? It looks like decimal representation of it.
# source(paste0(mdl0302, "src/empres.R"))        download defect - no metadata for  data file in folder -> have added a link to the new website, def. worth exploring
# source(paste0(mdl0302, "src/krause2021.R"))    only peatland -> but this is def. also needed and it's part of the ontology
# source(paste0(mdl0302, "src/roman2021.R"))     landcover that can't be disagregated into the required land-use types -> with the new ontology, it should be possible, at least at 'landcover group' level
# source(paste0(mdl0302, "src/wang2020.R"))      has many grazing data with coordinates and dates available
# source(paste0(mdl0302, "src/chain-guadarrama2017.R"))
# source(paste0(mdl0302, "src/SAMPLESSoilEmissions.R"))
# source(paste0(mdl0302, "src/caviglia2000.R"))
# source(paste0(mdl0302, "src/bouthiba2008.R"))
# source(paste0(mdl0302, "src/camara2020.R"))


########
# prio 3 (datasets that need to be extracted from (labelled georeferenced) tifs)
########
# source(paste0(mdl0302, "src/eurosat.R"))
# source(paste0(mdl0302, "src/WCDA.R"))
# source(paste0(mdl0302, "src/haarhoff2019.R"))
# source(paste0(mdl0302, "src/BigEarthNet.R"))


########
# prio 4 (hard to get data)
########
# source(paste0(mdl0302, "src/timesen2crop.R"))  coordinates not readily available -> authors already contacted!
# source(paste0(mdl0302, "src/AusPlots.R"))      some of the Vegetation-Communities_*.csv files could be interesting, but I think it's quite the hassle to extrac these data and harmonize them with the ontology
# source(paste0(mdl0302, "src/baad.R"))          dates are in: baad_metadate.csv, needs extraction by hand


## time periods missing
#
# source(paste0(mdl0302, "src/adina2017.R"))
# source(paste0(mdl0302, "src/alvarez-davila2017.R")) 200 -forest- needs clarification (mail)
# source(paste0(mdl0302, "src/brown2020.R"))          11 -forest-
# source(paste0(mdl0302, "src/bauters2019.R"))        15 -forest-
# source(paste0(mdl0302, "src/chaudhary2016.R"))      1008 -forest-
# source(paste0(mdl0302, "src/döbert2017.R"))         180 -forest-
# source(paste0(mdl0302, "src/draper2021.R"))         1240 -forest-
# source(paste0(mdl0302, "src/gibson2011.R"))         2220 -landuse-
# source(paste0(mdl0302, "src/hoffman2019.R"))
# source(paste0(mdl0302, "src/ibanez2018.R"))         434 -forest-
# source(paste0(mdl0302, "src/ibanez2020.R"))         51 -forest-
# source(paste0(mdl0302, "src/zhao2014.R"))           2897 -cropland-
# source(paste0(mdl0302, "src/lewis2013.R"))          260 -forest-
# source(paste0(mdl0302, "src/mendoza2016.R"))        218 -cropland-
# 299 - source(paste0(mdl0302, "src/see2016a.R")) # dates missing, the representiv column is missing. I THINK THIS DATASET IS PART OF FRITZ2017
# 175 - source(paste0(mdl0302, "src/see2016c.R")) # dates missing, I THINK THIS DATASET IS PART OF FRITZ2017
# 49 - source(paste0(mdl0302, "src/see2016b.R")) # dates missing I THINK THIS DATASET IS PART OF FRITZ2017
# source(paste0(mdl0302, "src/see2022.R"))
# source(paste0(mdl0302, "src/sankaran2007.R"))       854 -forest-
# source(paste0(mdl0302, "src/hou2017.R"))            802 -landcover-
# source(paste0(mdl0302, "src/lasky2015.R"))          1945 -sorghum-
# source(paste0(mdl0302, "src/scarcelli2019.R"))      168 -yam-
# source(paste0(mdl0302, "src/crowther2019.R"))
# source(paste0(mdl0302, "src/sarti2020.R"))
# source(paste0(mdl0302, "src/potts2017.R"))          14 -forest-
# source(paste0(mdl0302, "src/parizzi2017.R"))
# source(paste0(mdl0302, "src/vilanova2018.R"))       50 -forest- difficult to reconstruct, some times are given in the method section of the paper
# source(paste0(mdl0302, "src/menge2019.R"))          44 -forest-
# source(paste0(mdl0302, "src/morera-beita2019.R"))   20 -forest-
# source(paste0(mdl0302, "src/trettin2020.R"))        17 -mangrove-


## double check ----
#


## final decision reached (here only with reason for exclusion) ----
# Sheils2019      missing cor now in contact authors (PP)
# OBrian2019      missing cor of plots --> moved to discarded
# CV4A            already included in cropHarvest as 'african_crops_kenya'
# GAFC            already included in cropHarvest as 'african_crops_tanzania'
# Waha2016        no explicit spatial data availble that go beyond admin level 2 of the GADM dataset
# Crotteau2019    no coordinates at all
# stephens2017    from 1911
# fyfe2015        historical data
# budBurst        no clear vegetation patterns available in the data
# herzschuh2021   pollen data that I'd ignore for now -> ok
# harrington2019  only for 1985
# hayes2021       data not available digitally
# rustowicz2020   need to get from tifs, which don't have a crs
# mishra1995      only experiment site coordinates, not on plot level
# orta2002        only experiment site coordinates, not on plot level
# oweis2000       only experiment site coordinates, not on plot level
# pandey2001      only experiment site coordinates, not on plot level
# sharma1990      only experiment site coordinates, not on plot level
# sharma2001      only experiment site coordinates, not on plot level
# zhang2002       only experiment site coordinates, not on plot level
# souza2019       only experiment site coordinates, not on plot level
# pillet2017      unclear CRS and actually only 6 sites
# ogle2014        the coordinates here are from a regular raster, so this is a modelled data product -> need to reword in the table to sth like simply "modelled data prodcut as evident from the paper" or so
# liangyun2019    this is a reinterpretation of GOFC-GOLD and GFSAD30 datasets to the LCCS, which is thus unsuitable for us, since we'd have to reinterpret the reinterpretation, when we can instead work with GOFC-GOLD
# tuck2014        coordinates missing, even though they are used for data preparation
# reetsch2020     coordinates of farms (houshold survey) not the actual fields
# conabio         this seems to be primarily on the number of plant occurrences, and I don't see a way to easily extract information on landcover or even land use
