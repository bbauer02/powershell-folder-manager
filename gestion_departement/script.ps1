#Récupération des données du JSON et conversion en objet PowerShell
$regions = Get-Content .\region.json -Raw | ConvertFrom-Json
$departments = Get-Content .\departments.json -Raw | ConvertFrom-Json
$cities = Get-Content .\cities.json -Raw | ConvertFrom-Json


foreach( $region in $regions) {
    $regionName = -join($region.code,"-", $region.slug)
    # Write-Output $region_num
    New-Item -Path $pwd/data -Name $regionName -ItemType "directory"
    
    $filtered_deps = $departments | Where-Object { $_.region_code -eq $region.code  } 
    
    foreach( $department in  $filtered_deps ) {
        $depName = -join($department.code,"-", $department.slug)
        New-Item -Path $pwd/data/$regionName -Name $depName -ItemType "directory"

        $filtered_cities = $cities | Where-Object { $_.department_code -eq $department.code  }

        foreach( $city in  $filtered_cities ) {
            $cityName = -join($city.id,"-",$city.slug,'.txt') 
            $cityName = $cityName -replace(" ","-")
            New-Item -Path $pwd/data/$regionName/$depName/$cityName -ItemType "file"

            $content = -join($city.zip_code, " ", $city.name, "\n", $city.gps_lat)

            ADD-content -path $pwd/data/$regionName/$depName/$cityName -value $content
        }

    }
}



