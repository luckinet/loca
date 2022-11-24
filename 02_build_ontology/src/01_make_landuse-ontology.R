# script arguments ----
#
message("\n---- build landuse ontology ----")


# load data ----
#

revise all descriptions, use the same terms throughout, for example for when I talk about commodities
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

# define new classes
luckiOnto <- new_class(new = "domain", target = NA,
                       description = "the type of description system", ontology = luckiOnto) %>%
  new_class(new = "landcover group", target = "domain",
            description = "groups of landcover concepts", ontology = .) %>%
  new_class(new = "landcover", target = "landcover group",
            description = "concepts that describe the general type of the land surface cover", ontology = .) %>%
  new_class(new = "land use", target = "landcover",
            description = "concepts that describe the socio-economic dimension (how land is used) of the land surface cover", ontology = .) %>%
  new_class(new = "group", target = "domain",
            description = "broad groups of concepts that describe crop and livestock commodities", ontology = .) %>%
  new_class(new = "class", target = "group",
            description = "classes or types of concepts that describe crop and livestock commodities", ontology = .) %>%
  new_class(new = "aggregate", target = "class",
            description = "aggregates of (commodities that often occurr together) concepts that describe crop and livestock commodities", ontology = .) %>%
  new_class(new = "commodity", target = "class",
            description = "concepts that describe crop or livestock commodities",  ontology = .)

# define the harmonized concepts
domain <- tibble(new = c("surface types", "production systems"),
                 description = c("land use and landcover concepts describing the surface of the earth",
                                 "production systems described by the crop or livestock commodities grown there"))

luckiOnto <- new_concept(new = domain$new,
                         description = domain$description,
                         class = "domain",
                         ontology =  luckiOnto)

message("     landcover group")
lcGroup <- tibble(concept = c(
  "ARTIFICIAL SURFACES",
  "AGRICULTURAL AREAS",
  "FOREST AND SEMI-NATURAL AREAS",
  "WETLANDS",
  "WATER BODIES"),
  broader = "surface types")

luckiOnto <- new_concept(new = lcGroup$concept,
                         broader = get_concept(table = lcGroup %>% select(label = broader), ontology = luckiOnto),
                         class = "landcover group",
                         ontology =  luckiOnto)

message("     landcover")
lc <- tibble(concept = c(
  "Urban fabric",
  "Industrial, commercial and transport units",
  "Mine, dump and construction sites",
  "Artificial, non-agricultural vegetated areas",
  "Temporary cropland",
  "Permanent cropland",
  "Heterogeneous agricultural areas",
  "Forests",
  "Other Wooded Areas",
  "Shrubland",
  "Herbaceous associations",
  "Heterogeneous semi-natural areas",
  "Open spaces with little or no vegetation",
  "Inland wetlands",
  "Marine wetlands",
  "Inland waters",
  "Marine waters"),
  broader = c(rep(lcGroup$concept[1], 4), rep(lcGroup$concept[2], 3),
             rep(lcGroup$concept[3], 6), rep(lcGroup$concept[4], 2),
             rep(lcGroup$concept[5], 2)))

luckiOnto <- new_concept(new = lc$concept,
                         broader = get_concept(table = lc %>% select(label = broader), ontology = luckiOnto),
                         class = "landcover",
                         ontology =  luckiOnto)

message("     land use")
lu <- tibble(concept = c(
  "Fallow",
  "Herbaceous crops",
  "Temporary grazing",
  "Permanent grazing",
  "Shrub orchards",
  "Palm plantations",
  "Tree orchards",
  "Woody plantation",
  "Protective cover",
  "Agroforestry",
  "Mosaic of agricultural-uses",
  "Mosaic of agriculture and natural vegetation",
  "Undisturbed Forest",
  "Naturally Regenerating Forest",
  "Planted Forest",
  "Temporally Unstocked Forest"),
  broader = c(rep(lc$concept[5], 3), rep(lc$concept[6], 6),
             rep(lc$concept[7], 3), rep(lc$concept[8], 4)))

luckiOnto <- new_concept(new = lu$concept,
                         broader = get_concept(table = lu %>% select(label = broader), ontology = luckiOnto),
                         class = "land use",
                         ontology =  luckiOnto)

