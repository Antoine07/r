---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---


# Démarrer un projet R 

---

## Installer les outils 

Assurez-vous d'avoir, si pas déjà fait :

1. **R**
1. **RStudio**

👉 Rien d'autre n'est nécessaire.

---

## Créer un nouveau projet stater-simple

1. Ouvrez **RStudio**
2. Menu **File → New Project…**
3. Choisissez **New Directory**
4. Choisissez **New Project**
5. Donnez un nom au projet `starter-simple`
6. Cliquez sur **Create Project**

👉 RStudio crée automatiquement un fichier `.Rproj`.

---

## Toujours ouvrir le projet 

Pour travailler :

1. ouvrez **le fichier `.Rproj`**
1. ou **File → Open Project…**

❌ Ne travaillez pas hors projet, bien sûr.

---

## Structure minimale du projet

Dans le dossier du projet, créez les dossiers et fichiers suivants

```text
data/
R/
output/
```

- `data/` → données
- `R/` → scripts 
- `output/` → résultats

---

## Préparer l'environnement (une seule fois)

Dans la **console R** :

```r
renv::init()
install.packages("tidyverse") # tout ce dont nous avons besoin
renv::snapshot()
```

👉 Cela garantit que tout le monde aura les mêmes packages.

---

## Créer un premier script

Dans le dossier `R/` :

1. créez un fichier `01_sandbox.R`

Contenu :

```r
library(tidyverse)

# Charger les données iris
data(iris)

# Afficher les premières lignes
head(iris)

# Compter le nombre d'observations par espèce
table(iris$Species)
```

---

## Exécuter le script

1. ouvrez `01_test.R`
1. cliquez sur **Source**

Si un tableau s'affiche → **tout fonctionne** bravo !

---

## À la première ouverture (étudiants)

Dans la **console** :

```r
renv::restore()
```

Puis lancer les scripts.

---

## Ce qu'il ne faut PAS faire

❌ utiliser `setwd()`
❌ installer des packages dans les scripts
❌ copier-coller tout le code dans la console

