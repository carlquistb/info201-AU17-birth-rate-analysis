getFullDataframe <- function() {
  #load data
  country_list <- read.csv("data/country_list.csv", stringsAsFactors = FALSE)
  birth_rate <- read.csv("data/birth_rate.csv", stringsAsFactors = FALSE)
  pop <- read.csv("data/population.csv", stringsAsFactors = FALSE)
  pop_growth <- read.csv("data/population_growth.csv", stringsAsFactors = FALSE)
  gdp <- read.csv("data/gdp_in_countries.csv", stringsAsFactors = FALSE)
  immigration <- read.csv("data/immigration.csv", stringsAsFactors = FALSE)
  
  #clean data
  country_list <- country_list %>% select(long = Longitude..average., 
                                          lat = Latitude..average., 
                                          Country.Code = Alpha.3.code) 
  birth_rate <- birth_rate %>% 
    gather(key = "year", 
           value = "birth_rate", 
           -Country.Name, 
           -Country.Code,
           -Indicator.Name,
           -Indicator.Code) %>%
    select(-Indicator.Code, -Indicator.Name)
  pop_growth <- pop_growth %>%
    gather(key = "year",
           value = "pop_growth",
           -Country.Name,
           -Country.Code,
           -Indicator.Code,
           -Indicator.Name) %>%
    select(-Indicator.Code, -Indicator.Name)
  pop <- pop %>%
    gather(key = "year",
           value = "pop",
           -Country.Name,
           -Country.Code,
           -Indicator.Code,
           -Indicator.Name) %>%
    select(-Indicator.Code, -Indicator.Name)
  gdp <- gdp %>%
    gather(key = "year",
           value = "gdp",
           -Country.Name,
           -Country.Code,
           -Indicator.Code,
           -Indicator.Name) %>%
    select(-Indicator.Code, -Indicator.Name)
  immigration <- immigration %>%
    gather(key = "year",
           value = "immigration",
           -Country.Name,
           -Country.Code,
           -Indicator.Code,
           -Indicator.Name) %>%
    select(-Indicator.Code, -Indicator.Name)
  #join data
  data <- inner_join(country_list, birth_rate, by = "Country.Code")
  rm(country_list)
  rm(birth_rate)
  data <- inner_join(data, pop, by=c("Country.Code", "year"))
  rm(pop)
  data <- inner_join(data, pop_growth, by=c("Country.Code", "year"))
  rm(pop_growth)
  data <- inner_join(data, gdp, by=c("Country.Code", "year"))
  rm(gdp)
  data <- inner_join(data, immigration, by=c("Country.Code", "year"))
  rm(immigration)
  
  #clean joined data
  data <- data %>%
    select(long, 
           lat, 
           country_code = Country.Code, 
           country_name = Country.Name, 
           year, 
           birth_rate, 
           pop, 
           pop_growth, 
           immigration, 
           gdp)
  #return data.frame
  return(data)
}

worldMap <- function(data, current_year){
  #get current data
  current.data <- data %>% filter(data$year == paste0("X", current_year))
  
  #popup content
  content <- paste(sep = "<br/>",
                   paste0("Country: ", current.data$country_name),
                   paste0("population: ", current.data$pop),
                   paste0("population growth: ", current.data$pop_growth),
                   paste0("immigration: ", current.data$immigration),
                   paste0("gdp: ", current.data$gdp),
                   paste0("birth rate: ", current.data$birth_rate)
                  )
  
  #get underlay data
  my.map <- map("world", fill = TRUE, plot = FALSE)
  
  #print leaflet
  leaflet(current.data) %>% 
    addTiles() %>% 
    #addPolygons(map = my.map, fillColor = topo.colors(10, alpha = NULL), stroke = FALSE) %>%
    addMarkers(~long, ~lat, popup = content)
}

