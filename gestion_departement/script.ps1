#Récupération des données du JSON et conversion en objet PowerShell
$regions = Get-Content .\region.json -Raw | ConvertFrom-Json
$departments = Get-Content .\departments.json -Raw | ConvertFrom-Json
$cities = Get-Content .\cities.json -Raw | ConvertFrom-Json

foreach( $region in $regions) {
    $region_num = -join("[",$region.code,"]", " ", $region.slug)
    Write-Output $region_num
    $filtered_deps = $departments | Where-Object { $_.region_code -eq $region.code  } 
    
    foreach( $department in  $filtered_deps ) {
        $formatted_dep = -join("-->", "(",$department.code, ")",$department.slug)
        Write-Output $formatted_dep
    }
}

## Création du dossier de cours parent
#  New-Item -Path $ROOT_FOLDER -Name $cours -ItemType "directory"

 # On récupére la liste des dossiers et fichiers présents dans le répertoire courant
 # $childrenItems = Get-ChildItem -Path $ROOT_FOLDER




