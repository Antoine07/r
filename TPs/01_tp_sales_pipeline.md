# TP 01 — Fil rouge “sales” (pipeline + outputs)

## Contexte (métier)

Une équipe souhaite produire un reporting simple à partir d'un export CSV de ventes.

Objectifs:

- calculer le chiffre d'affaires (CA)
- produire des indicateurs par région et par produit
- générer des tables et des figures reproductibles

## Données

- entrée: `TPs/r/data/sales.csv`
- colonnes: `date`, `region`, `product`, `units`, `price`

## Pourquoi R est conçu pour ce TP

- Les données tabulaires sont manipulées via data frames/tibbles.
- Les transformations sont expressives et vectorisées.
- Les livrables (CSV, PNG) sont régénérables par scripts.

## Livrables attendus

- `data/processed/sales_clean.csv`
- `output/tables/revenue_by_region.csv`
- `output/tables/revenue_by_region_product.csv`
- `output/figures/revenue_by_region.png`
- (option) `reports/analyse.qmd` rendu en HTML

## Structure imposée (projet)

Créer un projet RStudio avec:

```
data/raw/
data/processed/
r/
output/tables/
output/figures/
reports/   (option)
```

## Notions techniques à couvrir (checklist)

- import CSV (base R ou `readr`)
- types: `Date`, `integer`, `numeric`
- `NA` (détection) et contrôles (`stopifnot`, `stop`)
- variable dérivée `revenue = units * price`
- agrégations (base R `aggregate` et/ou `dplyr`)
- export CSV + export PNG
- exécution en pipeline (`source("r/run_all.R")`)

---

## Étape 1 — Setup

Créer `r/00_setup.R` qui:

- vérifie que l'exécution se fait depuis la racine (présence d'un `.Rproj`)
- définit les chemins d'entrée/sortie
- crée les dossiers manquants (`dir.create`)

## Étape 2 — Import + nettoyage

Créer `r/01_import.R` qui:

1. lit `TPs/r/data/sales.csv` vers `sales_raw`
2. valide les colonnes attendues
3. parse `date`, `units`, `price` (et échoue en cas de parsing invalide)
4. crée `revenue`
5. écrit `data/processed/sales_clean.csv`

## Étape 3 — Tables + figure

Créer `r/02_outputs.R` qui:

1. lit `data/processed/sales_clean.csv`
2. produit:
   - revenu total par région
   - revenu total par (région, produit)
3. écrit les tables dans `output/tables/`
4. génère un barplot (base R ou `ggplot2`) dans `output/figures/`

## Étape 4 — Entrée unique

Créer `r/run_all.R` qui exécute:

- `r/01_import.R`
- `r/02_outputs.R`

## Bonus — Qualité / robustesse

- ajouter un contrôle sur les valeurs négatives (`units`, `price`)
- vérifier qu'il n'y a pas de `NA` dans `revenue`

