# TP 02 — Fil rouge “sales” (stats + rapport)

## Contexte (métier)

L'équipe souhaite compléter le reporting avec une interprétation statistique simple:

- comparaisons de groupes
- relation entre variables et CA
- un mini-rapport partageable

## Données

Utiliser la sortie du TP01:

- `data/processed/sales_clean.csv`

## Pourquoi R est conçu pour ce TP

- Fonctions statistiques standard disponibles directement (tests, régression).
- Modèles via formules (`y ~ x`) et objets résultats exploitables.
- Reporting reproductible (Quarto / R Markdown).

## Livrables attendus

- `output/tables/summary_by_region.csv`
- `output/figures/` (au moins 2 graphiques)
- `reports/report.qmd` rendu en HTML (ou `reports/report.md` si Quarto indisponible)

## Notions techniques à couvrir (checklist)

- descriptif: `mean`, `median`, `sd`, `quantile` (+ `na.rm`)
- tests: `t.test(y ~ group)`, `chisq.test(table(...))`
- régression: `lm(revenue ~ units + price)` + `summary`, `predict`
- visualisation: histogramme/boxplot/scatter (base R ou `ggplot2`)
- export: CSV + PNG
- rédaction: hypothèses, méthode, limites

---

## Étape 1 — Statistiques descriptives

1. Calculer des statistiques globales sur `revenue`.
2. Produire une table par région avec:
   - n, somme, moyenne, médiane, écart-type
3. Écrire cette table dans `output/tables/summary_by_region.csv`.

## Étape 2 — Tests

1. t-test: comparer `revenue` entre `North` et `South` (H0/H1 + conclusion).
2. chi²: tester association `region × product` (avec prudence).

## Étape 3 — Régression linéaire

1. Ajuster `lm(revenue ~ units + price)`.
2. Interpréter le coefficient de `units`.
3. Générer des prédictions et comparer avec les valeurs observées (qualitativement).

## Étape 4 — Figures

Produire au moins 2 figures, au choix:

- histogramme de `revenue`
- boxplot `revenue` par `region`
- scatter `units` vs `revenue` + droite de régression

Exporter dans `output/figures/`.

## Étape 5 — Rapport

Créer `reports/report.qmd` (ou `reports/report.md`) contenant:

- contexte + question
- données + préparation (résumé)
- résultats (table(s) + figure(s))
- tests + régression (2–3 paragraphes max)
- conclusion + limites

