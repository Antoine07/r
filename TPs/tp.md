Parfait.
Voici un **cours structuré, cohérent et exploitable en classe**, pensé pour des **étudiants qui maîtrisent déjà les vecteurs et les structures de données** en R.
On se concentre sur **la montée en abstraction**, le **raisonnement data/métier** et les **bons patterns**.

---

# Cours — Structuration et agrégation des données en R

## Du tableau de ventes au reporting métier

---

## 1. Positionnement du cours

### Prérequis supposés

Les étudiants savent déjà :

* manipuler des **vecteurs atomiques**
* utiliser les **listes**, **data.frames**, **matrices**
* indexer (`[ ]`, `[[ ]]`)
* écrire des fonctions simples
* comprendre les `NA`, les types et les classes

👉 Ce cours **ne revient pas** sur ces bases.

### Objectif pédagogique

Apprendre à :

* **structurer des données analytiques**
* **choisir la bonne structure R**
* **agréger efficacement**
* **encapsuler un résultat métier**

---

## 2. Problème métier de référence

> *On dispose de données de ventes unitaires.
> Le métier attend un reporting synthétique du chiffre d’affaires.*

Chaque ligne correspond à une transaction :

* date
* région
* produit
* quantité
* prix unitaire

---

## 3. Typage et fiabilisation des données

### Pourquoi cette étape est non négociable

Avant toute agrégation :

* un mauvais type → un mauvais calcul
* une date en texte → un bug silencieux

### Pattern recommandé

```r
sales$date  <- as.Date(sales$date)
sales$units <- as.integer(sales$units)
sales$price <- as.numeric(sales$price)

stopifnot(!any(is.na(sales$date)))
stopifnot(!any(is.na(sales$units)))
stopifnot(!any(is.na(sales$price)))
```

### Message clé

> **Un pipeline data commence toujours par sécuriser les types.**

---

## 4. Calcul d’une mesure métier

### Définition

Le chiffre d’affaires est une **mesure dérivée**.

```r
sales$revenue <- sales$units * sales$price
```

### Règle

* ne jamais recalculer la même métrique plus tard
* l’ajouter explicitement au jeu de données

---

## 5. Pourquoi un array pour l’analyse ?

### Limite du data.frame

Un `data.frame` est :

* excellent pour le stockage
* moins adapté à l’agrégation multidimensionnelle

### Concept clé : le cube analytique

Un cube permet de croiser :

* région
* produit
* date

👉 **Structure naturelle : array 3D**

---

## 6. Construction du cube avec `xtabs`

```r
cube <- xtabs(revenue ~ region + product + date, data = sales)
```

### Ce que fait `xtabs`

* agrège automatiquement
* produit un `array`
* nomme les dimensions

### Inspection systématique

```r
class(cube)
dim(cube)
dimnames(cube)
```

### Message clé

> `xtabs()` est un pont entre données tabulaires et structures analytiques.

---

## 7. Agrégation à partir du cube

### Pourquoi ne plus revenir au data.frame ?

* le cube est déjà agrégé
* toute information est contenue dedans

---

### Agrégations simples avec `apply()`

```r
by_region  <- apply(cube, 1, sum)
by_product <- apply(cube, 2, sum)
by_date    <- apply(cube, 3, sum)
```

### Agrégation multi-dimensionnelle

```r
by_region_product <- apply(cube, c(1, 2), sum)
```

### Message clé

> `apply()` sert à **plier une dimension d’un array**.

---

## 8. Encapsulation dans un objet métier

### Problème classique

* résultats dispersés
* variables globales
* contexte perdu

### Solution : une liste structurée

```r
report <- list(
  cube = cube,
  by_region = by_region,
  by_product = by_product,
  by_date = by_date,
  by_region_product = by_region_product
)
```

---

## 9. Ajouter du contexte (attributs et classe)

### Métadonnées

```r
attr(report, "generated_at") <- Sys.time()
attr(report, "source") <- "TPs/r/data/sales.csv"
```

### Classe métier

```r
class(report) <- "sales_report"
```

### Pourquoi une classe ?

* donner du sens
* préparer des méthodes (`print`, `summary`)
* sécuriser l’usage futur

---

## 10. Passage à l’industrialisation : la fonction

### Objectif

Passer du script :

* à une **brique réutilisable**

### Signature

```r
build_sales_report <- function(sales) { ... }
```

### Responsabilités de la fonction

* validation des colonnes
* typage
* calcul
* agrégation
* encapsulation

### Message clé

> Une fonction métier ≠ un script collé dans une fonction.

---

## 11. Ce que les étudiants doivent retenir

### Choix de structures

* `data.frame` → stockage
* `array` → analyse multidimensionnelle
* `list` → encapsulation
* `class` → sens métier

### Raisonnement

> Données → structure → agrégation → objet métier

---

## 12. Ouverture (discussion)

* Quand préférer `dplyr` à `xtabs` ?
* Pourquoi les moteurs OLAP reposent sur des cubes ?
* Comment sérialiser ce `report` ?
* Comment ajouter une dimension (ex : canal de vente) ?

---

## Conclusion

Ce cours n’est pas un cours de syntaxe R.
C’est un cours sur **la structuration de l’analyse**.

> **R est intéressant quand on l’utilise pour penser la donnée, pas juste la manipuler.**
