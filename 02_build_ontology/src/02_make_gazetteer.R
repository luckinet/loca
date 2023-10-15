# script arguments ----
#
message("\n---- build ontology for territories ----")


# load metadata ----
#
geoscheme <- read_csv2(file = geoscheme_path)

gadm_path <- gadm360_path
gadm_layers <- st_layers(dsn = gadm_path)


# load data ----
#
# unpack the file, if it's not yet unpacked
gadm36 <- st_read(dsn = gadm_path, layer = "level0") %>%
  st_drop_geometry()

if(!testFileExists(gadm_path)){
  if(!testFileExists(paste0(input_dir, "gadm36_levels_gpkg.zip"))){
    stop("please store 'gadm36_levels_gpkg.zip' in '", input_dir, "'")
  } else {
    if(!testFileExists(gadm_path)){
      message(" --> unpacking GADM basis")
      unzip(paste0(input_dir, "gadm36_levels_gpkg.zip"), exdir = input_dir)
    }
  }
}


# in case gadm 4.1 is used in the future, use this code
# gadm41 <- st_read(dsn = gadm410_path, layer = "ADM_0") %>%
#   st_drop_geometry()
# if(!testFileExists(gadm410_path)){
#   if(!testFileExists(paste0(input_dir, "gadm_410-levels.zip"))){
#     stop("please store 'gadm_410-levels.zip' in '", input_dir, "'")
#   } else {
#     if(!testFileExists(gadm410_path)){
#       message(" --> unpacking GADM basis")
#       unzip(paste0(input_dir, "gadm_410-levels.zip"), exdir = input_dir)
#     }
#   }
# }
# gadm_layers <- st_layers(dsn = gadm410_path)


# data processing ----
#
# first, build the UN geoscheme ...
temp_geo <- geoscheme %>%
  mutate(un_subregion = if_else(!is.na(`Intermediate Region Name`), `Intermediate Region Name`, `Sub-region Name`)) %>%
  select(unit = `Country or Area`,
         un_region = `Region Name`,
         un_subregion,
         m49 = `M49 Code`,
         iso_a2 = `ISO-alpha2 Code`,
         iso_a3 = `ISO-alpha3 Code`) %>%
  filter(!is.na(un_region)) %>%  # this filters out only Antarctica
  full_join(gadm36, by = c("iso_a3" = "GID_0")) %>%
  filter(!is.na(m49))


# ... then, start a new ontology
message(" --> initiate gazetteer")
gazetteer <- start_ontology(name = "luckiGazetteer", path = onto_dir,
                            version = "1.0.0",
                            code = ".xxx",
                            description = "the intial LUCKINet gazetteer",
                            homepage = "https://www.luckinet.org",
                            license = "CC-BY-4.0",
                            notes = "This gazetteer nests each country and their sub-level territories into the United Nations geoscheme. In parallel, as some concepts span several countries, for example 'France', and as these concepts would then not be nestable into the UN geoscheme, there is in parallel also a class 'nation' (at the first level) that is for those concepts that might occurr in the thematic described with the ontology. ")

