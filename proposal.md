# Birth Rate Analysis Project Proposal:

#### Brief Introduction:
This project will illustrate birth rates and their tendencies for over 200 countries from 1960 to 2015. Further, the report will go in depth over the relaionship between birth rate and economic growth in certain countries and regions, by comparing the rates of birth, population growth, and GDP growth.

In this interactive report, you can search through area and time to obtain specific birth rates, population growths, and GDP measurements. As an extra, we will consider the **immigration phenomenon**, because it serves to increase a country's  population, which indicates a similar function as the newly born population. In this report, we will illustrate the trend of global immigration direction and the bidirectional relationship between global immigration and economic growth.

#### Our Data:
Our data was collected primarily by the World Bank. Sourced (here)[]on 11/22/17, this data is divided into several csv tables, and is partially normalized. The World Bank had collected it from census reports and other statistical publications from national statistical offices

We have outlined a list of our collected datasets below:

| local path | type | rows | columns |
| ---------- | ---- | ---- | ------- |
| data/birth_rate.csv | csv | 265 | "Country Name", "Country Code", "Indicator Name", "Indicator Code", "1960", "1961", through "2016", "2017" |
| data/GDP_in_countries.csv | csv | 265 | "Country Name", "Country Code", "Indicator Name", "Indicator Code", "1960", "1961", through "2016", "2017" |
| data/immigration.csv | csv | 265 | "Country Name", "Country Code", "Indicator Name", "Indicator Code", "1960", "1961", through "2016", "2017" |
| data/income_group.csv | csv | 264 | "Country Code", "Region", "IncomeGroup", "SpecialNotes", "CountryName" |
| data/population.csv | csv | 265 | "Country Name", "Country Code", "Indicator Name", "Indicator Code", "1960", "1961", through "2016", "2017" |
| data/population_growth.csv | csv | 265 | "Country Name", "Country Code", "Indicator Name", "Indicator Code", "1960", "1961", through "2016", "2017"|

#### Target users of this report:
- Scholars who are doing research on (1) global and country birth rate changes; (2) the relationship between birth rate and economic growth; (3) the relaitonship between birth rate and national living standard in specific regions and countries. (4) global immigration trend and its impact on economic growth.
- Readers who want to know more about the verification and application of **Demographic Dividend Theory** proposed by David E. Bloom and Jeffrey G. Williamson. This report is going to discuss the scope and conditions for application of this theory. What's more, the report may be able to suggest future action on demographic policy in several certain countries with dominant international status.


##### 1. Create **at least 5** GitHub Issues as your first set of steps to take in the project.  You should assign these to individual group members to complete
*Please refer to the Part 6 in proposal*
* Issue 1: Handbook of the project website (includes introduction, target users, contributors and so on)
* Issue 2: P6 1 & 2
* Issue 3: P6 3 graph and short text report
* Issue 4: P6 4 & extra 1 (we can do it in a check box) + short report
* Issue 5: P6 5 text report (not very long)
* Issue 6: P6 extra 2
* Issue 7: *extra* P6 extra 3

##### 2. What will be the format of your final product (Shiny app, HTML page or slideshow compiled with KnitR, etc.)?
Shiny app

##### 3. How will you be reading in your data (i.e., are you using an API, or is it a static .csv/.json file)?
static.csv (e.g. read.csv())

##### 4. What types of data-wrangling (reshaping, reformatting, etc.) will you need to do to your data?

We will use ```filter```, ```join```, ```mutate``` and other functions in the ```dplyr```package to reshape the many semi-normalized dataframes into 1. For example, combining the dataframe of *income group* and *birth rate* can help determine the link between newly birth populaiton and living standard.

##### 5. What (major/new) libraries will be using in this project (no need to list common libraries that are used in many projects such as dplyr)
Besides Shiny integration and ggplot plotting, there will not be need for any packages beyond normal data manipulation packages commonly used in R.
##### 6. What questions, if any, will you be answering with statistical analysis/machine learning?

All the quesitons below are answered by statistical analysis.
- Global / region / specitic country birth rate tendency from 1960-2015
- Deviations during the period and the reasons for the bias. (eg. huge global events) And we can conclude several factors that have strong influence on birth rate.
- Comparison of birth rate in 4 different level of income countries (aka national living standard)
- The relaionship between GDP growth and birth rate in scale of global / region / country.
- Ellaboration of the **Demographic Dividend Theory**'s appliance. And how it applied to the Demographic Policies nowadays according to the data analysis results.

*Extra*
- In fact, birth rate influence population. Compare the birth rate, population growth rate and GDP growth rate trend in a certain country / region in a period of year.
- Immigration is also a kind of population input. Find out the bidirectional relationship between immigration and GDP growth rate.
- **extra** Maybe we can figure out the immigration trend.


##### 7. What major challenges do you anticipate?
- Some data of specific years are missing. How to deal with the missing data during statistical analysis and line chart drawing will be a problem.

- From now, ```ggmap``` and ```mapproj``` are the packages we use to draw a world map. But the results are far from perfect. We still need to find some way to draw a fancy world map as our main page.

- In the  extra part, we would like to show the immigration tendency on the world map. We are finding a way to draw arrows or even create animation on the website.
