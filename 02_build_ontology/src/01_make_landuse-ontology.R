# script arguments ----
#
message("\n---- build landuse ontology ----")


# load data ----
#


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


# define new classes ----
luckiOnto <- new_class(new = "domain", target = NA,
                       description = "the type of description system", ontology = luckiOnto) %>%
  new_class(new = "group", target = "domain",
            description = "broad groups of concepts that describe crops and livestock", ontology = .) %>%
  new_class(new = "class", target = "group",
            description = "mutually exclusive types of concepts that describe crops and livestock", ontology = .) %>%
  new_class(new = "commodity", target = "class",
            description = "concepts that describe crops or livestock",  ontology = .)

# define the harmonized concepts ----
domain <- tibble(concept = c("production systems"),
                 description = c("production systems described by the crops or livestock grown there"))

luckiOnto <- new_concept(new = domain$concept,
                         description = domain$description,
                         class = "domain",
                         ontology =  luckiOnto)

## surface types
message("     land surface types")

### landcover groups
# lcGroup <- tibble(concept = c("ARTIFICIAL LAND", "AGRICULTURAL LAND", "FOREST LAND", "SEMI-NATURAL LAND", "WETLANDS", "WATER BODIES"),
#                   description = c("Land that has been created by humans and which is covered with an artificial surface",
#                                   "Land that has been created by humans to grow plants for agricultural production, including pastures",
#                                   "Land that is covered by plant associations that are dominated by trees used for forestry",
#                                   "Land that is covered by semi-natural plant associations that are not under any (active) human use",
#                                   "Land that is covered by water the greater part of a year and which is otherwise typically covered by terrestrial plant associations",
#                                   "Land that is covered by permanent water bodies"),
#                   clc = c("1", "2", "3", "3", "4", "5"),
#                   broader = "surface types")

# luckiOnto <- new_concept(new = lcGroup$concept,
#                          broader = get_concept(table = lcGroup %>% select(label = broader), ontology = luckiOnto),
#                          description = lcGroup$description,
#                          class = "land-cover group",
#                          ontology =  luckiOnto)

### land cover
# lc <- list(
#   tibble(concept = c("Urban fabric", "Industrial, commercial and transport units", "Mine, dump and construction sites", "Artificial areas for agricultural production", "Artificial, non-agricultural vegetated areas"),
#          description = c("Areas mainly occupied by dwellings and buildings used by administrative/public utilities, including their connected areas (associated lands, approach road network, parking lots)",
#                          "Areas mainly occupied by industrial activities of manufacturing, trade, financial activities and services, transport infrastructures for road traffic and rail networks, airport installations, river and sea port installations, including their associated lands and access infrastructures",
#                          "Artificial areas mainly occupied by extractive activities, construction sites, man-made waste dump sites and their associated lands",
#                          "Areas mainly occupied by buildings that facilitate agricultural production such as livestock rearing facilities, greenhouses or agrovoltaic installations",
#                          "Areas voluntarily created for recreational use. Includes green or recreational and leisure urban parks, sport and leisure facilities"),
#          clc = c("1.1", "1.2", "1.3", NA_character_, "1.4"),
#          fao_lu = c(NA_character_),
#          broader = lcGroup$concept[1]),
#   tibble(concept = c("Temporary cropland", "Pastures", "Permanent cropland", "Heterogeneous agricultural lands"),
#          description = c("Lands under a rotation system used for annually harvested plants and fallow lands, which are rain-fed or irrigated. Includes flooded crops such as rice fields and other inundated croplands",
#                          "Lands that are permanently used (at least 5 years) for fodder production. Includes natural or sown herbaceous species, unimproved or lightly improved meadows, grazed or mechanically harvested meadows and pastures under a woody cover",
#                          "All surfaces occupied by permanent crops, not under a rotation system. Includes ligneous crops of standards cultures for fruit production such as extensive fruit orchards, olive groves, chestnut groves, walnut groves shrub orchards such as vineyards and some specific low-system orchard plantation, espaliers and climbers; all of which typically form a regular grid of a single species",
#                          "Areas of annual crops associated with permanent crops on the same parcel, annual crops cultivated under forest trees, areas of annual crops, meadows and/or permanent crops which are juxtaposed, landscapes in which crops and pastures are intimately mixed with natural vegetation or natural areas"),
#          clc = c("2.1", "2.3", "2.2", "2.4.4"),
#          fao_lu = c("6621", "6655", "6650", NA_character_),
#          broader = lcGroup$concept[2]),
#   tibble(concept = c("Forests"),
#          description = c("Areas occupied by forests and woodlands with a vegetation pattern composed of native or exotic coniferous and/or broad-leaved trees and which can be used for the production of timber or other forest products. The forest trees are under normal climatic conditions higher than 5 m with a canopy closure of 30 % at least. In case of young plantation, the minimum cut-off-point is 500 subjects by ha"),
#          clc = c("3.1"),
#          fao_lu = c("6646"),
#          broader = lcGroup$concept[3]),
#   tibble(concept = c("Shrubland", "Herbaceous associations", "Open spaces with little or no vegetation", "Heterogeneous semi-natural areas"), #"Other Wooded Areas"),
#          description = c("Bushy sclerophyllous vegetation in a climax stage of development, including maquis, matorral and garrigue",
#                          "Grasslands under no or moderate human influence. Low productivity grasslands. Often situated in areas of rough, uneven ground, steep slopes; frequently including rocky areas or patches of other (semi-)natural vegetation.",
#                          "Natural areas covered with little or no vegetation, including open thermophile formations of sandy or rocky grounds distributed on calcareous or siliceous soils frequently disturbed by erosion, steppic grasslands, perennial steppe-like grasslands, meso- and thermo-Mediterranean xerophile, mostly open, short-grass perennial grasslands, alpha steppes, vegetated or sparsely vegetated areas of stones on steep slopes, screes, cliffs, rock fares, limestone pavements with plant communities colonising their tracks, perpetual snow and ice, inland sand-dune, coastal sand-dunes and burnt natural woody vegetation areas",
#                          "Bushes, shrubs, dwarf shrubs and herbaceous plants with occasional scattered trees on the same parcel. The vegetation is low with closed cover and under no or moderate human influence. Can represent woodland degradation, forest regeneration / recolonization, natural succession or moors and heathland."),
#          clc = c("3.2", "3.2", "3.3", "3.2"),
#          fao_lu = c(NA_character_, NA_character_, NA_character_, NA_character_),
#          broader = lcGroup$concept[4]),
#   tibble(concept = c("Inland wetlands", "Marine wetlands"),
#          description = c("Areas flooded or liable to flooding during the great part of the year by fresh, brackish or standing water with specific vegetation coverage made of low shrub, semi-ligneous or herbaceous species. Includes water-fringe vegetation of lakes, rivers, and brooks and of fens and eutrophic marshes, vegetation of transition mires and quaking bogs and springs, highly oligotrophic and strongly acidic communities composed mainly of sphagnum growing on peat and deriving moistures of raised bogs and blanket bogs",
#                          "Areas which are submerged by high tides at some stage of the annual tidal cycle. Includes salt meadows, facies of saltmarsh grass meadows, transitional or not to other communities, vegetation occupying zones of varying salinity and humidity, sands and muds submerged for part of every tide devoid of vascular plants, active or recently abandoned salt-extraction evaporation basins"),
#          clc = c("4.1", "4.2"),
#          fao_lu = c(NA_character_),
#          broader = lcGroup$concept[6]),
#   tibble(concept = c("Inland waters", "Marine waters"),
#          description = c("Lakes, ponds and pools of natural origin containing fresh (i.e non-saline) water and running waters made of all rivers and streams. Man-made fresh water bodies including reservoirs and canals",
#                          "Oceanic and continental shelf waters, bays and narrow channels including sea lochs or loughs, fiords or fjords, rya straits and estuaries. Saline or brackish coastal waters often formed from sea inlets by sitting and cut-off from the sea by sand or mud banks"),
#          clc = c("5.1", "5.2"),
#          fao_lu = c("6680", "6773"),
#          broader = lcGroup$concept[7])) %>%
#   bind_rows()

# luckiOnto <- new_concept(new = lc$concept,
#                          broader = get_concept(table = lc %>% select(label = broader), ontology = luckiOnto),
#                          description = lc$description,
#                          class = "land cover",
#                          ontology =  luckiOnto)

