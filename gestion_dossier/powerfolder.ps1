$ROOT_FOLDER = $pwd


function ravratCase {
    param (
        [string]$StringToConvert
    )
    # On remplace les espaces par des "-"
    $StringToConvert = $StringToConvert -replace(" ","-")
    # On remplace les guillemets par des "-"
    $StringToConvert = $StringToConvert -replace("'","-")
    # On supprime tous les caractères spéciaux
    #$StringToConvert.Normalize("FormD") -replace '\p{M}', ''
    [hashtable]$unicodeHashTable = @{	
        # a
        'æ' = 'a'
        'à' = 'a'
        'â' = 'a'
        'ã' = 'a'
        'å' = 'a'
        'ā' = 'a'
        'ă' = 'a'
        'ą' = 'a'
        'ä' = 'a'
        'á' = 'a' 
        # b
        'ƀ' = 'b'
        'ƃ' = 'b'     
        # Tone six
        'ƅ' = 'b'
        # c
        'ç' = 'c'
        'ć' = 'c'
        'ĉ' = 'c'
        'ċ' = 'c'
        'č' = 'c'
        'ƈ' = 'c' 
        # d
        'ď' = 'd'
        'đ' = 'd'
        'ƌ' = 'd'     
        # e
        'è' = 'e'
        'é' = 'e'
        'ê' = 'e'
        'ë' = 'e'
        'ē' = 'e'
        'ĕ' = 'e'
        'ė' = 'e'
        'ę' = 'e'
        'ě' = 'e'
        '&' = 'e'  
        # g
        'ĝ' = 'e'
        'ğ' = 'e'
        'ġ' = 'e'
        'ģ' = 'e' 
        # h
        'ĥ' = 'h'
        'ħ' = 'h'  
        # i
        'ì' = 'i'
        'í' = 'i'
        'î' = 'i'
        'ï' = 'i'
        'ĩ' = 'i'
        'ī' = 'i'
        'ĭ' = 'i'
        'į' = 'i'
        'ı' = 'i'  
        # j
        'ĳ' = 'j'
        'ĵ' = 'j'
        # k
        'ķ' = 'k'
        'ĸ' = 'k'   
        # l
        'ĺ' = 'l'
        'ļ' = 'l'
        'ľ' = 'l'
        'ŀ' = 'l'
        'ł' = 'l'    
        # n
        'ñ' = 'n'
        'ń' = 'n'
        'ņ' = 'n'
        'ň' = 'n'
        'ŉ' = 'n'
        'ŋ' = 'n'  
        # o
        'ð' = 'o'
        'ó' = 'o'
        'õ' = 'o'
        'ô' = 'o'
        'ö' = 'o'
        'ø' = 'o'
        'ō' = 'o'
        'ŏ' = 'o'
        'ő' = 'o'
        'œ' = 'o'    
        # r
        'ŕ' = 'r'
        'ŗ' = 'r'
        'ř' = 'r'
        # s
        'ś' = 's'
        'ŝ' = 's'
        'ş' = 's'
        'š' = 's'
        'ß' = 'ss'
        'ſ' = 's'       
        # t
        'ţ' = 't'
        'ť' = 't'
        'ŧ' = 't'       
        # u
        'ù' = 'u'
        'ú' = 'u'
        'û' = 'u'
        'ü' = 'u'
        'ũ' = 'u'
        'ū' = 'u'
        'ŭ' = 'u'
        'ů' = 'u'
        'ű' = 'u'
        'ų' = 'u'     
        # w
        'ŵ' = 'w'       
        # y
        'ý' = 'y'
        'ÿ' = 'y'
        'ŷ' = 'y'   
        # z
        'ź' = 'z'
        'ż' = 'z'
        'ž' = 'z'
    }

    $CharArray = $StringToConvert.ToLower().ToCharArray()
    [array]$NewCharArray = @()
    foreach ($Char in $CharArray)
    {
        if ($UnicodeHashTable.ContainsKey($Char.ToString()) -eq $true) {
            $Char = $UnicodeHashTable["$($Char)"]
            $NewCharArray += $Char
        }
        else {
            $NewCharArray += $Char
        }
    }
    return [system.String]::Join("", $NewCharArray)
}
function Show-Menu {
    param (
        [string]$Title = 'My Menu',
        [string]$Question = 'Select an action',
        [String[]]$Items
    )
    do {
        Clear-Host
        Write-Host " $Title " -ForegroundColor Yellow
        Write-Host ""
        $i = 1
        foreach($Item in $Items) {
            Write-Host [$i] -ForegroundColor Green -NoNewline; 
            Write-Host ":"  $Item -ForegroundColor DarkBlue; 
            $i++
        }
    }until ($selection -ne  '')
    Write-Host ""
    $selection = Read-Host $Question
    return $selection
}
# On défini un tableau d'action possible.
$titre = "Gestion des dossiers vidéos"
$question = "Choisir une action"
$choix = @("Créer un nouveau cours", "Ajouter un chapitre à un cours")
$reponse = Show-Menu $titre $question $choix
# Créer un nouveau cours
if( $reponse -eq 1 ) {
    # Demander le nom du dossier à créer.
        Clear-Host
        Write-Host "Etape 1/2 : Créer un nouveau cours" -ForegroundColor Yellow 
        Write-Host ""
        Write-Host "Vous allez créer un nouveau dossier dans le répertoire :"  -ForegroundColor DarkBlue
        Write-Host "$pwd" -ForegroundColor Magenta
        Write-Host ""
        $cours = Read-Host -Prompt "Nom du cours" 
        if($cours -eq "") {
            Write-Host "Aucun nom de cours n'a été saisi" -ForegroundColor Red 
            return
        }
        $cours = ravratCase $cours
        if(Test-Path -Path $cours) {
            Write-Host  "Le dossier '$cours' existe déjà." -ForegroundColor Red
            return
        }
    
    # Demander le nom du premier chapitre.
        Clear-Host
        Write-Host "Etape 2/2 : Créer un chapitre de cours" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Vous allez créer un nouveau chapitre dans le répertoire : " -ForegroundColor DarkBlue
        Write-Host "$pwd\$cours" -ForegroundColor Magenta
        Write-Host ""
        $chapitre = Read-Host -Prompt "Nom du chapitre (chapitre)"
        if ($chapitre -eq "" ) {
            $chapitre = "chapitre"
        }
        $chapitre = ravratCase $chapitre
        $chapitre = "01-"+ $chapitre
    # Création du dossier de cours parent
        New-Item -Path $ROOT_FOLDER -Name $cours -ItemType "directory"
    # Création du dossier pour le premier chapitre
        New-Item -Path $ROOT_FOLDER/$cours -Name $chapitre -ItemType "directory"
    # Création des dossiers : prod et rush
        'prod','rush' | ForEach-Object {New-Item -Path $ROOT_FOLDER/$cours/$chapitre -Name "$_" -ItemType 'Directory'}
    # On copie le chemin du répertoire rush dans le presse papier
        $rushFolder = -join($pwd,"\",$cours,"\",$chapitre,"\", "rush")
        Set-Clipboard -Value $rushFolder
}       


# -----------------------------------------------------------------------
# -----------------------------------------------------------------------
# -----------------------------------------------------------------------


# Ajouter un chapitre à un cours existant
if( $reponse -eq 2) {
    # Afficher la liste des dossiers.
    # On récupére la liste des dossiers et fichiers présents dans le répertoire courant
    $childrenItems = Get-ChildItem -Path $ROOT_FOLDER
    [array]$folders = @()
    foreach ($item in $childrenItems) {
        # On test si l'item est un répertoire.
        if ($item.Attributes -eq "Directory") {
            #Créer un tableau contenant le nom des répertoires seulement
            $folders += $item.Name
        }
    }
    # Affichage du menu affichant la liste des cours
    $titre = "Etape 1/2 : Sélectionnez un cours"
    $question = "Choisir un numéro de cours"
    $reponse = Show-Menu $titre $question $folders
    if( $reponse -lt 1 -or $reponse -gt $folders.Length  ) {
        "Votre choix ne correspond pas à un cours connus!"
        break
    }
    if($coursSelected -eq "")  {
        "Aucun cours sélectionné"
    }
    # Récupération de la liste des cours
    $coursSelected = $folders[$reponse-1]
    # Demander le nom du chapitre à ajouter.
    Clear-Host
    Write-Host "Etape 2/2 : Créer un nouveau chapitre" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Vous allez créer un nouveau chapitre dans le répertoire : " -ForegroundColor DarkBlue
    Write-Host "$pwd\$coursSelected" -ForegroundColor Magenta
    Write-Host ""
    $chapitre = Read-Host -Prompt "Saisissez un nom (par défault : chapitre)"
    if($chapitre -eq "") {
        $chapitre = "chapitre"
        break
    }
    #On formate le nom du chapitre avec la norme RavratCase
    $chapitre = ravratCase $chapitre
    #On récupére la liste des chapitres pour en déduire la dernière numérotation
    $chapitres = Get-ChildItem -Path $ROOT_FOLDER/$coursSelected
    $lastNumber = $chapitres.Length + 1
    # On génére un nouveau nom de chapitre avec le numéro
    # "1" => "01" 
    $chapitre = ([string]$lastNumber).PadLeft(2,'0')+ "-"+$chapitre
    #Création du dossier
    New-Item -Path $ROOT_FOLDER/$coursSelected -Name $chapitre -ItemType "directory"
    # Création des dossiers : prod et rush
    'prod','rush' | ForEach-Object {New-Item -Path $ROOT_FOLDER/$coursSelected/$chapitre -Name "$_" -ItemType 'Directory'}
    # On copie le chemin du répertoire rush dans le presse papier
    $rushFolder = -join($pwd,"\",$coursSelected,"\",$chapitre,"\", "rush")
    Set-Clipboard -Value $rushFolder


}