# usage:
# $ pwsh-dev.ps1 [x86|x64]
param(
    [String] $arch = "x64"
)

Write-Host "Setting up environment variables..."

# Visual Studio path <https://github.com/microsoft/vswhere/wiki/Find-VC>
$vsPath = &"${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationpath

Write-Host "Microsoft Visual Studio path = '$vsPath'"

# Use module `Microsoft.VisualStudio.DevShell.dll`
Import-Module (Get-ChildItem $vsPath -Recurse -File -Filter Microsoft.VisualStudio.DevShell.dll).FullName

Enter-VsDevShell -VsInstallPath $vsPath -SkipAutomaticLocation -DevCmdArguments "-arch=${arch}"

# Set compiler
Set-Item -Path "env:CC" -Value "cl.exe"
Set-Item -Path "env:CXX" -Value "cl.exe"

Write-Host "Selecting $arch C/C++ compiler."
