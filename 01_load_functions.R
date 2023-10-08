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

write_profile <- function(name, parameters, version = NULL){

  assertDirectoryExists(x = input_dir, access = "rw")
  assertCharacter(x = name, len = 1)
  assertNames(x = names(parameters), must.include = c("years", "pixel_size", "censusDB_dir", "censusDB_extent", "occurrenceDB_dir", "occurrenceDB_extent", "landcover", "suitability_predictors"))
  assertSubset(x = parameters$censusDB_extent, choices = parameters$occurrenceDB_extent)
  assertCharacter(x = parameters$landcover, len = 1)
  assertCharacter(x = parameters$suitability_predictors, any.missing = FALSE)
  assertNumeric(x = parameters$pixel_size, len = 2)
  assertNumeric(x = parameters$tile_size, len = 2)
  assertCharacter(x = version, null.ok = TRUE)

  if(is.null(version)){
    stop("please profice a version number.")
  }

  # build all the directories in 'run'
  if(!testDirectoryExists(x = paste0(work_dir, name, "_", version))){
    dir.create(paste0(work_dir, name, "_", version))
    # dir.create(paste0(work_dir, name, "_", version, "/drivers"))
    # dir.create(paste0(work_dir, name, "_", version, "/initial_landuse"))
    # dir.create(paste0(work_dir, name, "_", version, "/intermediate"))
    # dir.create(paste0(work_dir, name, "_", version, "/input"))
    # dir.create(paste0(work_dir, name, "_", version, "/tiles"))
    # dir.create(paste0(work_dir, name, "_", version, "/tables"))
    # dir.create(paste0(work_dir, name, "_", version, "/suitability"))
    # dir.create(paste0(work_dir, name, "_", version, "/suitability/models"))
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
  rootPath <- paste0(input_dir, name, "_", version, "/")
  toWrite <- paste0(c(name, version, rootPath, years, extent, pixel_size, tile_size,
                      censusDB_dir, censusDB_extent, occurrenceDB_dir, occurrenceDB_extent,
                      parameters$landcover, toPredictors), collapse = "\n")

  if(testFileExists(x =  paste0(input_dir, profileFull))){
    message("the current profile (name + version) already exists")
    continue <- readline(prompt = "to overwrite it, type 'yes' or otherwise press any other key: ")

    if(continue == "yes"){
      write_lines(x = toWrite, file = paste0(input_dir, profileFull), append = FALSE)
    } else {
      return(NULL)
    }
  }

  write_lines(x = toWrite, file = paste0(input_dir, profileFull))
}

# Write profile for the current model run ----
#
# root     [character]  the main path, where this model resides.
# name     [character]  the name of this model.
# version  [character]  the version identifier.

load_profile <- function(name, version = NULL){

  assertDirectoryExists(x = input_dir, access = "rw")
  assertCharacter(x = name, len = 1)
  assertCharacter(x = version, null.ok = TRUE)

  if(is.null(version)){
    stop("please profice a version number.")
  }

  profileFull <- paste0(name, "_", version, "_profile.txt")

  if(!testFileExists(x = paste0(input_dir, profileFull), access = "rw")){
    stop("the profile '", profileFull, "' does not exist. Please create it with write_profile()")
  } else {
    temp <- read_lines(file = paste0(input_dir, profileFull), na = "")

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

start_occurrenceDB <- function(root = NULL, ontology = NULL){

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
    message("I have created a new project directory.")
  }
  if(!testDirectory(x = file.path(root, "stage1"), access = "rw")){
    dir.create(file.path(root, "stage1"))
  }
  if(!testDirectory(x = file.path(root, "stage3"), access = "rw")){
    dir.create(file.path(root, "stage3"))
  }
  if(!testDirectory(x = file.path(root, "meta"), access = "rw")){
    dir.create(file.path(root, "meta"))
  }
  for(i in seq_along(ontology)){
    temp <- str_split(tail(str_split(string = ontology[i], pattern = "/")[[1]], 1), "[.]")[[1]][1]
    if(!testDirectory(x = file.path(root, "meta", temp), access = "rw")){
      dir.create(file.path(root, "meta", temp))
    }
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
    message("I have created a new project directory.")
  }
  if(!testDirectory(x = root, access = "rw")){
    dir.create(file.path(root))
    message("I have created a new project directory.")
  }
  if(!testDirectory(x = file.path(root, "stage1"), access = "rw")){
    dir.create(file.path(root, "stage1"))
  }
  if(!testDirectory(x = file.path(root, "stage3"), access = "rw")){
    dir.create(file.path(root, "stage3"))
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

# generate input data for a LUCKINet module ----
#
# module       [character]  the module of the LUCKINet workflow for which to
#                           generate input data.
# dir          [character]  the directory where to store the model run.
# landcover    [integer]    number of landcover classes.
# landuse      [integer]    number of landuse classes.
# territories  [integer]    number of territories.
# dVal         [numeric]    manual values of demand areas. Overrides {ddL}
#                           and {ddT}.
# ddL          [numeric]    the demand distribution across landuse classes. Must
#                           contain as many values as there are landuse classes
#                           with values between 0 and 1, which add up to 1. If
#                           unspecified, this will be 1/landuse.
# ddT          [numeric]    the demand distribution across territories. Must
#                           contain as many values as there are territories with
#                           values between 0 and 1, which add up to 1. If
#                           unspecified, this will be 1/territories.
# adT          [character]  the spatial/area distribution of territories.
#                           Currently supported values are "diagonal" and
#                           "horizontal".
# app          [numeric]    area per pixel; multiplied with all area related
#                           measures.
# withUrban    [logical]    include an urban class?
# withRestr    [logical]    include restricted areas?
# seed         [integer]    seed for generating randomness (for instance with
#                           suitability maps).

generate_input <- function(module, dir, landcover, landuse, territories,
                           dVal = NULL, ddL = NULL, ddT = NULL, adT, app = 100,
                           withUrban, withRestr,
                           seed = 1137){

  message("revise functionality")

  # # library(luckiTools); library(terra); library(checkmate); library(NLMR); library(tibble); library(purrr); library(dplyr)
  # # module = "initial landuse"; dir = dataDir; landcover = 2; landuse = 2; territories = 1; ddL = NULL; ddT = NULL; dVal = NULL; adT = "horizontal"; withUrban = FALSE; withRestr = TRUE; seed = 1137
  #
  # # include:
  # #   - over/underestimate areas of classes
  # #   -
  #
  # # test input ----
  # assertChoice(x = module, choices = c("suitability", "initial landuse", "allocation"))
  # assertDirectoryExists(x = dir, access = "rw")
  # assertIntegerish(x = landcover, lower = 1, any.missing = FALSE, len = 1)
  # assertIntegerish(x = landuse, lower = 1, any.missing = FALSE, len = 1)
  # assertIntegerish(x = territories, lower = 1, any.missing = FALSE, len = 1)
  # assertNumeric(x = dVal, len = landuse*territories, null.ok = TRUE)
  # assertChoice(x = adT, choices = c("diagonal", "horizontal"))
  # assertLogical(x = withUrban, any.missing = FALSE, len = 1)
  # assertLogical(x = withRestr, any.missing = FALSE, len = 1)
  # assertIntegerish(x = seed, any.missing = FALSE, len = 1)
  #
  # theDir <- paste0(dir, "run/testing_0.1.0/")
  # if(testDirectoryExists(x = theDir)){
  #   unlink(theDir, recursive = TRUE)
  # }
  #
  #
  # # manage profile ----
  # covNames <- c(
  #   "iGHS_POP/GHSP"
  # )
  # params <- list(years = c(2000:2010),
  #                pixel_size = c(1, 1),
  #                arealDB_dir = "censusDB_testing",
  #                arealDB_extent = "Estonia",
  #                pointDB_dir = "pointDB_testing",
  #                pointDB_extent = "Estonia",
  #                landcover = "CCI_landCover/landCover",
  #                predictors = covNames)
  # write_profile(root = dir, name = "testing", version = "0.1.0", parameters = params)
  # profile <- load_profile(root = dir, name = "testing", version = "0.1.0")
  #
  # set.seed(seed = seed)
  #
  # # build stats and maps ----
  # mp_cover <- rast(nrows = 10, ncols = 10, xmin = 0, xmax = 10, ymin = 0, ymax = 10)
  #
  # if(landcover == 1){
  #
  #   mp_cover[] <- 10
  #
  # } else if(landcover == 2){
  #
  #   mp_cover[] <- c(rep(c(10, 10, 10, 10, 10, 20, 20, 20, 20, 20), 10))
  #
  # } else {
  #   stop("more than 2 landcover classes are currently not supported")
  # }
  #
  # mp_ahID <- mp_mask <- mp_rest <- mp_area <- mp_cover
  #
  # if(landuse == 1){
  #
  #   theClasses <- c(1120)
  #   theNames <- c("Cropland")
  #
  #   # layer1 <- rast(nlm_planargradient(ncol = 10, nrow = 10, resolution = 1, direction = 225))
  #   # find replacement for nlm_planargradient
  #   layer1Name <- "1120"
  #
  # } else if(landuse == 2){
  #
  #   theClasses <- c(1120, 1122)
  #   theNames <- c("Cropland", "Forest land")
  #
  #   # layer1 <- rast(nlm_planargradient(ncol = 10, nrow = 10, resolution = 1, direction = 225))
  #   # find replacement for nlm_planargradient
  #   layer2 <- 1 - layer1
  #
  #   layer1Name <- "1120"
  #   layer2Name <- "1122"
  #
  # } else if(landuse == 3){
  #
  #   theClasses <- c(1120, 1122, 1124)
  #   theNames <- c("Cropland", "Forest land", "Grazing land")
  #
  #   # layer1 <- rast(nlm_planargradient(ncol = 10, nrow = 10, resolution = 1, direction = 180)) * 2/3
  #   # find replacement for nlm_planargradient
  #   layer1[1:10] <- 0
  #   # layer2 <- rast(nlm_random(ncol = 10, nrow = 10)/3)
  #   # find replacement for nlm_random
  #   layer3 <- 1 - (layer1 + layer2)
  #
  #   layer1Name <- "1120"
  #   layer2Name <- "1122"
  #   layer3Name <- "1124"
  #
  # } else {
  #   stop("more than 3 landuse classes are currently not supported")
  # }
  #
  # if(is.null(ddL)){
  #   theArea <- rep(1, landuse) / landuse
  # } else {
  #   assertNumeric(x = ddL, lower = 0, upper = 1, len = landuse)
  #   assertTRUE(sum(ddL) == 1)
  #   theArea <- ddL
  # }
  #
  # tempClasses <- tibble(luckinetID = theClasses,
  #                       term = theNames,
  #                       area = theArea)
  #
  # if(territories == 1){
  #
  #   theTerritories <- 70
  #   mp_ahID[] <- 70
  #   # ahID_areas <- tibble(ahID = 70, total_area = 900)
  #
  # } else if(territories == 2){
  #
  #   theTerritories <- c(70, 80)
  #
  #   if(adT == "diagonal"){
  #     mp_ahID[] <- c(rep(70, 18), rep(80, 2),    # two equally sized units
  #                    rep(70, 8), rep(80, 2),
  #                    rep(70, 6), rep(80, 4),
  #                    rep(70, 6), rep(80, 4),
  #                    rep(70, 4), rep(80, 6),
  #                    rep(70, 3), rep(80, 7),
  #                    rep(70, 3), rep(80, 7),
  #                    rep(70, 1), rep(80, 9),
  #                    rep(70, 1), rep(80, 9))
  #   } else if(adT == "horizontal"){
  #     mp_ahID[] <- c(rep(70, 50), rep(80, 50))
  #   }
  #
  #   # ahID_areas <- tibble(ahID = c(70, 80), total_area = c(450, 450))
  #
  # } else {
  #   stop("more than 2 territories are currently not supported")
  # }
  # names(mp_ahID) <- "ahID"
  # names(mp_cover) <- "cover"
  #
  # # region mask
  # mp_mask[] <- 1
  # mp_mask[c(7, 8, 9, 10, 20, 90, 91, 98, 99, 100)] <- NA
  # names(mp_mask) <- "mask"
  #
  # # area map
  # mp_area[] <- app
  # names(mp_area) <- "area"
  #
  # # map of ahID and landcover
  # mp_temp <- mp_ahID * as.numeric(paste0(1, paste0(rep(0, nchar(max(values(mp_cover)))), collapse = "")))
  # mp_temp <- mp_temp + mp_cover
  #
  # if(is.null(ddT)){
  #   theArea <- rep(theArea, territories) / territories
  # } else {
  #   assertNumeric(x = ddT, lower = 0, upper = 1, len = territories)
  #   assertTRUE(sum(ddT) == 1)
  #   theArea <- as.vector(matrix(theArea, length(theArea), 1) %*% ddT)
  # }
  #
  # tempTerritories <- tibble(geoID = 1, year = 2000,
  #                           nation = "Estonia",
  #                           ahID = theTerritories,
  #                           ahLevel = 1)
  #
  # comb <- expand.grid(theTerritories, theClasses) %>%
  #   as_tibble() %>%
  #   set_names("ahID", "luckinetID")
  #
  # census <- tempTerritories %>%
  #   left_join(comb, by = "ahID") %>%
  #   left_join(tempClasses, by = "luckinetID") %>%
  #   mutate(area = theArea * sum(values(mp_area)))
  #
  #
  # # handle special cases ----
  # if(withRestr){
  #   # mp_rest[] <- abs(rnorm(length(values(mp_area)), 0, 0.03))
  #   mp_rest[] <- rep(c(0.02, 0.01, 0.02, 0.01, 0.02, 0.01, 0.02, 0.01, 0.02, 0.01, 0.01, 0.02, 0.01, 0.02, 0.01, 0.02, 0.01, 0.02, 0.01, 0.02), 5)
  #   if(territories == 2 & landuse == 2){
  #     census$area <- c(2199299, 2196409, 2182832, 2186333)
  #   } else if(territories == 1 & landuse == 2){
  #     census$area <- c(4432500, 4432500)
  #   }
  # } else {
  #   mp_rest[] <- 0
  # }
  # names(mp_rest) <- "restricted"
  #
  # if(withUrban){
  #
  #   mp_cover[c(72, 73, 82, 83)] <- 40
  #
  #   if(territories == 2 & landuse == 2){
  #     newClasses <- tibble(geoID = 1, year = 2000, nation = "Estonia",
  #                          ahID = theTerritories, ahLevel = 1,
  #                          luckinetID = 1126, term = "Other land")
  #     census <- bind_rows(census, newClasses) %>%
  #       arrange(ahID, luckinetID)
  #     census$area <- c(2474644.4, 1742230.6, 180000, 1568803.7, 2628195.5, 180000)
  #
  #     layer3 <- layer1
  #     layer3[] <- 0
  #     layer3[c(72, 73, 82, 83)] <- c(0.9, 0.95, 0.99, 0.95)
  #     layer1[c(72, 73, 82, 83)] <- 0
  #     layer2[c(72, 73, 82, 83)] <- c(0.1, 0.05, 0.01, 0.05)
  #
  #     mp_rest[c(72, 73, 82, 83)] <- 0
  #
  #     theClasses <- c(theClasses, 1126)
  #     layer3Name <- "1126"
  #
  #   } else if(territories == 1 & landuse == 2){
  #
  #   }
  #
  # }
  #
  # if(!is.null(dVal)){
  #   census$area <- dVal
  # }
  #
  #
  # # landcover limits ----
  # lc_limits <- tibble(landcover = rep(c("Cropland_lc", "Forest_lc", "Meadow_lc", "Other_lc"), each = 4),
  #                     lcID = rep(c(10, 20, 30, 40), each = 4),
  #                     luckinetID = rep(c(1120, 1122, 1124, 1126), 4),
  #                     short = rep(c("crop", "forest", "grazing", "other"), 4),
  #                     min = c(0.5, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0),
  #                     max = c(1, 0.5, 0.5, 0.5, 0.5, 1, 0.5, 0.5, 0.5, 0.5, 1, 0.5, 0, 0, 0, 1))
  #
  # lc_limits <- lc_limits %>%
  #   filter(luckinetID %in% theClasses)
  #
  # # tiles and geometries ----
  # theTiles <- tibble(x = c(0, 10, 10, 0),
  #                    y = c(0, 0, 10, 10)) %>%
  #   gs_polygon() %>%
  #   setFeatures(tibble(fid = 1, target = TRUE)) %>%
  #   setCRS(crs = crs(mp_cover)) %>%
  #   gc_sf()
  #
  #
  # # write output ----
  # saveRDS(object = census, file = paste0(profile$dir, "tables/census.rds"))
  # saveRDS(object = lc_limits, paste0(profile$dir, "tables/landcover_limits.rds"))
  #
  # st_write(obj = theTiles, dsn = paste0(profile$dir, "visualise/tiles.gpkg"), quiet = TRUE)
  #
  # if(exists(x = "layer1")){
  #
  #   writeRaster(x = layer1,
  #               filename = paste0(profile$dir, "suitability/suit_", layer1Name, "_2000_testing_0.1.0.tif"),
  #               overwrite = TRUE,
  #               filetype = "GTiff",
  #               datatype = "FLT4S")
  #
  #   writeRaster(x = layer1,
  #               filename = paste0(profile$dir, "tiles/suit_", layer1Name, "_2000_1_testing_0.1.0.tif"),
  #               overwrite = TRUE,
  #               filetype = "GTiff",
  #               datatype = "FLT4S")
  #
  # }
  #
  # if(exists(x = "layer2")){
  #
  #   writeRaster(x = layer2,
  #               filename = paste0(profile$dir, "suitability/suit_", layer2Name, "_2000_testing_0.1.0.tif"),
  #               overwrite = TRUE,
  #               filetype = "GTiff",
  #               datatype = "FLT4S")
  #
  #   writeRaster(x = layer2,
  #               filename = paste0(profile$dir, "tiles/suit_", layer2Name, "_2000_1_testing_0.1.0.tif"),
  #               overwrite = TRUE,
  #               filetype = "GTiff",
  #               datatype = "FLT4S")
  #
  # }
  #
  # if(exists(x = "layer3")){
  #
  #   writeRaster(x = layer3,
  #               filename = paste0(profile$dir, "tiles/suit_", layer3Name, "_2000_1_testing_0.1.0.tif"),
  #               overwrite = TRUE,
  #               filetype = "GTiff",
  #               datatype = "FLT4S")
  #
  #   writeRaster(x = layer3,
  #               filename = paste0(profile$dir, "suitability/suit_", layer3Name, "_2000_testing_0.1.0.tif"),
  #               overwrite = TRUE,
  #               filetype = "GTiff",
  #               datatype = "FLT4S")
  #
  # }
  #
  # writeRaster(x = mp_cover,
  #             filename = paste0(profile$dir, "landcover/landcover_2000_testing_0.1.0.tif"),
  #             overwrite = TRUE,
  #             filetype = "GTiff",
  #             datatype = "FLT4S")
  #
  # writeRaster(x = mp_ahID,
  #             filename = paste0(profile$dir, "maps/ahID_testing_0.1.0.tif"),
  #             overwrite = TRUE,
  #             filetype = "GTiff",
  #             datatype = "FLT4S")
  #
  # writeRaster(x = mp_mask,
  #             filename = paste0(profile$dir, "maps/regionMask_testing_0.1.0.tif"),
  #             overwrite = TRUE,
  #             filetype = "GTiff",
  #             datatype = "FLT4S")
  #
  # writeRaster(x = mp_area,
  #             filename = paste0(profile$dir, "maps/pixelArea_", profile$name, "_", profile$version, ".tif"),
  #             overwrite = TRUE,
  #             filetype = "GTiff",
  #             datatype = "FLT4S")
  #
  # writeRaster(x = mp_rest,
  #             filename = paste0(profile$dir, "maps/areaRestricted_testing_0.1.0.tif"),
  #             overwrite = TRUE,
  #             filetype = "GTiff",
  #             datatype = "FLT4S")
  #
  # writeRaster(x = mp_temp,
  #             filename = paste0(profile$dir, "maps/ahIDLC_testing_0.1.0.tif"),
  #             overwrite = TRUE,
  #             filetype = "GTiff",
  #             datatype = "FLT4S")


}

# Make a difference from gridded objects of two model runs
#
# obj  [character]  name of the object to get a difference from several runs
# x    [character]  the base run, from which to subtract {y}. If missing, the
#                   object is taken from the most recent run.
# y    [character]  the run that shall be subtracted from {x}.

get_difference <- function(obj, x = NULL, y = NULL){

  message("revise functionality")

  # assertCharacter(x = obj, len = 1, any.missing = FALSE)
  # assertClass(x = record, classes = "environment")
  # assertChoice(x = x, choices = names(record), null.ok = TRUE)
  # assertChoice(x = y, choices = names(record), null.ok = TRUE)
  #
  # if(is.null(x)){
  #   origin <- get(obj)
  #   x <- "current"
  # } else{
  #   origin <- record[[x]][[obj]]
  # }
  #
  # if(is.null(y)){
  #   ind <- ifelse(length(names(record)) == 1, 1, length(names(record)) - 1)
  #   y <- names(record)[ind]
  #   second <- record[[y]][[obj]]
  # } else{
  #   second <- record[[y]][[obj]]
  # }
  #
  # if(dim(origin)[3] == 1){
  #   out <- origin - second
  # } else {
  #   out <- origin
  #   for(i in 1:dim(origin)[3]){
  #     out[[i]] <- origin[[i]] - second[[i]]
  #   }
  # }
  #
  # names(out) <- paste0(names(origin), " diff(", x, "|", y, ")")
  # return(out)

}
