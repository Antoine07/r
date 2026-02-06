# Exercices — Filtres sur vecteurs (base R)

## Données 

```r
temps <- c(3, -2, 5, NA, 0, 7, -1, 4, 6, NA, -3, 2)
```

### Exercice 1

1. Donner toutes les températures **strictement positives**.
```r
temps[temps > 0 ]
```
2. Donner toutes les températures **négatives ou nulles**.
```r
temps[temps <= 0]
```

3. Donner les températures **non manquantes**.
```r
temps[!is.na(temps)]
```



---

### Exercice 2

1. Donner le **nombre** de températures positives.
```r
sum(temps > 0, na.rm = TRUE)
```

2. Donner le **nombre** de valeurs manquantes.
```r
sum(is.na(temps))
```

3. Vérifier s’il y a **plus de températures positives que négatives**.
```r
sum(temps > 0, na.rm = TRUE) > sum(temps < 0, na.rm = TRUE)
```

---

## Données 2 — Notes d’élèves

```r
notes <- c(12, 8, NA, 15, 9, 17, 10, 6, 14, NA)
```

### Exercice 3

1. Donner les notes **≥ 10**.
```r
notes[notes >= 10]
```
2. Donner les notes **< 10** (sans compter les `NA`).
```r
notes[notes < 10 & !is.na(notes)]
```
3. Donner les **positions** des notes ≥ 10.
```r
which(notes >= 10)
```

---

### Exercice 4

1. Calculer la **moyenne des notes ≥ 10**.
```r
mean(notes[notes >= 10], na.rm = TRUE)
```

2. Calculer la **moyenne des notes < 10**.
```r
mean(notes[notes < 10], na.rm = TRUE)
```

3. Indiquer quelle moyenne est la plus élevée.
```r
mean(notes[notes >= 10], na.rm = TRUE) >
  mean(notes[notes < 10], na.rm = TRUE)
```

---

## Données 3 — Ventes journalières (€)

```r
sales <- c(120, 90, 150, NA, 200, 80, 60, 175, 220, 95)
```

### Exercice 5

1. Donner les ventes **> 100 €**.
```r
sales[sales > 100]
```
2. Donner les ventes **≤ 100 €**.
```r
sales[sales <= 100]
```
3. Donner les **jours** (indices) où les ventes dépassent 150 €.

```r
days <- 1:length(sales)

days[sales > 150]

which(sales > 150)
```



---

### Exercice 6

Créer un nouveau vecteur `sales_corr` tel que :

* les ventes **< 100 €** sont remplacées par `100`
* les autres valeurs sont conservées
* les `NA` restent inchangés

```r
sales_corr <- sales
sales_corr[sales < 100] <- 100
sales_corr
```

---

## Données 4 — Âges

```r
ages <- c(17, 22, 19, 34, NA, 28, 16, 41, 25, 30)
```

### Exercice 7

1. Donner les âges **< 18**.
2. Donner les âges **≥ 18**.
3. Donner la proportion de majeurs.


```r
# 1. Âges < 18
ages[ages < 18]

# 2. Âges ≥ 18
ages[ages >= 18]

# 3. Proportion de majeurs
mean(ages >= 18, na.rm = TRUE)
```

---

### Exercice 8

1. Donner les âges **entre 20 et 30 inclus**.
2. Donner les positions correspondantes.
3. Calculer la moyenne de cette tranche d’âge.


```r
# 1. Âges entre 20 et 30 inclus
ages[ages >= 20 & ages <= 30]

# 2. Positions correspondantes
which(ages >= 20 & ages <= 30)

# 3. Moyenne de cette tranche
mean(ages[ages >= 20 & ages <= 30], na.rm = TRUE)
```


---

## Données 5 — Températures nocturnes

```r
night <- c(-3, -1, 2, NA, 0, 4, -2, 1, 3, -4)
```

### Exercice 9

1. Donner les nuits **≤ 0**.
2. Donner le nombre de nuits **strictement positives**.
3. Vérifier s’il existe **au moins une nuit < -3**.


```r
# 1. Nuits ≤ 0
night[night <= 0]

# 2. Nombre de nuits strictement positives
sum(night > 0, na.rm = TRUE)

# 3. Existe-t-il une nuit < -3 ?
any(night < -3, na.rm = TRUE)
```

---

## Exercice bonus — Raisonnement logique

À partir du vecteur `temps` :

1. Vérifier si **toutes** les températures positives sont < 10.
2. Vérifier s’il existe **au moins une température > 6**.
3. Vérifier s’il n’y a **aucune température égale à 1**.


```r
# 1. Toutes les températures positives sont < 10 ?
all(temps[temps > 0] < 10)

# 2. Existe-t-il au moins une température > 6 ?
any(temps > 6, na.rm = TRUE)

# 3. Aucune température égale à 1 ?
!any(temps == 1, na.rm = TRUE)
```
