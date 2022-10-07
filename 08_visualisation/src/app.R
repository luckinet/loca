# author ----
#
# Steffen Ehrmann


# version ----
# 1.0.0 (May 2022)


# script description ----
#


# load packages ----
#
library(shiny)
library(shinythemes)

library(leaflet)
library(tidyverse)
library(lubridate)

# library(ggplot2)
# library(ggthemes)
library(plotly)
library(ggraph)
library(tidygraph)

library(luckiTools)
library(arealDB)
library(geometr)
library(sf)
library(DT)

library(sunburstR)



# set paths ----
#
projDir <- select_path(idivnb283 = "/home/se87kuhe/idiv-mount/groups/MAS/01_projects/LUCKINet/",
                       HOMEBASE = "I:/groups/MAS/01_projects/LUCKINet/",
                       default = "/gpfs1/data/idiv_meyer/01_projects/LUCKINet/")
dataDir <- paste0(projDir, "01_data/")
modlDir <- paste0(projDir, "02_data_processing/")
evalDir <- paste0(projDir, "03_data_evaluation/")


# script arguments ----
#


# load metadata ----
#
vir <- colorNumeric("viridis", domain = NULL)
blues <- colorNumeric("Blues", domain = NULL)

colsType <- c(`arable land` = "#764c30ff", `perm. crops` = "#a26842ff",
              `temp. crops` = "#c69474ff", fallow = "#ddbeacff",
              `temp. grazing` = "#d76cffff", `perm. grazing` = "#9400ccff",
              `water bodies` = "#193995ff", `coastal waters` = "#436de1ff",
              `primary forest` = "#76aa00ff", `forest land` = "#009100ff",
              `naturally regen. \nforest` = "#9ade00ff", `planted forest` = "#bdff26ff",
              `other land` = "#9eabb0ff", `prot. cover` = "#dc0000ff")



# load data ----
#
cntr <- read_rds(paste0(dataDir, "tables/countries.rds"))
onto <- read_rds(paste0(dataDir, "tables/ontology.rds"))
ontoGraph <- read_csv(paste0(dataDir, "ontology/onto_lps.csv"))

censusStatus <- read_rds(paste0(dataDir, "tables/censusStatus.rds"))
# ceneusPatterns <- read_rds(paste0(dataDir, "censusPatterns.rds"))
# occurrStatus <- read_rds(paste0(dataDir, "occurrenceStatus.rds"))
# occurrPatterns <- read_rds(paste0(dataDir, "occurrencePatterns.rds"))
lc_stats <- read_rds(paste0(dataDir, "tables/landcover_esa.rds")) %>%
  filter(year %in% c(1992:2022))
lu_stats <- read_rds(paste0(dataDir, "tables/landuse_fao.rds")) %>%
  filter(year %in% c(1992:2022))
# lc_stats <- tibble(year = ymd(rep(1992:2022, times = length(cntr$unit) * 3), truncated = 2L),
#                    unit = rep(cntr$unit, each = length(1992:2022) * 3),
#                    type = rep(c("cropland", "forest land", "other vegetation"), times = 7874),
#                    proportion = round(rnorm(23622), 2))


# data processing ----
#
## handle the spatial data ----
world_mp <- cntr %>%
    left_join(censusStatus, by = "unit") %>%
    filter(nation != "Antarctica" & !island) %>%
    gc_geom(group = TRUE) %>%
    gc_sf()

## handle the ontology ----
ontoVert <- ontoGraph %>%
  mutate(name = to,
         shortName = map_chr(str_split(name, "[.]"), tail, 1)) %>%
  select(name, shortName)

ontoEdge <- ontoGraph %>%
  filter(!is.na(from))

ontoGraph <- tbl_graph(ontoVert, ontoEdge)

