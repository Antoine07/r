---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

---

# Structurer un projet R

**Objectif**
Avoir un projet clair, relançable et maintenable, dès le départ.

---

## Le problème courant

- scripts dispersés
- chemins absolus
- données et résultats mélangés
- difficile à relancer proprement
- structure qui change au fil du projet

---

## Principe général

Un projet R bien structuré repose sur :

1. une **racine de projet**
2. des **dossiers aux rôles explicites**
3. une **séparation claire** entre données, code et résultats

---

## Racine de projet

La racine du projet contient :

- le fichier `.Rproj`
- la documentation
- la structure des dossiers

👉 Tous les chemins du projet sont **relatifs à cette racine**.

---

## Structure minimale recommandée

```text
my_project/
  my_project.Rproj
  README.md
  .gitignore

  data/
    raw/          # données sources (non modifiées)
    processed/    # données dérivées (reconstruites)

  r/              # scripts R du projet

  output/
    tables/       # tables produites
    figures/      # graphiques produits

  reports/        # rapports (Quarto / R Markdown)
```

---

## Rôle des dossiers

### `data/raw/`

- données d'entrée
- jamais modifiées
- point de départ du projet

---

### `data/processed/`

- données nettoyées ou transformées
- toujours produites par du code
- peuvent être supprimées et reconstruites

---

### `r/`

- scripts R du projet
- pipeline d'analyse
- aucune donnée ou sortie finale

---

### `output/`

- résultats générés par le code
- jamais modifiés manuellement
- toujours reconstruisibles

---

### `reports/`

- documents finaux
- consomment les données et résultats existants
- ne produisent pas de nouvelles données sources

---

## Principe de reconstruction

Tout ce qui est :

- dans `data/processed/`
- dans `output/`

doit pouvoir être **supprimé puis recréé** en relançant le code.

---

## Flux de travail logique

```text
data/raw/
   ↓
scripts R
   ↓
data/processed/
   ↓
scripts R
   ↓
output/
   ↓
reports/
```

---

## Scripts R : organisation recommandée

Dans le dossier `r/` :

```text
r/
  00_setup.R      # initialisation du projet
  01_import.R     # import et nettoyage
  02_summaries.R  # tables et indicateurs
  03_plots.R      # graphiques
  run_all.R       # exécution complète
```

---

## Rôle de `run_all.R`

- point d'entrée du projet
- exécute les scripts dans l'ordre
- permet de reconstruire tout le projet
- ne contient aucune logique métier

---

## Exécution du projet

Depuis la racine du projet :

```r
source("r/run_all.R")
```

👉 L'exécution est **volontaire**, jamais automatique.

---

## Git : principe simple

À versionner :

- la structure
- les scripts
- la documentation

À ignorer :

- les fichiers reconstruisibles (`output/`, souvent `data/processed/`)

---

## Règle d'or

> Si un fichier peut être régénéré par le code,
> il n'a pas besoin d'être versionné.

---

## Résumé

- une racine claire
- des dossiers aux rôles fixes
- un pipeline explicite
- une reconstruction possible à tout moment

C'est la base d'un projet R propre et professionnel.
