# 105.1 — Cubes (tableaux de contingence) (exercices)

Correspond au chapitre: `Slides/105_1_cubes.md`

## Pourquoi R est conçu pour

- Construire des tableaux multi-dimensionnels (arrays) à partir d’une table.
- Calculer des marges (totaux) efficacement sans boucles.

## Données

Dataset: `TPs/r/data/sales.csv` avec `date`, `region`, `product`, `units`, `price`.

Pré-requis recommandé:

```r
sales <- read.csv("TPs/r/data/sales.csv", stringsAsFactors = FALSE)
sales$date <- as.Date(sales$date)
sales$revenue <- sales$units * sales$price
```

## Notions techniques à couvrir (checklist)

- `xtabs(value ~ dim1 + dim2 + ...)`
- `dim`, `dimnames`, indexation `[i, j, k]`, `drop = FALSE`
- `apply` pour les marges
- `as.data.frame` pour revenir à une table
- contrôles de cohérence avec `sum` / `aggregate`

---

## Exercice 1 — Construire le cube

1. Construire `cube <- xtabs(revenue ~ region + product + date, data = sales)`.
2. Afficher `class(cube)`, `dim(cube)`, `dimnames(cube)`.
3. Extraire:
   - la série temporelle `cube["North", "Keyboard", ]`
   - la matrice région × produit pour une date donnée (au choix)

## Exercice 2 — Marges (totaux)

À partir de `cube`, calculer:

1. `by_region <- apply(cube, 1, sum)`
2. `by_product <- apply(cube, 2, sum)`
3. `by_date <- apply(cube, 3, sum)`
4. `by_region_product <- apply(cube, c(1, 2), sum)`

Indiquer le type attendu de chaque résultat (vecteur / matrice).

## Exercice 3 — Retour en table “tidy”

1. Convertir le cube en table longue:
   - `cube_long <- as.data.frame(cube)`
   - renommer les colonnes en `region`, `product`, `date`, `revenue_total`
2. Filtrer les lignes où `revenue_total > 0`.
3. Pour chaque région, identifier le produit qui maximise `revenue_total` (sans boucle explicite, par exemple via `aggregate` + `split` + `lapply`).

## Exercice 4 — Contrôle de cohérence

1. Calculer le total `sum(sales$revenue)`.
2. Comparer avec `sum(cube)`.
3. Comparer `by_region` avec une agrégation directe:
   - `aggregate(revenue ~ region, data = sales, sum)`
4. Si une différence apparaît, proposer une cause plausible (types, NA, parsing date, etc.).

