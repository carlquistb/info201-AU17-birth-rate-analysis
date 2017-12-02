
library(shiny)
library(plotly)
birth_rate <- read.csv("../data/birth_rate.csv")
GDP <- read.csv("../data/GDP_in_countries.csv")
population <- read.csv("../data/population.csv")
population_growth <- read.csv("../data/population_growth.csv")
statistic <- list("birth rate" = "birth_rate",
                  "GDP" = "GDP_in_countries",
                  "population" = "population",
                  "population growth" = "population_growth")

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  sidebarLayout(
    sidebarPanel(
      selectInput("country", 
                  label = "Country", 
                  choices = birth_rate$Country.Name,
                  width = '100%'
      ),
      radioButtons("statistic1", 
                  label = "Statistic 1", 
                  choices = statistic,
                  width = '100%'
      ),
      radioButtons("statistic2", 
                  label = "Statistic 2", 
                  choices = statistic,
                  width = '100%'
      )
    ),
    mainPanel(
      plotlyOutput("comparison")
    )
  )
))
