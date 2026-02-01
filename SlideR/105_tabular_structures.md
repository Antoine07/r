---
marp: true
theme: default
paginate: true
class: lead
---

# Structures tabulaires

À maîtriser:

- `data.frame`
- `tibble`
- `data.table`

---

## `data.frame` — définition

Un `data.frame` est une liste de colonnes (vecteurs atomique) de même longueur.

```r
df <- data.frame(
  region = c("North", "South"),
  units = c(12L, 8L),
  price = c(49.99, 49.99),
  stringsAsFactors = FALSE
)
str(df)
```

---

## `data.frame` — accès et sous-ensemble

```r
df$units
df[1, ]
df[df$region == "North", ]
df[, c("region", "units")]
```

---

## `tibble` — définition

Un tibble est un data frame "moderne" (tidyverse):

- affichage plus lisible
- comportements plus stricts (moins de conversions implicites)

```r
# nécessite le package tibble
tibble::tibble(region = c("North", "South"), units = c(12L, 8L))
```

---

## `tibble` — point technique

- pas de conversion automatique texte → factor
- pas de rownames par défaut

```r
sales <- readr::read_csv("TPs/r/data/sales.csv")
class(sales)
```

---

## `data.table` — définition

`data.table` est une implémentation orientée performance, avec une syntaxe dédiée.

Point technique important: modifications souvent **par référence** (in-place).

```r
# nécessite le package data.table
DT <- data.table::as.data.table(df)
DT[, revenue := units * price]
DT[]
```

---

## `data.table` — agrégation

```r
DT[, .(revenue_total = sum(revenue)), by = region]
```

---

## Choisir (règle simple)

- `data.frame`: base R, universel
- `tibble`: tidyverse, confortable pour analyse/reporting
- `data.table`: performance et syntaxe spécifique

---

## Exercice (chapitre 3)

Sujet: `Exercices/105_tabular_structures.md`

