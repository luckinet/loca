# Select a system specific path ----
#
# This function calls Sys.info() and selects from the provided arguments that
# path that corresponds to the recent nodename.
#
# ...                   combination of a nodename and the path that should be
#                       valid here.
# default  [character]  a fallback path that should be

select_path <- function(..., default = NULL){

  sys <- Sys.info()

  paths <- exprs(...)
  out <- eval_tidy(paths[sys[["nodename"]]][[1]])

  if(length(out) == 0 & !is.null(default)){
    assertDirectoryExists(x = default, access = "rw")
    out <- default
  }

  return(out)
}


# Write profile for the current model run ----
#
# root        [character]  the main path, where this model resides.
# name        [character]  the name of this model.
# version     [character]  the version identifier.
# parameters  [list]       list of the profile parameters.

write_profile <- function(root, name, parameters, version = NULL){

  assertDirectoryExists(x = root, access = "rw")
  assertCharacter(x = name, len = 1)
  assertNames(x = names(parameters), must.include = c("years", "pixel_size", "censusDB_dir", "censusDB_extent", "occurrenceDB_dir", "occurrenceDB_extent", "landcover", "suitability_predictors"))
  assertSubset(x = parameters$censusDB_extent, choices = parameters$occurrenceDB_extent)
  assertCharacter(x = parameters$landcover, len = 1)
  assertCharacter(x = parameters$suitability_predictors, any.missing = FALSE)
  assertNumeric(x = parameters$pixel_size, len = 2)
  assertNumeric(x = parameters$tile_size, len = 2)
  assertCharacter(x = version, null.ok = TRUE)

  # set last char to "/", if it isn't yet
  if(str_sub(root, nchar(root)) != "/"){
    root <- paste0(root, "/")
  }

  if(is.null(version)){
    stop("please profice a version number.")
  }

  # build all the directories in 'run'
  if(!testDirectoryExists(x = paste0(root, "model_run/"))){
    dir.create(paste0(root, "model_run/"))
  }
  if(!testDirectoryExists(x = paste0(root, "model_run/", name, "_", version))){
    dir.create(paste0(root, "model_run/", name, "_", version))
    dir.create(paste0(root, "model_run/", name, "_", version, "/drivers"))
    dir.create(paste0(root, "model_run/", name, "_", version, "/initial_landuse"))
    dir.create(paste0(root, "model_run/", name, "_", version, "/intermediate"))
    dir.create(paste0(root, "model_run/", name, "_", version, "/input"))
    dir.create(paste0(root, "model_run/", name, "_", version, "/tiles"))
    dir.create(paste0(root, "model_run/", name, "_", version, "/tables"))
    dir.create(paste0(root, "model_run/", name, "_", version, "/suitability"))
    dir.create(paste0(root, "model_run/", name, "_", version, "/suitability/models"))
  }

  profileFull <- paste0(name, "_", version, "_profile.txt")

  censusDB_extent <- paste0(parameters$censusDB_extent, collapse = "\t")
  occurrenceDB_extent <- paste0(parameters$occurrenceDB_extent, collapse = "\t")
  censusDB_dir <- paste0(parameters$censusDB_dir, collapse = "\t")
  occurrenceDB_dir <- paste0(parameters$occurrenceDB_dir, collapse = "\t")
  years <- paste0(parameters$year, collapse = "\t")
  extent <- paste0(parameters$extent, collapse = "\t")
  pixel_size <- paste0(parameters$pixel_size, collapse = "\t")
  tile_size <- paste0(parameters$tile_size, collapse = "\t")
  toPredictors <- paste0(parameters$suitability_predictors, collapse = "\t")
  rootPath <- paste0(root, "model_run/", name, "_", version, "/")
  toWrite <- paste0(c(name, version, rootPath, years, extent, pixel_size, tile_size,
                      censusDB_dir, censusDB_extent, occurrenceDB_dir, occurrenceDB_extent,
                      parameters$landcover, toPredictors), collapse = "\n")

  if(testFileExists(x =  paste0(root, "model_run/", profileFull))){
    message("the current profile (name + version) already exists")
    continue <- readline(prompt = "to overwrite it, type 'yes' or otherwise press any other key: ")

    if(continue == "yes"){
      write_lines(x = toWrite, file = paste0(root, profileFull), append = FALSE)
    } else {
      return(NULL)
    }
  }

  write_lines(x = toWrite, file = paste0(root, "model_run/", profileFull))
}

