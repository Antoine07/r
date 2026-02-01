## Exercice — Températures de janvier (avec données manquantes)

On a relevé des températures quotidiennes au mois de janvier.
Certaines mesures sont **manquantes** (capteur défaillant) et sont codées par `NA`.

```r
january <- c(
  -2,  5, NA,  6, -2,  0,  6,  2,  8,  0,
   6, -1,  3, NA,  7,  0, -5,  7,  4,  7,
   8, -1,  5, -2,  3, -3, -2,  7,  8,  4,  2
)
```

### Questions

1. Donner toutes les températures **strictement supérieures à 0**.
2. Comparer le nombre de températures **positives** et **négatives** (en ignorant les valeurs manquantes).
3. Donner la **moyenne des températures positives** du mois.
4. Créer un vecteur `days` correspondant aux jours du mois et donner les **jours où la température était > 0**.
5. Donner toutes les températures **supérieures à 0 à partir du 10ᵉ jour**.
6. Remplacer les **températures négatives** par la **moyenne des températures positives** (sans modifier les `NA`).

Voici **3 questions supplémentaires**, toujours dans le même esprit, mais avec **plus de données** et un niveau légèrement au-dessus.

---

## Questions supplémentaires

On suppose toujours le vecteur `january` défini précédemment (avec des `NA`).

---

### 7️⃣ Analyse par période (plus de données)

Diviser le mois en **trois périodes** :

* jours 1 à 10
* jours 11 à 20
* jours 21 à 31

Pour chaque période :

* calculer la **moyenne des températures positives**
* ignorer les valeurs manquantes

---

### 8️⃣ Comparaison avec un second mois

On dispose maintenant des températures de février :

```r
february <- c(
  1,  3, -1,  4, NA,  2,  5, -2,  6,  7,
  6,  0, -3,  2,  3, NA,  4,  6,  5, -1,
  6,  7,  8,  1, -2,  0,  2,  3
)
```

Questions :

- calculer la moyenne des températures positives pour **janvier** et **février**
- déterminer **quel mois est le plus doux** selon ce critère

---

### Détection d'épisodes doux (logique vectorielle)

Un **épisode doux** est défini comme :

- doux pendant **3 jours consécutifs**
- avec une température **strictement supérieure à 5**

Questions :

- identifier les positions (jours) où un épisode doux commence en janvier
- indiquer combien d'épisodes doux ont été observés
