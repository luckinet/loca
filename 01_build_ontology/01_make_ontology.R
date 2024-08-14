# ----
# title       : build ontology - make ontology
# description : This is a script for building the LUCKINet commodity ontology.
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-03-27
# version     : 0.8.0
# status      : done (luts), done (gpw)
# comment     : file.edit(paste0(dir_docs, "/documentation/02_build_ontology.md"))
# ----

message("\n---- build landuse ontology ----")

dir_onto <- .get_path(module = "onto")
dir_onto_data <- paste0(dir_onto, "_data/")

path_onto <- paste0(dir_onto_data, "lucki_onto.rds")

# open tasks:
# - move everything to documentation that is just descriptive
# - consider documenting other lulc classes: https://docs.google.com/spreadsheets/d/1SX51OilNt-cUYpAa7t0LAvZRTzq3Sd4WJLnX6mWKfQk/edit#gid=1995607081
# - connect crops to landuse classes by providing the landuse classes as "has_broader_match"

# 1. make paths ----
#

# 2. load data ----
#

# 3. data processing ----
#
## start a new ontology ----
message(" --> initiate ontology")
luckiOnto <- start_ontology(name = "lucki_onto", path = dir_onto_data,
                            version = "1.0.2",
                            code = ".xx",
                            description = "the LUCKINet commodities",
                            homepage = "https://www.luckinet.org",
                            uri_prefix = "http://luckinet.org",
                            license = "CC-BY-4.0")

## define all sources ----
message(" --> defining sources")


# ### corine land cover ----
# luckiOnto <- new_source(name = "clc",
#                         date = Sys.Date(),
#                         description = "CORINE land cover nomenclature",
#                         homepage = "https://land.copernicus.eu/user-corner/technical-library/corine-land-cover-nomenclature-guidelines/html/",
#                         ontology = luckiOnto)
#
# clcID <- tribble(
#   ~label, ~description,
#   "100", "ARTIFICIAL SURFACES",
#   "110", "Urban fabric - Areas mainly occupied by dwellings and buildings used by administrative/public utilities, including their connected areas (associated lands, approach road network, parking lots).",
#   "111", "Continuous urban fabric - The continuous urban fabric class is assigned when urban structures and transport networks are dominating the surface area. > 80% of the land surface is covered by impermeable features like buildings, roads and artificially surfaced areas. Non-linear areas of vegetation and bare soil are exceptional. Clarification: This coverage percentage pertains to real ground surface. Therefore, identification of the 80% imperviousness threshold requires particular attention to avoid confusion with the apparent vegetation (i.e. visible tree crowns) and permeable surfaces under trees. For example, in the streets bordered with trees, the real ground surface under the trees is mostly covered with asphalt or concrete. So, the vegetation percentage has to be estimated taking into account the shape structure and spatial context visible on the satellite image. The occurrence of at least 80 % of soil sealing is not the sole criteria for assigning an area to this class; also land use aspects have to be taken into account. The dominant land use type is residential, which can be also mixed with public services or local governments and commercial or office areas.",
#   "112", "Discontinuous urban facbric - The discontinuous urban fabric class is assigned when urban structures and transport networks associated with vegetated areas and bare surfaces are present and occupy significant surfaces in a discontinuous spatial pattern. The impermeable features like buildings, roads and artificially surfaced areas range from 30 to 80 % land coverage. Clarification: The discrimination between continuous and discontinuous urban fabric is set from the presence of vegetation visible in the satellite image illustrating either single houses with gardens or scattered apartment blocks with green areas between them. The density of houses is the main criterion to attribute a land cover class to the built-up areas or to any other class. For example in case of patchwork of small agricultural parcels and scattered houses (with distance between them less than 300 m), the threshold to be applied for separation between class 112 (discontinuous urban fabric) and class 242 (complex cultivation patterns) is 30 % of urban fabric within the patchwork area. Above that threshold the area should be assigned to class 112, below the threshold to class 242.",
#   "120", "Industrial, commercial and transport units - Areas mainly occupied by industrial activities of manufacturing, trade, financial activities and services, transport infrastructures for road traffic and rail networks, airport installations, river and sea port installations, including their associated lands and access infrastructures. Includes industrial livestock rearing facilities.",
#   "121", "Industrial or commercial units - Buildings, other built-up structures and artificial surfaces (with concrete, asphalt, tarmacadam, or stabilised like e.g. beaten earth) occupy most of the area. It can also contain vegetation (most likely grass) or other non-sealed surfaces. This class is assigned for land units that are under industrial or commercial use or serve for public service facilities. Clarification: The class 121 has a strong focus on land use information, which is the key criterion to identify this class. In this class many different land cover types can occur, so it does not necessarily indicate precise information on land cover for a particular given situation in landscape, in particular the degree of imperviousness.",
#   "122", "Road and rail networks and associated land - Motorways and railways, including associated installations (stations, platforms, embankments, linear greenery narrower than 100 m). Minimum width for inclusion: 100 m. Clarification The general requirement of 100 m delineation accuracy is not sufficient in mapping 122. The tolerable shift in delineation is maximum 50 m. In delineating 122 a maximum 15-20% exaggeration of width is allowed, meaning that real width of the road including associated land should be at least 80 m to be included in CLC. In such cases the exaggerated width should be as close as possible to 100 m.",
#   "123", "Port areas - Infrastructure of port areas (land and water surface), including quays, dockyards and marinas.",
#   "124", "Airports - Airports installations: runways, buildings and associated land. This class is assigned for any kind of ground facilities that serve airborne transportation.",
#   "130", "Mine, dump and construction sites - Artificial areas mainly occupied by extractive activities, construction sites, man-made waste dump sites and their associated lands.",
#   "131", "Mineral extraction sites - Open-pit extraction sites of construction materials (sandpits, quarries) or other minerals (open-cast mines). Includes flooded mining pits.",
#   "132", "Dump sites - Public, industrial or mine dump sites.",
#   "133", "Construction sites - Spaces under construction development, soil or bedrock excavations, earthworks. This class is assigned for areas where landscape is affected by human activities, changed or modified into artificial surfaces, being in a state of anthropogenic transition.",
#   "140", "Artificial, non-agricultural vegetated areas - Areas voluntarily created for recreational use. Includes green or recreational and leisure urban parks, sport and leisure facilities.",
#   "141", "Green urban areas - Areas with vegetation within or partly embraced by urban fabric. This class is assigned for urban greenery, which usually has recreational or ornamental character and is usually accessible for the public.",
#   "142", "Sport and leisure sites - This class is assigned for areas used for sports, leisure and recreation purposes. Camping grounds, sports grounds, leisure parks, golf courses, racecourses etc. belong to this class, as well as formal parks not surrounded by urban areas. Clarification: The criterion for assigning this class is the use of land. Areas of any land cover type can belong to this class if the purpose and use of it is sport, leisure or recreation. Delineation should follow functional boundaries; such areas are often surrounded by fences.",
#   "200", "AGRICULTURAL AREAS",
#   "210", "Arable land - Lands under a rotation system used for annually harvested plants and fallow lands, which are rain-fed or irrigated. Includes flooded crops such as rice fields and other inundated croplands.",
#   "211", "Non-irrigated arable land - Cultivated land parcels under rainfed agricultural use for annually harvested non-permanent crops, normally under a crop rotation system, including fallow lands within such crop rotation. Fields with sporadic sprinkler-irrigation with non-permanent devices to support dominant rainfed cultivation are included.",
#   "212", "Permanently irrigated land - Cultivated land parcels under agricultural use for arable crops that are permanently or periodically irrigated, using a permanent infrastructure (irrigation channels, drainage network and additional irrigation facilities). Most of these crops cannot be cultivated without artificial water supply. Does not include sporadically irrigated land.",
#   "213", "Rice fields - Cultivated land parcels prepared for rice production, consisting of periodically flooded flat surfaces with irrigation channels. Clarification: As part of regular cultivation cycle, rice fields are occasionally left fallow for 1-3 years. These parcels are considered to be rice fields, too.",
#   "220", "Permanent crops - All surfaces occupied by permanent crops, not under a rotation system. Includes ligneous crops of standards cultures for fruit production such as extensive fruit orchards, olive groves, chestnut groves, walnut groves shrub orchards such as vineyards and some specific low-system orchard plantation, espaliers and climbers.",
#   "221", "Vineyards - Areas planted with vines, vineyard parcels covering >50% and determining the land use of the area.",
#   "222", "Fruit trees and berry plantations - Cultivated parcels planted with fruit trees and shrubs, intended for fruit production, including nuts. The planting pattern can be by single or mixed fruit species, both in association with permanently grassy surfaces.",
#   "223", "Olive groves - Cultivated areas planted with olive trees.",
#   "230", "Pastures - Lands that are permanently used (at least 5 years) for fodder production. Includes natural or sown herbaceous species, unimproved or lightly improved meadows and grazed or mechanically harvested meadows. Regular agriculture impact influences the natural development of natural herbaceous species composition.",
#   "231", "Pastures, meadows and other permanent grasslands under agricultural use - Permanent grassland characterized by agricultural use or strong human disturbance. Floral composition dominated by graminacea and influenced by human activity. Typically used for grazing-pastures, or mechanical harvesting of grass–meadows. Clarification: Pastures can be described as extensively or intensively grazed permanent grasslands with presence of farm infrastructure such as: fences, shelters, enclosures, watering places, drinking trough, and/or regular agricultural measures and works: mowing, drainage, hay making, seeding, manuring, shrub clearance. Typical visible signs of use are regular parcel structure and/or animal paths.",
#   "240", "Heterogeneous agricultural areas - Areas of annual crops associated with permanent crops on the same parcel, annual crops cultivated under forest trees, areas of annual crops, meadows and/or permanent crops which are juxtaposed, landscapes in which crops and pastures are intimately mixed with natural vegetation or natural areas.",
#   "241", "Annual crops associated with permanent crops - Cultivated land parcels with non-permanent crops (mostly arable land) associated with permanent crops (fruit trees or olive trees or vines) on the same parcel. Clarification: Permanent crops (fruit trees or olive trees or vines) are either in juxtaposition with arable crops or located along the border of the parcels. The occupation rate of non- permanent crops is > 50 %.",
#   "242", "Complex cultivation patterns - Mosaic of small cultivated land parcels with different cultivation types - annual crops, pasture and/or permanent crops -, eventually with scattered houses or gardens.",
#   "243", "Land principally occupied by agriculture, with significant areas of natural vegetation - Areas principally occupied by agriculture, interspersed with sig- nificant natural or semi-natural areas (including forests, shrubs, wetlands, water bodies, mineral outcrops) in a mosaic pattern.",
#   "244", "Agro-forestry areas - Annual crops or grazing land under the wooded cover of forestry species.",
#   "300", "FOREST AND SEMI-NATURAL AREAS",
#   "310", "Forests - Areas occupied by forests and woodlands with a vegetation pattern composed of native or exotic coniferous and/or broad-leaved trees and which can be used for the production of timber or other forest products. The forest trees are under normal climatic conditions higher than 5 m with a canopy closure of 30 % at least. In case of young plantation, the minimum cut-off-point is 500 subjects by ha. Boreal Scandinavian forest: Boreal forest in the northern part of Scandinavia where the canopy closure in climax stage of development is < 30 % (but > 15 %) and the height of trees is > 5-7 m (very frequently composed of Picea spp. and/or Pinus spp. concerning coniferous species with shrubby understorey, part of which are Vaccinium spp., dwarf forms of Salix spp. and Betula spp., Empetrum migrum, etc.) should be classified as coniferous forests (312). The above criteria should be accepted also for the CLC class 311 – broad-leaved forest (most frequently composed of Betula spp., Quercus spp., Fagus silvatica, but also with the possible occurrence of other deciduous species such as Populus tremula, Alnus spp., Salix caprea, Fraxinus excelsior, Ulmus spp., Tilia cordata and Acer platanoides). When the coniferous tree species are mixed with broad-leaved deciduous tree species (see species listed in the respective definitions) and their height is > 5-7 m and the canopy closure is around 30 % (always > 15 %), then this vegetation formation should be classified as mixed forest (313). When vegetation formation of the above-mentioned composition of broad-leaved deciduous and coniferous trees (with the canopy closure only around 10 %) and shrubs represent some transitional stage of forest development, then it should be classified as transitional woodland/shrub (324).",
#   "311", "Broad-leaved forest - Vegetation formation composed principally of trees, including shrub and bush understorey, where broad-leaved species predominate. Clarification: The predominant classifying parameter for this class is a crown cover density of > 30 % or a minimum 500 subjects/ha density, with broad-leaved trees representing > 75 % of the formation. The minimum tree height is 5 m.",
#   "312", "Coniferous forest - Vegetation formation composed principally of trees, including shrub and bush understorey, where coniferous species predominate. Clarification: The predominant classifying parameter for this class is a crown cover density of > 30 % or a minimum 500 subjects/ha density, with coniferous trees representing > 75 % of the formation. The minimum tree height is 5 m (with the exception of Christmas tree plantations).",
#   "313", "Mixed forest - Vegetation formation composed principally of trees, including shrub and bush understorey, where neither broad-leaved nor coniferous species predominate. Extension: Mixed forests with a crown cover of > 30 % or a 500 subjects/ha density for plantation structure. The share of both coniferous and broad-leaved species exceeds 25 % within the canopy closure. The minimum tree height is 5 m.",
#   "320", "Scrub and/or herbaceous associations - Temperate shrubby areas with Atlantic and Alpine heaths, sub-Alpine bush and tall herb communities, deciduous forest re-colonisation, hedgerows, dwarf conifers. All transitional forest development stages (regenerative and degenerative: natural development of forest – bushy formations on abandoned meadows, pastures or forest clear cut and also forest after calamities of variousorigin) should be classified as 324. Shrubby formation with sparse trees (< 15 % canopy closure in climax stage and the height of trees can be > 5-7 m) composed of dwarf forms of Betula spp. and Salix spp., plus Vaccinium spp. Empetrum migrum, Ledum palustre, Carex spp., Cladonia spp., etc. (cover > 50 % of surface) frequently interrupted by rock outcrops (typical of Scandinavia and the Northern Atlantic) should be classified as moors and heathland – tundra (322). Mediterranean and sub-Mediterranean evergreen sclerophyllous bush and scrub (maquis, garrigue, matorral, phrygana sensu lato), re-colonisation and degradation stages of broad-leaved evergreen forests. Dry thermophilous grasslands of the lowlands, hills and mountain zone. Poor Atlantic a sub-Atlantic mat-grasslands of acid soils; grasslands of decalcified sands; Alpine and sub Alpine grasslands. Humid grasslands and tall herb communities; lowland and mountain mesophile pastures and hay meadows.",
#   "321", "Natural grassland - Grasslands under no or moderate human influence. Low productivity grasslands. Often situated in areas of rough, uneven ground, steep slopes; frequently including rocky areas or patches of other (semi-)natural vegetation. Clarification: Natural grasslands are areas with herbaceous vegetation (maximum height is 150 cm and gramineous species are prevailing) covering at least 50 % of the surface. Besides herbaceous vegetation, areas of shrub formations, of scattered trees and of mineral outcrops also occur. Often under nature conservation. In this context the term ”natural” indicates that vegetation is developed under a minimum human interference,(not mowed, drained, irrigated, sown, fertilized or stimulated by chemicals, which might influence production of biomass). Even though the human interference cannot be completely discarded in quoted areas, it does not suppress the natural development or species composition of the meadows. Maintenance mowing and shrub clearance for prevention of woody overgrowth due to natural succession is tolerated. Sporadic extensive grazing with low livestock unit/ha is possible. Typical visible characteristics: large extent, irregular shape, usually in distant location from larger settlements.",
#   "322", "Moors and heathland - Vegetation with low and closed cover, dominated by bushes, shrubs, dwarf shrubs (heather, briars, broom, gorse, laburnum etc.) and herbaceous plants, forming a climax stage of development. Extension: Moors and heathlands are often formed in habitats where natural formation of forests is hindered by or made impossible by growing conditions. However, in some of these habitats afforestation is possible with human intervention.",
#   "323", "Sclerophyllous vegetation - Bushy sclerophyllous vegetation in a climax stage of development, including maquis, matorral and garrigue.",
#   "324", "Transitional woodland-scrub - Transitional bushy and herbaceous vegetation with occasional scattered trees. Can represent woodland degradation, forest regeneration / recolonization or natural succession. Clarification: Areas representing natural development of forest formations, consisting of young plants of broad–leaved and coniferous species, with herbaceous vegetation and dispersed solitary adult trees. Transitional process can be for instance natural succession on abandoned agricultural land, regeneration of forest after damages of various origin (e.g. storm, avalanche), stages of forest degeneration caused by natural or anthropogenic stress factors (e.g. drought, pollution), reforestation after clearcutting, afforestation on formerly non-forested natural or semi-natural areas etc.",
#   "330", "Open spaces with little or no vegetation - Natural areas covered with little or no vegetation, including open thermophile formations of sandy or rocky grounds distributed on calcareous or siliceous soils frequently disturbed by erosion, steppic grasslands, perennial steppe-like grasslands, meso- and thermo-Mediterranean xerophile, mostly open, short-grass perennial grasslands, alpha steppes, vegetated or sparsely vegetated areas of stones on steep slopes, screes, cliffs, rock fares, limestone pavements with plant communities colonising their tracks, perpetual snow and ice, inland sand-dune, coastal sand-dunes and burnt natural woody vegetation areas.",
#   "331", "Beaches, dunes, sands - Natural non-vegetated expanses of sand or pebble/gravel, in coastal or continental locations, like beaches, dunes, gravel pads; including beds of stream channels with torrential regime. Vegetation covers maximum 10%.",
#   "332", "Bare rocks - Scree, cliffs, rock outcrops, including areas of active erosion, rocks and reef flats situated above the high-water mark, inland salt planes.",
#   "333", "Sparsely vegetated areas - Areas with sparse vegetation, covering 10-50% of surface. Includes steppes, tundra, lichen heath, badlands, karstic areas and scattered high-altitude vegetation. Clarification: Scattered vegetation is composed of herbaceous and/or ligneous and semi-ligneous species, the rest of area is naturally bare ground.",
#   "334", "Burnt areas - Natural woody vegetation affected by recent fires. Clarification: This class includes recently (within a year of image acquisition) burnt areas of forests, moors and heathlands, sclerophyllous vegetation, transitional forest-shrub formations, areas with sparse vegetation. Recent burn is visible on satellite images, still mainly black, dark green or grey.",
#   "335", "Glaciers and perpetual snow - Land covered by glaciers or permanent snowfields. Clarification: Permanent snow and ice can be captured by finding the patches’ smallest extent during the year. This can be captured when they shrink to minimum due to summer warmth, but before the first snowfall after summer occurs. Such ideal date is between end July and late September. The general requirement of 100 m delineation accuracy is not sufficient in mapping 335. The tolerable shift in delineation is maximum 50 m.",
#   "400", "WETLANDS",
#   "410", "Inland wetlands - Areas flooded or liable to flooding during the great part of the year by fresh, brackish or standing water with specific vegetation coverage made of low shrub, semi-ligneous or herbaceous species. Includes water-fringe vegetation of lakes, rivers, and brooks and of fens and eutrophic marshes, vegetation of transition mires and quaking bogs and springs, highly oligotrophic and strongly acidic communities composed mainly of sphagnum growing on peat and deriving moistures of raised bogs and blanket bogs.",
#   "411", "Inland marshes - Low-lying land usually flooded in winter, and with ground more or less saturated by fresh water all year round.",
#   "412", "Peat bogs - Wetlands with accumulation of considerable amount of decomposed moss (mostly Sphagnum) and vegetation matter. Both natural and exploited peat bogs. Clarification: Peat bogs are types of mire where peat, a deposit of dead plant material—often mosses, and in a majority of cases, sphagnum moss, - is accumulated. Bogs occur where the water at the ground surface is acidic and low in nutrients. In general the low fertility and cool, moist climate results in relatively slow plant growth. The decay of biomass is even slower owing to the water-saturated soil which results in accumulation of peat.",
#   "420", "Marine wetlands - Areas which are submerged by high tides at some stage of the annual tidal cycle. Includes salt meadows, facies of saltmarsh grass meadows, transitional or not to other communities, vegetation occupying zones of varying salinity and humidity, sands and muds submerged for part of every tide devoid of vascular plants, active or recently abandoned salt-extraction evaporation basins.",
#   "421", "Salt Marshes - Vegetated low-lying areas in the coastal zone, above the high-tide line, susceptible to flooding by seawater. Often in the process of being filled in by coastal mud and sand sediments, gradually being colonized by halophilic plants. Clarification: Salt marshes are in most cases directly connected to intertidal areas and may successively develop from them in the long-term.",
#   "422", "Salines - Salt-pans for extraction of salt from salt water by evaporation, active or in process of abandonment. Sections of salt marsh exploited for the production of salt, clearly distinguishable from the rest of the marsh by their parcellation and embankment systems.",
#   "423", "Intertidal flats - Coastal zone under tidal influence between open sea and land, which is flooded by sea water regularly twice a day in a ca. 12 hours cycle. Area between the average lowest and highest sea water level at low tide and high tide. Generally non-vegetated expanses of mud, sand or rock lying between high and low water marks. Clarification: The seaward boundary of intertidal flats may underlay constant change in geographical extent due to littoral morphodynamics. Range of water level between low tide and high tide may vary between decimeters and several meters in height.",
#   "500", "WATER BODIES",
#   "510", "Inland waters - Lakes, ponds and pools of natural origin containing fresh (i.e non-saline) water and running waters made of all rivers and streams. Man-made fresh water bodies including reservoirs and canals.",
#   "511", "Water courses - Natural or artificial water-courses serving as water drainage channels. Includes canals. Minimum width for inclusion: 100 m. Clarification: In case of rivers with oscillating water level (when the width of the stream is less than 100 m in certain seasons of the year), the whole river bed must be added to the narrow water surface and then classified as 511. However, if there is no water in the river during a substantial part of the year (> 6 months), then the gravel and sand parts of the river bed (along with the narrow river bed, if appropriate) must be classified under class 331.",
#   "512", "Water bodies - Natural or artificial water bodies with presence of standing water surface during most of the year.",
#   "520", "Marine waters - Oceanic and continental shelf waters, bays and narrow channels including sea lochs or loughs, fiords or fjords, rya straits and estuaries. Saline or brackish coastal waters often formed from sea inlets by sitting and cut-off from the sea by sand or mud banks.",
#   "521", "Coastal lagoons - Stretches of salt or brackish water in coastal areas which are separated from the sea by a tongue of land or other similar topography. These water bodies can be connected to the sea at limited points, either permanently or for parts of the year only. Clarification: The connection between a lagoon under tidal influence and open sea does not have to be necessarily permanent and can also be present only during high tides.",
#   "522", "Estuaries - The mouth of a river under tidal influence within which the tide ebbs and flows. Clarification: In practice, upstream maritime influence is stopped by the first floodgate; downstream, the estuary limit is arbitrary.",
#   "523", "Sea and ocean - Zone seaward of the lowest tide limit."
# )
#
# ### esa cci land cover ----
# luckiOnto <- new_source(name = "esalc",
#                         date = Sys.Date(),
#                         version = "2.1.1",
#                         description = "The CCI-LC project delivers consistent global LC maps at 300 m spatial resolution on an annual basis from 1992 to 2020 The Coordinate Reference System used for the global land cover database is a geographic coordinate system (GCS) based on the World Geodetic System 84 (WGS84) reference ellipsoid.",
#                         homepage = "https://maps.elie.ucl.ac.be/CCI/viewer/index.php",
#                         ontology = luckiOnto)
#
# esalcID <- tribble(
#   ~label, ~description,
#   "10", "Cropland, rainfed",
#   "11", "Herbaceous cover",
#   "12", "Tree or shrub cover",
#   "20", "Cropland, irrigated or post‐flooding",
#   "30", "Mosaic cropland (>50%) / natural vegetation (tree, shrub, herbaceous cover) (<50%)",
#   "40", "Mosaic natural vegetation (tree, shrub, herbaceous cover) (>50%) / cropland (<50%)",
#   "50", "Tree cover, broadleaved, evergreen, closed to open (>15%)",
#   "60", "Tree cover, broadleaved, deciduous, closed to open (>15%)",
#   "61", "Tree cover, broadleaved, deciduous, closed (>40%)",
#   "62", "Tree cover, broadleaved, deciduous, open (15‐40%)",
#   "70", "Tree cover, needleleaved, evergreen, closed to open (>15%)",
#   "71", "Tree cover, needleleaved, evergreen, closed (>40%)",
#   "72", "Tree cover, needleleaved, evergreen, open (15‐40%)",
#   "80", "Tree cover, needleleaved, deciduous, closed to open (>15%)",
#   "81", "Tree cover, needleleaved, deciduous, closed (>40%)",
#   "82", "Tree cover, needleleaved, deciduous, open (15‐40%)",
#   "90", "Tree cover, mixed leaf type (broadleaved and needleleaved)",
#   "100", "Mosaic tree and shrub (>50%) / herbaceous cover (<50%)",
#   "110", "Mosaic herbaceous cover (>50%) / tree and shrub (<50%)",
#   "120", "Shrubland",
#   "121", "Evergreen shrubland",
#   "122", "Deciduous shrubland",
#   "130", "Grassland",
#   "140", "Lichens and mosses",
#   "150", "Sparse vegetation (tree, shrub, herbaceous cover) (<15%)",
#   "151", "Sparse tree (<15%)",
#   "152", "Sparse shrub (<15%)",
#   "153", "Sparse herbaceous cover (<15%)",
#   "160", "Tree cover, flooded, fresh or brakish water",
#   "170", "Tree cover, flooded, saline water",
#   "180", "Shrub or herbaceous cover, flooded, fresh/saline/brakish water",
#   "190", "Urban areas",
#   "200", "Bare areas",
#   "201", "Consolidated bare areas",
#   "202", "Unconsolidated bare areas",
#   "210", "Water bodies",
#   "220", "Permanent snow and ice"
# )

