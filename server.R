library(shiny)
library(shinythemes)
library(dplyr)
library(htmltools)
library(tidyr)
library(plotly)
library(maps)

options(shiny.sanitize.errors = FALSE)

#source contributor scripts
source("contributor_scripts/brendan.R")
source("contributor_scripts/sammi.R")
source("contributor_scripts/jasmine.r")

shinyServer(function(input, output, session) {
  
  ####run once per user####
  data <- getfulldataframe()
  
  #### map tab code.####
  output$worldMapExplorer <- renderLeaflet({
    worldMap(data = data, current_year = input$map_slider_year)
  })

  #### stat comparison tab code.####
  output$comparison <- renderPlotly({
    stat_comparison(input)
  })
  
  
  #### grouped comparison tab code.####
  output$barplot <- renderPlotly({
    
    createbar(input$data.type,input$get.year)
  })
  
})