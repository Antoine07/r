# Correction — Exercice Max / Min en R

# Fonction de comparaison entre deux valeurs
max_num <- function(a, b) {
  if (a > b) a else b
}

min_num <- function(a, b) {
  if (a < b) a else b
}

# Maximum d'un vecteur (sans max, min, Reduce)
max_vec <- function(x) {
  m <- x[1]
  for (i in 2:length(x)) {
    m <- max_num(m, x[i])
  }
  m
}

# Minimum d'un vecteur (sans max, min, Reduce)
min_vec <- function(x) {
  m <- x[1]
  for (i in 2:length(x)) {
    m <- min_num(m, x[i])
  }
  m
}

# Exemple de test
x <- c(5, 2, 9, 1, 7)

max_vec(x)  # 9
min_vec(x)  # 1
