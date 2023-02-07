# script arguments ----
#
message("\n---- build ontology for territories ----")


# load metadata ----
#
countries_sf <- read_rds(file = countryDir)


# load data ----
#
# unpack the file, if it's not yet unpacked
if(!testFileExists(gadmDir)){
  if(!testFileExists(paste0(dataDir, "/input/gadm36_levels_gpkg.zip"))){
    stop("please store 'gadm36_levels_gpkg.zip' in '", dataDir, "/input/'")
  } else {
    if(!testFileExists(paste0(dataDir, "/input/gadm36_levels.gpkg"))){
      message(" --> unpacking GADM basis")
      unzip(paste0(dataDir, "/input/gadm36_levels_gpkg.zip"))
    }
  }
}

gadm_layers <- st_layers(dsn = gadmDir)


# data processing ----
#
# start a new ontology
message(" --> initiate gazetteer")
gazetteer <- start_ontology(name = "gazetteer", path = paste0(dataDir, "/tables/"),
                            version = "1.0.0",
                            code = ".xxx",
                            description = "the intial LUCKINet gazetteer",
                            homepage = "https://www.luckinet.org",
                            license = "CC-BY-4.0",
                            notes = "This gazetteer nests each country and their sub-level territories into the United Nations geoscheme. In parallel, as some concepts span several countries, for example 'France', and as these concepts would then not be nestable into the UN geoscheme, there is in parallel also a class 'nation' (at the first level) that is for those concepts that might occurr in the thematic described with the ontology. ")

# define GADM as source
gazetteer <- new_source(name = "gadm",
                        date = Sys.Date(),
                        description = "GADM wants to map the administrative areas of all countries, at all levels of sub-division. We provide data at high spatial resolutions that includes an extensive set of attributes. ",
                        homepage = "https://gadm.org/index.html",
                        license = "CC-BY",
                        ontology = gazetteer)

# define new classes
gazetteer <- new_class(new = "un_region", target = NA,
                       description = "region according to the UN geoscheme", ontology = gazetteer) %>%
  new_class(new = "un_subregion", target = "un_region",
            description = "sub-region according to the UN geoscheme", ontology = .) %>%
  new_class(new = "al1", target = "un_subregion",
            description = "the first administrative level of the GADM gazetteer", ontology = .) %>%
  new_class(new = "al2", target = "al1",
            description = "the second administrative level of the GADM gazetteer", ontology = .) %>%
  new_class(new = "al3", target = "al2",
            description = "the third administrative level of the GADM gazetteer", ontology = .) %>%
  new_class(new = "al4", target = "al3",
            description = "the fourth administrative level of the GADM gazetteer", ontology = .) %>%
  new_class(new = "nation", target = NA,
            description = "groups of al1 concepts that together form a nation, which might span several of the other concepts (for example 'France', which is a combination of many territorial concepts across the whole world)", ontology = .)

# define the harmonised concepts
message("     UN geoscheme")
un_region <- c("AFRICA", "AMERICAS", "ANTARCTICA", "ASIA", "EUROPE", "OCEANIA")

gazetteer <- new_concept(new = un_region,
                         class = "un_region",
                         ontology =  gazetteer)

un_subregion <- tibble(concept = c(
  "Eastern Africa",
  "Middle Africa",
  "Northern Africa",
  "Southern Africa",
  "Western Africa",
  "Caribbean",
  "Central America",
  "Northern America",
  "Southern America",
  "Antarctica",
  "Central Asia",
  "Eastern Asia",
  "Southeastern Asia",
  "Southern Asia",
  "Western Asia",
  "Eastern Europe",
  "Northern Europe",
  "Southern Europe",
  "Western Europe",
  "Australia and New Zealand",
  "Melanesia",
  "Micronesia",
  "Polynesia"),
  broader = c(rep(un_region[1], 5), rep(un_region[2], 4), rep(un_region[3], 1),
             rep(un_region[4], 5), rep(un_region[5], 4), rep(un_region[6], 4)))

gazetteer <- new_concept(new = un_subregion$concept,
                         broader = get_concept(table = un_subregion %>% select(label = broader), ontology = gazetteer),
                         class = "un_subregion",
                         ontology =  gazetteer)


for(i in 1:4){

  message("     GADM level ", i)

  gazetteer <- new_mapping(new = paste0("NAME_", i-1),
                           target = tibble(label = paste0("al", i)),
                           source = "gadm", match = "exact", certainty = 3,
                           type = "class", ontology = gazetteer)

  temp <- st_read(dsn = gadmDir, layer = gadm_layers$name[i]) %>%
    st_drop_geometry() %>%
    as_tibble() %>%
    select(starts_with("NAME_")) %>%
    mutate(across(all_of(contains("NAME_")),
                  function(x){
                    temp <- trimws(x)
                    str_replace_all(string = temp, pattern = "[.]", replacement = "")
                  }))

  if(i == 1){

    previous <- get_concept(table = un_subregion %>% select(label = concept), ontology = gazetteer)

    items <- temp %>%
      full_join(countries_sf %>% st_drop_geometry(),
                by = c("NAME_0" = "gadm_name")) %>%
      filter(!is.na(un_subregion)) %>%
      rename("label" = "un_subregion") %>%
      left_join(previous, by = "label") %>%
      select(concept = !!paste0("NAME_", i-1), label, id, class)

  } else if(i == 2) {

    items <- temp %>%
      mutate(!!paste0("NAME_", i-1) := if_else(is.na(!!sym(paste0("NAME_", i-1))), !!sym(paste0("NAME_", i-2)), !!sym(paste0("NAME_", i-1)))) %>%
      filter(NAME_0 %in% countries_sf$gadm_name) %>%
      rename("label" = !!paste0("NAME_", i-2)) %>%
      left_join(previous, by = "label") %>%
      select(concept = !!paste0("NAME_", i-1), label, id, class)

  } else {

    items <- temp %>%
      mutate(!!paste0("NAME_", i-1) := if_else(is.na(!!sym(paste0("NAME_", i-1))), !!sym(paste0("NAME_", i-2)), !!sym(paste0("NAME_", i-1)))) %>%
      filter(NAME_0 %in% countries_sf$gadm_name) %>%
      unite(col = "parent_label", sort(str_subset(colnames(temp), "^NAME_"))[(i-2):(i-1)], sep = ".", na.rm = TRUE, remove = FALSE) %>%
      left_join(previous, by = "parent_label") %>%
      select(concept = !!paste0("NAME_", i-1), label, id, class)

  }

  items <- items %>%
    distinct() %>%
    filter(!is.na(concept))

  # test whether broader concepts are all present
  broaderMissing <- get_concept(table = items %>% select(label), ontology = gazetteer) %>%
    filter(is.na(id))
  if(dim(broaderMissing)[1] != 0) stop("some broader concepts are missing from the current ontology!")

  # assign the new concepts into the ontology
  gazetteer <- new_concept(new = items %>% pull(concept),
                           broader = items %>% select(id, label, class),
                           class = paste0("al", i),
                           ontology =  gazetteer)

  # and re-construct the concepts for this level
  parent <- get_concept(table = items %>% select(label, class) %>% distinct(), ontology = gazetteer)
  previous <- get_concept(table = items %>% select(label = concept, has_broader = id) %>% mutate(class = paste0("al", i)), ontology = gazetteer) %>%
    left_join(parent %>% select(id, parent = label), c("has_broader" = "id")) %>%
    unite(col = "parent_label", parent, label, sep = ".", na.rm = TRUE, remove = FALSE)

}


# write output ----
#
write_rds(x = gazetteer, file = paste0(dataDir, "tables/gazetteer.rds"))
