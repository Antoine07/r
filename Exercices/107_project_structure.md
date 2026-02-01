# 107 — Organiser un projet R (exercices)

Correspond au chapitre: `SlideR/107_project_structure.md`

## Pourquoi R est conçu pour

- Produire des analyses reproductibles (projet + scripts + sorties).
- Séparer le “code” et les “données” des livrables générés.

## Objectifs

- Mettre en place une structure projet simple.
- Définir un pipeline exécutable de bout en bout.

## Exercice 1 — Structure standard

Dans un nouveau projet RStudio, créer:

- `data/raw/`
- `data/processed/`
- `r/`
- `output/tables/`
- `output/figures/`
- `reports/` (optionnel)

## Exercice 2 — Pipeline minimal (3 scripts)

Créer les scripts (noms imposés):

- `r/00_setup.R` (création des dossiers + chemins)
- `r/01_import.R` (import et écriture dans `data/processed/`)
- `r/02_outputs.R` (table + figure dans `output/`)

Notions techniques à inclure:

- chemins relatifs (pas de chemins absolus)
- `stopifnot(file.exists(...))` sur l'entrée
- `dir.create(..., recursive = TRUE, showWarnings = FALSE)`

## Exercice 3 — Entrée unique

Créer `r/run_all.R` qui exécute le pipeline dans l'ordre.

## Bonus — Option reproductibilité packages

Lister les packages nécessaires et indiquer si `renv` est pertinent pour ce projet.

