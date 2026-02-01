# 203 — Corrélation & régression (exercices)

Correspond au chapitre: `SlideR/203_regression.md`

## Pourquoi R est conçu pour

- Décrire un modèle via une formule (`y ~ x1 + x2`) et analyser l'objet résultat.

## Pré-requis

Un objet `sales` contenant `units`, `price`, `revenue`.

## Notions techniques à couvrir (checklist)

- `cor(x, y)` + interprétation prudente
- `lm(formula, data = ...)`
- `summary(model)`, `coef(model)`
- `predict(model, newdata = ...)`
- diagnostics: `plot(model)`

---

## Exercice 1 — Corrélation

1. Calculer `cor(sales$units, sales$revenue)`.
2. Écrire 2 phrases: ce que cela indique et ce que cela n'indique pas.

## Exercice 2 — Modèle linéaire

1. Ajuster `model <- lm(revenue ~ units + price, data = sales)`.
2. Afficher `summary(model)`.
3. Interpréter le coefficient de `units` (signe + unité + “toutes choses égales”).

## Exercice 3 — Prédiction

1. Créer `pred <- predict(model, newdata = sales)`.
2. Comparer `head(pred)` avec `head(sales$revenue)`.

## Exercice 4 — Diagnostics (lecture)

1. Exécuter `plot(model)`.
2. Décrire un point d'attention potentiel (en 2–3 lignes).

