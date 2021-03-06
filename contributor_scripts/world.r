library(dplyr)
library(ggplot2)

# read datas
birth.rate <- read.csv("data/birth_rate.csv", stringsAsFactors = FALSE) %>% 
  select(-Indicator.Name,-Indicator.Code,-X2016,-X2017)
pop <- read.csv("data/population.csv", stringsAsFactors = FALSE)%>% 
  select(-Indicator.Name,-Indicator.Code,-X2016,-X2017)
pop.rate <- read.csv("data/population_growth.csv", stringsAsFactors = FALSE)%>% 
  select(-Indicator.Name,-Indicator.Code,-X2016,-X2017)
gdp.rate <- read.csv("data/gdp_in_countries.csv", stringsAsFactors = FALSE) %>% 
  select(-Indicator.Name,-Indicator.Code,-X2016,-X2017)
region <- read.csv("data/income_group.csv", stringsAsFactors = FALSE) %>% 
  select(Country.Code, Region)



# get rid of "X" from the column names
names(birth.rate) <- gsub("X","",names(birth.rate),fixed = TRUE)
names(pop) <- gsub("X","",names(pop),fixed = TRUE)
names(pop.rate) <- gsub("X","",names(pop.rate),fixed = TRUE)
names(gdp.rate) <- gsub("X","",names(gdp.rate),fixed = TRUE)


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
GDP.all <- full_join(region, gdp.rate, by= "Country.Code")
GDP.all = GDP.all[-264,]
semi.gdp.rate <- GDP.all[!(GDP.all$Region==""),] %>%
  select(-Country.Name, -Country.Code)
rm(GDP.all)
rm(gdp.rate)
rm(region)

birth.mean <- colMeans(semi.birth[,-1],na.rm=TRUE) %>% as.data.frame()
pop.rate.mean <- colMeans(semi.pop.rate[,-1],na.rm = TRUE) %>% as.data.frame()
GDP.mean <- colMeans(semi.gdp.rate[,-1],na.rm = TRUE) %>% as.data.frame()

rm(semi.birth)
rm(semi.gdp.rate)
rm(semi.pop)
rm(semi.pop.rate)

year <- rownames(birth.mean) %>% as.data.frame() 
names(year) <- "year"

birth.mean <- data.frame(year,birth.mean)
names(birth.mean)[2] <- "birth"

pop.rate.mean <- data.frame(year, pop.rate.mean)
names(pop.rate.mean)[2] <- "population"

GDP.mean <- data.frame(year,GDP.mean)
names(GDP.mean)[2] <- "GDP"

png(filename = "world.data.jpg")
a <- ggplot()+
  geom_line(data= birth.mean,aes(x=year, y=birth, group=1),colour="blue", size=1)+
  geom_line(data= pop.rate.mean,aes(x=year, y=population, group=1),colour="red", size=1)+
  geom_line(data= GDP.mean, aes(x= year, y= GDP, group=1),colour ="yellow", size=1)+
  theme(axis.ticks.y=element_blank(), 
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  ylab("value")
dev.off()


 