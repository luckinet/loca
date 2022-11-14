# Module 3.2 - Occurrence database

The database of the occurrence records contains in-situ landcover, land use or agricultural commodities occurrences from already elsewhere collated (but incomplete) databases and the (grey) literature.

## Tools

The occurrence database is built with [functions included in this repository](https://github.com/luckinet/luca/blob/main/02_boot_functions.R) for organizing the database and `ontologics` to harmonize concepts.

Each script follows a clearly defined template, where

1)  the meta-data are recorded,
2)  concepts are entered into the LUCKINet land use ontology,
3)  the data are processed to end up in a standardized format.

## Database structure

Each script produces an `*.rds`-file that contains a data-frame of the harmonized data of that data-set and, in case the data-set is an areal data-set, a geopackage (gpkg) file that contains the polygons. Each harmonized table then contains the following columns:

| name          | type      | description                                                                                                                          |
|:--------------|:----------|:-------------------------------------------------------------------------------------------------------------------------------------|
| datasetID     | class     | data-set descriptor                                                                                                                  |
| fid           | integer   | the feature ID of each sample                                                                                                        |
| type          | class     | whether it's a "point" or "areal" sample                                                                                             |
| country       | class     | in case the country is given in the original data-set, provide it here, otherwise ignore                                             |
| x             | numeric   | the longitude (centroid) of the sample                                                                                               |
| y             | numeric   | the latitude (centroid) of the sample                                                                                                |
| epsg          | numeric   | the EPSG representation of the coordinate reference system (<https://epsg.io>)                                                       |
| year          | YYYY      | the year in which the data was collected                                                                                             |
| month         | MM        | the month in which the data was collected                                                                                            |
| day           | DD        | the day in which the data was collected                                                                                              |
| irrigated     | logical   | whether or not the sample has an irrigated land use                                                                                  |
| area          | numeric   | in case the values are taken from plots, but no spatial object but instead the area of the plot is given, provide it here (m²)       |
| presence      | logical   | whether the data-point indicates presence of 'externalValue' (TRUE), or whether it indicates its absence (FALSE)                     |
| externalValue | character | the explicit value that is reported in the original data-set                                                                         |
| externalID    | class     | the explicit ID that is reported in the original data-set (can be NA)                                                                |
| LC1/2/3_orig  | class     | in case the data-set contains additionally information on landcover (not land use), the explicit value is recorded here              |
| sample_type   | class     | the type of sampling, either "field (sampling)", "visual interpretation", "area knowledge", "meta study" or "modeled (data-product)" |
| collector     | class     | what group of people has collected the data, either "expert", "citizen scientist" or "student"                                       |
| purpose       | class     | the purpose of data collection, either "monitoring", "validation", "study" or "map development"                                      |

## Post-processing

After collecting all information in a harmonized database some further steps are required. The final script `99_make_database.R` carries these out:

-   re-project all coordinates to epsg:4326 (WGS84), in case they are not yet in this coordinate reference system.
-   calculate precision of the coordinates (<https://en.wikipedia.org/wiki/Decimal_degrees>).
-   derive the spatial unit size.
-   carry out checks via `coordinateCleaner` R package.
-   determine quality flags for provenance documentation.
