---
marp: true
theme: default
paginate: true
class: lead
---

# Dataviz avec `ggplot2`

Objectif: des graphiques clairs, interprétables, et reproductibles.

---

## Définitions

- **Data frame / tibble**: table utilisée comme source de données.
- **`ggplot(data, aes(...))`**: initialise un graphique avec des données et des mappings.
- **Aesthetics (`aes`)**: correspondances entre variables et propriétés visuelles (x, y, couleur…).
- **Geom (`geom_*`)**: couche géométrique (points, lignes, barres…).
- **Facette (`facet_*`)**: petits multiples (un panneau par groupe).

---

## Pourquoi R est conçu pour cette étape

- `ggplot2` implémente la *grammar of graphics*: une façon cohérente de construire des graphiques.
- Les graphes partent d'une table et restent reproductibles (code → figure).
- Les mêmes données peuvent être déclinées en plusieurs vues sans copier/coller.

---

## Pré-requis (objet `sales`)

Les exemples supposent un objet `sales` avec une colonne `revenue`.

```r
library(tidyverse)

sales <- read_csv("TPs/r/data/sales.csv") |>
  mutate(
    date = as.Date(date),
    revenue = units * price
  )
```

---

## Rappel: le modèle ggplot

- `ggplot(data, aes(...))` = données + mapping
- `geom_*` = forme (points, barres, lignes…)
- `labs(...)` = titres/axes
- `theme_*` = style

---

## Mapping vs valeur constante

- Dans `aes(...)`: la propriété dépend d'une variable (mapping).
- En dehors de `aes(...)`: la propriété est constante.

```r
ggplot(sales, aes(x = units, y = revenue)) +
  geom_point(color = "steelblue", alpha = 0.6)
```

---

## Exemple: CA dans le temps (ligne)

```r
sales_daily <- sales |>
  group_by(date) |>
  summarise(revenue_total = sum(revenue), .groups = "drop")

ggplot(sales_daily, aes(x = date, y = revenue_total)) +
  geom_line() +
  labs(title = "Chiffre d'affaires par jour", x = "Date", y = "CA")
```

Définition: `sales_daily` est une table agrégée (une ligne par date).

---

## Exemple: CA par région (barres)

```r
sales_by_region <- sales |>
  group_by(region) |>
  summarise(revenue_total = sum(revenue), .groups = "drop")

ggplot(sales_by_region, aes(x = region, y = revenue_total)) +
  geom_col() +
  labs(title = "CA par région", x = "Région", y = "CA")
```

---

## Facets (petits multiples)

```r
ggplot(sales, aes(x = date, y = revenue, color = product)) +
  geom_point(alpha = 0.6) +
  facet_wrap(~ region)
```

---

## Export (fichier image)

```r
p <- ggplot(sales_by_region, aes(x = region, y = revenue_total)) +
  geom_col()

ggsave("output/figures/ca_par_region.png", p, width = 8, height = 4)
```

---

## Exercice (dataviz)

Sujet: `Exercices/110_ggplot2_intro.md`

Notions à pratiquer:
- `aes` (mapping) vs paramètres constants
- `geom_point`, `geom_line`, `geom_col`
- tables agrégées vs données brutes
- `facet_wrap` et légendes
- `ggsave` (export reproductible)

---

## Fin Jour 1 (checklist)

- importer un CSV
- transformer avec `dplyr`
- produire 2–3 graphiques simples avec `ggplot2`
