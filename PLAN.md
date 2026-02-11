# PLAN — Vidéo (5–10 min) : Refaire le projet `file_csv_demo` dans RStudio

## Objectif vidéo

Reproduire un mini-projet R **sans base de données** à partir de **2 fichiers CSV** (`regions` + `applicants`) en suivant une pipeline :
`setup → load → transform → analyse → extract`.

Objectif “démo livrable” : produire à la fin un dossier `output/` avec :
- `applicants_clean.csv`
- `by_region.csv`
- `deliverable.xlsx` (optionnel, si `writexl` installé)
- `report.html` (optionnel, si `rmarkdown` + `knitr` installés)

## Pré-requis (à afficher au début)

- Avoir R et RStudio installés
- Packages (une seule fois) :
  - `install.packages(c("dplyr", "tibble", "readr", "here"))`
- Optionnel (pour Excel + rapport HTML) :
  - `install.packages(c("writexl", "rmarkdown", "knitr"))`
- Durée cible : **5 à 10 minutes**

## Structure du projet (résultat final)

À la racine du projet :

- `file_csv_demo.Rproj`
- `run_all.R`
- `data/regions.csv`
- `data/applicants.csv`
- `r/setup.R`
- `r/load.R`
- `r/transform.R`
- `r/analyse.R`
- `r/extract.R`
- `report.Rmd` (rapport simple)
- `output/` (créé automatiquement)

## Script vidéo (séquençage)

### 1) Intro (20–30s)

- Présenter l’objectif : “2 fichiers → jointure → indicateurs → export”
- Dire que c’est la base d’un projet relançable

### 2) Créer le projet RStudio (45–60s)

- File → New Project → New Directory → New Project
- Nom : `file_csv_demo`
- Vérifier que le `.Rproj` est créé
- Créer les dossiers :
  - `data/`
  - `r/`
  - (optionnel) `output/` peut être créé à la main, mais le script le crée aussi automatiquement

### 3) Créer les données CSV (60–90s)

Créer `data/regions.csv` :

```csv
region_code,region_name
IDF,Île-de-France
NAQ,Nouvelle-Aquitaine
OCC,Occitanie
```

Créer `data/applicants.csv` :

```csv
applicant_id,age,gender,region_code,status,created_at
1,22,F,IDF,Registered,2024-01-02T09:10:00+00
2,34,M,IDF,Registered,2024-01-05T11:30:00+00
3,45,F,NAQ,Removed,2024-01-07T08:00:00+00
4,29,M,IDF,Registered,2024-01-12T16:45:00+00
5,18,F,NAQ,Registered,2024-01-15T10:05:00+00
6,41,M,OCC,Registered,2024-01-18T14:20:00+00
7,37,F,OCC,Removed,2024-01-20T13:10:00+00
8,26,M,NAQ,Registered,2024-01-21T09:50:00+00
9,52,M,IDF,Registered,2024-01-23T18:30:00+00
10,31,F,OCC,Removed,2024-01-25T07:25:00+00
```

### 4) `r/setup.R` (45–60s)

Objectif : charger les packages et définir les chemins.

Créer `r/setup.R` :

```r
# install.packages(c("dplyr", "tibble", "readr", "here")) # une seule fois
library(dplyr)
library(tibble)
library(readr)
library(here)

REGIONS_FILE <- here("data", "regions.csv")
APPLICANTS_FILE <- here("data", "applicants.csv")

if (!file.exists(REGIONS_FILE)) stop("Fichier manquant: ", REGIONS_FILE)
if (!file.exists(APPLICANTS_FILE)) stop("Fichier manquant: ", APPLICANTS_FILE)
```

Point à dire : “setup = dépendances + chemins, pas de logique métier”.

### 5) `r/load.R` (60–90s)

Objectif : lire les CSV et créer `regions_raw` + `applicants_raw`.

Créer `r/load.R` :

