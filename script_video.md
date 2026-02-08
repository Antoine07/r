# Script Synthesia — Vidéo cours (chapitre 112) avec démos dans RStudio

## Prompt Synthesia (à coller)

Créer une vidéo de cours **en français** sur “Fonctions en R et portée (scope)”. La voix, les titres et tout le texte à l’écran doivent être **en français**. Toutes les démonstrations de code doivent être **faites et exécutées dans le logiciel RStudio** (fenêtre RStudio visible : éditeur + console + sorties). Alterner avatar (explications) et capture d’écran RStudio (exécution des blocs). Montrer l’exécution bloc par bloc et les résultats dans la console. Ne pas utiliser un autre IDE/terminal.

## Métadonnées (pour Synthesia)

- **Titre vidéo** : *Fonctions en R et portée (scope)*
- **Durée cible** : 5–10 minutes
- **Langue / ton** : français, pédagogique, rythme calme
- **Style** : alternance *avatar face cam* + *capture écran du logiciel RStudio* (code exécuté)
- **Objectif** : savoir écrire des fonctions + comprendre la portée lexicale (variables locales/globales, `<<-`, closures, `local()`)

---

## Préparation (capture écran RStudio)

Dans le logiciel **RStudio** :

1) Ouvrir le projet (le `.Rproj`)  
2) Créer un script `112_video_demo.R` (ou un script temporaire)  
3) Coller le code des scènes ci-dessous, exécuter **bloc par bloc** (Ctrl/Cmd + Enter) dans RStudio  

Optionnel (si un package manque) :
```r
# install.packages("lubridate") # seulement si nécessaire (pas indispensable ici)
```

---

## Scène 1 — Intro (avatar)

**À l’écran (texte court)**  
“Chapitre 112 — Fonctions & portée (scope)”

**Voix off (avatar)**  
“Dans cette vidéo, on va apprendre à écrire des fonctions en R, puis comprendre un point clé du langage : la portée, c’est-à-dire d’où viennent les variables utilisées dans une fonction. On fera tout dans RStudio avec des exemples exécutés.”

---

## Scène 2 — Définir une fonction (démo dans RStudio)

**Voix off**  
“Une fonction se définit avec `function(...) { ... }`. En R, la dernière expression évaluée est retournée automatiquement.”

**Code à exécuter**
```r
aire_cercle <- function(r) {
  pi * r^2
}

aire_cercle(3)
aire_cercle(0.5)
```

**À montrer à l’écran**  
- Le script + l’exécution dans la console  

---

## Scène 3 — `return()` et sortie anticipée (démo dans RStudio)

**Voix off**  
“On peut aussi utiliser `return()` : c’est utile pour sortir tôt, par exemple si l’entrée n’est pas valide.”

**Code à exécuter**
```r
safe_sqrt <- function(x) {
  if (x < 0) return(NA_real_)
  sqrt(x)
}

safe_sqrt(9)
safe_sqrt(-1)
```

**À l’écran (texte court)**  
“Retour implicite vs `return()`”

---

## Scène 4 — Arguments : valeurs par défaut et arguments nommés (démo dans RStudio)

**Voix off**  
“On peut donner des valeurs par défaut, et appeler les fonctions avec des arguments nommés, ce qui rend le code plus lisible.”

**Code à exécuter**
```r
saluer <- function(nom = "toi") {
  paste("Bonjour", nom)
}

saluer()
saluer("Nina")
saluer(nom = "Amina")
```

---

## Scène 5 — `...` : transmettre des options (démo dans RStudio)

**Voix off**  
“`...` sert à accepter des arguments supplémentaires et à les transmettre à une autre fonction.”

**Code à exécuter**
```r
resume_num <- function(x, ...) {
  summary(x, ...)
}

resume_num(1:10)
resume_num(c(1, 2, NA, 4), na.rm = TRUE)
```

**Note narration (important)**  
“Attention : `...` peut aussi masquer des erreurs si on transmet des arguments mal orthographiés.”

---

## Scène 6 — Fonctions anonymes (démo dans RStudio)

**Voix off**  
“On peut écrire une fonction sans la nommer, par exemple avec `lapply()`.”

**Code à exécuter**
```r
lapply(list(1:3, 4:5, c(10, 1)), function(v) sum(v))
```

---

## Scène 7 — Portée lexicale : l’idée clé (démo dans RStudio)

**Voix off**  
“R utilise une portée lexicale : une fonction voit les variables en fonction de l’endroit où elle est définie.”

**Code à exécuter**
```r
x <- 10

f <- function(y) {
  x + y
}

f(5)
```

**À l’écran (texte court)**  
“Lexical scoping = on cherche `x` dans l’environnement de définition”

---

## Scène 8 — Shadowing : une variable locale masque une globale (démo dans RStudio)

**Voix off**  
“Si on redéfinit `x` dans la fonction, ce `x` devient local et masque le global.”

**Code à exécuter**
```r
x <- 10

g <- function() {
  x <- 1
  x
}

g()
x
```

**À montrer**  
- Le `x` global n’a pas changé

---

## Scène 9 — Affectation locale vs `<<-` (démo dans RStudio)

**Voix off**  
“Par défaut, `<-` dans une fonction crée/modifie une variable locale. `<<-` remonte dans les environnements parents et modifie une variable existante : c’est puissant, mais à utiliser avec prudence.”

**Code à exécuter**
```r
x <- 10

h <- function() {
  x <- 99
}
h()
x

k <- function() {
  x <<- 99
}
k()
x
```

**À l’écran (texte court)**  
“Éviter `<<-` en projet : préférer retourner une valeur”

---

## Scène 10 — Closures : une “usine à fonctions” (démo dans RStudio)

**Voix off**  
“Une closure, c’est une fonction qui capture des variables de son environnement. Ça permet de fabriquer des fonctions spécialisées.”

**Code à exécuter**
```r
make_adder <- function(a) {
  function(x) a + x
}

add10 <- make_adder(10)
add10(5)

add3 <- make_adder(3)
add3(5)
```

**Option visuelle (si tu veux montrer la capture)**  
```r
environment(add10)
get("a", envir = environment(add10))
```

---

## Scène 11 — `local()` : créer une portée temporaire (démo dans RStudio)

**Voix off**  
“`local()` crée un environnement temporaire : pratique pour éviter de polluer le global.”

**Code à exécuter**
```r
exists("tmp")

local({
  tmp <- 123
  tmp * 2
})

exists("tmp")
```

---

## Scène 12 — Conclusion (avatar)

**À l’écran (bullet points)**  
- `function()` pour encapsuler du code  
- Valeur de retour = dernière expression (souvent)  
- Portée lexicale : variables cherchées dans l’environnement de définition  
- `<<-` : rare, à utiliser avec prudence  
- Closures et `local()` : utiles pour structurer proprement

**Voix off**  
“À retenir : les fonctions rendent le code propre et réutilisable, et la portée lexicale explique pourquoi une fonction ‘voit’ certaines variables. Si tu maîtrises ça, tu éviteras une grande partie des bugs liés aux variables globales.”
