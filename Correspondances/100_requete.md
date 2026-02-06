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

###  Moyenne d’âge par région

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

### Demandeurs de 30 ans ou plus

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

###  Moyenne d’âge des inscrits uniquement

**SAS**

```sas
select mean(age)
from demandeurs
where statut = "Inscrit";
```

**R**

```r
demandeurs |>
  filter(statut == "Inscrit") |>
  summarise(age_moyen = mean(age))
```

---

### Nombre d’inscrits par région

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

###  Créer une variable « tranche d’âge »

```sas
select *,
       case
         when age < 25 then "Jeune"
         when age < 50 then "Adulte"
         else "Senior"
       end as tranche
from demandeurs;
```

```r
demandeurs |>
  mutate(
    tranche = case_when(
      age < 25 ~ "Jeune",
      age < 50 ~ "Adulte",
      TRUE ~ "Senior"
    )
  )
```

---

### Nombre de demandeurs par tranche d’âge

**SAS**

```sas
select tranche, count(*)
from demandeurs
group by tranche;
```

**R**

```r
demandeurs |>
  mutate(
    tranche = case_when(
      age < 25 ~ "Jeune",
      age < 50 ~ "Adulte",
      TRUE ~ "Senior"
    )
  ) |>
  group_by(tranche) |>
  summarise(nb = n())
```

---

### Pourcentage d’inscrits

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
