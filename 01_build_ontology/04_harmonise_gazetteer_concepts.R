# script arguments ----
#
message("\n---- harmonise previous concepts ----")


# load metadata ----
#
if(!exists("gaz_updated")){
  stop("\n\n! this script should only be run after the gazetteer has been updated !")
}


# load data ----
#
gaz <- load_ontology(path = path_gaz)


# data processing ----
#
# read matching tables
message(" --> load matching tables")

match <- list.files(path = paste0(dir_census_wip, "meta/lucki_gazetteer"), full.names = TRUE, pattern = "match_")
match <- match[!str_detect(string = match, pattern = "_old.")]

if(length(match) != 0){

  for(i in seq_along(match)){

    theTable <- read_rds(file = match[i])
    newName <- str_split(match[i], "[.]")[[1]]
    temp <- str_split(tail(str_split(string = newName[1], "/")[[1]], 1), "_")[[1]]
    message(paste0(" --> harmonising dataseries '", temp[2], "'"))

    newName <- paste0(newName[1], "_old.", newName[2])

    toIgnore <- theTable %>%
      filter(label == "ignore")

    temp <- theTable %>%
      filter(label != "ignore") %>%
      rename(id_new = id, has_broader_new = has_broader)

    # newTable <- gaz@concepts$harmonised %>%
    #   select(-has_close_match, -has_broader_match, -has_narrower_match, -has_exact_match, -description) %>%
    #   mutate(keep = TRUE) %>%
    #   left_join(temp, ., by = c("label", "class")) %>%
    #   mutate(keep = if_else(keep | label == "ignore", TRUE, FALSE)) %>%
    #   filter(keep) %>%
    #   # left_join(temp, ., by = c("label", "class", "id", "has_broader")) %>%
    #   # mutate(keep = if_else(keep | label == "ignore" | !is.na(has_broader_match) | !is.na(has_close_match) | !is.na(has_exact_match) | !is.na(has_narrower_match), TRUE, FALSE)) %>%
    #   # filter(!is.na(keep)) %>%
    #   arrange(id) %>%
    #   select(colnames(theTable))

    newTable <- toIgnore %>%
      bind_rows(newTable)

    if(!isTRUE(all.equal(as.data.frame(theTable), as.data.frame(newTable)))){
      message("     concepts adapted")
      # write_csv(x = theTable, file = newName, na = "", quote = "all")
      # write_csv(x = newTable, file = match[i], na = "", quote = "all")
      write_rds(x = theTable, file = newName)
      write_rds(x = newTable, file = match[i])
    }

  }

} else {
  message("no previous tables available yet!")
}

# beep(sound = 10)
message("\n     ... done")
