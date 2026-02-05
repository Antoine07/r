library(tibble)
library(dplyr)

# ---------------------------
# Données
# ---------------------------

dossiers <- tibble(
  id = 1:8,
  depot = as.Date(c(
    "2026-01-02", "2026-01-05", "2026-01-10", "2026-01-15",
    "2026-02-01", "2026-02-10", "2026-03-01", "2026-03-10"
  )),
  validation = as.Date(c(
    "2026-01-12", "2026-01-20", "2026-01-25", "2026-02-05",
    "2026-02-20", "2026-02-18", "2026-03-20", "2026-03-25"
  ))
)

# voir les données avant de commencer à travailler dessus
head(dossiers, 2)
tail(dossiers, 2)

# ===========================
# SLICING — lignes
# ===========================

# Première ligne
dossiers[1, ]

# Dernière ligne
dossiers[nrow(dossiers), ]

# Lignes 1 à 3
dossiers[1:3, ]

# Lignes 5 à 8
dossiers[5:8, ]

# Lignes impaires
dossiers[seq(1, nrow(dossiers), by = 2), ]

# Lignes paires
dossiers[seq(2, nrow(dossiers), by = 2), ]

# ===========================
# SLICING — colonnes
# ===========================

# Une colonne (vecteur)
dossiers$id

# Une colonne (tibble)
dossiers["id"]

# Plusieurs colonnes par nom
dossiers[, c("id", "depot")]

# Plusieurs colonnes par position
dossiers[, 1:2]

# Exclure une colonne
dossiers[, -1]

# ===========================
# SLICING — conditions (filtres)
# ===========================

# Dossiers déposés en janvier
dossiers[dossiers$depot < as.Date("2026-02-01"), ]

# Dossiers validés en février
dossiers[
  dossiers$validation >= as.Date("2026-02-01") &
  dossiers$validation <= as.Date("2026-02-28"),
]

# Dossiers déposés après le 10 janvier
dossiers[dossiers$depot > as.Date("2026-01-10"), ]

# ===========================
# SLICING — mix lignes / colonnes
# ===========================

# Lignes 1 à 4, colonnes id + validation
dossiers[1:4, c("id", "validation")]

# Dossiers de février, seulement les dates
dossiers[
  dossiers$depot >= as.Date("2026-02-01"),
  c("depot", "validation")
]

# ===========================
# Préparation pour agrégation
# ===========================

dossiers$delai <- dossiers$validation - dossiers$depot
dossiers$mois_depot <- format(dossiers$depot, "%Y-%m")

format(as.Date("2026-01-15"), "%Y-%m")

# ===========================
# AGGREGATE — base R
# ===========================

# ===========================
# AGGREGATION — base R (sans ~)
# ===========================

# Pré-requis
dossiers$delai <- dossiers$validation - dossiers$depot
dossiers$mois_depot <- format(dossiers$depot, "%Y-%m")

# ---------------------------
# Délai moyen par mois
# ---------------------------

notes  <- c(12, 15, 10, 8)
classe <- c("A", "A", "B", "B")
tapply(notes, classe, mean)

delai_moyen_par_mois <- tapply(
  dossiers$delai,
  dossiers$mois_depot,
  mean
)

delai_moyen_par_mois

# ---------------------------
# Délai max par mois
# ---------------------------

delai_max_par_mois <- tapply(
  dossiers$delai,
  dossiers$mois_depot,
  max
)

delai_max_par_mois

# ---------------------------
# Plusieurs statistiques par mois
# ---------------------------

delai_stats_par_mois <- tapply(
  dossiers$delai,
  dossiers$mois_depot,
  function(x) c(mean = mean(x), max = max(x))
)

delai_stats_par_mois

# ===========================
# AGGREGATE — dplyr 
# ===========================

# Délai moyen par mois
dossiers |>
  group_by(mois_depot) |>
  summarise(delai_moyen = mean(delai))

# Délai min / max par mois
dossiers |>
  group_by(mois_depot) |>
  summarise(
    delai_min = min(delai),
    delai_max = max(delai)
  )

# Compter le nombre de dossiers par mois
dossiers |>
  group_by(mois_depot) |>
  summarise(nb_dossiers = n())
