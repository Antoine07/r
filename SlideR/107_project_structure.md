---
marp: true
theme: default
paginate: true
class: lead
---

# Organiser un projet R (production)

But: démarrer vite avec une structure standard, sans complexité inutile.

---

## Le problème (souvent)

- scripts éparpillés, chemins absolus
- données mélangées avec les sorties
- difficile à relancer et à reproduire

---

## Le principe

1. Une **racine de projet** (fichier `.Rproj`)
2. Des **dossiers** aux rôles clairs
3. Un **pipeline** exécutable de bout en bout

---

## Démarrer: RStudio Project

- Le projet fixe le dossier racine
- Les chemins doivent rester relatifs
- Éviter `setwd()` dans les scripts

Réglage recommandé (reproductibilité):

- ne pas restaurer/sauvegarder le workspace

---

## Concept 1 — Vecteur (brique de base)

Un vecteur est une suite d’éléments (en général d’un même type).

```r
units <- c(12, 25, 8)
units >= 10
sum(units)
```

Idée clé: beaucoup d’opérations R sont **vectorisées**.

---

## Concept 2 — Data frame (table)

Un **data frame** est une table:

- chaque **colonne** est un vecteur
- toutes les colonnes ont la **même longueur**
- les colonnes peuvent avoir des **types différents**

```r
df <- data.frame(
  region = c("North", "South"),
  units = c(12L, 8L),
  price = c(49.99, 49.99)
)
str(df)
```

---

## Accéder aux colonnes (data frame)

```r
df$units
names(df)
nrow(df)
```

Filtrer des lignes:

```r
df[df$region == "North", ]
```

Sélectionner des colonnes:

```r
df[, c("region", "units")]
```

---

## Expressivité de R (exemples)

Créer une colonne dérivée (vectorisation):

```r
df$revenue <- df$units * df$price
```

Agréger (interface formule):

```r
aggregate(revenue ~ region, data = df, sum)
```

Une même intention peut être exprimée en peu de code, tout en restant lisible.

---

## Structure minimale (recommandée)

```
my_project/
  my_project.Rproj
  README.md
  .gitignore

  data/
    raw/        # données source (entrée)
    processed/  # données dérivées (reconstruites)

  r/            # scripts (pipeline)

  output/       # sorties (reconstruites)
    tables/
    figures/

  reports/      # rapport(s) Quarto/Rmd
```

---

## Règle d’or: flux de production

- `data/raw/` → scripts → `data/processed/`
- `data/processed/` → scripts → `output/`
- `reports/` consomme `data/processed/` et `output/`

Tout fichier dans `output/` doit être régénérable.

---

## Nommer les scripts (simple et efficace)

- `r/00_setup.R`: chemins + création des dossiers
- `r/01_import.R`: import + nettoyage + validation
- `r/02_summaries.R`: agrégations, tables
- `r/03_plots.R`: figures
- `r/run_all.R`: exécution dans l’ordre

---

## Chemins: portables (base R)

Objectif: aucune dépendance à une machine.

```r
stopifnot(file.exists("my_project.Rproj"))
raw_path <- "data/raw/sales.csv"
stopifnot(file.exists(raw_path))
```

---

## Validation: échouer tôt

Exemples (base R):

```r
required <- c("date", "region", "units")
missing <- setdiff(required, names(df))
if (length(missing) > 0) stop(paste("Colonnes manquantes:", paste(missing, collapse = ", ")))

if (any(df$units < 0, na.rm = TRUE)) stop("`units` doit être >= 0")
```

---

## Git: quoi versionner ?

À versionner:

- scripts (`r/`), rapports (`reports/`), documentation (`README.md`)
- données sources si autorisé (`data/raw/`)
- (si utilisé) `renv.lock`

À ignorer (reconstruisible):

- `output/`
- souvent `data/processed/`

---

## `renv`: à quoi cela sert ?

`renv` fige les versions de packages **au niveau du projet**.

Problèmes typiques sans `renv`:

- un collègue met à jour `dplyr`/`readr` → un script se met à échouer
- une version change l’inférence des types → résultats différents
- reprise du projet plus tard → les versions installées ne correspondent plus

---

## `renv`: exemple concret

Un rapport dépend de `readr` et `dplyr`.

- Poste A: `readr` v2.1.x → import OK
- Poste B: `readr` v2.2.x → warnings / types inférés différemment

Avec `renv`, `renv.lock` décrit exactement les versions, et tout le monde restaure le même environnement.

---

## `renv`: workflow minimal

Dans la racine du projet:

```r
install.packages("renv")
renv::init()
```

Après ajout/retrait de packages:

```r
renv::snapshot()
```

Sur une autre machine:

```r
renv::restore()
```

À versionner: `renv.lock`.

---

## Template prêt à l’emploi

Le dossier `project_r/` fournit une base opérationnelle, avec 2 modes:

- **starter simple**: un seul script pour découvrir la logique (import → sorties)
- **starter structuré**: scripts séparés (import → processed → output → rapport)

Objectif: commencer à travailler immédiatement, puis adapter.
