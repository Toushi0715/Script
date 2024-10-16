# Desinstalar Firefox usando PowerShell
# Eliminar de AppData
Remove-Item -Path "$env:APPDATA\Mozilla\Firefox" -Recurse -Force

# Eliminar de registro (con precaución)
$regPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
$firefoxKey = Get-ChildItem -Path $regPath | Where-Object { $_.GetValue("DisplayName") -like "*Firefox*" }
if ($firefoxKey) {
    $firefoxKey | ForEach-Object {
        $uninstallString = $_.GetValue("UninstallString")
        Start-Process -FilePath $uninstallString -ArgumentList "/S" -Wait
    }
}

# Eliminar de Winget
winget uninstall Mozilla.Firefox

# Eliminar de Microsoft Store
Get-AppxPackage -Name *firefox* | Remove-AppxPackage

# Nota: Este script elimina Firefox de manera irreversible. Asegúrate de hacer una copia de seguridad antes de ejecutarlo.
