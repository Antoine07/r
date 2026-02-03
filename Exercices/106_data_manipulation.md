# Exercice — Analyse et restructuration de données de ventes

## Contexte métier

Vous travaillez dans une équipe **data / reporting**.
On vous fournit un extrait de ventes issues du système d'information commercial.

Chaque ligne correspond à une transaction avec :

* `date` : date de la vente
* `region` : région commerciale
* `product` : produit vendu
* `units` : quantité vendue
* `price` : prix unitaire

L'objectif est de **produire des indicateurs exploitables** à partir de ces données.

```r
url <- "https://raw.githubusercontent.com/Antoine07/r/refs/heads/main/data/sales.csv"
sales <- readr::read_csv(url, show_col_types = FALSE)

# Aperçu rapide des premières lignes pour comprendre la structure
head(sales)

# Résumé statistique global pour détecter valeurs aberrantes ou incohérences
summary(sales)
```

---

## Partie 1 — Préparation des données

1. Vérifier le type des colonnes.
1. Créer une colonne `revenue` correspondant au chiffre d'affaires par ligne.
1. Vérifier que la colonne `date` est bien de type `Date`.

---

## Partie 2 — Filtrage et tri (logique ligne)

À partir de la table `sales` :

1. Conserver uniquement les ventes de la région `"North"`.
1. Parmi ces ventes, garder celles dont `units >= 10`.
1. Trier les résultats par chiffre d'affaires décroissant.
1. Ne conserver que les colonnes suivantes :

   * `date`
   * `product`
   * `units`
   * `revenue`

---

## Partie 3 — Agrégation métier

1. Calculer, par région :

   * le nombre de ventes
   * le chiffre d'affaires total
   * le chiffre d'affaires moyen
1. Expliquer en une phrase le rôle de `group_by()` et de `summarise()` dans ce calcul.
1. Identifier la région avec le chiffre d'affaires total le plus élevé.

---

## Partie 4 — Passage du format wide au format long

On vous fournit maintenant la table suivante :

```r
wide <- tibble::tibble(
  region = c("North", "South"),
  revenue_2025 = c(100, 80),
  revenue_2026 = c(120, 90)
)
```

1. Expliquer pourquoi cette table est au format **wide**.
1. Transformer cette table en un format **long** avec :

   * une colonne `year`
   * une colonne `revenue`
1. Vérifier le nombre de lignes du tableau obtenu et expliquer ce résultat.

---

## Partie 5 — Exploitation du format long

À partir de la table `long` :

1. Nettoyer la colonne `year` pour ne conserver que l'année (`2025`, `2026`).
1. Convertir `year` en entier.
1. Calculer le chiffre d'affaires total par année.
1. Expliquer pourquoi ces calculs sont plus simples en format long qu'en format wide.

---

## Question de raisonnement (importante)

En quelques lignes :

1. Dans quels cas un format **wide** peut-il être préférable ?
1. Pourquoi le format **long** est-il privilégié en analyse de données et en reporting ?

---

## Objectifs pédagogiques (non visibles par les étudiants)

* utiliser le pipe `|>` pour enchaîner des transformations
* maîtriser `select`, `filter`, `arrange`, `mutate`
* comprendre `group_by()` et `summarise()`
* comprendre et appliquer `pivot_longer()`
* faire le lien **structure des données → capacité d'analyse**
