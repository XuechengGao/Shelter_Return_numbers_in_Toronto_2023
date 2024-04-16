#### Preamble ####
# Purpose: Downloads and saves data
# Author: Xuecheng Gao
# Date: 2 April 2023 
# Contact: xuecheng.gao@mail.utoronto.ca
# License: MIT
# Pre-requisites: none



#### Workspace setup ####
library(tidyverse)

#### Clean data ####
### import raw data ###
toronto_shelter_system_flow <- read_csv("data/raw_data/toronto-shelter-system-flow.csv")



# Cleaning the data might involve:



# 1. Ensuring that all textual data is in a consistent format, such as all uppercase or all lowercase
toronto_shelter_system_flow <- toronto_shelter_system_flow %>%
  mutate(across(where(is.character), tolower)) # or toupper()

# 2. Converting categorical data into factor type with appropriate levels
toronto_shelter_system_flow <- toronto_shelter_system_flow %>%
  mutate(across(c(population_group, gender_male, gender_female, "gender_transgender,non-binary_or_two_spirit"), as.factor))

# 3. Handling any missing or NA values appropriately, which may depend on the context
toronto_shelter_system_flow <- toronto_shelter_system_flow %>%
  mutate(across(everything(), ~ifelse(is.na(.), 'Unknown', .)))

# 4. Converting percentages to a proportional format if they are currently in percentage format
toronto_shelter_system_flow <- toronto_shelter_system_flow %>%
  mutate(population_group_percentage = as.numeric(gsub("%", "", population_group_percentage))/100)



# 5. Ensuring age groups are numeric and named consistently without any special characters
toronto_shelter_system_flow <- toronto_shelter_system_flow %>%
  rename_with(~gsub("ageunder", "age_under_", .)) %>%
  rename_with(~gsub("age", "age_", .))


#### Save data ####
write_csv(toronto_shelter_system_flow, "data/analysis_data/toronto-shelter-system-flow-cleaned.csv")

