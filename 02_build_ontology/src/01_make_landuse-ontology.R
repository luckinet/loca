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
  new_class(new = "land-cover group", target = "domain",
            description = "groups of land-cover concepts", ontology = .) %>%
  new_class(new = "land cover", target = "land-cover group",
            description = "concepts that describe the general type of the land surface cover", ontology = .) %>%
  new_class(new = "land use", target = "land cover",
            description = "concepts that describe the socio-economic dimension (how land is used) of the land surface cover", ontology = .) %>%
  new_class(new = "group", target = "domain",
            description = "broad groups of concepts that describe crops and livestock", ontology = .) %>%
  new_class(new = "class", target = "group",
            description = "mutually exclusive types of concepts that describe crops and livestock", ontology = .) %>%
  new_class(new = "commodity", target = "class",
            description = "concepts that describe crops or livestock",  ontology = .)

# define the harmonized concepts ----
domain <- tibble(concept = c("surface types", "production systems"),
                 description = c("land-cover and land-use concepts describing the surface of the earth",
                                 "production systems described by the crops or livestock grown there"))

luckiOnto <- new_concept(new = domain$concept,
                         description = domain$description,
                         class = "domain",
                         ontology =  luckiOnto)

## surface types ----
message("     land surface types")

### landcover groups ----
lcGroup <- tibble(concept = c("ARTIFICIAL AREAS", "AGRICULTURAL AREAS", "FOREST AND SEMI-NATURAL AREAS", "WETLANDS", "WATER BODIES"),
                  description = c(NA_character_,
                                  NA_character_,
                                  NA_character_,
                                  NA_character_,
                                  NA_character_),
                  broader = "surface types")

luckiOnto <- new_concept(new = lcGroup$concept,
                         broader = get_concept(table = lcGroup %>% select(label = broader), ontology = luckiOnto),
                         description = lcGroup$description,
                         class = "land-cover group",
                         ontology =  luckiOnto)

### land cover ----
lc <- list(
  tibble(concept = c("Urban fabric", "Industrial, commercial and transport units", "Mine, dump and construction sites", "Artificial, non-agricultural vegetated areas"),
         description = c("Areas mainly occupied by dwellings and buildings used by administrative/public utilities, including their connected areas (associated lands, approach road network, parking lots)",
                         "Areas mainly occupied by industrial activities of manufacturing, trade, financial activities and services, transport infrastructures for road traffic and rail networks, airport installations, river and sea port installations, including their associated lands and access infrastructures. Includes industrial livestock rearing facilities",
                         "Artificial areas mainly occupied by extractive activities, construction sites, man-made waste dump sites and their associated lands",
                         "Areas voluntarily created for recreational use. Includes green or recreational and leisure urban parks, sport and leisure facilities"),
         broader = lcGroup$concept[1]),
  tibble(concept = c("Temporary cropland", "Pastures", "Permanent cropland", "Heterogeneous agricultural land"),
         description = c("Lands under a rotation system used for annually harvested plants and fallow lands, which are rain-fed or irrigated. Includes flooded crops such as rice fields and other inundated croplands",
                         "Lands that are permanently used (at least 5 years) for fodder production. Includes natural or sown herbaceous species, unimproved or lightly improved meadows and grazed or mechanically harvested meadows. Regular agriculture impact influences the natural development of natural herbaceous species composition",
                         "All surfaces occupied by permanent crops, not under a rotation system. Includes ligneous crops of standards cultures for fruit production such as extensive fruit orchards, olive groves, chestnut groves, walnut groves shrub orchards such as vineyards and some specific low-system orchard plantation, espaliers and climbers",
                         "Areas of annual crops associated with permanent crops on the same parcel, annual crops cultivated under forest trees, areas of annual crops, meadows and/or permanent crops which are juxtaposed, landscapes in which crops and pastures are intimately mixed with natural vegetation or natural areas"),
         broader = lcGroup$concept[2]),
  tibble(concept = c("Forests", "Other Wooded Areas", "Shrubland", "Herbaceous associations", "Heterogeneous semi-natural areas", "Open spaces witih little or no vegetation"),
         description = c("Areas occupied by forests and woodlands with a vegetation pattern composed of native or exotic coniferous and/or broad-leaved trees and which can be used for the production of timber or other forest products. The forest trees are under normal climatic conditions higher than 5 m with a canopy closure of 30 % at least. In case of young plantation, the minimum cut-off-point is 500 subjects by ha",
                         NA_character_,
                         "Bushy sclerophyllous vegetation in a climax stage of development, including maquis, matorral and garrigue",
                         "Grasslands under no or moderate human influence. Low productivity grasslands. Often situated in areas of rough, uneven ground, steep slopes; frequently including rocky areas or patches of other (semi-)natural vegetation.",
                         "Bushes, shrubs, dwarf shrubs and herbaceous plants with occasional scattered trees on the same parcel. The vegetation is low with closed cover and under no or moderate human influence. Can represent woodland degradation, forest regeneration / recolonization, natural succession or moors and heathland.",
                         "Natural areas covered with little or no vegetation, including open thermophile formations of sandy or rocky grounds distributed on calcareous or siliceous soils frequently disturbed by erosion, steppic grasslands, perennial steppe-like grasslands, meso- and thermo-Mediterranean xerophile, mostly open, short-grass perennial grasslands, alpha steppes, vegetated or sparsely vegetated areas of stones on steep slopes, screes, cliffs, rock fares, limestone pavements with plant communities colonising their tracks, perpetual snow and ice, inland sand-dune, coastal sand-dunes and burnt natural woody vegetation areas"),
         broader = lcGroup$concept[3]),
  tibble(concept = c("Inland wetlands", "Marine wetlands"),
         description = c("Areas flooded or liable to flooding during the great part of the year by fresh, brackish or standing water with specific vegetation coverage made of low shrub, semi-ligneous or herbaceous species. Includes water-fringe vegetation of lakes, rivers, and brooks and of fens and eutrophic marshes, vegetation of transition mires and quaking bogs and springs, highly oligotrophic and strongly acidic communities composed mainly of sphagnum growing on peat and deriving moistures of raised bogs and blanket bogs",
                         "Areas which are submerged by high tides at some stage of the annual tidal cycle. Includes salt meadows, facies of saltmarsh grass meadows, transitional or not to other communities, vegetation occupying zones of varying salinity and humidity, sands and muds submerged for part of every tide devoid of vascular plants, active or recently abandoned salt-extraction evaporation basins"),
         broader = lcGroup$concept[4]),
  tibble(concept = c("Inland waters", "Marine waters"),
         description = c("Lakes, ponds and pools of natural origin containing fresh (i.e non-saline) water and running waters made of all rivers and streams. Man-made fresh water bodies including reservoirs and canals",
                         "Oceanic and continental shelf waters, bays and narrow channels including sea lochs or loughs, fiords or fjords, rya straits and estuaries. Saline or brackish coastal waters often formed from sea inlets by sitting and cut-off from the sea by sand or mud banks"),
         broader = lcGroup$concept[5])) %>%
  bind_rows()

