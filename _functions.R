# ----
# title        : load functions
# version      : 0.0.9
# description  : This is the main script that loads custom functions that are used throughout this modelling pipeline, which are not part of other packages.
# license      : https://creativecommons.org/licenses/by-sa/4.0/
# authors      : Steffen Ehrmann
# date         : 2024-04-03
# documentation: file.edit(paste0(dir_docs, "/documentation/00_loca.md"))
# ----

# Select a system specific path ----
#
# This function calls Sys.info() and selects from the provided arguments that
# path that corresponds to the recent nodename.
#
# ...                   combination of a nodename and the path that should be
#                       valid here.
# default  [character]  a fallback path that should be

.select_path <- function(..., default = NULL){

  sys <- Sys.info()

  paths <- exprs(...)
  out <- eval_tidy(paths[sys[["nodename"]]][[1]])

  if(length(out) == 0 & !is.null(default)){
    assertDirectoryExists(x = default, access = "rw")
    out <- default
  }

  return(out)
}


# Create pipeline directories
#
# root        [character]  the path to the root directory of this project.
# modules     [list]       a named list of paths, where the names indicate the
#                          module name and the paths indicate in which directory
#                          the module is stored.

.create_directories <- function(root, modules){

  assertDirectoryExists(x = root, access = "rw")
  assertList(x = modules, types = "character")

  if(!testDirectoryExists(x = paste0(root, "_profile"))){
    dir.create(paste0(root, "_profile"))
  }

  for(i in seq_along(modules)){

    thisModule <- paste0(root, modules[[i]], "/")

    if(!testDirectoryExists(x = thisModule)){
      dir.create(thisModule)
      dir.create(paste0(thisModule, "_data"))
      dir.create(paste0(thisModule, "_misc"))
      dir.create(paste0(thisModule, "_pub"))
      writeLines(text = '# ----\n# title       : _MODULENAME - _SUB-MODULE\n# description : _INSERT\n# license     : _LICENSE\n# authors     : _AUTHORNAMES\n# date        : YYYY-MM-DD\n# version     : 0.0.0\n# status      : ...\n# comment     : file.edit(paste0(dir_docs, "/documentation/_MODULENAME.md"))\n# ----\n',
                 con = paste0(thisModule, "00_main.R"), sep = "")

    }
  }

}

# Write profile for the current model run ----
#
# path        [character]  the full path to the file.
# name        [character]  the name of this model.
# version     [character]  the version identifier.
# authors     [list]       list of authors.
# parameters  [list]       list of the profile parameters.
# domains     [list]       list of switches that indicate which domains to
#                          model.
# modules     [list]       list of module paths

.write_profile <- function(path, name, version, authors, license, parameters,
                           domains, modules){

  assertCharacter(x = name, len = 1)
  assertList(x = license, len = 2, any.missing = FALSE)
  assertNames(x = names(license), must.include = c("model", "data"))
  assertNames(x = names(parameters), must.include = c("years", "extent", "pixel_size", "tile_size"))
  assertNumeric(x = parameters$pixel_size, len = 2)
  assertNumeric(x = parameters$extent, len = 4, lower = -180, upper = 180, any.missing = FALSE)
  assertNumeric(x = parameters$tile_size, len = 2)
  assertIntegerish(x = parameters$years, min.len = 2, all.missing = FALSE)
  assertList(x = domains, types = "logical")

  assertCharacter(x = version, len = 1, pattern = "([0-9]+)\\.([0-9]+)\\.([0-9]+)(?:-([0-9A-Za-z-]+(?:\\.[0-9A-Za-z-]+)*))?(?:\\+[0-9A-Za-z-]+)?")
  # assertNames(x = names(modules), must.include = c("ontology", "grid_data", "census_data", "occurrence_data", "suitability_maps", "initial_landuse_map", "allocation_maps"))

  if(is.null(version)){
    stop("please provice a version number.")
  }

  authorRoles <- c("cre", "aut", "ctb")
  if(!testNames(x = names(authors), must.include = authorRoles)){
    which(!authorRoles %in% names(authors))

    authors[which(!authorRoles %in% names(authors))] <- NA_character_
    names(authors) <- authorRoles
  }

  model_info <- list(name = name,
                     version = version,
                     authors = authors,
                     license = license,
                     parameters = parameters,
                     domains = domains,
                     module_paths = modules)

  saveRDS(model_info, file = path)
  options(loca_profile = path)

}


# Construct the path to a particular module ----
#
# module      [character]  the name to identify the directory path for.
# data        [character]  in case the path should be to a specific directory
#                          containing data, provide the name of the folder
#                          within the modules' _data directory here.

