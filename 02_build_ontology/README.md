# Module 2 - The LUCKINet ontologies

The LUCKINet land use ontology is the basis for all harmonized concept concerning landcover, land use and commodity labels within LUCKINet (including the semantic matches between these harmonized concepts) and for all mappings to other ontologies. Strong focus is on mapping LUCKINet concepts to FAO concepts, but also other state of the art data-sets are considered. The LUCKINet gazetteer is the basis for all mappings of territories in census data that do not yet correspond to our standard. The gazetteer is primarily based on GADM and the UN geoscheme. All territorial concepts are derived from these two schemes.

## Tools

Both, the land use ontology and the gazetteer are built with the `ontologics` R-package, which is powered by the Simple Knowledge Organization System (skos, <https://www.w3.org/TR/skos-reference/>).

## LUCKINet land use ontology

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7228853.svg)](https://doi.org/10.5281/zenodo.7228853)
[![CC-By license](https://img.shields.io/badge/License-CC--BY-blue.svg)](https://creativecommons.org/licenses/by/4.0)
[![Website https://geokur-dmp2.geo.tu-dresden.de/Skosmos/skosmos/en/](https://img.shields.io/website-up-down-green-red/http/monip.org.svg)](https://geokur-dmp2.geo.tu-dresden.de/Skosmos/skosmos/en/)


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

The ontology is an amalgamation of various data-sets:

-   The FAO Indicative Crop Classification (ICC) v1.1, which provides a hierarchical structure of crop and livestock concepts (<https://datalab.review.fao.org/datalab/caliper/web/classification-page/43>).
-   The FAO Crops and livestock products data-set (QCL), which contains a range of concepts used by the FAO and frequently by statistical offices of nations that make their census data publicly available (<https://www.fao.org/faostat/en/#data/QCL>).
-   The FAO Land Use data-set (RL), which contains a hierarchical set of land use concepts that represent the most harmonized representation of land use concepts to date. (<https://www.fao.org/faostat/en/#data/RL>)
-   The FAO Forest Resource assessment (FRA), which contains a detailed set of forest classes that fits well together with the FAO Land Use vocabulary and represents relevant classes at a coarse scale (<https://www.fao.org/3/I8661EN/i8661en.pdf>, Sections 1b, 1e, 1f).
-   ESA CCI landcover, which contains the vocabulary of landcover classes we use throughout for allocating land use into the surface of the globe (<https://maps.elie.ucl.ac.be/CCI/viewer/download/CCI-LC_Maps_Legend.pdf>).
-   CORINE landcover classes (CLC), which is used as basis to define the (hierarchical) organisation of landcover and land-use classes (into which the crop and livestock commodities are nested). (<https://land.copernicus.eu/user-corner/technical-library/corine-land-cover-nomenclature-guidelines/html/>)

The aim in LUCKINet is to allocate land use concepts to the full terrestrial surface of the globe in a way that is thematically, spatially and temporally consistent. Thematic consistency is tackled by the land use ontology. To this end a definition is required where each concept is a narrower concept of one and only one broader concept. The most basal concepts are consequently plant species or varieties that act physiologically uniquely, so that they can be modeled as a unique, independent entity. At the topmost level we distinguish this into *AGRICULTURAL AREAS* (including temporary and permanent crops and land for grazing), *FOREST AND SEMI-NATURAL AREAS* (including primary, planted and naturally regenerating forest) and *ARTIFICIAL SURFACES*, *WETLANDS* and *WATER BODIES*. Those categories have already been globally well-harmonized by the FAO. However, despite extensive efforts by the FAO to achieve a well-harmonized ontological basis of all relevant concepts, a fully interoperable workflow at the finest level is not yet fully achieved (presumably due to the historical and organic growth of their vocabulary). Just one example that shows that further harmonization work was required lays in the fact that various agricultural concepts, such as flax, which has the broader concept *soft fibers* and linseed, which has the broader concept oil-seeds are actually produced by the same plant species (*Linum usitatissimum* in this case). The approach to allocating "*commodities"* in LUCKINet depends on the bio-geochemical and socio-economic suitability (see module 4), which is unique per plant species and not per (FAO) commodity. Thus, it was necessary to harmonize the FAO concepts further. After studying the FAO concept list, we found that the actually distinguishing factor of such double entries lays in the way the plant is used to produce the commodity. Hence, we introduced the additional attribute *use-type* into our ontology. After excluding all duplicated entries and deciding into which broader concept to nest the single concepts, we assigned use-type(s) to the unique concepts, for instance that linseed is used as *food* and as *fiber* crop.

Often it looks at first sight as though many of the data are not interoperable with one another, however, when matching concepts from the external data-sets with the harmonized concepts, while providing (1) the semantic relation and (2) a certainty assessment for the match, interoperability can be enhanced drastically. We do not simply set two concepts the same without documenting this, but compare their definitions and then record them accordingly. For instance, when a external concept is "more or less the same" as a harmonized concept, even though the definition may differ in a nuanc that is not relevant for us or the external concept is the same but uses a different term we record it as *close* match. If the definition clearly indicates that a concept is nested in a harmonized concept we record it as *narrower* match, for instance, an *Atlantic forest* is a special case of *deciduous forest* and is thus not recorded as *close* match, but as *narrow* match to deciduous forest. Recording it in that way allows to retain the true identity of that in-situ record, but also allows us to make use of the fact that it is also a deciduous forest, so we can use that record as though it was a deciduous forest.

## LUCKINet gazetteer

The gazetteer contains the following classes:

-   **un_region:** region according to the UN geoscheme
    -   **un_subregion:** sub-region according to the UN geoscheme
        -   **al1:** the first administrative level of the GADM data-set
            -   **al2:** the second administrative level of the GADM data-set
                -   **al3:** the third administrative level of the GADM data-set
                    -   **al4:** the fourth administrative level of the GADM data-set
-   **nation:** groups of al1 concepts that together form a nation, which might span several of the other concepts (for example 'France', which is a combination of many territorial concepts across the whole world).

The gazetteer is based on the GADM <https://gadm.org/index.html>, which provides the currently best organised set of territorial names and the UN geoscheme <https://en.wikipedia.org/wiki/United_Nations_geoscheme>, which provides organisation of nations into super-sets.
