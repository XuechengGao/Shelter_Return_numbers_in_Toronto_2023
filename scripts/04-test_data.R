#### Preamble ####
# Purpose: Downloads and saves data
# Author: Xuecheng Gao
# Date: 2 April 2023 
# Contact: xuecheng.gao@mail.utoronto.ca
# License: MIT
# Pre-requisites: none

#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(tidyverse)

# Assuming 'simulate_data' is already loaded into your R session
# and has the structure you've specified.

# Test 1: Check if '_id' column is integer
test_id_numeric <- simulate_data$ id |> class() == "integer"

# Test 2: Check if 'date' column is of type character
# and follows the 'mmm-yy' format
test_date_format <- all(str_detect(simulate_data$date, "^[A-Z][a-z]{2}-\\d{2}$"))

# Test 3: Check if 'population_group' column is of type character
test_population_group_character <- simulate_data$population_group |> class() == "character"

# Test 4: Check if 'returned_from_housing' column is integer
test_returned_from_housing_numeric <- simulate_data$returned_from_housing |> class() == "integer"

# Test 5: Check if 'returned_to_shelter' column is integer
test_returned_to_shelter_numeric <- simulate_data$returned_to_shelter |> class() == "integer"

# Test 6: Check if 'newly_identified' column is integer
test_newly_identified_numeric <- simulate_data$newly_identified |> class() == "integer"

# Test 7: Check if 'moved_to_housing' column is integer
test_moved_to_housing_numeric <- simulate_data$moved_to_housing |> class() == "integer"

# Test 8: Check if 'became_inactive' column is integer
test_became_inactive_numeric <- simulate_data$became_inactive |> class() == "integer"

# Test 9: Check if 'actively_homeless' column is integer
test_actively_homeless_numeric <- simulate_data$actively_homeless |> class() == "integer"

# Test 10: Check if age group columns are integer
test_age_groups_numeric <- all(map_chr(simulate_data[, c("ageunder16", "age16_24", "age25_44", "age45_64", "age65over")], class) %in% c("integer", "numeric", "double"))

# Test 11: Check if gender columns are integer
# Define the allowed gender categories
allowed_genders <- c("Male", "Female", "Transgender_nonbinary_or_two_spirit")

# Test if 'gender_male', 'gender_female', or 'gender_transgender_nonbinary_or_two_spirit'
# columns contain only the allowed categories
test_gender_categories <- all(simulate_data$gender_male %in% allowed_genders) &&
  all(simulate_data$gender_female %in% allowed_genders) &&
  all(simulate_data$`gender_transgender_nonbinary_or_two_spirit` %in% allowed_genders)

# Test 12: Check if 'population_group_percentage' column is numeric and values range between 0 and 100
test_population_group_percentage <- simulate_data$population_group_percentage |> class() %in% c("double", "numeric") &&
  all(simulate_data$population_group_percentage >= 0 & simulate_data$population_group_percentage <= 100)
      
# Collect all test results into a list for easy overview
test_results <- list(
  test_id_numeric,
  test_date_format,
  test_population_group_character,
  test_returned_from_housing_numeric,
  test_returned_to_shelter_numeric,
  test_newly_identified_numeric,
  test_moved_to_housing_numeric,
  test_became_inactive_numeric,
  test_actively_homeless_numeric,
  test_age_groups_numeric,
  test_gender_groups_numeric,
  test_population_group_percentage
)

# Print the test results
print(test_results)