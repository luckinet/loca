# load data ----
#
# get the territorial units already mobilised
stage3 <- list.files(paste0(dataDir, "censusDB/adb_tables/stage3"))

inv_tables <- read_csv(file = paste0(dataDir, "censusDB/inv_tables.csv"), col_types = "iiiccccDccccc")
inv_dataseries <- read_csv(file = paste0(dataDir, "censusDB/inv_dataseries.csv"), col_types = "icccccc")


# data processing ----
#
# determine which units are available in stage3
units <- stage3 %>%
  map(str_split, pattern = "[.]") %>%
  map_chr(c(1, 1))

countries <- countries %>%
  mutate(stage3 = if_else(unit %in% units, unit, NA_character_))


tempOut <- map_df(
  .x = countries$unit,
  .f = function(ix){

    message(ix)

    allInfo <- countries %>%
      filter(unit == ix)

    load <- allInfo %>%
      pull(stage3)

    if(!is.na(load)){
      temp <- read_rds(file = paste0(dataDir, "censusDB/adb_tables/stage3/", ix, ".rds"))

      if(is.null(temp)){
        warning("'", ix, "' doesn't contain any values.")
        return(NULL)
      }
    } else {
      return(NULL)
    }

    stage2 <- allInfo %>%
      pull(iso_a3) %>%
      tolower()

    stage2 <- list.files(paste0(dataDir, "censusDB/adb_tables/stage2"), pattern = stage2)
    stage2 <- list(stage2)

    if(!"planted" %in% colnames(temp)){
      temp <- temp %>%
        mutate(planted = NA_integer_)
    }
    if(!"harvested" %in% colnames(temp)){
      temp <- temp %>%
        mutate(harvested = NA_integer_)
    }

    temp <- temp %>%
      mutate(planted = as.integer(planted),
             harvested = as.integer(harvested),
             ahLevel = ifelse(nchar(ahID) <= 3, 1L,
                              ifelse(nchar(ahID) <= 6, 2L,
                                     ifelse(nchar(ahID) <= 9, 3L, 4L))),
             area = if_else(!is.na(planted), planted, harvested))

    # ... number of dataseries
    tabIDs <- temp %>%
      select(tabID) %>%
      unique() %>%
      pull(tabID)

    datIDs <- unique(inv_tables$datID[inv_tables$tabID %in% tabIDs])

    # ... type of dataseries
    datNames <- inv_dataseries$name[inv_dataseries$datID %in% datIDs]
    datNames <- list(datNames)

    faoDatID <- inv_dataseries$datID[inv_dataseries$name == "faostat"]
    faoTabIDs <- inv_tables$tabID[inv_tables$datID == faoDatID]

    # number of commodities
    cummProp <- temp %>%
      filter(ahLevel == 1) %>%
      select(year, luckinetID, ahID, area) %>%
      group_by(year, luckinetID, ahID) %>%
      summarise(entries = n(),
                area = sum(area, na.rm = TRUE)) %>%
      ungroup() %>%
      group_by(year, ahID) %>%
      mutate(prop_area = area / sum(area, na.rm = TRUE) * 100) %>%
      arrange(desc(prop_area)) %>%
      mutate(cumm_prop = cumsum(prop_area),
             q95_area = if_else(cumm_prop < 95, TRUE,
                                if_else(prop_area > 95, TRUE, FALSE)),
             q80_area = if_else(cumm_prop < 80, TRUE,
                                if_else(prop_area > 80, TRUE, FALSE))) %>%
      ungroup()
    cummProp <- cummProp %>%
      group_by(year, ahID) %>%
      summarise(q95 = sum(q95_area, na.rm = TRUE) + 1,
                q80 = sum(q80_area, na.rm = TRUE) + 1) %>%
      ungroup() %>%
      group_by(ahID) %>%
      summarise(q95_mean = mean(q95),
                q80_mean = mean(q80)) %>%
      ungroup()

    # ... percentage of covered commodities
    fao_c <- temp %>%
      filter(tabID %in% faoTabIDs) %>%
      distinct(luckinetID)
    other_c <- temp %>%
      filter(!tabID %in% faoTabIDs) %>%
      distinct(luckinetID)
    compl_c <- as.numeric(fao_c$luckinetID %in% other_c$luckinetID)
    compl_c <- round(sum(compl_c)/length(compl_c)*100, 2)

    # ... percentage of covered years
    compl_yr <- as.numeric(1992:2022 %in% unique(temp$year))
    compl_yr <- round(sum(compl_yr)/length(compl_yr)*100, 2)

    # put everything together
    tibble(unit = ix,
           level = max(temp$ahLevel),
           n_ds = length(datIDs),
           ds = datNames,
           n_c = length(unique(temp$luckinetID)),
           n_c95 = cummProp$q95_mean,
           n_c80 = cummProp$q80_mean,
           n_yr = length(unique(temp$year)),
           compl_yr = compl_yr,
           compl_c = compl_c,
           files = stage2)
  })



# write output ----
#
write_rds(x = tempOut, file = paste0(dataDir, "tables/censusStatus.rds"))

message("\n---- done ----")
