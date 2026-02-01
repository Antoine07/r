---
marp: true
theme: default
paginate: true
class: lead
---

# R & RStudio — Analyse de données (2 jours)

Public: bases en maths, objectif = analyser ses données et produire des graphiques + stats simples.

---

## Outils

- R (langage + runtime)
- RStudio (IDE)
- Packages: `tidyverse` (data + dataviz), `readr`, `dplyr`, `tidyr`, `ggplot2`, `data.table` (option)

---

## Objectifs (fin des 2 jours)

- Comprendre les objets R (vecteurs, data frames) et la syntaxe
- Importer et nettoyer un CSV
- Transformer des données (filtrer, regrouper, calculer)
- Faire des graphiques propres (`ggplot2`)
- Faire des stats descriptives + tests simples + régression linéaire

---

## Organisation (2 jours)

Jour 1 — bases + dataviz
- Installer R/RStudio + premiers pas
- Modèle mémoire & vecteurs atomiques (recycling, copy-on-write/copy-on-modify)
- Structures composées (listes, matrices, arrays, attributes)
- Structures tabulaires (data.frame, tibble, data.table)
- Programmation de base (fonctions, conditions, boucles)
- Import de données (CSV) + nettoyage
- Manipulation de données (`dplyr`, `tidyr`)
- `ggplot2` (scatter, bar, boxplot, facettes)

Jour 2 — stats simples + reporting
- descriptif (moyenne, médiane, variance, quantiles)
- corrélation + régression (`lm`)
- tests simples (t-test, chi2) + interprétation
- exporter résultats (CSV) + rendu (Quarto/R Markdown, optionnel)

---

## Fichiers du cours

- Introduction: `SlideR/000_intro_why_r.md`
- Installation: `SlideR/000_install_r_rstudio.md`
- Jour 1:
  - `SlideR/101_rstudio_workflow.md`
  - `SlideR/107_project_structure.md`
  - `SlideR/103_memory_vectors.md`
  - `SlideR/104_composite_structures.md`
  - `SlideR/105_tabular_structures.md`
  - `SlideR/102_r_basics_syntax.md`
  - `SlideR/108_import_cleaning.md`
  - `SlideR/106_data_manipulation.md`
  - `SlideR/110_ggplot2_intro.md`
- Jour 2:
  - `SlideR/201_stats_descriptive.md`
  - `SlideR/202_tests_inference.md`
  - `SlideR/203_regression.md`
  - `SlideR/204_reporting_export.md`

---

## Sujets (à rendre)

- Exercices: `Exercices/README.md`
- TPs: `TPs/README.md`
- Corrections: `Corrections/README.md`

---

## Fil rouge (dataset de TP)

CSV: `TPs/r/data/sales.csv`

Variables:
- `date`, `region`, `product`, `units`, `price`

Objectifs:
- CA (`revenue = units * price`)
- tendances dans le temps
- comparaison par région / produit
