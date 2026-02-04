---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
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

Un `tibble` est un **data.frame moderne**, fourni par le `tidyverse`.

Il respecte le même modèle tabulaire,
mais avec des **règles plus strictes**.

```r
# methode de geek à réserver pour la sandbox pas en projet
library(tidyverse)

tb <- tibble(
  region = c("North", "South"),
  units  = c(12L, 8L)
)

tb
```

Rappel dans la console `install.packages("tidyverse")` puis `renv::snapshot()`

---

## `tibble` — différences clés avec `data.frame`

Un `tibble` :

- ne convertit **jamais** automatiquement le texte en `factor` (variable catégorielle)
- n'utilise **pas de `rownames`** (noms automatiques inutiles)
- affiche un aperçu lisible
- ne tronque pas silencieusement les colonnes (affiche sans dire que tout n'est pas montré)

👉 Le comportement est **prévisible et explicite**.

---

## Exemple : import de données avec `readr`

```r
# library(tidyverse) déjà dans ce package

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

👉 Lecture naturelle : *"prendre x, puis …"*

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
# dplyr mutate est dans cette librarie, on la charge 

sales <- sales |>
  mutate(
    revenue = units * price
  )
```

👉 Lecture métier :
*"le chiffre d'affaires d'une ligne vaut quantité × prix"*

---

`mutate()` sert à **ajouter une colonne calculée** à un tableau de données (tibble / data frame).

👉 **Règle clé** : le calcul se fait **ligne par ligne**, automatiquement.

---

### Données de départ (`sales`)

Imaginons :

| product | units | price |
| ------- | ----- | ----- |
| A       | 2     | 10    |
| B       | 5     | 8     |
| C       | 1     | 20    |

---

### Code

```r
sales <- sales |>
  mutate(
    revenue = units * price
  )
```

---

### Ce que R fait en réalité

R lit **chaque ligne** et applique la formule :

- Ligne 1 → `2 * 10 = 20`
- Ligne 2 → `5 * 8 = 40`
- Ligne 3 → `1 * 20 = 20`

---

### Résultat

| product | units | price | revenue |
| ------- | ----- | ----- | ------- |
| A       | 2     | 10    | 20      |
| B       | 5     | 8     | 40      |
| C       | 1     | 20    | 20      |

👉 `revenue` est **une nouvelle colonne**, pas une variable unique.

---

## Pourquoi on dit "ligne par ligne"

Parce que :

- `units` est un **vecteur**
- `price` est un **vecteur**
- `units * price` est fait **élément par élément**

C'est **vectorisé**, pas une boucle explicite.

---

## À ne pas confondre

- ❌ `mutate()` ne résume pas les données
  (ça, c'est `summarise()`)

- ❌ `mutate()` ne crée pas une seule valeur
  (une valeur par ligne)

---

## `summarise()`

`summarise()` sert à **réduire les données** en **valeurs agrégées**.

👉 **Règle clé** : le calcul se fait **sur l'ensemble des lignes** (ou par groupe), pas ligne par ligne.

---

### `sales`

Imaginons :

| product | units | price |
| ------- | ----- | ----- |
| A       | 2     | 10    |
| B       | 5     | 8     |
| C       | 1     | 20    |

---

### Code

```r
# dplyr 
sales_summary <- sales |>
  summarise(
    total_units   = sum(units),
    total_revenue = sum(units * price),
    avg_price     = mean(price)
  )
```

---

## Ce que R fait en réalité

Il ne travaille **plus ligne par ligne** :

- `sum(units)` → 2 + 5 + 1 = **8**
- `sum(units * price)` → 20 + 40 + 20 = **80**
- `mean(price)` → (10 + 8 + 20) / 3 = **12.67**

---

## Résultat

| total_units | total_revenue | avg_price |
| ----------- | ------------- | --------- |
| 8           | 80            | 12.67     |

👉 Le tableau est **réduit à une seule ligne**.

---

## Pourquoi on dit "résumer"

Parce que :

- plusieurs lignes d'entrée
- **une ou quelques lignes en sortie**
- information **synthétique**

---

## À ne pas confondre

- ❌ `summarise()` ne crée pas une colonne par ligne
- ❌ `summarise()` ne conserve pas le détail

---

## Avec regroupement `group_by()`

```r
sales |>
  group_by(product) |>
  summarise(
    total_units = sum(units),
    total_revenue = sum(units * price)
  )
```

➡️ Résumé **par produit**, une ligne par groupe.

---

sales
┌─────────┬────────┬───────┐
│ product │ units  │ price │
├─────────┼────────┼───────┤
│ A       │   2    │  10   │
│ A       │   1    │  10   │
│ B       │   5    │   8   │
│ B       │   3    │   8   │
│ C       │   1    │  20   │
└─────────┴────────┴───────┘


---

┌─────────┬─────────────┬───────────────┐
│ product │ total_units │ total_revenue │
├─────────┼─────────────┼───────────────┤
│ A       │      3      │      30       │
│ B       │      8      │      64       │
│ C       │      1      │      20       │
└─────────┴─────────────┴───────────────┘

---

sales

```r
sales <- tibble(
  product = c("A", "A", "B", "B", "C"),
  units   = c(2, 1, 5, 3, 1),
  price   = c(10, 10, 8, 8, 20)
)

sales |>
  group_by(product) |>
  summarise(
    total_units = sum(units)
)

```

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

```r
pacman::p_load(tibble)

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