luckiOnto <- new_concept(new = lc$concept,
                         broader = get_concept(table = lc %>% select(label = broader), ontology = luckiOnto),
                         description = lc$description,
                         class = "land cover",
                         ontology =  luckiOnto)

### land use ----
lu <- list(
  tibble(concept = c("Fallow", "Herbaceous crops", "Temporary grazing"),
         description = c(NA_character_,
                         NA_character_,
                         NA_character_),
         broader = lc$concept[5]),
  tibble(concept = c("Shrub orchards", "Palm plantations", "Tree orchards", "Woody plantation", "Protective cover"),
         description = c(NA_character_,
                         NA_character_,
                         NA_character_,
                         NA_character_,
                         NA_character_),
         broader = lc$concept[7]),
  tibble(concept = c("Permanent grazing"),
         description = c(NA_character_),
         broader = lc$concept[6]),
  tibble(concept = c("Agroforestry", "Mosaic of agricultural uses", "Mosaic of agriculture and natural vegetation"),
         description = c(NA_character_,
                         NA_character_,
                         NA_character_),
         broader = lc$concept[8]),
  tibble(concept = c("Undisturbed Forest", "Naturally Regenerating Forest", "Planted Forest", "Temporally Unstocked Forest"),
         description = c(NA_character_,
                         NA_character_,
                         NA_character_,
                         NA_character_),
         broader = lc$concept[9])) %>%
  bind_rows()

