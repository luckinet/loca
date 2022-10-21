# Module 2 - The LUCKINet ontologies

The LUCKINet land use ontology is the basis for all harmonised concept concerning landcover, land use and commodity labels within LUCKINet (including the semantic matches between these harmonised concepts) and for all mappings to other ontologies. Strong focus is on mapping LUCKINet concepts to FAO concepts, but also other state of the art datasets are considered. The LUCKINet gazetteer is the basis for all mappings of territories in census data that do not yet correspond to our standard. The gazetteer is primarily based on GADM and the UN geoscheme. All territorial concepts are derived from these two schemes.

## Tools

Both, the land use ontology and the gazeteer are built with the 'ontologics' R-package, which is powered by the Simple Knowledge Organization System (skos, <https://www.w3.org/TR/skos-reference/>).

## LUCKINet land use ontology

The ontology has the following classes, their hierarchy is indicated by indentation (with an with a skos:broader semantic relation):

  -   **domain:** the overarching topics into which all other concepts are nested. At the current stage of this ontology, these are *lulc* (land use landcover) and *production systems*.
      -   **landcover group:** groups of landcover types (as the top-most lulc class) describing the respective *areas*, such as AGRICULTURAL AREAS, FOREST AND SEMI-NATURAL AREAS, WETLANDS and others.
          -   **landcover:** concepts that describe a unique cover type, largely taken from the CORINE classification, with small adaptions.
              -   **land use:** the socio-economic dimension, i.e., how the land under a certain cover is used. This level further distinguishes the target landcover types AGRICULTURAL AREAS and FOREST AND SEMI-NATURAL AREAS because they are in the focus of the first iteration of the LUCKINet land-use time-series.
      -   **group** groups of crop or livestock commodities as the top-most class of production systems.
          -   **class:** classes of similar commodities.
              -   **aggregate:** some commodities are very similar and thus reported together by some national statistical agencies, or the FAO (this class is at the same level as commodities).
              -   **commodity:** individual commodities (typically at the level of species or variety).

Moreover, 'commodity' and 'aggregate' are semantically related to 'land use' classes with skos:broader as well.

The ontology is an amalgamation of various datasets:

-   The FAO Indicative Crop Classification (ICC) v1.1, which provides a hierarchical structure of crop and livestock concepts (<https://datalab.review.fao.org/datalab/caliper/web/classification-page/43>).
-   The FAO Crops and livestock products dataset (QCL), which contains a range of concepts used by the FAO and frequently by statistical offices of nations that make their census data publicly available (<https://www.fao.org/faostat/en/#data/QCL>).
-   The FAO Land Use dataset (RL), which contains a hierarchical set of land-use concepts that represent the most harmonised representation of land-use concepts to date. (<https://www.fao.org/faostat/en/#data/RL>)
-   The FAO Forest Resource assessment (FRA), which contains a detailed set of forest classes that fits well together with the FAO Land Use vocabulary and represents relevant classes at a coarse scale (<https://www.fao.org/3/I8661EN/i8661en.pdf>, Sections 1b, 1e, 1f).
-   ESA CCI landcover, which contains the vocabulary of landcover classes we use throughout for allocating land use into the surface of the globe (<https://maps.elie.ucl.ac.be/CCI/viewer/download/CCI-LC_Maps_Legend.pdf>).
-   CORINE landcover classes (CLC), which is used as basis to define the (hierarchical) organisation of landcover and land-use classes (into which the crop and livestock commodities are nested). (<https://land.copernicus.eu/user-corner/technical-library/corine-land-cover-nomenclature-guidelines/html/>)

## LUCKINet gazetteer

The gazetteer contains the following classes:

-   **un_region:** region according to the UN geoscheme
    -   **un_subregion:** sub-region according to the UN geoscheme
        -   **al1:** the first administrative level of the GADM data-set
            -   **al2:** the second administrative level of the GADM data-set
                -   **al3:** the third administrative level of the GADM data-set
                    -   **al4:** the fourth administrative level of the GADM data-set
-   **nation:** groups of al1 concepts that together form a nation, which might span several of the other concepts (for example 'France', which is a combination of many territorial concepts across the whole world).

The gazetteer is based on the GADM <https://gadm.org/index.html>, which provides the currently best orgnanise set of territorial names and the UN geoscheme <https://en.wikipedia.org/wiki/United_Nations_geoscheme>, which provides organisation of nations into supersets.