### indicative crop classification ----
luckiOnto <- new_source(name = "icc",
                        date = Sys.Date(),
                        version = "1.1",
                        description = "The official version of the Indicative Crop Classification was developed for the 2020 round of agricultural censuses.",
                        homepage = "https://stats.fao.org/caliper/browse/skosmos/ICC11/en/",
                        uri_prefix = "https://stats.fao.org/classifications/ICC/v1.1/",
                        license = "?",
                        ontology = luckiOnto)

### central product classification ----
luckiOnto <- new_source(name = "cpc",
                        date = Sys.Date(),
                        version = "2.1",
                        description = "The Central Product Classification (CPC) v2.1",
                        homepage = "https://stats.fao.org/caliper/browse/skosmos/cpc21/en/",
                        uri_prefix = "http://stats-class.fao.uniroma2.it/CPC/v2.1/ag/",
                        license = "?",
                        ontology = luckiOnto)

### plant and animal species ----
luckiOnto <- new_source(name = "species",
                        date = Sys.Date(),
                        description = "This contains scientific plant and animal names as suggested by the ICC 1.1 in the book WORLD PROGRAMME FOR THE CENSUS OF AGRICULTURE 2020",
                        homepage = "https://www.fao.org/3/i4913e/i4913e.pdf",
                        license = "?",
                        ontology = luckiOnto)

### wikidata ID ----
luckiOnto <- new_source(name = "wiki",
                        date = Sys.Date(),
                        description = "Wikidata is a free, collaborative, multilingual, secondary database, collecting structured data to provide support for Wikipedia, Wikimedia Commons, the other wikis of the Wikimedia movement, and to anyone in the world.",
                        homepage = "https://www.wikidata.org/",
                        uri_prefix = "https://www.wikidata.org/wiki/",
                        license = "CC0",
                        ontology = luckiOnto)

### gbif ID ----
luckiOnto <- new_source(name = "gbif",
                        date = Sys.Date(),
                        description = "GBIF—the Global Biodiversity Information Facility—is an international network and data infrastructure funded by the world's governments and aimed at providing anyone, anywhere, open access to data about all types of life on Earth.",
                        homepage = "https://www.gbif.org/",
                        uri_prefix = "https://www.gbif.org/species/",
                        license = "dataset specific (see occurrence data)",
                        ontology = luckiOnto)

