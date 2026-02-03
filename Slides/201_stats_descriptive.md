---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Jour 2 — Stats descriptives (bases)

Objectif: résumer une variable et comparer des groupes.

---

## Définitions

- **Observation**: une ligne de données (une vente).
- **Variable**: une colonne (ex: `revenue`, `region`).
- **Variable quantitative**: numérique (ex: `revenue`).
- **Distribution**: ensemble des valeurs d'une variable (forme globale).
- **Statistique descriptive**: mesure calculée sur les données (moyenne, médiane…).

---

## Pourquoi R est conçu pour cette étape

- La statistique descriptive est au cœur de R (fonctions natives: `mean`, `median`, `sd`, `quantile`).
- L'analyse se fait directement sur des vecteurs et des tables (vectorisation, agrégation par groupe).

---

## Objet utilisé (`sales`)

`sales` désigne une table (data frame/tibble) contenant au moins `revenue` et `region`.

Exemple de préparation:

```r
library(tidyverse)

sales <- read_csv("TPs/r/data/sales.csv") |>
  mutate(
    date = as.Date(date),
    revenue = units * price
  )
```

---

## `NA` (valeurs manquantes)

Par défaut, beaucoup de fonctions renvoient `NA` si le vecteur contient des `NA`.

```r
mean(c(1, NA, 3))
mean(c(1, NA, 3), na.rm = TRUE)
```

---

## Mesures centrales

- **moyenne**: somme / nombre d'observations → `mean(x)`
- **médiane**: valeur centrale → `median(x)`

```r
mean(sales$revenue)
median(sales$revenue)
```

---

## Dispersion

- **variance**: dispersion quadratique → `var(x)`
- **écart-type**: racine de la variance → `sd(x)`
- **quantiles**: seuils (25%, 50%, 75%…) → `quantile(x, probs = ...)`

```r
sd(sales$revenue)
quantile(sales$revenue, probs = c(0.25, 0.5, 0.75))
```

---

## Résumé par groupe (dplyr)

Définition: un **groupe** est une catégorie (ex: une région) pour laquelle on calcule des indicateurs.

```r
sales |>
  group_by(region) |>
  summarise(
    n = n(),
    mean_revenue = mean(revenue),
    median_revenue = median(revenue),
    sd_revenue = sd(revenue),
    .groups = "drop"
  )
```

---

## Variante base R (agrégation)

```r
aggregate(revenue ~ region, data = sales, FUN = mean)
```

---

## Visualiser une distribution

Histogramme:

```r
ggplot(sales, aes(x = revenue)) +
  geom_histogram(bins = 30)
```

Boxplot par groupe:

```r
ggplot(sales, aes(x = region, y = revenue)) +
  geom_boxplot()
```

---

## Exercice (descriptif)

Sujet: `Exercices/201_stats_descriptive.md`

Notions à pratiquer:
- mesures centrales et dispersion (+ `na.rm`)
- agrégations par groupe (dplyr et/ou base R)
- histogramme et boxplot (lecture + interprétation)
