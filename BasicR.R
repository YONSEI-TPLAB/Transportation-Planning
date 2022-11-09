# Working Directory -------------------------------------------------------

getwd()

setwd('D:/Course/TransportationPlanning')



# R Objects ---------------------------------------------------------------

value_character <- 'cat'

value_numeric <- 1.8

value_logical <- TRUE

object_vector <- c('cat', 'dog')
c(1:5)
seq(1, 11, 2)
rep(2, 4)

object_vector[1]
object_vector[2]

object_mtx <- matrix(c(1.8, 2.8, 3.8, 4.8, 5.8, 6.8), nrow=2, ncol=3, byrow=TRUE)
object_mtx[1]
object_mtx[1, ]
object_mtx[, 2]

object_arr <- array(c(TRUE, FALSE, FALSE, TRUE, FALSE, FALSE), dim=c(1, 2, 3))
object_arr[1]
object_arr[4]
object_arr[1, 2, ]
object_arr[1, , 3]
object_arr[, , 3]

object_df <- data.frame(
  animal=object_vector,
  count=c(2, 1)
)
object_df[1]
object_df[2, ]
object_df[, 2]
object_df$animal

object_list <- list(value_character, object_mtx, object_df)
object_list[1]



# For loop / If statement -------------------------------------------------

for(x in object_vector){
  print(x)
}


y <- 0
if(y > 2){
  print('2 초과')
} else if(y == 2){
  print('2 동일')
} else{
  print('2 미만')
}



# Function ----------------------------------------------------------------

assign_x <- function(x){
  return(x)
}
assign_x(1)
assign_x(x=2)

is_3 <- assign_x(3)
is_3


# Data Input --------------------------------------------------------------


install.packages('tidyverse')
library(tidyverse)

ys <- read_csv('data/raw/인천광역시 연수구.csv')

ys <- read_csv('data/raw/인천광역시 연수구.csv', locale=locale('ko', encoding='cp949'))

View(ys)

data16 <- read.table(file="clipboard", sep="\t", header=TRUE)


# Dataframe Manipulation --------------------------------------------------

data16$job2016
data16[1, 4]
data16[1, ]
data16[, 4]
data16[1:3, c(3, 5)]
data16[, c('pop2016')]

data16 %>%
  slice(2)
data16 %>%
  filter(taz==2)
data16 %>%
  select(1)
data16 %>%
  select(taz)

data16$stuall <- data16$stu2016 + data16$univ2016

data16 %>%
  mutate(stuall = stu2016 + univ2016) %>%
  summary()

boxplot(data16[, 4:11])
plot(data16$pop2016, data16$ori2016)


# Automation --------------------------------------------------------------

all <- data.frame()
l <- list.files(path='data/raw/', pattern='csv')
for(i in 1:length(l)){
  now <- read_csv(paste0('data/raw/', l[i]), locale=locale('ko', encoding='cp949'))
  all <- bind_rows(all, now)
}
View(all)

write_csv(all, 'data/total_16.csv')

all_once <- read_csv(paste0('data/raw/', l), locale=locale('ko', encoding='cp949'))