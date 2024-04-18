#### Preamble ####
# Purpose: Models of the data to generate inferential statistics
# Author: Xuecheng Gao
# Date: 2 April 2023 
# Contact: xuecheng.gao@mail.utoronto.ca
# License: MIT




#### Workspace setup ####
library(MASS) 
library(dplyr)
library(readr)
library(car)
library(ggplot2)

### Read analysis data ###
analysis_data <-  read.csv('data/analysis_data/cleaned_data.csv')


# Splitting the dataset into before and after a specific date for comparison
start_before <- as.Date("01-jan-20", format="%d-%b-%y")
end_before <- as.Date("01-dec-21", format="%d-%b-%y")
start_after <- as.Date("01-jan-22", format="%d-%b-%y")
end_after <- as.Date("01-mar-24", format="%d-%b-%y")


# Note: This conversion assumes that the format of the date field is "Month - two-digit year", for example "jan-18"
analysis_data$date <- as.Date(paste0("01-", analysis_data$date), format="%d-%b-%y")


# Filter the data set using the converted date column
before_improvement <- subset(analysis_data, date >= start_before & date <= end_before)
after_improvement <- subset(analysis_data, date >= start_after & date <= end_after)


# Verifying the data split
cat("Observations before improvement:", nrow(before_improvement), "\n")
cat("Observations after improvement:", nrow(after_improvement), "\n")


### Model data ####

# Building negative binomial regression models for 2020-2021
model_before <- glm.nb(population_group_percentage_ ~ population_group  + date, data = before_improvement)
summary(model_before)

model_after <- glm.nb(population_group_percentage_ ~ population_group    + date, data = after_improvement)
summary(model_after)



# Graphical representation of the model results for 2022-2023

# For model_before
before_fitted <- data.frame(observed = before_improvement$population_group_percentage, fitted = fitted(model_before))
ggplot(before_fitted, aes(x = fitted, y = observed)) +
  geom_point() +
  geom_line(aes(x = fitted, y = fitted), color = "red") +
  labs(title = "Observed vs. Fitted Values - 2020-2021",
       x = "Fitted Values",
       y = "Observed Values") +
  theme_minimal()
before_fitted

# Save the plot
ggsave("output/graph/2020_2021_plot.png")


# For model_after
after_fitted <- data.frame(observed = after_improvement$population_group_percentage, fitted = fitted(model_after))
ggplot(after_fitted, aes(x = fitted, y = observed)) +
  geom_point() +
  geom_line(aes(x = fitted, y = fitted), color = "red") +
  labs(title = "Observed vs. Fitted Values - 2022-2023",
       x = "Fitted Values",
       y = "Observed Values") +
  theme_minimal()
after_fitted

# Save the plot
ggsave("output/graph/2022_2023.png")



#### Save model ####
models_dir <- ("models")
saveRDS(model_before, file = file.path(models_dir, "model_2020_2021.rds"))
saveRDS(model_after, file = file.path(models_dir, "model_2022_2023.rds"))



### Checks for Model ###

# Checking for multicollinearity using VIF

summary(model_before)
alias(model_before)

vif(model_before) 
vif(model_after)

# Visualizing residuals to identify patterns
par(mfrow = c(2, 2))
par(mar=c(3, 3, 3, 3)) 
plot(residuals(model_before), type = "p", main = "Residuals of Model 2020-2021")
plot(residuals(model_after), type = "p", main = "Residuals of Model 2022-2023")

# Examining the normality of residuals
hist(resid(model_before), main = "Histogram of Residuals - 2020-2021")
hist(resid(model_after), main = "Histogram of Residuals - 2022-2023")

# Investigating influential observations with Cook's distance
cooks.distance(model_before)
cooks.distance(model_after)  

# Plotting Cook's distance
plot(cooks.distance(model_before), type = "h", main = "Cook's Distance - 2020-2021")
plot(cooks.distance(model_after), type = "h", main = "Cook's Distance - 2022-2023")






