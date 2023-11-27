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


# data processing ----
#
other <- tibble(un_region = c("Asia", "Europe", "Asia"),
                un_subregion = c("Eastern Asia", "Southern Europe", "Western Asia"),
                iso_a3 = c("TWN", "XKO", "XNC"),
                unit = c("Taiwan", "Kosovo", "Northern Cyprus"))

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
  bind_rows(other) %>%
  full_join(gadm36, by = c("iso_a3" = "GID_0")) %>%
  filter(!is.na(un_region))


# ... then, start a new ontology ----
message(" --> initiate gazetteer")
gazetteer <- start_ontology(name = "lucki_gazetteer", path = onto_dir,
                            version = "1.0.0",
                            code = ".xxx",
                            description = "the intial LUCKINet gazetteer",
                            homepage = "https://www.luckinet.org",
                            license = "CC-BY-4.0",
                            notes = "This gazetteer nests each country and their sub-level territories into the United Nations geoscheme. In parallel, as some concepts span several countries, for example 'France', and as these concepts would then not be nestable into the UN geoscheme, there is in parallel also a class 'nation' (at the first level) that is for those concepts that might occurr in the thematic described with the ontology. ")

# define GADM as source
gazetteer <- new_source(name = "gadm36",
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
            description = "the sixth administrative level of the GADM gazetteer", ontology = .)

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

  thisLabel <- paste0("NAME_", i-1)
  if(i == 1){
    prevLabel <- "un_subregion"
  } else {
    prevLabel <- paste0("NAME_", i-2)
  }

  gazetteer <- new_mapping(new = thisLabel,
                           target = tibble(label = paste0("al", i)),
                           source = "gadm36", match = "exact", certainty = 3,
                           type = "class", ontology = gazetteer)

  temp <- st_read(dsn = gadm_path, layer = gadm_layers$name[i]) %>%
    st_drop_geometry() %>%
    filter(if_any(matches(paste0("ENGTYPE_", i-1)), ~ !.x %in% c("Water body", "Water Body", "Waterbody"))) %>%
    as_tibble() %>%
    select(starts_with("NAME_")) %>%
    mutate(across(all_of(contains("NAME_")),
                  function(x){
                    temp <- trimws(x)
                    str_replace_all(string = temp, pattern = "[.]", replacement = "")
                  }))

  mapGADM <- temp %>%
    full_join(temp_geo, by = "NAME_0") %>%
    mutate(!!thisLabel := if_else(is.na(!!sym(thisLabel)), !!sym(prevLabel), !!sym(thisLabel))) %>%
    select(-NAME_0) %>%
    rename(NAME_0 = unit) %>%
    filter(!is.na(un_subregion))

  if(i == 1){

    mapGADM <- mapGADM %>%
      rename("previous_label" = !!prevLabel)

    previous <- get_concept(label = un_subregion$concept, ontology = gazetteer) %>%
      rename(previous_label = label)

  } else if(i == 2) {

    mapGADM <- mapGADM %>%
      unite(col = "previous_label", sort(str_subset(colnames(temp), "^NAME_"))[1:(i-1)], sep = ".", na.rm = TRUE, remove = FALSE)

    previous <- get_concept(label = items[[prevLabel]], has_broader = items$id, class = paste0("al", i-1), ontology = gazetteer) %>%
      rename(previous_label = label)

  } else {

    mapGADM <- mapGADM %>%
      unite(col = "previous_label", sort(str_subset(colnames(temp), "^NAME_"))[1:(i-1)], sep = ".", na.rm = TRUE, remove = FALSE)

    previous <- get_concept(label = items[[prevLabel]], has_broader = items$id, class = paste0("al", i-1), ontology = gazetteer) %>%
      left_join(previous %>% select(id, previous_label), c("has_broader" = "id")) %>%
      unite(col = "previous_label", previous_label, label, sep = ".", na.rm = TRUE, remove = FALSE)

  }

  items <- mapGADM %>%
    left_join(previous, by = "previous_label") %>%
    distinct() %>%
    filter(!is.na(!!sym(thisLabel)) & !is.na(id))

  # test whether broader concepts are all present
  broaderMissing <- get_concept(label = items[[{{thisLabel}}]], ontology = gazetteer) %>%
    filter(is.na(id))
  if(dim(broaderMissing)[1] != 0) stop("some broader concepts are missing from the current ontology!")

  # assign the new concepts into the ontology
  gazetteer <- new_concept(new = items %>% pull({{thisLabel}}),
                           broader = items %>% select(id, label = previous_label, class),
                           class = paste0("al", i),
                           ontology =  gazetteer)

  if(i == 1){
    gazetteer <- new_mapping(new = mapGADM$NAME_0,
                             target = left_join(mapGADM %>% select(label = NAME_0), get_concept(label = mapGADM$NAME_0, ontology = gazetteer), by = "label") %>% select(id, label, class, has_broader),
                             source = "gadm36", match = "close", certainty = 3,
                             ontology = gazetteer)
  }

}


# write output ----
#
write_rds(x = gazetteer, file = gaz_path)
gaz_updated <- TRUE

# beep(sound = 10)
message("\n     ... done")
