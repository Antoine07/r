# 112 — Étude de cas : prix des diamants

## Stats + graphiques avec variables catégorielles

**Objectif**
Réaliser une **analyse exploratoire complète** :

* comprendre les données
* traiter correctement les variables catégorielles
* combiner **statistiques descriptives** et **graphiques**

---

## Contexte métier (important)

On dispose d’un jeu de données sur des **diamants** vendus sur un marché.

Questions typiques :

* Quels facteurs influencent le **prix** ?
* Certaines catégories sont-elles **plus chères en moyenne** ?
* Les distributions sont-elles homogènes ?

👉 Cas très proche d’une analyse produit / pricing.

---

## Données — `diamonds`

Le dataset est inclus dans `ggplot2`.

```r
library(tidyverse)

data(diamonds)

dia <- diamonds |> 
  as_tibble() |> 
  mutate(
    cut = factor(cut),
    color = factor(color),
    clarity = factor(clarity)
  )

glimpse(dia)
```

---

## Variables clés

* `price` : prix en dollars (numérique)
* `carat` : poids du diamant (numérique)
* `cut` : qualité de la taille (catégorielle)
* `color` : couleur (catégorielle)
* `clarity` : pureté (catégorielle)

👉 **Plusieurs variables codent des catégories** → `factor()` indispensable.

---

## Taille des groupes (comptages)

### Question

Certaines catégories sont-elles sur-représentées ?

```r
dia |> 
  count(cut)
```

```r
ggplot(dia, aes(x = cut)) +
  geom_bar() +
  labs(
    title = "Répartition des diamants par type de taille",
    x = "Qualité de la taille",
    y = "Nombre"
  )
```

---

## Comparer deux catégories — `cut` × `color`

```r
dia |>
  count(cut, color)
```

```r
ggplot(dia, aes(x = cut, fill = color)) +
  geom_bar(position = "fill") +
  labs(
    title = "Répartition des couleurs selon la taille",
    x = "Qualité de la taille",
    y = "Proportion",
    fill = "Couleur"
  )
```

👉 Lecture en **proportion**, pas en volume.

---

## Statistiques descriptives par groupe

### Question

Les diamants mieux taillés sont-ils plus chers en moyenne ?

```r
dia |>
  group_by(cut) |>
  summarise(
    n = n(),
    price_mean = mean(price),
    price_median = median(price),
    price_sd = sd(price),
    .groups = "drop"
  )
```

👉 Attention : **moyenne ≠ médiane** → distributions asymétriques.

---

## Comparer les distributions — boxplots

```r
ggplot(dia, aes(x = cut, y = price)) +
  geom_boxplot() +
  labs(
    title = "Distribution des prix selon la qualité de la taille",
    x = "Qualité de la taille",
    y = "Prix"
  )
```

Lecture :

* dispersion
* asymétrie
* valeurs extrêmes

---

## Stratifier par une autre catégorie

```r
ggplot(dia, aes(x = cut, y = price, fill = color)) +
  geom_boxplot(alpha = 0.6, outlier.size = 0.5) +
  labs(
    title = "Prix des diamants par taille et couleur",
    x = "Qualité de la taille",
    y = "Prix",
    fill = "Couleur"
  )
```

👉 Même analyse, mais **plus fine**.

---

## Relation entre deux variables numériques

### Question

Le prix augmente-t-il avec le poids ?

```r
ggplot(dia, aes(x = carat, y = price)) +
  geom_point(alpha = 0.3) +
  labs(
    title = "Prix en fonction du poids",
    x = "Carat",
    y = "Prix"
  )
```

---

## Relation + groupe catégoriel

```r
ggplot(dia, aes(x = carat, y = price, color = cut)) +
  geom_point(alpha = 0.4) +
  labs(
    title = "Prix vs carat, coloré par qualité de taille",
    x = "Carat",
    y = "Prix",
    color = "Taille"
  )
```

---

## Ajouter une tendance simple

```r
ggplot(dia, aes(x = carat, y = price, color = cut)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Tendance prix ~ carat selon la taille"
  )
```

👉 Lecture comparative des pentes.

---

## Analyse par sous-ensembles — `facet_wrap()`

```r
ggplot(dia, aes(x = carat, y = price)) +
  geom_point(alpha = 0.3) +
  facet_wrap(~ cut) +
  labs(
    title = "Relation prix / carat par qualité de taille",
    x = "Carat",
    y = "Prix"
  )
```

---

## Synthèse de l’étude

* Les variables catégorielles doivent être **explicitement déclarées**
* Les prix varient fortement selon :

  * le poids
  * la qualité
* Les distributions sont :

  * asymétriques
  * sensibles aux valeurs extrêmes
* Les graphiques complètent les tableaux statistiques

---

## Exercices proposés

1. Comparer `price` selon `clarity`
2. Visualiser la distribution de `carat` par `cut`
3. Calculer le prix moyen par `cut` et `clarity`
4. Refaire un graphique en proportions (`position = "fill"`)

---

## Message pédagogique final

> Une bonne analyse exploratoire repose autant sur la **bonne typologie des variables** que sur les graphiques.

---

Si tu veux, je peux maintenant :

* transformer cette étude en **TP guidé**
* fournir une **correction détaillée**
* ou l’adapter à un **contexte entreprise précis** (pricing, marketing, qualité produit)
