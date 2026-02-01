# 105 — Structures tabulaires (exercices)

Correspond au chapitre: `SlideR/105_tabular_structures.md`

## Pourquoi R est conçu pour

- Manipuler des tables comme structure centrale (colonnes = vecteurs).
- Proposer plusieurs “dialectes” pour les tables (base R, tidyverse, data.table).

## Notions techniques à couvrir (checklist)

- `data.frame`: création, `stringsAsFactors`, `$`, `[ , ]`
- `tibble`: création (`tibble::tibble`), `readr::read_csv`, différences d'affichage
- `data.table` (option): `as.data.table`, `:=`, `by`

---

## Exercice 1 — `data.frame` (base R)

1. Créer un `data.frame` avec `region`, `units`, `price` (au moins 3 lignes).
2. Ajouter `revenue = units * price`.
3. Filtrer les lignes où `region == "North"`.
4. Garder uniquement les colonnes `region` et `revenue`.

## Exercice 2 — Import CSV (data.frame)

1. Importer `TPs/r/data/sales.csv` avec `read.csv(..., stringsAsFactors = FALSE)`.
2. Afficher `str(sales)` et `head(sales)`.
3. Créer `revenue`.

## Exercice 3 — Tibble (tidyverse)

1. Importer le même fichier avec `readr::read_csv`.
2. Vérifier `class(sales)` et comparer la sortie avec l'import base R.
3. Identifier une différence observable (types, affichage, rownames…).

## Exercice 4 — `data.table` (option)

1. Convertir `sales` en `data.table`.
2. Ajouter `revenue` avec `:=`.
3. Calculer le revenu total par région avec `by = region`.

