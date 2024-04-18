#### Preamble ####
# Purpose: Simulate data
# Author: Xuecheng Gao
# Date: 2 April 2023 
# Contact: xuecheng.gao@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(tidyverse)
library(dplyr)

# Set seed for reproducibility
set.seed(500)

# Set parameters for simulated data
n_rows <- 100  # Number of rows
start_date <- as.Date("2020-01-01")  # Start date
end_date <- as.Date("2023-01-01")  # End date
groups <- c("Chronic", "Refugees", "Families", "Youth", "Single Adult")  # Different groups
cols <- c("returned_from_housing", "returned_to_shelter", "newly_identified", 
          "moved_to_housing", "became_inactive")  # Variables of interest

# Generate date sequence
dates <- seq.Date(from = start_date, to = end_date, by = "month")

# Generate simulated data
data <- expand.grid(date = dates, group = groups)
data <- data %>%
  mutate(
    returned_from_housing = sample(0:100, n(), replace = TRUE),
    returned_to_shelter = sample(0:100, n(), replace = TRUE),
    newly_identified = sample(0:100, n(), replace = TRUE),
    moved_to_housing = sample(0:100, n(), replace = TRUE),
    became_inactive = sample(0:100, n(), replace = TRUE)
  )



# Print the head of the data
head(simulate_data)
simulate_data[, (ncol(simulate_data)-9):ncol(simulate_data)]

