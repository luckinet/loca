# 01_build_ontology
# The LUCKINet ontology is the basis for all semantic matches within LUCKINet
# and for all mappings to other ontologies. Strong focus is on mapping LUCKINet
# concepts to FAO concepts, but also other state of the art datasets are
# considered.
# The LUCKINet gazeteer is the basis for all mapping of territories in census
# data that do not yet correspond to our standard. The gazetteer is primarily
# based on GADM and the UN geoscheme. All territorial concepts are derived from
# these two schemes.

## Tools ----
# The ontology is built with the 'ontologics' R-package, which is powered by the
# Simple Knowledge Organization System (skos,
# https://www.w3.org/TR/skos-reference/).

## LUCKINet ontology ----
# The ontology has the following harmonised concepts:
#
# - domain
#   - landcover group     groups of landcover types, describing the respective
#                         "areas", such as AGRICULTURAL AREAS, FOREST AND
#                         SEMI-NATURAL AREAS, WETLANDS and others.
#     - landcover         concepts that describe a unique cover type, largely
#                         taken from the CORINE classification, with small
#                         adaptions.
#       - land-use        the socio-economic dimension, i.e., how the landcover
#                         is used. This level further distinguishes the target
#                         landcover types AGRICULTURAL AREAS and FOREST AND
#                         SEMI-NATURAL AREAS because they are in the focus of
#                         the first iteration of the LUCKINet land-use
#                         time-series.
#   - group               groups of crop or livestock commodities
#     - class             classes of similar commodities
#       - aggregate       some commodities are very similar and thus reported
#                         together (at the same level as commodities)
#       - commodity       individual commodities (typically at the level of
#                         species or variety)
#
# They are embedded into a hierarchical structure and related with skos:broader,
# nesting is documented above by indention. Moreover, 'commodity' and
# 'aggregate' are semantically related to 'landuse' classes with skos:broader as
# well. 'External concepts' are input concepts from other 'sources' that not
# necessarily respond to a standard vocabulary, but may be mere collections of
# loosely defined concepts.
#
# The ontology is an amalgamation of various datasets:
#
# - The FAO Indicative Crop Classification (ICC) v1.1, which provides a
#   hierarchical structure of crop and livestock concepts
#   (https://datalab.review.fao.org/datalab/caliper/web/classification-page/43).
# - The FAO Crops and livestock products dataset (QCL), which contains a range
#   of concepts used by the FAO and frequently by statistical offices of nations
#   that make their census data publicly available
#   (https://www.fao.org/faostat/en/#data/QCL).
# - The FAO Land Use dataset (RL), which contains a hierarchical set of land-use
#   concepts that represent the most harmonised representation of land-use
#   concepts to date. (https://www.fao.org/faostat/en/#data/RL)
# - The FAO Forest Resource assessment (FRA), which contains a detailed set of
#   forest classes that fits well together with the FAO Land Use vocabulary and
#   represents relevant classes at a coarse scale
#   (https://www.fao.org/3/I8661EN/i8661en.pdf, Sections 1b, 1e, 1f).
# - ESA CCI landcover, which contains the vocabulary of landcover classes we use
#   throughout for allocating land use into the surface of the globe
#   (https://maps.elie.ucl.ac.be/CCI/viewer/download/CCI-LC_Maps_Legend.pdf).
# - CORINE landcover classes (CLC), which is used as basis to define the
#   (hierarchical) organisation of landcover and land-use classes (into which
#   the crop and livestock commodities are nested).
#   (https://land.copernicus.eu/user-corner/technical-library/corine-land-cover-nomenclature-guidelines/html/)

## LUCKINet gazetteer ----
# The gazetteer has the following harmonised concepts:
#
#
# The gazetteer is based on the GADM and the UN geoscheme:
#
# - GADM
#
# - UN geoscheme
