library(shiny)
library(shinythemes)
library(dplyr)

#source contributor scripts
#source("contributorScripts/___.R)


shinyServer(function(input, output, session) {
  
  ####sample panel code.####
  output$sampleSidebarOutput <- renderText({
    "sample sidebar output."
  })
  
  output$sampleMainPanelOutput <- renderText({
    "sample main panel output. we can play around and test things on this output panel."
  })
  
  
  #### map tab code.####
  output$worldMapExplorer <- renderLeaflet({
    df = data.frame(Lat = 1:10, Long = rnorm(10))
    leaflet(df) %>% addCircles()
  })
  
  
  #### stat comparison tab code.####
  
  
  
  #### grouped comparison tab code.####
  
  
})