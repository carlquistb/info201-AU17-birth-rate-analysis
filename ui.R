
#Shiny App UI

#install.packages("shinythemes")
#install.packages("leaflet")

#libraries
  library(shiny)
  library(shinythemes)
  library(leaflet)

#source files for each contributor
  #source("contributorScripts/brendan.R")

shinyUI(
  
  navbarPage("birth rate analysis", theme = shinytheme("cerulean"),
  
    ####example tab####
    tabPanel("example",
      sidebarLayout(
        sidebarPanel(
          textOutput("sampleSidebarOutput")
        ),
        mainPanel(
          textOutput("sampleMainPanelOutput")
        )
      )
    ),
    
    ####map tab####
    tabPanel("world map explorer",
      leafletOutput("worldMapExplorer")
    ),
    
    ####stat comparison tab####
    tabPanel("statistic chronological comparison"
             
    ),
    
    ####grouped comparison tab####
    tabPanel("grouped comparison"
             
    ),
    
    ####markdown tabs####
    navbarMenu("About",
      tabPanel("Using this app",
        includeMarkdown("md/instructions.md")
      ),
      tabPanel("Contributions",
        includeMarkdown("md/contrib.md")
      ),
      tabPanel("Sources",
        includeMarkdown("md/sources.md")
      ),
      tabPanel("Conclusions and Discussions",
        includeMarkdown("md/conclusions.md")
      )
    )
  )
)