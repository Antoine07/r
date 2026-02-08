---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
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

`n()` retourne le nombre de lignes dans chaque groupe.

```r
sales |>
  group_by(region) |>
  summarise(
    n = n(), 
    revenue_total = sum(revenue),
    revenue_mean = mean(revenue)
  )
```

---

## `tidyr` — problème "wide vs long"

Beaucoup d'outils supposent une donnée "longue" (une mesure par ligne).

- **wide**: plusieurs colonnes de mesures
- **long**: une colonne `name` + une colonne `value`

---

## `pivot_longer()` 

En data, on rencontre souvent deux formats :

### Format "wide" (large)

- une colonne par période / métrique
- pratique pour lire dans un tableur
- pénible pour analyser, filtrer, regrouper

---

Ici par exemple :

- `revenue_2025`
- `revenue_2026`

### Format "long" (tidy)

- une colonne pour la dimension (année)
- une colonne pour la valeur (revenue)
- idéal pour `group_by`, `summarise`, graphiques, modèles

👉 `pivot_longer()` sert à passer **du wide vers le long**.

---

## Départ : création du tibble wide

```r
wide <- tibble::tibble(
  region = c("North", "South"),
  revenue_2025 = c(100, 80),
  revenue_2026 = c(120, 90)
)
```

Contenu (conceptuellement) :

| region | revenue_2025 | revenue_2026 |
| ------ | -----------: | -----------: |
| North  |          100 |          120 |
| South  |           80 |           90 |

👉 Les années sont "encodées" dans les noms de colonnes.

---

## Objectif : obtenir un format long

On veut arriver à quelque chose comme :

| region | year         | revenue |
| ------ | ------------ | ------: |
| North  | revenue_2025 |     100 |
| North  | revenue_2026 |     120 |
| South  | revenue_2025 |      80 |
| South  | revenue_2026 |      90 |

👉 Une ligne = une observation (région, année).

---

## Le code `pivot_longer()` ligne par ligne

```r
long <- wide |>
  tidyr::pivot_longer(
    cols = starts_with("revenue_"),
    names_to = "year",
    values_to = "revenue"
  )
```

---

### `wide |> ...`

Le pipe passe `wide` comme premier argument à `pivot_longer()` :

Équivalent :

```r
long <- tidyr::pivot_longer(
  wide,
  cols = starts_with("revenue_"),
  names_to = "year",
  values_to = "revenue"
)
```

---

### `cols = starts_with("revenue_")`

Ça dit :
👉 "Les colonnes à pivoter sont celles dont le nom commence par `revenue_`".

Donc ici, ça sélectionne :

- `revenue_2025`
- `revenue_2026`

La colonne `region` n’est **pas pivotée** : elle est conservée comme identifiant.

---

### `names_to = "year"`

Quand on pivote, les **noms des colonnes** pivotées deviennent des **valeurs**.

👉 Ici, les noms `revenue_2025` et `revenue_2026` vont être stockés dans une nouvelle colonne appelée `year`.

Donc `year` contient pour l’instant :

- `"revenue_2025"`
- `"revenue_2026"`

(ce n’est pas encore "2025" et "2026", on y reviendra).

---

### `values_to = "revenue"`

Les **valeurs** contenues dans `revenue_2025` et `revenue_2026` sont mises dans une nouvelle colonne `revenue`.

Donc `revenue` contient :

* 100, 120, 80, 90

---

##  Ce qui change en taille

Avant : 2 lignes (North, South)
Après : 4 lignes (2 régions × 2 années)

Règle générale :

> `n_lignes_final = n_lignes_initial × n_colonnes_pivotées`

Ici : `2 × 2 = 4`.

---

## Pourquoi c’est utile juste après `group_by`/`summarise`

Une fois au format long, tu peux faire :

- du `group_by(region, year)`
- des graphiques faciles
- des filtres par année
- des calculs multi-années propres

Exemple typique :

```r
long |>
  group_by(year) |>
  summarise(total_revenue = sum(revenue))
```

---

## Amélioration : extraire une vraie année

Actuellement `year` vaut `"revenue_2025"`. Souvent on veut `"2025"`.

Solution simple avec `names_prefix` :

```r
long <- wide |>
  tidyr::pivot_longer(
    cols = starts_with("revenue_"),
    names_to = "year",
    names_prefix = "revenue_",
    values_to = "revenue"
  )
```

Là `year` devient `"2025"` et `"2026"`.

```r
long <- long |>
  mutate(year = as.integer(year))
```

---

## Résumé à retenir

- **wide** : années dans les noms de colonnes (tableur-friendly)
- **long** : année dans une colonne (analyse-friendly)
- `pivot_longer()` :

- "colonne → lignes"
- "noms → colonne `names_to`"
- "valeurs → colonne `values_to`"

---


## Exercice (chapitre 4)

Sujet: `Exercices/106_data_manipulation.md`
