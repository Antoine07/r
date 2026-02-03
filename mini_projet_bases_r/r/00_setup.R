# 00_setup.R
# Setup minimal du mini-projet
# - chargement des packages
# - définition des chemins
# - création des dossiers nécessaires

# Chargement explicite des dépendances
library(dplyr)
library(readr)
library(ggplot2)

# Définition des chemins (relatifs à la racine du projet)
data_raw_dir <- "data/raw"
data_processed_dir <- "data/processed"
output_tables_dir <- "output/tables"
output_figures_dir <- "output/figures"

# Création des dossiers si absents
dir.create(processed, showWarnings = FALSE, recursive = TRUE)
