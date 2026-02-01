https://www.youtube.com/watch?v=AG4iFVJWvoE


## reset RStudio 

```r
rm(list = ls())
```

## package pacman

```r
# pacman est un package qui permet de gérer facilement les packages 
if (!require("pacman", quietly = TRUE)) {
  install.packages("pacman")
}
library(pacman)

# installe le package s'il manque le charge s'il est déjà installé
pacman::p_load(dplyr, ggplot2, readr)
```