ontoPlot <- onto$mappings
ontoPlot$label_en <- str_replace_all(ontoPlot$label_en, "-", "_")
ontoPlot <- ontoPlot %>%
  select(-external, -wikidata, -CORINE, -ICC, -QCL, -RL, -FRA) %>%
  left_join(ontoPlot %>% select(code = broader, code2 = code, level2 = label_en), by = "code") %>%
  bind_rows(ontoPlot %>% filter(is.na(broader)) %>% select(code, label_en, class)) %>%
  unite(name, label_en, level2, remove = FALSE, na.rm = TRUE, sep = ".") %>%
  left_join(ontoPlot %>% select(code2 = broader, level3 = label_en), by = "code2") %>%
  filter(is.na(broader)) %>%
  mutate(lulc = if_else(class %in% c("landcover group", "landcover", "land-use"), "landcover", "land-use"),
           size = 1) %>%
    unite(path, label_en, level2, level3, na.rm = TRUE, sep = ".")


## build user infertface ----
ui <- navbarPage(
  title = "LUCKINet",
  theme = shinytheme("simplex"),

  ### 1 landcover ----
  tabPanel(title = "Land-Use/Landcover",
           sidebarLayout(sidebarPanel(width = 2,
                                      tags$h4("Modify display:"),
                                      selectInput(inputId = "coverType",
                                                  label = "ESA Landcover type",
                                                  choices = unique(lc_stats$type)),
                                      selectInput(inputId = "unit",
                                                  label = "Nation",
                                                  choices = unique(cntr$unit)),
                                      downloadButton("download_lu", "FAO land-use"),
                                      br(),
                                      br(),
                                      downloadButton("download_lc", "ESA landcover")),

                         mainPanel(width = 10,
                                   fluidRow(title = "2020 landcover proportion",
                                            tags$h4("ESA Landcover 2020"),
                                            leafletOutput("mp_lc_stats"),
                                            tags$h4("FAO Land-Use"),
                                            plotlyOutput("grph_lu_stats"))))),

  ### 2 integration ----
  tabPanel(title = "Integration Status",
           sidebarLayout(sidebarPanel(width = 2,
                                      tags$h4("Modify display:"),
                                      # selectInput(inputId = "coverType",
                                      #             label = "Landcover type",
                                      #             choices = unique(lc_stats$type)),
                                      # selectInput(inputId = "unit",
                                      #             label = "Nation",
                                      #             choices = unique(cntr$unit)),
                                      downloadButton("download_", "Download")),

                         mainPanel(width = 10,
                                   tabsetPanel(tabPanel(title = "Completeness Census",
                                                        column(width = 7,
                                                               tags$h4("bla"),
                                                               leafletOutput("")),
                                                        # column(width = 4,
                                                        #        tags$h4("Raw data"),
                                                        #        dataTableOutput("tbl_"))),
                                               tabPanel(title = "Sources Census",
                                                        tags$h4("Number of dataseries"),
                                                        leafletOutput("mp_dataseries")),
                                               tabPanel(title = "Completeness Occurrences",
                                                        tags$h4(""),
                                                        plotOutput("")),
                                               tabPanel(title = "Sources Occurrences",
                                                        tags$h4(""),
                                                        plotOutput(""))))))



    # # This map shows at which stage the different countries are, according to the
    # # name of their script.
    # visualise(`workflow status` = world_mp,
    #           fillcol = "status",
    #           theme = luckiTheme)
    #
    #
    #
    # # This map shows from which dataseries the data have been derived
    # visualise(`dataseries (faostat + frafao + ...)` = world_mp,
    #           fillcol = "ds",
    #           theme = luckiTheme)
    #
    # # This map shows the count of distinct commodities
    # visualise(`number of commodities` = world_mp,
    #           fillcol = "n_c",
    #           theme = luckiTheme)
    #
    # # This map shows the count of commodities that make up 95% of the area
    # visualise(`number of commodities q(95)_mean` = world_mp,
    #           fillcol = "n_c95",
    #           theme = luckiTheme)
    #
    # # This map shows the count of commodities that make up 80% of the area
    # visualise(`number of commodities q(80)_mean` = world_mp,
    #           fillcol = "n_c80",
    #           theme = luckiTheme)
    #
    # # This map shows the count of distinct years
    # visualise(`number of years` = world_mp,
    #           fillcol = "n_yr",
    #           theme = luckiTheme)
    #
    # # This map shows the smallest territorial level that is covered by the data
    # visualise(`smallest terr. level` = world_mp,
    #           fillcol = "level",
    #           theme = luckiTheme)
    #
    # # This map shows how many of our target years (in percent) have at least one
    # # entry per country
    # visualise(`temporal completeness (% of target-years)` = world_mp,
    #           fillcol = "compl_yr",
    #           theme = luckiTheme)
    #
    # # This map shows which fraction of the fao-commodities (in percent) has at least
    # # one entry in the subnational stats
    # visualise(`commodity completeness (% of FAO)` = world_mp,
    #           fillcol = "compl_c",
    #           theme = luckiTheme)
    #
    # # This map shows the fraction of available target-years averaged over all commodities
    # visualise(`completeness (% years of compl. comm.)` = world_mp,
    #           fillcol = "compl",
    #           theme = luckiTheme)
  ),

  ### 3 census patterns ----
  tabPanel(title = "Commodity Census patterns",
           # select range of years
           # select nation or region
           # select commodity or their groups
           # here show the treemap (relative contribution of each commodity) where commodity categories (probably classes) are used to group them
           # here, show the temporal trend of a commodity per region with the actual data highlighted differently than interpolated data, that should also be included in here
           # here show the geometries of the respective country or region and a choropleth map of the above selected commodity
  ),

  ### 4 occurrence patterns ----
  tabPanel(title = "Land-use occurrence patters",
           # select range of years
           # select nation or region
           # select commodity or their groups
           #
           # tick box for whether the overall picture should be shown, or whether it should be distinguished into years
           # a map of the point records
           # a choropleth map of the point density per nation (or perhaps per pixel?!)

           # these two should contain a table that visualises the frequency of concepts, according to what has been selected.
  ),

  ### 5 ontology ----
  tabPanel(title = "Ontology",
           # also visualise somehow the wikidata ID
           sidebarLayout(sidebarPanel(width = 2,
                                      tags$h4("Modify display:"),
                                      selectInput(inputId = "ontoType",
                                                  label = "Land-Use/Landcover",
                                                  choices = unique(ontoPlot$lulc),
                                                  selected = "landcover", multiple = TRUE),
                                      downloadButton(outputId = "download_onto",
                                                     label = "Download")),
                         mainPanel(width = 10,
                                   fluidRow(title = "Ontology Sun",
                                            tags$h4("Ontology Sun"),
                                            sunburstOutput("onto_sun", height = "600px"),
                                            textOutput("OntSselection"))),
                         fluid = FALSE)),

  ### 6 documentation ----
  tabPanel(title = "Documentation",
           column(width = 6,
                  includeMarkdown(paste0(evalDir, "visualise/luckinet_shiny/README.md"))),
           column(width = 6,
                  tabsetPanel(type = "tabs",
                              # tabPanel(title = "Landcover",
                              #          includeMarkdown(paste0(evalDir, "analyse_input/README.md"))),
                              # tabPanel(title = "Integration",
                              #          includeMarkdown(paste0(evalDir, "analyse_output/README.md"))),
                              # tabPanel(title = "Commodity Patterns",
                              #          includeMarkdown(paste0(modlDir, "02_build_census_database/README.md"))),
                              # tabPanel(title = "Occurrence Patterns",
                              #          includeMarkdown(paste0(modlDir, "02_build_occurrence_database/README.md"))),
                              # tabPanel(title = "Ontology",
                              #          includeMarkdown(paste0(modlDir, "01_build_ontology/README.md")))
                              ))))

