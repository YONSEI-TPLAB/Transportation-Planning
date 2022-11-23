library(tidyverse)
library(mlogit)

df_long <- read_csv('data/data_mode.csv')
long <- mlogit.data(df_long, choice='choice', idx=c('id', 'alt'))
model_long <- mlogit(choice~cost+ovt+freq|income|ivt, data=long)
summary(model_long)


# Pivot wider and apply mlogit() ------------------------------------------

wider <- df_long %>% pivot_wider(id_cols='id', names_from='alt', values_from=c(4:10))
choices <- df_long %>% filter(choice==1) %>% select(id, alt) %>% rename(mode=alt)
df_wide <- wider %>% left_join(choices, by='id') %>% relocate(mode, .after=id) %>% arrange(id)
wide <- mlogit.data(df_wide, choice='mode', varying=3:30, sep='_')
model_wide <- mlogit(mode~cost+ovt+freq|income|ivt, data=wide)
summary(model_wide)


# Wide data from New file -------------------------------------------------

df_wide %>% write_csv('data/data_canada.csv')
df_wide <- read_csv('data/data_canada.csv')
wide <- mlogit.data(df_wide, choice='mode', varying=3:30, sep='_')
model_wide <- mlogit(mode~cost+ovt+freq|income|ivt, data=wide)
summary(model_wide)
