---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# 111 — Stats + graphiques (variables catégorielles)

Objectif: faire une mini analyse exploratoire en combinant **stats descriptives** et **graphiques**, en gérant correctement les variables catégorielles avec `as.factor()` / `factor()`.

---

## Pourquoi `as.factor()` est important

En analyse de données, une variable peut être:

- **numérique** (quantitative): moyenne, écart-type, histogramme…
- **catégorielle** (qualitative): comptages, proportions, comparaison entre groupes…

Si une variable catégorielle est stockée en numérique (ex: `1/2/3`), on risque:
- des axes continus (mauvaise lecture)
- des agrégations “qui n’ont pas de sens” (moyenne de catégories)
- des graphiques trompeurs

---

## Données d’exemple — `mtcars`

`mtcars` est inclus dans R.

```r
library(tidyverse)
data(mtcars)
# as_tibble transforme le dataframe en tibble
# rownames = "model" 
# Prends les noms de lignes et mets-les dans une vraie colonne appelée model.
cars <- mtcars |>
  tibble::as_tibble(rownames = "model") |> 
  mutate(
    cyl = as.factor(cyl),
    am = factor(am, levels = c(0, 1), labels = c("Auto", "Manuelle"))
  )

glimpse(cars)
```

Variables utiles ici:
- `mpg`: consommation (numérique)
- `wt`: poids (numérique)
- `cyl`, `am`: groupes (facteurs)

---

## Comptages par groupe (table)

```r
cars |>
  count(cyl, am)

# rappel manière plus longue 
cars |>
  group_by(cyl, am) |>
  summarise(n = n())
```

Lecture: quels groupes sont sur/sous-représentés ?

---

## Comptages par groupe (barres)

```r
ggplot(cars, aes(x = cyl, fill = am)) +
  geom_bar() +
  labs(
    title = "Nombre de voitures par cylindres et transmission",
    x = "Cylindres",
    y = "Nombre",
    fill = "Transmission"
  )
```

Notion: `fill` permet une comparaison dans chaque catégorie.

---

## Stats descriptives par groupe

Objectif: comparer `mpg` entre groupes.

```r
cars |>
  group_by(cyl, am) |>
  summarise(
    n = n(),
    mpg_mean = mean(mpg),
    mpg_sd = sd(mpg),
    mpg_median = median(mpg),
    .groups = "drop"
  )
```

Notion: `group_by()` + `summarise()` = table de synthèse.

---

## Comparer des distributions (boxplot)

Un boxplot compare une distribution par groupe.

```r
ggplot(cars, aes(x = cyl, y = mpg, fill = am)) +
  geom_boxplot(alpha = 0.6) +
  labs(
    title = "mpg par cylindres (stratifié par transmission)",
    x = "Cylindres",
    y = "mpg",
    fill = "Transmission"
  )
```

---

## Relation entre 2 variables (nuage de points)

```r
ggplot(cars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(alpha = 0.8) +
  labs(
    title = "mpg vs wt, coloré par cylindres",
    x = "Poids (wt)",
    y = "mpg",
    color = "Cylindres"
  )
```

Option simple: ajouter une tendance.

```r
ggplot(cars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Tendance mpg ~ wt (par cylindres)")
```

---

## Données avec “codes” — `airquality`

Ici, `Month` est numérique (5..9) mais c’est une **catégorie**.

```r
data(airquality)
aq <- airquality |>
  as_tibble() |>
  mutate(
    Month = factor(
      Month,
      levels = 5:9,
      labels = c("May", "Jun", "Jul", "Aug", "Sep")
    )
  )

glimpse(aq)
```

---

## NA et stats par groupe

`Ozone` contient des `NA` → utiliser `na.rm = TRUE`.

```r
aq |>
  group_by(Month) |>
  summarise(
    n = n(),
    ozone_mean = mean(Ozone, na.rm = TRUE),
    ozone_median = median(Ozone, na.rm = TRUE),
    .groups = "drop"
  )
```

---

## Ozone par mois (graphiques simples)

```r
ggplot(aq, aes(x = Month, y = Ozone)) +
  geom_boxplot() +
  labs(title = "Ozone par mois", x = "Mois", y = "Ozone")
```

Option: visualiser la moyenne par mois (table + plot).

```r
oz_by_month <- aq |>
  group_by(Month) |>
  summarise(ozone_mean = mean(Ozone, na.rm = TRUE), .groups = "drop")

ggplot(oz_by_month, aes(x = Month, y = ozone_mean, group = 1)) +
  geom_line() +
  geom_point() +
  labs(title = "Ozone moyen par mois", x = "Mois", y = "Ozone moyen")
```

---

## Exercices

Sujet: `Exercices/111_stats_graphs.md`  

