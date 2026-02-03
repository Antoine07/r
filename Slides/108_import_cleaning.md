---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

## Définitions

- **CSV**: fichier texte tabulaire (lignes/colonnes) séparé par des virgules.
- **Parsing**: conversion d'une chaîne (texte) en type R (date, nombre…).
- **Valeur manquante (`NA`)**: absence de valeur (doit être gérée explicitement).
- **Tibble**: table tidyverse (data frame moderne) retournée par `read_csv()`.
- **`glimpse()`**: aperçu compact d'une table (fonction du package `{tibble}`).

---

## Objet de travail

On utilise en général deux objets:

- `sales_raw`: données importées (avant corrections)
- `sales`: données prêtes à analyser (types + variables dérivées)

---

## Import (readr)

`read_csv()` lit un CSV et renvoie une table (tibble).

```r
pacman::p_load(readr)

sales_raw <- read_csv("TPs/r/data/sales.csv")
sales_raw
```

---

## Import (base R)

`read.csv()` lit un CSV et renvoie un `data.frame`.

```r
sales_raw <- read.csv("TPs/r/data/sales.csv", stringsAsFactors = FALSE)
str(sales_raw)
```

Point technique: `stringsAsFactors = FALSE` évite de convertir automatiquement du texte en `factor` (des variables catégorielles).

---

## Inspecter rapidement

```r
tibble::glimpse(sales_raw)
summary(sales_raw)
```

Problèmes typiques:
- dates lues en texte
- colonnes numériques lues en texte
- valeurs manquantes

---

## Contrôles techniques (à faire tôt)

- colonnes attendues présentes (`names`, `setdiff`)
- types cohérents (`str`, `typeof`, `as.*`)
- valeurs manquantes (`is.na`, `sum`, `anyNA`)
- domaines de valeurs (ex: `units >= 0`, `price >= 0`)

Bonnes pratiques 

```r
# chercher les valeurs manquantes
required <- c("date", "region", "product", "units", "price")
# vecteur des noms de colonnes attendues dans le jeu de données

# la fonction setdiff récupère les valeurs manquantes dans le vect required
missing <- setdiff(required, names(sales_raw))
# compare les colonnes requises aux colonnes présentes dans sales_raw
# retourne les noms de colonnes absentes

if (length(missing) > 0)
  stop(paste("Colonnes manquantes:", paste(missing, collapse = ", ")))
# si au moins une colonne requise est absente, arrêt immédiat du script
# avec un message listant les colonnes manquantes

if (anyNA(sales_raw))
  message("Attention: valeurs manquantes détectées")
# teste l’ensemble du data frame
# retourne TRUE s’il existe au moins un NA, quelle que soit la colonne ou la ligne

# remarque pour NA 
sapply(df, anyNA)   # détection des NA par colonne
# retourne un vecteur logique indiquant si chaque colonne contient au moins un NA

sapply(df, 1, anyNA) # par ligne
# intention : détecter les NA par ligne
# en pratique, sapply n’est pas adapté ici pour parcourir les lignes
# apply(df, 1, anyNA) est la forme correcte pour un test ligne par ligne
```

---

## Parser une date 

On force le bon type 

```r
sales_raw$date <- as.Date(sales_raw$date)
```

---

## Types numériques

Certaines colonnes doivent être numériques pour pouvoir calculer.

- `units` : quantités
- `price` : prix

On force explicitement le type numérique.

```r
sales_raw$units <- as.numeric(sales_raw$units)
sales_raw$price <- as.numeric(sales_raw$price)
```

👉 Si une valeur ne peut pas être convertie, elle devient `NA`.

---

### Idée clé

> Mieux vaut forcer les types explicitement que laisser R deviner.

---

### À retenir pour la suite

- les calculs nécessitent des colonnes numériques
- les problèmes de type sont une source fréquente d’erreurs
- la validation détaillée sera vue plus tard

---

## Créer une variable: chiffre d'affaires

```r
sales_raw$revenue <- sales_raw$units * sales_raw$price
```

Définition: `revenue` est une **variable dérivée**, calculée à partir d'autres colonnes.

---

## Sauvegarder une version "processed"

Objectif: séparer données sources (`raw`) et données prêtes à analyser (`processed`).

```r
dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)
write.csv(sales_raw, "data/processed/sales_clean.csv", row.names = FALSE)
```

---

## Nettoyer: règles simples

- vérifier `NA`
- types corrects
- valeurs aberrantes (unités négatives, prix négatif)

```r
anyNA(sales_raw)
```

---

## Exercice (import)

Sujet: `Exercices/108_import_cleaning.md`
