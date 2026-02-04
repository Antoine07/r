---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Historique 

Dans les années 1970, le langage S est développé aux Bell Labs pour la statistique.
En 1993, R est créé par Ross Ihaka et Robert Gentleman comme version libre de S, dédiée à l'analyse de données.
En parallèle, Python, créé en 1991, se développe comme langage généraliste et sera ensuite largement utilisé en data science.

---

>Pour un usage R "classique" : **inutile d'investir**.

---
 # Ma machine

Machine : Mac Apple Silicon
SoC : Apple M4 Pro
RAM : 24 Go unifiée

Stockage : SSD Apple (très rapide)
OS : macOS

👉 C'est une machine haut de gamme orientée calcul et data. `Elle est sur-dimensionnée`

---

## Configuration minimale (fonctionne sans frustration)

👉 Adaptée à l'enseignement, aux projets modestes, aux datasets moyens.

- **CPU** : 4 cœurs (Intel i5 / Ryzen 5 équivalent)
- **RAM** : **8 Go** (strict minimum acceptable)
- **Stockage** : **SSD** (obligatoire aujourd'hui), 256 Go
- **OS** : Windows, macOS ou Linux (R est agnostique, ne dépend pas du matériel)
- **Écran** : Full HD minimum

---

## Configuration recommandée (confort + long terme)

👉 C'est **le meilleur compromis** pour 90 % des usages R.

- **CPU** : 6–8 cœurs (Ryzen 7 / Intel i7)
- **RAM** : **16 Go** (idéal pour R)
- **Stockage** : SSD NVMe, 512 Go
- **Écran** : 2 écrans ou 1 écran large (gain énorme de productivité)

---

Confortable pour :

- gros data frames
- jointures complexes
- `ggplot2` lourds
- RStudio / Positron + navigateur + PDF ouverts

---

💡 En R, **la RAM est plus importante que le CPU**.

---

### RAM > CPU > GPU

Pourquoi ?

- R charge les données **en mémoire**
- copier un data frame = consommation RAM immédiate
- swap disque = lenteur dramatique

---


# Introduction — Pourquoi R ?

Contexte d'utilisation, atouts, et exemples de projets réalisés avec R.

---

## Définition

- **R**: langage dédié au calcul, à la statistique et à la data.
- **Usage courant**: transformer des données, analyser, modéliser, visualiser, puis livrer un résultat reproductible.

---

## Dans quels contextes R est pertinent ?

- Analyse exploratoire et production d'indicateurs (KPI, Key Performance Indicators)
- Études statistiques (comparaisons, tests, régression)
- Automatisation de traitements (import, nettoyage, agrégations)
- Dataviz (graphes interprétables, exportables)
- Reporting reproductible (Quarto/R Markdown)

---

## Avantages de R (pratiques)

- Expressif pour la donnée tabulaire (data frames, mais on utilisera `tibble`)
- Écosystème riche (ex: `tidyverse`, `ggplot2`)
- Très bon support statistique (fonctions natives + packages)
- Reproductibilité: scripts + projets + rapports
- Interopérable: CSV/Excel/SQL, API, Python (selon besoins)

---

## Travail reproductible: une chaîne de production

Objectif: pouvoir relancer et obtenir le même résultat.

Exemple de chaîne typique:

1. Import (`data/raw/`)
2. Nettoyage + dérivations (`data/processed/`)
3. Tables/figures (`output/`)
4. Rapport (`reports/`)

---

## Exemples de projets métiers (marketing)

- Analyse de campagne: coûts, conversions, ROI, segments
- A/B testing: comparaison de taux de conversion entre variantes
- Cohortes: évolution d'un indicateur par date d'acquisition
- Scoring simple (régression/logistique) pour prioriser des leads

---

## Exemples de projets métiers (finance/contrôle)

- Suivi CA / marge: agrégations par période, produit, zone
- Détection d'anomalies: ruptures, valeurs aberrantes
- Prévisions simples: tendances, saisonnalité (selon données)
- Automatisation de reporting mensuel (exports + graphiques)

---

## Exemples de projets métiers (ops / produit / data)

- Qualité de données: contrôles, alertes, tableaux de validation
- Suivi produit: funnels, rétention, churn (cohortes)
- Support/qualité: analyse de tickets (catégories, volumes)
- Supply: volumes, délais, performance par site

---

## Exemples de livrables

- Un dossier projet (scripts + données + sorties)
- Un rapport HTML/PDF (Quarto)
- Des exports CSV (tables de synthèse)
- Des figures (PNG/PDF) pour slides/notes