message("     crop and livestock concepts")
group <- tibble(concept = c(
  "BIOENERGY CROPS",
  "FIBRE CROPS",
  "FLOWER CROPS",
  "FODDER CROPS",
  "FRUIT",
  "GUMS",
  "MEDICINAL CROPS",
  "SEEDS",
  "STIMULANTS",
  "SUGAR CROPS",
  "VEGETABLES",
  "BIRDS",
  "GLIRES",
  "UNGULATES",
  "INSECTS"),
  broader = "production systems")

luckiOnto <- new_concept(new = group$concept,
                         broader = get_concept(table = group %>% select(label = broader), ontology = luckiOnto),
                         class = "group",
                         ontology = luckiOnto)

class <- tibble(
  concept = c("Herbaceous biomass", "Woody biomass", "Other bioenergy crops"),
  broader = group$concept[1]) %>%
  bind_rows(tibble(
    concept = c("Bast fibre", "Leaf fibre", "Seed fibre", "Other fibre crops"),
    broader = group$concept[2])) %>%
  bind_rows(tibble(
    concept = c("Herbaceous flowers", "Tree flowers", "Other flower crops"),
    broader = group$concept[3])) %>%
  bind_rows(tibble(
    concept = c("Grass crops", "Fodder legumes", "Other fodder crops"),
    broader = group$concept[4])) %>%
  bind_rows(tibble(
    concept = c("Berries", "Citrus Fruit", "Grapes", "Pome Fruit", "Stone Fruit",
                "Tropical and subtropical Fruit", "Other fruit"),
    broader = group$concept[5])) %>%
  bind_rows(tibble(
    concept = c("Rubber", "Other gums"),
    broader = group$concept[6])) %>%
  bind_rows(tibble(
    concept = c("Medicinal herbs", "Medicinal fungi", "Other medicinal crops"),
    broader = group$concept[7])) %>%
  bind_rows(tibble(
    concept = c("Cereals", "Leguminous seeds", "Treenuts", "Oilseeds",
                "Other seeds"),
    broader = group$concept[8])) %>%
  bind_rows(tibble(
    concept = c("Stimulant crops", "Spice crops", "Other stimulants"),
    broader = group$concept[9])) %>%
  bind_rows(tibble(
    concept = c("Leave sugar crops", "Root sugar crops", "Sap sugar crops", "Other sugar crops"),
    broader = group$concept[10])) %>%
  bind_rows(tibble(
    concept = c("Fruit-bearing vegetables", "Leaf or stem vegetables",
                "Mushrooms and truffles", "Root vegetables",
                "Other vegetables"),
    broader = group$concept[11])) %>%
  bind_rows(tibble(
    concept = c("Poultry Birds", "Other birds"),
    broader = group$concept[12])) %>%
  bind_rows(tibble(
    concept = c("Lagomorphs", "Rodents", "Other glires"),
    broader = group$concept[13])) %>%
  bind_rows(tibble(
    concept = c("Bovines", "Camelids", "Equines", "Pigs", "Other ungulates"),
    broader = group$concept[14])) %>%
  bind_rows(tibble(
    concept = c("Food producing", "Fibre producing", "Other insects"),
    broader = group$concept[15]))

luckiOnto <- new_concept(new = class$concept,
                         broader = get_concept(table = class %>% select(label = broader), ontology = luckiOnto),
                         class = "class",
                         ontology =  luckiOnto)

