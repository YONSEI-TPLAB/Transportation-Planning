
# Activate Library --------------------------------------------------------

library(readxl)
library(tidyverse)


# Data Input --------------------------------------------------------------

df_long <- read_excel('data/data_choice.xlsx', sheet='long')
df_wide <- read_excel('data/data_choice.xlsx', sheet='wide')


# Activate 'mlogit' library -----------------------------------------------

# install.packages('mlogit')
library(mlogit)


# mlogit ------------------------------------------------------------------

long <- mlogit.data(df_long, choice='choice', idx=c('id', 'mode'))
wide <- mlogit.data(df_wide, choice='choice', varying=3:10, sep='_')

model_long <- mlogit(choice~vcost+wait|income+size|travel, data=long)
model_wide <- mlogit(choice~price+time|comfort, data=wide)

summary(model_long)
summary(model_wide)


# Prediction --------------------------------------------------------------

fitted <- data.frame(model_long$probabilities)
fitted$pred_choice <- colnames(fitted)[apply(fitted, 1, which.max)]


# Comparison --------------------------------------------------------------

df_long %>%
  filter(choice=='yes') %>%
  select(mode) %>%
  table() %>%
  prop.table()

model_long$freq %>% prop.table()

fitted %>% select(pred_choice) %>% table() %>% prop.table()




# Selection of the type of independent variables --------------------------

library(GGally)
long %>%
  data.frame() %>%
  select(-choice, -idx) %>%
  ggpairs(mapping=aes(color=mode))


