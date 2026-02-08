
sales <- tibble(
  region = c("North", "South"),
  units  = c(12L, 8L),
  price  = c(49.99, 49.99)
)

sales

sales$units
sales$price
sales$price[1]

sales[1, ]
sales[, 3]
sales[, c("region", "units")]


sales[sales$region == "North", ]


library(readr)


sales <- read_csv("./r/data/sales.csv")
sales
