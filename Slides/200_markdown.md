---
marp: true
theme: default
paginate: true
class: lead
header: "[index](https://antoine07.github.io/r)"
---

# Chapitre — Création d'une page HTML avec R Markdown

## Introduction

R Markdown permet de générer automatiquement des documents HTML à partir d'un
fichier texte combinant du contenu rédigé et du code R.
Cette approche est largement utilisée pour produire des rapports, des supports
de présentation et des pages web simples de manière reproductible.

---

## Structure minimale d'un fichier R Markdown

Un fichier R Markdown est composé de trois éléments principaux :
1. un en-tête YAML,
2. du texte rédigé en Markdown,
3. des blocs de code R (appelés *chunks*).

---

### En-tête YAML

L'en-tête YAML définit les paramètres de sortie du document.
Pour produire une page HTML, il suffit d'indiquer le format `html_document`.

```yaml
---
title: "Analyse"
output: html_document
---
```

---

Le titre défini dans l'en-tête apparaît en haut de la page HTML générée.

## Contenu Markdown

Le corps du document est rédigé en Markdown, un langage de balisage léger.
Il permet de structurer le contenu à l'aide de titres, de paragraphes et de listes.

Exemples :

- `#` crée un titre de niveau 1
- `##` crée un titre de niveau 2
- le texte est automatiquement converti en HTML

---

# Introduction
Ceci est un paragraphe de texte affiché dans la page HTML.

## Insertion de code R

Les blocs de code R sont intégrés grâce aux *chunks*.
Chaque chunk commence par `{r} et se termine par `.

```{r}
1 + 1
```

>Lors de la compilation, le code est exécuté et le résultat est inséré dans la page HTML.

---

## Génération automatique du HTML

Lorsque l'utilisateur cliquez sur **Knit** dans RStudio, R Markdown :

1. exécute le code R,
2. convertit le Markdown en HTML,
3. assemble l'ensemble dans une page web complète.

Le fichier HTML généré peut être ouvert dans un navigateur ou partagé sans R.

---

## Personnalisation de la page HTML

Il est possible de personnaliser l'apparence du document HTML en modifiant
les options de l'en-tête YAML.

```yaml
output:
  html_document:
    theme: cosmo
    toc: true
```

Ces options permettent par exemple d'ajouter une table des matières ou de
changer le thème graphique.

