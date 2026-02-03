---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Cubes en R (tableaux de contingence)

Après les structures tabulaires (`data.frame`, `tibble`), un **cube** est une représentation compacte d'un indicateur agrégé sur **plusieurs axes**.

---

## Définition — Cube

Un **cube** est un **array** (tableau N-dimensionnel) dont:

- chaque dimension correspond à un axe d'analyse (ex: région, produit, date)
- chaque cellule contient une valeur agrégée (ex: somme du CA)

En pratique, en base R, on utilise souvent un **tableau de contingence** via `xtabs()`.

---

## Pourquoi R est conçu pour cette notion

- Les **colonnes d'un `data.frame`** sont des vecteurs: R sait agréger rapidement.
- La formule `revenue ~ region + product + date` est expressive et lisible.
- Un cube permet des calculs rapides via `apply()` (marges, sous-totaux).

---

## Objet manipulé

Avec `xtabs()`, l'objet produit est un **array** (souvent de classe `xtabs`):

- `dim(cube)` : tailles des axes
- `dimnames(cube)` : modalités par axe
- `cube[i, j, k]` : cellule (région i, produit j, date k)

---

## Exemple 

```r
sales <- read.csv("TPs/r/data/sales.csv")
sales$date <- as.Date(sales$date)
sales$revenue <- sales$units * sales$price

# tilde (opérateur) agrège revenue en fonction de region, product et date
cube <- xtabs(revenue ~ region + product + date, data = sales)
class(cube)
dim(cube)
dimnames(cube)
```

---

## Lire un cube

Exemples (selon vos modalités):

```r
cube["North", "Keyboard", ]
cube["North", , ]
cube[ , "Keyboard", ]
```

Point technique: si une dimension doit rester une matrice/array, utiliser `drop = FALSE`.

---

## Marges (totaux) avec `apply()`

`apply(x, MARGIN, FUN)` agrège sur les dimensions non listées dans `MARGIN`.

Pour un cube (région × produit × date):

```r
by_region <- apply(cube, 1, sum)       # vecteur
by_product <- apply(cube, 2, sum)      # vecteur
by_date <- apply(cube, 3, sum)         # vecteur
by_region_product <- apply(cube, c(1, 2), sum)  # matrice
```

---

## De cube à table "tidy"

Pour réutiliser un cube avec des outils tabulaires, convertir en `data.frame`:

```r
cube_long <- as.data.frame(cube)
names(cube_long) <- c("region", "product", "date", "revenue_total")
head(cube_long)
```

---

## Remarques importantes

- Le cube agrège: il ne contient pas les lignes détaillées, mais des **totaux**.
- Les combinaisons absentes (aucune vente) apparaissent souvent à 0.
- Un cube peut grossir vite (produit des cardinalités): attention à la mémoire sur de gros axes.

---

## Exercices

Sujet: `Exercices/105_1_cubes.md`  
