# 202 — Tests (inférence) (exercices)

Correspond au chapitre: `SlideR/202_tests_inference.md`

## Pourquoi R est conçu pour

- Appliquer des tests statistiques standard à partir de formules et de tables.

## Pré-requis

Un objet `sales` contenant:

- `revenue` (numérique)
- `region`, `product` (catégories)

## Notions techniques à couvrir (checklist)

- formuler H0/H1
- `t.test(y ~ group, data = ...)`
- `table(x, y)` et `chisq.test(tab)`
- lecture: estimate, p-value, intervalle de confiance

---

## Exercice 1 — t-test (2 régions)

1. Créer `test_data <- subset(sales, region %in% c("North", "South"))`.
2. Vérifier les effectifs: `table(test_data$region)`.
3. Poser H0/H1 pour la comparaison des moyennes de `revenue`.
4. Lancer `t.test(revenue ~ region, data = test_data)`.
5. Rédiger une conclusion courte (3–5 lignes) avec p-value et limite principale.

## Exercice 2 — Chi² (région × produit)

1. Construire `tab <- table(sales$region, sales$product)`.
2. Lancer `chisq.test(tab)`.
3. Rédiger une conclusion: association ou non (avec prudence).

## Bonus — Pré-analyse

Avant chaque test:

1. afficher un descriptif (moyenne/median par groupe)
2. tracer un boxplot (si applicable)

