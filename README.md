# info201-AU17-birth-rate-analysis
Final project group for Informatics 201, introduction to data analysis and technical methods in Informatics.

# our data
| local path | type | rows | columns | source |
| ---------- | ---- | ---- | ------- | -------|
| data/birth_rate.csv | csv | 265 | "Country Name", "Country Code", "Indicator Name", "Indicator Code", "1960", "1961", through "2016", "2017" |
| data/GDP_in_countries.csv | csv | 265 | "Country Name", "Country Code", "Indicator Name", "Indicator Code", "1960", "1961", through "2016", "2017" |
| data/immigration.csv | csv | 265 | "Country Name", "Country Code", "Indicator Name", "Indicator Code", "1960", "1961", through "2016", "2017" |
| data/income_group.csv | csv | 264 | "Country Code", "Region", "IncomeGroup", "SpecialNotes", "CountryName" |
| data/population.csv | csv | 265 | "Country Name", "Country Code", "Indicator Name", "Indicator Code", "1960", "1961", through "2016", "2017" |
| data/population_growth.csv | csv | 265 | "Country Name", "Country Code", "Indicator Name", "Indicator Code", "1960", "1961", through "2016", "2017" |
| data/Countries_List.csv | csv | 243 | lots | https://opendata.socrata.com/dataset/Country-List-ISO-3166-Codes-Latitude-Longitude/mnkm-8ram |

# our code

- important to note, in order to locally test this code, you must run the following from a command link currently open in the master repo: ```cp -r data ~/data``` and ```cp -r contributorScripts ~/contributorScripts``` and ```cp -r md ~/md```. This is because when developing Shiny apps, you cannot use ```setwd()``` or ```getwd()```, and the working directory defaults to ```~/```, at least on my computer, probably for all macs. Windows users, I believe it will default to ```Users/yourUser```, so you should place the sourced files there.

# remote host
[Shiny App Server](https://carlquistb.shinyapps.io/info201-AU17-birth-rate-analysis/)
