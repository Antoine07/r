---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

#  Modèle mémoire et vecteurs atomiques

À maîtriser absolument:

- vecteurs atomiques (types + coercition + NA)
- recycling (recyclage)
- copy-on-write / copy-on-modify (copie à la modification)

---

## Définition — Vecteur atomique

Un **vecteur atomique** est une suite de valeurs **d'un seul type**.

Types atomiques courants:

- `logical` (`TRUE`/`FALSE`)
- `integer` (ex: `10L`)
- `double`/`numeric` (ex: `3.14`)
- `character` (texte)

Outils:

```r
typeof(x)  # stockage en mémoire
class(x)   # sémantique (souvent identique au typeof)
length(x)
```

---

## Représentation mémoire (idée)

Un vecteur atomique est stocké comme un bloc de mémoire homogène:

- un seul type → éléments de taille fixe (sauf `character`)
- les attributs (ex: `names`) ajoutent du coût mémoire

Repères (ordre de grandeur):

- `integer` / `logical`: ~4 octets par élément
- `double` (`numeric`): ~8 octets par élément
- `character`: pointeurs + stockage séparé des chaînes

```r
x <- rep(1, 1e6)
object.size(x)
```
---

# Inf 

```r
.Machine$double.xmax
# normalement la valeur qui suit est Inf
1.8*10^308 
```

On peut continuer à faire des calculs si on est en dessous de cette valeur, pour information le nombre d'atomes dans l'Univers est estimé à `≈ 10⁸⁰` ... 

---

# Limite 

👉 Au-delà de ~15–16 chiffres :
- les entiers ne sont plus exacts
- les petits écarts disparaissent

```r
1e16 + 1 == 1e16 # TRUE
1e10 + 1 == 1e10 # FALSE

```

---


## Représentation compacte (séquences en R) à partir de R 3.5

```r
R.version.string
# "R version 4.5.2 (2025-10-31)"
```

En R, certains objets peuvent être **représentés de manière paresseuse** :
R ne stocke pas toutes les valeurs immédiatement, mais **sait comment les calculer à la demande**.

### Exemple

```r
r <- 1:1e8
```

- R connaît : le début, la fin, le pas
- Il peut calculer une valeur ponctuelle sans parcourir tout le vecteur :

```r
r[1]
r[1e8]
```

👉 Le vecteur peut rester **non matérialisé** tant qu'aucun calcul global n'est demandé.

---

### ⚠️ Attention : `object.size()`

```r
object.size(r)
```

- Cette valeur correspond à la **taille théorique** du vecteur s'il était entièrement matérialisé
- Elle **ne permet pas de conclure** sur la compacité réelle en mémoire

---

### Conséquence importante

Dès qu'une opération nécessite **toutes les valeurs**, R doit les matérialiser :

```r
r2 <- r * 2
```

- toutes les valeurs sont calculées
- le vecteur est stocké en mémoire
- l'usage mémoire augmente fortement

---

### À retenir

- Accès ponctuel (`r[i]`, `head(r)`) → reste léger
- Calcul vectoriel global (`r * 2`, `sum(r)`) → **matérialisation et coût mémoire**

👉 La compacité est une **optimisation interne**, pas une garantie pour l'utilisateur.

---

## Créer des vecteurs

```r
v1 <- c(10, 20, 30)
v2 <- 1:5
v3 <- seq(0, 1, by = 0.25) # pas de 0.25
v4 <- rep("A", times = 3)
v5 <- seq(1, 10, length.out = 5) # nombre de points entre 1 à 10
```

---

## Coercition (conversion implicite)

Si plusieurs types sont mélangés, R convertit vers un type commun.

```r
c(1, 2, "3")
```

Conversions explicites:

```r
as.integer("10")
as.numeric("3.14")
as.character(10)
```

---

## `NA`, `NaN`, `Inf`

```r
x <- c(1, NA, 3)
is.na(x)
sum(is.na(x))
mean(x, na.rm = TRUE)

0/0   # NaN c'est une indéterminé au sens maths
1/0   # Inf c'est une limite 
```

---

## Indexation (1-based) et filtres logiques

```r
v <- c(5, 9, 2, 9, 1)
v[1] # accès à un élément
v[2:4] # slicing 
v[-1] # exclure la position 1, etc
v[v >= 5] # filtre logique
```

---

## Indexation par noms

On peut définir des noms dans un vecteur atomique, attention ce ne sont pas des clés, mais des labels.

```r
scores <- c(alice = 12, bob = 9, chris = 16)
scores["bob"]
names(scores)

x <- c(a = 1, a = 2) # vous pouvez faire ça ... 
x["a"] # n'écrase rien ... 
```

---

## Vectorisation (ce pour quoi R excelle)

```r
units <- c(12, 25, 8)
price <- c(49.99, 19.99, 49.99)
revenue <- units * price
revenue
```

---

## Recycling (recyclage)

Si les longueurs ne correspondent pas, R recycle le plus petit vecteur.

```r
c(1, 2, 3, 4) + c(10, 100)
```

Point technique:

- si la longueur n'est pas un multiple exact, R émet un warning (signal faible → à surveiller).

---

## Copy-on-write / copy-on-modify

R déclenche une copie lorsqu'un objet partagé est modifié.

Démonstration (observer les messages en console):

```r
x <- 1:5
tracemem(x)

y <- x
y[1] <- 99

sum( !(y == x) ) # si plus grand que 1 ... 
```

👉 tracemem() permet de voir quand un objet est copié en mémoire.

Conséquence: certaines modifications peuvent coûter cher sur des objets volumineux.

---

## Copy-on-write / copy-on-modify

Par rapport à l'exemple précédent R se dit :
"Attends… cet objet est partagé (x et y)
si je modifie, je vais casser x."

👉 Donc R :
- copie l'objet
- donne la copie à y
- modifie la copie
- laisse x intact

---

## Réallocation lors de la croissance d'un vecteur

Quand un vecteur grandit, R doit généralement:

- allouer un nouveau bloc mémoire
- copier les anciennes valeurs
- ajouter la nouvelle valeur

Dans une boucle, cela peut provoquer une réallocation + copie à chaque itération.

Exemple (à éviter):

```r
x <- numeric(0)
for (i in 1:100000) x <- c(x, i)
```

---

complexité ≈ O(n²)

- nouvelle allocation
- copie complète de l'ancien vecteur

```r
x <- numeric(0)

x <- c(x, 1)
x <- c(x, 2)
x <- c(x, 3)
# ...
```

---

## Pré-allocation (solution)

```r
n <- 100000
x <- numeric(n)
for (i in 1:n) x[i] <- i
```

Alternative vectorisée:

```r
# stocké de façon paresseuse
x <- 1:100000

# mauvaise pratique, si pas nécessaire, force le passage en double ×2 mémoire
x <- as.numeric(1:100000)
```

---

>Règle d'or à retenir :
>Si ce que vous voulez est une séquence régulière, utilisez toujours `:` ou `seq_*()`.

---

Dans les cas ci-dessous la conversion (`coercition`) se fait automatiquement 

```r
mean(x)
sd(x)
x / 3
log(x)
```

---

## NA

```r
x <- c(1, 2, NA, 4)
sum(x) # NA

sum(x, na.rm = TRUE) # retourne 7
```

---

## Exercice - températures janvier & février 

Sujet: `Exercices/103_memory_vectors.md`
