# script arguments ----
#
message("\n---- build landuse ontology ----")


# load data ----
#
# other sources: https://www.feedipedia.org/ https://tropical.theferns.info/ https://uses.plantnet-project.org/en/Main_Page


# data processing ----
#
# start a new ontology
message(" --> initiate ontology")
luckiOnto <- start_ontology(name = "luckiOnto", path = paste0(dataDir, "tables/"),
                            version = "1.0.0",
                            code = ".xxx",
                            description = "the intial LUCKINet commodity ontology",
                            homepage = "http://www.luckinet.org",
                            uri_prefix = "http://luckinet.org",
                            license = "CC-BY-4.0")

# define all sources ----
message(" --> defining sources")
luckiOnto <- new_source(name = "icc",
                        date = Sys.Date(),
                        version = "1.1",
                        description = "The official version of the Indicative Crop Classification was developed for the 2020 round of agricultural censuses.",
                        homepage = "https://stats.fao.org/caliper/browse/skosmos/ICC11/en/",
                        uri_prefix = "https://stats.fao.org/classifications/ICC/v1.1/",
                        license = "",
                        ontology = luckiOnto)

luckiOnto <- new_source(name = "cpc",
                        date = Sys.Date(),
                        version = "2.1",
                        description = "The Central Product Classification (CPC) v2.1",
                        homepage = "https://stats.fao.org/caliper/browse/skosmos/cpc21/en/",
                        uri_prefix = "http://stats-class.fao.uniroma2.it/CPC/v2.1/ag/",
                        license = "",
                        ontology = luckiOnto)

luckiOnto <- new_source(name = "species",
                        date = Sys.Date(),
                        description = "This contains scientific pland and animal names as suggested in the ICC 1.1",
                        homepage = "",
                        license = "",
                        ontology = luckiOnto)

luckiOnto <- new_source(name = "wiki",
                        date = Sys.Date(),
                        description = "Wikidata is a free, collaborative, multilingual, secondary database, collecting structured data to provide support for Wikipedia, Wikimedia Commons, the other wikis of the Wikimedia movement, and to anyone in the world.",
                        homepage = "https://www.wikidata.org/",
                        uri_prefix = "https://www.wikidata.org/wiki/",
                        license = "CC0",
                        ontology = luckiOnto)

luckiOnto <- new_source(name = "gbif",
                        date = Sys.Date(),
                        description = "GBIF—the Global Biodiversity Information Facility—is an international network and data infrastructure funded by the world's governments and aimed at providing anyone, anywhere, open access to data about all types of life on Earth.",
                        homepage = "https://www.gbif.org/",
                        uri_prefix = "https://www.gbif.org/species/",
                        license = "",
                        ontology = luckiOnto)

