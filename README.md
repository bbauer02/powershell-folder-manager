# PowerShell : Gestionnaire de dossier

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bbauer02/powershell-folder-manager)


Ce script permet de créer un dossier dans le répertoire courant contenant un sous dossier numéroté automatiquement. 
Dans ce sous dossier, sera alors créé 2 autres dossiers nommés : ``rush`` et ``prod``.

Le nom des dossiers est reformaté en **KebabCase**. 

Le chemin d'accès au répertoire ``rush`` est automatiquement copié dans le presse-papier. 

Exemple d'arborescence créée avec un dossier parent nommé ``cours1`` et un premier chapitre nommé : ``Exemple d'un premier chapitre``

- Cours
    - 01-exemple-d-un-premier-chapitre
       - rush
       - prod 
