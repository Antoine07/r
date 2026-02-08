---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Dates avancées en R (avec comparaisons SAS)

Objectif : manipuler des **dates / datetimes** sans pièges (format, mois, fuseaux) et faire le pont avec les réflexes SAS.

---

## R vs SAS : types “date” et “datetime”

- **SAS `date`** : nombre de **jours** depuis `01JAN1960`
- **SAS `datetime`** : nombre de **secondes** depuis `01JAN1960:00:00:00`
- **R `Date`** : nombre de **jours** depuis `1970-01-01`
- **R `POSIXct`** : nombre de **secondes** depuis `1970-01-01 00:00:00` (Unix epoch)

Idée clé : l’objet a une **valeur interne** + un **format d’affichage**.

---

## SAS : littéraux et affichage

```sas
/* Littéraux */
d  = '31DEC2024'd;
dt = '31DEC2024:14:30:00'dt;

/* Affichage */
format d yymmdd10. dt e8601dt19.;
```

- Le **format** SAS change l’affichage, pas la valeur interne

---

## R : créer et afficher une date / datetime

```r
d <- as.Date("2024-12-31")
dt <- as.POSIXct("2024-12-31 14:30:00", tz = "Europe/Paris")

format(d, "%Y-%m-%d")
format(dt, "%Y-%m-%d %H:%M:%S %Z")
```

- `format()` change l’**affichage** (et retourne du `character`)
- Garder l’objet `Date` / `POSIXct` pour calculer

---

## Parsing : SAS (informat) ↔ R (format)

**SAS**

```sas
input date_txt : yymmdd10.;
```

**R (base)**

```r
as.Date("2024-12-31", format = "%Y-%m-%d")
```

**R (lubridate)**

```r
lubridate::ymd("2024-12-31")
```

---

## Extraire des composants (année, mois, jour…)

**SAS**

```sas
annee = year(d);
mois  = month(d);
jour  = day(d);
```

**R (lubridate)**

```r
library(lubridate)
annee <- year(d)
mois  <- month(d)
jour  <- day(d)
```

---

## Date vs datetime : conversions fréquentes

**SAS**

```sas
d  = datepart(dt);          /* datetime -> date */
dt = dhms(d, 0, 0, 0);      /* date -> datetime (minuit) */
```

**R**

```r
as.Date(dt)                                  # datetime -> date
as.POSIXct(d, tz = "Europe/Paris")           # date -> datetime (minuit)
```

---

## Séquences : générer un calendrier

**SAS**

```sas
do d = '01JAN2024'd to '31JAN2024'd;
  output;
end;
```

**R**

```r
seq.Date(as.Date("2024-01-01"), as.Date("2024-01-31"), by = "day")
```

---

## Ajouter “1 mois” : piège classique

- Ajouter **30 jours** ≠ ajouter **1 mois**
- Exemple : `2024-01-31 + 30` ne donne pas “fin février”

**SAS (`INTNX`)**

```sas
fin_mois_suiv = intnx('month', d, 1, 'e');
```

**R (lubridate)**

```r
fin_mois_suiv <- ceiling_date(d, "month") - days(1)
```

---

## Décalages et arrondis temporels (mêmes idées)

**SAS**

```sas
debut_mois = intnx('month', d, 0, 'b');
```

**R**

```r
debut_mois <- floor_date(d, "month")
```

---

## Différences : `INTCK` (SAS) ↔ `difftime` (R)

**SAS**

```sas
nb_jours = intck('day', d0, d1);
```

**R**

```r
as.numeric(d1 - d0)                 # jours
as.numeric(difftime(dt1, dt0, "hours"))
```

À retenir : en R, la différence de `Date` est naturellement en jours.

---

## Fuseaux horaires et DST (heure d’été)

- En R, `POSIXct` dépend d’un `tz` pour l’interprétation/affichage
- Les changements d’heure (DST) créent des heures “inexistantes” ou “dupliquées”

```r
dt_utc <- as.POSIXct("2024-03-31 01:30:00", tz = "UTC")
dt_paris <- as.POSIXct(dt_utc, tz = "Europe/Paris")
```

Bon réflexe : choisir un `tz` (souvent `UTC`) pour stocker, et convertir pour afficher.

---

## Import : texte → date/datetime (robuste)

**SAS**

```sas
input dt_txt : e8601dt.;
```

**R**

```r
readr::parse_datetime("2024-12-31T14:30:00", format = "%Y-%m-%dT%H:%M:%S")
```

(Alternative R) `lubridate::ymd_hms()` si les formats sont réguliers.

---

## Pont SAS ↔ R : conversions numériques

Si vous récupérez des dates SAS **numériques** :

```r
date_from_sas <- function(days_since_1960) {
  as.Date(days_since_1960, origin = "1960-01-01")
}

datetime_from_sas <- function(seconds_since_1960, tz = "UTC") {
  as.POSIXct(seconds_since_1960, origin = "1960-01-01", tz = tz)
}
```

Et l’inverse :

```r
as.integer(d - as.Date("1960-01-01"))               # -> SAS date
as.numeric(dt - as.POSIXct("1960-01-01", tz="UTC")) # -> SAS datetime (sec)
```

---

## Message clé

1) Distinguer **valeur interne** vs **format d’affichage**  
2) Choisir le bon type : `Date` (jour) vs `POSIXct` (seconde)  
3) Pour les mois / fuseaux : préférer des fonctions dédiées (`INTNX` / `lubridate`)
