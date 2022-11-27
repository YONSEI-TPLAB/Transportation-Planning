library(tidyverse)
library(readxl)
data25 <- read_excel('data/data_2530.xlsx', sheet='2025³â')
data30 <- read_excel('data/data_2530.xlsx', sheet='2030³â')

data25 %>% group_by(sido) %>% summarise(ori=mean(ori), des=mean(des), n_samples=n())

t.test(data25$pop, mu=330000)

model_2025 <- lm(des ~ stu + emp + pop + work + pop15, data=data25)
summary(model_2025)

data30$des <- predict(model_2025, data30)
barplot(data30$des, names=data30$sigungu, horiz=TRUE)