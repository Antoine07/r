# 108 — Import & nettoyage (exercices)

Correspond au chapitre: `SlideR/108_import_cleaning.md`

## Pourquoi R est conçu pour

- Importer une table (CSV) et la transformer rapidement (types, colonnes dérivées).
- Ajouter des contrôles (qualité, invariants) dès l'entrée.

## Données

- Dataset: `TPs/r/data/sales.csv`
- Colonnes attendues: `date`, `region`, `product`, `units`, `price`

## Notions techniques à couvrir (checklist)

- `read.csv(..., stringsAsFactors = FALSE)` et/ou `readr::read_csv`
- parsing: `as.Date`, `as.integer`, `as.numeric` (+ `suppressWarnings`)
- `NA`, `is.na`, `anyNA`, `na.rm`
- contrôles: `stop`, `stopifnot`, `setdiff`, `names`
- écriture: `dir.create`, `write.csv`, `readr::write_csv`

---

## Exercice 1 — Import base R

1. Importer le fichier dans `sales_raw`.
2. Vérifier les colonnes attendues:
   - calculer la liste des colonnes manquantes (si existantes)
   - arrêter avec `stop()` si une colonne manque
3. Afficher `str(sales_raw)` et `summary(sales_raw)`.

## Exercice 2 — Parsing des types

Créer `sales` à partir de `sales_raw` et appliquer:

1. `sales$date <- as.Date(sales$date)`
2. `sales$units <- as.integer(sales$units)`
3. `sales$price <- as.numeric(sales$price)`

Puis:

- vérifier que la conversion n'a pas créé de `NA` inattendus
- vérifier que `units >= 0` et `price >= 0`

## Exercice 3 — Variable dérivée

1. Créer `sales$revenue <- sales$units * sales$price`.
2. Vérifier qu'il n'y a pas de `NA` dans `revenue` (ou expliquer leur origine).

## Exercice 4 — Version “processed”

1. Créer le dossier `data/processed/` (si absent).
2. Écrire `sales` dans `data/processed/sales_clean.csv`.

## Bonus — Import `readr` (option)

1. Refaire l'import avec `readr::read_csv`.
2. Comparer `str()` (ou `glimpse`) des deux objets.
3. Identifier les différences de types éventuelles.
