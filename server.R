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
    GDP <- read.csv("data/GDP_in_countries.csv",
                    stringsAsFactors = FALSE)
    country_list <- read.csv("data/Country_List.csv",
                             stringsAsFactors = FALSE) %>% 
      select(long = Longitude..average., 
             lat = Latitude..average., 
             Country.Code = Alpha.3.code)
    GDP <- inner_join(GDP, country_list, by = "Country.Code")
    leaflet(GDP) %>% addTiles() %>% addMarkers()
  })

  #### stat comparison tab code.####
  
  
  
  #### grouped comparison tab code.####
  
  
})