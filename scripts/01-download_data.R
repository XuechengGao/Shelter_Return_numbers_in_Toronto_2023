#### Preamble ####
# Purpose: Downloads and saves data
# Author: Xuecheng Gao
# Date: 2 April 2023 
# Contact: xuecheng.gao@mail.utoronto.ca
# License: MIT
# Pre-requisites: none



#### Workspace setup ####
library(opendatatoronto)
library(dplyr)


#### Download data ####

# get package
package <- show_package("ac77f532-f18b-427c-905c-4ae87ce69c93")
package

# get all resources for this package
resources <- list_package_resources("ac77f532-f18b-427c-905c-4ae87ce69c93")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()
data

#### Save data ####
# Save a New file
write_csv(data,"data/raw_data/toronto-shelter-system-flow.csv")


library(readr)
toronto_shelter_system_flow <- read_csv("data/raw_data/toronto-shelter-system-flow.csv")
View(toronto_shelter_system_flow)


         