### land use
# lu <- list(
#   tibble(concept = c("Protective Cover", "Agrovoltaics"),
#          description = c("Land covered by buildings that are used to produce plants, mushrooms or livestock under highly controlable conditions",
#                          "Land covered by solar panels in combination with agriculture or livestock rearing."),
#          fra = c(NA_character_),
#          fao_lu = c("6649", NA_character_),
#          esa_lc = c("10 | 30 | 40 | 190", "10 | 30 | 40"),
#          broader = lc$concept[4]),
#   tibble(concept = c("Fallow", "Herbaceous crops", "Temporary grazing"),
#          description = c("Land covered by temporary cropland that is currently (no longer than for 3 years) not used",
#                          "Land covered by temporary cropland that is used to produce any herbaceous crop",
#                          "Land covered by temporary cropland that is currently used for grazing or fodder production"),
#          fra = c(NA_character_),
#          fao_lu = c("6640", "6630", "6633"),
#          esa_lc = c("10 | 11 | 30 | 40", "10 | 11 | 20 | 30 | 40", "10 | 11 | 30 | 40"),
#          broader = lc$concept[6]),
#   tibble(concept = c("Shrub orchards", "Palm plantations", "Tree orchards", "Woody plantation"),
#          description = c("Land covered by permanent cropland that is used to produce commodities that grow on shrubby vegetation",
#                          "Land covered by permanent cropland that is used to produce commodities that grow on palms trees",
#                          "Land covered by permanent cropland that is used to produce commodities that grow on trees other than palms",
#                          "Land covered by permanent cropland that is used to produce woood or biomass from even-aged trees of one or, at most two, tree species"),
#          fra = c(NA_character_, "3.1.1", "3.1.2", "1.2.1"),
#          fao_lu = c("6650", "6650", "6650", "6650"),
#          esa_lc = c("10 | 12 | 30 | 40", "10 | 12 | 30 | 40 | 50", "10 | 12 | 30 | 40", "10 | 12 | 30 | 40"),
#          broader = lc$concept[8]),
#   tibble(concept = c("Cultivated pastures", "Naturally grown pastures"),
#          description = c("Land covered by pastures that are cultivated and managed",
#                          "Land covered by pastures that are grown naturally, either on grassland or under woody cover"),
#          fra = c(NA_character_),
#          fao_lu = c("6656", "6659"),
#          esa_lc = c("10 | 11 | 20 | 30 | 40", "30 | 40 | 100 | 110 | 130"),
#          broader = lc$concept[7]),
#   tibble(concept = c("Agroforestry", "Mix of agricultural uses"),
#          description = c("Land covered by temporary cropland under the wooded cover of forestry species",
#                          "Land covered by a mix of various temporary and/or permanent crops on the same parcel"),
#          fra = c("3.1.3", NA_character_),
#          fao_lu = c(NA_character_),
#          esa_lc = c("10 | 20 | 30 | 40", "10 | 20 | 30 | 40"),
#          broader = lc$concept[9]),
#   tibble(concept = c("Undisturbed Forest", "Naturally Regenerating Forest", "Planted Forest", "Temporally Unstocked Forest"),
#          description = c("Land covered by forest of native tree species that has been naturally regenerated, where there are no clearly visible indications of human activities and the ecological processes are not significantly disturbed",
#                          "Land covered by forest predominantly composed of trees established through natural regeneration",
#                          "Land covered by forest predominantly composed of trees established through planting and/or deliberate seeding",
#                          "Land covered by forest which is temporarily unstocked or with trees shorter than 1.3 meters that have not yet reached but are expected to reach a canopy cover of at least 10 percent and tree height of at least 5 meters"),
#          fra = c("1.3", "1.1", "1.2", "1.6"),
#          fao_lu = c("6714", "6717", "6716", NA_character_),
#          esa_lc = c("30 | 40 | 50 | 60 | 70 | 80 | 90 | 100 | 110"),
#          broader = lc$concept[10])) %>%
#   bind_rows() %>%
#   mutate(lu_id = seq_along(concept))

# luckiOnto <- new_concept(new = lu$concept,
#                          broader = get_concept(table = lu %>% select(label = broader), ontology = luckiOnto),
#                          description = lu$description,
#                          class = "land use",
#                          ontology =  luckiOnto)

## crop production systems ----
message("     crop and livestock production systems")

### groups ----
group <- tibble(concept = c("NON-FOOD CROPS", "FRUIT", "SEEDS", "STIMULANTING CROPS",
                            "SUGAR CROPS", "VEGETABLES", "BIRDS", "GLIRES", "UNGULATES", "INSECTS"),
                description = c("This group comprises plants that are grown primarily for all sort of industrial, non-food related purposes",
                                "This group comprises plants that are grown primarily to use their (typically sweet or sour) fleshy parts that are edible in a raw state",
                                "This group comprises plants that are grown primarily to use their seeds as food source. 'Seed' is regarded as the reproductive organ that, when put into a suitably substrate, grows a new plant.",
                                "This group comprises plants that are grown primarily to make use of their medicinal effect, their taste or for their mind-altering effects",
                                "This group comprises plants that are grown primarily for their sugar content",
                                "This group comprises plants that are grown primarily to use some of their organs (includes typically savory fruit, but not seeds) that are often heated to be easily digestible",
                                "This group comprises birds that are used for their eggs or meat or to perform tasks they were trained for",
                                "This group comprises lagomorphs and rodents that are used for their meat or fur",
                                "This group comprises ungulates that are used for their milk, meat and skin or to perform tasks they were trained for",
                                "This group comprises insects that are used for the substances they produce or directly for human consumption"),
                broader = "production systems")

luckiOnto <- new_concept(new = group$concept,
                         broader = get_concept(table = group %>% select(label = broader), ontology = luckiOnto),
                         class = "group",
                         ontology = luckiOnto)

### classes ----
class <- list(
  tibble(concept = c("Bioenergy crops", "Fibre crops", "Flower crops", "Rubber crops", "Pasture and forage crops"),
         description = c("This class covers plants that are grown primarily for the production of energy",
                         "This class covers plants that are primarily grown because some plant part is used to produce textile fibres. Other uses of other plant parts, such as fruit or oilseeds are possible",
                         "This class covers plants that are primarily grown to use some of their parts for ornamental reasons",
                         "This class covers plants that are grown to produce gums and rubbers",
                         "This class covers plants that are grown as food source for animals, to produce fodder/silage or to be grazed on by livestock"),
         broader = group$concept[1]),
  tibble(concept = c("Berries", "Citrus Fruit", "Grapes", "Pome Fruit", "Stone Fruit", "Oleaginous fruits", "Tropical and subtropical Fruit"),
         description = c("This class covers plants that are grown for their fruit that have small, soft roundish edible tissue",
                         "This class covers plants that are part of the genus Citrus",
                         "This class covers plants that are part of the genus Vitis",
                         "This class covers plants that are grown for their apple-like fruit",
                         "This class covers plants that are grown for their fruit that have a single hard stone and a fleshy, juicy edible tissue",
                         "This calss covers plants that are grown for their oil-containing tissue",
                         "This class covers plants that grow in tropical and subtropical regions"),
         broader = group$concept[2]),
  tibble(concept = c("Cereals", "Leguminous seeds", "Treenuts", "Oilseeds"),
         description = c("This class covers graminoid plants that are grown for their grain. This class also includes pseudocereals, as they are also grown for their grain",
                         "This class covers leguminous plants that are grown for both, their dry and green seeds",
                         "This class covers plants that are grown for their dry seeds that are protected by a hard shell",
                         "This class covers plants that are grown to use their seeds to produce oils for human nourishment"),
         broader = group$concept[3]),
  tibble(concept = c("Stimulant crops", "Spice crops", "Medicinal crops"),
         description = c("This class covers plants that are grown for their stimulating or mind-altering effects",
                         "This class covers plants that are grown for their aromatic properties",
                         "This class covers plants that are grown for their medical effects on the animal physiology"),
         broader = group$concept[4]),
  tibble(concept = c("Sugar crops"),
         description = c("This class covers plants that are primarily grown because some plant part is used to produce sugar. Other uses of other plant parts, such as fruit or oilseeds are possible"),
         broader = group$concept[5]),
  tibble(concept = c("Fruit-bearing vegetables", "Leaf or stem vegetables", "Mushrooms and truffles", "Root vegetables"),
         description = c("This class covers plants that are grown to use their fruit as vegetables",
                         "This class covers plants that are grown to use their leaves or stem as vegetables",
                         "This class covers mushrooms and truffles that are grown for human nourishment",
                         "This class covers plants that are grown to use their roots, tubers or bulbs as vegetables"),
         broader = group$concept[6]),
  tibble(concept = c("Poultry Birds"),
         description = c("This class covers all poultry birds"),
         broader = group$concept[7]),
  tibble(concept = c("Lagomorphs", "Rodents"),
         description = c("This class covers hares and rabbits",
                         "This class covers various rodents"),
         broader = group$concept[8]),
  tibble(concept = c("Bovines", "Caprines", "Camelids", "Equines", "Pigs"),
         description = c("This class covers bovine animals",
                         "This class covers goats, sheep",
                         "This class covers camels and lamas",
                         "This class covers horses, asses and mules",
                         "This class covers pigs and (domesticated) boar"),
         broader = group$concept[9]),
  tibble(concept = c("Food producing insects", "Fibre producing insects"),
         description = c("This class covers insect species that produce substances that are used as human nourishment, such as honey or protein",
                         "This class covers insect species that produce substances that are used as fibres"),
         broader = group$concept[10])) %>%
  bind_rows()

luckiOnto <- new_concept(new = class$concept,
                         broader = get_concept(table = class %>% select(label = broader), ontology = luckiOnto),
                         class = "class",
                         ontology =  luckiOnto)

### commodities ----

