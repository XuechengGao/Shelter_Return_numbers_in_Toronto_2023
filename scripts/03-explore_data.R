#### Preamble ####
# Purpose: Explore the dataset by creating data visualizations.
# Author: Xuecheng Gao
# Date: 2 April 2023 
# Contact: xuecheng.gao@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(tidyverse)
library(ggplot2)
library(tidyr)
library(readr)
library(here)

### Read analysis data ###

cleaned_data <- read_csv("data/analysis_data/cleaned_data.csv")


ggplot(cleaned_data, aes(x = population_group, y = returned_from_housing, fill = population_group)) +
  geom_col() +
  labs(title = "Number of People Returned from Housing by Population Group",
       x = "Population Group", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save plot
ggsave("output/graph/People_Returned_from_Housing_by_Population_Group.png")

cleaned_data %>%
  gather(key = "age_group", value = "count", "age__under_16", "age_16-24", "age_25-44", "age_45-64", "age_65over") %>%
  ggplot(aes(x = age_group, y = count, fill = age_group)) +
  geom_col() +
  labs(title = "Actively Homeless Count by Age Group",
       x = "Age Group", y = "Count") +
  theme_minimal()
# Save plot
ggsave("output/graph/Actively_Homeless_Count_by_Age_Group.png")

cleaned_data %>%
  pivot_longer(cols = c(gender_male, gender_female, "gender_transgender,non-binary_or_two_spirit"),
               names_to = "gender", values_to = "count") %>%
  ggplot(aes(x = population_group, y = count, fill = gender)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Gender Distribution by Population Group",
       x = "Population Group", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save plot
ggsave("output/graph/toronto_shelter_visualizations.png")