```r
source("r/setup.R")

regions_raw <- read_csv(REGIONS_FILE, show_col_types = FALSE) |>
  as_tibble()

applicants_raw <- read_csv(APPLICANTS_FILE, show_col_types = FALSE) |>
  as_tibble() |>
  mutate(
    applicant_id = as.integer(applicant_id),
    age = as.numeric(age),
    gender = as.character(gender),
    region_code = as.character(region_code),
    status = as.character(status),
    created_at = as.character(created_at)
  )

message("Tables chargées : applicants_raw=", nrow(applicants_raw), " | regions_raw=", nrow(regions_raw))
```

Démo console :
- exécuter `source("r/load.R")`
- montrer `glimpse(applicants_raw)` (optionnel)

### 6) `r/transform.R` (60–90s)

Objectif : jointure + variable `age_group`.

Créer `r/transform.R` :

```r
source("r/setup.R")

if (!exists("applicants_raw") || !exists("regions_raw")) {
  stop("Objets manquants : exécutez d'abord r/load.R")
}

applicants <- applicants_raw |>
  left_join(regions_raw, by = "region_code") |>
  mutate(
    region_name = coalesce(region_name, "Unknown"),
    age_group = case_when(
      is.na(age) ~ NA_character_,
      age < 18 ~ "<18",
      age <= 25 ~ "18-25",
      age <= 35 ~ "26-35",
      age <= 45 ~ "36-45",
      age <= 60 ~ "46-60",
      TRUE ~ "60+"
    )
  )

message("Transform OK : applicants=", nrow(applicants))
```

Démo :
- `source("r/transform.R")`
- montrer `count(applicants, region_name)`

### 7) `r/analyse.R` (60–90s)

Objectif : indicateurs simples.

Créer `r/analyse.R` :

```r
source("r/setup.R")

if (!exists("applicants")) stop("Objet 'applicants' absent : exécutez d'abord r/transform.R")

by_region <- applicants |>
  group_by(region_name) |>
  summarise(
    nb_applicants = n(),
    age_mean = mean(age, na.rm = TRUE),
    .groups = "drop"
  ) |>
  arrange(desc(nb_applicants))

registered_rate <- applicants |>
  summarise(registered_rate = mean(status == "Registered", na.rm = TRUE)) |>
  pull(registered_rate)

message("Indicateurs :")
print(by_region)
message("Registered rate = ", round(registered_rate, 3))
```

Démo :
- `source("r/analyse.R")`

### 8) `r/extract.R` (45–60s)

Objectif : exporter des livrables dans `output/` (CSV + Excel + rapport HTML).

Créer `r/extract.R` :

```r
source("r/setup.R")

if (!dir.exists("output")) dir.create("output", recursive = TRUE)

if (!exists("applicants")) stop("Objet 'applicants' absent : exécutez d'abord r/transform.R")
if (!exists("by_region")) stop("Objet 'by_region' absent : exécutez d'abord r/analyse.R")

write_csv(applicants, "output/applicants_clean.csv")
write_csv(by_region, "output/by_region.csv")

if (requireNamespace("writexl", quietly = TRUE)) {
  writexl::write_xlsx(
    x = list(applicants_clean = applicants, by_region = by_region),
    path = "output/deliverable.xlsx"
  )
}

if (requireNamespace("rmarkdown", quietly = TRUE)) {
  rmarkdown::render(
    input = "report.Rmd",
    output_file = "report.html",
    output_dir = "output",
    quiet = TRUE
  )
}

message("Exports OK → dossier output/")
```

Démo :
- `source("r/extract.R")`
- montrer `output/` dans le panneau Files
- ouvrir `output/report.html` (si généré)
- ouvrir `output/deliverable.xlsx` (si généré)

### 9) `run_all.R` (20–30s)

Créer `run_all.R` :

```r
source("r/load.R")
source("r/transform.R")
source("r/analyse.R")
source("r/extract.R")
```

Démo finale :
- fermer la session (ou `rm(list = ls())`)
- `source("run_all.R")` pour prouver que tout se relance

### 10) Conclusion (15–20s)

- Rappeler la logique : raw → clean → indicateurs → exports
- Prochaine étape suggérée : ajouter un graphique `ggplot2` ou passer le rapport en Quarto