# Write profile for the current model run ----
#
# root     [character]  the main path, where this model resides.
# name     [character]  the name of this model.
# version  [character]  the version identifier.

load_profile <- function(root, name, version = NULL){

  assertDirectoryExists(x = root, access = "rw")
  assertCharacter(x = name, len = 1)
  assertCharacter(x = version, null.ok = TRUE)

  if(str_sub(root, nchar(root)) != "/"){
    root <- paste0(root, "/")
  }

  if(is.null(version)){
    stop("please profice a version number.")
  }

  profileFull <- paste0(name, "_", version, "_profile.txt")

  if(!testFileExists(x = paste0(root, "model_run/", profileFull), access = "rw")){
    stop("the profile '", profileFull, "' does not exist. Please create it with write_profile()")
  } else {
    temp <- read_lines(file = paste0(root, "model_run/", profileFull), na = "")

    out <- NULL
    out$name <- temp[[1]]
    out$version <- temp[[2]]
    out$dir <- temp[[3]]
    out$years <- as.numeric(str_split(temp[[4]], "\t")[[1]])
    tempExt <- as.numeric(str_split(temp[[5]], "\t")[[1]])
    names(tempExt) <- c("xmin", "xmax", "ymin", "ymax")
    out$extent <- tempExt
    out$pixel_size <- as.numeric(str_split(temp[[6]], "\t")[[1]])
    out$tile_size <- as.numeric(str_split(temp[[7]], "\t")[[1]])
    out$censusDB_dir <- temp[[8]]
    out$censusDB_extent <- str_split(temp[[9]], "\t")[[1]]
    out$occurrenceDB_dir <- str_split(temp[[10]], "\t")[[1]]
    out$occurrenceDB_extent <- str_split(temp[[11]], "\t")[[1]]
    out$landcover <- str_split(temp[[12]], "\t")[[1]]
    out$suitability_predictors <- str_split(temp[[13]], "\t")[[1]]

    return(out)
  }

}

# Start an occurrence database ----
#
# root  [character]  path to the root directory that contains or shall contain a
#                    point database.

start_occurrenceDB <- function(root = NULL){

  assertCharacter(x = root, len = 1)

  # shitty windows workaround, because a directory may not have a trailing slash
  # for the function "file.exists()" used in assertDirectory()
  lastChar <- substr(x = root, start = nchar(root), stop = nchar(root))
  if(lastChar == "/"){
    root <- substr(root, start = 1, stop = nchar(root)-1)
  }

  # test whether the required directories exist and create them if they don't exist
  if(!testDirectory(x = root, access = "rw")){
    dir.create(file.path(root))
    dir.create(file.path(root, "01_concepts"))
    dir.create(file.path(root, "02_processed"))
    message("I have created a new project directory.")
  }

  # create the empty inventory tables, if they don't exist yet
  if(!testFileExists(x = file.path(root, "inv_datasets.csv"))){
    dataseries <- tibble(datID = integer(),
                         name = character(),
                         type = character(),
                         description = character(),
                         url = character(),
                         download_date = character(),
                         licence = character(),
                         notes = character(),
                         contact = character(),
                         disclosed = character())
    write_csv(x = dataseries,
              file = paste0(root, "/inv_datasets.csv"),
              na = "")
  }

  if(!testFileExists(x = file.path(root, "references.bib"))){
    bibentry(
      bibtype = "Misc",
      title = "LUCKINet overall computation algorithm (LOCA)",
      author = c(
        person(given = "Steffen", family = "Ehrmann",
               role = c("aut", "cre"),
               email = "steffen.ehrmann@idiv.de",
               comment = c(ORCID = "0000-0002-2958-0796")),
        person(given = "Carsten", family = "Meyer",
               role = c("aut"),
               email = "carsten.meyer@idiv.de",
               comment = c(ORCID="0000-0003-3927-5856"))
      ),
      organization = "Macroecology and Society Lab @iDiv",
      year = 2023,
      url = "https://www.idiv.de/de/luckinet.html") %>%
      toBibtex() %>%
      write_lines(file = paste0(root, "/references.bib"), append = TRUE)
  }

}

