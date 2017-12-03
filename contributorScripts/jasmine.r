library(dplyr)

# read datas
birth.rate <- read.csv("../data/birth_rate.csv") %>% select(-Indicator.Name,-Indicator.Code,-X2016,-X2017)
pop <- read.csv("../data/population.csv")%>% select(-Indicator.Name,-Indicator.Code,-X2016,-X2017)
pop.rate <- read.csv("../data/population_growth.csv")%>% select(-Indicator.Name,-Indicator.Code,-X2016,-X2017)
GDP.rate <- read.csv("../data/GDP_in_countries.csv") %>% select(-Indicator.Name,-Indicator.Code,-X2016,-X2017)
immigration <- read.csv("../data/immigration.csv")%>% select(-Indicator.Name,-Indicator.Code,-X2016,-X2017)
region <- read.csv("../data/income_group.csv") %>% select(Country.Code, Region)



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

# semi.pop
pop.all <- full_join(region, pop, by= "Country.Code")
pop.all = pop.all[-264,]
semi.pop <- pop.all[!(pop.all$Region==""),] %>%
  select(-Country.Name, -Country.Code)

#semi.pop.rate
pop.rate.all <- full_join(region, pop.rate, by= "Country.Code")
pop.rete.all = pop.rate.all[-264,]
semi.pop.rate <- pop.rate.all[!(pop.rate.all$Region==""),] %>%
  select(-Country.Name, -Country.Code)

#semi.GDP
GDP.all <- full_join(region, GDP.rate, by= "Country.Code")
GDP.all = GDP.all[-264,]
semi.GDP.rate <- GDP.all[!(GDP.all$Region==""),] %>%
  select(-Country.Name, -Country.Code)



# group into region and calculate mean(average)
group.region <- function(dataframe){
  dataframe %>% group_by(dataframe$Region) %>%
  summarise_each(funs(mean(., na.rm= T)))
}


final.birth <- group.region(semi.birth)
names(final.birth)[1] <- "name" 

final.pop <- group.region(semi.pop)
names(final.pop)[1] <- "name"

final.pop.rate <- group.region(semi.pop.rate) 
final.pop.rate <- final.pop.rate[-8,] %>% as.data.frame()
names(final.pop.rate)[1] <- "name"

final.GDP <- group.region(semi.GDP.rate)
names(final.GDP)[1] <- "name"


# world average in specific year
birth.mean <- colMeans(semi.birth[,-1],na.rm=TRUE) %>% as.data.frame() %>% t()
pop.rate.maen <- colMeans(semi.pop.rate[,-1],na.rm = TRUE) %>% as.data.frame() %>% t()
GDP.mean <- colMeans(semi.GDP.rate[,-1],na.rm = TRUE) %>% as.data.frame() %>% t()


# draw the region bar plot
createbar <- function(datatype, year){
  print(datatype)
  if(datatype== "final.birth"){
    return(final.birth)
  }
  if(datatype== "final.pop"){
    return(final.pop)
  }
  if(datatype=="final.pop.rate"){
    return(final.pop.rate)
  }
  if(datatype== "final.GDP"){
    return(final.GDP)
  }
  
  filtered <- datatype %>% select(name,year) %>% as.data.frame()
  
  bar.region <- plot_ly(data = filtered, x = ~filtered$name,
                        y= ~filtered$year, type = 'bar',
                        hoverinfo = 'text',
                        # sets hover text
                        text = ~paste("Region:", filtered$name, "<br>","Value:",filtered$year)) %>%
    layout(xaxis= list(title = "Regions"),
           yaxis= list(title = "Value"))
  
  return(bar.region)
}




