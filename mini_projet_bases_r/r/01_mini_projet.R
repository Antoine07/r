# Mini-projet — Bases R

source("r/00_setup.R")

# Étape 1 — Importer le CSV dans un data frame `sales`
# Indice: read.csv(..., stringsAsFactors = FALSE)
# TODO

# Étape 2 — Décrire l'objet
# - afficher les 6 premières lignes
# - afficher la structure (types)
# TODO

# Étape 3 — Corriger/assurer les types
# - convertir `date` en Date
# - convertir `units` en integer
# - convertir `price` en numeric
# TODO

# Étape 4 — Expressivité / vectorisation
# Créer une nouvelle colonne `revenue = units * price`
# TODO

# Étape 5 — Filtrer et sélectionner
# Créer un objet `north` qui ne contient que la région "North" et les colonnes:
# date, product, units, price, revenue
# TODO

# Étape 6 — Agréger
# Calculer le revenu total par région sous forme de data frame `revenue_by_region`.
# Indice: aggregate(revenue ~ region, data = sales, sum)
# TODO

# Étape 7 — Sauvegarder les sorties (reproductible)
# Écrire `revenue_by_region` dans output/tables (CSV)
# Générer un barplot dans output/figures (PNG)
# TODO
