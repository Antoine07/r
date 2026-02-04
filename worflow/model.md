## Structure du projet

```text
projet_data/
├── data/
│   ├── raw/
│   │   └── iris_raw.csv
│   └── processed/
│       └── iris_clean.csv
├── R/
│   ├── 10_import_raw.R
│   ├── 20_clean_data.R
│   ├── 30_analysis.R
│   └── 99_run_all.R
├── output/
│   └── stats_summary.csv
├── reports/
│   └── report.txt
└── projet_data.Rproj
```

---

## Étape 1 — `data/raw/` → import brut

### `R/10_import_raw.R`

```r
library(tidyverse)

# Lire les données brutes
iris_raw <- read_csv("data/raw/iris_raw.csv")

# Vérification rapide - inspect la structure
glimpse(iris_raw)
```

📌 Règle :

* **aucune modification**
* données telles qu'elles arrivent

---

## 3️⃣ Étape 2 — nettoyage → `data/processed/`

### `R/20_clean_data.R`

```r
library(tidyverse)

# On repart des données brutes
iris_clean <- iris_raw |>
  as_tibble() |>
  filter(!is.na(Species)) |>
  mutate(
    Species = as.factor(Species) # transforme du texte en variable qualitative 
  )

# Sauvegarde des données propres
write_csv(
  iris_clean,
  "data/processed/iris_clean.csv"
)
```

📌 Ici :

* conversions
* filtres simples
* **sortie intermédiaire persistée**

---

## Étape 3 — analyse → `output/`

### `R/30_analysis.R`

```r
library(tidyverse)

# Charger les données nettoyées
iris_clean <- read_csv("data/processed/iris_clean.csv")

# Statistiques par groupe
stats_summary <- iris_clean |>
  group_by(Species) |>
  summarise(
    n = n(),
    mean_sepal = mean(Sepal.Length),
    sd_sepal = sd(Sepal.Length),
    .groups = "drop"
  )

# Sauvegarde des résultats
write_csv(
  stats_summary,
  "output/stats_summary.csv"
)
```

📌 Ici :

* calculs
* **résultats chiffrés**
* pas de graphique

---

## Étape 4 — restitution → `reports/`

### `R/40_report.R` (simple, sans RMarkdown)

```r
library(tidyverse)

stats <- read_csv("output/stats_summary.csv")

# Rapport texte très simple
writeLines(
  c(
    "Rapport d'analyse - Iris",
    "",
    capture.output(print(stats))
  ),
  "reports/report.txt"
)
```

📌 Ici :

* pas de calcul
* **mise en forme / restitution**

---

## Script maître — tout enchaîner

### `R/99_run_all.R`

```r
source("R/10_import_raw.R")
source("R/20_clean_data.R")
source("R/30_analysis.R")
source("R/40_report.R")
```

👉 Une seule commande pour tout relancer.

# Exécutercette ligne de commande en console

```bash
source("R/99_run_all.R")
```

---

## Message pédagogique clé (à dire aux étudiants)

> Chaque dossier correspond à une étape logique du travail sur les données.

---

##  Règles simples 

* ❌ on ne modifie jamais `data/raw/`
* ✅ chaque étape écrit ses résultats
* ✅ les scripts sont courts et lisibles
* ✅ `run_all` doit toujours fonctionner

---

## Résumé 

```
raw        → données telles qu'elles arrivent
processed → données propres et réutilisables
output     → résultats chiffrés
reports    → restitution humaine
```
