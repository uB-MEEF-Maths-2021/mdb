# MathDataBase

Une collection de définitions et théorèmes.

## Téléchargement

3 possibilités selon vos objectifs.

### Simple

1. Aller à [versions](https://github.com/uB-MEEF-Maths-2021/MathDataBase-fr/releases)
2. télécharger l'archive de la dernière version
3. développer l'archive sur votre disque dur

### Cloner

Pour obtenir la toute dernière version de la base de données (il faut disposer de **Github Desktop**)

1. Aller à [Code](https://github.com/uB-MEEF-Maths-2021/MathDataBase-fr/)
2. Sélectionner la vue **Code**
3. Cliquer le bouton vert **Code->Open with GitHub Desktop**
4. Remplir le formulaire et valider

### Forker et cloner

Voir le guide de contributions.

## Configuration automatique

Une fois le téléchargement effectué, placer le dossier `MathDataBase` à l'endroit qui vous convient. Ouvrir un navigateur de fichiers et aller dans le dossier `MathDataBase`.

### sur Windows

Sélectionner le dossier `Tool` puis clic droit et choisir "Ouvrir une fenêtre PowerShell ici". Entrer et valider l'instruction
```
texlua configuration.lua
```

### sur MacOS

Si ce n'est déjà fait, dans «Préférences système > Clavier > Raccourcis claviers > Services» cochez le service «Nouveau terminal sur dossier».

Sélectionner le dossier `Tool` puis clic droit et choisir "Nouveau terminal sur dossier". Entrer et valider l'instruction
```
texlua configuration.lua
```
### Sur unix/linux

Sélectionner le dossier `Tool` puis clic droit et choisir "Ouvrir un terminal ici" (ou similaire). Entrer et valider l'instruction
```
texlua configuration.lua
```

## Configuration technique

Au cas où la configuration automatique ne fonctionne pas.

### Arborescence texmf locale

Sur MikTeX, créer une arborescence texmf local avec les instructions [miktex](https://miktex.org/kb/texmf-roots) reproduites ici

1. Créer un nouveau dossier sur votre ordinateur, par exemple dans votre dossier de démarrage, le nom pourra être `texmf`. Dans la suite, `<local texmf path>` doit êrte remplacé par le chemin vers ce dossier.
2. Lancer MiKTeX Console ouvrir la page Settings.
3. Sélectionner la vur Directories
4. Cliquer le bouton Add et naviguer jusqu'au dossier  `<local texmf path>` créé à l'étape 1

Pour les autres distributions,

1. Localiser votre arborescence `texmf` locale: dans un terminal, saisir la commande suivante et vallder
```
kpsewhich -var-value TEXMFHOME
```
La réponse est le chemin vers un dossier nommé `texmf`. S'il n'y a pas de dossier pour ce chemin, il faut en créer un.
Dans la suite, `<local texmf path>` doit êrte remplacé par le chemin vers ce dossier.

Créer le dossier 
### Installation

1. Trouver le chemin du dossier **MathDataBase**. Dans la suite  `<path to MathDataBase>` doit êrte remplacé par ce chemin.

2. Créer les dossier `<local texmf path>/tex/latex/`

3. Dans ce dossier,créer un ficher texte nommé `MDB.cfg` dont le contenu est
```
\MDBConfigure {
  path=<path to MathDataBase>,
}
```

4. Dans un terminal, saisir la commande

* Windows `mklink /d "<local texmf path>/tex/latex/MDB" "<path to MathDataBase>/Style"`
* Other `ln -s "<path to MathDataBase/Style>" "<local texmf path>/tex/latex/MDB"`

où `<local texmf path>` et  `<path to MathDataBase>` sont remplacés par ce qu'ils représentent.

Sur windows, les utilisateurs de base ne peunvent pas uttiliser  `mklink`. En cas d'erreur, il faut d'abord activer le mode développeur

1. Ouvrir les paramètreswindows
2. Sélectionner  "Mise à jour et sécurité"
3. Sélectionner "Pour les développeurs"
4. Click le bouton "Mode développeur"
5. Valider

Une fois la commande `mklink` exécutée avec succès, on peut désactiver le mode développeur de manière similaire

Pour tester si votre installation est correcte, saisir dans un terminal la commande
```
kpsewhich MathDataBase.sty
```
La réponse doit être un chemin se terminant par `MathDataBase.sty`.
Ensuite, créer un fichier `test.tex` de contenu
```
\documentclass{article}
\RequirePackage{MathDataBase}
\begin{document}
\MDB{Polynômes/racine/base/text}
\end{document}
```
`lualatex` doit composer ce document avec succès.
