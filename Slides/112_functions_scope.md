---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

#  Fonctions en R & portée (scope)

Objectif : savoir **écrire** des fonctions et **comprendre** d'où viennent les variables utilisées dans une fonction.

---

## Pourquoi faire des fonctions ?

- Réutiliser du code sans le copier-coller
- Rendre un script plus lisible (nommer une étape)
- Tester plus facilement (entrée → sortie)
- Encapsuler un comportement (et parfois un état)

---

## Définir une fonction

```r
aire_cercle <- function(r) {
  pi * r^2
}

aire_cercle(3)
```

- `function(...) { ... }` crée une fonction
- Le résultat est la **dernière expression** évaluée (retour implicite)

---

## `return()` (retour explicite)

```r
f1 <- function(x) { x + 1 }
f2 <- function(x) { return(x + 1) }
```

- Les deux styles sont valides
- `return()` est utile pour sortir tôt (conditions, garde-fous)

---

## Arguments : valeurs par défaut et nommage

```r
saluer <- function(nom = "toi") {
  paste("Bonjour", nom)
}

saluer()
saluer(nom = "Amina")
```

- Les valeurs par défaut rendent l'appel plus simple
- Les arguments **nommés** améliorent la lisibilité

---

## `...` : arguments variables (ellipsis)

```r
resume_num <- function(x, ...) {
  summary(x, ...)
}

resume_num(1:10)
```

- `...` permet de transmettre des options à d'autres fonctions
- Attention : sans validation, `...` peut masquer des erreurs de nom d'argument

---

## Fonctions anonymes (fonctions "sans nom")

```r
lapply(list(1:3, 4:5), function(v) sum(v))
```

- Utile quand la fonction est courte et utilisée une seule fois
- Très courant avec `*apply`, et plus généralement en programmation fonctionnelle

---

## Portée lexicale : idée clé

R utilise une **portée lexicale** : une fonction voit les variables selon l'endroit où elle a été **définie**.

```r
x <- 10
f <- function(y) { x + y }

f(5)  # 15
```

---

## Où R cherche une variable ?

Quand un nom (ex. `x`) est utilisé dans une fonction :

- environnement local (arguments + variables créées dans la fonction)  
- environnements parents (où la fonction a été définie)  
- environnement global  
- packages attachés (ex. `base`, `stats`, etc.)

---

## Shadowing (masquage de variables)

```r
x <- 10
g <- function() {
  x <- 1
  x
}

g()  # 1
x    # 10
```

- Le `x` local masque le `x` global dans le corps de la fonction

---

## Affectation locale (par défaut)

```r
x <- 10
h <- function() {
  x <- 99
}

h()
x  # 10
```

- `x <- ...` dans une fonction crée/modifie **une variable locale**
- Une fonction ne "modifie pas le global" par accident

---

## `<<-` : modifier un environnement parent (prudence)

```r
x <- 10
k <- function() {
  x <<- 99
}

k()
x  # 99
```

- `<<-` remonte dans les environnements parents pour modifier une variable existante
- À éviter en usage courant : préférez retourner une valeur

---

## Closures : une fonction peut "capturer" des variables

```r
make_adder <- function(a) {
  function(x) a + x
}

add10 <- make_adder(10)
add10(5)  # 15
```

- `add10` garde `a = 10` via l'environnement capturé

---

## `local()` : créer une portée temporaire

```r
local({
  tmp <- 123
  tmp * 2
})

# tmp n'existe pas ici
```

- Utile pour éviter de polluer l'environnement global

---

## Bonnes pratiques (scope)

- Passer les dépendances en **arguments** plutôt que lire des variables globales
- Retourner un résultat plutôt que modifier l'extérieur (`<<-`)
- Donner des noms explicites aux paramètres
- Garder des fonctions courtes (une responsabilité principale)

