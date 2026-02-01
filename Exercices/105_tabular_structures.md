# TP — Analyse de ventes avec `tibble`

## Contexte métier

Vous travaillez au sein d'une équipe **data / reporting**.
On vous confie un extrait de ventes issues du système d'information commercial.

Chaque ligne correspond à une transaction avec :

* `date` : date de la vente
* `region` : région commerciale
* `product` : produit vendu
* `units` : quantité vendue
* `price` : prix unitaire

Votre mission est de **préparer, analyser et synthétiser** ces données pour aider à la prise de décision.

👉 **Contraintes** :

* vous utilisez exclusivement des **tibbles**
* pas de `data.frame` explicite
* pas de boucles `for`

---

## Partie 1 — Import et validation des données

1. Importer le fichier `sales.csv` avec `readr`.
2. Vérifier que l'objet importé est bien un `tibble`.
3. Vérifier le type de chaque colonne.
4. Indiquer pourquoi le typage automatique est un point critique dans un contexte métier.
5. Vérifier l'absence de valeurs manquantes dans les colonnes numériques.

---

## Partie 2 — Enrichissement métier

1. Créer une nouvelle colonne `revenue` correspondant au chiffre d'affaires par ligne.
2. Vérifier le type de cette colonne.
3. Justifier pourquoi ce calcul doit être fait **au niveau ligne** et non après agrégation.
4. Ajouter une colonne logique `high_value_sale` qui vaut `TRUE` si :

   * `revenue > 500`
5. Compter le nombre de ventes à forte valeur.

---

## Partie 3 — Analyse par axe métier

### Analyse par région

1. Calculer le chiffre d'affaires total par région.
2. Identifier la région avec le chiffre d'affaires le plus élevé.
3. Calculer la part (%) de chaque région dans le chiffre d'affaires total.

---

### Analyse par produit

1. Calculer :

   * le chiffre d'affaires total par produit
   * le nombre total d'unités vendues par produit
2. Identifier le produit le plus rentable (CA).
3. Comparer un produit à faible volume mais fort prix avec un produit à fort volume.

---

## Partie 4 — Analyse temporelle

1. Calculer le chiffre d'affaires total par date.
2. Identifier la journée avec le chiffre d'affaires maximum.
3. Ajouter une colonne `weekday` (jour de la semaine).
4. Comparer les performances entre jours ouvrés et week-end (si pertinent).
5. Justifier l'intérêt de cette analyse pour le pilotage commercial.

---

## Partie 5 — Synthèse et restitution

1. Construire un **tibble de synthèse** contenant :

   * le CA total
   * le CA moyen par jour
   * le nombre total de ventes
2. Donner une interprétation métier de ces indicateurs.
3. Proposer **une recommandation** à partir des résultats observés.

---

## Partie 6 — Qualité et bonnes pratiques

1. Expliquer pourquoi l'usage de `tibble` est préférable à `data.frame` dans ce contexte.
2. Identifier deux risques métiers liés à des conversions implicites de type.
3. Expliquer pourquoi les `rownames` sont à éviter dans un pipeline de données.

---

## Bonus — Mise en situation réelle

Votre manager vous demande :

> *“Peut-on facilement ajouter une nouvelle région ou un nouveau produit sans casser l'analyse ?”*

1. Expliquez en quoi la structure actuelle le permet (ou non).
2. Indiquez ce qu'il faudrait adapter dans le code si le volume de données était multiplié par 100.

---

## Objectifs pédagogiques (non visibles par les apprenants)

* manipuler un tibble comme structure centrale
* raisonner en **métriques métier**
* structurer une analyse avant toute visualisation
* préparer les notions d'agrégation avancée et de reporting
* adopter une posture data professionnelle
