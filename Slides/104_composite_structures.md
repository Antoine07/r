---
marp: true
theme: default
paginate: true
class: lead
---

# Chapitre 2 — Structures composées

À maîtriser:

- listes
- matrices
- arrays
- attributes

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

## Arrays — définition

Un **array** généralise les matrices à N dimensions.

```r
a <- array(1:6, dim = c(1, 2, 3)) # 1 ligne 2 colonnes 3 couches
dim(a)
a[1, 2, 3]

b <- array(1:24, dim = c(2, 3, 4)) # 2 ligne 3 colonnes 4 couches
dim(b)
b[2, 3, 4]
```

---

## Arrays — appliquer sur une dimension

`apply(a, MARGIN, FUN)` applique une fonction sur des marges.

```r
apply(a, 1, sum)  # somme sur la 1ère dimension
apply(a, 2, sum)  # somme sur la 2e dimension
```

---

## Attributes — définition

Les **attributs** sont des méta-données attachées à un objet, attention un vecteur n'a pas de clé mais peut avoir des noms.

- `names`, `dim`, `class`, `levels`, …

```r
x <- c(a = 10, b = 20)
attributes(x)
```

---

## Attributes — `class` (sémantique)

Beaucoup d'objets sont des vecteurs + un `class`.

```r
d <- as.Date("2026-01-01")
typeof(d)
class(d) # permet de vérifier ici que c'est une Date 
```

---

## Pourquoi obtient-on la même valeur ?

```r
d <- as.Date("2026-01-01")
unclass(d)
# 20454

e <- as.Date("2026-01-01") - as.Date("1970-01-01")
unclass(e)
# 20454
```

Pourquoi `d` et `e` donnent-ils exactement la même valeur numérique (`20454`) ?

---

<details>
<summary>💡 Réponse</summary>

En R, une **date (`Date`) est stockée comme le nombre de jours écoulés depuis le 1ᵉʳ janvier 1970** (l'epoch Unix , epoch un point de départ dans le temps)

- `d` est une **date** :
  → un nombre (`double`) représentant des jours depuis 1970, avec la classe `"Date"`

- `e` est une **durée (`difftime`)** :
  → le résultat explicite du calcul entre deux dates
  → exprimée en **jours**

Dans les deux cas, la valeur brute est identique.

```
1970-01-01 + 20454 jours = 2026-01-01
```

Ce qui change n'est **pas la valeur**, mais **le sens métier** :

- `d` → un **instant dans le temps**
- `e` → une **durée**

</details>

---

## Exercice - les structures de données

Sujet: `Exercices/104_composite_structures.md`