# Start a grid database
#
# root  [character]  path to the root directory that contains or shall contain a
#                    grid database.

start_gridDB <- function(root = NULL){

  assertCharacter(x = root, len = 1)

  # shitty windows workaround, because a directory may not have a trailing slash
  # for the function "file.exists()" used in assertDirectory()
  lastChar <- substr(x = root, start = nchar(root), stop = nchar(root))
  if(lastChar == "/"){
    root <- substr(root, start = 1, stop = nchar(root)-1)
  }

  # test whether the required directories exist and create them if they don't exist
  if(!testDirectory(x = root, access = "rw")){
    dir.create(file.path(root))
    dir.create(file.path(root, "input"))
    dir.create(file.path(root, "processed"))
    message("I have created a new project directory.")
  }

  # create the empty inventory tables, if they don't exist yet
  if(!testFileExists(x = file.path(root, "inv_datasets.csv"))){
    dataseries <- tibble(datID = integer(),
                         name = character(),
                         type = character(),
                         description = character(),
                         url = character(),
                         download_date = character(),
                         licence = character(),
                         notes = character(),
                         contact = character(),
                         disclosed = character())
    write_csv(x = dataseries,
              file = paste0(root, "/inv_datasets.csv"),
              na = "")
  }

  if(!testFileExists(x = file.path(root, "references.bib"))){
    bibentry(
      bibtype = "Misc",
      title = "LUCKINet universal computation algorithm (LUCA)",
      author = c(
        person(given = "Steffen", family = "Ehrmann",
               role = c("aut", "cre"),
               email = "steffen.ehrmann@idiv.de",
               comment = c(ORCID = "0000-0002-2958-0796")),
        # person(given = "Ruben", family = "Remelgado",
        #        role = c("aut"),
        #        email = "ruben.remelgado@idiv.de",
        #        comment = c(ORCID="0000-0002-9871-5703")),
        person(given = "Carsten", family = "Meyer",
               role = c("aut"),
               email = "carsten.meyer@idiv.de",
               comment = c(ORCID="0000-0003-3927-5856"))
      ),
      organization = "Macroecology and Society Lab @iDiv",
      year = 2022,
      url = "https://www.idiv.de/de/luckinet.html") %>%
      toBibtex() %>%
      write_lines(file = paste0(root, "/references.bib"), append = TRUE)
  }

}


# Register a new data-set ----
#
# This function registers a new data-series into a list of meta-data.
# name           [character]  the data-series abbreviation.
# description    [character]  the "long name" or "brief description" of the
#                             data-series.
# type           [character]  one of the types "dynamic" or "static" indicating
#                             whether the data-set is dynamically updated or not.
# bibliography   [character]  the reference of this data-set as bibentry.
# url            [character]  the homepage of the data provider where the
#                             data-set or additional information can be found.
# download_date  [character]  YYYY-MM-DD representation of the date when the
#                             data-set was downloaded.
# licence        [character]  path to the local file in which the licence text
#                             is stored.
# contact        [character]  E-Mail or name of the person to contact regarding
#                             this data-set.
# disclosed      [logical]    whether the data-set is disclosed to the public,
#                             or whether some terms of use have to be followed.
# notes          [character]  optional notes.
# path           [logical]    the path to the invetory table.

