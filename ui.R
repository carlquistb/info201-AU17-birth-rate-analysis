
#Shiny App UI

#install.packages("shinythemes")
#install.packages("leaflet")
#install.packages("maps")

#libraries
  library(shiny)
  library(shinythemes)
  library(leaflet)
  library(plotly)
  library(maps)

#source files for each contributor
  source("contributorScripts/brendan.R")
  source("contributorScripts/sammi.R")

shinyUI(
  
  navbarPage("Birth Rate Analysis", theme = shinytheme("cerulean"),
  
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
    tabPanel("World Map Explorer",
      sidebarLayout(
        sidebarPanel(
          sliderInput("map_slider_year", min = 1960, max = 2017, value = 2000, label = "year")
        ),
        mainPanel(
          leafletOutput("worldMapExplorer")
        )
      )
    ),
    
    ####stat comparison tab####
    tabPanel("Statistic Chronological Comparison",
      sidebarLayout(
        sidebarPanel(
          selectInput("country", 
                     label = "Country", 
                     choices = readFile("birth_rate")$Country.Name,
                     width = '100%'
                     ),
          radioButtons("statistic1", 
                     label = "Statistic 1", 
                     choices = readFile("statistic"),
                     width = '100%'
                     ),
          radioButtons("statistic2", 
                     label = "Statistic 2", 
                     choices = readFile("statistic"),
                     width = '100%'
                     )
         ),
         mainPanel(
           plotlyOutput("comparison")
         )
        )
    ),
    
    ####grouped comparison tab####
    tabPanel("Grouped Comparison",
      sidebarLayout(
      sidebarPanel(
        
        
        radioButtons("data.type", label= h3("Pick the Data"),
                     choices = list("Birth Rate"= 'final.birth', "Population"= 'final.pop', 
                                    "Population Growth Rate"= 'final.pop.rate',"GDP Growth Rate"= 'final.GDP'),
                     selected = 'final.birth'
        ),
        
        
        sliderInput("get.year", min = 1960, max = 2015, value = 1960, label = h3("Select Year")),
        
        helpText(h3("Region:"),
                 h5("East Asia & Pacific"),
                 h5("Europe & Central Asia"),
                 h5("Latin America & Caribbean"),
                 h5("Middle East & North Africa"),
                 h5("North America"),
                 h5("South Asia"),
                 h5("Sub-Saharan Africa")) 
      ),   
      mainPanel(
        plotlyOutput("barplot")
      )
      
      
    )
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