# define GADM as source
gazetteer <- new_source(name = "gadm",
                        version = "3.6",
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
  new_class(new = "al5", target = "al4",
            description = "the fifth administrative level of the GADM gazetteer", ontology = .) %>%
  new_class(new = "al6", target = "al5",
            description = "the sixth administrative level of the GADM gazetteer", ontology = .) #%>%
  # new_class(new = "nation", target = NA,
  #           description = "groups of al1 concepts that together form a nation, which might span several of the other concepts (for example 'France', which is a combination of many territorial concepts across the whole world)", ontology = .)

# define the harmonised concepts
message("     UN geoscheme")
un_region <- toupper(unique(temp_geo$un_region))

gazetteer <- new_concept(new = un_region,
                         class = "un_region",
                         ontology =  gazetteer)

un_subregion <- temp_geo %>%
  select(broader = un_region, concept = un_subregion) %>%
  distinct() %>%
  mutate(broader = toupper(broader))

tempConcepts <- get_concept(label = un_subregion$broader, ontology = gazetteer) %>%
  left_join(un_subregion %>% select(label = broader, concept), ., by = "label")
gazetteer <- new_concept(new = tempConcepts$concept,
                         broader = tempConcepts,
                         class = "un_subregion",
                         ontology =  gazetteer)


for(i in 1:6){

  message("     GADM level ", i)

  gazetteer <- new_mapping(new = paste0("NAME_", i-1),
                           target = tibble(label = paste0("al", i)),
                           source = "gadm", match = "exact", certainty = 3,
                           type = "class", ontology = gazetteer)


  if(i == 1){

    previous <- get_concept(label = un_subregion$concept, ontology = gazetteer)

    temp <- st_read(dsn = gadm_path, layer = gadm_layers$name[i]) %>%
      st_drop_geometry() %>%
      as_tibble() %>%
      distinct() %>%
      # select(starts_with(c("COUNTRY", "NAME_"))) %>%
      # mutate(across(all_of(contains(c("COUNTRY", "NAME_"))),
      select(starts_with("NAME_")) %>%
      mutate(across(all_of(contains("NAME_")),
                    function(x){
                      temp <- trimws(x)
                      str_replace_all(string = temp, pattern = "[.]", replacement = "")
                    }))

    exclude entries such as "Åland Islands" here, as they are not available in the un geoscheme

    mapGADM <- temp %>%
      # full_join(temp_geo, by = "COUNTRY") %>%
      full_join(temp_geo, by = "NAME_0") %>%
      filter(!is.na(un_subregion)) %>%
      rename("label" = "un_subregion") %>%
      left_join(previous, by = "label")

    items <- mapGADM %>%
      # select(concept = "COUNTRY", label, id, class) %>%
      select(concept = unit, label, id, class)

  } else if(i == 2) {

    previous <- get_concept(label = items$concept, has_broader = items$id, class = paste0("al", i-1), ontology = gazetteer) %>%
      rename(parent_label = label)

    temp <- st_read(dsn = gadm_path, layer = gadm_layers$name[i]) %>%
      st_drop_geometry() %>%
      filter(!.data[[paste0("ENGTYPE_", i-1)]] %in% c("Water body", "Water Body", "Waterbody")) %>%
      as_tibble() %>%
      select(starts_with("NAME_")) %>%
      mutate(across(all_of(contains("NAME_")),
                    function(x){
                      temp <- trimws(x)
                      str_replace_all(string = temp, pattern = "[.]", replacement = "")
                    }))

    items <- temp %>%
      # mutate(!!paste0("NAME_", i-1) := if_else(is.na(!!sym(paste0("NAME_", i-1))), !!sym("COUNTRY"), !!sym(paste0("NAME_", i-1)))) %>%
      mutate(!!paste0("NAME_", i-1) := if_else(is.na(!!sym(paste0("NAME_", i-1))), !!sym(paste0("NAME_", i-2)), !!sym(paste0("NAME_", i-1)))) %>%
      # filter(COUNTRY %in% temp_geo$COUNTRY) %>%
      filter(NAME_0 %in% temp_geo$NAME_0) %>%
      # rename("label" = "COUNTRY") %>%
      rename("parent_label" = !!paste0("NAME_", i-2)) %>%
      left_join(previous, by = "parent_label") %>%
      select(concept = !!paste0("NAME_", i-1), label = parent_label, id, class)

  } else {

    previous <- get_concept(label = items$concept, has_broader = items$id, class = paste0("al", i-1), ontology = gazetteer) %>%
      left_join(previous %>% select(id, parent_label), c("has_broader" = "id")) %>%
      unite(col = "parent_label", parent_label, label, sep = ".", na.rm = TRUE, remove = FALSE)

    temp <- st_read(dsn = gadm_path, layer = gadm_layers$name[i]) %>%
      st_drop_geometry() %>%
      filter(!.data[[paste0("ENGTYPE_", i-1)]] %in% c("Water body", "Water Body", "Waterbody")) %>%
      as_tibble() %>%
      select(starts_with("NAME_")) %>%
      mutate(across(all_of(contains("NAME_")),
                    function(x){
                      temp <- trimws(x)
                      str_replace_all(string = temp, pattern = "[.]", replacement = "")
                    }))

    items <- temp %>%
      # mutate(!!paste0("NAME_", i-1) := if_else(is.na(!!sym(paste0("NAME_", i-1))), !!sym("COUNTRY"), !!sym(paste0("NAME_", i-1)))) %>%
      mutate(!!paste0("NAME_", i-1) := if_else(is.na(!!sym(paste0("NAME_", i-1))), !!sym(paste0("NAME_", i-2)), !!sym(paste0("NAME_", i-1)))) %>%
      # filter(COUNTRY %in% temp_geo$COUNTRY) %>%
      filter(NAME_0 %in% temp_geo$NAME_0) %>%
      # unite(col = "parent_label", sort(str_subset(colnames(temp), "COUNTRY|^NAME_"))[(i-2):(i-1)], sep = ".", na.rm = TRUE, remove = FALSE) %>%
      unite(col = "parent_label", sort(str_subset(colnames(temp), "^NAME_"))[1:(i-1)], sep = ".", na.rm = TRUE, remove = FALSE) %>%
      left_join(previous, by = "parent_label") %>%
      select(concept = !!paste0("NAME_", i-1), label, id, class)

  }

  items <- items %>%
    distinct() %>%
    filter(!is.na(concept) & !is.na(label))

  # test whether broader concepts are all present
  broaderMissing <- get_concept(label = items$label, ontology = gazetteer) %>%
    filter(is.na(id))
  if(dim(broaderMissing)[1] != 0) stop("some broader concepts are missing from the current ontology!")

  # assign the new concepts into the ontology
  gazetteer <- new_concept(new = items %>% pull(concept),
                           broader = items %>% select(id, label, class),
                           class = paste0("al", i),
                           ontology =  gazetteer)

  if(i == 1){
    gazetteer <- new_mapping(new = mapGADM$NAME_0,
                             target = left_join(mapGADM %>% select(label = unit), get_concept(label = mapGADM$unit, ontology = gazetteer), by = "label") %>% select(id, label, class, has_broader),
                             source = "gadm", match = "close", certainty = 3,
                             ontology = gazetteer)
  }

}



# write output ----
#
write_rds(x = gazetteer, file = gaz_path)

# beep(sound = 10)
message("\n     ... done")
