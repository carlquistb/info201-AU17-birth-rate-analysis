library(dplyr)

getRegionalData <- function() {
  
}
# read datas
birth.rate <- read.csv("data/birth_rate.csv", stringsAsFactors = FALSE) %>% 
  select(-Indicator.Name,-Indicator.Code,-X2016,-X2017)
pop <- read.csv("data/population.csv", stringsAsFactors = FALSE)%>% 
  select(-Indicator.Name,-Indicator.Code,-X2016,-X2017)
pop.rate <- read.csv("data/population_growth.csv", stringsAsFactors = FALSE)%>% 
  select(-Indicator.Name,-Indicator.Code,-X2016,-X2017)
GDP.rate <- read.csv("data/gdp_in_countries.csv", stringsAsFactors = FALSE) %>% 
  select(-Indicator.Name,-Indicator.Code,-X2016,-X2017)
region <- read.csv("data/income_group.csv", stringsAsFactors = FALSE) %>% 
  select(Country.Code, Region)



# get rid of "X" from the column names
names(birth.rate) <- gsub("X","",names(birth.rate),fixed = TRUE)
names(pop) <- gsub("X","",names(pop),fixed = TRUE)
names(pop.rate) <- gsub("X","",names(pop.rate),fixed = TRUE)
names(GDP.rate) <- gsub("X","",names(GDP.rate),fixed = TRUE)


# semi.birth.rate
birth.all <- full_join(region, birth.rate, by= "Country.Code")
birth.all = birth.all[-264,]
semi.birth <- birth.all[!(birth.all$Region==""),] %>%
  select(-Country.Name, -Country.Code)
rm(birth.rate)
rm(birth.all)

# semi.pop
pop.all <- full_join(region, pop, by= "Country.Code")
pop.all = pop.all[-264,]
semi.pop <- pop.all[!(pop.all$Region==""),] %>%
  select(-Country.Name, -Country.Code)
rm(pop.all)
rm(pop)

#semi.pop.rate
pop.rate.all <- full_join(region, pop.rate, by= "Country.Code")
pop.rate.all = pop.rate.all[-264,]
semi.pop.rate <- pop.rate.all[!(pop.rate.all$Region==""),] %>%
  select(-Country.Name, -Country.Code)
rm(pop.rate.all)
rm(pop.rate)


#semi.GDP
GDP.all <- full_join(region, GDP.rate, by= "Country.Code")
GDP.all = GDP.all[-264,]
semi.GDP.rate <- GDP.all[!(GDP.all$Region==""),] %>%
  select(-Country.Name, -Country.Code)
rm(GDP.all)
rm(GDP.rate)
rm(region)

# group into region and calculate mean(average)
group.region <- function(dataframe){
  dataframe %>% group_by(dataframe$Region) %>%
  summarise_all(funs(mean(., na.rm = T)))
}


final.birth <- group.region(semi.birth)
names(final.birth)[1] <- "name" 
rm(semi.birth)

final.pop <- group.region(semi.pop)
names(final.pop)[1] <- "name"
rm(semi.pop)

final.pop.rate <- group.region(semi.pop.rate) 
final.pop.rate <- final.pop.rate[-8,] %>% as.data.frame()
names(final.pop.rate)[1] <- "name"
rm(semi.pop.rate)

final.GDP <- group.region(semi.GDP.rate)
names(final.GDP)[1] <- "name"
rm(semi.GDP.rate)



# draw the region bar plot
createbar <- function(datatype, year){
  print(datatype)
  if(datatype== "final.birth"){
    filtered <- final.birth
  }
  if(datatype== "final.pop"){
    filtered <- final.pop
  }
  if(datatype=="final.pop.rate"){
    filtered <-  final.pop.rate
  }
  if(datatype== "final.GDP"){
    filtered <- final.GDP
  }
  
  time <- toString(year)
  filtered <- filtered %>% select(name,time)
  names(filtered)[2] <- "year"
  
  
  bar.region <- plot_ly(data = filtered, x = ~filtered$name,
                        y= ~filtered$year, type = 'bar',
                        hoverinfo = 'text',
                        # sets hover text
                        text = ~paste("Region:", filtered$name, "<br>","Value:",filtered$year))%>%
    
    layout(xaxis= list(title = "Regions"),
           yaxis= list(title = "Value"))
  return(bar.region)
}