#### Bioenergy crops ----
bioenergy <- list(
  tibble(concept = c("bamboo", "giant reed", "miscanthus", "reed canary grass", "switchgrass"),
         broader = class$concept[1],
         scientific_name = c("Bambusa spp.", "Arundo donax", "Miscanthus × giganteus", "Phalaris arundinacea", "Panicum virgatum"),
         icc_id = c(NA_character_, NA_character_, NA_character_, NA_character_, NA_character_),
         cpc_id = c(NA_character_, NA_character_, NA_character_, NA_character_, NA_character_),
         wiki_id = c("Q311331 | Q2157176", "Q161114", "Q2152417", "Q157419", "Q1466543"),
         gbif_id = c("2705751", "2703041", "4122678", "5289756", "2705081"),
         use_typ = c("energy"),
         used_part = c("biomass"),
         life_form = c("graminoid"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("1", "20-25", "1", "1", "1"),
         harvests = c("", "2", "1", "", ""),
         yield = c("", "50-80", "20-30", "", ""),
         height = c("10", "5", "5", "2", "5")),
  tibble(concept = c("acacia", "black locust", "eucalyptus", "poplar", "willow"),
         broader = class$concept[1],
         scientific_name = c("Acacia spp.", "Robinia pseudoacacia", "Eucalyptus spp.", "Populus spp.", "Salix spp."),
         icc_id = c(NA_character_, NA_character_, NA_character_, NA_character_, NA_character_),
         cpc_id = c(NA_character_, NA_character_, NA_character_, NA_character_, NA_character_),
         wiki_id = c("Q81666", "Q2019723", "Q45669", "Q25356", "Q36050"),
         gbif_id = c(""),
         use_typ = c("energy"),
         used_part = c("biomass"),
         life_form = c("tree"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", "", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Fibre crops ----
fibre <- list(
  tibble(concept = c("jute", "kenaf", "ramie"),
         broader = class$concept[2],
         scientific_name = c("Corchorus spp.", "Hibiscus cannabinus", "Boehmeria nivea"),
         icc_id = c("9.02.01.02", "9.02.01.02", "9.02.02.01"),
         cpc_id = c("01922.01", "01922.02", "01929.04"),
         wiki_id = c("Q107211 | Q161489", "Q1137540", "Q2130134 | Q750467"),
         gbif_id = c("3032212", "3152547", "2984359"),
         use_typ = c("fibre", "fibre", "fibre"),
         used_part = c("bast"),
         life_form = c("forb"),
         initiation = c("0"),
         persistence = c("1", "1", "1"),
         harvests = c("1-3", "1-4", "2-6"),
         # duration = c("102-140", "70-140", "60-180"),
         yield = c("2-2.75", "6-10", "3.4-4.5"),
         height = c("5", "5", "2")),
  tibble(concept = c("abaca | manila hemp", "sisal"),
         broader = class$concept[2],
         scientific_name = c("Musa textilis", "Agave sisalana"),
         icc_id = c("9.02.02.90", "9.02.02.02"),
         cpc_id = c("01929.07", "01929.05"),
         wiki_id = c("Q161097", "Q159221 | Q847423"),
         gbif_id = c("2762907", "2766636"),
         use_typ = c("fibre", "fibre"),
         used_part = c("leaves"),
         life_form = c("tree"),
         # persistence = c("permanent"),
         initiation = c("1-2"), # insert the number of years the crop needs to grow, before harvest
         persistence = c("15-40", ""), # insert the number of years after which this crop must be renewed
         harvests = c("1-4", ""),
         yield = c("4", ""), # insert the number of harvests per year
         height = c("5", "2")),
  tibble(concept = c("", ""),
         # Citronella Cymbopogon citrates/ Cymbopogon nardus 992 9.90.02 35410.01
         # Henequen Agave fourcroydes 922 9.02.02 01929
         # Lemon grass Cymbopogon citratus 922 9.02.02 35410
         # Maguey Agave atrovirens 922 9.02.02 01929
         # New Zealand flax (formio) Phormium tenax 922 9.02.01.04 01929
         # Formio (New Zealand flax) Phormium tenax 9214 9.02.01.04 01929
         # Rhea Boehmeria nivea 922 9.02.02 26190
         # Fique Furcraea macrophylla 9219 9.02.01.90 01929
         broader = class$concept[2],
         scientific_name = c(""),
         icc_id = c(""),
         cpc_id = c(""),
         wiki_id = c(""),
         gbif_id = c(""),
         use_typ = c(""),
         used_part = c(""),
         life_form = c(""),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c(""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c(""), # insert the number of harvests per year
         height = c("")), # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
  tibble(concept = c("kapok"),
         broader = class$concept[2],
         scientific_name = c("Ceiba pentandra"),
         icc_id = c("9.02.02.90"),
         cpc_id = c("01929.03 | 01499.05"),
         wiki_id = c("Q1728687 | Q138617"),
         gbif_id = c("5406697"),
         use_typ = c("fibre | food"),
         used_part = c("seed"),
         life_form = c("tree"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c(""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c(""), # insert the number of harvests per year
         height = c("xx"))
)

#### Flower crops ----
flower <- list(

)

#### Rubber crops ----
rubber <- list(
  tibble(concept = c("natural rubber"),
         broader = class$concept[4],
         scientific_name = c("Hevea brasiliensis"),
         icc_id = c("9.04"),
         cpc_id = c("01950"),
         wiki_id = c("Q131877"),
         gbif_id = c(""),
         use_typ = c("industrial"),
         used_part = c("resin"),
         life_form = c("tree"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c(""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c(""), # insert the number of harvests per year
         height = c("")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Pasture and forage crops ----
pasture <- list(
  tibble(concept = c("alfalfa", "orchard grass", "redtop", "ryegrass", "sudan grass", "timothy", "trefoil"),
         broader = class$concept[5],
         scientific_name = c("Medicago sativa", "Dactylis glomerata", "Agrostis spp.", "Lolium spp.", "Sorghum × drummondii", "Phleum pratense", "Lotus spp."),
         icc_id = c("9.01.01", "9.01.01", "9.90.01", "9.90.01", "9.01.01", "9.01.01", "9.90.01"),
         cpc_id = c("01912 | 01940", "01919.91", "01919.91", "01919.02", "01919", "01919.91", "01919.92"),
         wiki_id = c("Q156106", "Q161735", "Q27835", "Q158509", "Q332062", "Q256508", "Q101538"),
         gbif_id = c(""),
         use_typ = c("food | fodder | forage", "fodder | forage", "forage", "forage", "fodder | energy", "fodder", "forage"),
         used_part = c("biomass"),
         life_form = c("graminoid"),
         # persistence = c("temporary"),
         initiation = c("0"),
         persistence = c("", "", "", "", "", "", ""),
         harvests = c(""),
         yield = c("", "", "", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "", "", "")), # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
  tibble(concept = c("clover", "lupin"),
         broader = class$concept[5],
         scientific_name = c("Trifolium spp.", "Lupinus spp."),
         icc_id = c("9.01.01", "7.06"),
         cpc_id = c("01919.03", "01709.02"),
         wiki_id = c("Q101538", "Q156811"),
         gbif_id = c(""),
         use_typ = c("fodder | forage", "fodder | forage | food"),
         used_part = "biomass",
         life_form = c("forb"),
         # persistence = c("temporary"),
         initiation = c("0"),
         persistence = c("", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", ""), # insert the number of harvests per year
         height = c("", "")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Berries ----
berries <- list(
  tibble(concept = c("blueberry", "cranberry", "currant", "gooseberry", "kiwi fruit", "raspberry", "strawberry"),
         broader = class$concept[6],
         scientific_name = c("Vaccinium myrtillus | Vaccinium corymbosum", "Vaccinium macrocarpon | Vaccinium oxycoccus", "Ribes spp.", "Ribes spp.", "Actinidia deliciosa", "Rubus spp.", "Fragaria spp."),
         icc_id = c("3.04.06", "3.04.07", "3.04.01", "3.04.02", "3.04.03", "3.04.04", "3.04.05"),
         cpc_id = c("01355.01", "01355.02", "01351.01", "01351.02", "01352", "01353.01", "01354"),
         wiki_id = c("Q13178", "Q374399 | Q13181 | Q21546387", "Q3241599", "Q41503 | Q17638951", "Q13194", "Q12252383 | Q13179", "Q745 | Q13158"),
         gbif_id = c(""),
         use_typ = c("food"),
         used_part = c("fruit"),
         life_form = c("shrub"),
         # persistence = c("temporary"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", "", "", "", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c("", "", "", "", "", "", ""),
         yield = c("", "", "", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "", "", "")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Citrus Fruit ----
citrus <- list(
  tibble(concept = c("bergamot", "clementine", "grapefruit", "lemon", "lime", "mandarine", "orange", "pomelo", "satsuma", "tangerine"),
         broader = class$concept[7],
         scientific_name = c("Citrus bergamia", "Citrus reticulata", "Citrus paradisi", "Citrus limon", "Citrus limetta | Citrus aurantifolia", "Citrus reticulata", "Citrus sinensis | Citrus aurantium", "Citrus grandis", "Citrus reticulata", "Citrus reticulata"),
         icc_id = c("3.02.90", "3.02.04", "3.02.01", "3.02.02", "3.02.02", "3.02.04", "3.02.03", "3.02.01", "3.02.04", "3.02.04"),
         cpc_id = c("01329", "01324.02", "01321", "01322", "01322", "01324.02", "01323", "01321", "01324", "01324.01"),
         wiki_id = c("Q109196", "Q460517", "Q21552830", "Q500 | Q1093742", "Q13195", "Q125337", "Q12330939 | Q34887", "Q353817 | Q80024", "Q875262", "Q516494"),
         gbif_id = c(""),
         use_typ = c("food"),
         used_part = c("fruit"),
         life_form = c("tree"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", "", "", "", "", "", "", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", "", "", "", "", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "", "", "", "", "", "")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Grapes ----
grapes <- list(
  tibble(concept = c("grape"),
         broader = class$concept[8],
         scientific_name = c("Vitis vinifera"),
         icc_id = c("3.03"),
         cpc_id = c("01330"),
         gbif_id = c(""),
         wiki_id = c("Q10978 | Q191019"),
         use_typ = c("food"),
         used_part = c("fruit"),
         life_form = c("shrub"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c(""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c(""), # insert the number of harvests per year
         height = c("2"))
)

#### Pome Fruit ----
pome <- list(
  tibble(concept = c("apple", "loquat", "medlar", "pear", "quince"),
         broader = class$concept[9],
         scientific_name = c("Malus sylvestris", "Eriobotrya japonica", "Mespilus germanica", "Pyrus communis", "Cydonia oblonga"),
         icc_id = c("2.05.01", "3.05.90", "3.05.90", "3.05.05", "3.05.05"),
         cpc_id = c("01341", "01359", "01359", "01342.01", "01342.02"),
         gbif_id = c(""),
         wiki_id = c("Q89 | Q15731356", "Q41505", "Q146186 | Q3092517", "Q434 | Q13099586", "Q2751465 | Q43300"),
         use_typ = c("food"),
         used_part = c("fruit"),
         life_form = c("tree"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", "", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Stone Fruit ----
stone <- list(
  tibble(concept = c("apricot", "cherry", "nectarine", "peach", "plum", "sloe", "sour cherry"),
         broader = class$concept[10],
         scientific_name = c("Prunus armeniaca", "Prunus avium", "Prunus persica var. nectarina", "Prunus persica", "Prunus domestica", "Prunus spinosa", "Prunus cerasus"),
         icc_id = c("3.05.02", "3.05.03", "3.05.04", "3.05.04", "3.05.06", "3.05.06", "3.05.03"),
         cpc_id = c("01343", "01344.02", "01345", "01345", "01346", "01346", "01344.01"),
         wiki_id = c("Q37453 | Q3733836", "Q196", "Q2724976 | Q83165", "Q37383", "Q6401215 | Q13223298", "Q12059685 | Q129018", "Q68438267 | Q131517"),
         gbif_id = c(""),
         use_typ = c("food"),
         used_part = c("fruit"),
         life_form = c("tree"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", "", "", "", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", "", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "", "", "")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Oleaginous fruits ----
oleaginous <- list(
  tibble(concept = c("coconut", "oil palm"),
         broader = class$concept[11],
         scientific_name = c("Cocos nucifera", "Elaeis guineensis"),
         icc_id = c("4.04.01 | 9.02.02.90", "4.04.03"),
         cpc_id = c("01460 | 01929.08", "01491"),
         wiki_id = c("Q3342808", "Q165403"),
         gbif_id = c(""),
         use_typ = c("food | fibre", "food"),
         used_part = c("seed | husk", "seed"),
         life_form = c("palm", "palm"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", ""), # insert the number of harvests per year
         height = c("", "")), # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
  tibble(concept = c("olive"),
         broader = class$concept[11],
         scientific_name = c("Olea europaea"),
         icc_id = c("4.04.02"),
         cpc_id = c("01450"),
         wiki_id = c("Q37083 | Q1621080"),
         gbif_id = c(""),
         use_typ = c("food"),
         used_part = c( "fruit"),
         life_form = c("tree"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c(""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c(""), # insert the number of harvests per year
         height = c("")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Tropical and subtropical Fruit ----
tropical <- list(
  tibble(concept = c("avocado", "banana", "guava", "mango", "mangosteen", "papaya", "persimmon", "plantain"),
         broader = class$concept[12],
         scientific_name = c("Persea americana", "Musa sapientum | Musa cavendishii | Musa nana", "Psidium guajava", "Mangifera indica", "Garcinia mangostana", "Carica papaya", "Diospyros kaki | Diospyros virginiana", "Musa paradisiaca"),
         icc_id = c("3.01.01", "3.01.02", "3.01.06", "3.01.06", "3.01.06", "3.01.07", "3.01.90", "3.01.03"),
         cpc_id = c("01311", "01312", "01316.02", "01316.01", "01316.03", "01317", "01359.01", "01313"),
         wiki_id = c("Q961769 | Q37153", "Q503", "Q166843 | Q3181909", "Q169", "Q170662 | Q104030000", "Q732775", "Q158482 | Q29526", "Q165449"),
         gbif_id = c(""),
         use_typ = c("food", "fibre | food", "food", "food", "food", "food", "food", "food"),
         used_part = c("fruit"),
         life_form = c("tree"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", "", "", "", "", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", "", "", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "", "", "", "")), # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
  tibble(concept = c(""),
         # This subclass includes:
         # - durian fruits
         # - bilimbi, Averrhoa bilimbi
         # - starfruit, carambola Averrhoa carambola
         # - fruit of various species of Sapindaceae, including:
         # - jackfruit
         # - passion fruit, Passiflora edulis, Passiflora quadrangularis
         # - akee, Blighia sapida
         # - pepinos, Solanum muricatum
         # Sapodilla Achras sapota 39 3.90 01319
         # Litchi Litchi chinensis 319 3.01.90 01319
         # Custard apple Annona reticulate 319 3.01.90 01319
         # Breadfruit Artocarpus altilis 319 3.01.90 01319
         # Mulberry for fruit (all varieties) Morus spp. 39 3.90 01343
         # Mulberry for silkworms Morus alba 39 3.90 01343
         # Pomegranate Punica granatum 39 3.90 01399
         broader = class$concept[12],
         scientific_name = c(""),
         icc_id = c(""),
         cpc_id = c(""),
         wiki_id = c(""),
         gbif_id = c(""),
         use_typ = c(""),
         used_part = c(""),
         life_form = c(""),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c(""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c(""), # insert the number of harvests per year
         height = c("")), # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
  tibble(concept = c("açaí", "date"),
         broader = class$concept[12],
         scientific_name = c("Euterpe oleracea", "Phoenix dactylifera"),
         icc_id = c("3.01.9", "3.01.04"),
         cpc_id = c("01319", "01314"),
         wiki_id = c("Q33943 | Q12300487", "Q1652093"),
         gbif_id = c(""),
         use_typ = c("food"),
         used_part = c("fruit"),
         life_form = c("palm"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", ""), # insert the number of harvests per year
         height = c("", "")), # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
  tibble(concept = c("pineapple", "fig"),
         broader = class$concept[12],
         scientific_name = c("Ananas comosus", "Ficus carica"),
         icc_id = c("3.01.08", "3.01.05"),
         cpc_id = c("01318", "01315"),
         wiki_id = c("Q1493 | Q10817602", "Q36146 | Q2746643"),
         gbif_id = c(""),
         use_typ = c("food"),
         used_part = c("fruit"),
         life_form = c("shrub"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", ""), # insert the number of harvests per year
         height = c("", "")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Cereals ----
cereals <- list(
  tibble(concept = c("barley", "maize", "millet", "oat", "triticale", "buckwheat", "canary seed", "fonio", "quinoa", "rice", "rye", "sorghum", "teff", "wheat", "mixed cereals"),
         broader = class$concept[13],
         scientific_name = c("Hordeum vulgare", "Zea mays", "Pennisetum americanum | Eleusine coracana | Setaria italica | Echinochloa esculenta | Panicum miliaceum", "Avena spp.", "Triticosecale", "Fagopyrum esculentum", "Phalaris canariensis", "Digitaria exilis | Digitaria iburua", "Chenopodium quinoa", "Oryza sativa | Oryza glaberrima", "Secale cereale", "Sorghum bicolor", "Eragrostis abyssinica", "Triticum aestivum | Triticum spelta | Triticum durum", NA_character_),
         icc_id = c("1.05", "1.02", "1.08", "1.07", "1.09", "1.1", "1.13", "1.11", "1.12", "1.03", "1.06", "1.04", "1.9", "1.01", "1.14"),
         cpc_id = c("0115", "01121 | 01911", "0118", "0117", "01191", "01192", "01195", "01193", "01194", "0113", "0116", "0114 | 01919.01", "01199.01", "0111", "01199.02"),
         wiki_id = c("Q11577", "Q11575 | Q25618328", "Q259438", "Q165403 | Q4064203", "Q380329", "Q132734 | Q4536337", "Q2086586", "Q1340738 | Q12439809", "Q104030862 | Q139925", "Q5090", "Q5090 | Q161426", "Q12099", "Q843942 | Q103205493", "Q105549747 | Q12111", "Q15645384 | Q161098 | Q618324"),
         gbif_id = c(""),
         use_typ = c("forage | food", "food | silage", "food", "food | fodder", "food", "food", "food", "food", "food", "food", "food", "food | fodder", "food", "food", "food"),
         used_part = c("seed"),
         life_form = c("graminoid"),
         # persistence = c("temporary"),
         initiation = c("0"),
         persistence = c("", "", "", "", "", "", "", "", "", "", "", "", "", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", "", "", "", "", "", "", "", "", "", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "", "", "", "", "", "", "", "", "", "", "")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Leguminous seeds ----
legumes <- list(
  tibble(concept = c("bambara bean", "common bean", "broad bean", "chickpea", "cow pea", "lentil", "pea", "pigeon pea", "vetch"),
         broader = class$concept[14],
         scientific_name = c("Vigna subterranea", "Phaseolus vulgaris", "Vicia faba", "Cicer arietinum", "Vigna unguiculata", "Lens culinaris", "Pisum sativum", "Cajanus cajan", "Vicia sativa"),
         icc_id = c("7.09", "7.01", "7.02", "7.03", "7.04", "7.05", "7.07", "7.08", "7.1"),
         cpc_id = c("01708", "01701", "01702", "01703", "01706", "01704", "01705", "01707", "01709.01"),
         wiki_id = c("Q107357073", "Q42339 | Q2987371", "Q131342 | Q61672189", "Q81375 | Q21156930", "Q107414065", "Q61505177 | Q131226", "Q13189 | Q13202263", "Q632559 | Q103449274", "Q157071"),
         gbif_id = c(""),
         use_typ = c("food", "food", "food", "food", "food", "food", "food", "food", "food | fodder"),
         used_part = c("seed"),
         life_form = c("forb"),
         # persistence = c("temporary"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", "", "", "", "", "", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", "", "", "", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "", "", "", "", "")), # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
  tibble(concept = c("carob"),
         broader = class$concept[14],
         scientific_name = c("Ceratonia siliqua"),
         icc_id = c("3.9"),
         cpc_id = c("01356"),
         wiki_id = c("Q8195444 | Q68763"),
         gbif_id = c(""),
         use_typ = c("food"),
         used_part = c("seed"),
         life_form = c("tree"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c(""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c(""), # insert the number of harvests per year
         height = c("")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Treenuts ----
nuts <- list(
  tibble(concept = c("almond", "areca nut", "brazil nut", "cashew", "chestnut", "hazelnut | filbert", "kolanut", "macadamia", "pecan", "pistachio", "walnut"),
         broader = class$concept[15],
         scientific_name = c("Prunus dulcis", "Areca catechu", "Bertholletia excelsa", "Anacardium occidentale", "Castanea sativa", "Corylus avellana", "Cola acuminata | Cola nitida | Cola vera", "Macadamia integrifolia | Macadamia tetraphylla", "Carya illinoensis", "Pistacia vera", "Juglans spp."),
         icc_id = c("3.06.01", "3.06.08", "3.06.07", "3.06.02", "3.06.03", "3.06.04", "3.06.09", "3.06.90", "3.06.90", "3.06.05", "3.06.06"),
         cpc_id = c("01371", "01379.01", "01377", "01372", "01373", "01374", "01379.02", "01379", "01379", "01375", "01376"),
         wiki_id = c("Q184357 | Q15545507", "Q1816679 | Q156969","Q12371971", "Q7885904 | Q34007", "Q773987", "Q578307 | Q104738415", "Q114264 | Q912522", "Q310041 | Q11027461", "Q333877 | Q1119911", "Q14959225 | Q36071", "Q208021 | Q46871"),
         gbif_id = c(""),
         use_typ = c("food"),
         used_part = c("seed"),
         life_form = c("tree"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", "", "", "", "", "", "", "", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", "", "", "", "", "", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "", "", "", "", "", "", "")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Oilseeds ----
oilseeds <- list(
  tibble(concept = c("castor bean", "cotton", "earth pea", "fenugreek", "hemp", "linseed", "jojoba", "mustard", "niger seed", "peanut | goundnut", "poppy", "rapeseed | colza", "safflower", "sesame", "soybean", "sunflower"),
         broader = class$concept[16],
         scientific_name = c("Ricinus communis", "Gossypium spp.", "Vigna subterranea", "Trigonella foenum-graecum", "Canabis sativa", "Linum usitatissimum", "Simmondsia californica | Simmondsia chinensis", "Brassica nigra | Sinapis alba", "Guizotia abyssinica", "Arachis hypogaea", "Papaver somniferum", "Brassica napus", "Carthamus tinctorius", "Sesamum indicum", "Glycine max", "Helianthus annuus"),
         icc_id = c("4.03.01", "9.02.01.01", "7.9", "7.90", "9.02.01.04", "4.03.02 | 9.02.01.03", "4.03.11", "4.03.03", "4.03.04", "4.02", "4.03.12", "4.03.05", "4.03.06", "4.03.07", "4.01", "4.03.08"),
         cpc_id = c("01447", "0143 | 01921", "01709.90", "01709.90", "01449.02 | 01929.02", "01441 | 01929.01", "01499.03", "01442", "01449.90", "0142", "01448", "01443", "01446", "01444", "0141", "01445"),
         wiki_id = c("Q64597240 | Q155867", "Q11457", "Q338219", "Q133205", "Q26726 | Q7150699 | Q13414920", "Q911332", "Q267749", "Q131748 | Q146202 | Q504781", "Q110009144", "Q3406628 | Q23485", "Q131584 | Q130201", "Q177932", "Q156625 | Q104413623", "Q2763698 | Q12000036", "Q11006", "Q26949 | Q171497 | Q1076906"),
         gbif_id = c(""),
         use_typ = c("medicinal | food", "food | fibre", "food", "food", "food | fibre", "food | fibre | industrial", "food", "food", "food", "food", "food | medicinal | recreation", "food", "food | industrial", "food", "food", "food | fodder"),
         used_part = c("seed", "fruit | husk", "fruit", "seed | leaves", "seed | lint", "seed", "seed | bast | seed", "seed", "seed", "seed", "seed", "seed", "seed", "seed", "seed", "seed"),
         life_form = c("forb"),
         # persistence = c("temporary"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")), # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
  tibble(concept = c("shea nut | karite nut", "tallowtree", "tung nut"),
         broader = class$concept[16],
         scientific_name = c("Vitellaria paradoxa | Butyrospermum parkii", "Shorea aptera | Shorea stenocarpa | Sapium sebiferum", "Aleurites fordii"),
         icc_id = c("4.03.09", "4.03.13", "4.03.10"),
         cpc_id = c("01499.01",  "01499.04", "01499.02"),
         wiki_id = c("Q104212650 | Q50839003", "Q1201089", "Q2699247 | Q2094522"),
         gbif_id = c(""),
         use_typ = c("food", "industrial", "industrial"),
         used_part = c("seed"),
         life_form = c("tree"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", ""), # insert the number of harvests per year
         height = c("", "", "")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Stimulant crops ----
stimulants <- list(
  tibble(concept = c("tobacco"),
         broader = class$concept[17],
         scientific_name = c("Nicotiana tabacum"),
         icc_id = c("9.06"),
         cpc_id = c("01970"),
         wiki_id = c("Q1566 | Q181095"),
         gbif_id = c(""),
         use_typ = c("recreation"),
         used_part = c("leaves"),
         life_form = c("forb"),
         # persistence = c("temporary"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c(""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c(""), # insert the number of harvests per year
         height = c("")), # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
  tibble(concept = c("cocoa | cacao"),
         broader = class$concept[17],
         scientific_name = c("Theobroma cacao"),
         icc_id = c("6.01.04"),
         cpc_id = c("01640"),
         wiki_id = c("Q208008"),
         gbif_id = c(""),
         use_typ = c("food | recreation"),
         used_part = c("seed"),
         life_form = c("tree"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c(""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c(""), # insert the number of harvests per year
         height = c("")), # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
  tibble(concept = c("coffee", "mate", "tea"),
         broader = class$concept[17],
         scientific_name = c("Coffea spp.", "Ilex paraguariensis", "Camellia sinensis"),
         icc_id = c("6.01.01", "6.01.03", "6.01.02"),
         cpc_id = c("01610", "01630", "01620"),
         wiki_id = c("Q8486", "Q81602 | Q5881191", "Q101815 | Q6097"),
         gbif_id = c(""),
         use_typ = c("food | recreation", "food | recreation", "food | recreation"),
         used_part = c("fruit", "leaves", "leaves"),
         life_form = c("shrub"),
         # persistence = c("permanent"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", ""), # insert the number of harvests per year
         height = c("", "", "")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Spice crops ----
spice <- list(
  tibble(concept = c("anise", "badian | star anise", "cannella cinnamon", "caraway", "cardamon", "chillies and peppers", "coriander",
                     "cumin", "dill", "fennel", "hop", "malaguetta pepper", "thyme", "ginger", "pepper", "vanilla", "lavender"),
         broader = class$concept[18],
         scientific_name = c("Pimpinella anisum", "Illicium verum", "Cinnamomum verum", "Carum carvi", "Elettaria cardamomum", "Capsicum spp.", "Coriandrum sativum", "Cuminum cyminum", "Anethum graveoles", "Foeniculum vulgare", "Humulus lupulus", "Aframomum melegueta", "Thymus vulgaris", "Zingiber officinale", "Piper nigrum", "Vanilla planifolia", "Lavandula spp."),
         icc_id = c("6.02.01.02", "6.02.01.02", "6.02.02.03", "6.02.01.90", "6.02.02.02", "6.02.01.01", "6.02.01.02", "6.02.01.02", "6.02.01.02", "6.02.02.90", "6.02.02.07", "6.02.02.02", "6.02.02.90", "6.02.02.05", "6.02.02.01", "6.02.02.06", "9.03.01"),
         cpc_id = c("01654", "01654", "01655", "01654", "01653", "01652 | 01231", "01654", "01654", "0169", "01654", "01659", "01653", "0169", "01657", "01651", "01658", "01699"),
         wiki_id = c("Q28692", "Q1760637", "Q28165 | Q370239", "Q26811", "Q14625808", "Q165199 | Q201959 | Q1380", "Q41611 | Q20856764", "Q57328174 | Q132624", "Q26686 | Q59659860", "Q43511 | Q27658833",  "Q104212", "Q3312331", "Q148668 | Q3215980", "Q35625 | Q15046077", "Q311426", "Q162044", "Q42081"),
         gbif_id = c("5371877", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""),
         use_typ = c("food"),
         used_part = c("fruit", "fruit", "bark", "seed", "seed", "fruit", "seed | leaves", "seed", "seed", "bulb | leaves | fruit", "flower", "fruit", "seed", "root", "fruit", "fruit", "leaves"),
         life_form = c("forb"),
         # persistence = c(rep("temporary", 13), rep("permanent", 4)),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")), # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
  tibble(concept = c("angelica", "bay leaves", "guinea pepper", "moringa", "saffron", "turmeric"),
         broader = class$concept[18],
         scientific_name = c("Angelica archangelica", "Laurus nobilis", "Aframomum melegueta", "Moringa oleifera", "Crocus sativus", "Curcuma longa"),
         icc_id = c("6.02.02.90"),
         cpc_id = c("01699"),
         wiki_id = c("Q207745", "Q26006", "Q1503476", "Q234193", "Q15041677", "Q42562"),
         gbif_id = c("5371808", "3034015", "2758930", "3054181", "2747430", "2757624"),
         use_typ = c("food | medicinal", "food | medicinal", "food", "food", "food", "food | medicinal"),
         used_part = c("stalk", "leaves", "fruit", "fruit | leaves", "flower", "root"),
         life_form = c("forb", "tree", "forb", "tree", "forb", "forb"),
         initiation = c("0", NA_character_, NA_character_, "1", "0", "0"),
         persistence = c(NA_character_, NA_character_, "1", NA_character_, "1", "1"),
         harvests = c(NA_character_, NA_character_, NA_character_, "2 | 9", "1", "1"),
         yield = c(NA_character_, NA_character_, NA_character_, "31 | 0.6-1.2", NA_character_, NA_character_),
         height = c("2", "20", "2", "10", "0.5", "1")),
  tibble(concept = c("clove", "nutmeg | mace"),
         broader = class$concept[18],
         scientific_name = c("Eugenia aromatica", "Myristica fragrans"),
         icc_id = c("6.02.02.04", "6.02.02.02"),
         cpc_id = c("01656", "01653"),
         wiki_id = c("Q15622897 | Q26736", "Q1882876 | Q2724976"),
         gbif_id = c("3183002", "5406817"),
         use_typ = c("food", "food"),
         used_part = c("flower", "seed"),
         life_form = c("tree", "tree"),
         initiation = c("0", "8"),
         persistence = c(NA_character_, NA_character_),
         harvests = c(NA_character_, NA_character_),
         yield = c(NA_character_, NA_character_),
         height = c("10", "20")),
  tibble(concept = c("juniper berry"),
         broader = class$concept[18],
         scientific_name = c("Juniperus communis"),
         icc_id = c("6.02.01.02"),
         cpc_id = c("01654"),
         wiki_id = c("Q3251025 | Q26325"),
         gbif_id = c("2684709"),
         use_typ = c("food"),
         used_part = c("fruit"),
         life_form = c("shrub"),
         initiation = c(NA_character_),
         persistence = c(NA_character_),
         harvests = c(NA_character_),
         yield = c(NA_character_),
         height = c("10"))
)

#### Medicinal crops ----
medicinal <- list(
  tibble(concept = c("basil", "ginseng", "guarana", "kava", "liquorice", "mint"),
         broader = class$concept[19],
         scientific_name = c("Ocimum basilicum", "Panax spp.", "Paulinia cupana", "Piper methysticum", "Glycyrrhiza glabra", "Mentha spp."),
         icc_id = c("9.03.01.02", "9.03.02.01", "9.03.02.04", "9.03.02.03", "9.03.01", "9.03.01.01"),
         cpc_id = c("01699", "01699", "01699", "01699", "01930", "01699 | 01930.01"),
         wiki_id = c("Q38859 | Q65522654", "Q182881 | Q20817212", "Q209089", "Q161067", "Q257106", "Q47859 | Q156037"),
         gbif_id = c(""),
         use_typ = c("food", "food", "food | recreation", "food", "food | medicinal", "food"),
         used_part = c("leaves", "root", "seeds", "root", "root", "leaves"),
         life_form = c("forb", "forb", "forb", "forb", "forb", "forb"),
         # persistence = c("temporary"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", "", "", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "", "")), # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
  tibble(concept = c("coca"),
         broader = class$concept[19],
         scientific_name = c("Erythroxypum novogranatense | Erythroxypum coca"),
         icc_id = c("9.03.02.02"),
         cpc_id = c("01699"),
         wiki_id = c("Q158018"),
         gbif_id = c(""),
         use_typ = c("recreation"),
         used_part = c("leaves"),
         life_form = c("tree"),
         # persistence = c("temporary"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c(""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c(""), # insert the number of harvests per year
         height = c("")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Sugar crops ----
sugar <- list(
  tibble(concept = c("stevia"),
         broader = class$concept[20],
         scientific_name = c("Stevia rebaudiana"),
         icc_id = c("8.9"),
         cpc_id = c("01809"),
         wiki_id = c("Q312246 | Q3644010"),
         gbif_id = c(""),
         use_typ = c("food"),
         used_part = c("leaves"),
         life_form = c("forb"),
         # persistence = c("temporary"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c(""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c(""), # insert the number of harvests per year
         height = c("")), # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
  tibble(concept = c("sugar beet"),
         broader = class$concept[20],
         scientific_name = c("Beta vulgaris var. altissima"),
         icc_id = c("8.01"),
         cpc_id = c("01801 | 01919.06"),
         wiki_id = c("Q151964"),
         gbif_id = c(""),
         use_typ = c("food | fodder"),
         used_part = c("root | leaves"),
         life_form = c("forb"),
         # persistence = c("temporary"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", "", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "")), # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
  tibble(concept = c("sugar cane", "sweet sorghum"),
         broader = class$concept[20],
         scientific_name = c("Saccharum officinarum", "Sorghum saccharatum"),
         icc_id = c("8.02", "8.03"),
         cpc_id = c("01802 | 01919.91", "01809"),
         wiki_id = c("Q36940 | Q3391243", "Q3123184"),
         gbif_id = c(""),
         use_typ = c("food | fodder", "food"),
         used_part = c("stalk | sap"),
         life_form = c("graminoid", "graminoid"),
         # persistence = c("temporary"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", ""), # insert the number of harvests per year
         height = c("", "")), # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
  tibble(concept = c("sugar maple"),
         broader = class$concept[20],
         scientific_name = c("Acer saccharum"),
         icc_id = c("8.9"),
         cpc_id = c("01809"),
         wiki_id = c("Q214733"),
         gbif_id = c(""),
         use_typ = c("food"),
         used_part = c("stalk | sap"),
         life_form = c("tree"),
         # persistence = c("temporary"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c(""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c(""), # insert the number of harvests per year
         height = c("")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Fruit-bearing vegetables ----
fruit_veg <- list(
  tibble(concept = c("cantaloupe", "chayote", "cucumber | gherkin", "eggplant", "gourd", "melon", "okra", "pumpkin", "squash", "sweet pepper", "tamarillo", "tomato", "watermelon"),
         broader = class$concept[21],
         scientific_name = c("Cucumis melo", "Sechium edule", "Cucumis sativus", "Solanum melongena", "Lagenaria spp | Cucurbita spp.", "Cucumis melo", "Abelmoschus esculentus | Hibiscus esculentus", "Cucurbita spp", "Cucurbita spp", "Capsicum annuum", "Solanum betaceum", "Lycopersicon esculentum", "Citrullus lanatus"),
         icc_id = c("2.05.02", "2.02.90", "2.02.01", "2.02.02", "2.02.04", "2.05.02", "2.02.05", "2.02.04", "2.02.04", "6.02.01.01", "2.02.90", "2.02.03", "2.05.01"),
         cpc_id = c("01229", "01239.90", "01232", "01233", "01235", "01229", "01239.01", "01235", "01235", "01231", "01239.90", "01234", "01221"),
         wiki_id = c("Q61858403 | Q477179", "Q319611", "Q2735883 | Q23425", "Q7540 | Q12533094", "Q7370671", "Q5881191 | Q81602", "Q80531 | Q12047207", "Q165308 | Q5339301", "Q5339237 | Q7533", "Q1548030", "Q379747", "Q20638126 | Q23501", "Q38645 | Q17507129"),
         gbif_id = c(""),
         use_typ = c("food", "food", "food", "food", "food", "food", "food", "food | fodder", "food | fodder", "food", "food", "food", "food"),
         used_part = c("fruit"),
         life_form = c("forb"),
         # persistence = c("temporary"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", "", "", "", "", "", "", "", "", "", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", "", "", "", "", "", "", "", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "", "", "", "", "", "", "", "", "")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Leaf or stem vegetables ----
leaf_veg <- list(
  tibble(concept = c("artichoke", "asparagus", "bok choy | pak choi", "broccoli", "brussels sprout", "cabbage", "cauliflower", "celery",
                     "chicory", "chinese cabbage", "collard", "endive", "gai lan", "kale", "lettuce", "rhubarb",
                     "savoy cabbage", "spinach"),
         broader = class$concept[22],
         scientific_name = c("Cynara scolymus", "Asparagus officinalis", "Brassica rapa subsp. chinensis", "Brassica oleracea var. botrytis", "Brassica oleracea var. gemmifera", "Brassica oleracea var. capitata", "Brassica oleracea var. botrytis", "Apium graveolens", "Cichorium intybus", "Brassica chinensis", "Brassica oleracea var. viridis", "Cichorium endivia", "Brassica oleracea var. alboglabra", "Brassica oleracea var. acephala", "Lactuca sativa var. capitata", "Rheum spp.", "Brassica oleracea var. capitata", "Spinacia oleracea"),
         icc_id = c("2.01.01", "2.01.02", "2.01.03", "2.01.04", "2.01.90", "2.01.03 | 01919.04", "2.01.04", "2.01.90", "2.01.07", "2.01.03", "2.01.03", "2.01.90", "2.01.03", "2.01.90", "2.01.05", "2.01.90", "2.01.03", "2.01.06"),
         cpc_id = c("01216", "01211", "01212", "01213", "01212", "01212", "01213", "01290", "01214", "01212", "01212", "01214", "01212", "01212", "01214", "01219", "01212", "01215"),
         wiki_id = c("Q23041430", "Q2853420 | Q23041045", "Q18968514", "Q47722 | Q57544960", "Q150463 | Q104664711", "Q14328596", "Q7537 | Q23900272", "Q28298", "Q2544599 | Q1474", "Q13360268 | Q104664724", "Q146212 | Q14879985", "Q178547 | Q28604477", "Q1677369 | Q104664699", "Q45989", "Q83193 | Q104666136", "Q20767168", "Q154013", "Q81464"),
         gbif_id = c(""),
         use_typ = c("food", "food", "fodder | food", "food", "fodder | food", "food | fodder", "food", "food", "food | recreation", "food", "food", "food", "food", "food | fodder", "food", "food", "food", "food"),
         used_part = c("flowers", "shoots", "leaves", "flowers", "flowers", "leaves", "flowers", "shoots", "leaves", "leaves", "leaves", "leaves", "leaves", "leaves", "leaves", "leaves", "leaves", "leaves"),
         life_form = c("forb"),
         # persistence = c("temporary"),
         initiation = c(""), # insert the number of years the crop needs to grow, before harvest
         persistence = c("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""), # insert the number of years after which this crop must be renewed
         harvests = c(""),
         yield = c("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""), # insert the number of harvests per year
         height = c("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Mushrooms and truffles ----
mushrooms <- list(
  tibble(concept = c("mushrooms"),
         broader = class$concept[23],
         icc_id = c("2.04"),
         cpc_id = c("01270"),
         scientific_name = c("Agaricus spp. | Pleurotus spp. | Volvariella"),
         wiki_id = c("Q654236"),
         gbif_id = c("2518646 | 2518610 | 2530192"),
         life_form = c("mushroom"),
         use_typ = c("food"),
         used_part = c("fruit body"),
         initiation = c("0"),
         persistence = c("1"),
         harvests = c(""),
         yield = c(""),
         height = c("0.5"))
)

#### Root vegetables ----
root_veg <- list(
  tibble(concept = c("carrot", "chive", "beet root | red beet", "chard", "garlic", "leek", "onion", "turnip", "mangelwurzel", "manioc | cassava | tapioca", "potato", "sweet potato", "taro | dasheen", "yam", "yautia"),
         broader = class$concept[24],
         scientific_name = c("Daucus carota subsp. sativus", "Allium schoenoprasum", "Beta vulgaris subsp. vulgaris conditiva group",
                             "Beta vulgaris subsp. vulgaris cicla group", "Allium sativum", "Allium ampeloprasum",
                             "Allium cepa", "Brassica rapa", "Beta vulgaris subsp. vulgaris crassa group", "Manihot esculenta",
                             "Solamum tuberosum", "Ipomoea batatas", "Colocasia esculenta", "Dioscorea spp.", "Xanthosoma sagittifolium"),
         icc_id = c("2.03.01", "2.03.05", "8.01", "8.01", "2.03.03", "2.03.05", "2.03.04", "2.03.02", "8.01", "5.03", "5.01", "5.02", "5.05", "5.04", "5.06"),
         cpc_id = c("01251 | 01919.07", "01254", "01801", "01801", "01252", "01254", "Q23485 | 01253", "01251 | 01919.05", "01801", "01520", "01510", "01530", "01550", "01540", "01591"),
         wiki_id = c("Q11678009 | Q81", "Q51148 | Q5766863", "Q165191 | Q99548274", "Q157954", "Q23400 | Q21546392",
                     "Q1807269 | Q148995", "Q23485 | Q3406628", "Q33690609 | Q3916957", "Q740726", "Q43304555 | Q83124",
                     "Q16587531 | Q10998", "Q37937", "Q227997", "Q8047551 | Q71549", "Q279280"),
         gbif_id = c("6550056", "2855860", "7068845", "7068845", "2856681", "2856037",
                     "2857697", "7225636", "7068845", "3060998", "2930262", "2928551", "5330776", "2754367", "5330901"),
         use_typ = c("food | fodder", "food", "food | fodder | medicinal", "food", "food", "food", "food", "food", "food | forage", "food | fodder", "food", "food", "food", "food", "food | fodder"),
         used_part = c("root", "leaves", "leaves", "leaves", "bulb", "leaves", "bulb", "root", "root", "tuber", "root", "tuber", "root", "tuber", "tuber"),
         life_form = c("forb"),
         initiation = c("0"),
         persistence = c("1", "5", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"),
         # duration = c("90-120", "90-365", "90-120", "90-365", "180-300", "180", "90-120", "55-60", "150-180", "180-545", "90-180", "60-270", "180-455", "210-365", "365"),
         harvests = c("1", "3-5", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"),
         yield = c("", "", "", "", "", "", "", "", "", "", "", "", "", "", ""),
         height = c("2", "0.5", "0.5", "1", "1", "1", "1", "0.5", "0.5", "5", "1", "0.5", "2", "20", "2")),
  tibble(concept = c("arracacha", "celeriac", "horseradish", "kohlrabi", "radish", "salsify", "scorzonera", "sunroot", "swede", "parsnip"),
         broader = class$concept[24],
         scientific_name = c("Arracacia xanthorrhiza", "Apium graveolens var. rapaceum", "Armoracia rusticana",
                             "Brassica oleracea var. gongylodes", "Raphanus sativus", "Tragopogon porrifolius", "Scorzonera hispanica",
                             "Helianthus tuberosus", "Brassica napus var. napobrassica", "Pastinaca sativa"),
         icc_id = c("5.9", "2.03.90", "2.03.90", "2.03.90", "2.03.90", "2.03.90", "2.03.90", "2.01.01", "2.03.90", "2.03.90"),
         cpc_id = c("01599", "01259", "01259", "01212", "01259", "01259", "01259", "01599", "01919.08", "01259"),
         wiki_id = c("Q625399", "Q575174", "Q26545", "Q147202", "", "", "", "", "", ""),
         gbif_id = c("3034509", "5539782", "3041022", "3042850", "", "", "", "", "", ""),
         use_type = c("food", "food", "food | medicinal", "food", "", "", "", "", "", ""),
         used_part = c("root", "root", "root", "shoots", "", "", "", "", "", ""),
         life_form = c("forb"),
         initiation = c("0"),
         persistence = c("1", "1", "1", "1", "", "", "", "", "", ""), # insert the number of years after which this crop must be renewed
         # duration = c("", "130", "220-365", "56-110", "", "", "", "", "", ""),
         harvests = c("1", "1", "1", "1", "1", "1", "1", "1", "1", "1"), # insert the number of harvests per year
         yield = c("", "", "", "", "", "", "", "", "", ""),
         height = c("1", "1", "2", "0.5", "", "", "", "", "", "")) # insert the height classes (the upper bound) here (0.5, 1, 2, 5, 10, 20, 30, ...)
)

#### Animals ----
animals <- list(
  tibble(concept = c("partridge", "pigeon", "quail", "chicken", "duck", "goose", "turkey"),
         broader = class$concept[25],
         scientific_name = c("Alectoris rufa", "Columba livia", "Coturnis spp.", "Gallus domesticus", "Anas platyrhynchos", "Anser anser | Anser albofrons | Anser arvensis", "Meleagris gallopavo"),
         icc_id = NA_character_,
         cpc_id = c("02194", "02194", "02194", "02151", "02154", "02153", "02152"),
         wiki_id = c("Q25237 | Q29472543", "Q2984138 | Q10856", "Q28358", "Q780", "Q3736439 | Q7556", "Q16529344", "Q848706 | Q43794"),
         gbif_id = c(""),
         use_typ = c("food", "labor | food", "food", "food", "food", "labor | food", "food"),
         used_part = c("time | eggs | meat")),
  tibble(concept = c("hare", "rabbit"),
         broader = class$concept[26],
         scientific_name = c("Lepus spp.", "Oryctolagus cuniculus"),
         icc_id = NA_character_,
         cpc_id = c("02191"),
         wiki_id = c("Q46076 | Q63941258", "Q9394"),
         gbif_id = c(""),
         use_typ = c("food"),
         used_part = c("meat")),
  tibble(concept = c("buffalo", "cattle"),
         broader = class$concept[28],
         scientific_name = c("Bubalus bubalus | Bubalus ami | Bubalus depressicornis | Bubalus nanus | Syncerus spp. | Bison spp.", "Bos bovis | Bos taurus | Bos indicus | Bos grunniens | Bos gaurus | Bos grontalis | Bos sondaicus"),
         icc_id = NA_character_,
         cpc_id = c("02112", "02111"),
         wiki_id = c("Q82728", "Q830 | Q4767951"),
         gbif_id = c(""),
         use_typ = c("labor | food"),
         used_part = c("time | milk | meat")),
  tibble(concept = c("goat", "sheep"),
         broader = class$concept[29],
         scientific_name = c("Capra hircus", "Ovis aries"),
         icc_id = NA_character_,
         cpc_id = c("02123", "02122"),
         wiki_id = c("Q2934", "Q7368" ),
         gbif_id = c(""),
         use_typ = c("labor | food"),
         used_part = c("time | milk | meat")),
  tibble(concept = c("alpaca", "camel", "guanaco", "llama", "vicugna"),
         broader = class$concept[30],
         scientific_name = c("Lama pacos", "Camelus bactrianus | Camelus dromedarius | Camelus ferus", "Lama guanicoe", "Lama glama", "Lama vicugna"),
         icc_id = NA_character_,
         cpc_id = c("02121.02", "02121.01", "02121.02", "02121.02", "02121.02"),
         wiki_id = c("Q81564", "Q7375", "Q172886 | Q1552716", "Q42569", "Q2703941 | Q167797"),
         gbif_id = c(""),
         use_typ = c("fibre", "labor", "labor", "fibre | labor", "fibre"),
         used_part = c("hair", "time", "time", "hair | time", "hair")),
  tibble(concept = c("ass", "horse", "mule"),
         broader = class$concept[31],
         scientific_name = c("Equus africanus asinus", "Equus ferus caballus", "Equus africanus asinus × Equus ferus caballus"),
         icc_id = NA_character_,
         cpc_id = c("02132", "02131", "02133"),
         wiki_id = c("Q19707", "Q726 | Q10758650", "Q83093"),
         gbif_id = c(""),
         use_typ = c("labor | food"),
         used_part = c("time | meat")),
  tibble(concept = c("pig"),
         broader = class$concept[32],
         scientific_name = "Sus domesticus | Sus scrofa",
         icc_id = NA_character_,
         cpc_id = c("02140"),
         wiki_id = c("Q787"),
         gbif_id = c(""),
         use_typ = c("food"),
         used_part = c("meat")),
  tibble(concept = c("beehive"),
         broader = class$concept[33],
         scientific_name = c("Apis mellifera | Apis dorsata | Apis florea | Apis indica"),
         icc_id = NA_character_,
         cpc_id = c("02196"),
         gbif_id = c(""),
         wiki_id = c("Q165107"),
         use_typ = c("labor | food"),
         used_part = c("honey"))
)

#### combine all ----
commodity <- bind_rows(bioenergy, fibre, flower, rubber, pasture, berries,
                       citrus, grapes, pome, stone, oleaginous, tropical,
                       cereals, legumes, nuts, oilseeds, stimulants, spice,
                       medicinal, sugar, fruit_veg, leaf_veg, mushrooms,
                       root_veg, animals)

luckiOnto <- new_concept(new = commodity$concept,
                         broader = get_concept(table = commodity %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)


# mappings to other ontologies/vocabularies or attributes ----
#
## CORINE Land Cover Classification
# luckiOnto <- new_source(name = "clc",
#                         date = dmy("10-05-2019"),
#                         description = "CORINE land cover nomenclature",
#                         homepage = "https://land.copernicus.eu/user-corner/technical-library/corine-land-cover-nomenclature-guidelines/html/",
#                         ontology = luckiOnto)
#
# luckiOnto <- new_mapping(new = lcGroup$clc,
#                          target = get_concept(table = lcGroup %>% select(label = concept), ontology = luckiOnto),
#                          source = "clc", match = "close", certainty = 3,
#                          ontology = luckiOnto)
#
# luckiOnto <- new_mapping(new = lc$clc,
#                          target = get_concept(table = lc %>% select(label = concept), ontology = luckiOnto),
#                          source = "clc", match = "close", certainty = 3,
#                          ontology = luckiOnto)

## ESA CCI Land-Cover
# luckiOnto <- new_source(name = "esalc",
#                         version = "2.1.1",
#                         description = "The CCI-LC project delivers consistent global LC maps at 300 m spatial resolution on an annual basis from 1992 to 2020 The Coordinate Reference System used for the global land cover database is a geographic coordinate system (GCS) based on the World Geodetic System 84 (WGS84) reference ellipsoid.",
#                         homepage = "https://maps.elie.ucl.ac.be/CCI/viewer/index.php",
#                         ontology = luckiOnto)
#
# luckiOnto <- new_mapping(new = lu$esa_lc,
#                          target = get_concept(table = lu %>% select(label = concept), ontology = luckiOnto),
#                          source = "esalc", match = "close", certainty = 3,
#                          ontology = luckiOnto)

## FAO Forest Resource Assessment
# luckiOnto <- new_source(name = "fra",
#                         date = dmy("10-05-2019"),
#                         description = "FAO has been monitoring the world’s forests at 5 to 10 year intervals since 1946. The Global Forest Resources Assessments (FRA) are now produced every five years in an attempt to provide a consistent approach to describing the world’s forests and how they are changing.",
#                         homepage = "https://fra-data.fao.org/",
#                         ontology = luckiOnto)
#
# luckiOnto <- new_mapping(new = lu$fra,
#                          target = get_concept(table = lu %>% select(label = concept), ontology = luckiOnto),
#                          source = "fra", match = "close", certainty = 3,
#                          ontology = luckiOnto)

## FAO Land-Use Classification
# luckiOnto <- new_source(name = "faoLu",
#                         date = dmy("10-05-2019"),
#                         description = "The FAOSTAT Land Use domain contains data on forty-four categories of land use, irrigation and agricultural practices, relevant to monitor agriculture, forestry and fisheries activities at national, regional and global level.",
#                         homepage = "https://www.fao.org/faostat/en/#data/RL",
#                         ontology = luckiOnto)
#
# luckiOnto <- new_mapping(new = lc$fao_lu,
#                          target = get_concept(table = lc %>% select(label = concept), ontology = luckiOnto),
#                          source = "faoLu", match = "close", certainty = 3,
#                          ontology = luckiOnto)
#
# luckiOnto <- new_mapping(new = lu$fao_lu,
#                          target = get_concept(table = lu %>% select(label = concept), ontology = luckiOnto),
#                          source = "faoLu", match = "close", certainty = 3,
#                          ontology = luckiOnto)

## FAO Indicative Crop Classification (ICC) version 1.1
luckiOnto <- new_source(name = "icc",
                        date = Sys.Date(),
                        version = "1.1",
                        description = "The official version of the Indicative Crop Classification was developed for the 2020 round of agricultural censuses.",
                        homepage = "https://stats.fao.org/caliper/browse/skosmos/ICC11/en/",
                        uri_prefix = "https://stats.fao.org/classifications/ICC/v1.1/",
                        license = "",
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$icc_id,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "icc", match = "close", certainty = 3,
                         ontology = luckiOnto)

## FAO Central Product Classification (CPC) version 2.1
luckiOnto <- new_source(name = "cpc",
                        date = Sys.Date(),
                        version = "2.1",
                        description = "The Central Product Classification (CPC) v2.1",
                        homepage = "https://stats.fao.org/caliper/browse/skosmos/cpc21/en/",
                        uri_prefix = "http://stats-class.fao.uniroma2.it/CPC/v2.1/ag/",
                        license = "",
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$cpc_id,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "cpc", match = "close", certainty = 3,
                         ontology = luckiOnto)

## Scientific botanical/zoological name
luckiOnto <- new_source(name = "species",
                        date = Sys.Date(),
                        description = "This contains scientific pland and animal names as suggested in the ICC 1.1",
                        homepage = "",
                        license = "",
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$scientific_name,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "species", match = "close", certainty = 3,
                         ontology = luckiOnto)

## wikidata ----
luckiOnto <- new_source(name = "wiki",
                        date = Sys.Date(),
                        description = "Wikidata is a free, collaborative, multilingual, secondary database, collecting structured data to provide support for Wikipedia, Wikimedia Commons, the other wikis of the Wikimedia movement, and to anyone in the world.",
                        homepage = "https://www.wikidata.org/",
                        uri_prefix = "https://www.wikidata.org/wiki/",
                        license = "CC0",
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$wiki_id,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "wiki", match = "close", certainty = 3,
                         ontology = luckiOnto)

## gbif ----
luckiOnto <- new_source(name = "gbif",
                        date = Sys.Date(),
                        description = "GBIF—the Global Biodiversity Information Facility—is an international network and data infrastructure funded by the world's governments and aimed at providing anyone, anywhere, open access to data about all types of life on Earth.",
                        homepage = "https://www.gbif.org/",
                        uri_prefix = "https://www.gbif.org/species/",
                        license = "",
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$gbif_id,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "gbif", match = "close", certainty = 3,
                         ontology = luckiOnto)

## initiation ----
luckiOnto <- new_source(name = "initiation",
                        date = Sys.Date(),
                        description = "the number of years a plant needs to grow before it can be harvested the first time",
                        homepage = "",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$initiation,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "initiation", match = "narrow", certainty = 3,
                         ontology = luckiOnto)

## persistence ----
luckiOnto <- new_source(name = "persistence",
                        date = Sys.Date(),
                        description = "the number of years after which a plant is renewed either because it has been fully harvested or because it shall be replaced",
                        homepage = "",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

lut_persistence <- tibble(label = ,
                          description = c("plants that exist for ",
                                          "plants that exist for "))

luckiOnto <- new_mapping(new = commodity$persistence,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "persistence", match = "narrow", certainty = 3,
                         lut = lut_persistence,
                         ontology = luckiOnto)

## duration ----
luckiOnto <- new_source(name = "duration",
                        date = Sys.Date(),
                        description = "the number of days a plants needs to grow from planting to harvest.",
                        homepage = "",
                        license = "",
                        ontology = luckiOnto)

lut_duration <- tibble(label = ,
                    description = c("plants that exist for ",
                                    "plants that exist for "))

luckiOnto <- new_mapping(new = commodity$duration,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "duration", match = "narrow", certainty = 3,
                         lut = lut_duration,
                         ontology = luckiOnto)

## harvests ----
luckiOnto <- new_source(name = "harvests",
                        date = Sys.Date(),
                        description = "the number of days a plants needs to grow from planting to harvest.",
                        homepage = "",
                        license = "",
                        ontology = luckiOnto)

lut_harvests <- tibble(label = c("1", "2", "3", "4"),
                    description = c("plants that are harvested once per year",
                                    "plants that are harvested twice per year",
                                    "plants that are harvested three times per year",
                                    "plants that are harvested four times per year"))

luckiOnto <- new_mapping(new = commodity$cycle,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "cycle", match = "narrow", certainty = 3,
                         lut = lut_harvests,
                         ontology = luckiOnto)

## yield ----
luckiOnto <- new_source(name = "yield",
                        date = Sys.Date(),
                        description = "the typical dry-weight yield a crop produces, in tonnes/ha/harvest.",
                        homepage = "",
                        license = "",
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$yield,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "yield", match = "narrow", certainty = 3,
                         ontology = luckiOnto)

## height ----
luckiOnto <- new_source(name = "height",
                        date = Sys.Date(),
                        description = "the height classes of plants (the upper bound)",
                        homepage = "",
                        license = "",
                        ontology = luckiOnto)

lut_height <- tibble(label = c("0.5", "1", "2", "5", "10", "20", "30", "xx"),
                     description = c("plants that are between 0 and 0.5 m heigh",
                                     "plants that are between 0.5 and 1 m heigh",
                                     "plants that are between 1 and 2 m heigh",
                                     "plants that are between 2 and 5 m heigh",
                                     "plants that are between 5 and 10 m heigh",
                                     "plants that are between 10 and 20 m heigh",
                                     "plants that are between 20 and 30 m heigh",
                                     "plants that are higher than 30 m"))

luckiOnto <- new_mapping(new = commodity$height,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "height", match = "close", certainty = 3,
                         lut = lut_height,
                         ontology = luckiOnto)

## life-form ----
luckiOnto <- new_source(name = "life-form",
                        date = Sys.Date(),
                        description = "a collection of standard terms of plant life-forms",
                        homepage = "",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

lut_lifeForm <- tibble(label = c("graminoid", "tree", "shrub", "forb"),
                       description = c("plants that are graminoids",
                                       "plants that are trees",
                                       "plants that are shrubs",
                                       "plants that are forbs"))

luckiOnto <- new_mapping(new = commodity$life_form,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "life-form", match = "close", certainty = 3,
                         lut = lut_lifeForm,
                         ontology = luckiOnto)

## use-type ----
luckiOnto <- new_source(name = "use-type",
                        date = Sys.Date(),
                        description = "a collection of standard terms of use-types of crops or livestock, derived from the FAO Central Product Classification (CPC) version 2.1",
                        homepage = "",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

lut_useType <- tibble(label = c("energy", "fibre", "food", "wood", "forage",
                                "silage", "fodder", "industrial", "recreation",
                                "medicinal", "labor"),
                      description = c("plants that are used for energy production",
                                      "plants/animals that are used for fibre production",
                                      "plants/animals that are used for produced for human food consumption",
                                      "plants that are used for wood production",
                                      "plants that are left in the field where animals are sent to forage on the crop",
                                      "plants that are used to produce silage",
                                      "plants that are harvested and brought to animals, for more controlled feeding of animals",
                                      "plants that were historically labeled industrial crops",
                                      "plants with a stimulating effect that can be used for recreational purposes",
                                      "plants that are grown for their medicinal effect",
                                      "animals that are used for labor"))

luckiOnto <- new_mapping(new = commodity$use_typ,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "use-type", match = "close", certainty = 3,
                         lut = lut_useType,
                         ontology = luckiOnto)

## use-part ----
luckiOnto <- new_source(name = "use-part",
                        date = Sys.Date(),
                        description = "a collection of standard terms of use-types of crops or livestock, derived from the FAO Central Product Classification (CPC) version 2.1",
                        homepage = "",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

lut_usedPart <- tibble(label = ,
                       description = c(""))

luckiOnto <- new_mapping(new = commodity$used_part,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "use-part", match = "close", certainty = 3,
                         lut = lut_usedPart,
                         ontology = luckiOnto)


# write output ----
#
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))
export_as_rdf(ontology = luckiOnto, filename = paste0(dataDir, "tables/luckiOnto.ttl"))
