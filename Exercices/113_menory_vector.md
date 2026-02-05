# Exercices — Filtres sur vecteurs (base R)

## Données 

```r
temps <- c(3, -2, 5, NA, 0, 7, -1, 4, 6, NA, -3, 2)
```

### Exercice 1

1. Donner toutes les températures **strictement positives**.
2. Donner toutes les températures **négatives ou nulles**.
3. Donner les températures **non manquantes**.

---

### Exercice 2

1. Donner le **nombre** de températures positives.
2. Donner le **nombre** de valeurs manquantes.
3. Vérifier s’il y a **plus de températures positives que négatives**.

---

## Données 2 — Notes d’élèves

```r
notes <- c(12, 8, NA, 15, 9, 17, 10, 6, 14, NA)
```

### Exercice 3

1. Donner les notes **≥ 10**.
2. Donner les notes **< 10** (sans compter les `NA`).
3. Donner les **positions** des notes ≥ 10.

---

### Exercice 4

1. Calculer la **moyenne des notes ≥ 10**.
2. Calculer la **moyenne des notes < 10**.
3. Indiquer quelle moyenne est la plus élevée.

---

## Données 3 — Ventes journalières (€)

```r
sales <- c(120, 90, 150, NA, 200, 80, 60, 175, 220, 95)
```

### Exercice 5

1. Donner les ventes **> 100 €**.
2. Donner les ventes **≤ 100 €**.
3. Donner les **jours** (indices) où les ventes dépassent 150 €.

---

### Exercice 6

Créer un nouveau vecteur `sales_corr` tel que :

* les ventes **< 100 €** sont remplacées par `100`
* les autres valeurs sont conservées
* les `NA` restent inchangés

---

## Données 4 — Âges

```r
ages <- c(17, 22, 19, 34, NA, 28, 16, 41, 25, 30)
```

### Exercice 7

1. Donner les âges **< 18**.
2. Donner les âges **≥ 18**.
3. Donner la proportion de majeurs.

---

### Exercice 8

1. Donner les âges **entre 20 et 30 inclus**.
2. Donner les positions correspondantes.
3. Calculer la moyenne de cette tranche d’âge.

---

## Données 5 — Températures nocturnes

```r
night <- c(-3, -1, 2, NA, 0, 4, -2, 1, 3, -4)
```

### Exercice 9

1. Donner les nuits **≤ 0**.
2. Donner le nombre de nuits **strictement positives**.
3. Vérifier s’il existe **au moins une nuit < -3**.

---

## Exercice bonus — Raisonnement logique

À partir du vecteur `temps` :

1. Vérifier si **toutes** les températures positives sont < 10.
2. Vérifier s’il existe **au moins une température > 6**.
3. Vérifier s’il n’y a **aucune température égale à 1**.

---

### Objectifs pédagogiques

* indexation logique (`x[condition]`)
* opérateurs `> < >= <=`
* combinaisons avec `& | !`
* gestion des `NA`
* `sum`, `mean`, `any`, `all`

Si tu veux, je peux :

* fournir **la correction complète**
* transformer ces exos en **QCM**
* proposer une **fiche méthode “comment filtrer un vecteur”**
