---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
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

## Organisation (2 jours) - 1/2

Jour 1 — bases + dataviz
- Installer R/RStudio + premiers pas
- Modèle mémoire & vecteurs atomiques (recycling, copy-on-write/copy-on-modify)
- Structures composées (listes, matrices, arrays, attributes)
- Structures tabulaires (data.frame, tibble, data.table)
- Programmation de base (fonctions, conditions, boucles)
- Import de données (CSV) + nettoyage
- Manipulation de données (`dplyr`, `tidyr`)
- `ggplot2` (scatter, bar, boxplot, facettes)

----

## Organisation (2 jours) - 2/2


Jour 2 — stats simples + reporting
- descriptif (moyenne, médiane, variance, quantiles)
- corrélation + régression (`lm`)
- tests simples (t-test, chi2) + interprétation
- exporter résultats (CSV) + rendu (Quarto/R Markdown, optionnel)


---

## Fil rouge (dataset de TP)

CSV: `TPs/r/data/sales.csv`

Variables:
- `date`, `region`, `product`, `units`, `price`

Objectifs:
- CA (`revenue = units * price`)
- tendances dans le temps
- comparaison par région / produit
