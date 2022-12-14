library(tidyverse)
library(mlogit)

df <- read_csv('data_canada.csv')
df_mlogit <- mlogit.data(df, choice='mode', varying=3:30, sep='_')
my_model <- mlogit(mode~ovt+freq|dist+income|ivt, data=df_mlogit)
summary(my_model)

df <- read_csv('data_canada.csv')
df_mlogit <- mlogit.data(df, choice='choice')
my_model <- mlogit(choice~ovt+freq|dist+income|ivt, data=df_mlogit)
summary(my_model)

my_model <- mlogit(mode~ovt+freq|income|ivt, data=df_mlogit, reflevel='car')
summary(my_model)