.get_path <- function(module, data = NULL){

  assertCharacter(x = module, len = 1, any.missing = FALSE)

  profilePath <- getOption("loca_profile")
  root <- rstudioapi::getActiveProject()

  module_paths <- readRDS(file = profilePath)$module_paths

  if(!is.null(data)){

    temp <- paste0(module_paths[[module]], "/_data/", data)

  } else {
    temp <- module_paths[[module]]
  }

  out <- paste0(root, "/", temp,"/")
  assertDirectoryExists(x = out, access = "rw")

  return(out)
}

# View of the attribute table of an sf ----
#
# ... by dropping the geometry column that slows View() down dratically.
# x  [sf]  a simple feature of which to view the attribute table.

st_view <- function(x){

  assertClass(x = x, classes = "sf")

  out <- st_drop_geometry(x)

  geomCols <- map(seq_along(colnames(out)), function(ix){
    temp <- class(out[[ix]])
    if(any(temp == "sfc")) colnames(x)[ix]
  }) |>
    unlist()

  out <- out |>
    select(-any_of(geomCols))

  View(out, title = deparse(substitute(x)))
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

# Fold words to capital case
#
# x     [character] the words to fold.

.toCap <- function(x) {

  assertCharacter(x = x, any.missing = FALSE)

  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1, 1)), substring(s, 2),
        sep = "", collapse = " ")
}

# Determine amount of allocated memory ----
#
# unit  [character]  see ?object.size()

.getMemoryUse <- function(unit = "Mb"){

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

.getColTypes <- function(input = NULL, collapse = TRUE){

  assertDataFrame(x = input)
  assertLogical(x = collapse, len = 1)

  types <- tibble(col_type = c("character", "integer", "numeric", "double", "logical", "Date", "units", "sfc_POLYGON", "arrow_binary"),
                  code = c("c", "i", "n", "d", "l", "D", "u", "g", "a"))

  out <- map(1:dim(input)[2], function(ix){
      class(input[[ix]])[1]
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

# parse header ----
#
# path       [path]       the location to screen and parse
# pattern    [character]  a string by which to match scripts to filter by

.parse_header <- function(path, pattern = NULL){

  assertDirectoryExists(x = path, access = "rw")
  assertCharacter(x = pattern, len = 1, any.missing = FALSE, null.ok = TRUE)

  scripts <- list.files(path = path, full.names = TRUE, pattern = ".R")
  if(!is.null(pattern)){
    scripts <- scripts[str_detect(string = scripts, pattern = pattern)]
  }

  out <- tibble()
  for(i in seq_along(scripts)){

    theScript <- read_lines(file = scripts[i])
    theName <- str_split(tail(str_split(string = scripts[i], pattern = "/")[[1]], 1), "[.]")[[1]][1]
    headerBounds <- str_which(string = theScript, pattern = "# ----")
    notHeaderBounds <- str_which(string = theScript, pattern = "# -----")
    headerBounds <- headerBounds[!headerBounds %in% notHeaderBounds]

    if(length(headerBounds) == 0) next

    header <- theScript[(headerBounds[1]+1):(headerBounds[2]-1)]
    header <- str_replace_all(string = header, pattern = "# ", replacement = "")
    fields <- str_split(string = header, pattern = ": ")

    vals <- map(fields, 2, .default = NA) |>
      unlist()
    names <- map(fields, 1, .default = NA) |>
      unlist() |>
      str_replace_all(pattern = " ", replacement = "") |>
      str_replace_all(pattern = ":", replacement = "")
    nested <- str_detect(string = names, pattern = "-")
    nestedPre <- map(.x = which(nested), .f = function(ix){
      temp <- which(!nested) < ix
      names[tail(which(!nested)[temp], 1)]
    }) |>
      unlist()

    names[nested] <- paste0(nestedPre, names[nested])
    dups <- duplicated(names)
    dupNames <- names[dups]
    names[dups] <- paste0(dupNames, seq_along(dupNames)+1)

    names(vals) <- names
    theName <- tibble(key = theName)

    out <- theName |>
      bind_cols(as_tibble_row(vals)) |>
      bind_rows(out)
  }

  return(out)
}


# orphanized functions ----

# generate input data for a LUCKINet module
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
  # # test input
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
  # # manage profile
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
  # # build stats and maps
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
  # # handle special cases
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
  # # landcover limits
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
  # # tiles and geometries
  # theTiles <- tibble(x = c(0, 10, 10, 0),
  #                    y = c(0, 0, 10, 10)) %>%
  #   gs_polygon() %>%
  #   setFeatures(tibble(fid = 1, target = TRUE)) %>%
  #   setCRS(crs = crs(mp_cover)) %>%
  #   gc_sf()
  #
  #
  # # write output
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
# obj         [character]  name of the object to get a difference from several runs
# x           [character]  the base run, from which to subtract {y}. If missing, the
#                          object is taken from the most recent run.
# y           [character]  the run that shall be subtracted from {x}.

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

