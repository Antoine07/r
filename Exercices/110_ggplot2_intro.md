# 110 — `ggplot2` (exercices)

Correspond au chapitre: `SlideR/110_ggplot2_intro.md`

## Pourquoi R est conçu pour

- Produire des graphiques à partir de tables (data frames) de façon reproductible.
- Décliner une même donnée en plusieurs vues (tendance, comparaison, distribution).

## Pré-requis

Un objet `sales` (tibble) contenant `date`, `region`, `product`, `revenue`.

## Notions techniques à couvrir (checklist)

- `ggplot(data, aes(...))`
- mapping (`aes`) vs valeur constante
- `geom_line`, `geom_point`, `geom_col`
- agrégation avant le plot (table “résumé”)
- `facet_wrap`, `labs`, `theme_*`
- `ggsave` (export)

---

## Exercice 1 — Tendance (ligne)

1. Construire `sales_daily` (une ligne par date) avec `revenue_total`.
2. Tracer `revenue_total` par `date` avec `geom_line()`.
3. Ajouter un titre et des labels d'axes.

## Exercice 2 — Comparaison (barres)

1. Construire `sales_by_product` (une ligne par produit) avec `revenue_total`.
2. Tracer un bar chart (`geom_col`) du CA par produit.
3. Trier les barres (au choix: via la table ou via `reorder()`).

## Exercice 3 — Variabilité (points + facettes)

1. Tracer `revenue` en fonction de `date` (points) et colorer par `product`.
2. Ajouter `facet_wrap(~ region)`.
3. Ajuster l'opacité (`alpha`) pour la lisibilité.

## Exercice 4 — Export

1. Sauvegarder 2 figures dans `output/figures/` avec `ggsave`.
2. Vérifier que la figure se régénère en relançant le script.
