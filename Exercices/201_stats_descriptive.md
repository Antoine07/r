# 201 — Statistiques descriptives (exercices)

Correspond au chapitre: `SlideR/201_stats_descriptive.md`

## Pourquoi R est conçu pour

- Résumer des variables via des statistiques et des graphiques (fonctionnalités natives).
- Comparer des groupes via des agrégations simples.

## Pré-requis

Un objet `sales` contenant au minimum `revenue` et `region`.

## Notions techniques à couvrir (checklist)

- `mean`, `median`, `sd`, `quantile` (+ `na.rm`)
- `summary`, `str`
- agrégations par groupe (dplyr et/ou `aggregate`)
- histogramme, boxplot (lecture de distribution)

---

## Exercice 1 — Statistiques globales

Calculer sur `sales$revenue`:

1. moyenne, médiane
2. écart-type
3. quantiles 25%, 50%, 75%

## Exercice 2 — NA (simulation)

1. Créer une copie `sales_na <- sales`.
2. Remplacer quelques valeurs de `revenue` par `NA`.
3. Comparer le résultat de `mean(...)` avec et sans `na.rm = TRUE`.

## Exercice 3 — Résumé par région

Produire une table `by_region` contenant:

- `n`
- `revenue_total`
- `revenue_mean`
- `revenue_median`
- `revenue_sd`

## Exercice 4 — Visualiser

1. Histogramme de `revenue`.
2. Boxplot de `revenue` par `region`.
3. Ajouter une phrase d'interprétation (2–3 lignes) pour chaque graphique.