commodity <- tibble(
  concept = c("bamboo", "giant reed", "miscanthus", "reed canary grass",
              "switchgrass"),
  broader = class$concept[1]) %>%
  bind_rows(tibble(
    concept = c("acacia", "black locust", "eucalyptus", "poplar", "willow"),
    broader = class$concept[2])) %>%
  bind_rows(tibble(
    concept = c("hemp", "jute", "kenaf", "ramie"),
    broader = class$concept[4])) %>%
  bind_rows(tibble(
    concept = c("manila fibre", "sisal"),
    broader = class$concept[5])) %>%
  bind_rows(tibble(
    concept = c("cotton", "kapok"),
    broader = class$concept[6])) %>%
  bind_rows(tibble(
    concept = c("alfalfa"),
    broader = class$concept[11])) %>%
  bind_rows(tibble(
    concept = c("clover", "lupin"),
    broader = class$concept[12])) %>%
  bind_rows(tibble(
    concept = c("blueberry", "cranberry", "currant", "gooseberry", "kiwi fruit",
                "raspberry", "strawberry"),
    broader = class$concept[14])) %>%
  bind_rows(tibble(
    concept = c("clementine", "grapefruit", "lemon", "lime", "mandarine",
                "orange", "pomelo", "satsuma", "tangerine"),
    broader = class$concept[15])) %>%
  bind_rows(tibble(
    concept = c("grape"),
    broader = class$concept[16])) %>%
  bind_rows(tibble(
    concept = c("apple", "pear", "quince"),
    broader = class$concept[17])) %>%
  bind_rows(tibble(
    concept = c("apricot", "cherry", "nectarine", "peach", "plum", "sloe",
                "sour cherry"),
    broader = class$concept[18])) %>%
  bind_rows(tibble(
    concept = c("açaí", "avocado", "banana", "date", "fig", "guava", "mango",
                "mangosteen", "papaya", "persimmon", "pineapple", "plantain"),
    broader = class$concept[19])) %>%
  bind_rows(tibble(
    concept = c("natural gums", "natural rubber"),
    broader = class$concept[21])) %>%
  bind_rows(tibble(
    concept = c("basil", "coca", "ginseng", "guarana", "kava", "mint",
                "peppermint", "tobacco"),
    broader = class$concept[23])) %>%
  bind_rows(tibble(
    concept = c("barley", "maize", "millet", "oat", "triticale", "buckwheat",
                "canary seed", "fonio", "quinoa", "rice", "rye", "sorghum",
                "wheat", "mixed cereals"),
    broader = class$concept[26])) %>%
  bind_rows(tibble(
    concept = c("bambara bean", "bean", "broad bean", "carob", "chickpea",
                "cow pea", "lentil", "pea", "pigeon pea", "string bean",
                "vetch"),
    broader = class$concept[27])) %>%
  bind_rows(tibble(
    concept = c("almond", "areca nut", "brazil nut", "cashew", "chestnut",
                "hazelnut", "kolanut", "pistachio", "walnut"),
    broader = class$concept[28])) %>%
  bind_rows(tibble(
    concept = c("castor bean", "coconut", "jojoba", "linseed", "mustard",
                "niger seed", "oil palm", "olive", "peanut", "poppy", "rapeseed",
                "safflower", "sesame", "shea nut", "soybean", "sunflower",
                "tallowtree", "tung nut"),
    broader = class$concept[29])) %>%
  bind_rows(tibble(
    concept = c("cocoa beans", "coffee", "mate", "tea"),
    broader = class$concept[31])) %>%
  bind_rows(tibble(
    concept = c("anise", "badian", "cannella cinnamon", "caraway", "cardamon",
                "chillies and peppers", "clove", "coriander", "cumin", "fennel",
                "ginger", "hop", "juniper berry", "mace", "malaguetta pepper",
                "nutmeg", "pepper", "vanilla", "lavendar"),
    broader = class$concept[32])) %>%
  bind_rows(tibble(
    concept = c("stevia"),
    broader = class$concept[34])) %>%
  bind_rows(tibble(
    concept = c("sugar beet"),
    broader = class$concept[35])) %>%
  bind_rows(tibble(
    concept = c("sugar cane"),
    broader = class$concept[36])) %>%
  bind_rows(tibble(
    concept = c("cantaloupe", "cucumber", "eggplant", "gherkin", "gourd",
                "melon", "okra", "pumpkin", "squash", "tomato", "watermelon"),
    broader = class$concept[38])) %>%
  bind_rows(tibble(
    concept = c("artichoke", "asparagus", "bok choi", "broccoli",
                "brussels sprout", "cabbage", "cauliflower", "chicory",
                "chinese cabbage", "collard", "gai lan", "kale", "kohlrabi",
                "lettuce", "savoy cabbage", "spinach"),
    broader = class$concept[39])) %>%
  bind_rows(tibble(
    concept = c("mushrooms"),
    broader = class$concept[40])) %>%
  bind_rows(tibble(
    concept = c("carrot", "chive", "garlic", "leek", "onion", "turnip",
                "cassava", "potato", "sweet potato", "taro", "yam", "yautia"),
    broader = class$concept[41])) %>%
  bind_rows(tibble(
    concept = c("partridge", "pigeon", "quail", "chicken", "duck", "goose",
                "turkey"),
    broader = class$concept[43])) %>%
  bind_rows(tibble(
    concept = c("hare", "rabbit"),
    broader = class$concept[45])) %>%
  bind_rows(tibble(
    concept = c("buffalo", "cattle", "goat", "sheep"),
    broader = class$concept[48])) %>%
  bind_rows(tibble(
    concept = c("alpaca", "camel", "guanaco", "llama", "vicugna"),
    broader = class$concept[49])) %>%
  bind_rows(tibble(
    concept = c("ass", "horse", "mule"),
    broader = class$concept[50])) %>%
  bind_rows(tibble(
    concept = c("pig"),
    broader = class$concept[51])) %>%
  bind_rows(tibble(
    concept = c("beehive"),
    broader = class$concept[53]))

