---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Dates en R — bases essentielles

Objectif : comprendre **ce qu'est une date**, et **comment la manipuler simplement**.

---

##  Pourquoi les dates sont spéciales

Une date n'est :
- ni un nombre
- ni du texte

👉 C'est un **objet avec une signification temporelle**.

---

## Créer une date avec `as.Date()`

```r
d <- as.Date("2024-12-31")
d
```

📌 Format par défaut : `YYYY-MM-DD`

---

##  Type vs classe

```r
typeof(d)
class(d)
```

- type interne : `double`
- classe : `"Date"`

📌 La classe donne le **sens métier**.

---

##  Comment une date est stockée

```r
unclass(d)
```

👉 Nombre de jours depuis le **1er janvier 1970**.

📌 Détail interne, rarement manipulé directement.

---

## Calculs simples sur les dates

```r
d + 1      # lendemain
d - 7      # une semaine avant
```

📌 Les opérations restent cohérentes.

---

## Texte → date : attention au format

```r
as.Date("01/02/2026", format = "%d/%m/%Y")
```

Sans `format`, R ne peut pas deviner.

---

## Différence entre date et durée

```r
d1 <- as.Date("2026-01-01")
d0 <- as.Date("1970-01-01")

d1 - d0
```

👉 Résultat = **durée en jours** `difftime`.

---

## Message clé à retenir

>Une date est un nombre + une classe.

---

## Ce qu'on verra plus tard

- heures (`POSIXct`)
- fuseaux horaires
- `lubridate`

