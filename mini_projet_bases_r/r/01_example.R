
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

sales_raw <- tibble(
  date   = c("2024-01-01", "2024-01-02", "2024-01-03"),
  region = c("North", "South", "North"),
  units  = c("10", "5", "8"),
  price  = c("49.99", "49.99", "not_available"),
  stringsAsFactors = FALSE
)

# Conversion des types
sales_raw$date  <- as.Date(sales_raw$date)
sales_raw$units <- as.numeric(sales_raw$units)
sales_raw$price <- as.numeric(sales_raw$price)

# Identifier les lignes avec des valeurs manquantes
rows_ok <- !is.na(sales_raw$units) & !is.na(sales_raw$price)

# Suppression des lignes invalides
sales_clean <- sales_raw[rows_ok, ]

# Création de la variable dérivée
sales_clean$revenue <- sales_clean$units * sales_clean$price

# Affichage du résultat final
sales_clean

sales <- sales |> mutate(revenue = units * price)

sales |>
  filter(region == "North", units >= 10) |>
  arrange(desc(revenue))


sales <- sales |>
  mutate(
    is_bulk = units >= 20,
    ticket = if_else(revenue >= 500, "HIGH", "LOW")
  )

sales |>
  group_by(region) |>
  summarise(
    revenue_total = sum(revenue),
    n_sales = n()
  )

pacman::p_load(ggplot2, tidyverse)

data(iris)

glimpse(iris)



iris_counts <- iris |>
  group_by(Species) |>
  summarise(n = n())

ggplot(iris_counts, aes(x = Species, y = n)) +
  geom_col() +
  labs(
    title = "Nombre de fleurs par espèce",
    x = "Espèce",
    y = "Nombre de fleurs"
  )


iris2 <- iris |>
  mutate(
    petal_long = if_else(Petal.Length >= 4, "Longue", "Courte")
  )

ggplot(iris2, aes(x = Species, fill = petal_long)) +
  geom_bar() +
  labs(
    title = "Répartition des pétales courts/longs par espèce",
    x = "Espèce",
    y = "Nombre de fleurs",
    fill = "Type de pétale"
  )


ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_boxplot() +
  labs(
    title = "Longueur de sépale par espèce",
    x = "Espèce",
    y = "Longueur de sépale"
  )

ggplot(iris, aes(x = Species, y = Petal.Width)) +
  geom_boxplot() +
  labs(
    title = "Largeur de pétale par espèce",
    x = "Espèce",
    y = "Largeur de pétale"
  )


ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point(alpha = 0.8) +
  labs(
    title = "Pétales: Petal.Length vs Petal.Width",
    x = "Longueur de pétale",
    y = "Largeur de pétale",
    color = "Espèce"
  )


ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Relation longueur/largeur de pétale (tendance linéaire par espèce)",
    x = "Longueur de pétale",
    y = "Largeur de pétale",
    color = "Espèce"
  )


ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point(alpha = 0.8) +
  geom_vline(xintercept = 2, linetype = "dashed") +
  geom_hline(yintercept = 0.8, linetype = "dashed") +
  labs(
    title = "Séparation simple de setosa (seuils sur les pétales)",
    x = "Longueur de pétale",
    y = "Largeur de pétale",
    color = "Espèce"
  )


ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram(bins = 20, color = "white", fill = "steelblue") +
  labs(
    title = "Distribution de la longueur de sépale",
    x = "Longueur de sépale",
    y = "Fréquence"
  )


ggplot(iris, aes(x = Petal.Length, fill = Species)) +
  geom_density(alpha = 0.4) +
  labs(
    title = "Densité de la longueur de pétale par espèce",
    x = "Longueur de pétale",
    y = "Densité",
    fill = "Espèce"
  )

ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram(bins = 15, color = "white", fill = "steelblue") +
  facet_wrap(~ Species) +
  labs(
    title = "Longueur de sépale, par espèce",
    x = "Longueur de sépale",
    y = "Fréquence"
  )


ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point(alpha = 0.8) +
  facet_wrap(~ Species) +
  labs(
    title = "Sépales: relation longueur/largeur (par espèce)",
    x = "Longueur de sépale",
    y = "Largeur de sépale"
  )


ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_boxplot() +
  labs(
    title = "Longueur de pétale par espèce",
    x = "Espèce",
    y = "Longueur de pétale"
  )

pacman::p_load(tidyverse)

data(mtcars)

cars <- mtcars |>
  tibble::as_tibble(rownames = "model") # transforme mtcars un dataframe en tibble

glimpse(cars)

ggplot(cars, aes(x = wt, y = mpg)) +
  geom_point()

cars |>
  count(cyl)

ggplot(cars, aes(x = cyl)) +
  geom_bar() +
  labs(
    title = "Nombre de voitures par cylindres",
    x = "Cylindres",
    y = "Nombre"
  )

cars2 <- cars |>
  mutate(
    mpg_band = if_else(mpg >= 20, "Économe", "Gourmande")
  )


ggplot(cars2, aes(x = cyl, fill = mpg_band)) +
  geom_bar() +
  labs(
    title = "Consommation par cylindres",
    x = "Cylindres",
    y = "Nombre",
    fill = "Type"
  )


ggplot(cars, aes(x = factor(cyl), y = mpg)) +
  geom_boxplot() +
  labs(
    title = "Consommation selon les cylindres",
    x = "Cylindres",
    y = "mpg"
  )
ggplot(cars, aes(x = factor(cyl), y = hp)) +
  geom_boxplot() +
  labs(
    title = "Puissance selon les cylindres",
    x = "Cylindres",
    y = "hp"
  )


ggplot(cars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(alpha = 0.8) +
  labs(
    title = "Consommation en fonction du poids",
    x = "Poids",
    y = "mpg",
    color = "Cylindres"
  )


ggplot(cars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Tendance linéaire entre poids et consommation"
  )

x <- as.integer(1)
y <- as.integer(100)
z <- as.integer(1000000)

object.size(x)
object.size(y)
object.size(z)
as.integer(1000000000000000)
x <- 1.8*10^308
x
.Machine$double.xmax


1e10 + 1 == 1e10



x <- c(1, NA, "30",  NA, NA)
x_num <- as.numeric(x)
sum(x_num, na.rm = FALSE)
is.na(x)
sum(is.na(x))

sum(x[!is.na(x)])

sum(c(TRUE, FALSE, TRUE))

v <- c(5, 9, 2, 9, 1)
v[1]
v[2:4]
v[-1]
v[v >= 5]
v <- c(5, 9, 2, 9, 1)
v[-2]

x <- 1:5
tracemem(x)

y <- x
y[1] <- 99
sum( !(y == x) ) 


x <- 1:100000
typeof(mean(x))
sd(x)
x / 3
log(x)
typeof(x)
x <- mean(x)
x 

x <- 2147483647L
x + 2L # 2147483649

A <- matrix(c(1, 2,
              3, 4),
            nrow = 2, byrow = TRUE)

A_inv <- solve(A)
A %*% A_inv


A <- matrix(c(3, 1,
              1, 2),
            nrow = 2, byrow = TRUE)

b <- c(9, 8)
x <- solve(A) %*% b
x
x <- solve(A, b)
x

A %*% x


values <- list(1:3, 10:12, 100:102) 

for (v in values) {        # 1ère boucle : la liste
  for (x in v) {           # 2ème boucle : le vecteur
    print(x)
  }
}


lapply(values, sum)




