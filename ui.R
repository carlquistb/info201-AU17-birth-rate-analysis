
#Shiny App UI

#libraries
  library(shiny)
  #install.packages("shinythemes")
  library(shinythemes)

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
    tabPanel("world map explorer"
      
    ),
    
    ####stat comparison tab####
    tabPanel("statistic chronological comparison"
             
    ),
    
    tabPanel("grouped comparison"
             
    ),
    
    ####markdown####
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