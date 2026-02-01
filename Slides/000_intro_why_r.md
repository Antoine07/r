---
marp: true
theme: default
paginate: true
class: lead
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

- Expressif pour la donnée tabulaire (data frames)
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