luckiOnto <- new_concept(new = lu$concept,
                         broader = get_concept(table = lu %>% select(label = broader), ontology = luckiOnto),
                         description = lu$description,
                         class = "land use",
                         ontology =  luckiOnto)

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
  tibble(concept = c("Leave sugar crops", "Root sugar crops", "Sap sugar crops"),
         description = c("This class covers plants that are grown to produce sugar from their leaves",
                         "This class covers plants that are grown to produce sugar from their roots",
                         "This class covers plants that are grown to produce sugar from their sap"),
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
commodity <- list(
  tibble(concept = c("bamboo", "giant reed", "miscanthus", "reed canary grass", "switchgrass"),
         broader = class$concept[1],
         scientific_name = c("Bambusa spp.", "Arundo donax", "Miscanthus × giganteus", "Phalaris arundinacea", "Panicum virgatum"),
         icc_11 = c(NA_character_, NA_character_, NA_character_, NA_character_, NA_character_),
         cpc_21 = c(NA_character_, NA_character_, NA_character_, NA_character_, NA_character_),
         wiki_id = c("Q2157176", "Q161114", "Q41692", "Q157419", "Q1466543"),
         life_form = c("graminoid"),
         use_typ = c("bioenergy", "bioenergy", "bioenergy", "bioenergy", "bioenergy"),
         used_part = c("biomass"),
         persistence = c("temporary")),
  tibble(concept = c("acacia", "black locust", "eucalyptus", "poplar", "willow"),
         broader = class$concept[1],
         scientific_name = c("Acacia spp.", "Robinia pseudoacacia", "Eucalyptus spp.", "Populus spp.", "Salix spp."),
         icc_11 = c(NA_character_, NA_character_, NA_character_, NA_character_, NA_character_),
         cpc_21 = c(NA_character_, NA_character_, NA_character_, NA_character_, NA_character_),
         wiki_id = c("Q81666", "Q2019723", "Q45669", "Q25356", "Q36050"),
         life_form = c("tree"),
         use_typ = c("bioenergy"),
         used_part = c("biomass"),
         persistence = c("permanent")),
  tibble(concept = c("jute", "kenaf", "ramie"),
         broader = class$concept[2],
         scientific_name = c("Corchorus spp.", "Hibiscus cannabinus", "Boehmeria nivea"),
         icc_11 = c("9.02.01.02", "9.02.01.02", "9.02.02.01"),
         cpc_21 = c("01922.01", "01922.02", "01929.04"),
         wiki_id = c("Q107211", "Q1137540", "Q2130134 | Q750467"),
         life_form = c("forb"),
         use_typ = c("fibre", "fibre", "fibre"),
         used_part = c("bast"),
         persistence = c("temporary")),
  tibble(concept = c("abaca | manila hemp", "sisal"),
         # Citronella Cymbopogon citrates/ Cymbopogon nardus 992 9.90.02 35410.01
         # Henequen Agave fourcroydes 922 9.02.02 01929
         # Lemon grass Cymbopogon citratus 922 9.02.02 35410
         # Maguey Agave atrovirens 922 9.02.02 01929
         # New Zealand flax (formio) Phormium tenax 922 9.02.01.04 01929
         # Formio (New Zealand flax) Phormium tenax 9214 9.02.01.04 01929
         # Rhea Boehmeria nivea 922 9.02.02 26190
         # Fique Furcraea macrophylla 9219 9.02.01.90 01929
         broader = class$concept[2],
         scientific_name = c("Musa textilis", "Agave sisalana"),
         icc_11 = c("9.02.02.90", "9.02.02.02"),
         cpc_21 = c("01929.07", "01929.05"),
         wiki_id = c("Q203540", "Q159221 | Q847423"),
         life_form = "tree",
         use_typ = c("fibre", "fibre"),
         used_part = c("leaves"),
         persistence = c("permanent")),
  tibble(concept = c("kapok"),
         broader = class$concept[2],
         scientific_name = c("Ceiba pentandra"),
         icc_11 = c("9.02.02.90"),
         cpc_21 = c("01929.03 | 01499.05"),
         wiki_id = c("Q1728687"),
         life_form = c("tree"),
         use_typ = c("fibre | food"),
         used_part = c("seed"),
         persistence = c("permanent")),
  tibble(concept = c("natural rubber"),
         broader = class$concept[4],
         icc_11 = c("9.04"),
         cpc_21 = c("01950"),
         scientific_name = c("Hevea brasiliensis"),
         wiki_id = c("Q131877"),
         life_form = c("tree"),
         use_typ = c("industrial"),
         used_part = c("resin"),
         persistence = c("permanent")),
  tibble(concept = c("alfalfa", "orchard grass", "redtop", "ryegrass", "sudan grass", "timothy", "trefoil"),
         broader = class$concept[5],
         icc_11 = c("9.01.01", "9.01.01", "9.90.01", "9.90.01", "9.01.01", "9.01.01", "9.90.01"),
         cpc_21 = c("01912 | 01940", "01919.91", "01919.91", "01919.02", "01919", "01919.91", "01919.92"),
         scientific_name = c("Medicago sativa", "Dactylis glomerata", "Agrostis spp.", "Lolium spp.", "Sorghum × drummondii", "Phleum pratense", "Lotus spp."),
         wiki_id = c("Q156106", "Q161735", "Q27835", "Q158509", "Q332062", "Q256508", "Q101538"),
         life_form = c("graminoid"),
         use_typ = c("food | fodder | forage", "fodder | forage", "forage", "forage", "fodder | bioenergy", "fodder", "forage"),
         used_part = c("biomass"),
         persistence = c("temporary")),
  tibble(concept = c("clover", "lupin"),
         broader = class$concept[5],
         icc_11 = c("9.01.01", "7.06"),
         cpc_21 = c("01919.03", "01709.02"),
         scientific_name = c("Trifolium spp.", "Lupinus spp."),
         wiki_id = c("Q101538", "Q156811"),
         life_form = c("forb", "forb"),
         use_typ = c("fodder | forage", "fodder | forage | food"),
         used_part = "biomass",
         persistence = c("temporary")),
  tibble(concept = c("blueberry", "cranberry", "currant", "gooseberry", "kiwi fruit", "raspberry", "strawberry"),
         broader = class$concept[6],
         icc_11 = c("3.04.06", "3.04.07", "3.04.01", "3.04.02", "3.04.03", "3.04.04", "3.04.05"),
         cpc_21 = c("01355.01", "01355.02", "01351.01", "01351.02", "01352", "01353.01", "01354"),
         scientific_name = c("Vaccinium myrtillus | Vaccinium corymbosum", "Vaccinium macrocarpon | Vaccinium oxycoccus", "Ribes spp.", "Ribes spp.", "Actinidia deliciosa", "Rubus spp.", "Fragaria spp."),
         wiki_id = c("Q13178", "Q374399 | Q13181 | Q21546387", "Q3241599", "Q41503 | Q17638951", "Q13194", "Q12252383 | Q13179", "Q745 | Q13158"),
         life_form = c("shrub"),
         use_typ = c("food"),
         used_part = c("fruit"),
         persistence = c("temporary")),
  tibble(concept = c("bergamot", "clementine", "grapefruit", "lemon", "lime", "mandarine", "orange", "pomelo", "satsuma", "tangerine"),
         broader = class$concept[7],
         icc_11 = c("3.02.90", "3.02.04", "3.02.01", "3.02.02", "3.02.02", "3.02.04", "3.02.03", "3.02.01", "3.02.04", "3.02.04"),
         cpc_21 = c("01329", "01324.02", "01321", "01322", "01322", "01324.02", "01323", "01321", "01324", "01324.01"),
         scientific_name = c("Citrus bergamia", "Citrus reticulata", "Citrus paradisi", "Citrus limon", "Citrus limetta | Citrus aurantifolia", "Citrus reticulata", "Citrus sinensis | Citrus aurantium", "Citrus grandis", "Citrus reticulata", "Citrus reticulata"),
         wiki_id = c("Q109196", "Q460517", "Q21552830", "Q500 | Q1093742", "Q13195", "Q125337", "Q12330939 | Q34887", "Q353817 | Q80024", "Q875262", "Q516494"),
         life_form = c("tree"),
         use_typ = c("food"),
         used_part = c("fruit"),
         persistence = c("permanent")),
  tibble(concept = c("grape"),
         broader = class$concept[8],
         icc_11 = c("3.03"),
         cpc_21 = c("01330"),
         scientific_name = c("Vitis vinifera"),
         wiki_id = c("Q10978 | Q191019"),
         life_form = c("shrub"),
         use_typ = c("food"),
         used_part = c("fruit"),
         persistence = c("permanent")),
  tibble(concept = c("apple", "loquat", "medlar", "pear", "quince"),
         broader = class$concept[9],
         scientific_name = c("Malus sylvestris", "Eriobotrya japonica", "Mespilus germanica", "Pyrus communis", "Cydonia oblonga"),
         icc_11 = c("2.05.01", "3.05.90", "3.05.90", "3.05.05", "3.05.05"),
         cpc_21 = c("01341", "01359", "01359", "01342.01", "01342.02"),
         wiki_id = c("Q89 | Q15731356", "Q41505", "Q146186 | Q3092517", "Q434 | Q13099586", "Q2751465 | Q43300"),
         life_form = c("tree"),
         use_typ = c("food"),
         used_part = c("fruit"),
         persistence = c("permanent")),
  tibble(concept = c("apricot", "cherry", "nectarine", "peach", "plum", "sloe", "sour cherry"),
         broader = class$concept[10],
         icc_11 = c("3.05.02", "3.05.03", "3.05.04", "3.05.04", "3.05.06", "3.05.06", "3.05.03"),
         cpc_21 = c("01343", "01344.02", "01345", "01345", "01346", "01346", "01344.01"),
         scientific_name = c("Prunus armeniaca", "Prunus avium", "Prunus persica var. nectarina", "Prunus persica", "Prunus domestica", "Prunus spinosa", "Prunus cerasus"),
         wiki_id = c("Q37453 | Q3733836", "Q196", "Q2724976 | Q83165", "Q37383", "Q6401215 | Q13223298", "Q12059685 | Q129018", "Q68438267 | Q131517"),
         life_form = c("tree"),
         use_typ = c("food"),
         used_part = c("fruit"),
         persistence = c("permanent")),
  tibble(concept = c("coconut", "oil palm", "olive"),
         broader = class$concept[11],
         icc_11 = c("4.04.01 | 9.02.02.90", "4.04.03", "4.04.02"),
         cpc_21 = c("01460 | 01929.08", "01491", "01450"),
         scientific_name = c("Cocos nucifera", "Elaeis guineensis", "Olea europaea"),
         wiki_id = c("Q3342808", "Q165403", "Q37083 | Q1621080"),
         life_form = c("tree"),
         use_typ = c("food | fibre", "food", "food"),
         used_part = c("seed | husk", "seed", "fruit"),
         persistence = c("permanent")),
  tibble(concept = c("açaí", "avocado", "banana", "date", "fig", "guava", "mango", "mangosteen", "papaya", "persimmon", "pineapple",
                     "plantain"),
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
         icc_11 = c("3.01.9", "3.01.01", "3.01.02", "3.01.04", "3.01.05", "3.01.06", "3.01.06", "3.01.06", "3.01.07", "3.01.90", "3.01.08",
                    "3.01.03"),
         cpc_21 = c("01319", "01311", "01312", "01314", "01315", "01316.02", "01316.01", "01316.03", "01317", "01359.01", "01318", "01313"),
         scientific_name = c("Euterpe oleracea", "Persea americana", "Musa sapientum | Musa cavendishii | Musa nana", "Phoenix dactylifera",
                             "Ficus carica", "Psidium guajava", "Mangifera indica", "Garcinia mangostana", "Carica papaya",
                             "Diospyros kaki | Diospyros virginiana", "Ananas comosus", "Musa paradisiaca"),
         wiki_id = c("Q33943 | Q12300487", "Q961769 | Q37153", "Q503", "Q1652093", "Q36146 | Q2746643", "Q166843 | Q3181909", "Q169",
                     "Q170662 | Q104030000", "Q732775", "Q158482 | Q29526", "Q1493 | Q10817602", "Q165449"),
         life_form = c("tree", "tree", "tree", "tree", "shrub", "tree", "tree", "tree", "tree", "tree", "shrub", "tree"),
         use_typ = c("food", "food", "fibre | food", "food", "food", "food", "food", "food", "food", "food", "food", "food"),
         used_part = c("fruit"),
         persistence = c("permanent")),
  tibble(concept = c("barley", "maize", "millet", "oat", "triticale", "buckwheat", "canary seed", "fonio", "quinoa", "rice", "rye", "sorghum", "teff", "wheat", "mixed cereals"),
         broader = class$concept[13],
         icc_11 = c("1.05", "1.02", "1.08", "1.07", "1.09", "1.1", "1.13", "1.11", "1.12", "1.03", "1.06", "1.04", "1.9", "1.01", "1.14"),
         cpc_21 = c("0115", "01121 | 01911", "0118", "0117", "01191", "01192", "01195", "01193", "01194", "0113", "0116", "0114 | 01919.01", "01199.01", "0111", "01199.02"),
         scientific_name = c("Hordeum vulgare", "Zea mays", "Pennisetum americanum | Eleusine coracana | Setaria italica | Echinochloa esculenta | Panicum miliaceum", "Avena spp.", "Triticosecale", "Fagopyrum esculentum", "Phalaris canariensis", "Digitaria exilis | Digitaria iburua", "Chenopodium quinoa", "Oryza sativa | Oryza glaberrima", "Secale cereale", "Sorghum bicolor", "Eragrostis abyssinica", "Triticum aestivum | Triticum spelta | Triticum durum", NA_character_),
         wiki_id = c("Q11577", "Q11575 | Q25618328", "Q259438", "Q165403 | Q4064203", "Q380329", "Q132734 | Q4536337", "Q2086586", "Q1340738 | Q12439809", "Q104030862 | Q139925", "Q5090", "Q5090 | Q161426", "Q12099", "Q843942 | Q103205493", "Q105549747 | Q12111", "Q15645384 | Q161098 | Q618324"),
         life_form = c("graminoid"),
         use_typ = c("forage | food", "food | silage", "food", "food | fodder", "food", "food", "food", "food", "food", "food", "food", "food | fodder", "food", "food", "food"),
         used_part = c("seed"),
         persistence = c("temporary")),
  tibble(concept = c("bambara bean", "common bean", "broad bean", "carob", "chickpea", "cow pea", "lentil", "pea", "pigeon pea", "vetch"),
         # broader = class$concept[14],
         icc_11 = c("7.09", "7.01", "7.02", "3.9", "7.03", "7.04", "7.05", "7.07", "7.08", "7.1"),
         cpc_21 = c("01708", "01701", "01702", "01356", "01703", "01706", "01704", "01705", "01707", "01709.01"),
         scientific_name = c("Vigna subterranea", "Phaseolus vulgaris", "Vicia faba", "Ceratonia siliqua", "Cicer arietinum", "Vigna unguiculata", "Lens culinaris", "Pisum sativum", "Cajanus cajan", "Vicia sativa"),
         wiki_id = c("Q107357073", "Q42339 | Q2987371", "Q131342 | Q61672189", "Q8195444 | Q68763", "Q81375 | Q21156930", "Q107414065", "Q61505177 | Q131226", "Q13189 | Q13202263", "Q632559 | Q103449274", "Q157071"),
         life_form = c("forb"),
         use_typ = c("food", "food", "food", "food", "food", "food", "food", "food", "food", "food | fodder"),
         used_part = c("seed"),
         persistence = c("temporary", "temporary", "temporary", "permanent", "temporary", "temporary", "temporary", "temporary", "temporary", "temporary")),
  tibble(concept = c("almond", "areca nut", "brazil nut", "cashew", "chestnut", "hazelnut | filbert", "kolanut", "macadamia", "pecan", "pistachio", "walnut"),
         broader = class$concept[15],
         icc_11 = c("3.06.01", "3.06.08", "3.06.07", "3.06.02", "3.06.03", "3.06.04", "3.06.09", "3.06.90", "3.06.90", "3.06.05", "3.06.06"),
         cpc_21 = c("01371", "01379.01", "01377", "01372", "01373", "01374", "01379.02", "01379", "01379", "01375", "01376"),
         scientific_name = c("Prunus dulcis", "Areca catechu", "Bertholletia excelsa", "Anacardium occidentale", "Castanea sativa", "Corylus avellana", "Cola acuminata | Cola nitida | Cola vera", "Macadamia integrifolia | Macadamia tetraphylla", "Carya illinoensis", "Pistacia vera", "Juglans spp."),
         wiki_id = c("Q184357 | Q15545507", "Q1816679 | Q156969","Q12371971", "Q7885904 | Q34007", "Q773987", "Q578307 | Q104738415", "Q114264 | Q912522", "Q310041 | Q11027461", "Q333877 | Q1119911", "Q14959225 | Q36071", "Q208021 | Q46871"),
         life_form = c("tree"),
         use_typ = c("food"),
         used_part = c("seed"),
         persistence = c("permanent")),
  tibble(concept = c("castor bean", "cotton", "earth pea", "fenugreek", "hemp", "linseed", "jojoba", "mustard", "niger seed", "peanut | goundnut", "poppy", "rapeseed | colza", "safflower", "sesame", "shea nut | karite nut", "soybean", "sunflower", "tallowtree", "tung nut"),
         broader = class$concept[16],
         icc_11 = c("4.03.01", "9.02.01.01", "7.9", "7.90", "9.02.01.04", "4.03.02 | 9.02.01.03", "4.03.11", "4.03.03", "4.03.04", "4.02", "4.03.12", "4.03.05", "4.03.06", "4.03.07", "4.03.09", "4.01", "4.03.08 | ", "4.03.13", "4.03.10"),
         cpc_21 = c("01447", "0143 | 01921", "01709.90", "01709.90", "01449.02 | 01929.02", "01441 | 01929.01", "01499.03", "01442", "01449.90", "0142", "01448", "01443", "01446", "01444", "01499.01", "0141", "01445", "01499.04", "01499.02"),
         scientific_name = c("Ricinus communis", "Gossypium spp.", "Vigna subterranea", "Trigonella foenum-graecum", "Canabis sativa", "Linum usitatissimum", "Simmondsia californica | Simmondsia chinensis", "Brassica nigra | Sinapis alba", "Guizotia abyssinica", "Arachis hypogaea", "Papaver somniferum", "Brassica napus", "Carthamus tinctorius", "Sesamum indicum", "Vitellaria paradoxa | Butyrospermum parkii", "Glycine max", "Helianthus annuus", "Shorea aptera | Shorea stenocarpa | Sapium sebiferum", "Aleurites fordii"),
         wiki_id = c("Q64597240 | Q155867", "Q11457", "Q338219", "Q133205", "Q26726 | Q7150699 | Q13414920", "Q911332", "Q267749", "Q131748 | Q146202 | Q504781", "Q110009144", "Q3406628 | Q23485", "Q131584 | Q130201", "Q177932", "Q156625 | Q104413623", "Q2763698 | Q12000036", "Q104212650 | Q50839003", "Q11006", "Q26949 | Q171497 | Q1076906", "Q1201089", "Q2699247 | Q2094522"),
         life_form = c("forb", "tree", "forb", "forb", "forb", "forb", "forb", "forb", "forb", "forb", "forb", "forb", "forb", "forb", "tree", "forb", "forb", "tree", "tree"),
         use_typ = c("medicinal | food", "food | fibre", "food", "food", "food | fibre", "food | fibre | industrial", "food", "food", "food", "food", "food | medicinal | recreation", "food", "food | industrial", "food", "food", "food", "food | fodder", "industrial", "industrial"),
         used_part = c("seed", "fruit | husk", "fruit", "seed | leaves", "seed | lint", "seed", "seed | bast | seed", "seed", "seed", "seed", "seed", "seed", "seed", "seed", "seed", "seed", "seed", "seed", "seed"),
         persistence = c("temporary", "permanent", "temporary", "temporary", "temporary", "temporary", "temporary", "temporary", "temporary", "temporary", "temporary", "temporary", "temporary", "temporary", "permanent", "temporary", "temporary", "permanent", "permanent")),
  tibble(concept = c("cocoa | cacao", "coffee", "mate", "tea", "tobacco"),
         broader = class$concept[17],
         icc_11 = c("6.01.04", "6.01.01", "6.01.03", "6.01.02", "9.06"),
         cpc_21 = c("01640", "01610", "01630", "01620", "01970"),
         scientific_name = c("Theobroma cacao", "Coffea spp.", "Ilex paraguariensis", "Camellia sinensis", "Nicotiana tabacum"),
         wiki_id = c("Q208008", "Q8486", "Q81602 | Q5881191", "Q101815 | Q6097", "Q1566 | Q181095"),
         life_form = c("tree", "shrub", "shrub", "shrub", "forb"),
         use_typ = c("food | recreation", "food | recreation", "food | recreation", "food | recreation", "recreation"),
         used_part = c("seed", "fruit", "leaves", "leaves", "leaves"),
         persistence = c("permanent", "permanent", "permanent", "permanent", "temporary")),
  tibble(concept = c("anise", "badian | star anise", "cannella cinnamon", "caraway", "cardamon", "chillies and peppers", "clove", "coriander",
                     "cumin", "dill", "fennel", "ginger", "hop", "juniper berry", "mace", "malaguetta pepper", "nutmeg", "pepper", "thyme",
                     "vanilla", "lavender"),
         # Angelica stems Angelica archangelica 6229 6.02.02.90 01690
         # Bay leaves Laurus nobilis, 6229 6.02.02.90 01690
         # Drumstick tree Moringa oleifera 6229 6.02.02.90 01690
         # Guinea pepper Afframomum melegueta, piper guineense, xylopia aethiopica 6229 6.02.02.90 01690
         # Saffron Crocus savitus 6229 6.02.02.90 01690
         # Turmeric Curcuma longa 6229 6.02.02.90 01690
         broader = class$concept[18],
         icc_11 = c("6.02.01.02", "6.02.01.02", "6.02.02.03", "6.02.01.90", "6.02.02.02", "6.02.01.01", "6.02.02.04", "6.02.01.02",
                    "6.02.01.02", "6.02.01.02", "6.02.02.90", "6.02.02.05", "6.02.02.07", "6.02.01.02", "6.02.02.02", "6.02.02.02",
                    "6.02.02.02", "6.02.02.01", "6.02.02.90", "6.02.02.06", "9.03.01"),
         cpc_21 = c("01654", "01654", "01655", "01654", "01653", "01652 | 01231", "01656", "01654", "01654", "0169", "01654", "01657",
                    "01659", "01654", "01653", "01653", "01653", "01651", "0169", "01658", "01699"),
         scientific_name = c("Pimpinella anisum", "Illicium verum", "Cinnamomum verum", "Carum carvi", "Elettaria cardamomum", "Capsicum spp.",
                             "Eugenia aromatica", "Coriandrum sativum", "Cuminum cyminum", "Anethum graveoles", "Foeniculum vulgare",
                             "Zingiber officinale", "Humulus lupulus", "Juniperus communis", "Myristica fragrans", "Aframomum melegueta",
                             "Myristica fragrans", "Piper nigrum", "Thymus vulgaris", "Vanilla planifolia", "Lavandula spp."),
         wiki_id = c("Q28692", "Q1760637", "Q28165 | Q370239", "Q26811", "Q14625808", "Q165199 | Q201959 | Q1380", "Q15622897",
                     "Q41611 | Q20856764", "Q57328174 | Q132624", "Q26686 | Q59659860", "Q43511 | Q27658833", "Q35625 | Q15046077", "Q104212",
                     "Q3251025", "Q1882876", "Q3312331", "Q12104", "Q311426", "Q148668 | Q3215980", "Q162044", "Q42081"),
         life_form = c("forb", "forb", "forb", "forb", "forb", "forb", "tree", "forb", "forb", "forb", "forb", "forb", "forb", "shrub", "tree",
                       "forb", "tree", "forb", "forb", "forb", "forb"),
         use_typ = c("food", "food", "food", "food", "food", "food", "food", "food", "food", "food", "food", "food", "food", "food",
                     "food | fibre", "food", "food", "food", "food", "food", "food"),
         used_part = c("fruit", "fruit", "bark", "seed", "seed", "fruit", "flower", "seed | leaves", "seed", "seed", "bulb | leaves | fruit",
                       "root", "flower", "fruit", "fruit", "fruit", "seed", "fruit", "seed", "fruit", "leaves"),
         persistence = c("temporary", "temporary", "permanent", "temporary", "permanent", "temporary", "permanent", "temporary", "temporary",
                         "temporary", "temporary", "permanent", "permanent", "permanent", "permanent", "temporary", "permanent", "permanent",
                         "temporary", "permanent", "permanent")),
  tibble(concept = c("basil", "coca", "ginseng", "guarana", "kava", "liquorice", "mint"),
         broader = class$concept[19],
         icc_11 = c("9.03.01.02", "9.03.02.02", "9.03.02.01", "9.03.02.04", "9.03.02.03", "9.03.01", "9.03.01.01"),
         cpc_21 = c("01699", "01699", "01699", "01699", "01699", "01930", "01699 | 01930.01"),
         scientific_name = c("Ocimum basilicum", "Erythroxypum novogranatense | Erythroxypum coca", "Panax spp.", "Paulinia cupana", "Piper methysticum", "Glycyrrhiza glabra", "Mentha spp."),
         wiki_id = c("Q38859 | Q65522654", "Q158018", "Q182881 | Q20817212", "Q209089", "Q161067", "Q257106", "Q47859 | Q156037"),
         life_form = c("forb", "tree", "forb", "forb", "forb", "forb", "forb"),
         use_typ = c("food", "recreation", "food", "food | recreation", "food", "food | medicinal", "food"),
         used_part = c("leaves", "leaves", "root", "seeds", "root", "root", "leaves"),
         persistence = c("temporary")),
  tibble(concept = c("stevia"),
         broader = class$concept[20],
         icc_11 = c("8.9"),
         cpc_21 = c("01809"),
         scientific_name = c("Stevia rebaudiana"),
         wiki_id = c("Q312246 | Q3644010"),
         life_form = c("forb"),
         use_typ = c("food"),
         used_part = c("leaves"),
         persistence = c("temporary")),
  tibble(concept = c("sugar beet"),
         broader = class$concept[21],
         icc_11 = c("8.01"),
         cpc_21 = c("01801 | 01919.06"),
         scientific_name = c("Beta vulgaris var. altissima"),
         wiki_id = c("Q151964"),
         life_form = c("forb"),
         use_typ = c("food | fodder"),
         used_part = c("root | leaves"),
         persistence = c("temporary")),
  tibble(concept = c("sugar cane", "sweet sorghum", "sugar maple"),
         broader = class$concept[22],
         icc_11 = c("8.02", "8.03", "8.9"),
         cpc_21 = c("01802 | 01919.91", "01809", "01809"),
         scientific_name = c("Saccharum officinarum", "Sorghum saccharatum", "Acer saccharum"),
         wiki_id = c("Q36940 | Q3391243", "Q3123184", "Q214733"),
         life_form = c("graminoid", "graminoid", "tree"),
         use_typ = c("food | fodder", "food", "food"),
         used_part = c("stalk | sap"),
         persistence = c("temporary")),
  tibble(concept = c("cantaloupe", "chayote", "cucumber | gherkin", "eggplant", "gourd", "melon", "okra", "pumpkin", "squash", "sweet pepper", "tamarillo", "tomato", "watermelon"),
         broader = class$concept[23],
         icc_11 = c("2.05.02", "2.02.90", "2.02.01", "2.02.02", "2.02.04", "2.05.02", "2.02.05", "2.02.04", "2.02.04", "6.02.01.01", "2.02.90", "2.02.03", "2.05.01"),
         cpc_21 = c("01229", "01239.90", "01232", "01233", "01235", "01229", "01239.01", "01235", "01235", "01231", "01239.90", "01234", "01221"),
         scientific_name = c("Cucumis melo", "Sechium edule", "Cucumis sativus", "Solanum melongena", "Lagenaria spp | Cucurbita spp.", "Cucumis melo", "Abelmoschus esculentus | Hibiscus esculentus", "Cucurbita spp", "Cucurbita spp", "Capsicum annuum", "Solanum betaceum", "Lycopersicon esculentum", "Citrullus lanatus"),
         wiki_id = c("Q61858403 | Q477179", "Q319611", "Q2735883 | Q23425", "Q7540 | Q12533094", "Q7370671", "Q5881191 | Q81602", "Q80531 | Q12047207", "Q165308 | Q5339301", "Q5339237 | Q7533", "Q1548030", "Q379747", "Q20638126 | Q23501", "Q38645 | Q17507129"),
         life_form = c("forb"),
         use_typ = c("food", "food", "food", "food", "food", "food", "food", "food | fodder", "food | fodder", "food", "food", "food", "food"),
         used_part = c("fruit"),
         persistence = c("temporary")),
  tibble(concept = c("artichoke", "asparagus", "bok choy | pak choi", "broccoli", "brussels sprout", "cabbage", "cauliflower", "celery", "chicory", "chinese cabbage", "collard", "endive", "gai lan", "kale", "kohlrabi", "lettuce", "rhubarb", "savoy cabbage", "spinach"),
         broader = class$concept[24],
         icc_11 = c("2.01.01", "2.01.02", "2.01.03", "2.01.04", "2.01.90", "2.01.03 | 01919.04", "2.01.04", "2.01.90", "2.01.07", "2.01.03", "2.01.03", "2.01.90", "2.01.03", "2.01.90", "2.03.90", "2.01.05", "2.01.90", "2.01.03", "2.01.06"),
         cpc_21 = c("01216", "01211", "01212", "01213", "01212", "01212", "01213", "01290", "01214", "01212", "01212", "01214", "01212", "01212", "01212", "01214", "01219", "01212", "01215"),
         scientific_name = c("Cynara scolymus", "Asparagus officinalis", "Brassica rapa subsp. chinensis", "Brassica oleracea var. botrytis", "Brassica oleracea var. gemmifera", "Brassica oleracea var. capitata", "Brassica oleracea var. botrytis", "Apium graveolens", "Cichorium intybus", "Brassica chinensis", "Brassica oleracea var. viridis", "Cichorium endivia", "Brassica oleracea var. alboglabra", "Brassica oleracea var. acephala", "Brassica oleracea var. gongylodes", "Lactuca sativa var. capitata", "Rheum spp.", "Brassica oleracea var. capitata", "Spinacia oleracea"),
         wiki_id = c("Q23041430", "Q2853420 | Q23041045", "Q18968514", "Q47722 | Q57544960", "Q150463 | Q104664711", "Q14328596", "Q7537 | Q23900272", "Q28298", "Q2544599 | Q1474", "Q13360268 | Q104664724", "Q146212 | Q14879985", "Q178547 | Q28604477", "Q1677369 | Q104664699", "Q45989", "Q147202", "Q83193 | Q104666136", "Q20767168", "Q154013", "Q81464"),
         life_form = c("forb"),
         use_typ = c("food", "food", "fodder | food", "food", "fodder | food", "food | fodder", "food", "food", "food | recreation", "food", "food", "food", "food", "food | fodder", "food", "food", "food", "food", "food"),
         used_part = c("flowers", "shoots", "leaves", "flowers", "flowers", "leaves", "flowers", "shoots", "leaves", "leaves", "leaves", "leaves", "leaves", "leaves", "shoots", "leaves", "leaves", "leaves", "leaves"),
         persistence = c("temporary")),
  tibble(concept = c("mushrooms"),
         broader = class$concept[25],
         icc_11 = c("2.04"),
         cpc_21 = c("01270"),
         scientific_name = c("Agaricus spp. | Pleurotus spp. | Volvariella"),
         wiki_id = c("Q654236"),
         life_form = c("mushroom"),
         use_typ = c("food"),
         used_part = c("fruit body"),
         persistence = c("temporary")),
  tibble(concept = c("carrot", "chive", "beet root | red beet", "chard", "garlic", "leek", "onion", "turnip", "mangelwurzel",
                     "manioc | cassava | tapioca", "potato", "sweet potato", "taro | cocoyam | dasheen", "yam", "yautia"),
         # This subclass includes:
         # - Jerusalem artichokes, girasole, Helianthus tuberosus 211 2.01.01 01599
         # - tacca, Tacca pinnatifida
         # Arracha Arracacia xanthorrhiza 59 5.90 01599
         # Edo (eddoe) Xanthosoma spp.; Colocasia spp. 59 5.90 01599
         # Tannia Xanthosoma sagittifolium 59 5.90 01599
         # Horseradish Armoracia rusticana 239 2.03.90 01259
         # Celeriac Apium graveolens var. rapaceum 239 2.03.90 01259
         # Swede (fodder) Brassica napus var. napobrassica 239 2.03.90 01919.08
         # Salsify Tragopogon porrifolius 239 2.03.90 01259
         # Scorzonera (black salsify) Scorzonera hispanica 239 2.03.90 01259
         # Parsnip Pastinaca sativa 239 2.03.90 01259
         # Radish Raphanus sativus (inc. Cochlearia armoracia) 239 2.03.90 01259
         broader = class$concept[26],
         icc_11 = c("2.03.01", "2.03.05", "8.01", "8.01", "2.03.03", "2.03.05", "2.03.04", "2.03.02", "8.01", "5.03", "5.01", "5.02", "5.05",
                    "5.04", "5.06"),
         cpc_21 = c("01251 | 01919.07", "01254", "01801", "01801", "01252", "01254", "01253", "01251 | 01919.05", "01801", "01520", "01510",
                    "01530", "01550", "01540", "01591"),
         scientific_name = c("Daucus carota ssp. sativa", "Allium schoenoprasum", "Beta vulgaris var. vulgaris", "Beta vulgaris var. cicla",
                             "Allium sativum", "Allium ampeloprasum | Allium porrum", "Allium cepa", "Brassica rapa",
                             "Beta vulgaris var. crassa", "Manihot esculenta", "Solamum tuberosum", "Ipomoea batatas", "Colocasia esculenta",
                             "Dioscorea spp.", "Xanthosoma sagittifolium"),
         wiki_id = c("Q81 | Q11678009", "Q5766863", "Q99548274", "Q157954", "Q23400 | Q21546392", "Q1807269", "Q13191", "Q3916957 | Q3384",
                     "Q740726", "Q43304555 | Q83124", "Q16587531 | Q10998", "Q37937", "Q227997", "Q8047551 | Q71549", "Q763075"),
         life_form = c("forb"),
         use_typ = c("food | fodder", "food", "food", "food", "food", "food", "food", "food", "food | forage", "food", "food", "food", "food",
                     "food", "food"),
         used_part = c("root", "leaves", "leaves", "leaves", "bulb", "leaves", "bulb", "root", "root", "tuber", "root", "tuber", "root",
                       "tuber", "tuber"),
         persistence = c("temporary")),
  tibble(concept = c("partridge", "pigeon", "quail", "chicken", "duck", "goose", "turkey"),
         broader = class$concept[43],
         icc_11 = NA_character_,
         cpc_21 = c("02194", "02194", "02194", "02151", "02154", "02153", "02152"),
         scientific_name = c("Alectoris rufa", "Columba livia", "Coturnis spp.", "Gallus domesticus", "Anas platyrhynchos", "Anser anser | Anser albofrons | Anser arvensis", "Meleagris gallopavo"),
         wiki_id = c("Q25237 | Q29472543", "Q2984138 | Q10856", "Q28358", "Q780", "Q3736439 | Q7556", "Q16529344", "Q848706 | Q43794"),
         life_form = NA_character_,
         use_typ = c("food", "labor | food", "food", "food", "food", "labor | food", "food"),
         used_part = c("time | eggs | meat"),
         persistence = NA_character_),
  tibble(concept = c("hare", "rabbit"),
         broader = class$concept[45],
         icc_11 = NA_character_,
         cpc_21 = c("02191"),
         scientific_name = c("Lepus spp.", "Oryctolagus cuniculus"),
         wiki_id = c("Q46076 | Q63941258", "Q9394"),
         life_form = NA_character_,
         use_typ = c("food"),
         used_part = c("meat"),
         persistence = NA_character_),
  tibble(concept = c("buffalo", "cattle"),
         broader = class$concept[48],
         icc_11 = NA_character_,
         cpc_21 = c("02112", "02111"),
         scientific_name = c("Bubalus bubalus | Bubalus ami | Bubalus depressicornis | Bubalus nanus | Syncerus spp. | Bison spp.", "Bos bovis | Bos taurus | Bos indicus | Bos grunniens | Bos gaurus | Bos grontalis | Bos sondaicus"),
         wiki_id = c("Q82728", "Q830 | Q4767951"),
         life_form = NA_character_,
         use_typ = c("labor | food"),
         used_part = c("time | milk | meat"),
         persistence = NA_character_),
  tibble(concept = c("goat", "sheep"),
         broader = class$concept[49],
         icc_11 = NA_character_,
         cpc_21 = c("02123", "02122"),
         scientific_name = c("Capra hircus", "Ovis aries"),
         wiki_id = c("Q2934", "Q7368" ),
         life_form = NA_character_,
         use_typ = c("labor | food"),
         used_part = c("time | milk | meat"),
         persistence = NA_character_),
  tibble(concept = c("alpaca", "camel", "guanaco", "llama", "vicugna"),
         broader = class$concept[50],
         icc_11 = NA_character_,
         cpc_21 = c("02121.02", "02121.01", "02121.02", "02121.02", "02121.02"),
         scientific_name = c("Lama pacos", "Camelus bactrianus | Camelus dromedarius | Camelus ferus", "Lama guanicoe", "Lama glama", "Lama vicugna"),
         wiki_id = c("Q81564", "Q7375", "Q172886 | Q1552716", "Q42569", "Q2703941 | Q167797"),
         life_form = NA_character_,
         use_typ = c("fibre", "labor", "labor", "fibre | labor", "fibre"),
         used_part = c("hair", "time", "time", "hair | time", "hair"),
         persistence = NA_character_),
  tibble(concept = c("ass", "horse", "mule"),
         broader = class$concept[51],
         icc_11 = NA_character_,
         cpc_21 = c("02132", "02131", "02133"),
         scientific_name = c("Equus africanus asinus", "Equus ferus caballus", "Equus africanus asinus × Equus ferus caballus"),
         wiki_id = c("Q19707", "Q726 | Q10758650", "Q83093"),
         life_form = NA_character_,
         use_typ = c("labor | food"),
         used_part = c("time | meat"),
         persistence = NA_character_),
  tibble(concept = c("pig"),
         broader = class$concept[52],
         scientific_name = "Sus domesticus | Sus scrofa",
         icc_11 = NA_character_,
         cpc_21 = c("02140"),
         wiki_id = c("Q787"),
         life_form = NA_character_,
         use_typ = c("food"),
         used_part = c("meat"),
         persistence = NA_character_),
  tibble(concept = c("beehive"),
         broader = class$concept[53],
         scientific_name = c("Apis mellifera | Apis dorsata | Apis florea | Apis indica"),
         icc_11 = NA_character_,
         cpc_21 = c("02196"),
         wiki_id = c("Q165107"),
         life_form = NA_character_,
         use_typ = c("labor | food"),
         used_part = c("honey"),
         persistence = NA_character_)) %>%
  bind_rows()

luckiOnto <- new_concept(new = commodity$concept,
                         broader = get_concept(table = commodity %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)


# mappings to other ontologies/vocabularies ----
#
##



## FAO Indicative Crop Classification (ICC) version 1.1
luckiOnto <- new_source(name = "icc",
                        date = Sys.Date(),
                        version = "1.1",
                        description = "The official version of the Indicative Crop Classification was developed for the 2020 round of agricultural censuses.",
                        homepage = "https://stats.fao.org/caliper/browse/skosmos/ICC11/en/",
                        uri_prefix = "https://stats.fao.org/classifications/ICC/v1.1/",
                        license = "",
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$icc_11,
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

luckiOnto <- new_mapping(new = commodity$cpc_21,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "cpc", match = "close", certainty = 3,
                         ontology = luckiOnto)

## Scientific Botanical name
luckiOnto <- new_source(name = "scientificName",
                        date = Sys.Date(),
                        description = "This contains scientific pland and animal names as suggested in the ICC 1.1",
                        homepage = "",
                        license = "",
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$scientific_name,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "scientificName", match = "close", certainty = 3,
                         ontology = luckiOnto)

## wikidata ----
luckiOnto <- new_source(name = "wikidata",
                        date = Sys.Date(),
                        description = "Wikidata is a free, collaborative, multilingual, secondary database, collecting structured data to provide support for Wikipedia, Wikimedia Commons, the other wikis of the Wikimedia movement, and to anyone in the world.",
                        homepage = "https://www.wikidata.org/",
                        uri_prefix = "https://www.wikidata.org/wiki/",
                        license = "CC0",
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$wiki_id,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "wikidata", match = "close", certainty = 3,
                         ontology = luckiOnto)

## persistence ----
luckiOnto <- new_source(name = "persistence",
                        date = Sys.Date(),
                        description = "a collection of standard terms of the persistance of plants",
                        homepage = "",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

lut_persistence <- tibble(label = c("temporary", "permanent"),
                          description = c("plants that exist only until being harvest the first time",
                                          "plants that exist for several years where they are harvested several times"))

luckiOnto <- new_mapping(new = commodity$persistence,
                         target = get_concept(table = commodity %>% select(label = concept), ontology = luckiOnto),
                         source = "persistence", match = "close", certainty = 3,
                         lut = lut_persistence,
                         ontology = luckiOnto)

## life-form ----
luckiOnto <- new_source(name = "life-form",
                        date = Sys.Date(),
                        description = "a collection of standard terms of plant life-forms",
                        homepage = "",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

lut_lifeForm <- tibble(label = c("graminoid", "tree", "shrub", "forb"),
                       description = "")

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

lut_useType <- tibble(label = c("bioenergy", "fibre", "food", "wood", "forage",
                                "silage", "fodder", "industrial", "recreation",
                                "medicinal", "labor"),
                      description = c("plants that are used for bioenergy production",
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


# write output ----
#
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))
export_as_rdf(ontology = luckiOnto, filename = paste0(dataDir, "tables/luckiOnto.ttl"))