luckiOnto <- new_source(name = "use-type",
                        date = Sys.Date(),
                        description = "a collection of standard terms of use-types of crops or livestock, derived from the FAO Central Product Classification (CPC) version 2.1",
                        homepage = "",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

useTypes <- tibble(label = c("energy", "fibre", "food", "wood", "forage",
                             "silage", "fodder", "industrial", "recreation",
                             "medicinal", "labor"),
                   description = c("plants that are used for energy production.",
                                   "plants/animals that are used for fibre production.",
                                   "plants/animals that are used for produced for human food consumption.",
                                   "plants that are used for wood production.",
                                   "plants that are left in the field where animals are sent to forage on the crop.",
                                   "plants that are used to produce silage.",
                                   "plants that are harvested and brought to animals, for more controlled feeding of animals.",
                                   "plants that were historically labeled industrial crops.",
                                   "plants with a stimulating effect that can be used for recreational purposes.",
                                   "plants that are grown for their medicinal effect.",
                                   "animals that are used for labor."))

luckiOnto <- new_source(name = "life-form",
                        date = Sys.Date(),
                        description = "a collection of standard terms of plant life-forms",
                        homepage = "",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

lifeForms <- tibble(label = c("graminoid", "tree", "shrub", "forb", "vine", "mushroom"),
                    description = c("plants that are graminoids.",
                                    "plants that are trees.",
                                    "plants that are shrubs.",
                                    "plants that are forbs.",
                                    "plants that are forbs and grow as vines (they need support to grow into the air).",
                                    ""))

luckiOnto <- new_source(name = "use-part",
                        date = Sys.Date(),
                        description = "a collection of standard terms of use-types of crops or livestock, derived from the FAO Central Product Classification (CPC) version 2.1",
                        homepage = "",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

usedParts <- tibble(label = c("biomass", "bast", "leaves", "seed", "fruit"),
                    description = c("where the used part of the commodity is the whole biomass.",
                                    "",
                                    "",
                                    "",
                                    ""))

# luckiOnto <- new_source(name = "clc",
#                         date = dmy("10-05-2019"),
#                         description = "CORINE land cover nomenclature",
#                         homepage = "https://land.copernicus.eu/user-corner/technical-library/corine-land-cover-nomenclature-guidelines/html/",
#                         ontology = luckiOnto)

# luckiOnto <- new_source(name = "esalc",
#                         version = "2.1.1",
#                         description = "The CCI-LC project delivers consistent global LC maps at 300 m spatial resolution on an annual basis from 1992 to 2020 The Coordinate Reference System used for the global land cover database is a geographic coordinate system (GCS) based on the World Geodetic System 84 (WGS84) reference ellipsoid.",
#                         homepage = "https://maps.elie.ucl.ac.be/CCI/viewer/index.php",
#                         ontology = luckiOnto)

# luckiOnto <- new_source(name = "fra",
#                         date = dmy("10-05-2019"),
#                         description = "FAO has been monitoring the world’s forests at 5 to 10 year intervals since 1946. The Global Forest Resources Assessments (FRA) are now produced every five years in an attempt to provide a consistent approach to describing the world’s forests and how they are changing.",
#                         homepage = "https://fra-data.fao.org/",
#                         ontology = luckiOnto)

# luckiOnto <- new_source(name = "faoLu",
#                         date = dmy("10-05-2019"),
#                         description = "The FAOSTAT Land Use domain contains data on forty-four categories of land use, irrigation and agricultural practices, relevant to monitor agriculture, forestry and fisheries activities at national, regional and global level.",
#                         homepage = "https://www.fao.org/faostat/en/#data/RL",
#                         ontology = luckiOnto)

# luckiOnto <- new_source(name = "initiation",
#                         date = Sys.Date(),
#                         description = "the number of years a plant needs to grow before it can be harvested the first time",
#                         homepage = "",
#                         license = "CC-BY-4.0",
#                         ontology = luckiOnto)

# luckiOnto <- new_source(name = "persistence",
#                         date = Sys.Date(),
#                         description = "the number of years after which a plant is renewed either because it has been fully harvested or because it shall be replaced",
#                         homepage = "",
#                         license = "CC-BY-4.0",
#                         ontology = luckiOnto)

# lut_persistence <- tibble(label = c(""),
#                           description = c("plants that exist for ",
#                                           "plants that exist for "))

# luckiOnto <- new_source(name = "duration",
#                         date = Sys.Date(),
#                         description = "the number of days a plants needs to grow from planting to harvest.",
#                         homepage = "",
#                         license = "",
#                         ontology = luckiOnto)

# lut_duration <- tibble(label = ,
#                     description = c("plants that exist for ",
#                                     "plants that exist for "))

# harvests
# luckiOnto <- new_source(name = "harvests",
#                         date = Sys.Date(),
#                         description = "the number of days a plants needs to grow from planting to harvest.",
#                         homepage = "",
#                         license = "",
#                         ontology = luckiOnto)

# lut_harvests <- tibble(label = c("1", "2", "3", "4"),
#                     description = c("plants that are harvested once per year",
#                                     "plants that are harvested twice per year",
#                                     "plants that are harvested three times per year",
#                                     "plants that are harvested four times per year"))

# height
# luckiOnto <- new_source(name = "height",
#                         date = Sys.Date(),
#                         description = "the height classes of plants (the upper bound)",
#                         homepage = "",
#                         license = "",
#                         ontology = luckiOnto)

# lut_height <- tibble(label = c("0.5", "1", "2", "5", "10", "15", "20", "30", "xx"),
#                      description = c("plants that are between 0 and 0.5 m heigh",
#                                      "plants that are between 0.5 and 1 m heigh",
#                                      "plants that are between 1 and 2 m heigh",
#                                      "plants that are between 2 and 5 m heigh",
#                                      "plants that are between 5 and 10 m heigh",
#                                      "plants that are btween 10 and 15 m heigh",
#                                      "plants that are between 10 and 20 m heigh",
#                                      "plants that are between 20 and 30 m heigh",
#                                      "plants that are higher than 30 m"))


# define new classes ----
message(" --> defining classes")
luckiOnto <- new_class(new = "domain", target = NA_character_,
                       description = "the domain of surface area description", ontology = luckiOnto) %>%
  new_class(new = "land use", target = "domain", description = "land-use types", ontology = .) %>%
  new_class(new = "group", target = "domain",
            description = "broad groups of concepts that describe crops and livestock", ontology = .) %>%
  new_class(new = "class", target = "group",
            description = "mutually exclusive types of concepts that describe crops and livestock", ontology = .) %>%
  new_class(new = "commodity", target = "class",
            description = "concepts that describe crops or livestock",  ontology = .)


# define the harmonized concepts ----
message(" --> definíng concepts")
domain <- tibble(concept = c("land use", "commodities"),
                 description = c("surface area described by the predominant land use there",
                                 "surface area described by the crops and livestock grown there"))

luckiOnto <- new_concept(new = domain$concept,
                         description = domain$description,
                         class = "domain",
                         ontology =  luckiOnto)

### land use
lu <- list(
  tibble(concept = c("Protective Cover", "Agrovoltaics"),
         description = c("Land covered by buildings that are used to produce plants, mushrooms or livestock under highly controlable conditions",
                         "Land covered by solar panels in combination with agriculture or livestock rearing."),
         fra = c(NA_character_),
         fao_lu = c("6649", NA_character_)),
  tibble(concept = c("Fallow", "Herbaceous crops", "Temporary grazing"),
         description = c("Land covered by temporary cropland that is currently (no longer than for 3 years) not used",
                         "Land covered by temporary cropland that is used to produce any herbaceous crop",
                         "Land covered by temporary cropland that is currently used for grazing or fodder production"),
         fra = c(NA_character_),
         fao_lu = c("6640", "6630", "6633")),
  tibble(concept = c("Shrub orchards", "Palm plantations", "Tree orchards", "Woody plantation"),
         description = c("Land covered by permanent cropland that is used to produce commodities that grow on shrubby vegetation",
                         "Land covered by permanent cropland that is used to produce commodities that grow on palms trees",
                         "Land covered by permanent cropland that is used to produce commodities that grow on trees other than palms",
                         "Land covered by permanent cropland that is used to produce woood or biomass from even-aged trees of one or, at most two, tree species"),
         fra = c(NA_character_, "3.1.1", "3.1.2", "1.2.1"),
         fao_lu = c("6650", "6650", "6650", "6650")),
  tibble(concept = c("Cultivated pastures", "Naturally grown pastures"),
         description = c("Land covered by pastures that are cultivated and managed",
                         "Land covered by pastures that are grown naturally, either on grassland or under woody cover"),
         fra = c(NA_character_),
         fao_lu = c("6656", "6659")),
  tibble(concept = c("Agroforestry", "Mix of agricultural uses"),
         description = c("Land covered by temporary cropland under the wooded cover of forestry species",
                         "Land covered by a mix of various temporary and/or permanent crops on the same parcel"),
         fra = c("3.1.3", NA_character_),
         fao_lu = c(NA_character_)),
  tibble(concept = c("Undisturbed Forest", "Naturally Regenerating Forest", "Planted Forest", "Temporally Unstocked Forest"),
         description = c("Land covered by forest of native tree species that has been naturally regenerated, where there are no clearly visible indications of human activities and the ecological processes are not significantly disturbed",
                         "Land covered by forest predominantly composed of trees established through natural regeneration",
                         "Land covered by forest predominantly composed of trees established through planting and/or deliberate seeding",
                         "Land covered by forest which is temporarily unstocked or with trees shorter than 1.3 meters that have not yet reached but are expected to reach a canopy cover of at least 10 percent and tree height of at least 5 meters"),
         fra = c("1.3", "1.1", "1.2", "1.6"),
         fao_lu = c("6714", "6717", "6716", NA_character_))) %>%
  bind_rows() %>%
  mutate(broader = "land use")

luckiOnto <- new_concept(new = lu$concept,
                         broader = get_concept(table = lu %>% select(label = broader), ontology = luckiOnto),
                         description = lu$description,
                         class = "land use",
                         ontology =  luckiOnto)

## crop production systems ----

### groups ----
group <- tibble(concept = c("NON-FOOD CROPS", "FRUIT", "SEEDS", "STIMULANTING CROPS",
                            "SUGAR CROPS", "VEGETABLES", "BIRDS", "GLIRES", "UNGULATES", "INSECTS"),
                description = c("This group comprises plants that are grown primarily for all sort of industrial, non-food related purposes.",
                                "This group comprises plants that are grown primarily to use their (typically sweet or sour) fleshy parts that are edible in a raw state.",
                                "This group comprises plants that are grown primarily to use their seeds as food source. 'Seed' is regarded as the reproductive organ that, when put into a suitably substrate, grows a new plant.",
                                "This group comprises plants that are grown primarily to make use of their medicinal effect, their taste or for their mind-altering effects.",
                                "This group comprises plants that are grown primarily for their sugar content.",
                                "This group comprises plants that are grown primarily to use some of their organs (includes typically savory fruit, but not seeds) that are often heated to be easily digestible.",
                                "This group comprises birds that are used for their eggs or meat or to perform tasks they were trained for",
                                "This group comprises lagomorphs and rodents that are used for their meat or fur.",
                                "This group comprises ungulates that are used for their milk, meat and skin or to perform tasks they were trained for.",
                                "This group comprises insects that are used for the substances they produce or directly for human consumption."),
                broader = "commodities")

luckiOnto <- new_concept(new = group$concept,
                         broader = get_concept(table = group %>% select(label = broader), ontology = luckiOnto),
                         class = "group",
                         ontology = luckiOnto)

### classes ----
class <- list(
  tibble(concept = c("Bioenergy crops", "Fibre crops", "Flower crops", "Rubber crops", "Pasture and forage crops"),
         description = c("This class covers plants that are grown primarily for the production of energy.",
                         "This class covers plants that are primarily grown because some plant part is used to produce textile fibres. Other uses of other plant parts, such as fruit or oilseeds are possible.",
                         "This class covers plants that are primarily grown to use some of their parts for ornamental reasons.",
                         "This class covers plants that are grown to produce gums and rubbers.",
                         "This class covers plants that are grown as food source for animals, to produce fodder/silage or to be grazed on by livestock."),
         broader = group$concept[1]),
  tibble(concept = c("Berries", "Citrus Fruit", "Grapes", "Pome Fruit", "Stone Fruit", "Oleaginous fruits", "Tropical and subtropical Fruit"),
         description = c("This class covers plants that are grown for their fruit that have small, soft roundish edible tissue.",
                         "This class covers plants that are part of the genus Citrus.",
                         "This class covers plants that are part of the genus Vitis.",
                         "This class covers plants that are grown for their apple-like fruit.",
                         "This class covers plants that are grown for their fruit that have a single hard stone and a fleshy, juicy edible tissue.",
                         "This calss covers plants that are grown for their oil-containing tissue.",
                         "This class covers plants that grow in tropical and subtropical regions."),
         broader = group$concept[2]),
  tibble(concept = c("Cereals", "Leguminous seeds", "Treenuts", "Oilseeds"),
         description = c("This class covers graminoid plants that are grown for their grain. This class also includes pseudocereals, as they are also grown for their grain.",
                         "This class covers leguminous plants that are grown for both, their dry and green seeds.",
                         "This class covers plants that are grown for their dry seeds that are protected by a hard shell.",
                         "This class covers plants that are grown to use their seeds to produce oils for human nourishment."),
         broader = group$concept[3]),
  tibble(concept = c("Stimulant crops", "Spice crops", "Medicinal crops."),
         description = c("This class covers plants that are grown for their stimulating or mind-altering effects.",
                         "This class covers plants that are grown for their aromatic properties.",
                         "This class covers plants that are grown for their medical effects on the animal physiology."),
         broader = group$concept[4]),
  tibble(concept = c("Sugar crops"),
         description = c("This class covers plants that are primarily grown because some plant part is used to produce sugar. Other uses of other plant parts, such as fruit or oilseeds are possible."),
         broader = group$concept[5]),
  tibble(concept = c("Fruit-bearing vegetables", "Leaf or stem vegetables", "Mushrooms and truffles", "Root vegetables."),
         description = c("This class covers plants that are grown to use their fruit as vegetables.",
                         "This class covers plants that are grown to use their leaves or stem as vegetables.",
                         "This class covers mushrooms and truffles that are grown for human nourishment.",
                         "This class covers plants that are grown to use their roots, tubers or bulbs as vegetables."),
         broader = group$concept[6]),
  tibble(concept = c("Poultry Birds"),
         description = c("This class covers all poultry birds."),
         broader = group$concept[7]),
  tibble(concept = c("Lagomorphs", "Rodents"),
         description = c("This class covers hares and rabbits.",
                         "This class covers various rodents."),
         broader = group$concept[8]),
  tibble(concept = c("Bovines", "Caprines", "Camelids", "Equines", "Pigs"),
         description = c("This class covers bovine animals.",
                         "This class covers goats, sheep.",
                         "This class covers camels and lamas.",
                         "This class covers horses, asses and mules.",
                         "This class covers pigs and (domesticated) boar."),
         broader = group$concept[9]),
  tibble(concept = c("Food producing insects", "Fibre producing insects"),
         description = c("This class covers insect species that produce substances that are used as human nourishment, such as honey or protein.",
                         "This class covers insect species that produce substances that are used as fibres."),
         broader = group$concept[10])) %>%
  bind_rows()

luckiOnto <- new_concept(new = class$concept,
                         broader = get_concept(table = class %>% select(label = broader), ontology = luckiOnto),
                         class = "class",
                         ontology =  luckiOnto)

### commodities ----

# here, each item has the following elements
# item <- list(concept = character(),     the concept name
#              broader = character(),     the class into which it is nested
#              scientific = character(),  the scientific name(s)
#              icc_id = character(),      the Indicative Crop Classification ID
#              cpc_id = character(),      the Central Product Classification ID
#              wiki_id = character(),     the wikidata ID
#              gbif_id = character(),     the GBIF ID
#              use_type = character(),    the type of use for the commodity
#              used_part = character(),   the part of the commodity that is used
#              life_form = character(),   the life-form of the commodity (if it's a plant)
#              ybh = integer(),           the 'years before harvest', i.e., how long the crop needs to grow before it can be harvested
#              yoh = integer(),           the 'years of harvest', i.a., for how many years in a row the crop can be harvested
#              harvests = integer(),      the number of harvests
#              yield = double(),          the range of typical yield values
#              height = double())         the maximum height of the crop


class <-
  list(concept = , broader = class$concept[], scientific = ,
       icc_id = , cpc_id = , wiki_id = , gbif_id = ,
       use_type = , used_part = , life_form = ,
       ybh = , yoh = , harvests = , yield = , height = ) %>%
  list(class, .) %>%
  map_dfr(class, as_tibble_row)

#### Bioenergy crops ----
bioenergy <-
  list(concept = "bamboo", broader = class$concept[1], scientific = "Bambusa spp.",
       icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q311331 | Q2157176", gbif_id = "2705751",
       use_type = useTypes$label[1], used_part = usedParts$label[1], life_form = lifeForms$label[1],
       ybh = ,
       yoh = "1",
       harvests = ,
       yield = ,
       height = "10")

bioenergy <-
  list(concept = "giant reed", broader = class$concept[1], scientific = "Arundo donax",
       icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q161114", gbif_id = "2703041",
       use_type = useTypes$label[1], used_part = usedParts$label[1], life_form = lifeForms$label[1],
       ybh = ,
       yoh = "20-25", harvests = "2", yield = "50-80", height = "5") %>%
  list(bioenergy, .)

bioenergy <-
  list(concept = "miscanthus", broader = class$concept[1], scientific = "Miscanthus × giganteus",
       icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q2152417", gbif_id = "4122678",
       use_type = useTypes$label[1], used_part = usedParts$label[1], life_form = lifeForms$label[1],
       ybh = ,
       yoh = "1", harvests = "1", yield = "20-30", height = "5") %>%
  list(bioenergy, .)

bioenergy <-
  list(concept = "reed canary grass", broader = class$concept[1], scientific = "Phalaris arundinacea",
       icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q157419", gbif_id = "5289756",
       use_type = useTypes$label[1], used_part = usedParts$label[1], life_form = lifeForms$label[1],
       ybh = ,
       yoh = "1",
       harvests = ,
       yield = ,
       height = "2") %>%
  list(bioenergy, .)

bioenergy <-
  list(concept = "switchgrass", broader = class$concept[1], scientific = "Panicum virgatum",
       icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q1466543", gbif_id = "2705081",
       use_type = useTypes$label[1], used_part = usedParts$label[1], life_form = lifeForms$label[1],
       ybh = ,
       yoh = "1",
       harvests = ,
       yield = ,
       height = "5") %>%
  list(bioenergy, .)

bioenergy <-
  list(concept = "acacia", broader = class$concept[1], scientific = "Acacia spp.",
       icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q81666", gbif_id = "2978223",
       use_type = useTypes$label[1], used_part = usedParts$label[1], life_form = lifeForms$label[2],
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(bioenergy, .)

bioenergy <-
  list(concept = "black locust", broader = class$concept[1], scientific = "Robinia pseudoacacia",
       icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q2019723", gbif_id =  "5352251",
       use_type = useTypes$label[1], used_part = usedParts$label[1], life_form = lifeForms$label[2],
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(bioenergy, .)

bioenergy <-
  list(concept = "eucalyptus", broader = class$concept[1], scientific = "Eucalyptus spp.",
       icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q45669", gbif_id = "7493935",
       use_type = useTypes$label[1], used_part = usedParts$label[1], life_form = lifeForms$label[2],
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(bioenergy, .)

bioenergy <-
  list(concept = "poplar", broader = class$concept[1], scientific = "Populus spp.",
       icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q25356", gbif_id = "3040183",
       use_type = useTypes$label[1], used_part = usedParts$label[1], life_form = lifeForms$label[2],
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(bioenergy, .)

bioenergy <-
  list(concept = "willow", broader = class$concept[1], scientific = "Salix spp.",
       icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q36050", gbif_id = "3039576",
       use_type = useTypes$label[1], used_part = usedParts$label[1], life_form = lifeForms$label[2],
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(bioenergy, .) %>%
  map_dfr(bioenergy, as_tibble_row)

luckiOnto <- new_concept(new = bioenergy$concept,
                         broader = get_concept(table = bioenergy %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)


#### Fibre crops ----
fibre <-
  list(concept = "jute", broader = class$concept[2], scientific = "Corchorus spp.",
       icc_id = "9.02.01.02", cpc_id = "01922.01", wiki_id = "Q107211 | Q161489", gbif_id = "3032212",
       use_type = useTypes$label[2], used_part = usedParts$label[2], life_form = lifeForms$label[4],
       ybh = "0", yoh = "1", harvests = "1-3", yield = "2-2.75", height = "5")

fibre <-
  list(concept = "kenaf", broader = class$concept[2], scientific = "Hibiscus cannabinus",
       icc_id = "9.02.01.02", cpc_id = "01922.02", wiki_id = "Q1137540", gbif_id = "3152547",
       use_type = useTypes$label[2], used_part = usedParts$label[2], life_form = lifeForms$label[4],
       ybh = "0", yoh = "1", harvests = "1-4", yield = "6-10", height = "5") %>%
  list(fibre, .)

fibre <-
  list(concept = "ramie", broader = class$concept[2], scientific = "Boehmeria nivea",
       icc_id = "9.02.02.01", cpc_id = "01929.04", wiki_id = "Q2130134 | Q750467", gbif_id = "2984359",
       use_type = useTypes$label[2], used_part = usedParts$label[2], life_form = lifeForms$label[4],
       ybh = "0", yoh = "1", harvests = "2-6", yield = "3.4-4.5", height = "2") %>%
  list(fibre, .)

fibre <-
  list(concept = "abaca | manila hemp", broader = class$concept[2], scientific = "Musa textilis",
       icc_id = "9.02.02.90", cpc_id = "01929.07", wiki_id = "Q161097", gbif_id = "2762907",
       use_type = useTypes$label[2], used_part = usedParts$label[3], life_form = lifeForms$label[2],
       ybh = "1-2", yoh = "15-40", harvests = "1-4", yield = "4", height = "5") %>%
  list(fibre, .)

fibre <-
  list(concept = "sisal", broader = class$concept[2], scientific = "Agave sisalana",
       icc_id = "9.02.02.02", cpc_id = "01929.05", wiki_id = "Q159221 | Q847423", gbif_id = "2766636",
       use_type = useTypes$label[2], used_part = usedParts$label[3], life_form = lifeForms$label[2],
       ybh = ,
       yoh = ,
       harvests = "1-2",
       yield = ,
       height = "2") %>%
  list(fibre, .)

fibre <-
  list(concept = "kapok", broader = class$concept[2], scientific = "Ceiba pentandra",
       icc_id = "9.02.02.90", cpc_id = "01929.03 | 01499.05", wiki_id = "Q1728687 | Q138617", gbif_id = "5406697",
       use_type = "fibre | food", used_part = usedParts$label[4], life_form = lifeForms$label[2],
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = "xx") %>%
  list(fibre, .)

fibre <-
  list(concept = "new zealand flax | formio", broader = class$concept[2], scientific = "Phormium tenax",
       icc_id = "9.02.01.04", cpc_id = "01929", wiki_id = "Q607380", gbif_id = "2778511",
       use_type = "fibre", used_part = "stalk", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fibre, .)

fibre <-
  list(concept = "fique", broader = class$concept[2], scientific = "Furcraea macrophylla",
       icc_id = "9.02.01.90", cpc_id = "01929", wiki_id = "Q1474889", gbif_id = "2769812",
       use_type = "fibre", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fibre, .)

fibre <-
  list(concept = "henequen", broader = class$concept[2], scientific = "Agave fourcroydes",
       icc_id = "9.02.02", cpc_id = "01929", wiki_id = "Q136120", gbif_id = "2767123",
       use_type = "fibre", used_part = "leaves | food", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fibre, .)

fibre <-
  list(concept = "maguey", broader = class$concept[2], scientific = "Agave atrovirens",
       icc_id = "9.02.02", cpc_id = "01929", wiki_id = "Q2714978", gbif_id = "2766552",
       use_type = "fibre", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fibre, .) %>%
  map_dfr(fibre, as_tibble_row)

luckiOnto <- new_concept(new = fibre$concept,
                         broader = get_concept(table = fibre %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Flower crops ----
# flower <- list(
#
# )
#
# luckiOnto <- new_concept(new = flower$concept,
#                          broader = get_concept(table = flower %>% select(label = broader), ontology = luckiOnto),
#                          class = "commodity",
#                          ontology =  luckiOnto)

#### Rubber crops ----
rubber <-
  list(concept = "natural rubber", broader = class$concept[4], scientific = "Hevea brasiliensis",
       icc_id = "9.04", cpc_id = "01950", wiki_id = "Q131877", gbif_id = "3071171",
       use_type = "industrial", used_part = "resin", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(rubber, .) %>%
  map_dfr(rubber, as_tibble_row)

luckiOnto <- new_concept(new = fibre$concept,
                         broader = get_concept(table = fibre %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Pasture and forage crops ----
pasture <-
  list(concept = "alfalfa", broader = class$concept[5], scientific = "Medicago sativa",
       icc_id = "9.01.01", cpc_id = "01912 | 01940", wiki_id = "Q156106", gbif_id = "9151957",
       use_type = "food | fodder | forage", used_part = "biomass", life_form = "graminoid",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = )

pasture <-
  list(concept = "orchard grass", broader = class$concept[5], scientific = "Dactylis glomerata",
       icc_id = "9.01.01", cpc_id = "01919.91", wiki_id = "Q161735", gbif_id = "2705308",
       use_type = "fodder | forage", used_part = "biomass", life_form = "graminoid",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(pasture, .)

pasture <-
  list(concept = "redtop", broader = class$concept[5], scientific = "Agrostis spp.",
       icc_id = "9.90.01", cpc_id = "01919.91", wiki_id = "Q27835", gbif_id = "2706434",
       use_type = "forage", used_part = "biomass", life_form = "graminoid",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(pasture, .)

pasture <-
  list(concept = "ryegrass", broader = class$concept[5], scientific = "Lolium spp.",
       icc_id = "9.90.01", cpc_id = "01919.02", wiki_id = "Q158509", gbif_id = "2706217",
       use_type = "forage", used_part = "biomass", life_form = "graminoid",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(pasture, .)

pasture <-
  list(concept = "sudan grass", broader = class$concept[5], scientific = "Sorghum × drummondii",
       icc_id = "9.01.01", cpc_id = "01919", wiki_id = "Q332062", gbif_id = "2705184",
       use_type = "fodder | energy", used_part = "biomass", life_form = "graminoid",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(pasture, .)

pasture <-
  list(concept = "timothy", broader = class$concept[5], scientific = "Phleum pratense",
       icc_id = "9.01.01", cpc_id = "01919.91", wiki_id = "Q256508", gbif_id = "9014945",
       use_type = "fodder", used_part = "biomass", life_form = "graminoid",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(pasture, .)

pasture <-
  list(concept = "trefoil", broader = class$concept[5], scientific = "Lotus spp.",
       icc_id = "9.90.01", cpc_id = "01919.92", wiki_id = "Q101538", gbif_id = "10220564",
       use_type = "forage", used_part = "biomass", life_form = "graminoid",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(pasture, .)

pasture <-
  list(concept = "clover", broader = class$concept[5], scientific = "Trifolium spp.",
       icc_id = "9.01.01", cpc_id = "01919.03", wiki_id = "Q101538", gbif_id = "2973363",
       use_type = "fodder | forage", used_part = "biomass", life_form = "forb",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(pasture, .)

pasture <-
  list(concept = "lupin", broader = class$concept[5], scientific = "Lupinus spp.",
       icc_id = "7.06", cpc_id = "01709.02", wiki_id = "Q156811", gbif_id = "2963774",
       use_type = "fodder | forage | food", used_part = "biomass", life_form = "forb",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(pasture, .) %>%
  map_dfr(pasture, as_tibble_row)

luckiOnto <- new_concept(new = pasture$concept,
                         broader = get_concept(table = pasture %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Berries ----
berries <-
  list(concept = "blueberry", broader = class$concept[6], scientific = "Vaccinium myrtillus | Vaccinium corymbosum",
       icc_id = "3.04.06", cpc_id = "01355.01", wiki_id = "Q13178", gbif_id = "2882833 | 2882849",
       use_type = "food", used_part = "fruit", life_form = "shrub",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = )

berries <-
  list(concept = "cranberry", broader = class$concept[6], scientific = "Vaccinium macrocarpon | Vaccinium oxycoccus",
       icc_id = "3.04.07", cpc_id = "01355.02", wiki_id = "Q374399 | Q13181 | Q21546387", gbif_id = "7777960 | 2882949",
       use_type = "food", used_part = "fruit", life_form = "shrub",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(berries, .)

berries <-
  list(concept = "currant", broader = class$concept[6], scientific = "Ribes spp.",
       icc_id = "3.04.01", cpc_id = "01351.01", wiki_id = "Q3241599", gbif_id = "2986095",
       use_type = "food", used_part = "fruit", life_form = "shrub",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(berries, .)

berries <-
  list(concept = "gooseberry", broader = class$concept[6], scientific = "Ribes spp.",
       icc_id = "3.04.02", cpc_id = "01351.02", wiki_id = "Q41503 | Q17638951", gbif_id = "2986095",
       use_type = "food", used_part = "fruit", life_form = "shrub",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(berries, .)

berries <-
  list(concept = "kiwi fruit", broader = class$concept[6], scientific = "Actinidia deliciosa",
       icc_id = "3.04.03", cpc_id = "01352", wiki_id = "Q13194", gbif_id = "7270761",
       use_type = "food", used_part = "fruit", life_form = "shrub",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(berries, .)

berries <-
  list(concept = "raspberry", broader = class$concept[6], scientific = "Rubus spp.",
       icc_id = "3.04.04", cpc_id = "01353.01", wiki_id = "Q12252383 | Q13179",
       gbif_id = "2988638", use_type = "food", used_part = "fruit", life_form = "shrub",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(berries, .)

berries <-
  list(concept = "strawberry", broader = class$concept[6], scientific = "Fragaria spp.",
       icc_id = "3.04.05", cpc_id = "01354", wiki_id = "Q745 | Q13158", gbif_id = "3029779",
       use_type = "food", used_part = "fruit", life_form = "shrub",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(berries, .) %>%
  map_dfr(berries, as_tibble_row)

luckiOnto <- new_concept(new = berries$concept,
                         broader = get_concept(table = berries %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Citrus Fruit ----
citrus <-
  list(concept = "bergamot", broader = class$concept[7], scientific = "Citrus bergamia",
       icc_id = "3.02.90", cpc_id = "01329", wiki_id = "Q109196", gbif_id = "6433772",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = )

citrus <-
  list(concept = "clementine | mandarine", broader = class$concept[7], scientific = "Citrus reticulata",
       icc_id = "3.02.04", cpc_id = "01324.02", wiki_id = "Q460517 | Q125337", gbif_id = "3190172",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(citrus, .)

citrus <-
  list(concept = "grapefruit", broader = class$concept[7], scientific = "Citrus paradisi",
       icc_id = "3.02.01", cpc_id = "01321", wiki_id = "Q21552830", gbif_id = "7469645",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(citrus, .)

citrus <-
  list(concept = "lemon", broader = class$concept[7], scientific = "Citrus limon",
       icc_id = "3.02.02", cpc_id = "01322", wiki_id = "Q500 | Q1093742", gbif_id = "9198046",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(citrus, .)

citrus <-
  list(concept = "lime", broader = class$concept[7], scientific = "Citrus limetta | Citrus aurantifolia",
       icc_id = "3.02.02", cpc_id = "01322", wiki_id = "Q13195", gbif_id = "3190169 | 3190164",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(citrus, .)

citrus <-
  list(concept = "orange", broader = class$concept[7], scientific = "Citrus aurantium",
       icc_id = "3.02.03", cpc_id = "01323", wiki_id = "Q147096", gbif_id = "8077391",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(citrus, .)

citrus <-
  list(concept = "pomelo", broader = class$concept[7], scientific = "Citrus grandis",
       icc_id = "3.02.01", cpc_id = "01321", wiki_id = "Q353817 | Q80024", gbif_id = "3190161",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(citrus, .)

citrus <-
  list(concept = "satsuma", broader = class$concept[7], scientific = "Citrus reticulata",
       icc_id = "3.02.04", cpc_id = "01324", wiki_id = "Q875262", gbif_id = "3190172",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(citrus, .)

citrus <-
  list(concept = "tangerine", broader = class$concept[7], scientific = "Citrus reticulata",
       icc_id = "3.02.04", cpc_id = "01324.01", wiki_id = "Q516494", gbif_id = "3190172",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(citrus, .) %>%
  map_dfr(citrus, as_tibble_row)

luckiOnto <- new_concept(new = citrus$concept,
                         broader = get_concept(table = citrus %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Grapes ----
grapes <-
  list(concept = "grape", broader = class$concept[8], scientific = "Vitis vinifera",
       icc_id = "3.03", cpc_id = "01330", wiki_id = "Q10978 | Q191019", gbif_id = "5372392",
       use_type = "food", used_part = "fruit", life_form = "shrub",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = "2") %>%
  map_dfr(grapes, as_tibble_row)

luckiOnto <- new_concept(new = grapes$concept,
                         broader = get_concept(table = grapes %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Pome Fruit ----
pome <-
  list(concept = "apple", broader = class$concept[9], scientific = "Malus sylvestris",
       icc_id = "2.05.01", cpc_id = "01341", wiki_id = "Q89 | Q15731356", gbif_id = "3001509",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = )

pome <-
  list(concept = "loquat", broader = class$concept[9], scientific = "Eriobotrya japonica",
       icc_id = "3.05.90", cpc_id = "01359", wiki_id = "Q41505", gbif_id = "3024146",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(pome, .)

pome <-
  list(concept = "medlar", broader = class$concept[9], scientific = "Mespilus germanica",
       icc_id = "3.05.90", cpc_id = "01359", wiki_id = "Q146186 | Q3092517", gbif_id = "3031774",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(pome, .)

pome <-
  list(concept = "pear", broader = class$concept[9], scientific = "Pyrus communis",
       icc_id = "3.05.05", cpc_id = "01342.01", wiki_id = "Q434 | Q13099586", gbif_id = "5362573",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(pome, .)

pome <-
  list(concept = "quince", broader = class$concept[9], scientific = "Cydonia oblonga",
       icc_id = "3.05.05", cpc_id = "01342.02", wiki_id = "Q2751465 | Q43300", gbif_id = "5362215",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(pome, .) %>%
  map_dfr(pome, as_tibble_row)

luckiOnto <- new_concept(new = pome$concept,
                         broader = get_concept(table = pome %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Stone Fruit ----
stone <-
  list(concept = "apricot", broader = class$concept[10], scientific = "Prunus armeniaca",
       icc_id = "3.05.02", cpc_id = "01343", wiki_id = "Q37453 | Q3733836", gbif_id = "7818643",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = )

stone <-
  list(concept = "cherry", broader = class$concept[10], scientific = "Prunus avium",
       icc_id = "3.05.03", cpc_id = "01344.02", wiki_id = "Q196", gbif_id = "3020791",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(stone, .)

stone <-
  list(concept = "nectarin | peach", broader = class$concept[10], scientific = "Prunus persica",
       icc_id = "3.05.04", cpc_id = "01345", wiki_id = "Q2724976 | Q83165 | Q13189", gbif_id = "8149923",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(stone, .)

stone <-
  list(concept = "plum", broader = class$concept[10], scientific = "Prunus domestica",
       icc_id = "3.05.06", cpc_id = "01346", wiki_id = "Q6401215 | Q13223298", gbif_id = "7931731",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(stone, .)

stone <-
  list(concept = "sloe", broader = class$concept[10], scientific = "Prunus spinosa",
       icc_id = "3.05.06", cpc_id = "01346", wiki_id = "Q12059685 | Q129018", gbif_id = "3023221",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(stone, .)

stone <-
  list(concept = "sour cherry", broader = class$concept[10], scientific = "Prunus cerasus",
       icc_id = "3.05.03", cpc_id = "01344.01", wiki_id = "Q68438267 | Q131517", gbif_id = "3021922",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(stone, .) %>%
  map_dfr(stone, as_tibble_row)

luckiOnto <- new_concept(new = stone$concept,
                         broader = get_concept(table = stone %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Oleaginous fruits ----
oleaginous <-
  list(concept = "coconut", broader = class$concept[11], scientific = "Cocos nucifera",
       icc_id = "4.04.01 | 9.02.02.90", cpc_id = "01460 | 01929.08", wiki_id = "Q3342808",
       gbif_id = ,
       use_type = "food | fibre", used_part = "seed | husk", life_form = "palm",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = )

oleaginous <-
  list(concept = "oil palm", broader = class$concept[11], scientific = "Elaeis guineensis",
       icc_id = "4.04.03", cpc_id = "01491", wiki_id = "Q165403",
       gbif_id = ,
       use_type = "food", used_part = "seed", life_form = "palm",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oleaginous, .)

oleaginous <-
  list(concept = "olive", broader = class$concept[11], scientific = "Olea europaea",
       icc_id = "4.04.02", cpc_id = "01450", wiki_id = "Q37083 | Q1621080",
       gbif_id = ,
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oleaginous, .) %>%
  map_dfr(oleaginous, as_tibble_row)

luckiOnto <- new_concept(new = oleaginous$concept,
                         broader = get_concept(table = oleaginous %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Tropical and subtropical Fruit ----
tropical <-
  list(concept = "avocado", broader = class$concept[12], scientific = "Persea americana",
       icc_id = "3.01.01", cpc_id = "01311", wiki_id = "Q961769 | Q37153", gbif_id = "3034046",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = )

tropical <-
  list(concept = "banana", broader = class$concept[12], scientific = "Musa sapientum | Musa cavendishii | Musa nana",
       icc_id = "3.01.02", cpc_id = "01312", wiki_id = "Q503 | Q10757112 | Q132970", gbif_id = "2762752 | 2762680",
       use_type = "fibre | food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "guava", broader = class$concept[12], scientific = "Psidium guajava",
       icc_id = "3.01.06", cpc_id = "01316.02", wiki_id = "Q166843 | Q3181909", gbif_id = "5420380",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "mango", broader = class$concept[12], scientific = "Mangifera indica",
       icc_id = "3.01.06", cpc_id = "01316.01", wiki_id = "Q169", gbif_id = "3190638",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "mangosteen", broader = class$concept[12], scientific = "Garcinia mangostana",
       icc_id = "3.01.06", cpc_id = "01316.03", wiki_id = "Q170662 | Q104030000", gbif_id = "3189571",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "papaya", broader = class$concept[12], scientific = "Carica papaya",
       icc_id = "3.01.07", cpc_id = "01317", wiki_id = "Q34887", gbif_id = "2874484",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "persimmon", broader = class$concept[12], scientific = "Diospyros kaki | Diospyros virginiana",
       icc_id = "3.01.90", cpc_id = "01359.01", wiki_id = "Q158482 | Q29526", gbif_id = "3032984 | 3032986",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "plantain", broader = class$concept[12], scientific = "Musa paradisiaca",
       icc_id = "3.01.03", cpc_id = "01313", wiki_id = "Q165449", gbif_id = "2762752",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "açaí", broader = class$concept[12], scientific = "Euterpe oleracea",
       icc_id = "3.01.9", cpc_id = "01319", wiki_id = "Q33943 | Q12300487", gbif_id = "5293398",
       use_type = "food", used_part = "fruit", life_form = "palm",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "date", broader = class$concept[12], scientific = "Phoenix dactylifera",
       icc_id = "3.01.04", cpc_id = "01314", wiki_id = "Q1652093", gbif_id = "6109699",
       use_type = "food", used_part = "fruit", life_form = "palm",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "pineapple", broader = class$concept[12], scientific = "Ananas comosus",
       icc_id = "3.01.08", cpc_id = "01318", wiki_id = "Q1493 | Q10817602", gbif_id = "5288819",
       use_type = "food", used_part = "fruit", life_form = "shrub",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "fig", broader = class$concept[12], scientific = "Ficus carica",
       icc_id = "3.01.05", cpc_id = "01315", wiki_id = "Q36146 | Q2746643", gbif_id = "5361909",
       use_type = "food", used_part = "fruit", life_form = "shrub",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "sapodilla", broader = class$concept[12], scientific = "Achras sapota",
       icc_id = "3.90", cpc_id = "01319", wiki_id = "Q14959", gbif_id = "2885158",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "litchi", broader = class$concept[12], scientific = "Litchi chinensis",
       icc_id = "3.01.90", cpc_id = "01319", wiki_id = "Q13182", gbif_id = "3190002",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "custard apple", broader = class$concept[12], scientific = "Annona reticulate",
       icc_id = "3.01.90", cpc_id = "01319", wiki_id = "Q472653", gbif_id = "5407123",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "breadfruit", broader = class$concept[12], scientific = "Artocarpus altilis",
       icc_id = "3.01.90", cpc_id = "01319", wiki_id = "Q14677", gbif_id = "2984573",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "mulberry", broader = class$concept[12], scientific = "Morus spp.",
       icc_id = "3.90", cpc_id = "01319", wiki_id = "Q44789", gbif_id = "2984545",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .)

tropical <-
  list(concept = "pomegranate", broader = class$concept[12], scientific = "Punica granatum",
       icc_id = "3.90", cpc_id = "01319", wiki_id = "Q13188 | Q13222088", gbif_id = "5420901",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(tropical, .) %>%
  map_dfr(tropical, as_tibble_row)

# This subclass includes:
# - durian fruits
# - bilimbi, Averrhoa bilimbi
# - starfruit, carambola Averrhoa carambola
# - fruit of various species of Sapindaceae, including:
# - jackfruit
# - passion fruit, Passiflora edulis, Passiflora quadrangularis
# - akee, Blighia sapida
# - pepinos, Solanum muricatum


luckiOnto <- new_concept(new = tropical$concept,
                         broader = get_concept(table = tropical %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Cereals ----
cereals <-
  list(concept = "barley", broader = class$concept[13], scientific = "Hordeum vulgare",
       icc_id = "1.05", cpc_id = "0115", wiki_id = "Q11577", gbif_id = "2706056",
       use_type = "forage | food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = )

cereals <-
  list(concept = "maize", broader = class$concept[13], scientific = "Zea mays",
       icc_id = "1.02", cpc_id = "01121 | 01911", wiki_id = "Q11575 | Q25618328", gbif_id = "5290052",
       use_type = "food | silage", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "pearl millet", broader = class$concept[13], scientific = "Cenchrus americanus",
       icc_id = "1.08", cpc_id = "0118", wiki_id = "Q50840653", gbif_id = "5828197",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "finger millet", broader = class$concept[13], scientific = "Eleusine coracana",
       icc_id = "1.08", cpc_id = "0118", wiki_id = "Q932258", gbif_id = "2705957",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "foxtail millet", broader = class$concept[13], scientific = "Setaria italica",
       icc_id = "1.08", cpc_id = "0118", wiki_id = "Q161211", gbif_id = "5828197",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "japanese millet", broader = class$concept[13], scientific = "Echinochloa esculenta",
       icc_id = "1.08", cpc_id = "0118", wiki_id = "Q2061528", gbif_id = "2702798",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "proso millet", broader = class$concept[13], scientific = "Panicum miliaceum",
       icc_id = "1.08", cpc_id = "0118", wiki_id = "Q165196", gbif_id = "2705090",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "oat", broader = class$concept[13], scientific = "Avena sativa",
       icc_id = "1.07", cpc_id = "0117", wiki_id = "Q165403 | Q4064203", gbif_id = "2705290",
       use_type = "food | fodder", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "triticale", broader = class$concept[13], scientific = "Triticosecale",
       icc_id = "1.09", cpc_id = "01191", wiki_id = "Q380329", gbif_id = "2703325",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "buckwheat", broader = class$concept[13], scientific = "Fagopyrum esculentum",
       icc_id = "1.1", cpc_id = "01192", wiki_id = "Q132734 | Q4536337", gbif_id = "2889373",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "canary seed", broader = class$concept[13], scientific = "Phalaris canariensis",
       icc_id = "1.13", cpc_id = "01195", wiki_id = "Q2086586", gbif_id = "5289744",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "fonio", broader = class$concept[13], scientific = "Digitaria exilis | Digitaria iburua",
       icc_id = "1.11", cpc_id = "01193", wiki_id = "Q1340738 | Q12439809", gbif_id = "5289953",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "quinoa", broader = class$concept[13], scientific = "Chenopodium quinoa",
       icc_id = "1.12", cpc_id = "01194", wiki_id = "Q104030862 | Q139925", gbif_id = "3083935",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "rice", broader = class$concept[13], scientific = "Oryza sativa",
       icc_id = "1.03", cpc_id = "0113", wiki_id = "Q5090 | Q161426", gbif_id = "2703459",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "african rice", broader = class$concept[13], scientific = "Oryza glaberrima",
       icc_id = "1.03", cpc_id = "0113", wiki_id = "Q2670252", gbif_id = "2703464",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "rye", broader = class$concept[13], scientific = "Secale cereale",
       icc_id = "1.06", cpc_id = "0116", wiki_id = "Q5090 | Q161426", gbif_id = "2705966",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "sorghum", broader = class$concept[13], scientific = "Sorghum bicolor",
       icc_id = "1.04", cpc_id = "0114 | 01919.01", wiki_id = "Q12099", gbif_id = "2705181",
       use_type = "food | fodder", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "teff", broader = class$concept[13], scientific = "Eragrostis tef",
       icc_id = "1.9", cpc_id = "01199.01", wiki_id = "Q843942 | Q103205493", gbif_id = "2705325",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "wheat", broader = class$concept[13], scientific = "Triticum aestivum",
       icc_id = "1.01", cpc_id = "0111", wiki_id = "Q161098", gbif_id = "7795888",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = )

cereals <-
  list(concept = "wheat", broader = class$concept[13], scientific = "Triticum durum",
       icc_id = "1.01", cpc_id = "0111", wiki_id = "Q618324", gbif_id = "2706389",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .)

cereals <-
  list(concept = "wheat", broader = class$concept[13], scientific = "Triticum spelta",
       icc_id = "1.01", cpc_id = "0111", wiki_id = "Q158767", gbif_id = "2706402",
       use_type = "food", used_part = "seed", life_form = "graminoid",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(cereals, .) %>%
  map_dfr(cereals, as_tibble_row)

luckiOnto <- new_concept(new = cereals$concept,
                         broader = get_concept(table = cereals %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Leguminous seeds ----
legumes <-
  list(concept = "bambara bean", broader = class$concept[14], scientific = "Vigna subterranea",
       icc_id = "7.09", cpc_id = "01708", wiki_id = "Q107357073", gbif_id = "2982714",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = )

legumes <-
  list(concept = "common bean", broader = class$concept[14], scientific = "Phaseolus vulgaris",
       icc_id = "7.01", cpc_id = "01701", wiki_id = "Q42339 | Q2987371", gbif_id = "5350452",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(legumes, .)

legumes <-
  list(concept = "broad bean", broader = class$concept[14], scientific = "Vicia faba",
       icc_id = "7.02", cpc_id = "01702", wiki_id = "Q131342 | Q61672189", gbif_id = "2974832",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(legumes, .)

legumes <-
  list(concept = "chickpea", broader = class$concept[14], scientific = "Cicer arietinum",
       icc_id = "7.03", cpc_id = "01703", wiki_id = "Q81375 | Q21156930", gbif_id = "2947311",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(legumes, .)

legumes <-
  list(concept = "cow pea", broader = class$concept[14], scientific = "Vigna unguiculata",
       icc_id = "7.04", cpc_id = "01706", wiki_id = "Q107414065", gbif_id = "2982583",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(legumes, .)

legumes <-
  list(concept = "lentil", broader = class$concept[14], scientific = "Lens culinaris",
       icc_id = "7.05", cpc_id = "01704", wiki_id = "Q61505177 | Q131226", gbif_id = "5350010",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(legumes, .)

legumes <-
  list(concept = "pea", broader = class$concept[14], scientific = "Pisum sativum",
       icc_id = "7.07", cpc_id = "01705", wiki_id = "Q13189 | Q13202263", gbif_id = "5347845",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(legumes, .)

legumes <-
  list(concept = "pigeon pea", broader = class$concept[14], scientific = "Cajanus cajan",
       icc_id = "7.08", cpc_id = "01707", wiki_id = "Q632559 | Q103449274", gbif_id = "7587087",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(legumes, .)

legumes <-
  list(concept = "vetch", broader = class$concept[14], scientific = "Vicia sativa",
       icc_id = "7.1", cpc_id = "01709.01", wiki_id = "Q157071", gbif_id = "2975014",
       use_type = "food | fodder", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(legumes, .)

legumes <-
  list(concept = "carob", broader = class$concept[14], scientific = "Ceratonia siliqua",
       icc_id = "3.9", cpc_id = "01356", wiki_id = "Q8195444 | Q68763", gbif_id = "5356354",
       use_type = "food", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(legumes, .) %>%
  map_dfr(legumes, as_tibble_row)

luckiOnto <- new_concept(new = legumes$concept,
                         broader = get_concept(table = legumes %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Treenuts ----
nuts <-
  list(concept = "almond", broader = class$concept[15], scientific = "Prunus dulcis",
       icc_id = "3.06.01", cpc_id = "01371", wiki_id = "Q184357 | Q15545507", gbif_id = "3022502",
       use_type = "food", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = )

nuts <-
  list(concept = "areca nut", broader = class$concept[15], scientific = "Areca catechu",
       icc_id = "3.06.08", cpc_id = "01379.01", wiki_id = "Q1816679 | Q156969", gbif_id = "2736531",
       use_type = "food", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(nuts, .)

nuts <-
  list(concept = "brazil nut", broader = class$concept[15], scientific = "Bertholletia excelsa",
       icc_id = "3.06.07", cpc_id = "01377", wiki_id = "Q12371971", gbif_id = "3083180",
       use_type = "food", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(nuts, .)

nuts <-
  list(concept = "cashew", broader = class$concept[15], scientific = "Anacardium occidentale",
       icc_id = "3.06.02", cpc_id = "01372", wiki_id = "Q7885904 | Q34007", gbif_id = "5421368",
       use_type = "food", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(nuts, .)

nuts <-
  list(concept = "chestnut", broader = class$concept[15], scientific = "Castanea sativa",
       icc_id = "3.06.03", cpc_id = "01373", wiki_id = "Q773987", gbif_id = "5333294",
       use_type = "food", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(nuts, .)

nuts <-
  list(concept = "hazelnut | filbert", broader = class$concept[15], scientific =  "Corylus avellana",
       icc_id = "3.06.04", cpc_id = "01374", wiki_id = "Q578307 | Q104738415", gbif_id = "2875979",
       use_type = "food", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(nuts, .)

nuts <-
  list(concept = "kolanut", broader = class$concept[15], scientific = "Cola acuminata | Cola nitida | Cola vera",
       icc_id = "3.06.09", cpc_id = "01379.02", wiki_id = "Q114264 | Q912522", gbif_id = "5406685 | 5406687",
       use_type = "food", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(nuts, .)

nuts <-
  list(concept = "macadamia", broader = class$concept[15], scientific = "Macadamia integrifolia | Macadamia tetraphylla",
       icc_id = "3.06.90", cpc_id = "01379", wiki_id = "Q310041 | Q11027461",
       gbif_id = "2891785 | 2891787",
       use_type = "food", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(nuts, .)

nuts <-
  list(concept = "pecan", broader = class$concept[15], scientific = "Carya illinoensis",
       icc_id = "3.06.90", cpc_id = "01379", wiki_id = "Q333877 | Q1119911", gbif_id = "4205617",
       use_type = "food", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(nuts, .)

nuts <-
  list(concept = "pistachio", broader = class$concept[15], scientific = "Pistacia vera",
       icc_id = "3.06.05", cpc_id = "01375", wiki_id = "Q14959225 | Q36071", gbif_id = "3190585",
       use_type = "food", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(nuts, .)

nuts <-
  list(concept = "walnut", broader = class$concept[15], scientific = "Juglans spp.",
       icc_id = "3.06.06", cpc_id = "01376", wiki_id = "Q208021 | Q46871", gbif_id = "3054350",
       use_type = "food", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(nuts, .) %>%
  map_dfr(nuts, as_tibble_row)

luckiOnto <- new_concept(new = nuts$concept,
                         broader = get_concept(table = nuts %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Oilseeds ----
oilseeds <-
  list(concept = "castor bean", broader = class$concept[16], scientific = "Ricinus communis",
       icc_id = "4.03.01", cpc_id = "01447", wiki_id = "Q64597240 | Q155867", gbif_id = "5380041",
       use_type = "medicinal | food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = )

oilseeds <-
  list(concept = "cotton", broader = class$concept[16], scientific = "Gossypium spp.",
       icc_id = "9.02.01.01", cpc_id = "0143 | 01921", wiki_id = "Q11457", gbif_id = "3152652",
       use_type = "food | fibre", used_part = "fruit | husk", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "earth pea", broader = class$concept[16], scientific = "Vigna subterranea",
       icc_id = "7.9", cpc_id = "01709.90", wiki_id = "Q338219", gbif_id = "2982714",
       use_type = "food", used_part = "fruit", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "fenugreek", broader = class$concept[16], scientific = "Trigonella foenum-graecum",
       icc_id = "7.90", cpc_id = "01709.90", wiki_id = "Q133205", gbif_id = "5360475",
       use_type = "food", used_part = "seed | leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "hemp", broader = class$concept[16], scientific = "Canabis sativa",
       icc_id = "9.02.01.04", cpc_id = "01449.02 | 01929.02", wiki_id = "Q26726 | Q7150699 | Q13414920", gbif_id = "5361880",
       use_type = "food | fibre", used_part = "seed | lint", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "linseed", broader = class$concept[16], scientific = "Linum usitatissimum",
       icc_id = "4.03.02 | 9.02.01.03", cpc_id = "01441 | 01929.01", wiki_id = "Q911332", gbif_id = "2873861",
       use_type = "food | fibre | industrial", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "jojoba", broader = class$concept[16], scientific = "Simmondsia chinensis",
       icc_id = "4.03.11", cpc_id = "01499.03", wiki_id = "Q267749", gbif_id = "5361949",
       use_type = "food", used_part = "seed | bast | seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "mustard", broader = class$concept[16], scientific = "Brassica nigra | Sinapis alba",
       icc_id = "4.03.03", cpc_id = "01442", wiki_id = "Q131748 | Q146202 | Q504781", gbif_id = "3042658 | 3047621",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "niger seed", broader = class$concept[16], scientific = "Guizotia abyssinica",
       icc_id = "4.03.04", cpc_id = "01449.90", wiki_id = "Q110009144", gbif_id = "8584304",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "peanut | goundnut", broader = class$concept[16], scientific = "Arachis hypogaea",
       icc_id = "4.02", cpc_id = "0142", wiki_id = "Q3406628 | Q23485", gbif_id = "5353770",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "poppy", broader = class$concept[16], scientific = "Papaver somniferum",
       icc_id = "4.03.12", cpc_id = "01448", wiki_id = "Q131584 | Q130201", gbif_id = "2888439",
       use_type = "food | medicinal | recreation", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "rapeseed | colza", broader = class$concept[16], scientific = "Brassica napus",
       icc_id = "4.03.05", cpc_id = "01443", wiki_id = "Q177932", gbif_id = "3042636",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "safflower", broader = class$concept[16], scientific = "Carthamus tinctorius",
       icc_id = "4.03.06", cpc_id = "01446", wiki_id = "Q156625 | Q104413623", gbif_id = "3138327",
       use_type = "food | industrial", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "sesame", broader = class$concept[16], scientific = "Sesamum indicum",
       icc_id = "4.03.07", cpc_id = "01444", wiki_id = "Q2763698 | Q12000036", gbif_id = "3172622",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "soybean", broader = class$concept[16], scientific = "Glycine max",
       icc_id = "4.01", cpc_id = "0141", wiki_id = "Q11006", gbif_id = "5359660",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "sunflower", broader = class$concept[16], scientific = "Helianthus annuus",
       icc_id = "4.03.08", cpc_id = "01445", wiki_id = "Q26949 | Q171497 | Q1076906", gbif_id = "9206251",
       use_type = "food | fodder", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "shea nut | karite nut", broader = class$concept[16], scientific = "Vitellaria paradoxa",
       icc_id = "4.03.09", cpc_id = "01499.01", wiki_id = "Q104212650 | Q50839003", gbif_id = "2886750",
       use_type = "food", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "tallowtree", broader = class$concept[16], scientific = "Shorea aptera | Shorea stenocarpa | Sapium sebiferum",
       icc_id = "4.03.13", cpc_id = "01499.04", wiki_id = "Q1201089", gbif_id = "5377858",
       use_type = "industrial", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .)

oilseeds <-
  list(concept = "tung nut", broader = class$concept[16], scientific = "Aleurites fordii",
       icc_id = "4.03.10", cpc_id = "01499.02", wiki_id = "Q2699247 | Q2094522", gbif_id = "3074907",
       use_type = "industrial", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(oilseeds, .) %>%
  map_dfr(oilseeds, as_tibble_row)

luckiOnto <- new_concept(new = oilseeds$concept,
                         broader = get_concept(table = oilseeds %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Stimulant crops ----
stimulants <-
  list(concept = "tobacco", broader = class$concept[17], scientific = "Nicotiana tabacum",
       icc_id = "9.06", cpc_id = "01970", wiki_id = "Q1566 | Q181095", gbif_id = "2928774",
       use_type = "recreation", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = )

stimulants <-
  list(concept = "cocoa | cacao", broader = class$concept[17], scientific = "Theobroma cacao",
       icc_id = "6.01.04", cpc_id = "01640", wiki_id = "Q208008", gbif_id = "3152205",
       use_type = "food | recreation", used_part = "seed", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(stimulants, .)

stimulants <-
  list(concept = "coffee", broader = class$concept[17], scientific = "Coffea spp.",
       icc_id = "6.01.01", cpc_id = "01610", wiki_id = "Q8486", gbif_id = "2895315",
       use_type = "food | recreation", used_part = "fruit", life_form = "shrub",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(stimulants, .)

stimulants <-
  list(concept = "mate", broader = class$concept[17], scientific = "Ilex paraguariensis",
       icc_id = "6.01.03", cpc_id = "01630", wiki_id = "Q81602 | Q5881191", gbif_id = "5414252",
       use_type = "food | recreation", used_part = "leaves", life_form = "shrub",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(stimulants, .)

stimulants <-
  list(concept = "tea", broader = class$concept[17], scientific = "Camellia sinensis",
       icc_id = "6.01.02", cpc_id = "01620", wiki_id = "Q101815 | Q6097", gbif_id = "3189635",
       use_type = "food | recreation", used_part = "leaves", life_form = "shrub",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(stimulants, .) %>%
  map_dfr(stimulants, as_tibble_row)

luckiOnto <- new_concept(new = stimulants$concept,
                         broader = get_concept(table = stimulants %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Spice crops ----
spice <-
  list(concept = "anise", broader = class$concept[18], scientific = "Pimpinella anisum",
       icc_id = "6.02.01.02", cpc_id = "01654", wiki_id = "Q28692", gbif_id = "5371877",
       use_type = "food", used_part = "fruit", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "1")

spice <-
  list(concept = "badian | star anise", broader = class$concept[18], scientific = "Illicium verum",
       icc_id = "6.02.01.02", cpc_id = "01654", wiki_id = "Q2878644 | Q1760637", gbif_id = "2889756",
       use_type = "food", used_part = "fruit", life_form = "tree",
       ybh = "9", yoh = "80", harvests = "1",
       yield = ,
       height = "20") %>%
  list(spice, .)

spice <-
  list(concept = "cannella cinnamon", broader = class$concept[18], scientific = "Cinnamomum verum",
       icc_id = "6.02.02.03", cpc_id = "01655", wiki_id = "Q28165 | Q370239", gbif_id = "3033987",
       use_type = "food | medicinal", used_part = "bark", life_form = "tree",
       ybh = "3", yoh = "40-50",
       harvests = ,
       yield = ,
       height = "5") %>%
  list(spice, .)

spice <-
  list(concept = "caraway", broader = class$concept[18], scientific = "Carum carvi",
       icc_id = "6.02.01.90", cpc_id = "01654", wiki_id = "Q26811", gbif_id = "3034714",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = "1", yoh = "2", harvests = "1", yield = "0.8-1.5", height = "1") %>%
  list(spice, .)

spice <-
  list(concept = "cardamon", broader = class$concept[18], scientific = "Elettaria cardamomum",
       icc_id = "6.02.02.02", cpc_id = "01653", wiki_id = "Q33466 | Q14625808", gbif_id = "2759871",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = "5") %>%
  list(spice, .)

spice <-
  list(concept = "chillies and peppers", broader = class$concept[18], scientific = "Capsicum spp.",
       icc_id = "6.02.01.01", cpc_id = "01652 | 01231", wiki_id = "Q165199 | Q201959 | Q1380", gbif_id = "2932937",
       use_type = "food | medicinal", used_part = "fruit", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "2") %>%
  list(spice, .)

spice <-
  list(concept = "coriander", broader = class$concept[18], scientific = "Coriandrum sativum",
       icc_id = "6.02.01.02", cpc_id = "01654", wiki_id = "Q41611 | Q20856764", gbif_id = "3034871",
       use_type = "food", used_part = "seed | leaves", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1", yield = "2", height = "0.5") %>%
  list(spice, .)

spice <-
  list(concept = "cumin", broader = class$concept[18], scientific = "Cuminum cyminum",
       icc_id = "6.02.01.02", cpc_id = "01654", wiki_id = "Q57328174 | Q132624", gbif_id = "3034775",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "0.5") %>%
  list(spice, .)

spice <-
  list(concept = "dill", broader = class$concept[18], scientific = "Anethum graveoles",
       icc_id = "6.02.01.02", cpc_id = "0169", wiki_id = "Q26686 | Q59659860", gbif_id = "3034646",
       use_type = "food", used_part = "seed | leaves", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "1") %>%
  list(spice, .)

spice <-
  list(concept = "fennel", broader = class$concept[18], scientific = "Foeniculum vulgare",
       icc_id = "6.02.02.90", cpc_id = "01654", wiki_id = "Q43511 | Q27658833", gbif_id = "3034922",
       use_type = "food", used_part = "bulb | leaves | fruit", life_form = "forb",
       ybh = "0",
       yoh = "1",
       harvests = "1",
       yield = ,
       height = "2") %>%
  list(spice, .)

spice <-
  list(concept = "hop", broader = class$concept[18], scientific = "Humulus lupulus",
       icc_id = "6.02.02.07", cpc_id = "01659", wiki_id = "Q104212", gbif_id = "2984535",
       use_type = "food", used_part = "flower", life_form = "vine",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "10") %>%
  list(spice, .)

spice <-
  list(concept = "malaguetta pepper | guinea pepper", broader = class$concept[18], scientific = "Aframomum melegueta",
       icc_id = "6.02.02.02", cpc_id = "01653", wiki_id = "Q1503476 | Q3312331", gbif_id = "2758930",
       use_type = "food", used_part = "fruit", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = "2") %>%
  list(spice, .)

spice <-
  list(concept = "thyme", broader = class$concept[18], scientific = "Thymus vulgaris",
       icc_id = "6.02.02.90", cpc_id = "0169", wiki_id = "Q148668 | Q3215980", gbif_id = "5341442",
       use_type = "food", used_part = "seed", life_form = "forb",
       ybh = "0", yoh = "5", harvests = "1",
       yield = ,
       height = "0.5") %>%
  list(spice, .)

spice <-
  list(concept = "ginger", broader = class$concept[18], scientific = "Zingiber officinale",
       icc_id = "6.02.02.05", cpc_id = "01657", wiki_id = "Q35625 | Q15046077", gbif_id = "2757280",
       use_type = "food", used_part = "root", life_form = "forb",
       ybh = "1", yoh = "2", harvests = "1",
       yield = ,
       height = "2") %>%
  list(spice, .)

spice <-
  list(concept = "pepper", broader = class$concept[18], scientific = "Piper nigrum",
       icc_id = "6.02.02.01", cpc_id = "01651", wiki_id = "Q43084", gbif_id = "3086357",
       use_type = "food", used_part = "fruit", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = "5") %>%
  list(spice, .)

spice <-
  list(concept = "vanilla", broader = class$concept[18], scientific = "Vanilla planifolia",
       icc_id = "6.02.02.06", cpc_id = "01658", wiki_id = "Q7224923 | Q162044", gbif_id = "2803398",
       use_type = "food", used_part = "fruit", life_form = "vine",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = "15") %>%
  list(spice, .)

spice <-
  list(concept = "lavender", broader = class$concept[18], scientific = "Lavandula spp.",
       icc_id = "9.03.01", cpc_id = "01699", wiki_id = "Q42081 | Q171892", gbif_id = "2927302",
       use_type = "food", used_part = "leaves | buds", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "1") %>%
  list(spice, .)

spice <-
  list(concept = "angelica", broader = class$concept[18], scientific = "Angelica archangelica",
       icc_id = "6.02.02.90",
       cpc_id = ,
       wiki_id = "Q207745", gbif_id = "5371808",
       use_type = "food | medicinal", used_part = "shoot", life_form = "forb",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = "2") %>%
  list(spice, .)

spice <-
  list(concept = "bay leaves", broader = class$concept[18], scientific = "Laurus nobilis",
       icc_id = "6.02.02.90",
       cpc_id = ,
       wiki_id = "Q26006", gbif_id = "3034015",
       use_type = "food | medicinal", used_part = "leaves", life_form = "tree",
       ybh = ,
       yoh = "1",
       harvests = ,
       yield = ,
       height = "20") %>%
  list(spice, .)

spice <-
  list(concept = "moringa", broader = class$concept[18], scientific = "Moringa oleifera",
       icc_id = "6.02.02.90",
       cpc_id = ,
       wiki_id = "Q234193", gbif_id = "3054181",
       use_type = "food", used_part = "fruit | leaves", life_form = "tree",
       ybh = "1",
       yoh = ,
       harvests = "2 | 9", yield = "31 | 0.6-1.2", height = "10") %>%
  list(spice, .)

spice <-
  list(concept = "saffron", broader = class$concept[18],        scientific = "Crocus sativus",
       icc_id = "6.02.02.90",
       cpc_id = ,
       wiki_id = "Q15041677", gbif_id = "2747430",
       use_type = "food", used_part = "flower", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "0.5") %>%
  list(spice, .)

spice <-
  list(concept = "turmeric", broader = class$concept[18], scientific = "Curcuma longa",
       icc_id = "6.02.02.90",
       cpc_id = ,
       wiki_id = "Q42562", gbif_id = "2757624",
       use_type = "food | medicinal", used_part = "root", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "1") %>%
  list(spice, .)

spice <-
  list(concept = "clove", broader = class$concept[18], scientific = "Eugenia aromatica",
       icc_id = "6.02.02.04", cpc_id = "01656", wiki_id = "Q15622897 | Q26736", gbif_id = "3183002",
       use_type = "food", used_part = "flower", life_form = "tree",
       ybh = "0",
       yoh = ,
       harvests = ,
       yield = ,
       height = "10") %>%
  list(spice, .)

spice <-
  list(concept = "nutmeg | mace", broader = class$concept[18], scientific = "Myristica fragrans",
       icc_id = "6.02.02.02", cpc_id = "01653", wiki_id = "Q1882876 | Q2724976", gbif_id = "5406817",
       use_type = "food", used_part = "seed", life_form = "tree",
       ybh = "8",
       yoh = ,
       harvests = ,
       yield = ,
       height = "20") %>%
  list(spice, .)

spice <-
  list(concept = "juniper berry", broader = class$concept[18], scientific = "Juniperus communis",
       icc_id = "6.02.01.02", cpc_id = "01654", wiki_id = "Q3251025 | Q26325", gbif_id = "2684709",
       use_type = "food", used_part = "fruit", life_form = "shrub",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = "10") %>%
  list(spice, .) %>%
  map_dfr(spice, as_tibble_row)


luckiOnto <- new_concept(new = spice$concept,
                         broader = get_concept(table = spice %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Medicinal crops ----
medicinal <-
  list(concept = "basil", broader = class$concept[19], scientific = "Ocimum basilicum",
       icc_id = "9.03.01.02", cpc_id = "01699", wiki_id = "Q38859 | Q65522654", gbif_id = "2927096",
       use_type = "food", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(medicinal, .)

medicinal <-
  list(concept = "ginseng", broader = class$concept[19], scientific = "Panax ginseng",
       icc_id = "9.03.02.01", cpc_id = "01699", wiki_id = "Q182881 | Q20817212", gbif_id = "5372262",
       use_type = "food", used_part = "root", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(medicinal, .)

medicinal <-
  list(concept = "guarana", broader = class$concept[19], scientific = "Paulinia cupana",
       icc_id = "9.03.02.04", cpc_id = "01699", wiki_id = "Q209089", gbif_id = "3189949",
       use_type = "food | recreation", used_part = "seed", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(medicinal, .)

medicinal <-
  list(concept = "kava", broader = class$concept[19], scientific = "Piper methysticum",
       icc_id = "9.03.02.03", cpc_id = "01699", wiki_id = "Q161067", gbif_id = "3086358",
       use_type = "food", used_part = "root", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(medicinal, .)

medicinal <-
  list(concept = "liquorice", broader = class$concept[19], scientific = "Glycyrrhiza glabra",
       icc_id = "9.03.01", cpc_id = "01930", wiki_id = "Q257106", gbif_id = "2965732",
       use_type = "food | medicinal", used_part = "root", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(medicinal, .)

medicinal <-
  list(concept = "mint", broader = class$concept[19], scientific = "Mentha spp.",
       icc_id = "9.03.01.01", cpc_id = "01699 | 01930.01", wiki_id = "Q47859 | Q156037", gbif_id = "2927173",
       use_type = "food", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(medicinal, .)

medicinal <-
  list(concept = "coca", broader = class$concept[19], scientific = "Erythroxylum novogranatense | Erythroxylum coca",
       icc_id = "9.03.02.02", cpc_id = "01699", wiki_id = "Q158018", gbif_id = "2873941 | 2873939",
       use_type = "recreation", used_part = "leaves", life_form = "tree",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(medicinal, .) %>%
  map_dfr(medicinal, as_tibble_row)

luckiOnto <- new_concept(new = medicinal$concept,
                         broader = get_concept(table = medicinal %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Sugar crops ----
sugar <-
  list(concept = "stevia", broader = class$concept[20], scientific_name = "Stevia rebaudiana",
       icc_id = "8.9", cpc_id = "01809", wiki_id = "Q312246 | Q7213452 | Q3644010", gbif_id = "3125557",
       use_type = "food", used_part = "leaves", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1", yield = "1-7.6", height = "1") %>%
  list(sugar, .)

sugar <-
  list(concept = "sugar beet", broader = class$concept[20], scientific_name = "Beta vulgaris var. altissima",
       icc_id = "8.01", cpc_id = "01801 | 01919.06", wiki_id = "Q151964", gbif_id = "",
       use_type = "food | fodder", used_part = "root", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1", yield = "40-80", height = "0.5") %>%
  list(sugar, .)

sugar <-
  list(concept = "sugar cane", broader = class$concept[20], scientific = "Saccharum officinarum",
       icc_id = "8.02", cpc_id = "01802 | 01919.91", wiki_id = "Q36940 | Q3391243", gbif_id = "2703912",
       use_type = "food | fodder", used_part = "shoot | sap", life_form = "graminoid",
       ybh = "9-24", yoh = "10", harvests = "1", yield = "30-180", height = "5") %>%
  list(sugar, .)

sugar <-
  list(concept = "sweet sorghum", broader = class$concept[20], scientific = "Sorghum saccharatum",
       icc_id = "8.03", cpc_id = "01809", wiki_id = "Q3123184 | Q332062", gbif_id = "2705181",
       use_type = "food | fodder | energy", used_part = "shoot | sap", life_form = "graminoid",
       ybh = "0", yoh = "1", harvests = "1", yield = "7-9.5", height = "5") %>%
  list(sugar, .)

sugar <-
  list(concept = "sugar maple", broader = class$concept[20], scientific_name = "Acer saccharum",
       icc_id = "8.9", cpc_id = "01809", wiki_id = "Q214733", gbif_id = "3189859",
       use_type = "food", used_part = "sap", life_form = "tree",
       ybh = "30-40",
       yoh = ,
       harvests = ,
       yield = ,
       height = "30") %>%
  list(sugar, .) %>%
  map_dfr(sugar, as_tibble_row)

luckiOnto <- new_concept(new = sugar$concept,
                         broader = get_concept(table = sugar %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Fruit-bearing vegetables ----
fruit_veg <-
  list(concept = "cantaloupe", broader = class$concept[21], scientific = "Cucumis melo",
       icc_id = "2.05.02", cpc_id = "01229", wiki_id = "Q61858403 | Q477179", gbif_id = "2874570",
       use_type = "food", used_part = "fruit", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fruit_veg, .)

fruit_veg <-
  list(concept = "chayote", broader = class$concept[21], scientific = "Sechium edule",
       icc_id = "2.02.90", cpc_id = "01239.90", wiki_id = "Q319611", gbif_id = "2874612",
       use_type = "food", used_part = "fruit", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fruit_veg, .)

fruit_veg <-
  list(concept = "cucumber | gherkin", broader = class$concept[21], scientific = "Cucumis sativus",
       icc_id = "2.02.01", cpc_id = "01232", wiki_id = "Q2735883 | Q23425", gbif_id = "2874569",
       use_type = "food", used_part = "fruit", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fruit_veg, .)

fruit_veg <-
  list(concept = "eggplant", broader = class$concept[21], scientific = "Solanum melongena",
       icc_id = "2.02.02", cpc_id = "01233", wiki_id = "Q7540 | Q12533094", gbif_id = "2930617",
       use_type = "food", used_part = "fruit", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fruit_veg, .)

fruit_veg <-
  list(concept = "gourd", broader = class$concept[21], scientific = "Lagenaria spp | Cucurbita spp.",
       icc_id = "2.02.04", cpc_id = "01235", wiki_id = "Q7370671", gbif_id = "2874671 | 2874506",
       use_type = "food", used_part = "fruit", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fruit_veg, .)

fruit_veg <-
  list(concept = "melon", broader = class$concept[21], scientific = "Cucumis melo",
       icc_id = "2.05.02", cpc_id = "01229", wiki_id = "Q5881191 | Q81602", gbif_id = "2874570",
       use_type = "food", used_part = "fruit", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fruit_veg, .)

fruit_veg <-
  list(concept = "okra", broader = class$concept[21], scientific = "Abelmoschus esculentus | Hibiscus esculentus",
       icc_id = "2.02.05", cpc_id = "01239.01", wiki_id = "Q80531 | Q12047207", gbif_id = "3152708",
       use_type = "food", used_part = "fruit", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fruit_veg, .)

fruit_veg <-
  list(concept = "pumpkin", broader = class$concept[21], scientific = "Cucurbita spp",
       icc_id = "2.02.04", cpc_id = "01235", wiki_id = "Q165308 | Q5339301", gbif_id = "2874506",
       use_type = "food | fodder", used_part = "fruit",
       life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fruit_veg, .)

fruit_veg <-
  list(concept = "squash", broader = class$concept[21], scientific = "Cucurbita spp",
       icc_id = "2.02.04", cpc_id = "01235", wiki_id = "Q5339237 | Q7533", gbif_id = "2874506",
       use_type = "food | fodder", used_part = "fruit", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fruit_veg, .)

fruit_veg <-
  list(concept = "sweet pepper", broader = class$concept[21], scientific = "Capsicum annuum",
       icc_id = "6.02.01.01", cpc_id = "01231", wiki_id = "Q1548030", gbif_id = "2932944",
       use_type = "food", used_part = "fruit", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fruit_veg, .)

fruit_veg <-
  list(concept = "tamarillo", broader = class$concept[21], scientific = "Solanum betaceum",
       icc_id = "2.02.90", cpc_id = "01239.90", wiki_id = "Q379747", gbif_id = "2930216",
       use_type = "food", used_part = "fruit", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fruit_veg, .)

fruit_veg <-
  list(concept = "tomato", broader = class$concept[21], scientific = "Lycopersicon esculentum",
       icc_id = "2.02.03", cpc_id = "01234", wiki_id = "Q20638126 | Q23501", gbif_id = "2930181",
       use_type = "food", used_part = "fruit", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fruit_veg, .)

fruit_veg <-
  list(concept = "watermelon", broader = class$concept[21], scientific = "Citrullus lanatus",
       icc_id = "2.05.01", cpc_id = "01221", wiki_id = "Q38645 | Q17507129", gbif_id = "2874621",
       use_type = "food", used_part = "fruit", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(fruit_veg, .) %>%
  map_dfr(fruit_veg, as_tibble_row)

luckiOnto <- new_concept(new = fruit_veg$concept,
                         broader = get_concept(table = fruit_veg %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Leaf or stem vegetables ----
leaf_veg <-
  list(concept = "artichoke", broader = class$concept[22], scientific = "Cynara scolymus",
       icc_id = "2.01.01", cpc_id = "01216", wiki_id = "Q23041430", gbif_id = "3112361",
       use_type = "food", used_part = "flower", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = )

leaf_veg <-
  list(concept = "asparagus", broader = class$concept[22], scientific = "Asparagus officinalis",
       icc_id = "2.01.02", cpc_id = "01211", wiki_id = "Q2853420 | Q23041045", gbif_id = "2768885",
       use_type = "food", used_part = "shoots", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "bok choy | pak choi", broader = class$concept[22], scientific = "Brassica rapa subsp. chinensis",
       icc_id = "2.01.03", cpc_id = "01212", wiki_id = "Q18968514", gbif_id = "3042702",
       use_type = "fodder | food", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "broccoli", broader = class$concept[22], scientific = "Brassica oleracea var. botrytis",
       icc_id = "2.01.04", cpc_id = "01213", wiki_id = "Q47722 | Q57544960", gbif_id = "3042854",
       use_type = "food", used_part = "flower", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "brussels sprout", broader = class$concept[22], scientific = "Brassica oleracea var. gemmifera",
       icc_id = "2.01.90", cpc_id = "01212", wiki_id = "Q150463 | Q104664711", gbif_id = "9451746",
       use_type = "fodder | food", used_part = "flower", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "cabbage", broader = class$concept[22], scientific = "Brassica oleracea var. capitata",
       icc_id = "2.01.03 | 01919.04", cpc_id = "01212", wiki_id = "Q14328596", gbif_id = "9263609",
       use_type = "food | fodder", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "cauliflower", broader = class$concept[22], scientific = "Brassica oleracea var. botrytis",
       icc_id = "2.01.04", cpc_id = "01213", wiki_id = "Q7537 | Q23900272", gbif_id = "3042854",
       use_type = "food", used_part = "flower", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "celery", broader = class$concept[22], scientific = "Apium graveolens",
       icc_id = "2.01.90", cpc_id = "01290", wiki_id = "Q28298", gbif_id = "5371879",
       use_type = "food", used_part = "shoots", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "chicory", broader = class$concept[22], scientific = "Cichorium intybus",
       icc_id = "2.01.07", cpc_id = "01214", wiki_id = "Q2544599 | Q1474", gbif_id = "5392252",
       use_type = "food | recreation", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "chinese cabbage", broader = class$concept[22], scientific = "Brassica chinensis",
       icc_id = "2.01.03", cpc_id = "01212", wiki_id = "Q13360268 | Q104664724", gbif_id = "7903057",
       use_type = "food", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "collard", broader = class$concept[22], scientific = "Brassica oleracea var. viridis",
       icc_id = "2.01.03", cpc_id = "01212", wiki_id = "Q146212 | Q14879985", gbif_id = "3042878",
       use_type = "food", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "endive", broader = class$concept[22], scientific = "Cichorium endivia",
       icc_id = "2.01.90", cpc_id = "01214", wiki_id = "Q178547 | Q28604477", gbif_id = "5392243",
       use_type = "food", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "gai lan", broader = class$concept[22], scientific = "Brassica oleracea var. alboglabra",
       icc_id = "2.01.03", cpc_id = "01212", wiki_id = "Q1677369 | Q104664699", gbif_id = "3042859",
       use_type = "food", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "kale", broader = class$concept[22], scientific = "Brassica oleracea var. acephala",
       icc_id = "2.01.90", cpc_id = "01212", wiki_id = "Q45989", gbif_id = "3042879",
       use_type = "food | fodder", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "lettuce", broader = class$concept[22], scientific = "Lactuca sativa var. capitata",
       icc_id = "2.01.05", cpc_id = "01214", wiki_id = "Q83193 | Q104666136", gbif_id = "4933901",
       use_type = "food", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "rhubarb", broader = class$concept[22], scientific = "Rheum spp.",
       icc_id = "2.01.90", cpc_id = "01219", wiki_id = "Q20767168", gbif_id = "2888863",
       use_type = "food", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "savoy cabbage", broader = class$concept[22], scientific = "Brassica oleracea var. capitata",
       icc_id = "2.01.03", cpc_id = "01212", wiki_id = "Q154013", gbif_id = "9263609",
       use_type = "food", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .)

leaf_veg <-
  list(concept = "spinach", broader = class$concept[22], scientific = "Spinacia oleracea",
       icc_id = "2.01.06", cpc_id = "01215", wiki_id = "Q81464", gbif_id = "3083647",
       use_type = "food", used_part = "leaves", life_form = "forb",
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(leaf_veg, .) %>%
  map_dfr(leaf_veg, as_tibble_row)

luckiOnto <- new_concept(new = leaf_veg$concept,
                         broader = get_concept(table = leaf_veg %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Mushrooms and truffles ----
mushrooms <-
  list(concept = "mushrooms", broader = class$concept[23], scientific = "Agaricus spp. | Pleurotus spp. | Volvariella",
       icc_id = "2.04", cpc_id = "01270", wiki_id = "Q654236", gbif_id = "2518646 | 2518610 | 2530192",
       use_type = useTypes$label[3], used_part = usedParts$label[5], life_form = lifeForms$label[6],
       ybh = "0", yoh = "1", harvests = "10-18",
       yield = ,
       height = "0.5") %>%
  list(mushrooms, .) %>%
  map_dfr(mushrooms, as_tibble_row)

luckiOnto <- new_concept(new = mushrooms$concept,
                         broader = get_concept(table = mushrooms %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Root vegetables ----
root_veg <-
  list(concept = "carrot", broader = class$concept[24], scientific = "Daucus carota subsp. sativus",
       icc_id = "2.03.01", cpc_id = "01251 | 01919.07", wiki_id = "Q11678009 | Q81", gbif_id = "4271342",
       use_type = "food | fodder", used_part = "root", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "2") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "chive", broader = class$concept[24], scientific = "Allium schoenoprasum",
       icc_id = "2.03.05", cpc_id = "01254", wiki_id = "Q51148 | Q5766863", gbif_id = "2855860",
       use_type = "food", used_part = "leaves", life_form = "forb",
       ybh = "0", yoh = "5", harvests = "3-5",
       yield = ,
       height = "0.5") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "beet root | red beet", broader = class$concept[24], scientific = "Beta vulgaris subsp. vulgaris conditiva group",
       icc_id = "8.01", cpc_id = "01801", wiki_id = "Q165191 | Q99548274", gbif_id = "7068845",
       use_type = "food | fodder | medicinal", used_part = "leaves", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "0.5") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "chard", broader = class$concept[24], scientific = "Beta vulgaris subsp. vulgaris cicla group",
       icc_id = "8.01", cpc_id = "01801", wiki_id = "Q157954", gbif_id = "7068845",
       use_type = "food", used_part = "leaves", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "1") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "garlic", broader = class$concept[24], scientific = "Allium sativum",
       icc_id = "2.03.03", cpc_id = "01252", wiki_id = "Q23400 | Q21546392", gbif_id = "2856681",
       use_type = "food", used_part = "bulb", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "1") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "leek", broader = class$concept[24], scientific = "Allium ampeloprasum",
       icc_id = "2.03.05", cpc_id = "01254", wiki_id = "Q1807269 | Q148995", gbif_id = "2856037",
       use_type = "food", used_part = "leaves", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "1") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "onion", broader = class$concept[24], scientific = "Allium cepa",
       icc_id = "2.03.04", cpc_id = "Q23485 | 01253", wiki_id = "Q23485 | Q3406628", gbif_id = "2857697",
       use_type = "food", used_part = "bulb", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "1") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "turnip", broader = class$concept[24], scientific = "Brassica rapa",
       icc_id = "2.03.02", cpc_id = "01251 | 01919.05", wiki_id = "Q33690609 | Q3916957", gbif_id = "7225636",
       use_type = "food", used_part = "root", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "0.5") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "mangelwurzel", broader = class$concept[24], scientific = "Beta vulgaris subsp. vulgaris crassa group",
       icc_id = "8.01", cpc_id = "01801", wiki_id = "Q740726", gbif_id = "7068845",
       use_type = "food | forage", used_part = "root", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "0.5") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "manioc | cassava | tapioca", broader = class$concept[24], scientific = "Manihot esculenta",
       icc_id = "5.03", cpc_id = "01520", wiki_id = "Q43304555 | Q83124", gbif_id = "3060998",
       use_type = "food | fodder", used_part = "tuber", life_form = "shrub",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "5") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "potato", broader = class$concept[24], scientific = "Solamum tuberosum",
       icc_id = "5.01", cpc_id = "01510", wiki_id = "Q16587531 | Q10998", gbif_id = "2930262",
       use_type = "food", used_part = "root", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "1") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "sweet potato", broader = class$concept[24], scientific = "Ipomoea batatas",
       icc_id = "5.02", cpc_id = "01530", wiki_id = "Q37937", gbif_id = "2928551",
       use_type = "food", used_part = "tuber", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "0.5") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "taro | dasheen", broader = class$concept[24], scientific = "Colocasia esculenta",
       icc_id = "5.05", cpc_id = "01550", wiki_id = "Q227997", gbif_id = "5330776",
       use_type = "food", used_part = "root", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "2") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "yam", broader = class$concept[24], scientific = "Dioscorea spp.",
       icc_id = "5.04", cpc_id = "01540", wiki_id = "Q8047551 | Q71549", gbif_id = "2754367",
       use_type = "food", used_part = "tuber", life_form = "vine",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "20") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "yautia", broader = class$concept[24], scientific = "Xanthosoma sagittifolium",
       icc_id = "5.06", cpc_id = "01591", wiki_id = "Q279280", gbif_id = "5330901",
       use_type = "food | fodder", used_part = "tuber", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "2") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "arracacha", broader = class$concept[24], scientific = "Arracacia xanthorrhiza",
       icc_id = "5.9", cpc_id = "01599", wiki_id = "Q625399", gbif_id = "3034509",
       use_type = "food", used_part = "root", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "1") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "celeriac", broader = class$concept[24], scientific =  "Apium graveolens var. rapaceum",
       icc_id = "2.03.90", cpc_id = "01259", wiki_id = "Q575174", gbif_id = "5539782",
       use_type = "food", used_part = "root", life_form = "forb",
       ybh = "0",
       yoh = "1",
       harvests = "1",
       yield = ,
       height = "1") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "horseradish", broader = class$concept[24], scientific = "Armoracia rusticana",
       icc_id = "2.03.90", cpc_id = "01259", wiki_id = "Q26545", gbif_id = "3041022",
       use_type = "food | medicinal", used_part = "root", life_form = "forb",
       ybh = "0", yoh = "1", harvests = "1",
       yield = ,
       height = "2") %>%
  list(root_veg, .)

root_veg <-
  list(concept =  "kohlrabi", broader = class$concept[24], scientific = "Brassica oleracea var. gongylodes",
       icc_id = "2.03.90", cpc_id = "01212", wiki_id = "Q147202", gbif_id = "3042850",
       use_type = "food", used_part = "shoots", life_form = "forb",
       ybh = "0",
       yoh = "1",
       harvests = "1",
       yield = ,
       height = "0.5") %>%
  list(root_veg, .)

root_veg <-
  list(concept = "radish", broader = class$concept[24], scientific = "Raphanus sativus",
       icc_id = "2.03.90", cpc_id = "01259", wiki_id = "Q1057750", gbif_id = "7678610",
       use_type = "food | medicinal", used_part = "root", life_form = "forb",
       ybh = "0",
       yoh = ,
       harvests = "1",
       yield = ,
       height = ) %>%
  list(root_veg, .)

root_veg <-
  list(concept = "salsify", broader = class$concept[24], scientific = "Tragopogon porrifolius",
       icc_id = "2.03.90", cpc_id = "01259", wiki_id = "Q941639", gbif_id = "5386938",
       use_type = "food", used_part = "root", life_form = "forb",
       ybh = "0",
       yoh = ,
       harvests = "1",
       yield = ,
       height = ) %>%
  list(root_veg, .)

root_veg <-
  list(concept = "scorzonera", broader = class$concept[24], scientific =  "Scorzonera hispanica",
       icc_id = "2.03.90", cpc_id = "01259", wiki_id = "Q385259", gbif_id = "3110905",
       use_type = "food", used_part = "root", life_form = "forb",
       ybh = "0",
       yoh = ,
       harvests = "1",
       yield = ,
       height = ) %>%
  list(root_veg, .)

root_veg <-
  list(concept = "sunroot", broader = class$concept[24], scientific = "Helianthus tuberosus",
       icc_id = "2.01.01", cpc_id = "01599", wiki_id = "Q146190", gbif_id = "3119175",
       use_type = "food", used_part = "root", life_form = "forb",
       ybh = "0",
       yoh = ,
       harvests = "1",
       yield = ,
       height = ) %>%
  list(root_veg, .)

root_veg <-
  list(concept =  "swede", broader = class$concept[24], scientific = "Brassica napus var. napobrassica",
       icc_id = "2.03.90", cpc_id = "01919.08", wiki_id = "Q158464 | Q158464", gbif_id = "6306660",
       use_type = "food", used_part = "root", life_form = "forb",
       ybh = "0",
       yoh = ,
       harvests = "1",
       yield = ,
       height = ) %>%
  list(root_veg, .)

root_veg <-
  list(concept = "parsnip", broader = class$concept[24], scientific = "Pastinaca sativa",
       icc_id = "2.03.90", cpc_id = "01259", wiki_id = "Q188614 | Q104413481", gbif_id = "8262702",
       use_type = "food",  used_part = "root", life_form = "forb",
       ybh = "0",
       yoh = ,
       harvests = "1",
       yield = ,
       height = ) %>%
  list(root_veg, .) %>%
  map_dfr(root_veg, as_tibble_row)

luckiOnto <- new_concept(new = root_veg$concept,
                         broader = get_concept(table = root_veg %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

#### Animals ----
animals <-
  list(concept = "partridge", broader = class$concept[25], scientific = "Alectoris rufa",
       icc_id = NA_character_, cpc_id = "02194", wiki_id = "Q25237 | Q29472543", gbif_id = "2474051",
       use_type = "food", used_part = "time | eggs | meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = )

animals <-
  list(concept = "pigeon", broader = class$concept[25], scientific = "Columba livia",
       icc_id = NA_character_, cpc_id = "02194", wiki_id = "Q2984138 | Q10856", gbif_id = "2495414",
       use_type = "labor | food", used_part = "time | eggs | meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "quail", broader = class$concept[25], scientific = "Coturnis spp.",
       icc_id = NA_character_, cpc_id = "02194", wiki_id = "Q28358", gbif_id = NA_character_,
       use_type = "food", used_part = "time | eggs | meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "chicken", broader = class$concept[25], scientific = "Gallus gallus",
       icc_id = NA_character_, cpc_id = "02151", wiki_id = "Q780", gbif_id = "9326020",
       use_type = "food", used_part = "time | eggs | meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "duck", broader = class$concept[25], scientific = "Anas platyrhynchos",
       icc_id = NA_character_, cpc_id = "02154", wiki_id = "Q3736439 | Q7556", gbif_id = "9761484",
       use_type = "food", used_part = "time | eggs | meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "goose", broader = class$concept[25], scientific = "Anser anser | Anser albofrons | Anser arvensis",
       icc_id = NA_character_, cpc_id = "02153", wiki_id = "Q16529344", gbif_id = "2498036",
       use_type = "labor | food", used_part = "time | eggs | meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "turkey", broader = class$concept[25], scientific = "Meleagris gallopavo",
       icc_id = NA_character_, cpc_id = "02152", wiki_id = "Q848706 | Q43794", gbif_id = "9606290",
       use_type = "food", used_part = "time | eggs | meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "hare", broader = class$concept[26], scientific = "Lepus spp.",
       icc_id = NA_character_, cpc_id = "02191", wiki_id = "Q46076 | Q63941258", gbif_id = "2436691",
       use_type = "food", used_part = "meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "rabbit", broader = class$concept[26], scientific = "Oryctolagus cuniculus",
       icc_id = NA_character_, cpc_id = "02191", wiki_id = "Q9394", gbif_id = "2436940",
       use_type = "food", used_part = "meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

# https://docs.google.com/spreadsheets/d/1ZXpLOwkqwJQItDfB9lUDKLg8580hTPbiMmJkWJABiz8/edit#gid=488199622
animals <-
  list(concept = "buffalo", broader = class$concept[28], scientific = "Bubalus bubalus | Bubalus ami | Bubalus depressicornis | Bubalus nanus | Syncerus spp. | Bison spp.",
       icc_id = NA_character_, cpc_id = "02112", wiki_id = "Q82728", gbif_id = "8085503 | 2441175",
       use_type = "labor | food", used_part = "time | milk | meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "cattle", broader = class$concept[28], scientific = "Bos bovis | Bos taurus | Bos indicus | Bos grunniens | Bos gaurus | Bos grontalis | Bos sondaicus",
       icc_id = NA_character_, cpc_id = "02111", wiki_id = "Q830 | Q4767951", gbif_id = "2441022 | 2441023 | 2441019 | 2441026",
       use_type = "labor | food", used_part = "time | milk | meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "goat", broader = class$concept[29], scientific = "Capra hircus",
       icc_id = NA_character_, cpc_id = "02123", wiki_id = "Q2934", gbif_id = "2441056",
       use_type = "labor | food", used_part = "time | milk | meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "sheep", broader = class$concept[29], scientific = "Ovis aries",
       icc_id = NA_character_, cpc_id = "02122", wiki_id = "Q7368", gbif_id = "2441110",
       use_type = "labor | food", used_part = "time | milk | meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "alpaca", broader = class$concept[30], scientific = "Vicugna pacos",
       icc_id = NA_character_, cpc_id = "02121.02", wiki_id = "Q81564", gbif_id = "7515593",
       use_type = "fibre", used_part = "hair", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "camel", broader = class$concept[30], scientific = "Camelus bactrianus | Camelus dromedarius",
       icc_id = NA_character_, cpc_id = "02121.01", wiki_id = "Q7375", gbif_id = "2441238 | 9055455",
       use_type = "labor", used_part = "time", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "guanaco", broader = class$concept[30], scientific = "Lama guanicoe",
       icc_id = NA_character_, cpc_id = "02121.02", wiki_id = "Q172886 | Q1552716", gbif_id = "5220188",
       use_type = "labor", used_part = "time", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "llama", broader = class$concept[30], scientific = "Lama glama",
       icc_id = NA_character_, cpc_id = "02121.02", wiki_id = "Q42569", gbif_id = "5220190",
       use_type = "fibre | labor", used_part = "hair | time", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "vicugna", broader = class$concept[30], scientific = "Vicugna vicugna",
       icc_id = NA_character_, cpc_id = "02121.02", wiki_id = "Q2703941 | Q167797", gbif_id = "5220192",
       use_type = "fibre", used_part = "hair", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "ass", broader = class$concept[31], scientific = "Equus asinus",
       icc_id = NA_character_, cpc_id = "02132", wiki_id = "Q19707", gbif_id = "2440891",
       use_type = "labor | food", used_part = "time | meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "horse", broader = class$concept[31], scientific = "Equus caballus",
       icc_id = NA_character_, cpc_id = "02131", wiki_id = "Q726 | Q10758650", gbif_id = "2440886",
       use_type = "labor | food", used_part = "time | meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "mule", broader = class$concept[31], scientific = "Equus africanus asinus × Equus ferus caballus",
       icc_id = NA_character_, cpc_id = "02133", wiki_id = "Q83093", gbif_id = NA_character_,
       use_type = "labor | food", used_part = "time | meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "pig", broader = class$concept[32], scientific = "Sus domesticus | Sus scrofa",
       icc_id = NA_character_, cpc_id = "02140", wiki_id = "Q787", gbif_id = "7705930",
       use_type = "food", used_part = "meat", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .)

animals <-
  list(concept = "beehive", broader = class$concept[33], scientific = "Apis mellifera | Apis dorsata | Apis florea | Apis indica",
       icc_id = NA_character_, cpc_id = "02196", wiki_id = "Q165107", gbif_id = "1341976 | 1341978 | 1341974 | 1341979",
       use_type = "labor | food", used_part = "honey", life_form = NA_character_,
       ybh = ,
       yoh = ,
       harvests = ,
       yield = ,
       height = ) %>%
  list(animals, .) %>%
  map_dfr(animals, as_tibble_row)

luckiOnto <- new_concept(new = animals$concept,
                         broader = get_concept(table = animals %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)


# mappings to other ontologies/vocabularies or attributes ----
message(" --> mappings to other vocabularies")

luckiOnto <- new_mapping(new = commodity$icc_id,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "icc", match = "close", certainty = 3,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$cpc_id,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "cpc", match = "close", certainty = 3,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$scientific_name,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "species", match = "close", certainty = 3,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$wiki_id,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "wiki", match = "close", certainty = 3,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$gbif_id,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "gbif", match = "close", certainty = 3,
                         ontology = luckiOnto)

# luckiOnto <- new_mapping(new = lcGroup$clc,
#                          target = get_concept(table = lcGroup %>% select(label = concept), ontology = luckiOnto),
#                          source = "clc", match = "close", certainty = 3,
#                          ontology = luckiOnto)

# luckiOnto <- new_mapping(new = lc$clc,
#                          target = get_concept(table = lc %>% select(label = concept), ontology = luckiOnto),
#                          source = "clc", match = "close", certainty = 3,
#                          ontology = luckiOnto)

# luckiOnto <- new_mapping(new = lu$esa_lc,
#                          target = get_concept(table = lu %>% select(label = concept), ontology = luckiOnto),
#                          source = "esalc", match = "close", certainty = 3,
#                          ontology = luckiOnto)

# luckiOnto <- new_mapping(new = lu$fra,
#                          target = get_concept(table = lu %>% select(label = concept), ontology = luckiOnto),
#                          source = "fra", match = "close", certainty = 3,
#                          ontology = luckiOnto)

# luckiOnto <- new_mapping(new = lc$fao_lu,
#                          target = get_concept(table = lc %>% select(label = concept), ontology = luckiOnto),
#                          source = "faoLu", match = "close", certainty = 3,
#                          ontology = luckiOnto)
#
# luckiOnto <- new_mapping(new = lu$fao_lu,
#                          target = get_concept(table = lu %>% select(label = concept), ontology = luckiOnto),
#                          source = "faoLu", match = "close", certainty = 3,
#                          ontology = luckiOnto)
# luckiOnto <- new_mapping(new = commodity$initiation,
#                          target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
#                          source = "initiation", match = "narrower", certainty = 3,
#                          ontology = luckiOnto)


# luckiOnto <- new_mapping(new = commodity$persistence,
#                          target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
#                          source = "persistence", match = "narrow", certainty = 3,
#                          lut = lut_persistence,
#                          ontology = luckiOnto)

# luckiOnto <- new_mapping(new = commodity$duration,
#                          target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
#                          source = "duration", match = "narrow", certainty = 3,
#                          lut = lut_duration,
#                          ontology = luckiOnto)


# luckiOnto <- new_mapping(new = commodity$harvests,
#                          target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
#                          source = "harvests", match = "narrow", certainty = 3,
#                          lut = lut_harvests,
#                          ontology = luckiOnto)

## yield ----
# luckiOnto <- new_source(name = "yield",
#                         date = Sys.Date(),
#                         description = "the typical dry-weight yield a crop produces, in tonnes/ha/harvest.",
#                         homepage = "",
#                         license = "",
#                         ontology = luckiOnto)
#
# luckiOnto <- new_mapping(new = commodity$yield,
#                          target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
#                          source = "yield", match = "narrow", certainty = 3,
#                          ontology = luckiOnto)


# luckiOnto <- new_mapping(new = commodity$height,
#                          target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
#                          source = "height", match = "close", certainty = 3,
#                          lut = lut_height,
#                          ontology = luckiOnto)


luckiOnto <- new_mapping(new = commodity$life_form,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "life-form", match = "close", certainty = 3,
                         lut = lifeForms,
                         ontology = luckiOnto)

## use-type ----
luckiOnto <- new_mapping(new = commodity$use_type,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "use-type", match = "close", certainty = 3,
                         lut = useTypes,
                         ontology = luckiOnto)

# luckiOnto <- new_mapping(new = commodity$used_part,
#                          target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
#                          source = "use-part", match = "close", certainty = 3,
#                          lut = lut_usedPart,
#                          ontology = luckiOnto)


# write output ----
#
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))
export_as_rdf(ontology = luckiOnto, filename = paste0(dataDir, "tables/luckiOnto.ttl"))
