library(tidyverse)
data(iris)

iris 
t <- tibble(
  x = 1:3,
  y = c("a", "b", "c")
)

t[2:3, ]
