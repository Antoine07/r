---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Jour 2 — Corrélation & régression linéaire

Objectif: expliquer/prédire une variable (modèle simple).

---

## Définitions

- **Corrélation**: mesure de liaison linéaire entre deux variables numériques (entre -1 et 1).
- **Régression linéaire**: modèle qui relie une variable cible (Y) à une ou plusieurs variables explicatives (X).
- **Modèle**: objet R contenant paramètres et diagnostics (ex: `lm(...)`).
- **Coefficient**: effet estimé d'une variable explicative sur la cible (toutes choses égales par ailleurs).
- **Résidu**: différence entre valeur observée et valeur prédite.

---

## Pourquoi R est conçu pour cette étape

- L'interface formule (`y ~ x1 + x2`) décrit directement un modèle.
- Les résultats sont des objets (coef, résidus, prédictions) exploitables par du code.
- Les diagnostics de base sont intégrés (`plot(model)`).

---

## Objet utilisé (`sales`)

`sales` est une table (data frame/tibble) contenant au minimum `units`, `price` et `revenue`.

---

## Corrélation (numérique-numérique)

```r
cor(sales$units, sales$revenue)
```

Attention:
- corrélation ≠ causalité
- sensible aux valeurs extrêmes

---

## Visualiser (scatter)

```r
ggplot(sales, aes(x = units, y = revenue)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE)
```

---

## Régression linéaire (`lm`)

```r
model <- lm(revenue ~ units + price, data = sales)
summary(model)
```

À lire:
- coefficients
- R²
- p-values (avec prudence)

---

## Prédire (niveau débutant)

```r
pred <- predict(model, newdata = sales)
head(pred)
```

Définition: `predict()` renvoie les valeurs prédites par le modèle.

---

## Résidus (vérification rapide)

```r
plot(model)
```

Objectif: repérer non-linéarités, hétéroscédasticité, points influents.

---

## Exercice (régression)

Sujet: `Exercices/203_regression.md`

Notions à pratiquer:
- construire un modèle `lm` via formule
- interpréter un coefficient (signe, unité, “toutes choses égales”)
- produire une prédiction (`predict`)
- lire un diagnostic simple (résidus)
