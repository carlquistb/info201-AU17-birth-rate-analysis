makeFullDataframe <- function() {
  #load data
  country_list <- read.csv("data/Country_List.csv", stringsAsFactors = FALSE)
  birth_rate <- read.csv("data/birth_rate.csv", stringsAsFactors = FALSE)
  pop <- read.csv("data/population.csv", stringsAsFactors = FALSE)
  pop_growth <- read.csv("data/population_growth.csv", stringsAsFactors = FALSE)
  gdp <- read.csv("data/GDP_in_countries.csv", stringsAsFactors = FALSE)
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
  print(paste0("X", current_year))
  print(toString(data$year))
  current.data <- data %>% filter(data$year == paste0("X", current_year))
  print(head(current.data))
  leaflet(current.data) %>% addTiles() %>% addMarkers(~long, ~lat, ~htmlEscape(gdp))
}