regDataset <- function(name = NULL, description = NULL, type = NULL,
                       bibliography = NULL, url = NULL, download_date = NULL,
                       licence = NULL, contact = NULL, disclosed = NULL,
                       notes = NULL, path = NULL){

  # get tables
  inv_datasets <- read_csv(file = paste0(path, "inv_datasets.csv"), col_types = "iccccDcccl")

  # check validity of arguments
  assertDataFrame(x = inv_datasets)
  assertNames(x = colnames(inv_datasets), permutation.of = c("datID", "name", "type", "description", "url", "download_date", "licence", "notes", "contact", "disclosed"))
  assertCharacter(x = name, ignore.case = TRUE, any.missing = FALSE, len = 1, null.ok = TRUE)
  assertCharacter(x = description, ignore.case = TRUE, any.missing = FALSE, len = 1, null.ok = TRUE)
  assertCharacter(x = url, ignore.case = TRUE, any.missing = FALSE, len = 1)
  assertDate(x = download_date, any.missing = FALSE, len = 1)
  assertCharacter(x = licence, ignore.case = TRUE, any.missing = FALSE, len = 1, null.ok = TRUE)
  assertCharacter(x = contact, ignore.case = TRUE, any.missing = FALSE, len = 1, null.ok = TRUE)
  assertCharacter(x = notes, ignore.case = TRUE, any.missing = FALSE, len = 1, null.ok = TRUE)
  assertLogical(x = disclosed)

  message("\n---- ", name, " ----")

  # ask for missing and required arguments
  if(is.null(name)){
    message("please type in the dataset name: ")
    theName <- readline()
    if(is.na(theName)){
      theName = NA_character_
    }
  } else {
    theName <- name
  }

  if(is.null(description)){
    message("please provide the description of the dataset: ")
    theDescription <- readline()
    if(is.na(theDescription)){
      theDescription = NA_character_
    }
  } else{
    theDescription <- description
  }

  if(is.null(type)){
    message("please provide the type of this dataset (chose from: study, validation, collection): ")
    theType <- readline()
    if(is.na(theType)){
      theType = NA_character_
    }
  } else {
    theType <- type
  }
  assertChoice(x = theType, choices = c("dynamic", "static"))

  if(is.null(url)){
    message("please type in the dataset url (ideally it is a doi.org url: ")
    theDOI <- readline()
    if(is.na(theDOI)){
      theDOI = NA_character_
    }
  } else{
    theDOI <- url
  }

  if(is.null(licence)){
    message("please type in the description of the license of this dataset: ")
    thelicence <- readline()
    if(is.na(thelicence)){
      thelicence = NA_character_
    }
  } else{
    thelicence <- licence
  }

  if(is.null(contact)){
    message("please type in the contact details of this dataset: ")
    theContact <- readline()
    if(is.na(theContact)){
      theContact = NA_character_
    }
  } else{
    theContact <- contact
  }

  if(is.null(download_date)){
    message("please type in the download date of this dataset: ")
    theDate <- readline()
    if(is.na(theDate)){
      theDate = NA
    }
  } else{
    theDate <- download_date
  }

  if(is.null(notes)){
    notes = NA_character_
  }

  # construct new documentation
  newDID <- ifelse(length(inv_datasets$datID)==0, 1, as.integer(max(inv_datasets$datID)+1))

  temp <- tibble(datID = as.integer(newDID),
                 name = theName,
                 type = theType,
                 description = theDescription,
                 url = theDOI,
                 download_date = theDate,
                 licence = thelicence,
                 contact = theContact,
                 disclosed = disclosed,
                 notes = notes)

  if(theName %in% inv_datasets$name){

    old <- inv_datasets %>%
      filter(name == theName)

    if(all(map2_lgl(temp, old, `==`), na.rm = TRUE)){
      message("! the data-series '", name, "' has already been registered !")
      temp <- inv_datasets[which(inv_datasets$name %in% name), ]
      return(temp)
    }
  }

  bib <- read_lines(file = paste0(path, "/references.bib"))
  if(bib[length(bib)] != ""){
    bib <- c(bib, "")
  }
  if(class(bibliography) %in% "handl"){
    bibliography$key <- theName
    bibliography$id <- theName
    tempBib <- bibtex_writer(bibliography)
  } else if(class(bibliography) %in% "bibentry"){
    tempBib <- format(bibliography, style = "Bibtex") %>%
      str_split(pattern = "\n") %>%
      unlist()
  }
  bib <- c(bib, tempBib)
  write_lines(x = bib, file = paste0(path, "/references.bib"))

  # join the old table with 'index'
  out <- dplyr::union(inv_datasets, temp) %>%
    group_by(across(all_of("name"))) %>%
    filter(row_number() == n()) %>%
    arrange(!!as.name(colnames(inv_datasets)[1])) %>%
    ungroup()

  write_csv(x = out, file = paste0(path, "inv_datasets.csv"), na = "")
  return(temp)

}


