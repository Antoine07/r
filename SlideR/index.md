---
marp: true
theme: default
paginate: true
class: lead
---

# Plan du cours — R & RStudio (2 jours)

---

## Objectif

- Prendre en main R et RStudio
- Importer, nettoyer et transformer des données
- Faire de la dataviz avec `ggplot2`
- Produire des statistiques descriptives et des analyses simples

---

## Organisation (2 jours)

Jour 1 — bases + data + dataviz
- workflow RStudio + projets
- syntaxe de base R + NA
- structures (vecteurs, data frame / tibble)
- import CSV + nettoyage
- `dplyr` (filter/mutate/summarise/group_by)
- `ggplot2` (bar/line/scatter/boxplot + facettes)

Jour 2 — stats simples + interprétation
- descriptif (moyenne, médiane, variance, quantiles)
- tests simples (t-test, chi2) + lecture de résultats
- corrélation + régression linéaire (`lm`)
- exporter données/graphiques + mini reporting

---

## Slides (ordre recommandé)

Introduction:
- `SlideR/000_intro_why_r.md`

Installation:
- `SlideR/000_install_r_rstudio.md`

Jour 1:
- `SlideR/101_rstudio_workflow.md`
- `SlideR/107_project_structure.md`
- `SlideR/103_memory_vectors.md`
- `SlideR/104_composite_structures.md`
- `SlideR/105_tabular_structures.md`
- `SlideR/102_r_basics_syntax.md`
- `SlideR/108_import_cleaning.md`
- `SlideR/106_data_manipulation.md`
- `SlideR/110_ggplot2_intro.md`

Jour 2:
- `SlideR/201_stats_descriptive.md`
- `SlideR/202_tests_inference.md`
- `SlideR/203_regression.md`
- `SlideR/204_reporting_export.md`

---

## Fil rouge (dataset)

- CSV: `TPs/r/data/sales.csv`
- Variables: `date`, `region`, `product`, `units`, `price`
- Objectif: créer `revenue = units * price`, analyser et visualiser

---

## Check rapide (code de départ)

```r
install.packages("tidyverse")
library(tidyverse)

sales <- read_csv("TPs/r/data/sales.csv") |>
  mutate(
    date = as.Date(date),
    revenue = units * price
  )

sales |> group_by(region) |> summarise(revenue_total = sum(revenue), .groups = "drop")
```

---

## Sujets (à rendre)

- Exercices: `Exercices/README.md`
- TPs: `TPs/README.md`
- Corrections: `Corrections/README.md`
