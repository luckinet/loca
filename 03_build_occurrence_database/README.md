

```r
# 01_build_point_database

# File names of the source scripts (in the folder '/src') contain a character
# string that either identifies the main author and year of publication, or the
# platform on which the dataset has been published.

## Data tables ----
# Each script produces an rds-file that contains a data-frame of the harmonised
# data of that dataset and, in case the dataset is an areal dataset, a gpkg-file
# that contains the polygons. The script '00_template.R' documents the steps
# that should be taken to end up with the data-frame structure required by the
# database. Each data-frame then contains the following columns (obligatory
# variables have a * in the third column):
#
# - datasetID      class      *  dataset descriptor
# - fid            integer    *  the feature ID of each sample
# - type           class      *  whether it's a "point" or "areal" sample
# - country        class         in case the country is given in the original
#                                dataset, provide it here, otherwise ignore
# - x              numeric    *  the longitude (centroid) of the sample
# - y              numeric    *  the latitude (centroid) of the sample
# - epsg           numeric    *  the EPSG representation of the coordinate
#                                reference system (https://epsg.io)
# - year           YYYY       *  the year in which the data was collected
# - month          MM            the month in which the data was collected
# - day            DD            the day in which the data was collected
# - irrigated      logical       whether or not the sample has an irrigated
#                                land-use
# - area           numeric    *  in case the values are taken from plots, but no
#                                spatial object but instead the area of the plot
#                                is given, provide it here (m²)
# - presence       logical    *  whether the data-point indicates presence of
#                                'externalValue' (TRUE), or whether it indicates
#                                its absence (FALSE)
# - externalValue  character  *  the explicit value that is reported in the
#                                original dataset
# - externalID     class         the explicit ID that is reported in the
#                                original dataset (can be NA)
# - LC1/2/3_orig   class         in case the dataset contains additionally
#                                information on landcover (not landuse), the
#                                explicit value is recorded here
# - sample_type    class      *  the type of sampling, either "field (sampling)",
#                                "visual interpretation", "area knowledge",
#                                "meta study" or "modelled (dataproduct)"
# - collector      class      *  what group of people has collected the data,
#                                either "expert", "citizen scientist" or
#                                "student"
# - purpose        class      *  the purpose of data collection, either
#                                "monitoring", "validation", "study" or "map
#                                development"

## Post-processing ----
# The rds-files are all stored in the root folder of the database specified
# below in start_pointDB(). The final script, '99_make_database.R' then goes
# through all those files and does some post-processing to finally store the
# overall database into the file 'luckinet_lu_pointDB.rds':
#
# - re-project all coordinates to epsg:4326 (WGS84), in case they are not yet in
#   this coordinate reference system.
# - calculate precision of the coordinates
#   (https://en.wikipedia.org/wiki/Decimal_degrees).
# - derive the spatial unit size (find documentation on that in
#   '99_make_database.R').
# - ensure that all values luckinetID occur in the luckinet ontology and that
#   the resulting ontology is valid.
# - derive quality flags (find documentation on that in '99_make_database.R').
# - validate that the values in 'sample_type', 'collector' and 'purpose' follow
#   a common standard.
```

