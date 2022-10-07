# Areal database

***module: 01_build_areal_database***

Our database of areal census statistics of several land-use dimensions is a major difference to other, similar projects. The database has been collated and harmonised with greatest of care with the help of dedicated database tools we built specifically for that very reason.

The land-use dimensions we cover here are primarily the FAO land-use categories, as a globally well-harmonised basis. These categories are largely distinguished into *Agricultural Area* (including temporary and permanent crops and land for grazing), *Forest* (including primary, planted and naturally regenerating forest) and *Other Land*.
To go into more detail, we collected for each nation the most detailed available sub-national data of 

  1) the area covered by various types of land-use
  2) the area covered by various types of forests 
  3) the planted and harvested area and the production of all crop-commodities that are grown in any region, which includes various data about grazing or pastures and also fallow land. 
  4) the number of livestock animals in a region.
  
Despite extensive efforts by he FAO to achieve a well-harmonised ontological basis also of agricultural concepts that allows readily interoperable workflows, we found wide ranges of values and labels in these sub-national data. Consequently we harmonised all land-use, forest and crop-commodity concepts into one (thematically) global ontology across all dimensions of land-use relevant to our project.

## Input data

Global data-sources include:

- FAOSTAT
- countrySTAT
- fAO Data-Lab
- worldbank
- agromaps
- SPAM
- ag-census

Regional data-sources include:

- eurostat - europe
- agriwanet - central asia

Special purpose data-sources inlcude:

- UNODC - Illicit commodities


## Dedicated tools and scripts

Everything based on a reproducable workflow including scripts that document every step in code

### tabshiftr


### arealDB






# This database is built primarily following the logic of the arealDB package,
# which is composed of three steps of data integration. The spatial basis is the
# GADM dataset and wherever possible native geometries, provided by statistical
# agencies, are used. The typically rather heterogeneous tables containing the
# census statistics are reorganised via schema-descriptions in the tabshiftr
# package.

## File names ----
# Scripts (in the folder '/src') are organised per nation and likewise are the
# resulting datasets stored as *.rds files with nation names as file names.

## Data tables ----
# Each script produces an rds-file that contains a data-frame of the harmonised
# data and a gpkg-file of the geometry associated to those data (typically based
# on GADM). Each data-frame then contains the following columns (obligatory
# variables have a * in the third column):
#
# - id          integer    *  observation identifier.
# - tabID       integer    *  the identifier of the specific table
#                             (see inv_tables.csv) from which the observation
#                             originates.
# - geoID       integer    *  the identifier of the specific geometry dataseries
#                             to which the observation is associated/where it
#                             occurs.
# - ahID        integer    *  the administrative hierarchy identifier,
#                             specifying both to which nation, but also to which
#                             territory nested therein the observation belongs.
# - luckinetID  character  *  the identifier of the land-use dimension of the
#                             observation. This would either be landcover,
#                             coarse land-use classes or commodities of
#                             agriculture.
# - year        YYYY       *  the year in which the census observation has been
#                             recorded.
# - harvested   numeric       the area that was harvested [hectare] (for
#                             agricultural commodities only).
# - production  numeric       the production quantity [tonnes] (for agricultural
#                             commodities only).
# - yield       numeric       the yield [production per harvested area] (for
#                             agricultural commodities only).
# - area        numeric       either the area of landcover or land-use or in
#                             case an agricultural commodity is quantified
#                             only in coarse detail without specification of
#                             whether it is measured by harvested or planted
#                             area [hectare].
# - headcount   numeric       the number of animals (for livestock only).
# - planted     numeric       the area that was planted [hectare] (for
#                             agricultural commodities only).
#
# Each geometry contains a layer per territorial level and the attribute table
# of each has the following columns:
#
# - fid     integer    territorial unit identifier.
# - nation  character  the nation to which the territorial unit belongs.
# - name    character  the name of the territorial unit.
# - level   integer    the hierarchical level in which the territorial unit is
#                      located.
# - ahID    integer    the administrative hierarchy identifier, specifying both
#                      to which nation the territory belongs, but also how it is
#                      nested therein.
# - geoID   integer    the identifier of the geometry dataseries from which the
#                      territory originates.
# - al1_id  numeric    that part of the ahID that signifies the first
#                      administrative level.
# - al2_id  numeric    in case the geometry contains the second level, this is
#                      that part of the ahID that signifies the second
#                      administrative level.
# - al3_id  numeric    in case the geometry contains the third level, this is
#                      that part of the ahID that signifies the third
#                      administrative level.
# - al4_id  numeric    in case the geometry contains the fourth level, this is
#                      that part of the ahID that signifies the fourth
#                      administrative level.
# - geometry           the geometric information of the territorial unit
#                      (simple features standard).

## The administrative hierarchy identifier ----
# At each administrative level a three-digit ID (ahID) is assigned to the
# alphabetically sorted unit names. When descending into a lower level, that ID
# is restarted at 0 within each parent unit. This allows to identify each
# territory and its hierarchical position right away.

