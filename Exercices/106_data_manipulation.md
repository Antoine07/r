# 106 — Manipulation de données (exercices)

Correspond au chapitre: `SlideR/106_data_manipulation.md`

## Pourquoi R est conçu pour

- Enchaîner des transformations sur des tables de façon déclarative.
- Passer d'une table brute à une table “tidy” (propre) pour analyse et dataviz.

## Pré-requis

Créer un objet `sales` avec les colonnes:

- `date` (Date)
- `region`, `product`
- `units`, `price`
- `revenue = units * price`

## Notions techniques à couvrir (checklist)

- `dplyr`: `select`, `filter`, `arrange`, `mutate`, `group_by`/`summarise`
- `tidyr`: `pivot_longer`, `pivot_wider`, `separate`/`unite` (option)
- pipe `|>`
- agrégation 1 clé → 2 clés

---

## Exercice 1 — Préparer `sales`

1. Importer `TPs/r/data/sales.csv` avec `readr::read_csv`.
2. Créer `revenue` et convertir `date`.
3. Vérifier: `sum(is.na(sales$revenue)) == 0`.

## Exercice 2 — Sélection / filtre / tri

1. Garder uniquement `date`, `region`, `product`, `revenue`.
2. Filtrer les ventes de `North` avec `units >= 10`.
3. Trier par `revenue` décroissant.

## Exercice 3 — Variables dérivées

Ajouter:

- `is_bulk = units >= 20`
- `ticket = "HIGH"` si `revenue >= 500`, sinon `"LOW"`

## Exercice 4 — Agrégation (1 clé)

Calculer une table `by_region` avec:

- `n_sales` (nombre de lignes)
- `revenue_total` (somme)
- `revenue_mean` (moyenne)

## Exercice 5 — Agrégation (2 clés)

Calculer une table `by_region_product` avec:

- `revenue_total` par `(region, product)`
- tri décroissant au sein de chaque région (ou tri global)

## Bonus — Top N

Pour chaque région, extraire les 2 produits qui génèrent le plus de revenu.

---

## Exercice 6 — `tidyr` (wide → long → wide)

1. Créer un objet `wide`:

```r
wide <- tibble::tibble(
  region = c("North", "South"),
  revenue_2025 = c(100, 80),
  revenue_2026 = c(120, 90)
)
```

2. Transformer en “long” avec `tidyr::pivot_longer`:
   - `names_to = "year"`
   - `values_to = "revenue"`
3. Revenir en “wide” avec `tidyr::pivot_wider`.
