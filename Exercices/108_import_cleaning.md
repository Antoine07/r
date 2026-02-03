## Exercice — Nettoyage de données simples

On vous fournit un jeu de données brut `sales_raw` importé depuis un fichier CSV.

### Données brutes

```r
sales_raw <- tibble(
  date   = c("2024-01-01", "2024-01-02", "2024-01-03"),
  region = c("North", "South", "North"),
  units  = c("10", "5", "8"),
  price  = c("49.99", "49.99", "not_available")
)
```

---

## Objectif

Produire un jeu de données propre `sales_clean` prêt à être utilisé pour des calculs.

---

## Étapes demandées

1. Convertir la colonne `date` en type date
2. Convertir les colonnes `units` et `price` en type numérique
3. Identifier les lignes problématiques (valeurs manquantes après conversion)
4. Supprimer les lignes invalides
5. Créer une nouvelle colonne `revenue = units × price`

---

## Contraintes

* utiliser uniquement des fonctions simples
* pas de validation avancée
* pas de package supplémentaire obligatoire

---

## Résultat attendu

Un objet `sales_clean` qui :

* contient uniquement des colonnes bien typées
* ne contient plus de valeurs manquantes
* permet de calculer un chiffre d’affaires

---

## Indice (facultatif)

```r
as.Date()
as.numeric()
is.na()
```

---

## Bonus (optionnel)

Afficher la structure finale :

```r
str(sales_clean)
```
