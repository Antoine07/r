# Mini-projet — Bases R (data frame + scripts)

Ce mini-projet sert à pratiquer les bases de R sur un petit dataset, en suivant une structure de projet simple.

## Objectifs

- Comprendre ce qu’est un **data frame** et comment le manipuler.
- Importer un CSV et contrôler les types.
- Créer des variables dérivées (vectorisation).
- Filtrer, sélectionner, agréger.
- Produire des sorties reproductibles (`output/`).

## Structure

- `data/raw/`: données sources
- `r/`: scripts
- `output/`: sorties générées (tables + figures)

## Démarrage

1. Ouvrir `mini_projet_bases_r.Rproj`.
2. Exécuter le script de travail:

```r
source("r/01_mini_projet.R")
```

Un corrigé est disponible:

```r
source("r/01_mini_projet_corrections.R")
```

## Livrables attendus

- `output/tables/revenue_by_region.csv`
- `output/figures/revenue_by_region.png`

## Dataset

Le fichier `data/raw/sales.csv` contient:

- `date` (YYYY-MM-DD)
- `region`
- `product`
- `units`
- `price`
