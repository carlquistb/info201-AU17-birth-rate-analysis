library(shiny)
library(shinythemes)
library(dplyr)
library(htmltools)
library(tidyr)

#source contributor scripts
source("contributorScripts/brendan.R")

shinyServer(function(input, output, session) {
  
  ####run once per user####
  data <- makeFullDataframe()
  
  ####sample panel code.####
  output$sampleSidebarOutput <- renderText({
    "sample sidebar output."
  })
  
  output$sampleMainPanelOutput <- renderText({
    "sample main panel output. we can play around and test things on this output panel."
  })
  
  
  #### map tab code.####
  output$worldMapExplorer <- renderLeaflet({
    current_year <- input$map_slider_year
    print(paste0("X", current_year))
    print(toString(data$year))
    current.data <- data %>% filter(data$year == paste0("X", current_year))
    print(head(current.data))
    leaflet(current.data) %>% addTiles() %>% addMarkers(popup = ~gdp)
  })

  #### stat comparison tab code.####
  
  
  
  #### grouped comparison tab code.####
  
  
})