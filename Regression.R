
# Activate Library --------------------------------------------------------

library(readxl)
library(tidyverse)


# Data Input --------------------------------------------------------------

data16 <- read_excel('data/data_1625.xlsx', sheet='data_16')
data25 <- read_excel('data/data_1625.xlsx', sheet='data_25')


# Correlation Matrix ------------------------------------------------------

data16 %>% 
  select(-taz, -UPDIST, -DISTRICT_N) %>% 
  cor()


# Correlation Matrix Plot -------------------------------------------------

data16 %>% 
  select(-taz, -UPDIST, -DISTRICT_N) %>% 
  ggpairs()

data16 %>% 
  select(-taz, -DISTRICT_N) %>% 
  ggpairs(mapping=aes(color=UPDIST, alpha=0.5))


# Regression --------------------------------------------------------------

data16 <- data16 %>% rename_with(.fn=~str_remove(., '2016'))
data25 <- data25 %>% rename_with(.fn=~str_remove(., '2025'))

ori_model <- lm(ori ~ pop+young+work+job, data=data16)
ori_model
summary(ori_model)


# Applying Regression Model -----------------------------------------------

ori_final <- lm(ori ~ job + stu, data=data16)
des_final <- lm(des ~ work + job + stu, data=data16)
summary(ori_final)

data25$ori <- predict(ori_final, data25)
data25$des <- predict(des_final, data25)
data25