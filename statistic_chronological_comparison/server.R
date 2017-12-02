
library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)

birth_rate <- read.csv("../data/birth_rate.csv")
GDP <- read.csv("../data/GDP_in_countries.csv")
population <- read.csv("../data/population.csv")
population_growth <- read.csv("../data/population_growth.csv")

shinyServer(function(input, output) {
  
  
  
  output$comparison <- renderPlotly({
    
    statistic1 <- read.csv(paste("../data/",input$statistic1,".csv",sep = ""))
    statistic1 <- statistic1 %>% filter(Country.Name == input$country)
    statistic1 <- statistic1 %>% select(starts_with("X"))
    
    statistic2 <- read.csv(paste("../data/",input$statistic2,".csv",sep = ""))
    statistic2 <- statistic2 %>% filter(Country.Name == input$country)
    statistic2 <- statistic2 %>% select(starts_with("X"))
    
    years <- c(1960:2017)
    values1 <- as.numeric(statistic1)
    values2 <- as.numeric(statistic2)  
    
    ### make regression linear
    values1.lm <- lm(values1 ~ years, data=statistic1)
    values2.lm <- lm(values2 ~ years, data=statistic2)
    
    a1 <- as.numeric(values1.lm$coefficients[1])
    b1 <- as.numeric(values1.lm$coefficients[2])
    
    a2 <- as.numeric(values2.lm$coefficients[1])
    b2 <- as.numeric(values2.lm$coefficients[2])
    
    values1_regression <- a1 + b1 * years
    values2_regression <- a2 + b2 * years
    
    #### exclude the qualified plot and keep just outliers
    
    judge1 <- max(values1_regression) - min(values1_regression)
    judge2 <- max(values2_regression) - min(values2_regression)
    
    for(i in 1:57){
      if(is.na(values1[i])==F){
        if(abs(as.numeric(values1[i])-as.numeric(values1_regression[i]))<= judge1){
          values1[i]=NA
        }
      }
    }
    
    for(i in 1:57){
      if(is.na(values2[i])==F){
        if(abs(as.numeric(values2[i])-as.numeric(values2_regression[i]))<= judge2){
          values2[i]=NA
        }
      }
    }
    
    values <- values1_regression
    
    plot_ly(x = ~years) %>%
      add_trace(y=~values,name = input$statistic1 ,mode = 'lines',type = 'scatter')%>%
      add_trace(y=~values1,name = input$statistic1,mode = 'markers',type = 'scatter')%>%
      add_trace(y=~values2_regression,name = input$statistic2,mode = 'lines',type = "scatter") %>%
      add_trace(y=~values2,name = input$statistic2,mode = 'markers',type = "scatter") 
    
    })
  
  
})
