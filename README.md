## reset RStudio 

```r
rm(list = ls())
```

## package indispensable 

On ne l'utilisera pas dans un projet structuré avec `renv`, mais il est pratique dans un script R pour commencer.

En console 

```bash
install.packages(c("tibble", "readr", "dplyr"))
```

Puis chargez les librairies dans R

```r
library("tibble")

data(iris)

iris |> 
  as_tibble() |> 
  summarise(across(where(is.numeric), mean))
```

## fonctions utiles 

```r
# Accéder à la documentation d’une fonction
?function_name

?read_csv
help(read_csv)

# Afficher la signature d’une fonction
args(read_csv)

# Lister tous les paramètres et leurs valeurs par défaut
formals(read_csv)
```

## Supports de cours 

https://www.youtube.com/watch?v=AG4iFVJWvoE