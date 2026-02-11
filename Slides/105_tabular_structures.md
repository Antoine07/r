---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Structures tabulaires en R (avec tibble)

Objectif du chapitre :

- comprendre ce qu'est une **structure tabulaire**
- manipuler des données sous forme de **tables**
- écrire des traitements lisibles et prévisibles
- préparer les chapitres d'agrégation et de reporting

---

## Une structure tabulaire

En analyse de données, on manipule des **tables** :

- des **lignes** : observations
- des **colonnes** : variables
- chaque colonne a un **type**
- toutes les colonnes ont la même longueur

👉 En R moderne, cette structure s'appelle un **tibble**.

---

## `tibble` — définition

Un `tibble` est une **table de données moderne** pour R.

- chaque colonne est un **vecteur**
- chaque ligne est une **observation**
- comportement **explicite et prévisible**
- pensé pour l'analyse de données

```r
library(tibble)

sales <- tibble(
  region = c("North", "South"),
  units  = c(12L, 8L),
  price  = c(49.99, 49.99)
)

sales
```

---

## Pourquoi utiliser `tibble`

Un `tibble` :

- ne modifie pas les types sans le dire
- ne crée pas de variables implicites
- affiche un aperçu lisible
- signale clairement ce qui est montré ou non

👉 Moins de surprises, plus de contrôle.

---

## Accéder aux données d'un tibble

```r
sales$units          # colonne
sales[1, ]           # ligne
sales[, c("region", "units")]
sales[sales$region == "North", ]
```

👉 La logique est **identique** à une table classique.

---

## Importer des données : format standard

Les outils d'import modernes retournent directement des `tibble`.

```r
library(readr)

sales <- read_csv("TPs/r/data/sales.csv")
sales
```

Ce que fait `readr` :

- typage automatique visible
- pas de conversions implicites
- retour systématique d'un `tibble`

---

# Construire un pipeline de données

---

## Le pipe `|>` — principe

Le pipe permet d'enchaîner des traitements
**de gauche à droite**.

```r
result <- x |>
  f() |>
  g() |>
  h()
```

👉 Lecture naturelle :

> prendre x, puis faire f, puis g, puis h

---

## Pourquoi utiliser le pipe

- code plus lisible
- moins de variables intermédiaires
- enchaînement logique clair
- standard moderne de R (base)

---

## `mutate()` — enrichir un tibble

`mutate()` sert à **ajouter ou modifier des colonnes**.

```r
library(dplyr)

sales <- sales |>
  mutate(
    revenue = units * price
  )
```

👉 Le calcul est fait **ligne par ligne**.

---

## Pourquoi on dit « ligne par ligne »

Parce que :

- `units` est un vecteur
- `price` est un vecteur
- le calcul est fait **élément par élément**

C'est du **calcul vectorisé**, pas une boucle.

---

## À ne pas confondre

- ❌ `mutate()` ne résume pas les données
- ❌ `mutate()` ne produit pas une seule valeur

Chaque ligne garde sa propre valeur.

---

## `summarise()` — réduire les données

`summarise()` sert à **calculer des valeurs globales**.

```r
sales_summary <- sales |>
  summarise(
    total_units   = sum(units),
    total_revenue = sum(units * price),
    avg_price     = mean(price)
  )
```

👉 Plusieurs lignes → une ligne de synthèse.

---

## Différence clé

| Fonction      | Effet                      |
| ------------- | -------------------------- |
| `mutate()`    | ajoute des colonnes        |
| `summarise()` | réduit le nombre de lignes |

---

## Regrouper avec `group_by()`

```r
sales |>
  group_by(product) |>
  summarise(
    total_units = sum(units),
    total_revenue = sum(units * price)
  )
```

👉 Une ligne de résultat **par groupe**.

---

## Exemple complet

```r
sales <- tibble(
  product = c("A", "A", "B", "B", "C"),
  units   = c(2, 1, 5, 3, 1),
  price   = c(10, 10, 8, 8, 20)
)

sales |>
  group_by(product) |>
  summarise(
    total_units = sum(units),
    total_revenue = sum(units * price)
  )
```

---

## Pourquoi `tibble` est le standard en data

- comportement explicite
- pipelines plus lisibles
- intégration naturelle avec :

  - `dplyr`
  - `tidyr`
  - readr`
- adapté aux analyses réelles

👉 C'est le format de travail courant en data.

---

```r
library(tibble)

sales <- tibble(
  region  = c("EU", "EU", "EU", "US", "US", "US"),
  product = c("A",  "A",  "B",  "A",  "B",  "B"),
  date    = as.Date(c(
    "2024-01-01",
    "2024-01-01",
    "2024-01-01",
    "2024-01-02",
    "2024-01-02",
    "2024-01-02"
  )),
  revenue = c(100, 50, 80, 120, 60, 40)
)
```

---

## Exercice

`Exercices/105_tabular_structures.md`

