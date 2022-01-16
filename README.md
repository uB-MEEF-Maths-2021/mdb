# MathDataBase

A collection of definitions and theorems.

## Download

Choose one of 3 solutions

### Simple process

1. Go to [releases](https://github.com/uB-MEEF-Maths-2021/MathDataBase-fr/releases)
2. download the archive of the latest release
3. expand that archive on your hard drive

### Clone

Obtain the last cutting edge database.

1. Go to [Code](https://github.com/uB-MEEF-Maths-2021/MathDataBase-fr/)
2. Select the **Code** tab
3. Hit the green button **Code->Open with GitHub Desktop**
4. Fill the form

### Fork and clone

See the contributing guide lines.

## Install

1. Locate your local `texmf` tree: in a terminal, issue
```
kpsewhich -var-value TEXMFHOME
```
The answer is something like `<some path>/texmf` (or `<path>\texmf` on windows)

2. locate the folder containing `MathDataBase`.

3. Issue in the terminal

* Windows `mklink /d "<MathDataBase path>" "<some path>/texmf/tex/latex/MDB"`
* Other `ln -s "<some path>/texmf/tex/latex/MDB" "<MathDataBase path>"`
