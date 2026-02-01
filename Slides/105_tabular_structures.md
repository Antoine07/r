---
marp: true
theme: default
paginate: true
class: lead
---

# Structures tabulaires en R

Objectif du chapitre :

- comprendre les structures tabulaires en R
- savoir **quand** et **pourquoi** utiliser chacune
- éviter les comportements implicites piégeux
- préparer les chapitres d'agrégation et de reporting

---

## Panorama des structures tabulaires

En R, plusieurs structures permettent de représenter des données tabulaires.

Dans ce chapitre, nous nous concentrons sur :

- `data.frame` (base R)
- `tibble` (tidyverse)

Elles représentent **le même concept**, mais avec des **choix de conception différents**.

---

## `data.frame` — définition

Un `data.frame` est une **liste de colonnes** :

- chaque colonne est un **vecteur atomique**
- toutes les colonnes ont la **même longueur**
- chaque ligne représente une observation

```r
df <- data.frame(
  region = c("North", "South"),
  units  = c(12L, 8L),
  price  = c(49.99, 49.99)
)

str(df)
```

---

## `data.frame` — propriétés importantes

- structure tabulaire de base en R
- universellement supporté
- très flexible

Mais aussi :

⚠️ structure **historique**, avec certains comportements implicites.

---

## `data.frame` — points de vigilance

Selon la configuration de R :

- conversion automatique `character → factor`
- présence de `rownames` implicites
- comportements parfois silencieux

Exemple :

```r
df2 <- data.frame(region = c("North", "South"))
str(df2)
```

👉 Ces comportements peuvent introduire des bugs discrets en data.

---

## `data.frame` — accès et sous-ensemble

```r
df$units
df[1, ]
df[df$region == "North", ]
df[, c("region", "units")]
```

---

## Question de compréhension

```r
df[, 1:2]
```

❓ Questions :

- que retourne cette expression ?
- quel est le type de l'objet retourné ?
- pourquoi R ne retourne pas un simple vecteur ?

---

## Pourquoi une alternative au `data.frame` ?

En analyse de données moderne, on cherche :

- moins de conversions implicites
- des erreurs visibles plus tôt
- des comportements plus prévisibles
- une meilleure intégration dans des pipelines

C'est le rôle de `tibble`.

---

## `tibble` — définition

Un `tibble` est un **data.frame moderne**, fourni par le tidyverse.

Il respecte le même modèle tabulaire,
mais avec des **règles plus strictes**.

```r
if (!require("pacman", quietly = TRUE)) {
  install.packages("pacman")
}
library(pacman)

pacman::p_load(tibble)

tb <- tibble(
  region = c("North", "South"),
  units  = c(12L, 8L)
)

tb
```

---

## `tibble` — différences clés avec `data.frame`

Un `tibble` :

- ne convertit **jamais** automatiquement le texte en `factor`
- n'utilise **pas de `rownames`**
- affiche un aperçu lisible
- ne tronque pas silencieusement les colonnes

👉 Le comportement est **prévisible et explicite**.

---

## Exemple : import de données avec `readr`

```r
pacman::p_load(readr)

sales <- readr::read_csv("TPs/r/data/sales.csv")
str(sales)
```

Ce que fait `readr` :
- typage automatique contrôlé
- pas de facteurs implicites
- retour d'un `tibble`

👉 C'est le format recommandé pour les pipelines data.

---

# Construire un pipeline de données

---

## Le pipe `|>` — principe

Le pipe permet d'écrire des traitements **de gauche à droite**.

```r
result <- f(g(h(x)))
```

devient :

```r
result <- x |>
  h() |>
  g() |>
  f()
```

👉 Lecture naturelle : *“prendre x, puis …”*

---

## Pourquoi utiliser le pipe en data

- améliore la lisibilité
- évite les variables intermédiaires
- reflète un enchaînement logique de traitements
- standard moderne en R (base depuis R 4.1)

---

## `mutate()` — enrichir les données

`mutate()` sert à **créer ou modifier des colonnes** dans un tibble.

Chaque calcul est fait **ligne par ligne**.

```r
pacman::p_load(dplyr)

sales <- sales |>
  mutate(
    revenue = units * price
  )
```

👉 Lecture métier :
*“le chiffre d'affaires d'une ligne vaut quantité × prix”*

---

## `mutate()` — points importants

- retourne un **nouveau tibble**
- ne modifie pas l'objet initial par défaut
- peut créer plusieurs colonnes
- une colonne créée peut être réutilisée immédiatement

```r
sales <- sales |>
  mutate(
    revenue = units * price,
    high_value = revenue > 500
  )
```

---

## `mutate()` vs agrégation

-`mutate()` → **ajoute des colonnes**
-`summarise()` → **réduit le nombre de lignes**

👉 Toujours enrichir les données **avant** de les agréger.

---

## Pourquoi `tibble` est privilégié en data

- moins de surprises
- nettoyage plus simple
- erreurs détectées plus tôt
- meilleure lisibilité
- cohérence avec `dplyr`, `tidyr`, `readr`

👉 `tibble` est pensé pour l'analyse, pas seulement pour le stockage.

---

## Cube analytique — intuition métier

Un **cube analytique** permet d'analyser une mesure métier
selon **plusieurs axes en même temps**.

Exemples de questions auxquelles il répond :

- Quel est le chiffre d'affaires **par région et par date** ?
- Quel produit performe le mieux **selon les régions** ?
- Comment évoluent les ventes **dans le temps** ?

👉 On ne regarde plus des lignes,
👉 on regarde des **dimensions d'analyse**.

---

## Cube analytique — représentation en R

En R, un cube analytique est généralement représenté par un
**array multidimensionnel**.

```r
cube <- xtabs(revenue ~ region + product + date, data = sales)
```

- chaque axe du cube = une **dimension** (région, produit, date)
- chaque cellule = une **mesure agrégée** (ici : le CA)

À partir du cube, on peut :

- agréger par région, produit ou date
- construire des indicateurs de pilotage
- alimenter un reporting ou un tableau de bord

👉 Le cube est **dérivé des données brutes**,
👉 pas une structure de stockage primaire.

---

## Exercice

`Exercices/105_tabular_structures.md`

