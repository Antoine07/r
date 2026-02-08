---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---


## Jeu de données (à copier dans R)

```r
library(tibble)
library(dplyr)

demandeurs <- tibble(
  id = 1:12,
  age = c(22, 34, 45, 29, 18, 41, 37, 26, 52, 31, 24, 39),
  sexe = c("F", "H", "F", "H", "F", "H", "F", "H", "H", "F", "F", "H"),
  region = c(
    "IDF", "IDF", "NAQ", "IDF",
    "NAQ", "OCC", "OCC", "NAQ",
    "IDF", "OCC", "NAQ", "IDF"
  ),
  statut = c(
    "Inscrit", "Inscrit", "Radié", "Inscrit",
    "Inscrit", "Inscrit", "Radié", "Inscrit",
    "Inscrit", "Radié", "Inscrit", "Inscrit"
  )
)

demandeurs
```

---

## Correspondances SAS (PROC SQL) ↔ R

---

###  Moyenne d'âge par région

**SAS**

```sas
proc sql;
  select region, mean(age) as age_moyen
  from demandeurs
  group by region;
quit;
```

**R**

```r
demandeurs |>
  group_by(region) |>
  summarise(age_moyen = mean(age))
```

---

###  Nombre de demandeurs par région

**SAS**

```sas
select region, count(*) as nb
from demandeurs
group by region;
```

**R**

```r
demandeurs |>
  group_by(region) |>
  summarise(nb = n())
```

---

### Demandeurs âgés de 30 ans ou plus

**SAS**

```sas
select *
from demandeurs
where age >= 30;
```

**R**

```r
demandeurs |>
  filter(age >= 30)
```

*Écriture équivalente plus explicite (recommandée dans les supports et les scripts robustes) :*

```r
demandeurs |>
  dplyr::filter(age >= 30)
```

> L'utilisation de `dplyr::filter()` permet d'indiquer explicitement le package d'origine et d'éviter toute ambiguïté avec des fonctions portant le même nom dans d'autres librairies.

---

###  Femmes par région

**SAS**

```sas
select region, count(*) as nb_femmes
from demandeurs
where sexe = "F"
group by region;
```

**R**

```r
demandeurs |>
  filter(sexe == "F") |>
  group_by(region) |>
  summarise(nb_femmes = n())
```

---

###  Âge minimum et maximum par région

**SAS**

```sas
select region, min(age), max(age)
from demandeurs
group by region;
```

**R**

```r
demandeurs |>
  group_by(region) |>
  summarise(
    age_min = min(age),
    age_max = max(age)
  )
```

---

###  Moyenne d'âge des inscrits uniquement

**SAS**

```sas
select mean(age)
from demandeurs
where statut = "Inscrit";
```

**R**

```r
demandeurs |>
  dplyr::filter(statut == "Inscrit") |>
  summarise(age_moyen = mean(age))
```

---

### Nombre d'inscrits par région

**SAS**

```sas
select region, count(*)
from demandeurs
where statut = "Inscrit"
group by region;
```

**R**

```r
demandeurs |>
  filter(statut == "Inscrit") |>
  group_by(region) |>
  summarise(nb = n())
```

---

### Pourcentage d'inscrits

**SAS**

```sas
select
  sum(case when statut = "Inscrit" then 1 else 0 end) / count(*) as taux
from demandeurs;
```

**R**

```r
demandeurs |>
  summarise(
    taux_inscrits = mean(statut == "Inscrit")
  )
```

---

## Exemple 1 — Jointure interne (INNER JOIN)

### Objectif

Conserver uniquement les demandeurs dont la région est connue dans la table de correspondance.

### Tables

```r
demandeurs
```

```text
id | region
---+--------
1  | IDF
2  | NAQ
3  | OCC
```

```r
regions
```

```text
region | nom_region
-------+-------------------
IDF    | Île-de-France
NAQ    | Nouvelle-Aquitaine
```

---

### SAS

```sas
select d.*, r.nom_region
from demandeurs d
inner join regions r
on d.region = r.region;
```

---

### R

```r
demandeurs |>
  inner_join(regions, by = "region")
```

---

### Résultat

- Seules les lignes avec une correspondance dans les deux tables sont conservées
- La région `OCC` est supprimée (pas de correspondance)

---

## Exemple 2 — Jointure gauche (LEFT JOIN)

### Objectif

Conserver **tous les demandeurs**, même si la région n'a pas de correspondance.

---

### SAS

```sas
select d.*, r.nom_region
from demandeurs d
left join regions r
on d.region = r.region;
```

---

### R

```r
demandeurs |>
  left_join(regions, by = "region")
```

---

### Résultat

- Tous les demandeurs sont conservés
- `nom_region` vaut `NA` si aucune correspondance n'existe


