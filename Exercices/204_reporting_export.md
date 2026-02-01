# 204 — Export & reporting (exercices)

Correspond au chapitre: `SlideR/204_reporting_export.md`

## Pourquoi R est conçu pour

- Produire des livrables standards (tables, figures, rapport) à partir d'un script.
- Séparer entrées/sorties et rendre l'analyse relançable.

## Notions techniques à couvrir (checklist)

- exports: `write.csv`, `readr::write_csv`, `saveRDS`, `readRDS`
- export graphique: `ggsave`
- structure: `data/raw`, `data/processed`, `output`, `reports`
- mini-rapport: question → méthode → résultats → conclusion

---

## Exercice 1 — Exports de tables

À partir d'une table `by_region`:

1. Écrire `by_region` en CSV dans `output/tables/`.
2. Sauvegarder le même objet en RDS dans `output/tables/`.
3. Relire le RDS et vérifier que l'objet relu a le même nombre de lignes/colonnes.

## Exercice 2 — Export de figure

1. Créer une figure ggplot (au choix: CA par région, CA par jour).
2. Exporter en PNG dans `output/figures/` avec un nom explicite.

## Exercice 3 — Mini-rapport (sans Quarto)

Rédiger un fichier `reports/mini_report.md` contenant:

- contexte + question (3–5 lignes)
- un tableau (lien/description du CSV généré)
- une figure (lien/description du PNG généré)
- conclusion (3 lignes) + limites

## Bonus — Quarto (option)

1. Créer `reports/mini_report.qmd`.
2. Inclure 1 chunk de code qui charge une table et affiche un résumé.

