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

### Local texmf tree

On MikTeX, create a local texmf tree following instructions at [miktex](https://miktex.org/kb/texmf-roots)

1. Create a directory `<local texmf path>`, say `~/mytexmf`, which serves as the new TEXMF root directory.
2. Create TDS-compliant subdirectories and move/copy your files here.
3. Start MiKTeX Console and open the Settings page.
4. Click the Directories tab.
5. Click the Add button and browse to the TEXMF root directory created during step 1: `<local texmf path>`.

For other distributions,

1. Locate your local `texmf` tree: in a terminal, issue
```
kpsewhich -var-value TEXMFHOME
```
The answer is some `<local texmf path>` which last compenent contains `texmf`.

### Installation

1. locate the **MathDataBase** folder. In the sequel `<path to MathDataBase>` designates the path to this folder.

2. Create a file named `MDB.cfg` at `<path to MathDataBase>`, which content reads
```
\MDBConfigure {
  path=<path to MathDataBase>,
}
```

2. Issue in the terminal

* Windows `mklink /d "<some path>/texmf/tex/latex/MDB" "<path to MathDataBase>/Style"`
* Other `ln -s "<path to MathDataBase/Style>" "<some path>/texmf/tex/latex/MDB"`

where you replace `<path to MathDataBase>` with the real path.

On windows, basic users are not allowed to use the `mklink` command. In case of error, there are two solutions

1. Open a terminal as administrator
2. Activate the developer mode

### Developer mode in windows

How to enable Developer Mode in Windows 10

1. Open Settings.
2. Select the "Update & security" section
3. Select the "For developers" section
4. Click on the "Developer mode" button
5. A pop-up appears, click on "Yes".

How to disable Developer Mode in Windows 10?

1. Open Settings.
2. Select the "Update & security" section
3. Select the "For developers" section
4. Click "Don't use developer features"

### Test

Create `test.tex` with content
```
\documentclass{article}
\RequirePackage{MathDataBase}
\begin{document}
\MDB{Polynômes/racine/base/text}
\end{document}
```
This document should typeset properly.