luckiOnto <- new_concept(new = commodity$concept,
                         broader = get_concept(table = commodity %>% select(label = broader), ontology = luckiOnto),
                         class = "commodity",
                         ontology =  luckiOnto)

# define mappings to other ontologies/vocabularies
attributes <- tribble(
  ~concept,               ~wiki_id,               ~life_form,  ~persistence, ~use_typ,
  "bamboo",               "Q2157176",             "graminoid", "temporary",  "bioenergy | fibre | food",
  "giant reed",           "Q161114",              "graminoid", "temporary",  "bioenergy",
  "miscanthus",           "Q41692",               "graminoid", "temporary",  "bioenergy",
  "reed canary grass",    "Q157419",              "graminoid", "temporary",  "bioenergy",
  "switchgrass",          "Q1466543",             "graminoid", "temporary",  "bioenergy",
  "acacia",               "Q81666",               "tree",      "permanent",  "bioenergy | wood",
  "black locust",         "Q2019723",             "tree",      "permanent",  "bioenergy | wood",
  "eucalyptus",           "Q45669",               "tree",      "permanent",  "bioenergy | wood",
  "poplar",               "Q25356",               "tree",      "permanent",  "bioenergy | wood",
  "willow",               "Q36050",               "tree",      "permanent",  "bioenergy | wood",
  "barley",               "Q11577",               "graminoid", "temporary",  "forage | food",
  "maize",                "Q11575 | Q25618328",   "graminoid", "temporary",  "food | silage",
  "millet",               "Q131542",              "graminoid", "temporary",  "food",
  "oat",                  "Q165403 | Q4064203",   "graminoid", "temporary",  "food",
  "triticale",            "Q380329",              "graminoid", "temporary",  "food",
  "buckwheat",            "Q132734 | Q4536337",   "graminoid", "temporary",  "food",
  "canary seed",          "Q2086586",             "graminoid", "temporary",  "food",
  "fonio",                "Q1340738 | Q12439809", "graminoid", "temporary",  "food",
  "quinoa",               "Q104030862 | Q139925", "graminoid", "temporary",  "food",
  "mixed cereals",        NA,                     "graminoid", "temporary",  "food",
  "rice",                 "Q5090 | Q161426",      "graminoid", "temporary",  "food",
  "rye",                  "Q12099",               "graminoid", "temporary",  "food",
  "sorghum",              "Q105549747 | Q12111",  "graminoid", "temporary",  "food",
  "wheat",                "Q15645384 | Q161098 | Q618324", "graminoid",      "temporary",                     "food",
  "cotton",               "Q11457",               "herb",      "temporary",  "fibre",
  "hemp",                 "Q26726 | Q7150699 | Q13414920", "herb",           "temporary",                     "fibre | food",
  "jute",                 "Q107211",              "herb",      "temporary",  "fibre",
  "kapok",                "Q1728687",             "tree",      "permanent",  "fibre | food",
  "kenaf",                "Q1137540",             "herb",      "temporary",  "fibre",
  "manila fibre",         "Q203540",              "tree",      "permanent",  "fibre",
  "ramie",                "Q2130134 | Q750467",   "herb",      "temporary",  "fibre",
  "sisal",                "Q159221 | Q847423",    "tree",      "permanent",  "food",
  "alfalfa",              "Q156106",              "graminoid", "temporary",  "fodder",
  "clover",               NA,                     "herb",      "temporary",  "fodder",
  "blueberry",            "Q13178",               "shrub",     "temporary",  "food",
  "cranberry",            "Q374399 | Q13181 | Q21546387", "shrub", "temporary", "food",
  "currant",              "Q3241599",             "shrub",     "temporary",  "food",
  "gooseberry",           "Q41503 | Q17638951",   "shrub",     "temporary",  "food",
  "kiwi fruit",           "Q13194",               "shrub",     "temporary",  "food",
  "raspberry",            "Q12252383 | Q13179",   "shrub",     "temporary",  "food",
  "strawberry",           "Q745 | Q13158",        "shrub",     "temporary",  "food",
  "clementine",           "Q460517",              "tree",      "permanent",  "food",
  "grapefruit",           "Q21552830",            "tree",      "permanent",  "food",
  "lemon",                "Q500 | Q1093742",      "tree",      "permanent",  "food",
  "lime",                 "Q13195",               "tree",      "permanent",  "food",
  "mandarine",            "Q125337",              "tree",      "permanent",  "food",
  "orange",               "Q12330939 | Q34887",   "tree",      "permanent",  "food",
  "pomelo",               "Q353817 | Q80024",     "tree",      "permanent",  "food",
  "satsuma",              "Q875262",              "tree",      "permanent",  "food",
  "tangerine",            "Q516494",              "tree",      "permanent",  "food",
  "grape",                "Q10978 | Q191019",     "shrub",     "permanent",  "food",
  "apple",                "Q89",                  "tree",      "permanent",  "food",
  "quince",               "Q2751465 | Q43300",    "tree",      "permanent",  "food",
  "apricot",              "Q37453 | Q3733836",    "tree",      "permanent",  "food",
  "cherry",               "Q196",                 "tree",      "permanent",  "food",
  "nectarine",            "Q2724976 | Q83165",    "tree",      "permanent",  "food",
  "peach",                "Q37383",               "tree",      "permanent",  "food",
  "plum",                 "Q6401215 | Q13223298", "tree",      "permanent",  "food",
  "sloe",                 "Q12059685 | Q129018",  "tree",      "permanent",  "food",
  "sour cherry",          "Q68438267 | Q131517",  "tree",      "permanent",  "food",
  "açaí",                 "Q33943 | Q12300487",   "tree",      "permanent",  "food",
  "avocado",              "Q961769 | Q37153",     "tree",      "permanent",  "food",
  "banana",               "Q503",                 "tree",      "permanent",  "fibre | food",
  "date",                 "Q1652093",             "tree",      "permanent",  "food",
  "fig",                  "Q36146 | Q2746643",    "shrub",     "permanent",  "food",
  "guava",                "Q166843 | Q3181909",   "tree",      "permanent",  "food",
  "mango",                "Q169",                 "tree",      "permanent",  "food",
  "mangosteen",           "Q170662 | Q104030000", "tree",      "permanent",  "food",
  "papaya",               "Q732775",              "tree",      "permanent",  "food",
  "persimmon",            "Q158482 | Q29526",     "tree",      "permanent",  "food",
  "pineapple",            "Q1493 | Q10817602",    "shrub",     "permanent",  "food",
  "plantain",             "Q165449, ",            "tree",      "permanent",  "food",
  "natural gums",         NA,                     "tree",      "permanent",  "industrial",
  "natural rubber",       NA,                     "tree",      "permanent",  "industrial",
  "bambara bean",         "Q107357073",           "forb",      "temporary",  "food",
  "bean",                 "Q379813",              "forb",      "temporary",  "food",
  "broad bean",           "Q131342 | Q61672189",  "forb",      "temporary",  "food",
  "carob",                "Q8195444 | Q68763",    "forb",      "permanent",  "food",
  "chickpea",             "Q81375 | Q21156930",   "forb",      "temporary",  "food",
  "cow pea",              "Q107414065",           "forb",      "temporary",  "food",
  "lentil",               "Q61505177 | Q131226",  "forb",      "temporary",  "food",
  "lupin",                "Q156811",              "forb",      "temporary",  "fodder | forage",
  "pea",                  "Q13189 | Q13202263",   "forb",      "temporary",  "food",
  "pigeon pea",           "Q632559 | Q103449274", "forb",      "temporary",  "food",
  "string bean",          "Q42339 | Q2987371",    "forb",      "temporary",  "food",
  "vetch",                "Q157071",              "forb",      "temporary",  "food",
  "basil",                "Q38859 | Q65522654",   "forb",      "temporary",  "food",
  "coca",                 "Q158018",              "tree",      "permanent",  "recreation",
  "ginseng",              "Q182881 | Q20817212",  "forb",      "permanent",  "food",
  "guarana",              "Q209089",              "forb",      "permanent",  "food | recreation",
  "kava",                 "Q161067",              "forb",      "permanent",  "food",
  "mint",                 "Q47859",               "forb",      "temporary",  "food",
  "peppermint",           "Q156037",              "forb",      "temporary",  "food",
  "tobacco",              "Q1566 | Q181095",      "forb",      "temporary",  "recreation",
  "almond",               "Q184357 | Q15545507",  "tree",      "permanent",  "food",
  "areca nut",            "Q1816679 | Q156969",   "tree",      "permanent",  "food",
  "brazil nut",           "Q12371971",            "tree",      "permanent",  "food",
  "cashew",               "Q7885904 | Q34007",    "tree",      "permanent",  "food",
  "chestnut",             "Q773987",              "tree",      "permanent",  "food",
  "hazelnut",             "Q578307 | Q104738415", "tree",      "permanent",  "food",
  "kolanut",              "Q114264 | Q912522",    "tree",      "permanent",  "food",
  "pistachio",            "Q14959225 | Q36071",   "tree",      "permanent",  "food",
  "walnut",               "Q208021 | Q46871",     "tree",      "permanent",  "food",
  "castor bean",          "Q64597240 | Q155867",  "forb",      "temporary",  "medicinal | food",
  "coconut",              "Q3342808",             "tree",      "permanent",  "fibre | food",
  "jojoba",               "Q267749",              "forb",      "temporary",  "food",
  "linseed",              "Q911332",              "forb",      "temporary",  "fibre | food",
  "mustard",              "Q131748 | Q146202 | Q504781", "forb", "temporary", "food",
  "niger seed",           "Q110009144, ",         "forb",      "temporary",  "food",
  "oil palm",             "Q80531 | Q12047207",   "tree",      "permanent",  "food | industrial",
  "olive",                "Q3406628 | Q23485",    "tree",      "permanent",  "food",
  "peanut",               "Q434 | Q13099586",     "forb",      "temporary",  "food",
  "poppy",                "Q131584 | Q130201",    "forb",      "temporary",  "food | recreation",
  "rapeseed",             "Q177932",              "forb",      "temporary",  "food",
  "safflower",            "Q156625 | Q104413623", "forb",      "temporary",  "food | industrial",
  "sesame",               "Q2763698 | Q12000036", "forb",      "temporary",  "food",
  "shea nut",             "Q104212650 | Q50839003", "tree",    "permanent",  "food",
  "soybean",              "Q11006",               "forb",      "temporary",  "food",
  "sunflower",            "Q26949 | Q171497 | Q1076906", "forb", "temporary", "food",
  "tallowtree",           "Q1201089",             "tree",      "permanent",  "industrial",
  "tung nut",             "Q2699247 | Q2094522",  "tree",      "permanent",  "industrial",
  "cassava",              "Q43304555 | Q83124",   "forb",      "temporary",  "food",
  "potato",               "Q16587531 | Q10998",   "forb",      "temporary",  "food",
  "sweet potato",         "Q37937",               "forb",      "temporary",  "food",
  "taro",                 "Q227997",              "forb",      "temporary",  "food",
  "yam",                  "Q8047551 | Q71549",    "forb",      "temporary",  "food",
  "yautia",               "Q763075",              "forb",      "temporary",  "food",
  "cocoa beans",          "Q208008",              "tree",      "permanent",  "food | recreation",
  "coffee",               "Q8486",                "shrub",     "permanent",  "food | recreation",
  "mate",                 "Q81602 | Q5881191",    "shrub",     "permanent",  "food | recreation",
  "tea",                  "Q101815 | Q6097",      "shrub",     "permanent",  "food | recreation",
  "anise",                "Q28692",               "forb",      "temporary",  "food",
  "badian",               "Q1760637",             "forb",      "temporary",  "food",
  "cannella cinnamon",    "Q28165 | Q370239",     "forb",      "permanent",  "food",
  "caraway",              "Q26811",               "forb",      "temporary",  "food",
  "cardamon",             "Q14625808",            "forb",      "permanent",  "food",
  "chillies and peppers", "Q165199 | Q201959 | Q1380", "forb", "temporary",  "food",
  "clove",                "Q15622897",            "tree",      "permanent",  "food",
  "coriander",            "Q41611 | Q20856764",   "forb",      "temporary",  "food",
  "cumin",                "Q57328174 | Q132624",  "forb",      "temporary",  "food",
  "fennel",               "Q43511 | Q27658833",   "forb",      "temporary",  "food",
  "ginger",               "Q35625 | Q15046077",   "forb",      "permanent",  "food",
  "hop",                  "Q104212",              "forb",      "permanent",  "food",
  "juniper berry",        "Q3251025",             "shrub",     "permanent",  "food",
  "mace",                 "Q1882876",             "tree",      "permanent",  "food | fibre",
  "malaguetta pepper",    "Q3312331",             "forb",      "temporary",  "food",
  "nutmeg",               "Q12104",               "tree",      "permanent",  "food",
  "pepper",               "Q311426",              "forb",      "permanent",  "food",
  "vanilla",              "Q162044",              "forb",      "permanent",  "food",
  "lavendar",             "Q42081",               "forb",      "permanent",  "food",
  "sugar beet",            "Q151964",              "forb",      "temporary",  "food",
  "sugar cane",            "Q36940 | Q3391243",    "graminoid", "temporary",  "food",
  "stevia",               "Q312246 | Q3644010",   "forb",      "temporary",  "food",
  "cantaloupe",           "Q61858403 | Q477179",  "forb",      "temporary",  "food",
  "cucumber",             "Q2735883",             "forb",      "temporary",  "food",
  "eggplant",             "Q7540 | Q12533094",    "forb",      "temporary",  "food",
  "gherkin",              "Q23425",               "forb",      "temporary",  "food",
  "gourd",                "Q7370671",             "forb",      "temporary",  "food",
  "melon",                "Q259438",              "forb",      "temporary",  "food",
  "okra",                 "Q37083 | Q1621080",    "forb",      "temporary",  "food",
  "pumpkin",              "Q165308 | Q5339301",   "forb",      "temporary",  "fodder | food",
  "squash",               "Q5339237 | Q7533",     "forb",      "temporary",  "fodder | food",
  "tomato",               "Q20638126 | Q23501",   "forb",      "temporary",  "food",
  "watermelon",           "Q38645 | Q17507129",   "forb",      "temporary",  "food",
  "artichoke",            "Q23041430",            "forb",      "temporary",  "food",
  "asparagus",            "Q2853420 | Q23041045", "forb",      "temporary",  "food",
  "bok choi",             "Q18968514",            "forb",      "temporary",  "fodder | food",
  "broccoli",             "Q47722 | Q57544960",   "forb",      "temporary",  "food",
  "brussels sprout",      "Q150463 | Q104664711", "forb",      "temporary",  "fodder | food",
  "cabbage",              "Q14328596",            "forb",      "temporary",  "fodder | food",
  "cauliflower",          "Q7537 | Q23900272",    "forb",      "temporary",  "food",
  "chicory",              "Q2544599 | Q1474",     "forb",      "temporary",  "food | recreation",
  "chinese cabbage",      "Q13360268 | Q104664724", "forb",    "temporary",  "food",
  "collard",              "Q146212 | Q14879985",  "forb",      "temporary",  "food",
  "gai lan",              "Q1677369 | Q104664699", "forb",     "temporary",  "food",
  "kale",                 "Q45989",               "forb",      "temporary",  "food",
  "kohlrabi",             "Q147202",              "forb",      "temporary",  "food",
  "lettuce",              "Q83193 | Q104666136",  "forb",      "temporary",  "food",
  "savoy cabbage",        "Q154013",              "forb",      "temporary",  "food",
  "spinach",              "Q81464",               "forb",      "temporary",  "food",
  "mushrooms",            "Q654236",              "forb",      "temporary",  "food",
  "carrot",               "Q81 | Q11678009",      "forb",      "temporary",  "fodder | food",
  "chive",                "Q5766863",             "forb",      "temporary",  "food",
  "garlic",               "Q23400 | Q21546392",   "forb",      "temporary",  "food",
  "leek",                 "Q1807269",             "forb",      "temporary",  "food",
  "onion",                "Q13191",               "forb",      "temporary",  "food",
  "turnip",               "Q3916957 | Q3384",     "forb",      "temporary",  "food",
  "partridge",            "Q25237 | Q29472543",   NA,          NA,           "food",
  "pigeon",               "Q2984138 | Q10856",    NA,          NA,           "labor | food",
  "quail",                "Q28358",               NA,          NA,           "food",
  "chicken",              "Q780",                 NA,          NA,           "food",
  "duck",                 "Q3736439 | Q7556",     NA,          NA,           "food",
  "goose",                "Q16529344",            NA,          NA,           "labor | food",
  "turkey",               "Q848706 | Q43794",     NA,          NA,           "food",
  "hare",                 "Q46076 | Q63941258",   NA,          NA,           "food",
  "rabbit",               "Q9394",                NA,          NA,           "food",
  "buffalo",              "Q82728",               NA,          NA,           "labor | food",
  "cattle",               "Q830 | Q4767951",      NA,          NA,           "labor | food",
  "goat",                 "Q2934",                NA,          NA,           "labor | food",
  "sheep",                "Q7368",                NA,          NA,           "labor | food",
  "alpaca",               "Q81564",               NA,          NA,           "fibre",
  "camel",                "Q7375",                NA,          NA,           "labor",
  "guanaco",              "Q172886 | Q1552716",   NA,          NA,           "labor",
  "llama",                "Q42569",               NA,          NA,           "fibre | labor",
  "vicugna",              "Q2703941 | Q167797",   NA,          NA,           "fibre",
  "ass",                  "Q19707",               NA,          NA,           "labor",
  "horse",                "Q726 | Q10758650",     NA,          NA,           "labor",
  "mule",                 "Q83093",               NA,          NA,           "labor",
  "pig",                  "Q787",                 NA,          NA,           "food",
  "beehive",              "Q165107",              NA,          NA,           "labor"
)


