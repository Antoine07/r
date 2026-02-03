---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Installer R & RStudio

But: pouvoir lancer R, installer des packages et travailler dans RStudio.

Téléchargements:
- RStudio Desktop: https://posit.co/download/rstudio-desktop/
- R (CRAN): https://cran.r-project.org/

---

## Définitions (objets et outils)

- **R**: langage + environnement d'exécution (interpréteur) qui exécute du code.
- **RStudio**: IDE (éditeur, console, plots, gestion de projets) qui pilote R.
- **Package**: ensemble de fonctions/données installées dans R (ex: `ggplot2`).
- **CRAN**: dépôt officiel où R télécharge des packages.

Commandes:

- `install.packages("tidyverse")`: installe un package (une seule fois).
- `library(tidyverse)`: charge un package dans la session courante.

---

## À installer

- **R**: le langage + runtime
- **RStudio Desktop**: l'IDE (éditeur + console + plots + projets)

Important:
- RStudio ≠ R
- si R n'est pas installé, RStudio ne peut pas exécuter du code

---

## Windows

1) Installer **R** (CRAN)
2) Installer **RStudio Desktop**

Après installation:
- ouvrir RStudio
- vérifier dans la Console:

```r
version
```

---

## macOS

1) Installer **R** (package macOS)
2) Installer **RStudio Desktop**

Test:

```r
R.version.string
```

---

## Linux (Ubuntu/Debian)

Option simple:
- installer R via le gestionnaire de paquets
- installer RStudio Desktop

Test dans R:

```r
sessionInfo()
```

---

## Installer des packages

```r
install.packages("tidyverse")
```

Charger un package:

```r
library(tidyverse)
```

---

##  Réflexe


```r
sessionInfo()
```