# Build file names ----
#
# profile  [list]  the profile as derived via load_profile().

load_filenames <- function(profile){

  root <- profile$dir
  assertDirectoryExists(x = root, access = "rw")

  wF <- read_csv(file = workingFiles, col_types = c("ccnlcciii"))

  gadmVect <- list(gadm = paste0(dirname(dirname(root)), "/misc/gadm36_levels.gpkg"))

  out <- map(.x = seq_along(wF$name), .f = function(ix){
    temp <- wF[ix,]
    paste0(root, temp$folder, "/", temp$name, "_", profile$name, "_", profile$version, ".", temp$type)
  })
  names(out) <- wF$name

  out <- c(gadmVect, out)

  return(out)

}


# View of the attribute table of an sf ----
#
# ... by dropping the geometry column that slows View() down dratically.
# x  [sf]  a simple feature of which to view the attribute table.

View_sf <- function(x){

  assertClass(x = x, classes = "sf")

  out <- st_drop_geometry(x)
  View(out)

}


# Transform tibble to matrix ----
#
# x         [tibble]     the tibble to transform.
# rownames  [character]  the column that contains row names

as_matrix <- function(x, rownames = NULL){

  assertDataFrame(x = x)
  assertCharacter(x = rownames, any.missing = FALSE, len = 1, null.ok = TRUE)
  if(!is.null(rownames)){
    assertSubset(x = rownames, choices = names(x))
    temp <- select(x, -all_of(rownames))
    out <- as.matrix(temp)
    rownames(out) <- x[[rownames]]
  } else {
    out <- as.matrix(x)
  }

  return(out)
}


# Convert degree to radians ----
#
# degree  [numeric]  a degree value to convert to radians.

.rad <- function(degree){

  assertNumeric(x = degree)

  (degree * pi)/180
}


# Determine amount of allocated memory ----
#
# unit  [character]  see ?object.size()

getMemoryUse <- function(unit = "Mb"){

  doc <- data.frame('object' = ls(envir = .GlobalEnv)) %>%
    mutate(size_unit = object %>% sapply(. %>% get() %>% object.size %>% format(., unit = unit)),
           size = as.numeric(sapply(strsplit(size_unit, split = ' '), FUN = function(x) x[1]))) %>%
    arrange(desc(size)) %>%
    unite(col = out, size_unit, object, sep = ": ") %>%
    pull(out)

  message(paste0(doc, collapse = "\n"))
}


# Get the column types of a tibble ----
#
# input     [tibble]   tibble from which to get column types.
# collapse  [logical]  whether or not to paste all column

getColTypes <- function(input = NULL, collapse = TRUE){

  assertDataFrame(x = input)
  assertLogical(x = collapse, len = 1)

  types <- tibble(col_type = c("character", "integer", "numeric", "double", "logical", "Date", "units", "sfc_POLYGON"),
                  code = c("c", "i", "n", "d", "l", "D", "u", "g"))

  out <- map(1:dim(input)[2], function(ix){
      class(input[[ix]])
    }) %>%
    unlist() %>%
    tibble(col_type = .) %>%
    left_join(y = types, by = "col_type") %>%
    pull("code")

  if(collapse){
    out <- out %>%
      str_c(collapse = "")
  }

  return(out)

}