### use-type ----
luckiOnto <- new_source(name = "use-type",
                        date = Sys.Date(),
                        description = "a collection of standard terms of use-types of crops or livestock, derived from the FAO Central Product Classification (CPC) version 2.1",
                        homepage = "https://www.luckinet.org",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

useTypes <- tribble(
  ~label, ~description,
  "energy", "plants that are used for energy production.",
  "fibre", "plants/animals that are used for fibre production.",
  "food", "plants/animals that are used for human food consumption.",
  "wood", "plants that are used for wood production.",
  "forage", "plants that are left in the field where animals are sent to forage on the crop.",
  "silage", "plants that are used to produce silage.",
  "fodder", "plants that are harvested and brought to animals, for more controlled feeding of animals.",
  "industrial", "plants that were historically labeled industrial crops.",
  "recreation", "plants with a stimulating effect that can be used for recreational purposes.",
  "medicinal", "plants that are grown for their medicinal effect.",
  "labor", "animals that are used for labor/draught.",
  "reproduction", "animals that are used for reproducing the stock."
)


### use-part ----
luckiOnto <- new_source(name = "use-part",
                        date = Sys.Date(),
                        description = "a collection of standard terms of the used parts of crops or livestock, derived from the FAO Central Product Classification (CPC) version 2.1",
                        homepage = "https://www.luckinet.org",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

usedParts <- tribble(
  ~ label, ~description,
  "bark", "where the bark is used.",
  "bast", "where the bast is used.",
  "biomass", "where the whole biomass is used.",
  "buds", "where the flower bud is used.",
  "bulb", "where the buld is used.",
  "eggs", "where the eggs are used.",
  "flower", "where the flower is used.",
  "fruit", "where the fruit is used.",
  "hair", "where the hair are used.",
  "honey", "where the honey is used.",
  "husk", "where the husk is used.",
  "leaves", "where the leaves are used.",
  "lint", "where the flower lint is used.",
  "meat", "where the meat of an animal is used.",
  "dairy", "where the milk of an animal is used.",
  "resin", "where the resin is used.",
  "root", "where the roots are used.",
  "sap", "where the sap is used.",
  "seed", "where the seed is used.",
  "shoot", "where the shoot is used.",
  "stalk", "where the stalk of a plant is used.",
  "time", "where the time/physical presence of an animal is used",
  "tuber", "where the tuber is used.",
  "fur", "where the fur is used.",
  "silk", "where the silk is used."
)

### life-form ----
luckiOnto <- new_source(name = "life-form",
                        date = Sys.Date(),
                        description = "a collection of standard terms of plant life-forms",
                        homepage = "https://www.luckinet.org",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

lifeForms <- tribble(
  ~label,      ~description,
  "graminoid", "plants that are graminoids.",
  "tree", "plants that are trees.",
  "shrub", "plants that are shrubs.",
  "forb", "plants that are forbs.",
  "vine", "plants that are forbs and grow as vines (they need support to grow into the air).",
  "mushroom", "mushrooms."
)

### persistence ----
luckiOnto <- new_source(name = "persistence",
                        date = Sys.Date(),
                        description = "the number of years a plant needs to grow before it can be harvested the first time.",
                        homepage = "https://www.luckinet.org",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

lut_persistence <- tibble(label = as.character(c(1:9, 24, 40)), description = NA_character_)

### duration ----
luckiOnto <- new_source(name = "duration",
                        date = Sys.Date(),
                        description = "the number of years a plant can be harvested.",
                        homepage = "https://www.luckinet.org",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

lut_duration <- tibble(label = as.character(c(1:10, 25, 40, 50, 80)), description = NA_character_)

### harvests ----
luckiOnto <- new_source(name = "harvests",
                        date = Sys.Date(),
                        description = "the number of harvests that can be taken from a plant per year.",
                        homepage = "https://www.luckinet.org",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

lut_harvests <- tribble(
  ~ label, ~description,
  "once", "plants that are harvested once per year",
  "twice", "plants that are harvested twice per year",
  "thrice", "plants that are harvested three times per year",
  "often", "plants that are harvested more than three times per year"
)

### upper height ----
luckiOnto <- new_source(name = "height",
                        date = Sys.Date(),
                        description = "the height classes of plants (expressed as the upper bound)",
                        homepage = "https://www.luckinet.org",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

lut_height <- tribble(
  ~label,  ~description,
  "0.5", "plants that are between 0 and 0.5 m heigh.",
  "1", "plants that are between 0.5 and 1 m heigh.",
  "2", "plants that are between 1 and 2 m heigh.",
  "5", "plants that are between 2 and 5 m heigh.",
  "10", "plants that are between 5 and 10 m heigh.",
  "15", "plants that are btween 10 and 15 m heigh.",
  "20", "plants that are between 10 and 20 m heigh.",
  "30", "plants that are between 20 and 30 m heigh.",
  "40", "plants that are between 30 and 40 m heigh.",
  "higher", "plants that are higher than 40 m."
)

### age range ----
luckiOnto <- new_source(name = "age-class",
                        date = Sys.Date(),
                        description = "the range of the typical animal age",
                        homepage = "https://www.luckinet.org",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

lut_ages <- tibble(label = c("juvenile", "subadult", "adult"),
                   description = c("animals that need to grow up.",
                                   "animals that are at the verge of becoming reproductive.",
                                   "animals that are able to reproduce if not castrated."))

### sex ----
luckiOnto <- new_source(name = "sex",
                        date = Sys.Date(),
                        description = "the sex of the animal",
                        homepage = "https://www.luckinet.org",
                        license = "CC-BY-4.0",
                        ontology = luckiOnto)

lut_sexes <- tibble(label = c("male", "female"),
                    description = c("animals that are male",
                                    "animals that are female"))


## define new classes ----
message(" --> defining classes")
luckiOnto <- new_class(new = "domain", target = NA_character_,
                       description = "the domain of surface area description.", ontology = luckiOnto) %>%
  new_class(new = "cover", target = "domain", description = "landcover classes", ontology = .) %>%
  new_class(new = "dynamic", target = "cover", description = "predominant attribute determining dynamics within the landcover type.", ontology = .) %>%
  new_class(new = "use", target = "dynamic", description = "mutually exclusive types of how land covered by a particular type and dynamic is used.", ontology = .) %>%
  new_class(new = "group", target = "domain",
            description = "broad groups of concepts that describe crops and livestock.", ontology = .) %>%
  new_class(new = "class", target = "group",
            description = "mutually exclusive types of concepts that describe crops and livestock.", ontology = .) %>%
  new_class(new = "crop", target = "class",
            description = "direct concept labels that describe crops.", ontology = .) %>%
  # new_class(new = "variety", target = "crop",
  #           description = "terms that describe varieties of crops.", ontology = .) %>%
  new_class(new = "animal", target = "class",
            description = "direct concept labels that describe livestock.", ontology = .) #%>%
  # new_class(new = "type", target = "animal",
  #           description = "terms that describe types of livestock.", ontology = .)


## define the harmonized concepts ----
message(" --> defining concepts")
domain <- tribble(
  ~concept,   ~description,
  "landcover", "surface area described by the predominant landcover in that location.",
  "landuse", "surface area described by the crops and livestock in that location."
)

luckiOnto <- new_concept(new = domain$concept,
                         description = domain$description,
                         class = "domain",
                         ontology = luckiOnto)

### landcover ----
lc <- tribble(
  ~concept, ~description, ~broader,
  "BARE LAND", "Areas covered by rock, sand or bare soil that contain at most sparse life.", domain$concept[1],
  "ASSEMBLED LAND", "Areas covered by human-made structures.", domain$concept[1],
  "VEGETATED LAND", "Areas covered by vegetation.", domain$concept[1],
  "WETLAND", "Areas that are terrestrial but are inundated to a degree that the conditions for life are adapted to the presence of the water (of any salinity).", domain$concept[1],
  "WATER", "Inland or coastal areas covered by a water body.", domain$concept[1]
)

luckiOnto <- new_concept(new = lc$concept,
                         broader = left_join(lc %>% select(concept, label = broader), get_concept(label = lc$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         description = lc$description,
                         class = "cover",
                         ontology = luckiOnto)


### land dynamics ----
ld <- tribble(
  ~concept, ~description, ~broader,
  "Managed bare land", "Areas that are bare due to (previous) management.", lc$concept[1],
  "Non-managed bare land", "Areas that are bare out of natural causes.", lc$concept[1],
  "Non-Productive", "Areas covered by human-made structures that are not used for productive purposes.", lc$concept[2],
  "Productive", "Areas covered by human-made structures that contain or are composed of productive biomass.", lc$concept[2],
  "Managed vegetation", "Areas where management is the dominant determining or limiting factor.", lc$concept[3],
  "Non-managed vegetation", "Areas where management is absent or at most extensive and where bio-climatic conditions are the dominant determining or limiting factor (including mosaic cycle states).", lc$concept[3],
  "Seasonal flooding", "Areas that are terrestrial but are inundated for a limited time per year (weeks to months).", lc$concept[4],
  "Permanent flooding", "Areas that are terrestrial but are inundated permanently (years or longer).", lc$concept[4],
  "Liquid", "Inland or coastal areas covered by water that persists for the largest part of the year in liquid form.", lc$concept[5],
  "Frozen", "Inland or coastal areas covered by water that persists for the largest part of the year in frozen form.", lc$concept[5],
)

luckiOnto <- new_concept(new = ld$concept,
                         broader = left_join(ld %>% select(concept, label = broader), get_concept(label = ld$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         description = ld$description,
                         class = "dynamic",
                         ontology = luckiOnto)


### landuse ----
lu <- tribble(
  ~concept, ~description, ~broader,
  "Built-up land", "Areas that are assembled and non-productive with structures with various uses such as buildings, roads and rails that exlude primary sector uses.", ld$concept[3],
  "Energy production", "Areas that are assembled and non-productive with structures that are used for energy production that exlude primary sector uses.", ld$concept[3],
  "Agrovoltaics", "Areas that are assembled and productive with solar panels that are used in combination with plant production or livestock rearing.", ld$concept[4],
  "Protective Cover", "Areas that are assembled and productive with buildings that are used to produce plants, mushrooms or livestock under a roof where environmental conditions can be controlled.", ld$concept[4],
  "Herbaceous crops", "Areas with herbaceous vegetation used for crops that need one or two years before harvest (both for human and livestock uses).", ld$concept[5],
  "Fallow", "Areas with herbaceous vegetation currently not used, with an intention for crop production within 3 years.", ld$concept[5],
  "Cultivated grazingland", "Areas with herbaceous vegetation established through seeding, mowing or other means that is used for grazing.", ld$concept[5],
  "Naturally growing grazingland", "Areas with herbaceous vegetation established through natural regeneration (with sparse woody vegetation) that is used for grazing.", ld$concept[5],
  "Shrub orchards", "Areas with woody vegetation used for crops that grow on shrubs.", ld$concept[5],
  "Tree orchards", "Areas with woody vegetation used for crops that grow on trees other than palms.", ld$concept[5],
  "Palm plantations", "Areas with woody vegetation used for crops that grow on palms trees.", ld$concept[5],
  "Woody plantation", "Areas with woody vegetation used for wood or biomass production from even-aged trees of one or two tree species.", ld$concept[5],
  "Planted forest", "Areas with woody vegetation used for forestry and composed of trees established through planting and/or deliberate seeding.", ld$concept[5],
  "Naturally growing forest", "Areas with woody vegetation used for forestry and composed of trees established through natural regeneration.", ld$concept[5],
  "Mix of primary sector uses", "Areas with vegetation patches of various types (agroforestry, silvopastoral, shifting, etc) used for primary sector commodities.", ld$concept[5],
  "Other vegetated land", "Areas with vegetation that has no primary sector use (gardens, parks, sports, etc).", ld$concept[5],
  "Naturally growing biocrust", "Areas without intentional modifications of lichen and mosses", ld$concept[6],
  "Naturally growing grassland", "Areas without intentional modifications where the highest layer is composed of grasses and forbs.", ld$concept[6],
  "Naturally growing shrubland", "Areas without intentional modifications where the highest layer is composed of woody plants with more than one stem (shrubs).", ld$concept[6],
  "Naturally growing woodland", "Areas without intentional modifications where the highest layer is composed of woody plants with one central stem (trees).", ld$concept[6],
)

luckiOnto <- new_concept(new = lu$concept,
                         broader = left_join(lu %>% select(concept, label = broader), get_concept(label = lu$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         description = lu$description,
                         class = "use",
                         ontology = luckiOnto)

### crop production systems ----
#### groups ----
group <- tribble(
  ~concept, ~description, ~broader,
  "NON-FOOD CROPS", "This group comprises plants that are grown primarily for all sort of industrial, non-food related purposes.", domain$concept[2],
  "FRUIT", "This group comprises plants that are grown primarily to use their (typically sweet or sour) fleshy parts that are edible in a raw state.", domain$concept[2],
  "SEEDS", "This group comprises plants that are grown primarily to use their seeds as food source. 'Seed' is regarded as the reproductive organ that, when put into a suitable substrate, grows a new plant.", domain$concept[2],
  "STIMULANTING CROPS", "This group comprises plants that are grown primarily to make use of their medicinal effect, their taste or for their mind-altering effects.", domain$concept[2],
  "SUGAR CROPS", "This group comprises plants that are grown primarily for their sugar content.", domain$concept[2],
  "VEGETABLES", "This group comprises plants that are grown primarily to use their (typically savory) fleshy parts that are often heated to be easily digestible.", domain$concept[2],
  "BIRDS", "This group comprises birds that are used for their eggs or meat or to perform tasks they were trained for", domain$concept[2],
  "GLIRES", "This group comprises lagomorphs and rodents that are used for their meat or fur.", domain$concept[2],
  "UNGULATES", "This group comprises ungulates that are used for their milk, meat and skin or to perform tasks they were trained for.", domain$concept[2],
  "INSECTS", "This group comprises insects that are used for the substances they produce or directly for human consumption.", domain$concept[2],
  "OTHER ANIMALS", "This group comprises other animals that are used for various purposes.", domain$concept[2]
)

luckiOnto <- new_concept(new = group$concept,
                         broader = left_join(group %>% select(concept, label = broader), get_concept(label = group$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         description = group$description,
                         class = "group",
                         ontology = luckiOnto)

#### classes ----
class <- tribble(
  ~concept, ~description, ~broader,
  "Bioenergy crops", "This class covers plants that are primarily grown for the production of energy.", group$concept[1],
  "Fibre crops", "This class covers plants that are primarily grown because some plant part is used to produce textile fibres. Other uses of other plant parts, such as fruit or oilseeds are possible.", group$concept[1],
  "Flower crops", "This class covers plants that are primarily grown to use some of their parts for ornamental reasons.", group$concept[1],
  "Rubber crops", "This class covers plants that are grown to produce gums and rubbers.", group$concept[1],
  "Pasture and forage crops", "This class covers plants that are grown as food source for animals, to produce fodder/silage or to be grazed on by livestock (excluding vegetables).", group$concept[1],
  "Berries", "This class covers plants that are grown for their fruit that have small, soft roundish edible tissue.",group$concept[2],
  "Citrus Fruit", "This class covers plants that are part of the genus Citrus.", group$concept[2],
  "Grapes", "This class covers plants that are part of the genus Vitis.", group$concept[2],
  "Pome Fruit", "This class covers plants that are grown for their apple-like fruit.", group$concept[2],
  "Stone Fruit", "This class covers plants that are grown for their fruit that have a single hard stone and a fleshy, juicy edible tissue.", group$concept[2],
  "Oleaginous fruits", "This class covers plants that are grown for their oil-containing tissue.", group$concept[2],
  "Tropical and subtropical Fruit", "This class covers plants that grow in tropical and subtropical regions.", group$concept[2],
  "Cereals", "This class covers graminoid plants that are grown for their grain. This class also includes pseudocereals, as they are also grown for their grain.", group$concept[3],
  "Leguminous seeds", "This class covers leguminous plants that are grown for both, their dry and green seeds.", group$concept[3],
  "Treenuts", "This class covers plants that are grown for their dry seeds that are protected by a hard shell.", group$concept[3],
  "Oilseeds", "This class covers plants that are grown to use their seeds to produce oils for human nourishment.", group$concept[3],
  "Stimulant crops", "This class covers plants that are grown for their stimulating or mind-altering effects.", group$concept[4],
  "Spice crops", "This class covers plants that are grown for their aromatic properties.", group$concept[4],
  "Medicinal crops", "This class covers plants that are grown for their medical effects on the animal physiology.", group$concept[4],
  "Sugar crops", "This class covers plants that are primarily grown because some plant part is used to produce sugar. Other uses of other plant parts, such as fruit or oilseeds are possible.", group$concept[5],
  "Fruit-bearing vegetables", "This class covers plants that are grown to use their fruit as vegetables.", group$concept[6],
  "Leaf or stem vegetables", "This class covers plants that are grown to use their leaves or stem as vegetables.", group$concept[6],
  "Mushrooms and truffles", "This class covers mushrooms and truffles that are grown for human nourishment.", group$concept[6],
  "Root vegetables", "This class covers plants that are grown to use their roots, tubers or bulbs as vegetables.", group$concept[6],
  "Poultry", "This class covers all poultry birds.", group$concept[7],
  "Lagomorphs", "This class covers hares and rabbits.", group$concept[8],
  "Rodents", "This class covers various rodents.", group$concept[8],
  "Bovines", "This class covers bovine animals.", group$concept[9],
  "Caprines", "This class covers goats and sheep.", group$concept[9],
  "Camelids", "This class covers camels and lamas.", group$concept[9],
  "Equines", "This class covers horses, asses and mules.", group$concept[9],
  "Cervine", "This class covers deers, elks, roe deer, moose and other Cervidea.", group$concept[9],
  "Swine", "This class covers pigs and (domesticated) boar.", group$concept[9],
  "Insects", "This class covers insect species that produce substances that are used as human nourishment, such as honey or protein or substances that are used as fibres.", group$concept[10],
  "Canines", "This class covers all fox and wolf-like animals.", group$concept[11],
  "Mustelids", "This class covers all weasle-like animals.", group$concept[11]
)

luckiOnto <- new_concept(new = class$concept,
                         broader = left_join(class %>% select(concept, label = broader), get_concept(label = class$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         description = class$description,
                         class = "class",
                         ontology = luckiOnto)

#### commodities ----

##### Bioenergy crops ----
bioenergy <-
  tibble(concept = "acacia", broader = class$concept[1], scientific = "Acacia spp.",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q81666", gbif_id = "2978223",
         purpose = "energy", used_part = "biomass", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

bioenergy <-
  tibble(concept = "bamboo", broader = class$concept[1], scientific = "Bambusa spp.",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q311331|Q2157176", gbif_id = "2705751",
         purpose = "energy", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = "1", harvests = NA, height = "10") %>%
  bind_rows(bioenergy, .)

bioenergy <-
  tibble(concept = "black locust", broader = class$concept[1], scientific = "Robinia pseudoacacia",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q2019723", gbif_id = "5352251",
         purpose = "energy", used_part = "biomass", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(bioenergy, .)

bioenergy <-
  tibble(concept = "eucalyptus", broader = class$concept[1], scientific = "Eucalyptus spp.",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q45669", gbif_id = "7493935",
         purpose = "energy", used_part = "biomass", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(bioenergy, .)

bioenergy <-
  tibble(concept = "giant reed", broader = class$concept[1], scientific = "Arundo donax",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q161114", gbif_id = "2703041",
         purpose = "energy", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = "25", harvests = "2", height = "5") %>%
  bind_rows(bioenergy, .)

bioenergy <-
  tibble(concept = "miscanthus", broader = class$concept[1], scientific = "Miscanthus × giganteus",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q2152417", gbif_id = "4122678",
         purpose = "energy", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = "1", harvests = "1", height = "5") %>%
  bind_rows(bioenergy, .)

bioenergy <-
  tibble(concept = "poplar", broader = class$concept[1], scientific = "Populus spp.",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q25356", gbif_id = "3040183",
         purpose = "energy", used_part = "biomass", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(bioenergy, .)

bioenergy <-
  tibble(concept = "reed canary grass", broader = class$concept[1], scientific = "Phalaris arundinacea",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q157419", gbif_id = "5289756",
         purpose = "energy", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = "1", harvests = NA, height = "2") %>%
  bind_rows(bioenergy, .)

bioenergy <-
  tibble(concept = "switchgrass", broader = class$concept[1], scientific = "Panicum virgatum",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q1466543", gbif_id = "2705081",
         purpose = "energy", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = "1", harvests = NA, height = "5") %>%
  bind_rows(bioenergy, .)

bioenergy <-
  tibble(concept = "willow", broader = class$concept[1], scientific = "Salix spp.",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q36050", gbif_id = "3039576",
         purpose = "energy", used_part = "biomass", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(bioenergy, .)

luckiOnto <- new_concept(new = bioenergy$concept,
                         broader = left_join(bioenergy %>% select(concept, label = broader), get_concept(label = bioenergy$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)


##### Fibre crops ----
fibre <-
  tibble(concept = "jute", broader = class$concept[2], scientific = "Corchorus spp.",
         icc_id = "9.02.01.02", cpc_id = "01922.01", wiki_id = "Q107211|Q161489", gbif_id = "3032212",
         purpose = "fibre", used_part = "bast", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "3", height = "5")

fibre <-
  tibble(concept = "kenaf", broader = class$concept[2], scientific = "Hibiscus cannabinus",
         icc_id = "9.02.01.02", cpc_id = "01922.02", wiki_id = "Q1137540", gbif_id = "3152547",
         purpose = "fibre", used_part = "bast", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "4", height = "5") %>%
  bind_rows(fibre, .)

fibre <-
  tibble(concept = "ramie", broader = class$concept[2], scientific = "Boehmeria nivea",
         icc_id = "9.02.02.01", cpc_id = "01929.04", wiki_id = "Q2130134|Q750467", gbif_id = "2984359",
         purpose = "fibre", used_part = "bast", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "6", height = "2") %>%
  bind_rows(fibre, .)

fibre <-
  tibble(concept = "abaca|manila hemp", broader = class$concept[2], scientific = "Musa textilis",
         icc_id = "9.02.02.90", cpc_id = "01929.07", wiki_id = "Q161097", gbif_id = "2762907",
         purpose = "fibre", used_part = "leaves", life_form = "tree",
         ybh = "2", yoh = "40", harvests = "4", height = "5") %>%
  bind_rows(fibre, .)

fibre <-
  tibble(concept = "sisal", broader = class$concept[2], scientific = "Agave sisalana",
         icc_id = "9.02.02.02", cpc_id = "01929.05", wiki_id = "Q159221|Q847423", gbif_id = "2766636",
         purpose = "fibre", used_part = "leaves", life_form = "tree",
         ybh = NA, yoh = NA, harvests = "2", height = "2") %>%
  bind_rows(fibre, .)

fibre <-
  tibble(concept = "kapok", broader = class$concept[2], scientific = "Ceiba pentandra",
         icc_id = "9.02.02.90", cpc_id = "01929.03|01499.05", wiki_id = "Q1728687|Q138617", gbif_id = "5406697",
         purpose = "fibre|food", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fibre, .)

fibre <-
  tibble(concept = "new zealand flax|formio", broader = class$concept[2], scientific = "Phormium tenax",
         icc_id = "9.02.01.04", cpc_id = "01929", wiki_id = "Q607380", gbif_id = "2778511",
         purpose = "fibre", used_part = "stalk", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fibre, .)

fibre <-
  tibble(concept = "fique", broader = class$concept[2], scientific = "Furcraea macrophylla",
         icc_id = "9.02.01.90", cpc_id = "01929", wiki_id = "Q1474889", gbif_id = "2769812",
         purpose = "fibre", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fibre, .)

fibre <-
  tibble(concept = "henequen", broader = class$concept[2], scientific = "Agave fourcroydes",
         icc_id = "9.02.02", cpc_id = "01929", wiki_id = "Q136120", gbif_id = "2767123",
         purpose = "fibre", used_part = "food|leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fibre, .)

fibre <-
  tibble(concept = "maguey", broader = class$concept[2], scientific = "Agave atrovirens",
         icc_id = "9.02.02", cpc_id = "01929", wiki_id = "Q2714978", gbif_id = "2766552",
         purpose = "fibre", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fibre, .)

# fibre <-
#   tibble(concept = "mallow", broader = class$concept[2], scientific = "",
#          icc_id = "", cpc_id = "", wiki_id = "Q147325", gbif_id = "3152364",
#          purpose = "fibre", used_part = "leaves", life_form = "vine",
#          ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
#   bind_rows(fibre, .)

luckiOnto <- new_concept(new = fibre$concept,
                         broader = left_join(fibre %>% select(concept, label = broader), get_concept(label = fibre$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Rubber crops ----
rubber <-
  tibble(concept = "natural rubber", broader = class$concept[4], scientific = "Hevea brasiliensis",
         icc_id = "9.04", cpc_id = "01950", wiki_id = "Q131877", gbif_id = "3071171",
         purpose = "industrial", used_part = "sap", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

luckiOnto <- new_concept(new = rubber$concept,
                         broader = left_join(rubber %>% select(concept, label = broader), get_concept(label = rubber$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Pasture and forage crops ----
pasture <-
  tibble(concept = "alfalfa", broader = class$concept[5], scientific = "Medicago sativa",
         icc_id = "9.01.01", cpc_id = "01912|01940", wiki_id = "Q156106", gbif_id = "9151957",
         purpose = "food|forage|fodder", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

pasture <-
  tibble(concept = "orchard grass", broader = class$concept[5], scientific = "Dactylis glomerata",
         icc_id = "9.01.01", cpc_id = "01919.91", wiki_id = "Q161735", gbif_id = "2705308",
         purpose = "forage|fodder", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pasture, .)

pasture <-
  tibble(concept = "redtop", broader = class$concept[5], scientific = "Agrostis spp.",
         icc_id = "9.90.01", cpc_id = "01919.91", wiki_id = "Q27835", gbif_id = "2706434",
         purpose = "forage", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pasture, .)

pasture <-
  tibble(concept = "ryegrass", broader = class$concept[5], scientific = "Lolium spp.",
         icc_id = "9.90.01", cpc_id = "01919.02", wiki_id = "Q158509", gbif_id = "2706217",
         purpose = "forage", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pasture, .)

pasture <-
  tibble(concept = "sudan grass", broader = class$concept[5], scientific = "Sorghum × drummondii",
         icc_id = "9.01.01", cpc_id = "01919", wiki_id = "Q332062", gbif_id = "2705184",
         purpose = "energy|fodder", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pasture, .)

pasture <-
  tibble(concept = "timothy", broader = class$concept[5], scientific = "Phleum pratense",
         icc_id = "9.01.01", cpc_id = "01919.91", wiki_id = "Q256508", gbif_id = "9014945",
         purpose = "fodder", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pasture, .)

pasture <-
  tibble(concept = "bahiagrass", broader = class$concept[5], scientific = "Paspalum notatum",
         icc_id = "9.01.01", cpc_id = "01919.91", wiki_id = "Q1010817", gbif_id = "2705621",
         purpose = "forage", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pasture, .)

pasture <-
  tibble(concept = "bluegrass", broader = class$concept[5], scientific = "Poa pratensis",
         icc_id = "9.01.01", cpc_id = "01919.91", wiki_id = "Q147783", gbif_id = "2704178",
         purpose = "fodder", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pasture, .)

pasture <-
  tibble(concept = "bentgrass", broader = class$concept[5], scientific = "Agrostis spp.",
         icc_id = "9.01.01", cpc_id = "01919.91", wiki_id = "Q161137", gbif_id = "2706434",
         purpose = "fodder", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pasture, .)

pasture <-
  tibble(concept = "bermudagrass", broader = class$concept[5], scientific = "Cynodon dactylon",
         icc_id = "9.01.01", cpc_id = "01919.91", wiki_id = "Q208705", gbif_id = "6109637",
         purpose = "fodder", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pasture, .)

pasture <-
  tibble(concept = "bromegrass", broader = class$concept[5], scientific = "Bromus spp.",
         icc_id = "9.01.01", cpc_id = "01919.91", wiki_id = "Q147621", gbif_id = "2703642",
         purpose = "fodder", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pasture, .)

pasture <-
  tibble(concept = "fescue", broader = class$concept[5], scientific = "Festuca spp.",
         icc_id = "9.01.01", cpc_id = "01919.91", wiki_id = "Q157337", gbif_id = "2704913",
         purpose = "fodder", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pasture, .)

pasture <-
  tibble(concept = "trefoil", broader = class$concept[5], scientific = "Lotus spp.",
         icc_id = "9.90.01", cpc_id = "01919.92", wiki_id = "Q101538", gbif_id = "10220564",
         purpose = "forage", used_part = "biomass", life_form = "graminoid",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pasture, .)

pasture <-
  tibble(concept = "clover", broader = class$concept[5], scientific = "Trifolium spp.",
         icc_id = "9.01.01", cpc_id = "01919.03", wiki_id = "Q101538", gbif_id = "2973363",
         purpose = "forage|fodder", used_part = "biomass", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pasture, .)

pasture <-
  tibble(concept = "lupin", broader = class$concept[5], scientific = "Lupinus spp.",
         icc_id = "7.06", cpc_id = "01709.02", wiki_id = "Q156811", gbif_id = "2963774",
         purpose = "food|forage|fodder", used_part = "biomass", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pasture, .)

luckiOnto <- new_concept(new = pasture$concept,
                         broader = left_join(pasture %>% select(concept, label = broader), get_concept(label = pasture$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Berries ----
berries <-
  tibble(concept = "blueberry", broader = class$concept[6], scientific = "Vaccinium myrtillus|Vaccinium corymbosum",
         icc_id = "3.04.06", cpc_id = "01355.01", wiki_id = "Q13178", gbif_id = "2882833|2882849",
         purpose = "food", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

berries <-
  tibble(concept = "cranberry", broader = class$concept[6], scientific = "Vaccinium macrocarpon|Vaccinium oxycoccus",
         icc_id = "3.04.07", cpc_id = "01355.02", wiki_id = "Q374399|Q13181|Q21546387", gbif_id = "7777960|2882949",
         purpose = "food", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(berries, .)

berries <-
  tibble(concept = "currant", broader = class$concept[6], scientific = "Ribes spp.",
         icc_id = "3.04.01", cpc_id = "01351.01", wiki_id = "Q3241599", gbif_id = "2986095",
         purpose = "food", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(berries, .)

berries <-
  tibble(concept = "gooseberry", broader = class$concept[6], scientific = "Ribes spp.",
         icc_id = "3.04.02", cpc_id = "01351.02", wiki_id = "Q41503|Q17638951", gbif_id = "2986095",
         purpose = "food", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(berries, .)

berries <-
  tibble(concept = "kiwi fruit", broader = class$concept[6], scientific = "Actinidia deliciosa",
         icc_id = "3.04.03", cpc_id = "01352", wiki_id = "Q13194", gbif_id = "7270761",
         purpose = "food", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(berries, .)

berries <-
  tibble(concept = "raspberry", broader = class$concept[6], scientific = "Rubus spp.",
         icc_id = "3.04.04", cpc_id = "01353.01", wiki_id = "Q12252383|Q13179", gbif_id = "2988638",
         purpose = "food", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(berries, .)

berries <-
  tibble(concept = "strawberry", broader = class$concept[6], scientific = "Fragaria spp.",
         icc_id = "3.04.05", cpc_id = "01354", wiki_id = "Q745|Q13158", gbif_id = "3029779",
         purpose = "food", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(berries, .)

berries <-
  tibble(concept = "aroniaberry", broader = class$concept[6], scientific = "Aronia spp.",
         icc_id = "3.04.90", cpc_id = "01359", wiki_id = "Q158983", gbif_id = "2988529",
         purpose = "food", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(berries, .)

berries <-
  tibble(concept = "elderberry", broader = class$concept[6], scientific = "Sambucus spp.",
         icc_id = "3.04.90", cpc_id = "01359", wiki_id = "Q131448", gbif_id = "2888721",
         purpose = "food", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(berries, .)

berries <-
  tibble(concept = "rose", broader = class$concept[6], scientific = "Rosa spp.",
         icc_id = "3.04.90", cpc_id = "01359", wiki_id = "Q34687|Q46740", gbif_id = "8395064",
         purpose = "food", used_part = "fruit|leaves|buds", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(berries, .)

berries <-
  tibble(concept = "rowan", broader = class$concept[6], scientific = "Sorbus aucuparia",
         icc_id = "3.04.90", cpc_id = "01359", wiki_id = "Q146198", gbif_id = "3012167",
         purpose = "food", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(berries, .)

berries <-
  tibble(concept = "sea-buckthorn", broader = class$concept[6], scientific = "Hippophae rhamnoides",
         icc_id = "3.04.90", cpc_id = "01359", wiki_id = "Q165378", gbif_id = "3039285",
         purpose = "food", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(berries, .)


luckiOnto <- new_concept(new = berries$concept,
                         broader = left_join(berries %>% select(concept, label = broader), get_concept(label = berries$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Citrus Fruit ----
citrus <-
  tibble(concept = "bergamot", broader = class$concept[7], scientific = "Citrus bergamia",
         icc_id = "3.02.90", cpc_id = "01329", wiki_id = "Q109196", gbif_id = "6433772",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

citrus <-
  tibble(concept = "clementine|mandarine", broader = class$concept[7], scientific = "Citrus reticulata",
         icc_id = "3.02.04", cpc_id = "01324.02", wiki_id = "Q460517|Q125337", gbif_id = "3190172",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(citrus, .)

citrus <-
  tibble(concept = "grapefruit", broader = class$concept[7], scientific = "Citrus paradisi",
         icc_id = "3.02.01", cpc_id = "01321", wiki_id = "Q21552830", gbif_id = "7469645",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(citrus, .)

citrus <-
  tibble(concept = "lemon", broader = class$concept[7], scientific = "Citrus limon",
         icc_id = "3.02.02", cpc_id = "01322", wiki_id = "Q500|Q1093742", gbif_id = "9198046",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(citrus, .)

citrus <-
  tibble(concept = "lime", broader = class$concept[7], scientific = "Citrus limetta|Citrus aurantifolia",
         icc_id = "3.02.02", cpc_id = "01322", wiki_id = "Q13195", gbif_id = "3190169|3190164",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(citrus, .)

citrus <-
  tibble(concept = "orange", broader = class$concept[7], scientific = "Citrus aurantium",
         icc_id = "3.02.03", cpc_id = "01323", wiki_id = "Q147096", gbif_id = "8077391",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(citrus, .)

citrus <-
  tibble(concept = "pomelo", broader = class$concept[7], scientific = "Citrus grandis",
         icc_id = "3.02.01", cpc_id = "01321", wiki_id = "Q353817|Q80024", gbif_id = "3190161",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(citrus, .)

citrus <-
  tibble(concept = "satsuma", broader = class$concept[7], scientific = "Citrus reticulata",
         icc_id = "3.02.04", cpc_id = "01324", wiki_id = "Q875262", gbif_id = "3190172",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(citrus, .)

citrus <-
  tibble(concept = "tangerine", broader = class$concept[7], scientific = "Citrus reticulata",
         icc_id = "3.02.04", cpc_id = "01324.01", wiki_id = "Q516494", gbif_id = "3190172",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(citrus, .)

luckiOnto <- new_concept(new = citrus$concept,
                         broader = left_join(citrus %>% select(concept, label = broader), get_concept(label = citrus$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Grapes ----
grapes <-
  tibble(concept = "grape", broader = class$concept[8], scientific = "Vitis vinifera",
         icc_id = "3.03", cpc_id = "01330", wiki_id = "Q10978|Q191019", gbif_id = "5372392",
         purpose = "food", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = "2")

luckiOnto <- new_concept(new = grapes$concept,
                         broader = left_join(grapes %>% select(concept, label = broader), get_concept(label = grapes$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Pome Fruit ----
pome <-
  tibble(concept = "apple", broader = class$concept[9], scientific = "Malus sylvestris",
         icc_id = "2.05.01", cpc_id = "01341", wiki_id = "Q89|Q15731356", gbif_id = "3001509",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

pome <-
  tibble(concept = "loquat", broader = class$concept[9], scientific = "Eriobotrya japonica",
         icc_id = "3.05.90", cpc_id = "01359", wiki_id = "Q41505", gbif_id = "3024146",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pome, .)

pome <-
  tibble(concept = "medlar", broader = class$concept[9], scientific = "Mespilus germanica",
         icc_id = "3.05.90", cpc_id = "01359", wiki_id = "Q146186|Q3092517", gbif_id = "3031774",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pome, .)

pome <-
  tibble(concept = "pear", broader = class$concept[9], scientific = "Pyrus communis",
         icc_id = "3.05.05", cpc_id = "01342.01", wiki_id = "Q434|Q13099586", gbif_id = "5362573",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pome, .)

pome <-
  tibble(concept = "quince", broader = class$concept[9], scientific = "Cydonia oblonga",
         icc_id = "3.05.05", cpc_id = "01342.02", wiki_id = "Q2751465|Q43300", gbif_id = "5362215",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pome, .)

pome <-
  tibble(concept = "amelanchier", broader = class$concept[9], scientific = "Amelanchier spp.",
         icc_id = "3.05.90", cpc_id = "01349.10", wiki_id = "Q156957", gbif_id = "3023817",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(pome, .)

luckiOnto <- new_concept(new = pome$concept,
                         broader = left_join(pome %>% select(concept, label = broader), get_concept(label = pome$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Stone Fruit ----
stone <-
  tibble(concept = "apricot", broader = class$concept[10], scientific = "Prunus armeniaca",
         icc_id = "3.05.02", cpc_id = "01343", wiki_id = "Q37453|Q3733836", gbif_id = "7818643",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

stone <-
  tibble(concept = "cherry", broader = class$concept[10], scientific = "Prunus avium",
         icc_id = "3.05.03", cpc_id = "01344.02", wiki_id = "Q196", gbif_id = "3020791",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(stone, .)

stone <-
  tibble(concept = "nectarin|peach", broader = class$concept[10], scientific = "Prunus persica",
         icc_id = "3.05.04", cpc_id = "01345", wiki_id = "Q2724976|Q83165|Q13189", gbif_id = "8149923",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(stone, .)

stone <-
  tibble(concept = "plum", broader = class$concept[10], scientific = "Prunus domestica",
         icc_id = "3.05.06", cpc_id = "01346", wiki_id = "Q6401215|Q13223298", gbif_id = "7931731",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(stone, .)

stone <-
  tibble(concept = "sloe", broader = class$concept[10], scientific = "Prunus spinosa",
         icc_id = "3.05.06", cpc_id = "01346", wiki_id = "Q12059685|Q129018", gbif_id = "3023221",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(stone, .)

stone <-
  tibble(concept = "sour cherry", broader = class$concept[10], scientific = "Prunus cerasus",
         icc_id = "3.05.03", cpc_id = "01344.01", wiki_id = "Q68438267|Q131517", gbif_id = "3021922",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(stone, .)

luckiOnto <- new_concept(new = stone$concept,
                         broader = left_join(stone %>% select(concept, label = broader), get_concept(label = stone$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Oleaginous fruits ----
oleaginous <-
  tibble(concept = "coconut", broader = class$concept[11], scientific = "Cocos nucifera",
         icc_id = "4.04.01|9.02.02.90", cpc_id = "01460|01929.08", wiki_id = "Q3342808", gbif_id = "2735117",
         purpose = "fibre|food", used_part = "seed", life_form = "shrub",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

oleaginous <-
  tibble(concept = "oil palm", broader = class$concept[11], scientific = "Elaeis guineensis",
         icc_id = "4.04.03", cpc_id = "01491", wiki_id = "Q165403", gbif_id = "2731882",
         purpose = "food", used_part = "seed", life_form = "shrub",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oleaginous, .)

oleaginous <-
  tibble(concept = "olive", broader = class$concept[11], scientific = "Olea europaea",
         icc_id = "4.04.02", cpc_id = "01450", wiki_id = "Q37083|Q1621080", gbif_id = "5415040",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oleaginous, .)

luckiOnto <- new_concept(new = oleaginous$concept,
                         broader = left_join(oleaginous %>% select(concept, label = broader), get_concept(label = oleaginous$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Tropical and subtropical Fruit ----
tropical <-
  tibble(concept = "avocado", broader = class$concept[12], scientific = "Persea americana",
         icc_id = "3.01.01", cpc_id = "01311", wiki_id = "Q961769|Q37153", gbif_id = "3034046",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

tropical <-
  tibble(concept = "banana", broader = class$concept[12], scientific = "Musa sapientum|Musa cavendishii|Musa nana",
         icc_id = "3.01.02", cpc_id = "01312", wiki_id = "Q503|Q10757112|Q132970", gbif_id = "2762752|2762680",
         purpose = "fibre|food", used_part = "fruit|leaves", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "guava", broader = class$concept[12], scientific = "Psidium guajava",
         icc_id = "3.01.06", cpc_id = "01316.02", wiki_id = "Q166843|Q3181909", gbif_id = "5420380",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "mango", broader = class$concept[12], scientific = "Mangifera indica",
         icc_id = "3.01.06", cpc_id = "01316.01", wiki_id = "Q169", gbif_id = "3190638",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "mangosteen", broader = class$concept[12], scientific = "Garcinia mangostana",
         icc_id = "3.01.06", cpc_id = "01316.03", wiki_id = "Q170662|Q104030000", gbif_id = "3189571",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "papaya", broader = class$concept[12], scientific = "Carica papaya",
         icc_id = "3.01.07", cpc_id = "01317", wiki_id = "Q34887", gbif_id = "2874484",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "persimmon", broader = class$concept[12], scientific = "Diospyros kaki|Diospyros virginiana",
         icc_id = "3.01.90", cpc_id = "01359.01", wiki_id = "Q158482|Q29526", gbif_id = "3032984|3032986",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "plantain", broader = class$concept[12], scientific = "Musa paradisiaca",
         icc_id = "3.01.03", cpc_id = "01313", wiki_id = "Q165449", gbif_id = "2762752",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "açaí", broader = class$concept[12], scientific = "Euterpe oleracea",
         icc_id = "3.01.9", cpc_id = "01319", wiki_id = "Q33943|Q12300487", gbif_id = "5293398",
         purpose = "food", used_part = "fruit", life_form = "shrub",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "date", broader = class$concept[12], scientific = "Phoenix dactylifera",
         icc_id = "3.01.04", cpc_id = "01314", wiki_id = "Q1652093", gbif_id = "6109699",
         purpose = "food", used_part = "fruit", life_form = "shrub",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "pineapple", broader = class$concept[12], scientific = "Ananas comosus",
         icc_id = "3.01.08", cpc_id = "01318", wiki_id = "Q1493|Q10817602", gbif_id = "5288819",
         purpose = "food", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "fig", broader = class$concept[12], scientific = "Ficus carica",
         icc_id = "3.01.05", cpc_id = "01315", wiki_id = "Q36146|Q2746643", gbif_id = "5361909",
         purpose = "food", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "sapodilla", broader = class$concept[12], scientific = "Achras sapota",
         icc_id = "3.90", cpc_id = "01319", wiki_id = "Q14959", gbif_id = "2885158",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "litchi", broader = class$concept[12], scientific = "Litchi chinensis",
         icc_id = "3.01.90", cpc_id = "01319", wiki_id = "Q13182", gbif_id = "3190002",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "custardapple", broader = class$concept[12], scientific = "Annona reticulate",
         icc_id = "3.01.90", cpc_id = "01319", wiki_id = "Q472653", gbif_id = "5407123",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "breadfruit", broader = class$concept[12], scientific = "Artocarpus altilis",
         icc_id = "3.01.90", cpc_id = "01319", wiki_id = "Q14677", gbif_id = "2984573",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "mulberry", broader = class$concept[12], scientific = "Morus spp.",
         icc_id = "3.90", cpc_id = "01319", wiki_id = "Q44789", gbif_id = "2984545",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "pomegranate", broader = class$concept[12], scientific = "Punica granatum",
         icc_id = "3.90", cpc_id = "01319", wiki_id = "Q13188|Q13222088", gbif_id = "5420901",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "durian", broader = class$concept[12], scientific = "Durio zibethinus",
         icc_id = "3.90", cpc_id = "01319", wiki_id = "Q1135236", gbif_id = "3152230",
         purpose = "food", used_part = "fruit|seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "jackfruit", broader = class$concept[12], scientific = "Artocarpus heterophyllus",
         icc_id = "3.90", cpc_id = "01319", wiki_id = "Q45757", gbif_id = "2984565",
         purpose = "food", used_part = "fruit|seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "passionfruit", broader = class$concept[12], scientific = "Passiflora edulis",
         icc_id = "3.90", cpc_id = "01319", wiki_id = "Q156790", gbif_id = "2874190",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "ackee", broader = class$concept[12], scientific = "Blighia sapida",
         icc_id = "3.90", cpc_id = "01319", wiki_id = "Q417145", gbif_id = "3189955",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = "10") %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "pepinos", broader = class$concept[12], scientific = "Solanum muricatum",
         icc_id = "3.90", cpc_id = "01319", wiki_id = "Q135928", gbif_id = "2931290",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "bilimbi", broader = class$concept[12], scientific = "Averrhoa bilimbi",
         icc_id = "3.90", cpc_id = "01319", wiki_id = "Q237465", gbif_id = "2891640",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "starfruit", broader = class$concept[12], scientific = "Averrhoa carambola",
         icc_id = "3.90", cpc_id = "01319", wiki_id = "Q159447", gbif_id = "9407103",
         purpose = "food|medicinal", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(tropical, .)

tropical <-
  tibble(concept = "cherimoya", broader = class$concept[12], scientific = "Annona cherimola",
         icc_id = "3.90", cpc_id = "01319", wiki_id = "Q158986", gbif_id = "5407147",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = "9") %>%
  bind_rows(tropical, .)


luckiOnto <- new_concept(new = tropical$concept,
                         broader = left_join(tropical %>% select(concept, label = broader), get_concept(label = tropical$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Cereals ----
cereals <-
  tibble(concept = "barley", broader = class$concept[13], scientific = "Hordeum vulgare",
         icc_id = "1.05", cpc_id = "0115", wiki_id = "Q11577", gbif_id = "2706056",
         purpose = "food|forage", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA)

cereals <-
  tibble(concept = "maize", broader = class$concept[13], scientific = "Zea mays",
         icc_id = "1.02", cpc_id = "01121|01911", wiki_id = "Q11575|Q25618328", gbif_id = "5290052",
         purpose = "food|silage", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "pearl millet", broader = class$concept[13], scientific = "Cenchrus americanus",
         icc_id = "1.08", cpc_id = "0118", wiki_id = "Q50840653", gbif_id = "5828197",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "finger millet", broader = class$concept[13], scientific = "Eleusine coracana",
         icc_id = "1.08", cpc_id = "0118", wiki_id = "Q932258", gbif_id = "2705957",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "foxtail millet", broader = class$concept[13], scientific = "Setaria italica",
         icc_id = "1.08", cpc_id = "0118", wiki_id = "Q161211", gbif_id = "5828197",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "japanese millet", broader = class$concept[13], scientific = "Echinochloa esculenta",
         icc_id = "1.08", cpc_id = "0118", wiki_id = "Q2061528", gbif_id = "2702798",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "proso millet", broader = class$concept[13], scientific = "Panicum miliaceum",
         icc_id = "1.08", cpc_id = "0118", wiki_id = "Q165196", gbif_id = "2705090",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "oat", broader = class$concept[13], scientific = "Avena sativa",
         icc_id = "1.07", cpc_id = "0117", wiki_id = "Q165403|Q4064203", gbif_id = "2705290",
         purpose = "food|fodder", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "triticale", broader = class$concept[13], scientific = "Triticosecale",
         icc_id = "1.09", cpc_id = "01191", wiki_id = "Q380329", gbif_id = "2703325",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "buckwheat", broader = class$concept[13], scientific = "Fagopyrum esculentum",
         icc_id = "1.1", cpc_id = "01192", wiki_id = "Q132734|Q4536337", gbif_id = "2889373",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "canary seed", broader = class$concept[13], scientific = "Phalaris canariensis",
         icc_id = "1.13", cpc_id = "01195", wiki_id = "Q2086586", gbif_id = "5289744",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "fonio", broader = class$concept[13], scientific = "Digitaria exilis|Digitaria iburua",
         icc_id = "1.11", cpc_id = "01193", wiki_id = "Q1340738|Q12439809", gbif_id = "5289953",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "quinoa", broader = class$concept[13], scientific = "Chenopodium quinoa",
         icc_id = "1.12", cpc_id = "01194", wiki_id = "Q104030862|Q139925", gbif_id = "3083935",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "rice", broader = class$concept[13], scientific = "Oryza sativa",
         icc_id = "1.03", cpc_id = "0113", wiki_id = "Q5090|Q161426", gbif_id = "2703459",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "african rice", broader = class$concept[13], scientific = "Oryza glaberrima",
         icc_id = "1.03", cpc_id = "0113", wiki_id = "Q2670252", gbif_id = "2703464",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "rye", broader = class$concept[13], scientific = "Secale cereale",
         icc_id = "1.06", cpc_id = "0116", wiki_id = "Q5090|Q161426", gbif_id = "2705966",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "sorghum", broader = class$concept[13], scientific = "Sorghum bicolor",
         icc_id = "1.04", cpc_id = "0114|01919.01", wiki_id = "Q12099", gbif_id = "2705181",
         purpose = "food|fodder", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "teff", broader = class$concept[13], scientific = "Eragrostis tef",
         icc_id = "1.9", cpc_id = "01199.01", wiki_id = "Q843942|Q103205493", gbif_id = "2705325",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "wheat", broader = class$concept[13], scientific = "Triticum aestivum",
         icc_id = "1.01", cpc_id = "0111", wiki_id = "Q161098", gbif_id = "7795888",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "durum", broader = class$concept[13], scientific = "Triticum durum",
         icc_id = "1.01", cpc_id = "0111", wiki_id = "Q618324", gbif_id = "2706389",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

cereals <-
  tibble(concept = "spelt", broader = class$concept[13], scientific = "Triticum spelta",
         icc_id = "1.01", cpc_id = "0111", wiki_id = "Q158767", gbif_id = "2706402",
         purpose = "food", used_part = "seed", life_form = "graminoid",
         ybh = "0", yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(cereals, .)

luckiOnto <- new_concept(new = cereals$concept,
                         broader = left_join(cereals %>% select(concept, label = broader), get_concept(label = cereals$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Leguminous seeds ----
legumes <-
  tibble(concept = "bambara bean", broader = class$concept[14], scientific = "Vigna subterranea",
         icc_id = "7.09", cpc_id = "01708", wiki_id = "Q107357073", gbif_id = "2982714",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

legumes <-
  tibble(concept = "common bean", broader = class$concept[14], scientific = "Phaseolus vulgaris",
         icc_id = "7.01", cpc_id = "01701", wiki_id = "Q42339|Q2987371", gbif_id = "5350452",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(legumes, .)

legumes <-
  tibble(concept = "broad bean", broader = class$concept[14], scientific = "Vicia faba",
         icc_id = "7.02", cpc_id = "01702", wiki_id = "Q131342|Q61672189", gbif_id = "2974832",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(legumes, .)

legumes <-
  tibble(concept = "chickpea", broader = class$concept[14], scientific = "Cicer arietinum",
         icc_id = "7.03", cpc_id = "01703", wiki_id = "Q81375|Q21156930", gbif_id = "2947311",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(legumes, .)

legumes <-
  tibble(concept = "cow pea", broader = class$concept[14], scientific = "Vigna unguiculata",
         icc_id = "7.04", cpc_id = "01706", wiki_id = "Q107414065", gbif_id = "2982583",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(legumes, .)

legumes <-
  tibble(concept = "lentil", broader = class$concept[14], scientific = "Lens culinaris",
         icc_id = "7.05", cpc_id = "01704", wiki_id = "Q61505177|Q131226", gbif_id = "5350010",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(legumes, .)

legumes <-
  tibble(concept = "pea", broader = class$concept[14], scientific = "Pisum sativum",
         icc_id = "7.07", cpc_id = "01705", wiki_id = "Q13189|Q13202263", gbif_id = "5347845",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(legumes, .)

legumes <-
  tibble(concept = "pigeon pea", broader = class$concept[14], scientific = "Cajanus cajan",
         icc_id = "7.08", cpc_id = "01707", wiki_id = "Q632559|Q103449274", gbif_id = "7587087",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(legumes, .)

legumes <-
  tibble(concept = "vetch", broader = class$concept[14], scientific = "Vicia sativa",
         icc_id = "7.1", cpc_id = "01709.01", wiki_id = "Q157071", gbif_id = "2975014",
         purpose = "food|fodder", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(legumes, .)

legumes <-
  tibble(concept = "carob", broader = class$concept[14], scientific = "Ceratonia siliqua",
         icc_id = "3.9", cpc_id = "01356", wiki_id = "Q8195444|Q68763", gbif_id = "5356354",
         purpose = "food", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(legumes, .)

luckiOnto <- new_concept(new = legumes$concept,
                         broader = left_join(legumes %>% select(concept, label = broader), get_concept(label = legumes$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Treenuts ----
nuts <-
  tibble(concept = "almond", broader = class$concept[15], scientific = "Prunus dulcis",
         icc_id = "3.06.01", cpc_id = "01371", wiki_id = "Q184357|Q15545507", gbif_id = "3022502",
         purpose = "food", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

nuts <-
  tibble(concept = "areca nut", broader = class$concept[15], scientific = "Areca catechu",
         icc_id = "3.06.08", cpc_id = "01379.01", wiki_id = "Q1816679|Q156969", gbif_id = "2736531",
         purpose = "food", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(nuts, .)

nuts <-
  tibble(concept = "brazil nut", broader = class$concept[15], scientific = "Bertholletia excelsa",
         icc_id = "3.06.07", cpc_id = "01377", wiki_id = "Q12371971", gbif_id = "3083180",
         purpose = "food", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(nuts, .)

nuts <-
  tibble(concept = "cashew", broader = class$concept[15], scientific = "Anacardium occidentale",
         icc_id = "3.06.02", cpc_id = "01372", wiki_id = "Q7885904|Q34007", gbif_id = "5421368",
         purpose = "food", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(nuts, .)

nuts <-
  tibble(concept = "chestnut", broader = class$concept[15], scientific = "Castanea sativa",
         icc_id = "3.06.03", cpc_id = "01373", wiki_id = "Q773987", gbif_id = "5333294",
         purpose = "food", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(nuts, .)

nuts <-
  tibble(concept = "hazelnut|filbert", broader = class$concept[15], scientific = "Corylus avellana",
         icc_id = "3.06.04", cpc_id = "01374", wiki_id = "Q578307|Q104738415", gbif_id = "2875979",
         purpose = "food", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(nuts, .)

nuts <-
  tibble(concept = "kolanut", broader = class$concept[15], scientific = "Cola acuminata|Cola nitida|Cola vera",
         icc_id = "3.06.09", cpc_id = "01379.02", wiki_id = "Q114264|Q912522", gbif_id = "5406685|5406687",
         purpose = "food", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(nuts, .)

nuts <-
  tibble(concept = "macadamia", broader = class$concept[15], scientific = "Macadamia integrifolia|Macadamia tetraphylla",
         icc_id = "3.06.90", cpc_id = "01379", wiki_id = "Q310041|Q11027461", gbif_id = "2891785|2891787",
         purpose = "food", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(nuts, .)

nuts <-
  tibble(concept = "pecan", broader = class$concept[15], scientific = "Carya illinoensis",
         icc_id = "3.06.90", cpc_id = "01379", wiki_id = "Q333877|Q1119911", gbif_id = "4205617",
         purpose = "food", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(nuts, .)

nuts <-
  tibble(concept = "pistachio", broader = class$concept[15], scientific = "Pistacia vera",
         icc_id = "3.06.05", cpc_id = "01375", wiki_id = "Q14959225|Q36071", gbif_id = "3190585",
         purpose = "food", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(nuts, .)

nuts <-
  tibble(concept = "walnut", broader = class$concept[15], scientific = "Juglans spp.",
         icc_id = "3.06.06", cpc_id = "01376", wiki_id = "Q208021|Q46871", gbif_id = "3054350",
         purpose = "food", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(nuts, .)

luckiOnto <- new_concept(new = nuts$concept,
                         broader = left_join(nuts %>% select(concept, label = broader), get_concept(label = nuts$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Oilseeds ----
oilseeds <-
  tibble(concept = "castor bean", broader = class$concept[16], scientific = "Ricinus communis",
         icc_id = "4.03.01", cpc_id = "01447", wiki_id = "Q64597240|Q155867", gbif_id = "5380041",
         purpose = "food|medicinal", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

oilseeds <-
  tibble(concept = "cotton", broader = class$concept[16], scientific = "Gossypium spp.",
         icc_id = "9.02.01.01", cpc_id = "0143|01921", wiki_id = "Q11457", gbif_id = "3152652",
         purpose = "fibre|food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "earth pea", broader = class$concept[16], scientific = "Vigna subterranea",
         icc_id = "7.9", cpc_id = "01709.90", wiki_id = "Q338219", gbif_id = "2982714",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "fenugreek", broader = class$concept[16], scientific = "Trigonella foenum-graecum",
         icc_id = "7.90", cpc_id = "01709.90", wiki_id = "Q133205", gbif_id = "5360475",
         purpose = "food", used_part = "leaves|seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "hemp", broader = class$concept[16], scientific = "Canabis sativa",
         icc_id = "9.02.01.04", cpc_id = "01449.02|01929.02", wiki_id = "Q26726|Q7150699|Q13414920", gbif_id = "5361880",
         purpose = "fibre|food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "linseed", broader = class$concept[16], scientific = "Linum usitatissimum",
         icc_id = "4.03.02|9.02.01.03", cpc_id = "01441|01929.01", wiki_id = "Q911332", gbif_id = "2873861",
         purpose = "fibre|food|industrial", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "jojoba", broader = class$concept[16], scientific = "Simmondsia chinensis",
         icc_id = "4.03.11", cpc_id = "01499.03", wiki_id = "Q267749", gbif_id = "5361949",
         purpose = "food", used_part = "bast|seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "mustard", broader = class$concept[16], scientific = "Brassica nigra|Sinapis alba",
         icc_id = "4.03.03", cpc_id = "01442", wiki_id = "Q131748|Q146202|Q504781", gbif_id = "3042658|3047621",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "niger seed", broader = class$concept[16], scientific = "Guizotia abyssinica",
         icc_id = "4.03.04", cpc_id = "01449.90", wiki_id = "Q110009144", gbif_id = "8584304",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "peanut|groundnut", broader = class$concept[16], scientific = "Arachis hypogaea",
         icc_id = "4.02", cpc_id = "0142", wiki_id = "Q3406628|Q23485", gbif_id = "5353770",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "poppy", broader = class$concept[16], scientific = "Papaver somniferum",
         icc_id = "4.03.12", cpc_id = "01448", wiki_id = "Q131584|Q130201", gbif_id = "2888439",
         purpose = "food|recreation|medicinal", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "rapeseed|colza", broader = class$concept[16], scientific = "Brassica napus",
         icc_id = "4.03.05", cpc_id = "01443", wiki_id = "Q177932", gbif_id = "3042636",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "safflower", broader = class$concept[16], scientific = "Carthamus tinctorius",
         icc_id = "4.03.06", cpc_id = "01446", wiki_id = "Q156625|Q104413623", gbif_id = "3138327",
         purpose = "food|industrial", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "sesame", broader = class$concept[16], scientific = "Sesamum indicum",
         icc_id = "4.03.07", cpc_id = "01444", wiki_id = "Q2763698|Q12000036", gbif_id = "3172622",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "soybean", broader = class$concept[16], scientific = "Glycine max",
         icc_id = "4.01", cpc_id = "0141", wiki_id = "Q11006", gbif_id = "5359660",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "sunflower", broader = class$concept[16], scientific = "Helianthus annuus",
         icc_id = "4.03.08", cpc_id = "01445", wiki_id = "Q26949|Q171497|Q1076906", gbif_id = "9206251",
         purpose = "food|fodder", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "shea nut|karite nut", broader = class$concept[16], scientific = "Vitellaria paradoxa",
         icc_id = "4.03.09", cpc_id = "01499.01", wiki_id = "Q104212650|Q50839003", gbif_id = "2886750",
         purpose = "food", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "tallowtree", broader = class$concept[16], scientific = "Shorea aptera|Shorea stenocarpa|Sapium sebiferum",
         icc_id = "4.03.13", cpc_id = "01499.04", wiki_id = "Q1201089", gbif_id = "5377858",
         purpose = "industrial", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

oilseeds <-
  tibble(concept = "tung nut", broader = class$concept[16], scientific = "Aleurites fordii",
         icc_id = "4.03.10", cpc_id = "01499.02", wiki_id = "Q2699247|Q2094522", gbif_id = "3074907",
         purpose = "industrial", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(oilseeds, .)

luckiOnto <- new_concept(new = oilseeds$concept,
                         broader = left_join(oilseeds %>% select(concept, label = broader), get_concept(label = oilseeds$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Stimulant crops ----
stimulants <-
  tibble(concept = "tobacco", broader = class$concept[17], scientific = "Nicotiana tabacum",
         icc_id = "9.06", cpc_id = "01970", wiki_id = "Q1566|Q181095", gbif_id = "2928774",
         purpose = "recreation", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

stimulants <-
  tibble(concept = "cocoa|cacao", broader = class$concept[17], scientific = "Theobroma cacao",
         icc_id = "6.01.04", cpc_id = "01640", wiki_id = "Q208008", gbif_id = "3152205",
         purpose = "food|recreation", used_part = "seed", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(stimulants, .)

stimulants <-
  tibble(concept = "coffee", broader = class$concept[17], scientific = "Coffea spp.",
         icc_id = "6.01.01", cpc_id = "01610", wiki_id = "Q8486", gbif_id = "2895315",
         purpose = "food|recreation", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(stimulants, .)

stimulants <-
  tibble(concept = "mate", broader = class$concept[17], scientific = "Ilex paraguariensis",
         icc_id = "6.01.03", cpc_id = "01630", wiki_id = "Q81602|Q5881191", gbif_id = "5414252",
         purpose = "food|recreation", used_part = "leaves", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(stimulants, .)

stimulants <-
  tibble(concept = "tea", broader = class$concept[17], scientific = "Camellia sinensis",
         icc_id = "6.01.02", cpc_id = "01620", wiki_id = "Q101815|Q6097", gbif_id = "3189635",
         purpose = "food|recreation", used_part = "leaves", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(stimulants, .)

luckiOnto <- new_concept(new = stimulants$concept,
                         broader = left_join(stimulants %>% select(concept, label = broader), get_concept(label = stimulants$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Spice crops ----
spice <-
  tibble(concept = "anise", broader = class$concept[18], scientific = "Pimpinella anisum",
         icc_id = "6.02.01.02", cpc_id = "01654", wiki_id = "Q28692", gbif_id = "5371877",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "1")

spice <-
  tibble(concept = "badian|star anise", broader = class$concept[18], scientific = "Illicium verum",
         icc_id = "6.02.01.02", cpc_id = "01654", wiki_id = "Q2878644|Q1760637", gbif_id = "2889756",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = "9", yoh = "80", harvests = "1", height = "20") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "cannella cinnamon", broader = class$concept[18], scientific = "Cinnamomum verum",
         icc_id = "6.02.02.03", cpc_id = "01655", wiki_id = "Q28165|Q370239", gbif_id = "3033987",
         purpose = "food|medicinal", used_part = "bark", life_form = "tree",
         ybh = "3", yoh = "50", harvests = NA, height = "5") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "caraway", broader = class$concept[18], scientific = "Carum carvi",
         icc_id = "6.02.01.90", cpc_id = "01654", wiki_id = "Q26811", gbif_id = "3034714",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = "1", yoh = "2", harvests = "1", height = "1") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "cardamon", broader = class$concept[18], scientific = "Elettaria cardamomum",
         icc_id = "6.02.02.02", cpc_id = "01653", wiki_id = "Q33466|Q14625808", gbif_id = "2759871",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = "5") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "chillies and peppers", broader = class$concept[18], scientific = "Capsicum spp.",
         icc_id = "6.02.01.01", cpc_id = "01652|01231", wiki_id = "Q165199|Q201959|Q1380", gbif_id = "2932937",
         purpose = "food|medicinal", used_part = "fruit", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "2") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "coriander", broader = class$concept[18], scientific = "Coriandrum sativum",
         icc_id = "6.02.01.02", cpc_id = "01654", wiki_id = "Q41611|Q20856764", gbif_id = "3034871",
         purpose = "food", used_part = "leaves|seed", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", yield_min = NA, yield_max = "2", height = "0.5") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "cumin", broader = class$concept[18], scientific = "Cuminum cyminum",
         icc_id = "6.02.01.02", cpc_id = "01654", wiki_id = "Q57328174|Q132624", gbif_id = "3034775",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "0.5") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "dill", broader = class$concept[18], scientific = "Anethum graveoles",
         icc_id = "6.02.01.02", cpc_id = "0169", wiki_id = "Q26686|Q59659860", gbif_id = "3034646",
         purpose = "food", used_part = "leaves|seed", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "1") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "fennel", broader = class$concept[18], scientific = "Foeniculum vulgare",
         icc_id = "6.02.02.90", cpc_id = "01654", wiki_id = "Q43511|Q27658833", gbif_id = "3034922",
         purpose = "food", used_part = "bulb|fruit|leaves", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "2") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "hop", broader = class$concept[18], scientific = "Humulus lupulus",
         icc_id = "6.02.02.07", cpc_id = "01659", wiki_id = "Q104212", gbif_id = "2984535",
         purpose = "food", used_part = "flower", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "10") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "malaguetta pepper|guinea pepper", broader = class$concept[18], scientific = "Aframomum melegueta",
         icc_id = "6.02.02.02", cpc_id = "01653", wiki_id = "Q1503476|Q3312331", gbif_id = "2758930",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = "2") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "thyme", broader = class$concept[18], scientific = "Thymus vulgaris",
         icc_id = "6.02.02.90", cpc_id = "0169", wiki_id = "Q148668|Q3215980", gbif_id = "5341442",
         purpose = "food", used_part = "seed", life_form = "vine",
         ybh = "0", yoh = "5", harvests = "1", height = "0.5") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "ginger", broader = class$concept[18], scientific = "Zingiber officinale",
         icc_id = "6.02.02.05", cpc_id = "01657", wiki_id = "Q35625|Q15046077", gbif_id = "2757280",
         purpose = "food", used_part = "root", life_form = "vine",
         ybh = "1", yoh = "2", harvests = "1", height = "2") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "pepper", broader = class$concept[18], scientific = "Piper nigrum",
         icc_id = "6.02.02.01", cpc_id = "01651", wiki_id = "Q43084", gbif_id = "3086357",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = "5") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "vanilla", broader = class$concept[18], scientific = "Vanilla planifolia",
         icc_id = "6.02.02.06", cpc_id = "01658", wiki_id = "Q7224923|Q162044", gbif_id = "2803398",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = "15") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "lavender", broader = class$concept[18], scientific = "Lavandula spp.",
         icc_id = "9.03.01", cpc_id = "01699", wiki_id = "Q42081|Q171892", gbif_id = "2927302",
         purpose = "food", used_part = "buds|leaves", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "1") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "angelica", broader = class$concept[18], scientific = "Angelica archangelica",
         icc_id = "6.02.02.90", cpc_id = "01699", wiki_id = "Q207745", gbif_id = "5371808",
         purpose = "food|medicinal", used_part = "shoot", life_form = "vine",
         ybh = "0", yoh = NA, harvests = NA, height = "2") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "bay leaves", broader = class$concept[18], scientific = "Laurus nobilis",
         icc_id = "6.02.02.90", cpc_id = "01699", wiki_id = "Q26006", gbif_id = "3034015",
         purpose = "food|medicinal", used_part = "leaves", life_form = "tree",
         ybh = NA, yoh = "1", harvests = NA, height = "20") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "moringa", broader = class$concept[18], scientific = "Moringa oleifera",
         icc_id = "6.02.02.90", cpc_id = "01699", wiki_id = "Q234193", gbif_id = "3054181",
         purpose = "food", used_part = "fruit", life_form = "tree",
         ybh = "1", yoh = NA, harvests = "2", height = "10") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "saffron", broader = class$concept[18], scientific = "Crocus sativus",
         icc_id = "6.02.02.90", cpc_id = "01699", wiki_id = "Q15041677", gbif_id = "2747430",
         purpose = "food", used_part = "flower", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "0.5") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "turmeric", broader = class$concept[18], scientific = "Curcuma longa",
         icc_id = "6.02.02.90", cpc_id = "01699", wiki_id = "Q42562", gbif_id = "2757624",
         purpose = "food|medicinal", used_part = "root", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "1") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "clove", broader = class$concept[18], scientific = "Eugenia aromatica",
         icc_id = "6.02.02.04", cpc_id = "01656", wiki_id = "Q15622897|Q26736", gbif_id = "3183002",
         purpose = "food", used_part = "flower", life_form = "tree",
         ybh = "0", yoh = NA, harvests = NA, height = "10") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "nutmeg|mace", broader = class$concept[18], scientific = "Myristica fragrans",
         icc_id = "6.02.01.90", cpc_id = "01653", wiki_id = "Q1882876|Q2724976", gbif_id = "5406817",
         purpose = "food", used_part = "seed", life_form = "tree",
         ybh = "8", yoh = NA, harvests = NA, height = "20") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "juniper berry", broader = class$concept[18], scientific = "Juniperus communis",
         icc_id = "6.02.01.90", cpc_id = "01654", wiki_id = "Q3251025|Q26325", gbif_id = "2684709",
         purpose = "food", used_part = "fruit", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = "10") %>%
  bind_rows(spice, .)

spice <-
  tibble(concept = "parsley", broader = class$concept[18], scientific = "Petroselinum crispum",
         icc_id = "6.02.01.90", cpc_id = "01699", wiki_id = "Q25284", gbif_id = "7828157",
         purpose = "food", used_part = "leaves", life_form = "forb",
         ybh = NA, yoh = NA, harvests = NA, height = "1") %>%
  bind_rows(spice, .)

luckiOnto <- new_concept(new = spice$concept,
                         broader = left_join(spice %>% select(concept, label = broader), get_concept(label = spice$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Medicinal crops ----
medicinal <-
  tibble(concept = "basil", broader = class$concept[19], scientific = "Ocimum basilicum",
         icc_id = "9.03.01.02", cpc_id = "01699", wiki_id = "Q38859|Q65522654", gbif_id = "2927096",
         purpose = "food", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

medicinal <-
  tibble(concept = "ginseng", broader = class$concept[19], scientific = "Panax ginseng",
         icc_id = "9.03.02.01", cpc_id = "01699", wiki_id = "Q182881|Q20817212", gbif_id = "5372262",
         purpose = "food", used_part = "root", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(medicinal, .)

medicinal <-
  tibble(concept = "guarana", broader = class$concept[19], scientific = "Paulinia cupana",
         icc_id = "9.03.02.04", cpc_id = "01699", wiki_id = "Q209089", gbif_id = "3189949",
         purpose = "food|recreation", used_part = "seed", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(medicinal, .)

medicinal <-
  tibble(concept = "kava", broader = class$concept[19], scientific = "Piper methysticum",
         icc_id = "9.03.02.03", cpc_id = "01699", wiki_id = "Q161067", gbif_id = "3086358",
         purpose = "food", used_part = "root", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(medicinal, .)

medicinal <-
  tibble(concept = "liquorice", broader = class$concept[19], scientific = "Glycyrrhiza glabra",
         icc_id = "9.03.01", cpc_id = "01930", wiki_id = "Q257106", gbif_id = "2965732",
         purpose = "food|medicinal", used_part = "root", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(medicinal, .)

medicinal <-
  tibble(concept = "mint", broader = class$concept[19], scientific = "Mentha spp.",
         icc_id = "9.03.01.01", cpc_id = "01699|01930.01", wiki_id = "Q47859|Q156037", gbif_id = "2927173",
         purpose = "food", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(medicinal, .)

medicinal <-
  tibble(concept = "coca", broader = class$concept[19], scientific = "Erythroxylum novogranatense|Erythroxylum coca",
         icc_id = "9.03.02.02", cpc_id = "01699", wiki_id = "Q158018", gbif_id = "2873941|2873939",
         purpose = "recreation", used_part = "leaves", life_form = "tree",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(medicinal, .)

luckiOnto <- new_concept(new = medicinal$concept,
                         broader = left_join(medicinal %>% select(concept, label = broader), get_concept(label = medicinal$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Sugar crops ----
sugar <-
  tibble(concept = "stevia", broader = class$concept[20], scientific = "Stevia rebaudiana",
         icc_id = "8.9", cpc_id = "01809", wiki_id = "Q312246|Q7213452|Q3644010", gbif_id = "3125557",
         purpose = "food", used_part = "leaves", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "1")

sugar <-
  tibble(concept = "sugar beet", broader = class$concept[20], scientific = "Beta vulgaris var. altissima",
         icc_id = "8.01", cpc_id = "01801|01919.06", wiki_id = "Q151964", gbif_id = "",
         purpose = "food|fodder", used_part = "root", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "0.5") %>%
  bind_rows(sugar, .)

sugar <-
  tibble(concept = "sugar cane", broader = class$concept[20], scientific = "Saccharum officinarum",
         icc_id = "8.02", cpc_id = "01802|01919.91", wiki_id = "Q36940|Q3391243", gbif_id = "2703912",
         purpose = "food|fodder", used_part = "sap|shoot", life_form = "graminoid",
         ybh = "24", yoh = "10", harvests = "1", height = "5") %>%
  bind_rows(sugar, .)

sugar <-
  tibble(concept = "sweet sorghum", broader = class$concept[20], scientific = "Sorghum saccharatum",
         icc_id = "8.03", cpc_id = "01809", wiki_id = "Q3123184|Q332062", gbif_id = "2705181",
         purpose = "food|fodder", used_part = "sap|shoot", life_form = "graminoid",
         ybh = "0", yoh = "1", harvests = "1", height = "5") %>%
  bind_rows(sugar, .)

sugar <-
  tibble(concept = "sugar maple", broader = class$concept[20], scientific = "Acer saccharum",
         icc_id = "8.9", cpc_id = "01809", wiki_id = "Q214733", gbif_id = "3189859",
         purpose = "food", used_part = "sap", life_form = "tree",
         ybh = "40", yoh = NA, harvests = NA, height = "30") %>%
  bind_rows(sugar, .)

luckiOnto <- new_concept(new = sugar$concept,
                         broader = left_join(sugar %>% select(concept, label = broader), get_concept(label = sugar$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Fruit-bearing vegetables ----
fruit_veg <-
  tibble(concept = "cantaloupe", broader = class$concept[21], scientific = "Cucumis melo",
         icc_id = "2.05.02", cpc_id = "01229", wiki_id = "Q61858403|Q477179", gbif_id = "2874570",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

fruit_veg <-
  tibble(concept = "chayote", broader = class$concept[21], scientific = "Sechium edule",
         icc_id = "2.02.90", cpc_id = "01239.90", wiki_id = "Q319611", gbif_id = "2874612",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fruit_veg, .)

fruit_veg <-
  tibble(concept = "cucumber|gherkin", broader = class$concept[21], scientific = "Cucumis sativus",
         icc_id = "2.02.01", cpc_id = "01232", wiki_id = "Q2735883|Q23425", gbif_id = "2874569",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fruit_veg, .)

fruit_veg <-
  tibble(concept = "eggplant", broader = class$concept[21], scientific = "Solanum melongena",
         icc_id = "2.02.02", cpc_id = "01233", wiki_id = "Q7540|Q12533094", gbif_id = "2930617",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fruit_veg, .)

fruit_veg <-
  tibble(concept = "gourd", broader = class$concept[21], scientific = "Lagenaria spp|Cucurbita spp.",
         icc_id = "2.02.04", cpc_id = "01235", wiki_id = "Q7370671", gbif_id = "2874671|2874506",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fruit_veg, .)

fruit_veg <-
  tibble(concept = "melon", broader = class$concept[21], scientific = "Cucumis melo",
         icc_id = "2.05.02", cpc_id = "01229", wiki_id = "Q5881191|Q81602", gbif_id = "2874570",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fruit_veg, .)

fruit_veg <-
  tibble(concept = "okra", broader = class$concept[21], scientific = "Abelmoschus esculentus|Hibiscus esculentus",
         icc_id = "2.02.05", cpc_id = "01239.01", wiki_id = "Q80531|Q12047207", gbif_id = "3152708",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fruit_veg, .)

fruit_veg <-
  tibble(concept = "pumpkin", broader = class$concept[21], scientific = "Cucurbita spp",
         icc_id = "2.02.04", cpc_id = "01235", wiki_id = "Q165308|Q5339301", gbif_id = "2874506",
         purpose = "food|fodder", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fruit_veg, .)

fruit_veg <-
  tibble(concept = "squash", broader = class$concept[21], scientific = "Cucurbita spp",
         icc_id = "2.02.04", cpc_id = "01235", wiki_id = "Q5339237|Q7533", gbif_id = "2874506",
         purpose = "food|fodder", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fruit_veg, .)

fruit_veg <-
  tibble(concept = "sweet pepper", broader = class$concept[21], scientific = "Capsicum annuum",
         icc_id = "6.02.01.01", cpc_id = "01231", wiki_id = "Q1548030", gbif_id = "2932944",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fruit_veg, .)

fruit_veg <-
  tibble(concept = "tamarillo", broader = class$concept[21], scientific = "Solanum betaceum",
         icc_id = "2.02.90", cpc_id = "01239.90", wiki_id = "Q379747", gbif_id = "2930216",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fruit_veg, .)

fruit_veg <-
  tibble(concept = "tomato", broader = class$concept[21], scientific = "Lycopersicon esculentum",
         icc_id = "2.02.03", cpc_id = "01234", wiki_id = "Q20638126|Q23501", gbif_id = "2930181",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fruit_veg, .)

fruit_veg <-
  tibble(concept = "watermelon", broader = class$concept[21], scientific = "Citrullus lanatus",
         icc_id = "2.05.01", cpc_id = "01221", wiki_id = "Q38645|Q17507129", gbif_id = "2874621",
         purpose = "food", used_part = "fruit", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(fruit_veg, .)

luckiOnto <- new_concept(new = fruit_veg$concept,
                         broader = left_join(fruit_veg %>% select(concept, label = broader), get_concept(label = fruit_veg$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Leaf or stem vegetables ----
leaf_veg <-
  tibble(concept = "artichoke", broader = class$concept[22], scientific = "Cynara scolymus",
         icc_id = "2.01.01", cpc_id = "01216", wiki_id = "Q23041430", gbif_id = "3112361",
         purpose = "food", used_part = "flower", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA)

leaf_veg <-
  tibble(concept = "asparagus", broader = class$concept[22], scientific = "Asparagus officinalis",
         icc_id = "2.01.02", cpc_id = "01211", wiki_id = "Q2853420|Q23041045", gbif_id = "2768885",
         purpose = "food", used_part = "shoot", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "bok choy|pak choi", broader = class$concept[22], scientific = "Brassica rapa subsp. chinensis",
         icc_id = "2.01.03", cpc_id = "01212", wiki_id = "Q18968514", gbif_id = "3042702",
         purpose = "food|fodder", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "broccoli", broader = class$concept[22], scientific = "Brassica oleracea var. botrytis",
         icc_id = "2.01.04", cpc_id = "01213", wiki_id = "Q47722|Q57544960", gbif_id = "3042854",
         purpose = "food", used_part = "flower", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "brussels sprout", broader = class$concept[22], scientific = "Brassica oleracea var. gemmifera",
         icc_id = "2.01.90", cpc_id = "01212", wiki_id = "Q150463|Q104664711", gbif_id = "9451746",
         purpose = "food|fodder", used_part = "flower", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "cabbage", broader = class$concept[22], scientific = "Brassica oleracea var. capitata",
         icc_id = "2.01.03|01919.04", cpc_id = "01212", wiki_id = "Q14328596", gbif_id = "9263609",
         purpose = "food|fodder", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "cauliflower", broader = class$concept[22], scientific = "Brassica oleracea var. botrytis",
         icc_id = "2.01.04", cpc_id = "01213", wiki_id = "Q7537|Q23900272", gbif_id = "3042854",
         purpose = "food", used_part = "flower", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "celery", broader = class$concept[22], scientific = "Apium graveolens",
         icc_id = "2.01.90", cpc_id = "01290", wiki_id = "Q28298", gbif_id = "5371879",
         purpose = "food", used_part = "shoot", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "chicory", broader = class$concept[22], scientific = "Cichorium intybus",
         icc_id = "2.01.07", cpc_id = "01214", wiki_id = "Q2544599|Q1474", gbif_id = "5392252",
         purpose = "food|recreation", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "chinese cabbage", broader = class$concept[22], scientific = "Brassica chinensis",
         icc_id = "2.01.03", cpc_id = "01212", wiki_id = "Q13360268|Q104664724", gbif_id = "7903057",
         purpose = "food", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "collard", broader = class$concept[22], scientific = "Brassica oleracea var. viridis",
         icc_id = "2.01.03", cpc_id = "01212", wiki_id = "Q146212|Q14879985", gbif_id = "3042878",
         purpose = "food", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "endive", broader = class$concept[22], scientific = "Cichorium endivia",
         icc_id = "2.01.90", cpc_id = "01214", wiki_id = "Q178547|Q28604477", gbif_id = "5392243",
         purpose = "food", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "gai lan", broader = class$concept[22], scientific = "Brassica oleracea var. alboglabra",
         icc_id = "2.01.03", cpc_id = "01212", wiki_id = "Q1677369|Q104664699", gbif_id = "3042859",
         purpose = "food", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "kale", broader = class$concept[22], scientific = "Brassica oleracea var. acephala",
         icc_id = "2.01.90", cpc_id = "01212", wiki_id = "Q45989", gbif_id = "3042879",
         purpose = "food|fodder", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "lettuce", broader = class$concept[22], scientific = "Lactuca sativa var. capitata",
         icc_id = "2.01.05", cpc_id = "01214", wiki_id = "Q83193|Q104666136", gbif_id = "4933901",
         purpose = "food", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "rhubarb", broader = class$concept[22], scientific = "Rheum spp.",
         icc_id = "2.01.90", cpc_id = "01219", wiki_id = "Q20767168", gbif_id = "2888863",
         purpose = "food", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "savoy cabbage", broader = class$concept[22], scientific = "Brassica oleracea var. capitata",
         icc_id = "2.01.03", cpc_id = "01212", wiki_id = "Q154013", gbif_id = "9263609",
         purpose = "food", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

leaf_veg <-
  tibble(concept = "spinach", broader = class$concept[22], scientific = "Spinacia oleracea",
         icc_id = "2.01.06", cpc_id = "01215", wiki_id = "Q81464", gbif_id = "3083647",
         purpose = "food", used_part = "leaves", life_form = "vine",
         ybh = NA, yoh = NA, harvests = NA, height = NA) %>%
  bind_rows(leaf_veg, .)

luckiOnto <- new_concept(new = leaf_veg$concept,
                         broader = left_join(leaf_veg %>% select(concept, label = broader), get_concept(label = leaf_veg$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Mushrooms and truffles ----
mushrooms <-
  tibble(concept = "mushrooms", broader = class$concept[23], scientific = "Agaricus spp.|Pleurotus spp.|Volvariella",
         icc_id = "2.04", cpc_id = "01270", wiki_id = "Q654236", gbif_id = "2518646|2518610|2530192",
         purpose = "food", used_part = "fruit", life_form = "mushroom",
         ybh = "0", yoh = "1", harvests = "18", height = "0.5")

luckiOnto <- new_concept(new = mushrooms$concept,
                         broader = left_join(mushrooms %>% select(concept, label = broader), get_concept(label = mushrooms$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Root vegetables ----
root_veg <-
  tibble(concept = "carrot", broader = class$concept[24], scientific = "Daucus carota subsp. sativus",
         icc_id = "2.03.01", cpc_id = "01251|01919.07", wiki_id = "Q11678009|Q81", gbif_id = "4271342",
         purpose = "food|fodder", used_part = "root", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "2")


root_veg <-
  tibble(concept = "chive", broader = class$concept[24], scientific = "Allium schoenoprasum",
         icc_id = "2.03.05", cpc_id = "01254", wiki_id = "Q51148|Q5766863", gbif_id = "2855860",
         purpose = "food", used_part = "leaves", life_form = "vine",
         ybh = "0", yoh = "5", harvests = "5", height = "0.5") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "beet root|red beet", broader = class$concept[24], scientific = "Beta vulgaris subsp. vulgaris conditiva group",
         icc_id = "8.01", cpc_id = "01801", wiki_id = "Q165191|Q99548274", gbif_id = "7068845",
         purpose = "food|fodder", used_part = "leaves", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "0.5") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "chard", broader = class$concept[24], scientific = "Beta vulgaris subsp. vulgaris cicla group",
         icc_id = "8.01", cpc_id = "01801", wiki_id = "Q157954", gbif_id = "7068845",
         purpose = "food", used_part = "leaves", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "1") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "garlic", broader = class$concept[24], scientific = "Allium sativum",
         icc_id = "2.03.03", cpc_id = "01252", wiki_id = "Q23400|Q21546392", gbif_id = "2856681",
         purpose = "food", used_part = "buld", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "1") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "leek", broader = class$concept[24], scientific = "Allium ampeloprasum",
         icc_id = "2.03.05", cpc_id = "01254", wiki_id = "Q1807269|Q148995", gbif_id = "2856037",
         purpose = "food", used_part = "leaves", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "1") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "onion", broader = class$concept[24], scientific = "Allium cepa",
         icc_id = "2.03.04", cpc_id = "Q23485|01253", wiki_id = "Q23485|Q3406628", gbif_id = "2857697",
         purpose = "food", used_part = "buld", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "1") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "turnip", broader = class$concept[24], scientific = "Brassica rapa",
         icc_id = "2.03.02", cpc_id = "01251|01919.05", wiki_id = "Q33690609|Q3916957", gbif_id = "7225636",
         purpose = "food", used_part = "root", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "0.5") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "mangelwurzel", broader = class$concept[24], scientific = "Beta vulgaris subsp. vulgaris crassa group",
         icc_id = "8.01", cpc_id = "01801", wiki_id = "Q740726", gbif_id = "7068845",
         purpose = "food|forage", used_part = "root", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "0.5") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "manioc|cassava|tapioca", broader = class$concept[24], scientific = "Manihot esculenta",
         icc_id = "5.03", cpc_id = "01520", wiki_id = "Q43304555|Q83124", gbif_id = "3060998",
         purpose = "food|fodder", used_part = "tuber", life_form = "forb",
         ybh = "0", yoh = "1", harvests = "1", height = "5") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "potato", broader = class$concept[24], scientific = "Solamum tuberosum",
         icc_id = "5.01", cpc_id = "01510", wiki_id = "Q16587531|Q10998", gbif_id = "2930262",
         purpose = "food", used_part = "root", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "1") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "sweet potato", broader = class$concept[24], scientific = "Ipomoea batatas",
         icc_id = "5.02", cpc_id = "01530", wiki_id = "Q37937", gbif_id = "2928551",
         purpose = "food", used_part = "tuber", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "0.5") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "taro|dasheen", broader = class$concept[24], scientific = "Colocasia esculenta",
         icc_id = "5.05", cpc_id = "01550", wiki_id = "Q227997", gbif_id = "5330776",
         purpose = "food", used_part = "root", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "2") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "yam", broader = class$concept[24], scientific = "Dioscorea spp.",
         icc_id = "5.04", cpc_id = "01540", wiki_id = "Q8047551|Q71549", gbif_id = "2754367",
         purpose = "food", used_part = "tuber", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "20") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "yautia", broader = class$concept[24], scientific = "Xanthosoma sagittifolium",
         icc_id = "5.06", cpc_id = "01591", wiki_id = "Q279280", gbif_id = "5330901",
         purpose = "food|fodder", used_part = "tuber", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "2") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "arracacha", broader = class$concept[24], scientific = "Arracacia xanthorrhiza",
         icc_id = "5.9", cpc_id = "01599", wiki_id = "Q625399", gbif_id = "3034509",
         purpose = "food", used_part = "root", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "1") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "celeriac", broader = class$concept[24], scientific = "Apium graveolens var. rapaceum",
         icc_id = "2.03.90", cpc_id = "01259", wiki_id = "Q575174", gbif_id = "5539782",
         purpose = "food", used_part = "root", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "1") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "horseradish", broader = class$concept[24], scientific = "Armoracia rusticana",
         icc_id = "2.03.90", cpc_id = "01259", wiki_id = "Q26545", gbif_id = "3041022",
         purpose = "food|medicinal", used_part = "root", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "2") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "kohlrabi", broader = class$concept[24], scientific = "Brassica oleracea var. gongylodes",
         icc_id = "2.03.90", cpc_id = "01212", wiki_id = "Q147202", gbif_id = "3042850",
         purpose = "food", used_part = "shoot", life_form = "vine",
         ybh = "0", yoh = "1", harvests = "1", height = "0.5") %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "radish", broader = class$concept[24], scientific = "Raphanus sativus",
         icc_id = "2.03.90", cpc_id = "01259", wiki_id = "Q1057750", gbif_id = "7678610",
         purpose = "food|medicinal", used_part = "root", life_form = "vine",
         ybh = "0", yoh = NA, harvests = "1", height = NA) %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "salsify", broader = class$concept[24], scientific = "Tragopogon porrifolius",
         icc_id = "2.03.90", cpc_id = "01259", wiki_id = "Q941639", gbif_id = "5386938",
         purpose = "food", used_part = "root", life_form = "vine",
         ybh = "0", yoh = NA, harvests = "1", height = NA) %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "scorzonera", broader = class$concept[24], scientific = "Scorzonera hispanica",
         icc_id = "2.03.90", cpc_id = "01259", wiki_id = "Q385259", gbif_id = "3110905",
         purpose = "food", used_part = "root", life_form = "vine",
         ybh = "0", yoh = NA, harvests = "1", height = NA) %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "sunroot|topinambur", broader = class$concept[24], scientific = "Helianthus tuberosus",
         icc_id = "2.01.01", cpc_id = "01599", wiki_id = "Q146190", gbif_id = "3119175",
         purpose = "food", used_part = "root", life_form = "vine",
         ybh = "0", yoh = NA, harvests = "1", height = NA) %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "swede", broader = class$concept[24], scientific = "Brassica napus var. napobrassica",
         icc_id = "2.03.90", cpc_id = "01919.08", wiki_id = "Q158464|Q158464", gbif_id = "6306660",
         purpose = "food", used_part = "root", life_form = "vine",
         ybh = "0", yoh = NA, harvests = "1", height = NA) %>%
  bind_rows(root_veg, .)

root_veg <-
  tibble(concept = "parsnip", broader = class$concept[24], scientific = "Pastinaca sativa",
         icc_id = "2.03.90", cpc_id = "01259", wiki_id = "Q188614|Q104413481", gbif_id = "8262702",
         purpose = "food", used_part = "root", life_form = "vine",
         ybh = "0", yoh = NA, harvests = "1", height = NA) %>%
  bind_rows(root_veg, .)

luckiOnto <- new_concept(new = root_veg$concept,
                         broader = left_join(root_veg %>% select(concept, label = broader), get_concept(label = root_veg$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "crop",
                         ontology = luckiOnto)

##### Animals ----
animals <-
  tibble(concept = "chicken", broader = class$concept[25], scientific = "",
         icc_id = NA_character_, cpc_id = "02151", wiki_id = "Q780", gbif_id = "5260",
         purpose = "food", used_part = "eggs|meat")

# animals <-
#   tibble(concept = "chicken-juvenile", broader = class$concept[25]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "chicken-adult", broader = class$concept[25]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "chicken-adult-female", broader = class$concept[25]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "chicken-adult-female-eggs", broader = class$concept[25]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "chicken-adult-male", broader = class$concept[25]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "chicken---meat", broader = class$concept[25]) %>%
#   bind_rows(animals, .)

animals <-
  tibble(concept = "guinea fowl", broader = class$concept[25], scientific = "Agelastes spp.|Guttera spp.|Numida meleagris",
         icc_id = NA_character_, cpc_id = "02155", wiki_id = "Q171953", gbif_id = NA_character_,
         purpose = "food", used_part = "eggs|meat") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "partridge", broader = class$concept[25], scientific = "Alectoris rufa",
         icc_id = NA_character_, cpc_id = "02194", wiki_id = "Q25237|Q29472543", gbif_id = "2474051",
         purpose = "food", used_part = "eggs|meat") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "pigeon", broader = class$concept[25], scientific = "Columba livia",
         icc_id = NA_character_, cpc_id = "02194", wiki_id = "Q2984138|Q10856", gbif_id = "2495414",
         purpose = "food|labor", used_part = "eggs|meat|time") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "quail", broader = class$concept[25], scientific = "Coturnis spp.",
         icc_id = NA_character_, cpc_id = "02194", wiki_id = "Q28358", gbif_id = NA_character_,
         purpose = "food", used_part = "eggs|meat") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "duck", broader = class$concept[25], scientific = "Anas platyrhynchos",
         icc_id = NA_character_, cpc_id = "02154", wiki_id = "Q3736439|Q7556", gbif_id = "9761484",
         purpose = "food", used_part = "eggs|meat") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "goose", broader = class$concept[25], scientific = "Anser anser|Anser albofrons|Anser arvensis",
         icc_id = NA_character_, cpc_id = "02153", wiki_id = "Q16529344", gbif_id = "2498036",
         purpose = "food|labor", used_part = "eggs|meat|time") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "turkey", broader = class$concept[25], scientific = "Meleagris gallopavo",
         icc_id = NA_character_, cpc_id = "02152", wiki_id = "Q848706|Q43794", gbif_id = "9606290",
         purpose = "food", used_part = "eggs|meat") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "hare", broader = class$concept[26], scientific = "Lepus spp.",
         icc_id = NA_character_, cpc_id = "02191", wiki_id = "Q46076|Q63941258", gbif_id = "2436691",
         purpose = "food", used_part = "fur") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "rabbit", broader = class$concept[26], scientific = "Oryctolagus cuniculus",
         icc_id = NA_character_, cpc_id = "02191", wiki_id = "Q9394", gbif_id = "2436940",
         purpose = "food", used_part = "fur") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "buffalo|bison", broader = class$concept[28], scientific = "Bubalus bubalus|Bubalus ami|Bubalus depressicornis|Bubalus nanus|Syncerus spp.|Bison spp.",
         icc_id = NA_character_, cpc_id = "02112", wiki_id = "Q82728", gbif_id = "8085503|2441175",
         purpose = "food|labor", used_part = "meat|dairy|time") %>%
  bind_rows(animals, .)

# animals <-
#   tibble(concept = "buffalo|bison-juvenile", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "buffalo|bison-subadult", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "buffalo|bison-subadult-female", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "buffalo|bison-subadult-male", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "buffalo|bison-adult", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "buffalo|bison-adult-female", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "buffalo|bison-adult-male", broader = class$concept[28]) %>%
#   bind_rows(animals, .)

animals <-
  tibble(concept = "cattle", broader = class$concept[28], scientific = "Bos bovis|Bos taurus|Bos indicus|Bos grunniens|Bos gaurus|Bos grontalis|Bos sondaicus",
         icc_id = NA_character_, cpc_id = "02111", wiki_id = "Q830|Q4767951", gbif_id = "2441022|2441023|2441019|2441026",
         purpose = "food|labor", used_part = "meat|dairy|time") %>%
  bind_rows(animals, .)

# animals <-
#   tibble(concept = "cattle---meat", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle--female-meat", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle--male-meat", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle---dairy", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-juvenile", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-juvenile-female", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-juvenile-female-meat", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-juvenile-male", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-juvenile-male-meat", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-subadult", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-subadult-female", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-subadult-female-dairy", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-subadult-female-meat", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-subadult-male", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-subadult-male-dairy", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-subadult-male-meat", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-adult", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-adult-female", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-adult-female-dairy", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-adult-female-meat", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-adult-male", broader = class$concept[28]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "cattle-adult-male-meat", broader = class$concept[28]) %>%
#   bind_rows(animals, .)

animals <-
  tibble(concept = "goat", broader = class$concept[29], scientific = "Capra hircus",
         icc_id = NA_character_, cpc_id = "02123", wiki_id = "Q2934", gbif_id = "2441056",
         purpose = "food|labor", used_part = "meat|dairy|time") %>%
  bind_rows(animals, .)

# animals <-
#   tibble(concept = "goat-juvenile", broader = class$concept[29]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "goat-adult", broader = class$concept[29]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "goat-adult-female", broader = class$concept[29]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "goat-adult-male", broader = class$concept[29]) %>%
#   bind_rows(animals, .)

animals <-
  tibble(concept = "sheep", broader = class$concept[29], scientific = "Ovis aries",
         icc_id = NA_character_, cpc_id = "02122", wiki_id = "Q7368", gbif_id = "2441110",
         purpose = "food|labor", used_part = "meat|dairy|time") %>%
  bind_rows(animals, .)

# animals <-
#   tibble(concept = "sheep-juvenile", broader = class$concept[29]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "sheep-adult", broader = class$concept[29]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "sheep-adult-female", broader = class$concept[29]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "sheep-adult-male", broader = class$concept[29]) %>%
#   bind_rows(animals, .)

animals <-
  tibble(concept = "alpaca", broader = class$concept[30], scientific = "Vicugna pacos",
         icc_id = NA_character_, cpc_id = "02121.02", wiki_id = "Q81564", gbif_id = "7515593",
         purpose= "fibre", used_part = "hair") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "camel", broader = class$concept[30], scientific = "Camelus bactrianus|Camelus dromedarius",
         icc_id = NA_character_, cpc_id = "02121.01", wiki_id = "Q7375", gbif_id = "2441238|9055455",
         purpose = "labor", used_part = "time") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "guanaco", broader = class$concept[30], scientific = "Lama guanicoe",
         icc_id = NA_character_, cpc_id = "02121.02", wiki_id = "Q172886|Q1552716", gbif_id = "5220188",
         purpose = "labor", used_part = "time") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "llama", broader = class$concept[30], scientific = "Lama glama",
         icc_id = NA_character_, cpc_id = "02121.02", wiki_id = "Q42569", gbif_id = "5220190",
         purpose = "fibrelabor", used_part = "hair|time") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "vicugna", broader = class$concept[30], scientific = "Vicugna vicugna",
         icc_id = NA_character_, cpc_id = "02121.02", wiki_id = "Q2703941|Q167797", gbif_id = "5220192",
         purpose= "fibre", used_part = "hair") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "ass", broader = class$concept[31], scientific = "Equus asinus",
         icc_id = NA_character_, cpc_id = "02132", wiki_id = "Q19707", gbif_id = "2440891",
         purpose = "food|labor", used_part = "meat|time") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "horse", broader = class$concept[31], scientific = "Equus caballus",
         icc_id = NA_character_, cpc_id = "02131", wiki_id = "Q726|Q10758650", gbif_id = "2440886",
         purpose = "food|labor", used_part = "meat|time") %>%
  bind_rows(animals, .)

# animals <-
#   tibble(concept = "horse-juvenile", broader = class$concept[31]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "horse-adult", broader = class$concept[31]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "horse-adult-female", broader = class$concept[31]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "horse-adult-male", broader = class$concept[31]) %>%
#   bind_rows(animals, .)

animals <-
  tibble(concept = "mule", broader = class$concept[31], scientific = "Equus africanus asinus × Equus ferus caballus",
         icc_id = NA_character_, cpc_id = "02133", wiki_id = "Q83093", gbif_id = NA_character_,
         purpose = "food|labor", used_part = "meat|time") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "red deer", broader = class$concept[32], scientific = "Cervus elaphus",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q79794", gbif_id = "2440958",
         purpose = "fibre|food", used_part = "meat") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "roe deer", broader = class$concept[32], scientific = "Capreolus capreolus",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q122069", gbif_id = "5220126",
         purpose = "fibre|food", used_part = "meat") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "white-tailed deer", broader = class$concept[32], scientific = "Odocoileus virginianus",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q215887", gbif_id = "2440965",
         purpose = "fibre|food", used_part = "meat") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "fallow deer", broader = class$concept[32], scientific = "Dama dama|Dama mesopotamica",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q159857|Q756889", gbif_id = "5220136|5220137",
         purpose = "fibre|food", used_part = "meat") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "moose", broader = class$concept[32], scientific = "Alces alces",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q35517", gbif_id = "2440940",
         purpose = "fibre|food", used_part = "meat") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "caribou|reindeer", broader = class$concept[32], scientific = "Rangifer tarandus",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q39624", gbif_id = "5220114",
         purpose = "fibre|food", used_part = "meat") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "wapiti|elk", broader = class$concept[32], scientific = "Cervus canadensis",
         icc_id = NA_character_, cpc_id = NA_character_, wiki_id = "Q180404", gbif_id = "145954737",
         purpose = "fibre|food", used_part = "meat") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "pig", broader = class$concept[33], scientific = "Sus domesticus|Sus scrofa",
         icc_id = NA_character_, cpc_id = "02140", wiki_id = "Q787", gbif_id = "7705930",
         purpose = "food", used_part = "meat") %>%
  bind_rows(animals, .)

# animals <-
#   tibble(concept = "pig-juvenile", broader = class$concept[33]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "pig-subadult", broader = class$concept[33]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "pig-subadult-female", broader = class$concept[33]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "pig-subadult-male", broader = class$concept[33]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "pig-adult", broader = class$concept[33]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "pig-adult-female", broader = class$concept[33]) %>%
#   bind_rows(animals, .)
#
# animals <-
#   tibble(concept = "pig-adult-male", broader = class$concept[33]) %>%
#   bind_rows(animals, .)

animals <-
  tibble(concept = "beehive", broader = class$concept[34], scientific = "Apis mellifera|Apis dorsata|Apis florea|Apis indica",
         icc_id = NA_character_, cpc_id = "02196", wiki_id = "Q165107", gbif_id = "1341976|1341978|1341974|1341979",
         purpose = "food|labor", used_part = "honey|time") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "silkmoth", broader = class$concept[34], scientific = "",
         icc_id = NA_character_, cpc_id = "", wiki_id = "", gbif_id = "",
         purpose = "fibre", used_part = "silk") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "fox", broader = class$concept[35], scientific = "",
         icc_id = NA_character_, cpc_id = "", wiki_id = "", gbif_id = "",
         purpose = "fibre", used_part = "hair") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "dog", broader = class$concept[35], scientific = "",
         icc_id = NA_character_, cpc_id = "", wiki_id = "", gbif_id = "",
         purpose = "food", used_part = "lint") %>%
  bind_rows(animals, .)

animals <-
  tibble(concept = "mink", broader = class$concept[36], scientific = "",
         icc_id = NA_character_, cpc_id = "", wiki_id = "", gbif_id = "",
         purpose = paste0("fibre", collapse = "|"), used_part = "hair") %>%
  bind_rows(animals, .)

luckiOnto <- new_concept(new = animals$concept,
                         broader = left_join(animals %>% select(concept, label = broader), get_concept(label = animals$broader, ontology = luckiOnto), by = "label") %>% select(id, label, class),
                         class = "animal",
                         ontology = luckiOnto)

commodity <- bind_rows(bioenergy, fibre, rubber, pasture, berries, citrus, grapes,
                       pome, stone, oleaginous, tropical, cereals, legumes, nuts,
                       oilseeds, stimulants, spice, medicinal, sugar, fruit_veg,
                       leaf_veg, mushrooms, root_veg, animals)


## mappings to other ontologies/vocabularies or attributes ----
message(" --> mappings to other vocabularies")

# clcTemp <- lu %>%
#  separate_rows(clc, sep = " \\| ")
# luckiOnto <- new_mapping(new = clcTemp$clc,
#             target = left_join(clcTemp %>% select(label = concept, clc), get_concept(label = clcTemp$concept, ontology = luckiOnto), by = "label") %>% select(id, label, class, has_broader),
#             lut = clcID,
#             source = "clc", match = "close", certainty = 3,
#             ontology = luckiOnto)

# esalcTemp <- lu %>%
#  separate_rows(esalc, sep = " \\| ")
# luckiOnto <- new_mapping(new = esalcTemp$esalc,
#             target = left_join(esalcTemp %>% select(label = concept, esalc), get_concept(label = esalcTemp$concept, ontology = luckiOnto), by = "label") %>% select(id, label, class, has_broader),
#             lut = esalcID,
#             source = "esalc", match = "close", certainty = 3,
#             ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$scientific,
                         target = left_join(commodity %>% select(label = concept, scientific), get_concept(label = commodity$concept, ontology = luckiOnto), by = "label") %>% select(id, label, class, has_broader),
                         source = "species", match = "close", certainty = 3,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$icc_id,
                         target = left_join(commodity %>% select(label = concept, icc_id), get_concept(label = commodity$concept, ontology = luckiOnto), by = "label") %>% select(id, label, class, has_broader),
                         source = "icc", match = "close", certainty = 3,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$cpc_id,
                         target = left_join(commodity %>% select(label = concept, cpc_id), get_concept(label = commodity$concept, ontology = luckiOnto), by = "label") %>% select(id, label, class, has_broader),
                         source = "cpc", match = "close", certainty = 3,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$wiki_id,
                         target = left_join(commodity %>% select(label = concept, wiki_id), get_concept(label = commodity$concept, ontology = luckiOnto), by = "label") %>% select(id, label, class, has_broader),
                         source = "wiki", match = "close", certainty = 3,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$gbif_id,
                         target = left_join(commodity %>% select(label = concept, gbif_id), get_concept(label = commodity$concept, ontology = luckiOnto), by = "label") %>% select(id, label, class, has_broader),
                         source = "gbif", match = "close", certainty = 3,
                         ontology = luckiOnto)

message(" --> mappings to attributes")

luckiOnto <- new_mapping(new = commodity$purpose,
                         target = left_join(commodity %>% select(label = concept, purpose), get_concept(label = commodity$concept, ontology = luckiOnto), by = "label") %>% select(id, label, class, has_broader),
                         source = "use-type", match = "close", certainty = 3,
                         lut = useTypes,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$used_part,
                         target = left_join(commodity %>% select(label = concept, used_part), get_concept(label = commodity$concept, ontology = luckiOnto), by = "label") %>% select(id, label, class, has_broader),
                         source = "use-part", match = "close", certainty = 3,
                         lut = usedParts,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$life_form,
                         target = left_join(commodity %>% select(label = concept, life_form), get_concept(label = commodity$concept, ontology = luckiOnto), by = "label") %>% select(id, label, class, has_broader),
                         source = "life-form", match = "close", certainty = 3,
                         lut = lifeForms,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$ybh,
                         target = left_join(commodity %>% select(label = concept, ybh), get_concept(label = commodity$concept, ontology = luckiOnto), by = "label") %>% select(id, label, class, has_broader),
                         source = "persistence", match = "close", certainty = 3,
                         lut = lut_persistence,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$yoh,
                         target = left_join(commodity %>% select(label = concept, yoh), get_concept(label = commodity$concept, ontology = luckiOnto), by = "label") %>% select(id, label, class, has_broader),
                         source = "duration", match = "close", certainty = 3,
                         lut = lut_duration,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$harvests,
                         target = left_join(commodity %>% select(label = concept, harvests), get_concept(label = commodity$concept, ontology = luckiOnto), by = "label") %>% select(id, label, class, has_broader),
                         source = "harvests", match = "close", certainty = 3,
                         lut = lut_harvests,
                         ontology = luckiOnto)

luckiOnto <- new_mapping(new = commodity$height,
                         target = left_join(commodity %>% select(label = concept, height), get_concept(label = commodity$concept, ontology = luckiOnto), by = "label") %>% select(id, label, class, has_broader),
                         source = "height", match = "close", certainty = 3,
                         lut = lut_height,
                         ontology = luckiOnto)

# 4. write output ----
#
write_rds(x = luckiOnto, file = path_onto)
onto_updated <- TRUE

beep(sound = 10)
message("\n   ... done")

