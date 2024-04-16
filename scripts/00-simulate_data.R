#### Preamble ####
# Purpose: Downloads and saves data
# Author: Xuecheng Gao
# Date: 2 April 2023 
# Contact: xuecheng.gao@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(tidyverse)


# Set seed for reproducibility
set.seed(123)

# Simulate data
simulate_data <- tibble(
  id = seq(1, 100), # assuming we want 100 rows of data
  date = sample(seq(as.Date('2021-01-01'), as.Date('2023-12-01'), by="month"), 100, replace = TRUE),
  population_group = sample(c("Group A", "Group B", "Group C"), 100, replace = TRUE),
  returned_from_housing = rpois(100, lambda = 5),
  returned_to_shelter = rpois(100, lambda = 3),
  newly_identified = rpois(100, lambda = 7),
  moved_to_housing = rpois(100, lambda = 4),
  became_inactive = rpois(100, lambda = 2),
  actively_homeless = rpois(100, lambda = 10),
  ageunder16 = rbinom(100, size = 100, prob = 0.1),
  age16_24 = rbinom(100, size = 100, prob = 0.15),
  age25_44 = rbinom(100, size = 100, prob = 0.3),
  age45_64 = rbinom(100, size = 100, prob = 0.25),
  age65over = rbinom(100, size = 100, prob = 0.2),
  gender_male = sample(c("Yes", "No"), 100, replace = TRUE),
  gender_female = sample(c("Yes", "No"), 100, replace = TRUE),
  gender_transgender_nonbinary_or_two_spirit = sample(c("Yes", "No"), 100, replace = TRUE),
  population_group_percentage = runif(100, 0, 1)
) %>%
  mutate(date = format(date, "%b-%y")) # format the date as 'mmm-yy'

# Print the head of the data
head(simulate_data)
simulate_data[, (ncol(simulate_data)-9):ncol(simulate_data)]

