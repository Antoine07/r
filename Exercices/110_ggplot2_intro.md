# 110 — `ggplot2` (Iris) — Exercices + corrections

Ce fichier contient les exercices **et** leurs corrections (immédiatement sous chaque énoncé).

## Préparation

```r
library(tidyverse)

data(iris)
# iris a déjà ces colonnes :
# Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, Species
glimpse(iris)
```

---

## Partie 1 – Comptages (barres)

### Exercice 1.1 – Nombre de fleurs par espèce

1. Compter combien d'observations il y a par `Species`.  

Correction :

```r
# Option dplyr (recommandé)
iris |>
  count(Species)

# Option base R (équivalent)
as.data.frame(table(iris$Species))
```

---

### Exercice 1.2 – Barres empilées (seuil sur la longueur de pétale)

1. Créer une nouvelle variable `petal_long` qui vaut `"Longue"` si `Petal.Length >= 4` sinon `"Courte"`.  
2. Faire un graphique en barres empilées du nombre de fleurs par espèce et type de pétale (`petal_long`).

Correction :

```r
iris2 <- iris |>
  mutate(
    petal_long = if_else(Petal.Length >= 4, "Longue", "Courte")
  )

ggplot(iris2, aes(x = Species, fill = petal_long)) +
  geom_bar() +
  labs(
    title = "Répartition des pétales courts/longs par espèce",
    x = "Espèce",
    y = "Nombre de fleurs",
    fill = "Type de pétale"
  )
```

---

## Partie 2 – Boxplots (distributions)

### Exercice 2.1 – Longueur de sépale par espèce

1. Tracer un boxplot de `Sepal.Length` en fonction de `Species`.  
2. Ajouter un titre et des labels d'axes.

Correction :

```r
ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_boxplot() +
  labs(
    title = "Longueur de sépale par espèce",
    x = "Espèce",
    y = "Longueur de sépale"
  )
```

---

### Exercice 2.2 – Largeur de pétale par espèce

Même chose avec `Petal.Width`.

Correction :

```r
ggplot(iris, aes(x = Species, y = Petal.Width)) +
  geom_boxplot() +
  labs(
    title = "Largeur de pétale par espèce",
    x = "Espèce",
    y = "Largeur de pétale"
  )
```

---

## Partie 3 – Relations (nuages de points)

### Exercice 3.1 – Séparation des espèces par les pétales

1. Tracer `Petal.Length` (x) vs `Petal.Width` (y).  
2. Colorer les points par `Species`.  
3. Ajouter un titre et des labels d'axes.

Correction :

```r
ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point(alpha = 0.8) +
  labs(
    title = "Pétales: Petal.Length vs Petal.Width",
    x = "Longueur de pétale",
    y = "Largeur de pétale",
    color = "Espèce"
  )
```

---

### Exercice 3.2 – Ajouter une tendance (option simple)

1. Reprendre l’exercice 3.1.  
2. Ajouter une courbe de tendance par espèce avec `geom_smooth(method = "lm", se = FALSE)`.

Correction :

```r
ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Relation longueur/largeur de pétale (tendance linéaire par espèce)",
    x = "Longueur de pétale",
    y = "Largeur de pétale",
    color = "Espèce"
  )
```

---

### Exercice 3.3 – Règle simple: isoler `setosa`

Contexte d’analyse: visuellement, `setosa` est souvent très séparée par les pétales.

1. Sur le graphique de l’exercice 3.1, ajouter:
   - une ligne verticale `Petal.Length = 2`
   - une ligne horizontale `Petal.Width = 0.8`
2. Interpréter en 2 phrases: est-ce cohérent avec la séparation observée ?

Correction :

```r
ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point(alpha = 0.8) +
  geom_vline(xintercept = 2, linetype = "dashed") +
  geom_hline(yintercept = 0.8, linetype = "dashed") +
  labs(
    title = "Séparation simple de setosa (seuils sur les pétales)",
    x = "Longueur de pétale",
    y = "Largeur de pétale",
    color = "Espèce"
  )
```

---

## Partie 4 – Histogrammes et densités

### Exercice 4.1 – Histogramme de la longueur de sépale

1. Faire un histogramme de `Sepal.Length` pour toutes les fleurs.  
2. Choisir un nombre de classes (`bins`) raisonnable.

Correction :

```r
ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram(bins = 20, color = "white", fill = "steelblue") +
  labs(
    title = "Distribution de la longueur de sépale",
    x = "Longueur de sépale",
    y = "Fréquence"
  )
```

---

### Exercice 4.2 – Densité de la longueur de pétale par espèce

1. Tracer une courbe de densité de `Petal.Length`.  
2. Colorer/remplir par `Species`.

Correction :

```r
ggplot(iris, aes(x = Petal.Length, fill = Species)) +
  geom_density(alpha = 0.4) +
  labs(
    title = "Densité de la longueur de pétale par espèce",
    x = "Longueur de pétale",
    y = "Densité",
    fill = "Espèce"
  )
```

---

## Partie 5 – Facets (petits multiples)

### Exercice 5.1 – Histogrammes de longueur de sépale par espèce

1. Reprendre l'histogramme de `Sepal.Length`.  
2. Utiliser `facet_wrap(~ Species)` pour avoir un panneau par espèce.

Correction :

```r
ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram(bins = 15, color = "white", fill = "steelblue") +
  facet_wrap(~ Species) +
  labs(
    title = "Longueur de sépale, par espèce",
    x = "Longueur de sépale",
    y = "Fréquence"
  )
```

---

### Exercice 5.2 – Comparer les sépales par espèce (nuages facettés)

Contexte d’analyse: les sépales séparent moins bien les espèces que les pétales (souvent plus de recouvrement).

1. Tracer `Sepal.Length` (x) vs `Sepal.Width` (y).  
2. Utiliser `facet_wrap(~ Species)` pour obtenir un panneau par espèce.  
3. Garder la même échelle (par défaut) pour comparer les zones occupées.

Correction :

```r
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point(alpha = 0.8) +
  facet_wrap(~ Species) +
  labs(
    title = "Sépales: relation longueur/largeur (par espèce)",
    x = "Longueur de sépale",
    y = "Largeur de sépale"
  )
```

---

## Partie 6 – Synthèse

### Exercice 6.1 – Graphique au choix + interprétation

Consignes aux étudiants :

1. Choisissez une variable continue parmi `Sepal.Length`, `Sepal.Width`, `Petal.Length`, `Petal.Width`.  
2. Choisissez un type de graphique parmi : barres (sur une classe dérivée), boxplot, histogramme, densité, facets.  
3. Faites le graphique par espèce (`Species`).  
4. Écrivez 2–3 phrases pour décrire ce que vous voyez.

Exemple de correction possible (à montrer seulement après) :

```r
ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_boxplot() +
  labs(
    title = "Longueur de pétale par espèce",
    x = "Espèce",
    y = "Longueur de pétale"
  )
```
