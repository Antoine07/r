---
marp: true
theme: default
paginate: true
class: lead
---

# Chapitre 4 — Manipulation de données

À maîtriser:

- `dplyr`
- `tidyr`

---

## Pourquoi R est conçu pour ce chapitre

- L'analyse consiste souvent à enchaîner des transformations sur des tables.
- `dplyr` rend ces transformations lisibles (verbes) et reproductibles (scripts).
- `tidyr` couvre la mise en forme des tables (large/long, séparation/assemblage).

---

## Préparer une table d'exemple (`sales`)

```r
library(tidyverse)

sales <- read_csv("TPs/r/data/sales.csv") |>
  mutate(
    date = as.Date(date),
    revenue = units * price
  )
```

---

## `dplyr` — verbes essentiels

- `select`, `filter`, `arrange`
- `mutate`
- `group_by` + `summarise`

---

## `dplyr` — exemple (filtrer + trier)

```r
sales |>
  filter(region == "North", units >= 10) |>
  arrange(desc(revenue)) |>
  select(date, product, units, revenue)
```

---

## `dplyr` — exemple (agréger)

```r
sales |>
  group_by(region) |>
  summarise(
    n = n(),
    revenue_total = sum(revenue),
    revenue_mean = mean(revenue),
    .groups = "drop"
  )
```

---

## `tidyr` — problème “wide vs long”

Beaucoup d'outils supposent une donnée “longue” (une mesure par ligne).

- **wide**: plusieurs colonnes de mesures
- **long**: une colonne `name` + une colonne `value`

---

## `tidyr` — `pivot_longer`

```r
wide <- tibble::tibble(
  region = c("North", "South"),
  revenue_2025 = c(100, 80),
  revenue_2026 = c(120, 90)
)

long <- wide |>
  tidyr::pivot_longer(
    cols = starts_with("revenue_"),
    names_to = "year",
    values_to = "revenue"
  )
long
```

---

## `tidyr` — `pivot_wider`

```r
long |>
  tidyr::pivot_wider(names_from = year, values_from = revenue)
```

---

## `tidyr` — autres opérations utiles

- `separate()` / `unite()` (split/join de colonnes texte)
- `drop_na()` (supprimer lignes avec NA)
- `replace_na()` (remplacer NA)

---

## Exercice (chapitre 4)

Sujet: `Exercices/106_data_manipulation.md`

