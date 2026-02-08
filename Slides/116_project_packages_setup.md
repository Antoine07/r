---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Projet R — configuration & installation des packages

Objectif : rendre un projet **relançable** (mêmes packages, mêmes versions) sur plusieurs machines.

---

## 2 commandes à ne pas confondre

Installer (une seule fois, sur la machine) :

```r
install.packages("dplyr")
```

Charger (à chaque session) :

```r
library(dplyr)
```

---

## Où R installe les packages ?

```r
.libPaths()
```

- Un “library path” = un dossier où R met les packages
- Plusieurs paths possibles (user / system)

À éviter dans un projet : bricoler `.libPaths()` sans stratégie (ça casse la reproductibilité).

---

## CRAN / miroirs / dépôts

Installer depuis CRAN :

```r
install.packages("tidyverse", repos = "https://cloud.r-project.org")
```

Définir un dépôt par défaut (session courante) :

```r
options(repos = c(CRAN = "https://cloud.r-project.org"))
```

---

## Le vrai problème en projet : les versions

Sans gestion de dépendances :

- A installe `dplyr` (v1)
- B installe `dplyr` (v2)
- Le code marche chez A, casse chez B

Solution : **verrouiller** les versions du projet.

---

## `renv` : standard simple pour un projet relançable

`renv` crée un environnement de packages **par projet** + un fichier de lock.

Fichiers importants :

- `renv.lock` : versions verrouillées (à versionner)
- `renv/` : mécanisme du projet (à versionner)
- `renv/library/` : packages installés localement (souvent ignorés par git)

---

## Démarrer un nouveau projet avec `renv`

Dans la console (racine du projet) :

```r
renv::init()
install.packages(c("tidyverse", "lubridate"))
renv::snapshot()
```

- `init()` active `renv`
- `snapshot()` écrit `renv.lock`

---

## Récupérer un projet existant (le cas le plus fréquent)

Après `git clone` / ouverture du `.Rproj` :

```r
renv::restore()
```

Cela installe les packages **exactement** aux versions de `renv.lock`.

---

## Ajouter / mettre à jour des packages (workflow)

1. installer / mettre à jour
```r
install.packages("readr")
```

1. mettre à jour le lockfile
```r
renv::snapshot()
```

Bon réflexe : si `renv.lock` change, le commit doit inclure ce fichier.

---

## Vérifier l'état du projet

```r
renv::status()
sessionInfo()
```

- `renv::status()` : incohérences entre la bibliothèque et `renv.lock`
- `sessionInfo()` : versions + plateforme (utile pour debug)

---

## Binaire vs source (erreurs d'installation)

Quand ça échoue, causes fréquentes :

- compilation requise (pas d'outils C/C++ sur la machine)
- dépendance système manquante (lib, headers)

Exemples de prérequis :
- Windows : Rtools
- macOS : Xcode Command Line Tools

---

## Installer depuis GitHub (hors CRAN)

```r
remotes::install_github("tidyverse/ggplot2")
renv::snapshot()
```

Même règle : après installation, **snapshot** pour que le projet reste relançable.

---

## Bonne pratique projet : un script `00_setup.R`

Idée : un point d'entrée qui :

- charge les packages
- configure ce qui est spécifique au projet (options, seed, chemins)
- échoue vite si une dépendance manque

Exemple minimal :

```r
library(tidyverse)
```

---

## Règles d'or

1. Ouvrir le projet via le `.Rproj` (racine claire)  
1. Utiliser `renv` pour verrouiller les versions (`renv.lock`)  
1. `renv::restore()` quand on récupère le projet  
1. `renv::snapshot()` après changement de dépendances
