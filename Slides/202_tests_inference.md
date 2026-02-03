---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Jour 2 — Tests simples (inférence)

Objectif: comparer des groupes et tester une hypothèse.

---

## Définitions

- **Hypothèses**: H0 (pas d'effet) vs H1 (effet/différence).
- **Statistique de test**: nombre calculé à partir des données.
- **p-value**: probabilité d'obtenir un résultat aussi extrême (ou plus) si H0 est vraie.
- **Seuil α**: niveau de décision (souvent 0.05) choisi avant le test.
- **Intervalle de confiance**: plage plausible pour un paramètre (ex: différence de moyennes).

---

## Pourquoi R est conçu pour cette étape

- R a une longue tradition statistique: les tests (t-test, chi²) sont disponibles directement.
- L'interface formule (`y ~ group`) permet de décrire un test de façon concise.
- Les objets de résultats contiennent tout (statistique, p-value, IC) et sont exploitables.

---

## Objet utilisé (`sales`)

- `sales` est une table (data frame/tibble).
- `revenue` est une variable numérique.
- `region` et `product` sont des variables catégorielles.

Les exemples supposent que `revenue` a déjà été calculé (ex: `revenue = units * price`).

---

## Rappel: idée d'un test

- H0: "pas d'effet" / "pas de différence"
- H1: "différence" / "effet"

Un test renvoie une p-value (à interpréter avec un seuil α).

---

## t-test (comparaison de moyennes)

Définition: compare la moyenne d'une variable numérique entre **deux** groupes.

Exemple: comparer `revenue` entre deux régions.

```r
test_data <- subset(sales, region %in% c("North", "South"))
t.test(revenue ~ region, data = test_data)
```

À lire:
- estimate (moyennes)
- p-value
- intervalle de confiance

---

## Attention: conditions (niveau débutant)

Point de méthode:

- regarder les descriptifs et un boxplot avant le test
- attention aux petits effectifs

```r
table(test_data$region)
```

---

## Test du chi2 (variables qualitatives)

Définition: teste une association entre deux variables catégorielles.

Exemple: région × produit (table de contingence):

```r
tab <- table(sales$region, sales$product)
chisq.test(tab)
```

---

## Attention (interprétation)

- p-value ≠ importance pratique
- vérifier les conditions (taille d'échantillon, indépendance)
- commencer par des statistiques descriptives et des graphes

---

## Exercice (tests)

Sujet: `Exercices/202_tests_inference.md`

Notions à pratiquer:
- formuler H0/H1 correctement
- utiliser `t.test(y ~ group, data = ...)`
- construire une table de contingence (`table`) et lancer `chisq.test`
- rédiger une conclusion courte (contexte + p-value + limites)
