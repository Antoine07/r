https://www.youtube.com/watch?v=AG4iFVJWvoE


## reset RStudio 

```r
rm(list = ls())
```

## package pacman

On ne l'utilisera pas dans un projet structuré avec `renv`, mais il est pratique dans un script R pour commencer.

```r
# pacman est un package qui permet de gérer facilement les packages 
if (!require("pacman", quietly = TRUE)) {
  install.packages("pacman")
}
library(pacman)

# installe le package s'il manque le charge s'il est déjà installé
pacman::p_load(dplyr, ggplot2, readr)
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