# Update an inventory table ----
#
# index      [tibble]     the table to use as update.
# name       [character]  name of the table that shall be updated.
# matchCols  [character]  the columns in the old file by which to match.
# backup     [logical]    whether or not to store the old table in the log
#                         directory (in case it is available).

updateTable <- function(index = NULL, path = NULL, matchCols = NULL, backup = FALSE){

  # set internal paths
  intPaths <- getOption("pdb_path")

  # check validity of arguments
  assertTibble(x = index)
  assertDirectoryExists(x = path)

  # first archive the original index
  theTime <- paste0(strsplit(x = format(Sys.time(), format = "%Y%m%d_%H%M%S"), split = "[ ]")[[1]], collapse = "_")

  # if a file already exists, join the new data to that
  tabPath <- path

  if (testFileExists(x = tabPath)) {

    if (backup) {
      write_csv(x = oldIndex,
                file = paste0(intPaths, "/log/", name, "_", theTime, ".csv"),
                na = "", append = FALSE)
    }

    if (is.null(matchCols)) {
      matchCols <- names(oldIndex)
      matchCols <- matchCols[!matchCols %in% "notes"]
    } else {
      assertSubset(x = matchCols, choices = names(oldIndex))
    }


  }

  # store it


}


# Validate the format of objects ----
#
# Any object handled in luckinet should be validated, before writing it to a
# database
# object  [data.frame]  the object for which to validate the format.
# type    [character]   the type of luckinet object to validate

validateFormat <- function(object, type = "occurrence"){

  cols <- tibble(names = c("datasetID", "fid", "country", "x", "y", "geometry", "epsg",
                           "type", "date", "irrigated", "area", "presence", "externalID",
                           "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                           "sample_type", "collector", "purpose"),
                 types = c("c", "i", "c", "n", "n", "g", "n", "c",
                           "D", "l", "n", "l", "c", "c",
                           "c", "c", "c", "c", "c", "c"),
                 types2 = c("c", "i", "c", "n", "n", "l", "n", "c",
                            "D", "l", "n", "l", "c", "c",
                            "c", "c", "c", "c", "c", "c")) %>%
    arrange(names)

  assertClass(x = object, classes = "data.frame")
  assertNames(x = names(object), must.include = cols$names)

  theTypes <-  getColTypes(object %>% select(cols$names), collapse = FALSE)

  if(all(is.na(object$geometry))){
    equalTypes <- theTypes == cols$types2
  } else {
    equalTypes <- theTypes == cols$types
  }

  if(!all(equalTypes)){
    stop(paste0("some columns have the wrong format (", paste0(paste0(cols$names[which(!equalTypes)], "|", cols$types[which(!equalTypes)]), collapse = ", "), ")"))
  }

  invisible(object)

}


# Save occurrence dataset ----
#
# Wrapper around saveRDS that also moves the dataset to the "02_processed"
# folder in the same directory.
# object   [tibble]     the object to save and move to "processed"
# path     [character]  the root path in which the database to write into is
#                       located.
# name     [character]  the name under which the dataset shall be saved
# outType  [character]  the file format with which the dataset shall be saved.
#                       Currently either "gpkg" or "rds" are recommended.

saveDataset <- function(object, path, name, outType = "rds"){

  assertNames(x = outType, subset.of = c(tolower(st_drivers()$name), "rds"))

  thisPath <- paste0(path, name)

  if(all(is.na(object$geometry))){
    writePoint <- TRUE
  } else {
    writePoint <- FALSE
  }

  if(outType != "rds"){
    if(writePoint){
      object <- object %>%
        filter(!is.na(x) & !is.na(y)) %>%
        st_as_sf(coords = c("x", "y")) %>%
        st_set_crs(4326)
    }

    st_write(obj = object,
             dsn = paste0(thisPath, ".", outType),
             delete_layer = TRUE,
             quiet = TRUE)
  } else {
    saveRDS(object = object, file = paste0(thisPath, ".rds"))
  }

}
