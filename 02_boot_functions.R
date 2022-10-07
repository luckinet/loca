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

  types <- tibble(col_type = c("character", "integer", "numeric", "double", "logical", "Date", "units", "sfc_POLYGON"),
                  code = c("c", "i", "n", "d", "l", "D", "u", "g"))

  out <- input %>%
    summarise_all(class) %>%
    filter(row_number() == 1) %>%
    gather(col_name, col_type) %>%
    left_join(y = types, by = "col_type") %>%
    pull("code")

  if(collapse){
    out <- out %>%
      str_c(collapse = "")
  }


  return(out)

}

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

