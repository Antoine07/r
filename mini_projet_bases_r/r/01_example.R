
rm(list = ls())

df <- data.frame(
  region = c("North", "South"),
  units = c(12L, 8L),
  price = c(49.99, 49.99)
)
str(df)

df$region

df[1, ]
df[df$region == "North", ]
df[,1:2 ]
df[, c("region", "units")]


if (!require("pacman", quietly = TRUE)) {
  install.packages("pacman")
}
library(pacman)

pacman::p_load(tibble)

tibble::tibble(region = c("North", "South"), units = c(12L, 8L))


pacman::p_load(readr)

sales <- readr::read_csv("../TPs/r/data/sales.csv", show_col_types = TRUE)

str(sales)


february <- c(
  1,  3, -1,  4, NA,  2,  5, -2,  6,  7,
  6,  0, -3,  2,  3, NA,  7,  6,  6, -1,
  6,  7,  8,  1, -2,  0,  2,  3
)

warm <- february > 5
warm[is.na(warm)] <- FALSE  

start_episode <- warm[1:(length(warm) - 2)] &
  warm[2:(length(warm) - 1)] &
  warm[3:length(warm)]


start_episode

days <- 1:length(february)
starts <- days[1:(length(days) - 2)][start_episode]
starts


sales <- tibble(
  product = c("A", "A", "B", "B", "C"),
  units   = c(2, 1, 5, 3, 1),
  price   = c(10, 10, 8, 8, 20)
)

pacman::p_load(dplyr)

sales |>
  group_by(product) |>
  summarise(
    total_units = sum(units),
    .groups = "drop"
  )



rm(list = ls())

sales <- tibble(
  region  = c("EU", "EU", "EU", "US", "US", "US"),
  product = c("A",  "A",  "B",  "A",  "B",  "B"),
  date    = as.Date(c(
    "2024-01-01",
    "2024-01-01",
    "2024-01-01",
    "2024-01-02",
    "2024-01-02",
    "2024-01-02"
  )),
  revenue = c(100, 50, 80, 120, 60, 40)
)

cube <- xtabs(revenue ~ region + product + date, data = sales)

double <- function(x) {
  x * 100
}

x <- 1:5
x |>
  sum() |> 
  double() |>
  double()

m <-matrix(1:6, nrow=3, ncol = 2,  byrow = TRUE)
m   

m <- rbind(
  c(1, 2),
  c(4, 5),
  c(4, 5)
)

m

gc()
ls()
sum(sapply(ls(), function(n) object.size(get(n))))
system("vm_stat") 

a <-numeric(10)
a


fibo <-function(n){
    if(n < 2) stop("la suite de fibo commence à n > 2 ici")
    v <-numeric(n)
    v[1]<-1
    v[2]<-1
    
    for(i in 3:n){
      v[i] <- v[i-2] + v[i-1]
    }
    
    v
}

fibo(10)

sales |>
  group_by(region) |>
  summarise(total_revenue = sum(revenue))


sales |>
  group_by(region) |>
  summarise(
    n = n(), 
    revenue_total = sum(revenue),
    revenue_mean = mean(revenue)
  )

url <- "https://raw.githubusercontent.com/Antoine07/r/refs/heads/main/data/sales.csv"

sales <- readr::read_csv(url, show_col_types = FALSE)

str(sales)

summary(sales)
head(sales)

args(read_csv)
formals(read_csv)

required <- c("date", "region", "product", "units", "price")
missing <- setdiff(required, names(sales))
missing
names(sales)


d <- setdiff(c(1,2,3,4), c(1,2))
d
paste(d, collapse = ", ")
sum(c(1,2,3, NA),  na.rm = TRUE) 

?sum

anyNA(c(1,2,3, 6))
df <- tibble(
  region = c("North", "South"),
  units = c(12L, 8L),
  price = c(49.99, 49.99)
)
str(df)

df$units
names(df)
nrow(df)
df[df$region == "North", ]

sales |> mutate(revenue = units * price)



