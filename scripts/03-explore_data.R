#### Preamble ####
# Purpose: 
# Author: Xuecheng Gao
# Date: 2 April 2023 
# Contact: xuecheng.gao@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(tidyverse)



toronto_shelter_system_flow <- read_csv("data/analysis_data/toronto-shelter-system-flow-cleaned.csv")


ggplot(toronto_shelter_system_flow, aes(x = population_group, y = returned_from_housing, fill = population_group)) +
  geom_col() +
  labs(title = "Number of People Returned from Housing by Population Group",
       x = "Population Group", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


toronto_shelter_system_flow %>%
  gather(key = "age_group", value = "count", "age__under_16", "age_16-24", "age_25-44", "age_45-64", "age_65over") %>%
  ggplot(aes(x = age_group, y = count, fill = age_group)) +
  geom_col() +
  labs(title = "Actively Homeless Count by Age Group",
       x = "Age Group", y = "Count") +
  theme_minimal()


toronto_shelter_system_flow %>%
  select(population_group, gender_male, gender_female, ends_with("transgender,non-binary_or_two_spirit")) %>%
  pivot_longer(cols = -population_group, names_to = "gender", values_to = "count") %>%
  ggplot(aes(x = population_group, y = count, fill = gender)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Gender Distribution by Population Group",
       x = "Population Group", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


ggsave("toronto_shelter_visualizations.pdf", device = "pdf")