luckiOnto <- new_source(name = "wikidata",
                        date = Sys.Date(),
                        description = "Wikidata is a free, collaborative, multilingual, secondary database, collecting structured data to provide support for Wikipedia, Wikimedia Commons, the other wikis of the Wikimedia movement, and to anyone in the world.",
                        homepage = "https://www.wikidata.org/",
                        uri_prefix = "https://www.wikidata.org/wiki/",
                        license = "CC0",
                        ontology = luckiOnto)

luckiOnto <- new_source(name = "persistence",
                        date = Sys.Date(),
                        description = "a collection of standard terms of the persistance of plants",
                        homepage = "",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

luckiOnto <- new_source(name = "life-form",
                        date = Sys.Date(),
                        description = "a collection of standard terms of plant life-forms",
                        homepage = "",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

luckiOnto <- new_source(name = "use-type",
                        date = Sys.Date(),
                        description = "a collection of standard terms of crop and livestock use-types",
                        homepage = "",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

# set the mappings to these attributes
lut_useType <- tibble(label = c("bioenergy", "fibre", "food", "wood", "forage",
                                "silage", "fodder", "industrial", "recreation",
                                "medicinal", "labor"),
                      description = c("plants that are used for bioenergy production",
                                      "plants/animals that are used for fibre production",
                                      "plants/animals that are used for produced for human food consumption",
                                      "plants that are used for wood production",
                                      "plants that are produced for animals to forage on them",
                                      "plants that are used to produce silage",
                                      "plants that serve as fodder, for more controlled feeding of animals",
                                      "plants that were historically labeled industrial crops",
                                      "plants with a stimulating effect that can be used for recreational purposes",
                                      "plants that are grown for their medicinal effect",
                                      "animals that is used for labor"))

lut_persistence <- tibble(label = c("temporary", "permanent"),
                          description = c("plants that exist only until being harvest the first time",
                                          "plants that exist for several years where they are harvested several times"))

lut_lifeForm <- tibble(label = c("graminoid", "tree", "herb", "shrub", "forb"),
                       description = "")

luckiOnto <- new_mapping(new = attributes$wiki_id,
                         target = get_concept(table = attributes %>% select(label = concept), ontology = luckiOnto),
                         source = "wikidata", match = "close", certainty = 3,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = attributes$persistence,
                         target = get_concept(table = attributes %>% select(label = concept), ontology = luckiOnto),
                         source = "persistence", match = "close", certainty = 3,
                         description = lut_persistence,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = attributes$life_form,
                         target = get_concept(table = attributes %>% select(label = concept), ontology = luckiOnto),
                         source = "life-form", match = "close", certainty = 3,
                         description = lut_lifeForm,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = attributes$use_typ,
                         target = get_concept(table = attributes %>% select(label = concept), ontology = luckiOnto),
                         source = "use-type", match = "close", certainty = 3,
                         description = lut_useType,
                         ontology = luckiOnto)


# workaround to insert description to external concepts/attributes
#
lut <- bind_rows(lut_useType, lut_persistence)

luckiOnto@concepts$external <- left_join(luckiOnto@concepts$external, lut, by = "label") %>%
  mutate(description = if_else(is.na(description.x), description.y, description.x)) %>%
  select(id, label, has_broader, description, has_source)

# write output ----
#
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))
export_as_rdf(ontology = luckiOnto, filename = paste0(dataDir, "tables/luckiOnto.ttl"))
