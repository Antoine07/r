---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Chapitre 2 — Structures composées

À maîtriser:

- listes
- matrices

---

## Listes — définition

Une **liste** est une collection d'éléments, potentiellement de types différents.

Remarque `20L` représente un entier L force le type `integer`

```r
l <- list(
  name = "Alice",
  age = 20L,
  scores = c(12, 15, 18)
)
str(l)
```

---

## Listes — extraire: `[ ]` vs `[[ ]]` vs `$`

- `l["age"]` renvoie une sous-liste (type liste)
- `l[["age"]]` renvoie l'élément
- `l$age` accède à un élément par nom

```r
l["age"]
l[["age"]] 
l$age # meme chose que ce qui précède 
```

Vérifiez les types avec `typeof`

---

## Listes — itération

```r
values <- list(1:3, 10:12, 100:102) # liste de listes, 3 éléments
lapply(values, sum)
```

Point technique: `lapply()` renvoie toujours une liste.

>Liste → lapply()
>Matrice / array → apply()

---


## Matrices — définition

Une **matrice** est un vecteur atomique + un attribut `dim` (2D).

```r
m <- matrix(1:6, nrow = 2, byrow = TRUE)
m
dim(m)
```

---

`matrix()` prend un vecteur et le transforme en 2D
`nrow = 2` impose 2 lignes
`ncol` est déduit automatiquement
`byrow = TRUE` remplit ligne par ligne (sinon colonne par colonne)

```r
m <- matrix(1:6, nrow = 2)
m <- matrix(1:6, nrow = 2, byrow = TRUE)
m <- rbind(
  c(1, 2, 3),
  c(4, 5, 6)
)
# existe rbind r = row ici c = col
m <- cbind(
  c(1, 4),
  c(2, 5),
  c(3, 6)
)
m <- diag(3) # matrice identité
```
---

## Matrices — indexation et `drop`

```r
m[1, 2]
m[1, ]              # "drop" la dimension, plus une matrice
m[1, , drop = FALSE] # conserve une matrice
```

---

## Matrices — opérations

- élément-par-élément: `+`, `*`
- produit matriciel: `%*%`

```r
A <- matrix(1:4, nrow = 2)
B <- matrix(5:8, nrow = 2)

A + B
A %*% B
```

---

`byrow = TRUE` remplissage par ligne, par défaut FALSE par colonne

```r
m <- matrix(1:6, nrow = 2, byrow = TRUE)
m
```

---

```r
rowSums(A) # somme des lignes
colSums(A) # somme des colonnes

# apply pour les fonctions 
apply(A, 1, max) # max des lignes  1 = ligne
apply(A, 2, max)  # max des colonnes 2 = colonne
```

---

# Inverser une matrice

```r
A <- matrix(c(1, 2,
              3, 4),
            nrow = 2, byrow = TRUE)

A_inv <- solve(A)
A %*% A_inv
```

---

# Résoudre un système `Ax=b`


```r
A <- matrix(c(3, 1,
              1, 2),
            nrow = 2, byrow = TRUE)

b <- c(9, 8)
```

- Méthode naïve à éviter : `x <- solve(A) %*% b`
- Méthode efficace : `x <- solve(A, b)`
- Vérifier : `A %*% x`

---

## Exercice - les structures de données

Sujet: `Exercices/104_composite_structures.md`
