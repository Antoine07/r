---
marp: true
theme: default
paginate: true
class: lead
---

# Importer & nettoyer un CSV

Fil rouge: `TPs/r/data/sales.csv`

---

## Définitions

- **CSV**: fichier texte tabulaire (lignes/colonnes) séparé par des virgules.
- **Parsing**: conversion d'une chaîne (texte) en type R (date, nombre…).
- **Valeur manquante (`NA`)**: absence de valeur (doit être gérée explicitement).
- **Tibble**: table tidyverse (data frame moderne) retournée par `read_csv()`.
- **`glimpse()`**: aperçu compact d'une table (fonction du package `{tibble}`).

---

## Pourquoi R est conçu pour cette étape

- Lire et manipuler des tables (`data.frame` / tibble) est un usage central en R.
- Le langage fournit des fonctions natives de parsing/contrôle (`as.*`, `is.*`, `NA`, `stopifnot`).
- Les packages standard data (ex: `readr`) automatisent l’import tout en restant reproductibles.

---

## Objet de travail

On utilise en général deux objets:

- `sales_raw`: données importées (avant corrections)
- `sales`: données prêtes à analyser (types + variables dérivées)

---

## Import (readr)

`read_csv()` lit un CSV et renvoie une table (tibble).

```r
library(readr)

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

Point technique: `stringsAsFactors = FALSE` évite de convertir automatiquement du texte en `factor`.

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

Exemples:

```r
required <- c("date", "region", "product", "units", "price")
missing <- setdiff(required, names(sales_raw))
if (length(missing) > 0) stop(paste("Colonnes manquantes:", paste(missing, collapse = ", ")))

if (anyNA(sales_raw)) message("Attention: valeurs manquantes détectées")
```

---

## Parser une date

Option A (base R):

```r
sales_raw$date <- as.Date(sales_raw$date)
```

Option B (lubridate):

```r
library(lubridate)
sales_raw$date <- ymd(sales_raw$date)
```

---

## Types numériques (pièges fréquents)

- `units` doit être numérique (souvent entier)
- `price` doit être numérique (double)
- les conversions silencieuses peuvent créer des `NA`

```r
sales_raw$units <- suppressWarnings(as.integer(sales_raw$units))
sales_raw$price <- suppressWarnings(as.numeric(sales_raw$price))

stopifnot(!any(is.na(sales_raw$units)))
stopifnot(!any(is.na(sales_raw$price)))
```

---

## Créer une variable: chiffre d'affaires

```r
sales_raw$revenue <- sales_raw$units * sales_raw$price
```

Définition: `revenue` est une **variable dérivée**, calculée à partir d'autres colonnes.

---

## Sauvegarder une version “processed”

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

Objectifs:
- importer `sales.csv` (base R puis option `readr`)
- convertir `date`, `units`, `price` et gérer les erreurs de parsing
- créer `revenue` et vérifier les invariants (`units >= 0`, `price >= 0`)
- écrire une version `data/processed/sales_clean.csv`
