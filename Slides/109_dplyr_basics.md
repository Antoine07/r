---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Annexe — `dplyr` (ancienne version)

Remplacé par `SlideR/106_data_manipulation.md` (Chapitre 4: `dplyr` + `tidyr`).

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
library(tidyverse)

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
```

---

## Filtrer / trier

```r
sales |>
  filter(region == "North", units >= 10) |>
  arrange(desc(revenue))
```

---

## `mutate()`: créer des variables

```r
sales |>
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
    n_sales = n(),
    .groups = "drop"
  )
```

---

## Agréger par date (tendance)

```r
sales |>
  group_by(date) |>
  summarise(revenue_total = sum(revenue), .groups = "drop")
```

---

## `count()` (raccourci fréquences)

```r
sales |>
  count(region, product, sort = TRUE)
```

---

## Exercice (dplyr)

Sujet: `Exercices/106_data_manipulation.md`

Notions à pratiquer:
- `select`, `filter`, `arrange`, `mutate`
- `group_by` + `summarise` (+ `.groups`)
- agrégations à 1 clé puis 2 clés
- vérifications simples (ex: aucun `NA` dans `revenue`)
