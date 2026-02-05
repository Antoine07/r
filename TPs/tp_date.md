## TP — Analyse de durées et d'écarts entre dates

On étudie les délais de traitement de dossiers administratifs sur le premier trimestre 2026.

### Données

On dispose des dates de dépôt et de validation de 8 dossiers :

```r
library(tibble)
library(dplyr)

# ---------------------------
# 1. Données
# ---------------------------

dossiers <- tibble(
  id = 1:8,
  depot = as.Date(c(
    "2026-01-02", "2026-01-05", "2026-01-10", "2026-01-15",
    "2026-02-01", "2026-02-10", "2026-03-01", "2026-03-10"
  )),
  validation = as.Date(c(
    "2026-01-12", "2026-01-20", "2026-01-25", "2026-02-05",
    "2026-02-20", "2026-02-18", "2026-03-20", "2026-03-25"
  ))
)
```

---

### Questions

#### Calcul de durées

- Créer une variable `delai` correspondant au nombre de jours entre le dépôt et la validation.
- Vérifier le type de la variable obtenue.

---

## Analyse temporelle

- Ajouter une variable `mois_depot` correspondant au mois de dépôt.
- Calculer le délai moyen par mois de dépôt.

---

#### Comparaison à un seuil

On considère qu'un dossier est **en retard** si le délai dépasse 20 jours.

- Créer une variable logique `retard`.
- Calculer la proportion de dossiers en retard.

---

#### 5. Raisonnement sur les dates

Déterminer le nombre de dossiers validés en février 2026.
Calculer le nombre de jours entre la première date de dépôt et la dernière date de validation.

---

### Question bonus (conceptuelle)

Pourquoi est-il préférable de stocker les dates en `Date` plutôt qu'en `character` pour ce type d'analyse ?
