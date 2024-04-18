#### Preamble ####
# Purpose: Downloads and saves data
# Author: Xuecheng Gao
# Date: 2 April 2023 
# Contact: xuecheng.gao@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(tidyverse)
# [...UPDATE THIS...]

#### Load data ####
# [...ADD CODE HERE...]
# 假设你的数据集已经载入到变量data中
data <- read.csv('data/analysis_data/toronto-shelter-system-flow-cleaned.csv')



# 导入MASS包（如果尚未安装，请先安装）
if (!require(MASS)) {
  install.packages("MASS")
  library(MASS)
}

# 导入lme4包（如果尚未安装，请先安装）
if (!require(lme4)) {
  install.packages("lme4")
  library(lme4)
}


# 使用多层回归拟合数据，并指定随机截距效应
#model_ml <- lmer(population_group_percentage_ ~ returned_from_housing + returned_to_shelter + newly_identified + moved_to_housing + became_inactive +
 #                  actively_homeless + age_under_16 + age_16_24 + age_25_44 + age_45_64 + age_65over +
  #                 gender_male + gender_female + (1 | population_group), data=data)
model_ml <- glm.nb(population_group_percentage_ ~ returned_from_housing + returned_to_shelter + newly_identified + moved_to_housing + became_inactive +
                   actively_homeless + age_under_16 + age_16_24 + age_25_44 + age_45_64 + age_65over +
                   gender_male + gender_female + (1 | population_group), data=data)




# 输出模型摘要
summary(model_nb)

# 预测
predicted_values_nb <- predict(model_nb, newdata=data, type="response")

# 计算R平方值
rsquared_nb <- 1 - sum((data$population_group - predicted_values_nb)^2) / sum((data$population_group - mean(data$population_group))^2)
print(paste("R平方值:", rsquared_nb))


# 计算预测的准确率
MSE <- mean((test_data$population_group_percentage_ - predictions)^2)
R2 <- cor(test_data$population_group_percentage_, predictions)^2

# 输出准确率指标
print(list(MSE = MSE, R2 = R2))
