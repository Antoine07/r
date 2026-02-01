# 104 — Structures composées (exercices)

---

## Exercice 1 — Listes: accès

1. Créer:

```r
student <- list(name = "Alice", age = 20L, scores = c(12, 15, 18))
```

2. Extraire `age` avec `student[["age"]]` puis avec `student$age`.
3. Extraire `scores` et calculer la moyenne.

## Exercice 2 — Listes: itération

1. Créer `values <- list(1:3, 10:12, 100:102)`.
2. Calculer la somme de chaque élément avec `lapply(values, sum)`.

## Exercice 3 — Matrices: création et indexation

1. Créer `m <- matrix(1:9, nrow = 3, byrow = TRUE)`.
2. Extraire l'élément (ligne 2, colonne 3).
3. Extraire la ligne 1 avec et sans `drop = FALSE` et comparer `class()`.

## Exercice 4 — Matrices: opérations

1. Créer `A <- matrix(1:4, nrow = 2)` et `B <- matrix(5:8, nrow = 2)`.
2. Calculer `A + B` puis `A %*% B` et expliquer la différence.

## Exercice 5 — Arrays

1. Créer `a <- array(1:24, dim = c(2, 3, 4))`.
2. Extraire `a[1, 2, 3]`.
3. Calculer `apply(a, 2, sum)`.

## Exercice 6 — Attributes (class)

1. Créer `d <- as.Date("2026-01-01")`.
2. Afficher `typeof(d)`, `class(d)` puis `unclass(d)`.
3. Expliquer en 2–3 lignes ce que représente `class` dans ce cas.
