# TP — Analyse exploratoire d'un gros fichier Kaggle

## Préparer et exécuter le projet proprement

### Structure du projet 

```text
tp_taxi/
├── data/
│   └── yellow_tripdata_2017-01.csv
├── R/
│   ├── 00_setup.R
│   └── 99_run_all.R
├── renv/
├── renv.lock
└── README.md
```

---

### `00_setup.R` — Préparer l'environnement

👉 Ce script sert à **tout préparer une seule fois**.

Il contient typiquement :

* le chargement des librairies
* la configuration du projet
* l'initialisation de l'environnement R

```r
# 00_setup.R
library(tidyverse)
library(lubridate)
```

Règle : **on ne met pas d'analyse ici**, seulement la préparation.

---

### `99_run_all.R` — Lancer tout le projet

👉 Ce script permet de **tout exécuter d'un coup**, dans le bon ordre.

```r
# 99_run_all.R
source("R/00_setup.R")
source("R/10_import.R")
source("R/20_clean.R")
source("R/30_analysis.R")
source("R/40_plots.R")
```

Utile pour :

* reproduire l'analyse
* vérifier que tout fonctionne
* éviter les oublis

---

### `renv` — Pourquoi et à quoi ça sert

`renv` permet de **figer les versions des packages** utilisés dans le projet.

👉 Objectif :

* avoir **les mêmes résultats partout**
* éviter les erreurs “chez moi ça marche”

---

### Comment `renv` est utilisé ici

Les étudiants **n'ont rien à configurer**.

Ils doivent seulement :

```r
renv::restore()
```

Cela :

* installe automatiquement les bons packages
* aux bonnes versions
* pour ce projet précis

`renv.lock` est le fichier qui décrit l'environnement.

---

### À retenir absolument

* `setup` → préparer l'environnement
* `run_all` → exécuter tout le projet
* `renv` → garantir la reproductibilité

---

### Phrase clé à dire aux étudiants

> Un projet data doit pouvoir être relancé à l'identique, sans bricolage.

---

Si tu veux, je peux aussi :

* fournir **le contenu exact des scripts vides** (`10_import.R`, etc.)
* ajouter une **slide “ce que vous ne devez PAS modifier”**
* ou simplifier encore pour un **public L1 / non informatique**


## Objectif du TP

À partir d'un **fichier réel volumineux**, vous devez :

* charger et inspecter les données
* préparer les variables utiles
* gérer correctement les variables catégorielles
* produire des statistiques descriptives simples
* construire des graphiques interprétables

⚠️ Il ne s'agit **pas** d'optimisation ni de modélisation.

---

## Chargement des librairies


Chargez les librairies nécessaires pour :

* la manipulation de données
* la gestion des dates
* la visualisation

```r
library(tidyverse)
library(lubridate)
```

---

## Lecture du fichier CSV


Chargez le fichier `yellow_tripdata_2017-01.csv` à l'aide de `read_csv()`.
Affichez ensuite la structure des données.

👉 Questions :

* Combien y a-t-il de lignes ?
* Quels types de variables repérez-vous ?

```r
taxi_raw <- read_csv(
  "data/yellow_tripdata_2017-01.csv",
  show_col_types = FALSE
)

glimpse(taxi_raw)
```

---

## Sélection des variables utiles


Créez un nouveau tableau `taxi` en ne conservant que les variables nécessaires à l'analyse :

* informations temporelles
* distance
* montants
* variables de groupe

👉 Justifiez brièvement votre sélection.

```r
taxi <- taxi_raw |>
  select(
    ...
  )
```

---

## Création de variables dérivées et catégorielles


À partir du tableau précédent :

1. Convertissez les colonnes de dates en vraies dates
2. Calculez la durée du trajet en minutes
3. Créez :

   * l'heure du trajet
   * le jour de la semaine
4. Transformez les variables de codes en **facteurs**

👉 Vérifiez le résultat avec `glimpse()`.

```r
taxi <- taxi |>
  mutate(
    ...
  )
```

---

## Nettoyage minimal des données


Éliminez les observations manifestement aberrantes :

* durées négatives ou excessives
* distances incohérentes
* montants négatifs ou irréalistes

👉 Objectif : rendre les données **analysables**, pas parfaites.

```r
taxi_clean <- taxi |>
  filter(
    ...
  )
```

---

## Statistiques descriptives globales


Calculez, sur l'ensemble des données nettoyées :

* le nombre d'observations
* moyenne et médiane :

  * de la distance
  * de la durée
  * du montant total

👉 Comparez moyenne et médiane : que constatez-vous ?

```r
taxi_clean |>
  summarise(
    ...
  )
```

---

## Comptages par catégorie


Calculez le nombre de courses par type de paiement.

👉 Question :

* certaines catégories sont-elles dominantes ?

```r
taxi_clean |>
  count(...)
```

---

##  Visualisations

###  Volume de courses par jour


Construisez une série temporelle montrant le nombre de courses par jour.

👉 Interprétez les variations observées.

---

### Distribution des distances


Tracez un histogramme des distances de trajets.

👉 La distribution est-elle symétrique ?

---

###  Montant total selon le type de paiement


Utilisez un boxplot pour comparer les montants selon le type de paiement.

👉 Comparez médiane et dispersion.

---

###  Relation distance / prix


Réalisez un nuage de points :

* distance en abscisse
* montant total en ordonnée
  Ajoutez une tendance.

👉 La relation est-elle linéaire ? Bruitée ?

---

###  Carte de chaleur jour × heure


Construisez une heatmap représentant l'intensité des courses selon :

* le jour de la semaine
* l'heure

👉 Identifiez les périodes les plus actives.

---

## Synthèse écrite (attendue)

Rédigez une conclusion courte (5–8 lignes) répondant aux questions :

* quelles structures ressortent ?
* quelles variables sont déterminantes ?
* quelles limites voyez-vous à cette analyse ?

---

# Aide-mémoire — Fonctions nouvelles utilisées dans ce TP

## `read_csv()`

Lit un fichier CSV et détecte automatiquement les types de colonnes.

---

## `glimpse()`

Affiche rapidement :

* le type des variables
* un aperçu des valeurs

---

## `select()`

Permet de garder uniquement certaines colonnes.

---

## `mutate()`

Permet :

* de créer de nouvelles variables
* de transformer des variables existantes

---

## `ymd_hms()`

Convertit un texte en date-heure.

---

## `difftime()`

Calcule une différence entre deux dates (durée).

---

## `hour()` / `wday()`

Extraient l'heure ou le jour de la semaine depuis une date.

---

## `factor()`

Déclare explicitement une variable comme catégorielle.

---

## `count()`

Compte le nombre d'observations par catégorie.

---

## `geom_tile()`

Permet de créer une carte de chaleur à partir de données agrégées.
