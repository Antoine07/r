---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Dataviz avec `ggplot2`

Les exemples utilisent `mtcars`, un jeu de données inclus par défaut dans R.

---

## Données d'exemple — `mtcars`

`mtcars` décrit des caractéristiques de voitures :

- consommation `mpg`
- poids `wt`
- puissance `hp`
- nombre de cylindres `cyl`
- type de transmission `am`

Certaines variables sont **numériques** mais représentent des **groupes**.

---

## Préparer les données

```r
library(tidyverse)

data(mtcars)

cars <- mtcars |>
  tibble::as_tibble(rownames = "model") |>
  mutate(
    cyl = factor(cyl),
    am  = factor(am, labels = c("Automatique", "Manuelle"))
  )

glimpse(cars)
```

---

👉

- `mtcars` est transformé en **tibble**
- les noms de lignes deviennent une variable `model`
- les variables de groupe sont converties en **facteurs**

---

## Principe de `ggplot()`

Un graphique `ggplot2` se construit **par couches** :

* `ggplot(data, aes(...))`
  → données et variables
* `+ geom_*()`
  → type de graphique
* `+ labs(...)`
  → titres et légendes

---

## Nuage de points simple

```r
ggplot(cars, aes(x = wt, y = mpg)) +
  geom_point()
```

👉 Relation entre le **poids** et la **consommation**.

---

## Mapping vs valeur fixe

* **Dans `aes()`** → dépend des données
* **Hors `aes()`** → valeur imposée

```r
ggplot(cars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(alpha = 0.8)
```

👉 La couleur dépend du **nombre de cylindres** (variable de groupe).

---

## Comptages — `geom_bar()`

`geom_bar()` compte automatiquement le nombre d'observations par catégorie.

```r
ggplot(cars, aes(x = cyl)) +
  geom_bar() +
  labs(
    title = "Nombre de voitures par cylindres",
    x = "Cylindres",
    y = "Nombre"
  )
```

👉 Chaque barre correspond au nombre de voitures par type de cylindre.

---

## Barres empilées — variable dérivée

On crée une variable catégorielle simple à partir de `mpg`.

```r
cars2 <- cars |>
  mutate(
    mpg_band = if_else(mpg >= 20, "Économe", "Gourmande")
  )
```

---

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

👉 Une barre par cylindre, découpée selon le type de consommation.

---

## Comparer des groupes — boxplots hookups

Le boxplot permet de comparer une variable numérique entre groupes.

```r
ggplot(cars, aes(x = cyl, y = mpg)) +
  geom_boxplot() +
  labs(
    title = "Consommation selon les cylindres",
    x = "Cylindres",
    y = "mpg"
  )
```

---

```r
ggplot(cars, aes(x = cyl, y = hp)) +
  geom_boxplot() +
  labs(
    title = "Puissance selon les cylindres",
    x = "Cylindres",
    y = "hp"
  )
```

👉 Les groupes sont définis par des **facteurs**.

---

## Relations — nuage de points groupé

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

👉 On observe la relation entre deux variables quantitatives, par groupe.

---

## Ajouter une tendance linéaire

Chaque groupe possède sa propre droite de régression.

```r
ggplot(cars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Tendance linéaire entre poids et consommation",
    color = "Cylindres"
  )
```

👉 La droite aide à lire la **tendance moyenne** pour chaque groupe.

---

## Règles essentielles à retenir

* Une variable de groupe → **facteur**
* `geom_bar()` → **données non agrégées**
* `geom_col()` → **données déjà agrégées**
* `geom_smooth()` applique une **transformation statistique**
* Toujours vérifier le **type des variables**

---

## Exercices — `iris`

Sujet: `Exercices/110_ggplot2_intro.md`