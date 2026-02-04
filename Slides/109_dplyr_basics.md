---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Annexe — `dplyr` 

Objectif: passer d'une table brute à des indicateurs.

---

## Définitions

- **`dplyr`**: package de manipulation de tables (data frames / tibbles).
- **Verbe**: fonction qui transforme une table et renvoie une table.
- **Pipe `|>`**: envoie le résultat à gauche comme 1er argument à droite.
- **`group_by()`**: définit des groupes (clés) pour les agrégations.
- **`summarise()`**: calcule des indicateurs par groupe (une ligne par groupe).

---

## Pourquoi R est conçu pour cette étape

- Les analyses data reposent sur des opérations répétitives sur des tables: filtrer, créer des variables, agréger.
- `dplyr` rend ces transformations **déclaratives** et lisibles (suite de verbes).
- Le pipe `|>` met en avant le flux: “table → table → table”.

---

## `dplyr`: verbes clés

- `select()` colonnes
- `filter()` lignes
- `mutate()` nouvelles colonnes
- `arrange()` trier
- `group_by()` + `summarise()` agréger

---

## Préparer les données

```r
pacman::p_load(dplyr, tidyverse)

sales <- read_csv("TPs/r/data/sales.csv") |>
  mutate(
    date = as.Date(date),
    revenue = units * price
  )
```

Définition: `sales` est une tibble (data frame) et `revenue` une variable dérivée.

---

## `select()`: choisir des colonnes

```r
sales |>
  select(date, region, product, revenue)

# le pipe fait ça : select(sales, date, region, product, revenue)
```

---

## Filtrer / trier

```r
sales |>
  filter(region == "North", units >= 10) |>
  arrange(desc(revenue)) # ordonne par ordre décroissant par défaut croissant arrange
```

---

## `mutate()`: créer des variables

```r
# on enregistre ces nouvelles colonnes dans sales
sales <- sales |>
  mutate(
    is_bulk = units >= 20,
    ticket = if_else(revenue >= 500, "HIGH", "LOW")
  )
```

Point technique: `if_else` (tidyverse) garde des types plus stricts que `ifelse`.

---

## Agréger (GROUP BY)

CA par région:

```r
sales |>
  group_by(region) |>
  summarise(
    revenue_total = sum(revenue),
    n_sales = n()
  )
```

---

## Agréger par date (tendance)

```r
sales |>
  group_by(date) |>
  summarise(revenue_total = sum(revenue))
```

---

## `count()` (raccourci fréquences)

```r
sales |>
  count(region, product, sort = TRUE)
```

---

## Appliquer un calcul à plusieurs colonnes : `across()`

Quand on agrège des données, on veut souvent appliquer **le même calcul à plusieurs colonnes**  
(ex : moyenne de toutes les variables numériques).

`dplyr` fournit pour cela la fonction **`across()`**, utilisée dans `summarise()` ou `mutate()`.

```r
summarise(
  across(colonnes, fonction)
)
```

Lecture :

> *Pour chaque colonne sélectionnée, appliquer cette fonction.*

---

### Sélection automatique de colonnes : `where()`

`where()` permet de sélectionner des colonnes **selon leur type** ou une condition.

Exemple :

```r
summarise(
  across(where(is.numeric), mean)
)
```

Interprétation :

- `where(is.numeric)` → toutes les colonnes numériques
- `mean` → fonction appliquée à chacune
- une colonne de sortie par variable

---

### Exemple complet

```r
iris |>
  summarise(
    across(where(is.numeric), mean)
  )
```

➡️ Calcule la moyenne de toutes les variables numériques du jeu de données.
