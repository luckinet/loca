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


# Write profile for the current model run ----
#
# name        [character]  the name of this model.
# version     [character]  the version identifier.
# authors     [list]       list of authors.
# parameters  [list]       list of the profile parameters.
# modules     [list]       list of module paths.

.write_profile <- function(name, version = NULL, authors = NULL, license = NULL, parameters, modules){

  assertCharacter(x = name, len = 1)
  assertNames(x = names(parameters), must.include = c("years", "extent", "pixel_size", "tile_size"))
  assertNumeric(x = parameters$pixel_size, len = 2)
  assertNumeric(x = parameters$extent, len = 4)
  assertNumeric(x = parameters$tile_size, len = 2)
  assertCharacter(x = version, null.ok = TRUE)
  assertNames(x = names(modules), must.include = c("ontology", "grid_data", "census_data", "occurrence_data", "suitability_maps", "initial_landuse_map", "allocation_maps"))

  if(is.null(version)){
    stop("please provice a version number.")
  }

  # build all the directories in 'run'
  if(!testDirectoryExists(x = paste0(work_dir, name, "_", version))){
    dir.create(paste0(work_dir, name, "_", version))
  }

  profileName <- paste0(name, "_", version, ".RData")

  authorRoles <- c("cre", "aut", "ctb")
  if(!testNames(x = names(authors), must.include = authorRoles)){
    which(!authorRoles %in% names(authors))

    authors[which(!authorRoles %in% names(authors))] <- NA_character_
    names(authors) <- authorRoles
  }

  model_info <- list(name = name, version = version, authors = authors,
                     license = license,
                     parametes = parameters, module_paths = modules)

  if(testFileExists(x =  paste0(work_dir, profileName))){
    message("the current profile (name + version) already exists")
    continue <- readline(prompt = "to overwrite it, type 'yes' or otherwise press any other key: ")

    if(continue == "yes"){
      save(model_info, file = paste0(work_dir, profileName))
    } else {
      return(NULL)
    }
  }

  save(model_info, file = paste0(work_dir, profileName))
}


# Start an occurrence database ----
#
# root  [character]  path to the root directory that contains or shall contain a
#                    point database.

odb_init <- function(root = NULL, ontology = NULL){

  assertCharacter(x = root, len = 1)

  # funny windows workaround, because a directory may not have a trailing slash
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
  if(!testDirectory(x = file.path(root, "input"), access = "rw")){
    dir.create(file.path(root, "input"))
  }
  if(!testDirectory(x = file.path(root, "output"), access = "rw")){
    dir.create(file.path(root, "output"))
  }
  if(!testDirectory(x = file.path(root, "meta"), access = "rw")){
    dir.create(file.path(root, "meta"))
  }

  for(i in seq_along(unique(ontology))){
    temp <- str_split(tail(str_split(string = unique(ontology)[i], pattern = "/")[[1]], 1), "[.]")[[1]][1]
    if(!testDirectory(x = file.path(root, "meta", temp), access = "rw")){
      message("creating ", paste0(".../meta/", temp))
      dir.create(file.path(root, "meta", temp))
    }
    if(!testFileExists(x = paste0(file.path(root, "meta", temp), ".rds"))){
      message("copying ontology to ", paste0(".../meta/", temp, ".rds"))
      file.copy(from = unique(ontology)[[i]], to = paste0(file.path(root, "meta", temp), ".rds"))
    }
    ontology[which(ontology == unique(ontology)[[i]])] <- paste0(file.path(root, "meta", temp), ".rds")
  }

  if(!testFileExists(x = file.path(root, "references.bib"))){
    bibentry(
      bibtype = "Misc",
      key = "ehrmann2024",
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
      year = 2024,
      url = "https://www.idiv.de/de/luckinet.html") %>%
      toBibtex() %>%
      write_lines(file = paste0(root, "/references.bib"), append = TRUE)
  }

  options(adb_path = root)
  options(ontology_path = ontology)

}

# Start a grid database
#
# root  [character]  path to the root directory that contains or shall contain a
#                    grid database.

