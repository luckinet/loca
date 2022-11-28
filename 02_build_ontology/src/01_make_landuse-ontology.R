# script arguments ----
#
message("\n---- build landuse ontology ----")


# load data ----
#

change new_mapping so that if description is a tibble with columns 'label' and 'description' (basically a look up table), that the external concepts are not stored with "has_broader" information

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
lcGroup <- tibble(concept = c("ARTIFICIAL SURFACES", "AGRICULTURAL AREAS", "FOREST AND SEMI-NATURAL AREAS", "WETLANDS", "WATER BODIES"),
                  description = c(NA_character_, NA_character_, NA_character_, NA_character_, NA_character_),
                  broader = "surface types")

luckiOnto <- new_concept(new = lcGroup$concept,
                         broader = get_concept(table = lcGroup %>% select(label = broader), ontology = luckiOnto),
                         description = lcGroup$description,
                         class = "land-cover group",
                         ontology =  luckiOnto)

### land cover ----
lc <- list(
  tibble(concept = c("Urban fabric", "Industrial, commercial and transport units", "Mine, dump and construction sites", "Artificial, non-agricultural vegetated areas"),
         description = c(NA_character_,
                         NA_character_,
                         NA_character_,
                         NA_character_),
         broader = lcGroup$concept[1]),
  tibble(concept = c("Temporary cropland", "Permanent cropland", "Heterogeneous agricultural areas"),
         description = c(NA_character_,
                         NA_character_,
                         NA_character_),
         broader = lcGroup$concept[2]),
  tibble(concept = c("Forests", "Other Wooded Areas", "Shrubland", "Herbaceous associations", "Heterogeneous semi-natural areas", "Open spaces witih little or no vegetation"),
         description = c(NA_character_,
                         NA_character_,
                         NA_character_,
                         NA_character_,
                         NA_character_,
                         NA_character_),
         broader = lcGroup$concept[3]),
  tibble(concept = c("Inland wetlands", "Marine wetlands"),
         description = c(NA_character_,
                         NA_character_),
         broader = lcGroup$concept[4]),
  tibble(concept = c("Inland waters", "Marine waters"),
         description = c(NA_character_,
                         NA_character_),
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
  tibble(concept = c("Permanent grazing", "Shrub orchards", "Palm plantations", "Tree orchards", "Woody plantation", "Protective cover"),
         description = c(NA_character_,
                         NA_character_,
                         NA_character_,
                         NA_character_,
                         NA_character_,
                         NA_character_),
         broader = lc$concept[6]),
  tibble(concept = c("Agroforestry", "Mosaic of agricultural-uses", "Mosaic of agriculture and natural vegetation"),
         description = c(NA_character_,
                         NA_character_,
                         NA_character_),
         broader = lc$concept[7]),
  tibble(concept = c("Undisturbed Forest", "Naturally Regenerating Forest", "Planted Forest", "Temporally Unstocked Forest"),
         description = c(NA_character_,
                         NA_character_,
                         NA_character_,
                         NA_character_),
         broader = lc$concept[8])) %>%
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
                                "This group comprises plants that are grown primarily to use their (typically sweet or sour) fleshy part that is edible in a raw state",
                                "This group comprises plants that are grown primarily to use their seeds as food source. 'Seed' is regarded as the reproductive organ that, when put into a suitably substrate, grows a new plant.",
                                "This group comprises plants that are grown primarily to make use of their medicinal effect, their taste or for their mind-altering effects",
                                "This group comprises plants that are grown primarily for their sugar content",
                                "This group comprises plants that are grown primarily to use some of their organs (includes typically savory fruit, but not seeds) as human nourishment",
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
  tibble(concept = c("Bioenergy crops", "Fibre crops", "Flower crops", "Rubber crops", "Pasture crops"),
         description = c("This class covers plants that are grown primarily for the production of energy",
                         "This class covers plants where some plant-part is used to produce textile fibres, and which are not used for other means, such as fruit or oil production",
                         "This class covers plants that are grown to use some of their parts for ornamental reasons, and which are not used for other means, such as fruit or fibre production",
                         "This class covers plants that are grown to produce gums and rubbers",
                         "This class covers plants that are grown as food source for animals, mostly to be grazed on by livestock"),
         broader = group$concept[1]),
  tibble(concept = c("Berries", "Citrus Fruit", "Grapes", "Pome Fruit", "Stone Fruit", "Tropical and subtropical Fruit"),
         description = c("This class covers plants that are grown for their fruit that have small, soft roundish edible tissue",
                         "This class covers plants that are part of the genus Citrus",
                         "This class covers plants that are part of the genus Vitis",
                         "This class covers plants that are grown for their apple-like fruit",
                         "This class covers plants that are grown for their fruit that have a single hard stone and a fleshy, juicy edible tissue",
                         "This class covers plants that grow in tropical and subtropical regions"),
         broader = group$concept[2]),
  tibble(concept = c("Cereals", "Leguminous seeds", "Treenuts", "Oilseeds"),
         description = c("This class covers graminoid plants that are grown for their grain. This class also includes pseudocereals, as they are also used for their grain",
                         "This class covers leguminous plants that are grown for both, their dry and green seeds",
                         "This class covers plants that are grown for their dry seeds that are protected by a hard shell",
                         "This class covers plants that are grown to use their seeds to produce oils that are part of human nourishment"),
         broader = group$concept[3]),
  tibble(concept = c("Stimulant crops", "Spice crops", "Medicinal crops"),
         description = c("This class covers plants that are grown for their stimulating or mind-altering effects",
                         "This class covers plants that are grown for their aromatic properties",
                         "This class covers plants that are grown for their medical effects on the animal physiology"),
         broader = group$concept[4]),
  tibble(concept = c("Leave sugar crops", "Root sugar crops", "Sap sugar crops"),
         description = c("This class covers plants that grown to produce sugar from their leaves",
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
         life_form = c("herb"),
         use_typ = c("fibre", "fibre", "fibre"),
         used_part = c("bast"),
         persistence = c("temporary")),
  tibble(concept = c("abaca | manila hemp", "sisal"),
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
         cpc_21 = c("01929.03"),
         wiki_id = c("Q1728687"),
         life_form = c("tree"),
         use_typ = c("fibre"),
         used_part = c("seed"),
         persistence = c("permanent")),
  # tibble(concept = c("natural gums", "natural rubber"),
  #        broader = class$concept[4],
  #        icc_11 = c("", ""),
  #        cpc_21 = c("", ""),
  #        scientific_name = c("", ""),
  #        wiki_id = c(NA_character_, NA_character_),
  #        life_form = c("tree"),
  #        use_typ = c("industrial"),
  #        used_part = c("", ""),
  #        persistence = c("permanent")),
  tibble(concept = c("alfalfa"),
         broader = class$concept[5],
         icc_11 = c("9.01.01"),
         cpc_21 = c("01912 | 01940"),
         scientific_name = c("Medicago sativa"),
         wiki_id = c("Q156106"),
         life_form = c("graminoid"),
         use_typ = c("food | fodder | forage"),
         used_part = c("biomass"),
         persistence = c("temporary")),
  tibble(concept = c("clover", "lupin"),
         broader = class$concept[5],
         icc_11 = c("9.01.01", "7.06"),
         cpc_21 = c("01919.03", "01709.02"),
         scientific_name = c("Trifolium spp.", "Lupinus spp."),
         wiki_id = c("Q101538", "Q156811"),
         life_form = c("forb", "forb"),
         use_typ = c("fodder | forage", "fodder | forage"),
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
  tibble(concept = c("clementine", "grapefruit", "lemon", "lime", "mandarine", "orange", "pomelo", "satsuma", "tangerine"),
         broader = class$concept[15],
         icc_11 = c(""),
         cpc_21 = c(""),
         scientific_name = c(""),
         wiki_id = c("Q460517", "Q21552830", "Q500 | Q1093742", "Q13195", "Q125337", "Q12330939 | Q34887", "Q353817 | Q80024", "Q875262", "Q516494"),
         life_form = c("tree"),
         use_typ = c("food"),
         used_part = c(""),
         persistence = c("permanent")),
  tibble(concept = c("grape"),
         broader = class$concept[16],
         icc_11 = c(""),
         cpc_21 = c(""),
         scientific_name = c(""),
         wiki_id = c("Q10978 | Q191019"),
         life_form = c("shrub"),
         use_typ = c("food"),
         used_part = c(""),
         persistence = c("permanent")),
  tibble(concept = c("apple", "pear", "quince"),
         broader = class$concept[17],
         scientific_name = c("Malus sylvestris", "Pyrus communis", "Cydonia oblonga"),
         icc_11 = c("2.05.01", "3.05.05", "3.05.05"),
         cpc_21 = c("01341", "01342.01", "01342.02"),
         wiki_id = c("Q89 | Q15731356", "Q434 | Q13099586", "Q2751465 | Q43300"),
         life_form = c("tree"),
         use_typ = c("food"),
         used_part = c("fruit"),
         persistence = c("permanent")),
  tibble(concept = c("apricot", "cherry", "nectarine", "peach", "plum", "sloe", "sour cherry"),
         broader = class$concept[18],
         icc_11 = c(),
         cpc_21 = c(),
         scientific_name = c(),
         wiki_id = c("Q37453 | Q3733836", "Q196", "Q2724976 | Q83165", "Q37383", "Q6401215 | Q13223298", "Q12059685 | Q129018", "Q68438267 | Q131517"),
         life_form = c("tree"),
         use_typ = c("food"),
  used_part = c(""),
         persistence = c("permanent")),
  tibble(concept = c("açaí", "avocado", "banana", "date", "fig", "guava", "mango", "mangosteen", "papaya", "persimmon", "pineapple", "plantain"),
         broader = class$concept[19],
         icc_11 = c(),
         cpc_21 = c(),
         scientific_name = c(),
         wiki_id = c("Q33943 | Q12300487", "Q961769 | Q37153", "Q503", "Q1652093", "Q36146 | Q2746643", "Q166843 | Q3181909", "Q169","Q170662 | Q104030000", "Q732775", "Q158482 | Q29526", "Q1493 | Q10817602", "Q165449"),
         life_form = c("tree", "tree", "tree", "tree", "shrub", "tree", "tree", "tree", "tree", "tree", "shrub", "tree"),
         use_typ = c("food", "food", "fibre | food", "food", "food", "food", "food", "food", "food", "food", "food", "food"),
  used_part = c(""),
         persistence = c("permanent")),
  tibble(concept = c("basil", "coca", "ginseng", "guarana", "kava", "mint", "peppermint", "tobacco"),
         broader = class$concept[23],
         icc_11 = c(),
         cpc_21 = c(),
         scientific_name = c(),
         wiki_id = c("Q38859 | Q65522654", "Q158018", "Q182881 | Q20817212", "Q209089", "Q161067", "Q47859", "Q156037", "Q1566 | Q181095"),
         life_form = c("forb", "tree", "forb", "forb", "forb", "forb", "forb", "forb"),
         use_typ = c("food", "recreation", "food", "food | recreation", "food", "food", "food", "recreation"),
  used_part = c(""),
         persistence = c("temporary")),
  tibble(concept = c("barley", "maize", "millet", "oat", "triticale", "buckwheat", "canary seed", "fonio", "quinoa", "rice", "rye", "sorghum", "wheat", "mixed cereals"),
         broader = class$concept[26],
         icc_11 = c(),
         cpc_21 = c(),
         scientific_name = c(),
         wiki_id = c("Q11577", "Q11575 | Q25618328", "Q131542", "Q165403 | Q4064203", "Q380329", "Q132734 | Q4536337", "Q2086586", "Q1340738 | Q12439809", "Q104030862 | Q139925", NA, "Q5090 | Q161426", "Q12099", "Q105549747 | Q12111", "Q15645384 | Q161098 | Q618324"),
         life_form = c("graminoid"),
         use_typ = c("forage | food", "food | silage", "food", "food", "food", "food", "food", "food", "food", "food", "food", "food", "food", "food"),
         used_part = c(""),
         persistence = c("temporary")),
  tibble(concept = c("bambara bean", "bean", "broad bean", "carob", "chickpea", "cow pea", "lentil", "pea", "pigeon pea", "string bean", "vetch"),
         broader = class$concept[27],
         icc_11 = c("", "", "", "3.9"),
         cpc_21 = c("", "", "", "01356"),
         scientific_name = c("", "", "", "Ceratonia siliqua"),
         wiki_id = c("Q107357073", "Q379813", "Q131342 | Q61672189", "Q8195444 | Q68763", "Q81375 | Q21156930", "Q107414065", "Q61505177 | Q131226", "Q13189 | Q13202263", "Q632559 | Q103449274", "Q42339 | Q2987371", "Q157071"),
         life_form = c("forb"),
         use_typ = c("food"),
         used_part = c(""),
         persistence = c("temporary", "temporary", "temporary", "permanent", "temporary", "temporary", "temporary", "temporary", "temporary", "temporary", "temporary")),
  tibble(concept = c("almond", "areca nut", "brazil nut", "cashew", "chestnut", "hazelnut", "kolanut", "pistachio", "walnut"),
         broader = class$concept[28],
         icc_11 = c(),
         cpc_21 = c(),
         scientific_name = c(),
         wiki_id = c("Q184357 | Q15545507", "Q1816679 | Q156969","Q12371971", "Q7885904 | Q34007", "Q773987", "Q578307 | Q104738415", "Q114264 | Q912522", "Q14959225 | Q36071", "Q208021 | Q46871"),
         life_form = c("tree"),
         use_typ = c("food"),
  used_part = c(""),
         persistence = c("permanent")),
  tibble(concept = c("castor bean", "coconut | coir", "cotton", "hemp", "linseed | flax", "jojoba", "mustard",
                     "niger seed", "oil palm", "olive", "peanut | goundnut", "poppy", "rapeseed", "safflower",
                     "sesame", "shea nut", "soybean", "sunflower", "tallowtree", "tung nut"),
         broader = class$concept[29],
         icc_11 = c("", "9.02.02.90", "9.02.01.01",
                    "9.02.01.04", "9.02.01.03", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""),
         cpc_21 = c("", "0146 | 01929.08", "0143 | 01921",
                    "01929.02", "01441 | 01929.01", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""),
         scientific_name = c("", "Cocos nucifera", "Gossypium spp.",
                             "Canabis sativa", "Linum usitatissimum", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""),
         wiki_id = c("Q64597240 | Q155867", "Q3342808", "Q11457",
                     "Q26726 | Q7150699 | Q13414920", "Q911332", "Q267749",
                     "Q131748 | Q146202 | Q504781", "Q110009144", "Q80531 | Q12047207", "Q3406628 | Q23485",
                     "Q434 | Q13099586", "Q131584 | Q130201", "Q177932", "Q156625 | Q104413623",
                     "Q2763698 | Q12000036", "Q104212650 | Q50839003", "Q11006", "Q26949 | Q171497 | Q1076906",
                     "Q1201089", "Q2699247 | Q2094522"),
         life_form = c("forb", "tree", "tree", "forb", "forb", "forb", "forb", "forb", "tree", "tree", "forb",
                       "forb", "forb", "forb", "forb", "tree", "forb", "forb", "tree", "tree"),
         use_typ = c("medicinal | food", "food | fibre", "food | fibre", "food | fibre",
                     "food | fibre | industrial", "food", "food", "food", "food | industrial", "food", "food",
                     "food | recreation", "food", "food | industrial", "food", "food", "food", "food",
                     "industrial", "industrial"),
         used_part = c("", "fruit | husk", "seed | lint",
                       "", "seed | bast | seed", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""),
         persistence = c("temporary", "permanent", "permanent", "temporary", "temporary", "temporary",
                         "temporary", "temporary", "permanent", "permanent", "temporary", "temporary",
                         "temporary", "temporary", "temporary", "permanent", "temporary", "temporary",
                         "permanent", "permanent")),
  tibble(concept = c("cocoa beans", "coffee", "mate", "tea"),
         broader = class$concept[31],
         icc_11 = c(),
         cpc_21 = c(),
         scientific_name = c(),
         wiki_id = c("Q208008", "Q8486", "Q81602 | Q5881191", "Q101815 | Q6097"),
         life_form = c("tree", "shrub", "shrub", "shrub"),
         use_typ = c("food | recreation"),
  used_part = c(""),
         persistence = c("permanent")),
  tibble(concept = c("anise", "badian", "cannella cinnamon", "caraway", "cardamon", "chillies and peppers", "clove", "coriander", "cumin", "fennel", "ginger", "hop", "juniper berry", "mace", "malaguetta pepper", "nutmeg", "pepper", "vanilla", "lavendar"),
         broader = class$concept[32],
         icc_11 = c(),
         cpc_21 = c(),
         scientific_name = c(),
         wiki_id = c("Q28692", "Q1760637", "Q28165 | Q370239", "Q26811", "Q14625808", "Q165199 | Q201959 | Q1380", "Q15622897", "Q41611 | Q20856764", "Q57328174 | Q132624", "Q43511 | Q27658833", "Q35625 | Q15046077", "Q104212", "Q3251025", "Q1882876", "Q3312331", "Q12104", "Q311426", "Q162044", "Q42081"),
         life_form = c("forb", "forb", "forb", "forb", "forb", "forb", "tree", "forb", "forb", "forb", "forb", "forb", "shrub", "tree", "forb", "tree", "forb", "forb", "forb"),
         use_typ = c("food", "food", "food", "food", "food", "food", "food", "food", "food", "food", "food", "food", "food", "food | fibre", "food", "food", "food", "food", "food"),
         used_part = c(""),
         persistence = c("temporary", "temporary", "permanent", "temporary", "permanent", "temporary", "permanent", "temporary", "temporary", "temporary", "permanent", "permanent", "permanent", "permanent", "temporary", "permanent", "permanent", "permanent", "permanent")),
  tibble(concept = c("stevia"),
         broader = class$concept[34],
         icc_11 = c(),
         cpc_21 = c(),
         scientific_name = c(),
         wiki_id = c("Q312246 | Q3644010"),
         life_form = c("forb"),
         use_typ = c("food"),
         used_part = c(""),
         persistence = c("temporary")),
  tibble(concept = c("sugar beet"),
         broader = class$concept[21],
         icc_11 = c("8.01"),
         cpc_21 = c("01801 | 01919.06"),
         scientific_name = c("Beta vulgaris"),
         wiki_id = c("Q151964"),
         life_form = c("forb"),
         use_typ = c("food | fodder"),
         used_part = c("root | leaves"),
         persistence = c("temporary")),
  tibble(concept = c("sugar cane"),
         broader = class$concept[36],
         icc_11 = c(),
         cpc_21 = c(),
         scientific_name = c(),
         wiki_id = c("Q36940 | Q3391243"),
         life_form = c("graminoid"),
         use_typ = c("food"),
         used_part = c(""),
         persistence = c("temporary")),
  tibble(concept = c("cantaloupe", "cucumber", "eggplant", "gherkin", "gourd", "melon", "okra", "pumpkin", "squash", "tomato", "watermelon"),
         broader = class$concept[38],
         icc_11 = c(),
         cpc_21 = c(),
         scientific_name = c(),
         wiki_id = c("Q61858403 | Q477179", "Q2735883", "Q7540 | Q12533094", "Q23425", "Q7370671", "Q259438", "Q37083 | Q1621080", "Q165308 | Q5339301", "Q5339237 | Q7533", "Q20638126 | Q23501", "Q38645 | Q17507129"),
         life_form = c("forb"),
         use_typ = c("food", "food", "food", "food", "food", "food", "food", "fodder | food", "fodder | food", "food", "food"),
  used_part = c(""),
         persistence = c("temporary")),
  tibble(concept = c("artichoke", "asparagus", "bok choi", "broccoli", "brussels sprout", "cabbage", "cauliflower", "chicory", "chinese cabbage", "collard", "gai lan", "kale", "kohlrabi", "lettuce", "savoy cabbage", "spinach"),
         broader = class$concept[39],
         icc_11 = c(),
         cpc_21 = c(),
         scientific_name = c(),
         wiki_id = c("Q23041430", "Q2853420 | Q23041045", "Q18968514", "Q47722 | Q57544960", "Q150463 | Q104664711", "Q14328596", "Q7537 | Q23900272", "Q2544599 | Q1474", "Q13360268 | Q104664724", "Q146212 | Q14879985", "Q1677369 | Q104664699", "Q45989", "Q147202", "Q83193 | Q104666136", "Q154013", "Q81464"),
         life_form = c("forb"),
         use_typ = c("food", "food", "fodder | food", "food", "fodder | food", "fodder | food", "food", "food | recreation", "food", "food", "food", "food", "food", "food", "food", "food"),
  used_part = c(""),
         persistence = c("temporary")),
  tibble(concept = c("mushrooms"),
         broader = class$concept[40],
         icc_11 = c(),
         cpc_21 = c(),
         scientific_name = c(),
         wiki_id = c("Q654236"),
         life_form = c("mushroom"),
         use_typ = c("food"),
         used_part = c(""),
         persistence = c("temporary")),
  tibble(concept = c("carrot", "chive", "garlic", "leek", "onion", "turnip", "cassava | manioc | tapioca",
                     "potato", "sweet potato", "taro", "yam", "yautia"),
         broader = class$concept[41],
         icc_11 = c("2.03.01", "", "2.03.03", "2.03.05", "2.03.04", "2.03.02", "5.03", "", "", "", "", ""),
         cpc_21 = c("01251 | 01919.07", "", "01252", "01254", "01253", "01251 | 01919.05", "01520", "", "", "", "", ""),
         scientific_name = c("Daucus carota ssp. sativa", "", "Allium sativum",
                             "Allium ampeloprasum | Allium porrum", "Allium cepa",
                             "Brassica rapa", "Manihot esculenta", "", "", "", "", ""),
         wiki_id = c("Q81 | Q11678009","Q5766863", "Q23400 | Q21546392", "Q1807269", "Q13191", "Q3916957 | Q3384", "Q43304555 | Q83124", "Q16587531 | Q10998", "Q37937", "Q227997", "Q8047551 | Q71549", "Q763075"),
         life_form = c("forb"),
         use_typ = c("food | forage", "food", "food", "food", "food", "food | forage", "food", "food", "food", "food", "food", "food"),
         used_part = c(""),
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
https://stats.fao.org/caliper/browse/skosmos/ICC11/en/
https://stats.fao.org/caliper/browse/skosmos/cpc21/en/

Crop name _ Botanical name _ ICC 1.0 Code _ ICC 1.1 Code _ Code CPC
Almond Prunus dulcis 361 3.06.01 01371
Angelica stems Angelica archangelica 6229 6.02.02.90 01690
Anise seeds Pimpinella anisum 6212 6.02.01.02 01654
Apricot Prunus armeniaca 352 3.05.02 01343
Areca (betel nut) Areca catechu 992 3.06.08 01379.01
Arracha Arracacia xanthorrhiza 59 5.90 01599
Arrowroot Maranta arundinacea 59 5.90 01599
Artichoke Cynara scolymus 211 2.01.01 01216
Asparagus Asparagus officinalis 212 2.01.02 01211
Avocado Persea americana 311 3.01.01 01311

Bajra (Pearl millet) Pennisetum americanum 18 1.08 0118
Bambara bean Voandzeia subterranea or Vigna subterranea 79 7.09 01708
Banana Musa sapientum, M. cavendishii, M.nana 3.01.02 3.01.02 01312
Barley Hordeum vulgare 15 1.05 0115
Bay leaves Laurus nobilis, 6229 6.02.02.90 01690
Basil Ocimum basilicum 931 9.03.01.02 01690
Beans, dry, edible, for grains Phaseolus vulgaris 71 7.01 01701
Beans, harvested green Phaseolus and Vigna spp. 71 7.01 01701
Beet, fodder (mangel) Beta vulgaris 81 8.01 01919.01
Beet, red Beta vulgaris 81 8.01 01801
Bergamot Citrus bergamia 329 3.02.90 01329
Betel nut Areca catechu 992 9.90.02 01379
Black pepper Piper nigrum 6221 6.02.02.01 01651
Blackberries of various species Rubus spp. 349 3.04.90 01353.02
Brazil nut Bertholletia excelsa 369 3.06.07 01377
Breadfruit Artocarpus altilis 319 3.01.90 01319
Broad bean, dry Vicia faba 72 7.02 01702
Broad bean, harvested green Vicia faba 72 7.02 01702
Broccoli Brassica oleracea var. botrytis 214 2.01.04 01213
Broom millet Sorghum bicolor 18 1.08 0118
Broom sorghum Sorghum bicolor 14 1.04 0114
Brussels sprouts Brassica oleracea var. gemmifera 219 2.01.90 01212
Buckwheat Fagopyrum esculentum 192 1.10 01192

Cabbage (red, white, Savoy) Brassica oleracea var. capitata 213 2.01.03 01212
Cabbage, Chinese Brassica chinensis 213 2.01.03 01212
Cabbage, for fodder Brassica spp. 213 2.01.03 01919.10
Cacao (cocoa) Theobroma cacao 614 6.01.04 0164
Cantaloupe Cucumis melo 225 2.02.05 01229
Caraway seeds Carum carvi 6219 6.02.01.90 01654
Cardamom Elettaria cardamomum 6222 6.02.02.02 01653
Cardoon Cynara cardunculus 219 2.01.90 01219
Cashew nuts Anacardium occidentale 362 3.06.02 01372
Castor bean Ricinus communis 431 4.03.01 01449
Cauliflower Brassica oleracea var. botrytis 214 2.01.04 01213
Celeriac Apium graveolens var. rapaceum 239 2.03.90 01259
Celery Apium graveolens 219 2.01.90 01290
Chayote Sechium edule 229 2.02.90 01239.90
Cherry Prunus avium,, cerasus avium 353 3.05.03 01344.02
Chestnut Castanea sativa 363 3.06.03 01373
Chickpea (gram pea) Cicer arietinum 73 7.03 01703
Chicory Cichorium intybus 217 2.01.07 01214
Chicory for greens Cichorium intybus 217 2.01.07 01214
Chili, dry (all varieties) Capsicum spp. (annuum) 6211 6.02.01.01 01652
Chili, fresh (all varieties) Capsicum spp. (annuum) 6211 6.02.01.01 01652
Cinnamon Cinnamomum verum 6223 6.02.02.03 01655
Citron Citrus medica 329 3.02.90 01329
Citronella Cymbopogon citrates/ Cymbopogon nardus 992 9.90.02 35410.01
Clementine Citrus reticulata 324 3.02.04 01324.02
Clove Eugenia aromatica (Syzygium aromaticum) 6224 6.02.02.04 01656
Coca Erythroxypum novogranatense, E. coca 932 9.03.02.02 01930
Cocoa (cacao) Theobroma cacao 614 6.01.04 0164
Coconut Cocos nucifera 441 4.04.01 0146
Cocoyam Colocasia esculenta 59 5.90 01599
Coffee Coffea spp. 611 6.01.01 0161
Cola nut (all varieties) Cola acuminata; C. nitida; C.vera 619 3.06.09 03230
Colza (rapeseed) Brassica napus 435 4.03.05 01443
Corn (maize) for cereals Zea mays 12 1.02 01121
Corn (maize) for silage Zea mays 12 1.02 01121
Corn (sweet) for vegetable Zea mays 12 1.02 01290
Corn for salad Valerianella locusta 219 2.01.90 01219
Cowpea, for grain Vigna unguiculata 74 7.04 01706
Cowpea, harvested green Vigna unguiculata 74 7.04 01706
Cress Lepidium sativum 219 2.01.90 01219
Cucumber Cucumis sativus 221 2.02.01 01232
Custard apple Annona reticulate 319 3.01.90 01319

Dasheen Colocasia esculenta 59 5.90 01599
Date Phoenix dactylifera 313 3.01.03 01314
Dill and dill seed Anethum graveoles 6229 6.02.02.90 01690
Drumstick tree Moringa oleifera 6229 6.02.02.90 01690
Durra (sorghum) Sorghum bicolour 14 1.04 01142
Durum wheat Triticum durum 11 1.01 01111

Earth pea Vigna subterranea 79 7.90 01709
Edo (eddoe) Xanthosoma spp.; Colocasia spp. 59 5.90 01599
Eggplant Solanum melongena 222 2.02.02 01233
Endive Cichorium endivia 219 2.01.90 01214

Fennel Foeniculum vulgare 219 6.02.01.02 01290
Fenugreek Trigonella foenum-graecum 79 7.90 01690
Fig Ficus carica 314 3.01.05 01315
Filbert (hazelnut) Corylus avellana 364 3.06.04 01374
Fique Furcraea macrophylla 9219 9.02.01.90 01929
Flax for oil seed (linseed) Linum usitatissimum 9213 9.02.01.04 01929.01
Fonio Digitaria exilis; D. iburua 192 1.11 01193
Formio (New Zealand flax) Phormium tenax 9214 9.02.01.04 01929

Geranium Pelargonium spp.; Geranium spp. 931 9.03.01 01930
Ginger Zingiber officinale 6225 6.02.02.05 01657
Ginseng Panax spp. 932 9.03.02.01 01930
Gourd Lagenaria spp; Cucurbita spp. 226 2.02.90 01235
Gram pea (chickpea) Cicer arietinum 73 7.03 01703
Grape Vitis vinifera 33 3.03 0133
Grapefruit Citrus paradisi 321 3.02.01 01321
Grapes for raisins Vitis vinifera 33 3.03 01330
Grapes for table use Vitis vinifera 33 3.03 01330
Grapes for wine Vitis vinifera 33 3.03 01330
Grass esparto Lygeum spartum 991 9.90.01 01929
Grass, orchard Dactylis glomerata 911 9.01.01 01919
Grass, Sudan Sorghum bicolour var. Sudanense 911 9.01.01 01919
Groundnut (peanut) Arachis hypogaea 42 4.02 0142
Guarana Paulinia cupana 932 9.03.02.04 01690
Guava Psidium guajava 319 3.01.06 01316.02
Guinea corn (sorghum) Sorghum bicolor 14 1.04 0114
Guinea pepper Afframomum melegueta, piper guineense, xylopia aethiopica 6229 6.02.02.90 01690

Hazelnut (filbert) Corylus avellana 364 3.06.04 01374
Hemp, sun Crotalaria juncea 9213 9.02.01.05 01922
Henequen Agave fourcroydes 922 9.02.02 01929
Henna Lawsonia inermis 911 9.01.01 03250
Hop Humulus lupulus 619 6.02.02.07 01659
Horse bean Vicia faba 72 7.02 01702
Horseradish Armoracia rusticana 239 2.03.90 01259
Hybrid maize Zea mays 12 1.02 01121

Indigo Indigofera tinctoria 991 9.90.01 03250

Jasmine Jasminum spp. 952 9.05.02 01620
Jerusalem artichoke Helianthus tuberosus 211 2.01.01 01599
Jojoba Simmondsia californica or S. chinensis 449 4.03.11 01499.03
Jowar (sorghum) Sorghum bicolor 14 1.04 0114

Kale Brassica oleracea var. Acephala 219 2.01.90 01212
Kava Piper methysticum 932 9.03.02.03 01690
Kohlrabi Brassica oleracea var. gongylodes 239 2.03.90 01212
Kola nut see Cola nut 619 3.06.09 01379.02

Lavender Lavandula spp. (over 15 sp.) 931 9.03.01 01930
Lemon Citrus limon 322 3.02.02 01322
Lemon grass Cymbopogon citratus 922 9.02.02 35410
Lentil Lens culinaris 75 7.05 01704
Lespedeza (all varieties) Lespedeza spp. 911 9.01.01 01919
Lettuce Lactuca sativa var. capitata 215 2.01.05 01214
Lime, sour Citrus aurantifolia 322 3.02.02 01322
Lime, sweet Citrus limetta 322 3.02.02 01322
Linseed (flax for oil seed) Linum usitatissimum 432 4.03.02 01441
Liquorice Glycyrrhiza glabra 931 9.03.01 01930
Litchi Litchi chinensis 319 3.01.90 01319
Loquat Eriobotrya japonica 359 3.05.90 01359

Macadamia (Queensland nut) Macadamia spp. ternifolia 369 3.06.90 01379
Mace Myristica fragrans 6222 6.02.02.02 01653
Maguey Agave atrovirens 922 9.02.02 01929
Maize (corn) Zea mays 12 1.02 0112
Maize (corn) for silage Zea mays 12 1.02 0112
Maize (hybrid) Zea mays 12 1.02 0112
Maize, ordinary Zea mays 12 1.02 0112
Mandarin Citrus reticulata 324 3.02.04 01324
Mangel (fodder beet) Beta vulgaris 81 8.01 01919.01
Mango Mangifera indica 315 3.01.06 01316.01
Mangosteen/Mangostano Garcinia mangostana 315 3.01.06 01316.03
Maslin (mixed cereals) Mixture of Triticum spp.; Secale cereale 191 1.14 01199.02
Medlar Mespilus germanica 359 3.05.90 01359
Melon (except watermelon) Cucumis melo 225 2.05.02 01229
Millet broom Sorghum bicolor 18 1.08 0118
Millet, bajra Pennisetum americanum 18 1.08 0118
Millet, bulrush Pennisetum americanum 18 1.08 0118
Millet, finger Eleusine coracana 18 1.08 0118
Millet, foxtail Setaria italica 18 1.08 0118
Millet, Japanese Echinochloa esculenta 18 1.08 0118
Millet, pearl (bajra, bulrush) Pennisetum americanum 18 1.08 0118
Millet, proso Panicum miliaceum 18 1.08 0118
Mint (all varieties) Mentha spp. 6219 9.03.01.01 01930
Mulberry for fruit (all varieties) Morus spp. 39 3.90 01343
Mulberry for silkworms Morus alba 39 3.90 01343
Mushrooms Agaricus spp.; Pleurotus spp.; Volvariella 24 2.04 0127
Mustard Brassica nigra; Sinapis alba 433 4.03.03 01442

Nectarine Prunus persica var. nectarina 354 3.05.05 01355
New Zealand flax (formio) Phormium tenax 922 9.02.01.04 01929
Niger seed Guizotia abyssinica 434 4.03.04 01929
Nutmeg Myristica fragrans 6222 6.02.02.02 01653

Oats, for fodder Avena spp. (about 30 sp.) 17 1.07 01919.92
Oats, for grain Avena spp. (about 30 sp.) 17 1.07 0117
Oil palm Elaeis guineensis 443 4.04.03 01491
Okra Abelmoschus esculentus; Hibiscus esculentus 229 2.02.05 01239.01
Olive Olea europaea 442 4.04.02 0145
Opium Papaver somniferum 931 9.03.01 01930
Orange Citrus sinensis 323 3.02.03 01323
Orange, bitter Citrus aurantium 323 3.02.03 01323
Ornamental plants Various 951 9.05.01 0196

Palm palmyra Borassus flabellifer 992 9.09.02 03250
Palm, kernel oil Elaeis guineensis 443 4.04.03 01491.02
Palm, oil Elaeis guineensis 443 4.04.03 01491.01
Palm, sago Metroxylon sagu 992 9.09.02 23230
Papaya (pawpaw) Carica papaya 316 3.01.07 01317
Parsnip Pastinaca sativa 239 2.03.90 01259
Pea, edible dry, for grain Pisum sativum 77 7.07 01705
Pea, harvested green Pisum sativum 77 7.07 01705
Peach Prunus persica 354 3.05.05 01355
Peanut (groundnut) Arachis hypogaea 42 4.02 0142
Pecan nut Carya illinoensis 369 3.06.90 01379
Pepper, black Piper nigrum 6221 6.02.02.01 01651
Pepper, dry Capsicum spp. (over 30 sp.) 6211 6.02.01.01 01652
Persimmon Diospyros kaki; Diospyros virginiana 319 3.01.90 01359.01
Pigeon pea Cajanus cajan 78 7.08 01707
Pineapple Ananas comosus 317 3.01.08 01318
Pistachio nut Pistacia vera 365 3.06.05 01375
Plantain Musa paradisiaca 312 3.01.03 01313.01
Plum Prunus domestica 356 3.05.08 01356
Pomegranate Punica granatum 39 3.90 01399
Pomelo Citrus grandis 321 3.02.01 01321
Poppy seed Papaver somniferum 439 4.03.12 01448
Poppy straw Papaver somniferum 931 9.03.01.02 01930
Potato Solamum tuberosum 51 5.01 0151
Potato, sweet Ipomoea batatas 52 5.02 01591
Prune Prunus domestica 356 3.05.08 21412
Pumpkin, edible Cucurbita spp. (over 25 sp.) 226 2.02.04 01235
Pumpkin, for fodder Cucurbita spp. (over 25 sp.) 226 2.02.04 01919.11
Pyrethum Chrysanthemum cinerariaefolium 991 9.90.01 01930.02

Quebracho Aspidosperma spp. (more than 3 sp.) 992 9.90.02 03250
Queensland nut See Macadamia 369 3.06.90 01379
Quinine Cinchona spp. (more than 6 sp.) 932 9.03.02 01930
Quinoa Chenopodium quinoa 192 1.12 01194

Radish Raphanus sativus (inc. Cochlearia armoracia) 239 2.03.90 01259
Rapeseed (colza) Brassica napus 435 4.03.05 01443
Red beet Beta vulgaris 81 8.01 01801
Redtop Agrostis spp. 911 9.01.01 01919
Rhea Boehmeria nivea 922 9.02.02 26190
Rhubarb Rheum spp. 219 2.01.90 01219
Rice Oryza sativa; Oryza glaberrima 13 1.03 0113
Rose Rose spp. 952 9.05.02 01930
Rubber Hevea brasiliensis 94 9.04 01950
Rutabaga (swede) Brassica napus var. napobrassica 239 2.03.90 01919
Rye Secale cereale 16 1.06 0116
Ryegrass seed Lolium spp. (about 20 sp.) 991 9.90.01 01919.05

Safflower Carthamus tinctorius 436 4.03.06 01446
Saffron Crocus savitus 6229 6.02.02.90 01690
Sainfoin Onobrychis viciifolia 911 9.01.01 01919
Salsify Tragopogon porrifolius 239 2.03.90 01259
Sapodilla Achras sapota 39 3.90 01319
Satsuma (mandarin/tangerine) Citrus reticulata 324 3.02.04 01324
Scorzonera (black salsify) Scorzonera hispanica 239 2.03.90 01259
Sesame Sesamum indicum 437 4.03.07 01444
Shea tree (shea butter or karite nut) Vitellaria paradoxa or Butyrospermum parkii 449 4.03.09 01499.01
Sisal Agave sisalana 922 9.02.02.02 01929.04
Sorghum Sorghum bicolor 14 1.04 0114
Sorghum, broom Sorghum bicolor 14 1.04 0114
Sorghum, durra Sorghum bicolor 14 1.04 0114
Sorghum, Guinea corn Sorghum bicolor 14 1.04 0114
Sorghum, jowar Sorghum bicolor 14 1.04 0114
Sorghum, sweet Sorghum bicolor 183 8.03 01809
Sour cherry Prunus cerasus, cerasus acida 353 3.05.03 01344.01
Soybean Glycine max 41 4.01 0141
Soybean hay Glycine max 41 4.01 0141
Spelt wheat Triticum spelta 192 Spinach Spinacia oleracea 216 2.01.06 01215
Squash Cucurbita spp. (over 25 sp.) 226 2.02.04 01235
Sugar cane for fodder Saccharum officinarum 82 8.02 01919.92
Sugar cane for sugar or alcohol Saccharum officinarum 82 8.02 01802
Sugar cane for thatching Saccharum officinarum 82 8.02 01802
Sunflower for fodder Helianthus annuus 438 4.03.08 01919.92
Sunflower for oil seed Helianthus annuus 438 4.03.08 01445
Sunhemp Crotalaria juncea 9213 9.02.01.05 01922
Swede Brassica napus var. napobrassica 239 2.03.90 01919
Swede for fodder Brassica napus var. napobrassica 239 2.03.90 01919.02
Sweet corn Zea mays 12 1.02 01290
Sweet lime Citrus limetta 322 3.02.02 01322
Sweet pepper Capsicum annuum 6211 6.02.02.01 01231
Sweet potato Lopmoea batatas 52 5.02 01591
Sweet sorghum Sorghum bicolor 183 8.03 01809

Tallow tree Shorea aptera; S. stenocarpa; Sapium sebiferum;
449
Stillingia sebifera 4.03.13 01499.04
Tangerine Citrus reticulata 324 3.02.04 01324.01
Tannia Xanthosoma sagittifolium 59 5.90 01599
Taro Colocasia esculenta 59 5.05 01599
Tea Camellia sinensis 612 6.01.02 0162
Tef Eragrostis abyssinica 192 1.90 01199.01
Thymus Thymus vulgaris 6229 6.02.02.90 01690
Timothy Phleum pratense 911 9.01.01 01940
Tobacco Nicotiana tabacum 96 9.06 0197
Tomato Lycopersicon esculentum 223 2.02.03 01234
Trefoil Lotus spp. (about 100 sp.) 991 9.90.01 01929
Triticale Hybrid of Triticum aestivum and Secale cereale 17 1.09 01191
Tung tree Aleurites spp.; Fordii 449 4.03.10 01499.02
Turmeric Curcuma longa 6229 6.02.02.90 01690

Urena (Congo jute) Urena lobata 9214 9.02.01.02 01922

Vanilla Vanilla planifolia 6226 6.02.02.06 01658
Vetches Vicia sativa 79 7.10 01709.01

Walnut Juglans spp. (over 20 sp.), ep. regia 366 3.06.06 01376
Watermelon Citrullus lanatus 224 2.05.01 01221
Wheat Triticum aestivum 11 1.01 0111

Yam Dioscorea spp. (over 120 sp.) 54 5.04 01593
Yautia Xanthosoma sagittifolium 59 5.06 01599
Yerba mate Ilex paraguariensis 613 6.01.03 01630

## FAO Indicative Crop Classification (ICC) version 1.1
luckiOnto <- new_source(name = "icc_11",
                        date = Sys.Date(),
                        description = "The official version of the Indicative Crop Classification was developed for the 2020 round of agricultural censuses.",
                        homepage = "https://stats.fao.org/caliper/browse/skosmos/ICC11/en/",
                        uri_prefix = "https://stats.fao.org/caliper/browse/skosmos/ICC11/en/page/",
                        license = "",
                        ontology = luckiOnto)

luckiOnto <- new_mapping()

## FAO Central Product Classification (CPC) version 2.1
luckiOnto <- new_source(name = "cpc_21",
                        date = Sys.Date(),
                        description = "The Central Product Classification (CPC) v2.1",
                        homepage = "https://stats.fao.org/caliper/browse/skosmos/cpc21/en/",
                        uri_prefix = "",
                        license = "",
                        ontology = luckiOnto)

luckiOnto <- new_mapping()

## Scientific Botanical name
luckiOnto <- new_source(name = "scientific_name",
                        date = Sys.Date(),
                        description = "",
                        homepage = "",
                        uri_prefix = "",
                        license = "",
                        ontology = luckiOnto)

luckiOnto <- new_mapping()

## wikidata ----
luckiOnto <- new_source(name = "wikidata",
                        date = Sys.Date(),
                        description = "Wikidata is a free, collaborative, multilingual, secondary database, collecting structured data to provide support for Wikipedia, Wikimedia Commons, the other wikis of the Wikimedia movement, and to anyone in the world.",
                        homepage = "https://www.wikidata.org/",
                        uri_prefix = "https://www.wikidata.org/wiki/",
                        license = "CC0",
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = attributes$wiki_id,
                         target = get_concept(table = attributes %>% select(label = concept), ontology = luckiOnto),
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

luckiOnto <- new_mapping(new = attributes$persistence,
                         target = get_concept(table = attributes %>% select(label = concept), ontology = luckiOnto),
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

lut_lifeForm <- tibble(label = c("graminoid", "tree", "herb", "shrub", "forb"),
                       description = "")

luckiOnto <- new_mapping(new = attributes$life_form,
                         target = get_concept(table = attributes %>% select(label = concept), ontology = luckiOnto),
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
                                      "animals that is used for labor"))

luckiOnto <- new_mapping(new = attributes$use_typ,
                         target = get_concept(table = attributes %>% select(label = concept), ontology = luckiOnto),
                         source = "use-type", match = "close", certainty = 3,
                         lut = lut_useType,
                         ontology = luckiOnto)


# workaround to insert description to external concepts/attributes
#
lut <- lut_useType, lut_persistence)

luckiOnto@concepts$external <- left_join(luckiOnto@concepts$external, lut, by = "label") %>%
  mutate(description = if_else(is.na(description.x), description.y, description.x)) %>%
  select(id, label, has_broader, description, has_source)

# write output ----
#
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))
export_as_rdf(ontology = luckiOnto, filename = paste0(dataDir, "tables/luckiOnto.ttl"))
