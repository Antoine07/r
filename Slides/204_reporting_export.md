---
marp: true
theme: default
paginate: true
class: lead
---

# Jour 2 — Export & reporting

Objectif: partager des résultats et garder une analyse reproductible.

---

## Définitions

- **Export**: écrire un objet R sur disque (CSV, image…).
- **CSV**: format tabulaire texte (échange simple).
- **PNG**: format image (graphique exporté).
- **Rapport**: document qui combine texte + code + sorties (tables/graphes).
- **Reproductible**: relançable de bout en bout, avec les mêmes entrées.

---

## Pourquoi R est conçu pour cette étape

- Scripts + projets + rapports: chaîne de production complète.
- Exports standards (CSV/images) et rapports (Quarto/R Markdown) sont des livrables fréquents.
- La reproductibilité s'appuie sur: code versionné + données d'entrée + outputs régénérables.

---

## Exporter un CSV

```r
write.csv(sales, "sales_clean.csv", row.names = FALSE)
```

Avec `readr`:

```r
readr::write_csv(sales, "sales_clean.csv")
```

Définition: `sales` est un data frame/tibble.

---

## Exporter un objet R (RDS)

Pour conserver types/attributs exactement (usage interne R):

```r
saveRDS(sales, "sales_clean.rds")
sales2 <- readRDS("sales_clean.rds")
```

---

## Sauvegarder des graphiques

```r
library(ggplot2)

p <- ggplot(sales, aes(x = date, y = revenue)) + geom_point()
ggsave("plot_sales.png", p, width = 8, height = 4)
```

Définition: `p` est un objet ggplot.

---

## Reporting (optionnel)

Deux outils courants:
- R Markdown (`.Rmd`)
- Quarto (`.qmd`)

But:
- code + texte + graphiques + tableaux dans un même document

---

## Structure recommandée (projet)

```
my_project/
  data/raw/
  data/processed/
  r/
  output/
  reports/
```

Règle: `output/` doit être reconstruisible.

---

## Structure d'un mini-rapport

- contexte + question
- nettoyage + choix méthodo
- résultats (stats + graphes)
- conclusion métier
- limites

---

## Exercice (mini-rapport)

Sujet: `Exercices/204_reporting_export.md`

Notions à pratiquer:
- exports CSV et PNG (noms, dossiers, reproductibilité)
- sauvegarde RDS (différence avec CSV)
- mini-rapport structuré (question → méthode → résultats → conclusion)
