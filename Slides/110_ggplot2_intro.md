---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Dataviz avec `ggplot2`

**Objectif**
Apprendre à construire des graphiques simples avec `ggplot2`.

Les exemples utilisent `mtcars`, un jeu de données déjà inclus dans R.

---

## Données d'exemple — `mtcars`

`mtcars` décrit des voitures :

- consommation (`mpg`)
- poids (`wt`)
- puissance (`hp`)
- nombre de cylindres (`cyl`)
- type de transmission (`am`)

---

```r
library(tidyverse)

data(mtcars)

cars <- mtcars |>
  tibble::as_tibble(rownames = "model") # transforme mtcars un dataframe en tibble

glimpse(cars)
```

👉 On se contente ici de rendre les données plus lisibles.
Aucune transformation "avancée".

---

## Le principe de `ggplot()`

Un graphique `ggplot2` se construit **par couches**.

- `ggplot(data, aes(...))`
  → quelles données et quelles variables
- `+ geom_*()`
  → quel type de graphique
- `+ labs(...)`
  → titres et légendes

```r
# nuage de point mpg = miles per gallon et wt = weight 
ggplot(cars, aes(x = wt, y = mpg)) +
  geom_point()
```

👉 Relation entre le poids et la consommation.

---

## Mapping vs valeur fixe

- **Dans `aes()`** : dépend des données
- **Hors `aes()`** : valeur imposée

```r
# cyl contient des valeurs (4, 6, 8) ggplot2 attribue une couleur différente à chaque valeur
ggplot(cars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(alpha = 0.8)
```

👉 La couleur dépend du nombre de cylindres.

---

## Comptages — `geom_bar()`

`geom_bar()` compte automatiquement le nombre de lignes par catégorie.

```r
cars |>
  group_by(cyl) |>
  summarise(n = n()) # rappel n() compte le nombre de lignes 

# Une autre manière de faire ça plus rapide 
cars |>
  count(cyl)
```

```r
ggplot(cars, aes(x = cyl)) +
  geom_bar() +
  labs(
    title = "Nombre de voitures par cylindres",
    x = "Cylindres",
    y = "Nombre"
  )
```

👉 Chaque barre correspond à un nombre de voitures.

---

## Barres empilées — variable dérivée

On crée une nouvelle colonne simple pour classer les voitures.

```r
cars2 <- cars |>
  mutate(
    mpg_band = if_else(mpg >= 20, "Économe", "Gourmande")
  )
```

```r
ggplot(cars2, aes(x = cyl, fill = mpg_band)) +
  geom_bar() +
  labs(
    title = "Consommation par cylindres",
    x = "Cylindres",
    y = "Nombre",
    fill = "Type"
  )
```

👉 Une même barre, découpée en sous-catégories.

---

## Comparer des groupes — `geom_boxplot()`

Le boxplot permet de comparer des valeurs entre groupes.

boxplot = diagramme à moustache 

Utilisez `factor` pour créer des groupes, sinon la variable x sera considérée comme une variable continue par ggplot.

```r
ggplot(cars, aes(x = factor(cyl), y = mpg)) +
  geom_boxplot() +
  labs(
    title = "Consommation selon les cylindres",
    x = "Cylindres",
    y = "mpg"
  )
```

```r
ggplot(cars, aes(x = factor(cyl), y = hp)) +
  geom_boxplot() +
  labs(
    title = "Puissance selon les cylindres",
    x = "Cylindres",
    y = "hp"
  )
```

---

## Relations — nuage de points

```r
ggplot(cars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(alpha = 0.8) +
  labs(
    title = "Consommation en fonction du poids",
    x = "Poids",
    y = "mpg",
    color = "Cylindres"
  )
```

👉 On observe si deux variables évoluent ensemble.

---

## Ajouter une tendance simple

```r
ggplot(cars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Tendance linéaire entre poids et consommation"
  )
```

👉 La droite aide à lire la tendance générale.

---

## Exercices — `iris`

Les exercices reprennent **exactement les mêmes idées** :
