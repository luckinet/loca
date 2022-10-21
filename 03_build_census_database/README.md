# Module 3.1 - Census database

The database of areal census statistics contains official land use, forestry and agricultural commodity statistics from the Food and Agriculture Organization (FAO) at national level and from national or regional statistical agencies at the finest possible sub-national level, if available or also from the FAO, for example via countrySTAT (<https://www.fao.org/in-action/countrystat/en/>) or the FAO Data Lab (<https://www.fao.org/datalab/website/web/home>).

The variables we are interested in are those variables that are already harmonized by the FAO:

1)  the area covered by the overarching land use classes, as defined in the FAO Land Use data-set (RL) (<https://www.fao.org/faostat/en/#data/RL>).
2)  the area covered by various types of forests as defined in the FAO Forest Resource Assessment (FRA) (<https://www.fao.org/3/I8661EN/i8661en.pdf>).
3)  the planted and harvested area and the production of all agricultural commodities that are grown in any region, which may include various data about grazing or pastures and also fallow land, even though they are often instead reported as "land use" statistics.
4)  the headcount of livestock animals in a region, as defined, together with crops, in the FAO Crop and Livestock products data-set (<https://www.fao.org/faostat/en/#data/QCL>).

## Tools

The census database is built with the R packages `arealDB` for organizing the database, `tabshiftr` for reorganizing messy tables and `ontologics` to harmonize concepts. The spatial basis is the GADM data-set (<https://gadm.org/index.html>) or, geometries provided by the national statistical agencies, if available.

Scripts (in the folder '/src') are organised either per data-series (such as fao, countrystat or eurostat) or per nation. Each script follows a clearly defined template, where

1)  the meta-data are recorded,
2)  concepts are entered into the LUCKINet land use ontology,
3)  data tables and optional geometries are recorded and
4)  data tables and optional geometries are normalized (i.e. their format is translated to a common standard via `tabshiftr`).

## Database structure

Each script produces an `*.rds`-file that contains a data-frame of the harmonized data and a geopackage (gpkg) file of the geometry associated to those data (typically based on GADM). Each harmonized table then contains the following columns:

| name       | type      | description                                                                                                                                                                                              |
|:--------------------|:--------------------|:-----------------------------|
| id         | integer   | observation identifier                                                                                                                                                                                   |
| tabID      | integer   | the identifier of the specific table (see `inv_tables.csv`) from which the observation originates                                                                                                        |
| geoID      | integer   | the identifier of the specific geometry data-series to which the observation is associated/where it occurs                                                                                               |
| ahID       | integer   | the administrative hierarchy identifier                                                                                                                                                                  |
| luckinetID | character | the identifier of the land use dimension of the observation. This would either be landcover, coarse land-use classes or commodities of agriculture                                                       |
| year       | YYYY      | the year in which the census observation has been recorded                                                                                                                                               |
| harvested  | numeric   | the area that was harvested [hectare] (for agricultural commodities only)                                                                                                                                |
| planted    | numeric   | the area that was planted [hectare] (for agricultural commodities only)                                                                                                                                  |
| area       | numeric   | either the area of landcover or land use or in case an agricultural commodity is quantified only in coarse detail without specification of whether it is measured by harvested or planted area [hectare] |
| production | numeric   | the production quantity [tonnes] (for agricultural commodities only)                                                                                                                                     |
| yield      | numeric   | the yield [production per harvested area] (for agricultural commodities only)                                                                                                                            |
| headcount  | numeric   | the number of animals (for livestock only)                                                                                                                                                               |
| ...        | numeric   | possibly other variables that are also reported and which may give some indication of or hint at the above variables                                                                                     |

Each geometry contains a layer per territorial level with a associated attribute table that has the following columns:

| name     | type      | description                                                                                                                  |
|:--------------------|:--------------------|:-----------------------------|
| fid      | integer   | territorial unit identifier                                                                                                  |
| nation   | character | the nation to which the territorial unit belongs                                                                             |
| name     | character | the name of the territorial unit                                                                                             |
| level    | integer   | the hierarchical level in which the territorial unit is located                                                              |
| ahID     | integer   | the administrative hierarchy identifier                                                                                      |
| geoID    | integer   | the identifier of the geometry dataseries from which the territory originates                                                |
| al1_id   | numeric   | that part of the ahID that signifies the first administrative level                                                          |
| al2_id   | numeric   | in case the geometry contains the second level, this is that part of the ahID that signifies the second administrative level |
| al3_id   | numeric   | in case the geometry contains the third level, this is that part of the ahID that signifies the third administrative level   |
| al4_id   | numeric   | in case the geometry contains the fourth level, this is that part of the ahID that signifies the fourth administrative level |
| geometry | geometry  | the geometric information of the territorial unit (simple features standard)                                                 |

## The administrative hierarchy identifier

At each administrative level a three-digit ID (ahID) is assigned to the alphabetically sorted unit names. When descending into a lower level, that ID is restarted at 0 within each parent unit. This allows to identify each territory and its hierarchical position in the gazetteer right away.

## Post-processing

After collecting all information in a harmonized database some further steps are required. The final script `99_make_database.R` carries these out:

-   summarize values per territorial unit, in case they were double reported or when external concepts had to be harmonized so that several external concepts refer to the same harmonized concept.
-   optionally interpolate missing values (depending on the model run)
-   carry out checks that ensure the patterns are within reasonable bounds.
-   determine quality flags for provenance documentation.