## build server ----
server <- function(input, output){

  # reactive elements
  lc_stats_filterType <- reactive({
    temp <- lc_stats %>%
      filter(type == input$coverType) %>%
      # filter(year == "2022-01-01") %>%
      select(-type, -year)
    world_mp %>%
      left_join(temp, by = "unit")
  })

  lu_stats_filterUnit <- reactive({
    lu_stats %>%
      filter(unit == input$unit) %>%
      mutate(year = as.Date(paste0(year, "-01-01")))
  })

  onto_select <- reactive({
    ontoPlot %>%
      filter(lulc %in% input$ontoType) %>%
      select(path, size)
  })

  onto_mouseover <- reactive({
    input$sunburst_mouseover
  })

  # rendered elements
  # LULC tab ----
  ## map (land_surface) ----
  output$mp_lc_stats <- renderLeaflet({

    leaflet(world_mp) %>%
      setView(9.998176, 14.531777, zoom = 2) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(color = "#969696",
                  weight = 2,
                  fillOpacity = 0.8,
                  label = ~as.character(unit))

  })
  observe({
    leafletProxy("mp_lc_stats", data = lc_stats_filterType()) %>%
      addPolygons(color = "#969696",
                  weight = 2,
                  fillOpacity = 0.8,
                  fillColor = ~vir(prop),
                  label = ~as.character(unit)) %>%
      addLegend("bottomright", pal = vir, values = ~prop, title = input$coverType,
                layerId="colorLegend")
  })

  ## table ----
  # output$tbl_lu_stats <- renderDataTable(
  #   datatable({
  #     lu_stats_filterUnit() %>%
  #       pivot_wider(id_cols = c(unit, year), names_from = type, values_from = prop) #%>%
  #       # mutate(year = year(year))
  #   },
  #   options = list(pageLength = 20),
  #   filter = "top"))

  ## timeline ----
  output$grph_lu_stats <- renderPlotly({
    lu_stats_filterUnit() %>%
      plot_ly(x = ~year, y = ~prop, color = ~type_short,
              type = "scatter", mode = "lines")
  })

  ## download ----
  output$download_lu <- downloadHandler(
    filename = function() {
      paste("landuse_fao-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write_csv(lc_stats, file)
    }
  )
  output$download_lc <- downloadHandler(
    filename = function() {
      paste("landcover_esa-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write_csv(lu_stats, file)
    }
  )

  # Ontology tab ----
  ## plot ----
  output$onto_sun <- renderSunburst({
    # onto_select() %>%
    #   sunburst(data = ., legend = FALSE) %>%
    #   add_shiny()

    ggraph(ontoGraph, layout = 'circlepack') +
      geom_node_circle(aes(fill = depth)) +
      # geom_node_text(aes(label = shortName, filter = leaf, fill=depth)) +
      theme_void() +
      theme(legend.position="FALSE") +
      scale_fill_viridis()
    # https://ggraph.data-imaginist.com/articles/Layouts.html
  })

  output$OntSselection <- renderText(onto_mouseover())

  ## download ----
  output$download_onto <- downloadHandler(
    filename = function() {
      paste("ontology-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write_csv(onto$mappings, file)
    }
  )

  # Integration tab ----
  ## maps ----
  output$mp_dataseries <- renderLeaflet({

    leaflet(world_mp) %>%
      setView(9.998176, 14.531777, zoom = 2) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(color = "#969696",
                  weight = 2,
                  fillOpacity = 0.8,
                  fillColor = ~vir(n_ds),
                  label = ~as.character(unit)) %>%
      addLegend("bottomright", pal = vir, values = ~n_ds, title = "N. Datseries",
                layerId = "colorLegend")

  })

  # leaflet(world_mp) %>%
  #     setView(9.998176, 14.531777, zoom = 2) %>%
  #     addProviderTiles("CartoDB.Positron") %>%
  #     addPolygons(color = "#969696",
  #                 weight = 2,
  #                 fillColor = ~blues(n_ds),
  #                 fillOpacity = 0.8,
  #                 label = ~as.character(unit))

}


# an peter
# - datensatz zu ländergrenzen


# run app ----
#
shinyApp(ui = ui, server = server)
