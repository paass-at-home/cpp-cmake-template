# do not continue if there are any errors
$ErrorActionPreference = "Stop"

# define directories relative to script directory
$ProjectRootPath = (Get-Item $PSScriptRoot).FullName
$ThirdParty = "$ProjectRootPath\third-party"
$DownloadsPath = "$ProjectRootPath\.downloads"

if (!(Test-Path "$ThirdParty")) {
    New-Item "$ThirdParty" -ItemType Directory
}
if (!(Test-Path "$DownloadsPath")) {
	New-Item "$DownloadsPath" -ItemType Directory
}

# SFML
Push-Location
$Url="https://www.sfml-dev.org/files/SFML-2.5.1-sources.zip"
$ZipFile="SFML-2.5.1-sources.zip"
$ZipOutputDirectory="SFML-2.5.1"
$ThirdPartyOutputPath = "$ThirdParty\SFML"

if (!(Test-Path "$ThirdPartyOutputPath")) {

    if (!(Test-Path "$DownloadsPath\$ZipFile")) {
      Write-Host "Downloading $ZipFile into $DownloadsPath folder ..."
      $WebClient = New-Object System.Net.WebClient	
      $WebClient.DownloadFile($Url, "$DownloadsPath\$ZipFile")
	}

    Set-Location $ThirdParty
    Write-Host "Unzipping $ZipFile into $ThirdPartyOutputPath ..."
	Expand-Archive $DownloadsPath\$ZipFile $ThirdParty

    # configure development shell
    Invoke-Expression "$ProjectRootPath\pwsh-dev.ps1"
 
    Set-Location $ThirdParty\${ZipOutputDirectory}

    cmake .
    cmake --build . --config Debug
    cmake --build . --config Release
    cmake --install . --prefix $ThirdPartyOutputPath --config Debug
    cmake --install . --prefix $ThirdPartyOutputPath --config Release

    Set-Location $ProjectRootPath
    Remove-Item $ThirdParty\${ZipOutputDirectory} -Recurse
}
Pop-Location
