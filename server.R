library(shiny)
library(shinythemes)
library(dplyr)
library(htmltools)
library(tidyr)
library(plotly)
library(maps)

#source contributor scripts
source("contributorScripts/brendan.R")
source("contributorScripts/sammi.R")
source("contributorScripts/jasmine.R")

shinyServer(function(input, output, session) {
  
  ####run once per user####
  data <- getFullDataframe()
  
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