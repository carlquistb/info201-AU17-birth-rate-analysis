library(shiny)
library(shinythemes)
library(dplyr)

#source contributor scripts
#source("contributorScripts/___.R)


shinyServer(function(input, output, session) {
  output$sampleSidebarOutput <- renderText({
    "sample sidebar output."
  })
  
  output$sampleMainPanelOutput <- renderText({
    "sample main panel output."
  })
})