gdb_init <- function(root = NULL){

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
  if(!testDirectory(x = file.path(root, "input"), access = "rw")){
    dir.create(file.path(root, "input"))
  }
  if(!testDirectory(x = file.path(root, "output"), access = "rw")){
    dir.create(file.path(root, "output"))
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


# Save (and update) a list of references
#
# object     [bib]        the new item to add to the reference list
# file       [path]       the location of the list to update

saveBIB <- function(object, file){

  assertClass(x = object, classes = "bibentry")
  assertFileExists(x = file, access = "rw")

  newBib <- c(read.bib(file = file), object)
  newBib <- newBib[!duplicated(newBib)]

  write.bib(entry = newBib, file = file, verbose = FALSE)

}

# orphanized functions ----

# Reorganise excel files from the australian bureau of statistics
#
# This functions iterates through the spreadsheets and aligns them
# file       [character]   the object to save and move to "processed"
# skip       [integerish]  how many rows to skip before the table
# trim_by    [character]   a character string that distinguishes the table from
#                          some potential footer
# offset     [integerish]  by how many rows is the trim_by value offset
# territory  [character]   whether the territories are in columns or in rows

reorg_abs <- function(file, skip, trim_by, offset, territory = "columns"){

  message("probably not needed anymore!?")

  # assertFileExists(x = file, access = "rw")
  # assertIntegerish(x = skip, len = 1, lower = 1)
  # assertCharacter(x = trim_by, len = 1)
  # assertChoice(x = territory, choices = c("columns", "rows"))
  #
  # sheetnames <- excel_sheets(path = file)
  #
  # sheets <- map(.x = 2:length(sheetnames), .f = function(iy){
  #
  #   temp <- read_excel(path = file, sheet = iy, skip = skip, col_names = FALSE)
  #   dims <- dim(temp)
  #
  #   cutRow <- str_which(string = temp[,1, drop = TRUE], pattern = trim_by) - offset
  #
  #   temp <- temp %>%
  #     slice(1:cutRow)
  #
  #   if(territory == "columns"){
  #     temp <- temp %>%
  #       rownames_to_column('rn') %>%
  #       pivot_longer(cols = !rn)
  #
  #     rep1 <- temp[1:dims[2], ] %>%
  #       fill(value, .direction = "down")
  #     rep2 <- temp[(dims[2]+1):dim(temp)[1], ]
  #     temp <- bind_rows(rep1, rep2) %>%
  #       pivot_wider(names_from = name, values_from = value) %>%
  #       select(-rn)
  #
  #     fullNames <- temp %>%
  #       slice(1:2) %>%
  #       summarise(across(everything(), \(x) paste0(x, collapse = " -_-_ ")))
  #     fullNames[1] <- "variable"
  #
  #     temp <- temp %>%
  #       slice(-(1:2))
  #     colnames(temp) <- fullNames
  #   } else {
  #     fullNames <- temp[1, ]
  #
  #     temp <- temp %>%
  #       slice(-1)
  #     colnames(temp) <- fullNames
  #
  #   }
  #
  #   return(temp)
  # })
  #
  # names(sheets) <- sheetnames[2:length(sheetnames)]
  #
  # return(sheets)
}

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


# Get gridded layers
#
# This function derives file-names from \code{path} and first constructs a *.vrt
# masked to the dimensions specified in \code{extent} from those names
# (gdalbuildvrt). Next, it stores the spatial subset as GTiff with the original
# name in 'outDir' (gdal_translate).
# paths       [character]  exact path to the files to extract. See function
#                          'get_meta_gridDB' to get those paths.
# outDir      [character]  path to the directory where the output shall be
#                          stored.
# extent      [data.frame] coordinates from which an extent (maximum and minimum)
#                          can be derived; must contain columns "x" "y".

pull_layers <- function(paths, outDir, extent){

  message("probably not needed anymore!?")

  # assertDirectoryExists(x = outDir, access = "rw")
  # assertFileExists(x = paths)
  # assertDataFrame(x = extent, all.missing = FALSE, min.cols = 2)
  # assertNames(x = names(extent), must.include = c("x", "y"))
  #
  # oldDigits <- getOption("digits")
  # options(digits = 12)
  #
  # out <- NULL
  # for(i in seq_along(paths)){
  #   inputTif <- paths[i]
  #   filePath <- str_split(inputTif, "[.]")[[1]]
  #   filePath <- str_split(filePath[1], "/")[[1]]
  #   outTif <- paste0(outDir, tail(filePath, 1), ".tif")
  #
  #   xCells <- colFromX(object = rast(inputTif), x = extent$x)
  #   yCells <- rowFromY(object = rast(inputTif), y = extent$y)
  #
  #   srcWin <- paste0(c(min(xCells), min(yCells),
  #                      max(xCells) - min(xCells), max(yCells) - min(yCells)),
  #                    collapse = " ")
  #
  #   system(paste0('gdal_translate -of GTiff -ot Float32 -co COMPRESS=DEFLATE -co ZLEVEL=9 -co PREDICTOR=2 ',
  #                 ' -srcwin ', srcWin, ' ', inputTif, ' ', outTif))
  #   out <- c(out, outTif)
  # }
  # options(digits = oldDigits)
  #
  # return(out)
}

