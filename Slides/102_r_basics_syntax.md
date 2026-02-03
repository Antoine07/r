---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Syntaxe R 

## Affectation: `<-`


```r
x <- 10
y <- x + 5
```

`<-` est la convention R (même si `=` fonctionne souvent).

---

## Types de base

- `numeric` (double)
- `integer`
- `character` (texte)
- `logical` (`TRUE`/`FALSE`)

Tester:

```r
typeof(3.14)
typeof(10L)
typeof("hello")
typeof(TRUE)
```

---

## Vecteurs 

```r
v <- c(10, 20, 30)
length(v)
sum(v)
mean(v)
```

Un vecteur est homogène (un seul type, après coercition éventuelle).

coercition = convertion de type automatique

---

## Indexation (1-based)

```r
v[1]     # premier
v[2:3]   # plage d'index
v[-1]    # tout sauf le 1er
rev(v)   # renvoie le vecteur inversé
```

Filtrage logique:

```r
v[v >= 20]
```

---

## `NA` (valeurs manquantes)

```r
x <- c(1, 2, NA, 4)
mean(x)              # NA
mean(x, na.rm = TRUE)
```

---

## Fonctions: structure

```r
add <- function(a, b) {
  a + b
}

add(2, 3)
```

---

## Conditions & boucles (minimum)

```r
if (x > 0) "positive" else "negative"
```

Boucle `for`:

```r
total <- 0
for (i in 1:5) total <- total + i
total
```

---

## Exercice les bases

`Exercices/102_r_basic_syntax.md`
