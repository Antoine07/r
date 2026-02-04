---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Syntaxe R — les bases pour démarrer

Objectif : savoir **lire**, **écrire** et **exécuter** du code R simple.

---

##  Créer des objets (affectation)

```r
x <- 10
y <- x + 5
```

- `<-` associe une valeur à un nom
- R travaille avec des **objets**
- on réutilise les objets dans les calculs

📌 Convention R : `<-` (même si `=` fonctionne parfois)

---

## Les types de base

Toute valeur a un **type**.

- `numeric` : nombres
- `integer` : entiers
- `character` : texte
- `logical` : vrai / faux

```r
typeof(3.14)
typeof(10L)
typeof("hello")
typeof(TRUE)
```

📌 Le type détermine ce qu’on peut faire avec une valeur.

---

## Vecteurs : la structure centrale de R

Un vecteur = plusieurs valeurs du **même type**.

```r
v <- c(10, 20, 30)
length(v)
sum(v)
mean(v)
```

📌 R est conçu pour travailler sur des **collections de valeurs**.

---

##  Coercition (conversion automatique)

```r
c(1, "a", TRUE)
```

- R force les valeurs vers un type commun
- un vecteur est **toujours homogène**

📌 Le typage existe, mais il est souvent implicite.

---

## Indexation (R commence à 1)

```r
v[1]     # premier élément
v[2:3]   # sous-vecteur
v[-1]    # exclusion
rev(v)   # ordre inversé
```

📌 L’indexation permet d’extraire des sous-ensembles.

---

##  Sélection par condition (logique)

```r
v[v >= 20]
```

- on garde uniquement les valeurs qui vérifient la condition
- base de l’analyse de données

---

##  Valeurs manquantes (`NA`)

```r
x <- c(1, 2, NA, 4)

mean(x)                # NA
mean(x, na.rm = TRUE)  # ignore les NA
```

📌 Les données réelles contiennent presque toujours des `NA`.

---

## Fonctions : regrouper des instructions

```r
add <- function(a, b) {
  a + b
}

add(2, 3)
```

- une fonction prend des arguments
- renvoie un résultat
- évite de répéter du code

---

## Décider et répéter (minimum vital)

### Condition

```r
if (x > 0) "positive" else "negative"
```

### Boucle

```r
total <- 0

for (i in 1:5) {
  total <- total + i
}

total
```

📌 Présenté ici pour la culture générale.

---

## Parcourir une liste de vecteurs

```r
values <- list(1:3, 10:12, 100:102) # liste de listes, 3 éléments
for (v in values) {        # 1ère boucle : la liste
  for (x in v) {           # 2ème boucle : le vecteur
    print(x)
  }
}
```

---

## Convertir avec as.*()

```r
as.Date() → convertir en date
as.numeric() → convertir en nombre
as.character() → convertir en texte
as.factor() → convertir en catégorie
as.logical() → convertir en booléen

d <- as.Date("2024-12-31")
d + 1
# [1] "2025-01-01"

x <- c("A", "B", "A", "C")
f <- as.factor(x)
# [1] "A" "B" "C"
```