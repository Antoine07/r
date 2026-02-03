---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

#  RStudio: workflow

---

## Définitions (ce qui est manipulé)

- **Script**: fichier `.R` qui contient du code à rejouer (source de vérité).
- **Console**: endroit où R exécute du code et affiche les résultats.
- **Objet**: valeur stockée en mémoire (vecteur, data frame, fonction…).
- **Environnement**: liste des objets actuellement disponibles (souvent l'onglet Environment).
- **Répertoire de travail**: dossier racine depuis lequel les chemins relatifs sont résolus.
- **RStudio Project (`.Rproj`)**: configuration qui fixe une racine de projet.

---

## Les 4 zones RStudio

- Script (éditeur)
- Console (exécution)
- Environment/History (objets)
- Files/Plots/Packages/Help (navigation + sorties)

---

## RStudio Project 

Un projet fixe:
- le dossier de travail (racine)
- l'organisation des fichiers
- un contexte reproductible

Créer:
- File → New Project → New Directory

---

## Bonnes pratiques de travail

- tout code dans un **script** (`.R`)
- exécuter par petits blocs (Ctrl/Cmd + Enter)
- nommer clairement les objets (`sales_raw`, `sales_clean`)
- éviter de "tout faire dans la console" sans trace

---

## Aide & documentation

```r
?mean
help("lm")
```

Vignettes (si disponible):

```r
vignette("dplyr")
```

---

## Installer / charger des packages

Installer (une seule fois):

```r
install.packages("tidyverse")
```

Charger (à chaque session):

```r
library(tidyverse)
```

## package pacman

```r
# pacman est un package qui permet de gérer facilement les packages 
if(!require(pacman)) install.pacakge("pacman")
library(pacman)

# installe le package s'il manque le charge s'il est déjà installé
pacman::p_load(dplyr, ggplot2, readr)
```
