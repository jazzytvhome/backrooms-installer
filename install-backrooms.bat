@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command "& ([scriptblock]::Create(([System.IO.File]::ReadAllText('%~f0') -replace '(?s)^.*::PSBEGIN\r?\n','')))"
exit /b %ERRORLEVEL%

::PSBEGIN
$host.UI.RawUI.WindowTitle = 'Backrooms Mod Installer'
$modsDir = "$env:APPDATA\.minecraft\mods"
$releaseBase = "https://github.com/jazzytvhome/backrooms-installer/releases/latest/download"

$mods = @(
    "fabric-api-0.92.9+1.20.1.jar",
    "geckolib-fabric-1.20.1-4.8.3.jar",
    "spb-revamped-1.20.1-1.2.0.jar",
    "voicechat-fabric-1.20.1-2.6.18.jar"
)

Write-Host ""
Write-Host " =====================================================" -ForegroundColor Green
Write-Host "   Found Footage (Backrooms) Mod Installer" -ForegroundColor Green
Write-Host "   Minecraft 1.20.1 - Fabric - TLauncher" -ForegroundColor Green
Write-Host " =====================================================" -ForegroundColor Green
Write-Host ""

if (-not (Test-Path $modsDir)) { New-Item -ItemType Directory -Path $modsDir | Out-Null }

Write-Host " [*] Installing mods to: $modsDir" -ForegroundColor Cyan
Write-Host ""

foreach ($mod in $mods) {
    $dest = Join-Path $modsDir $mod
    if (Test-Path $dest) {
        Write-Host "  Already installed: $mod" -ForegroundColor Yellow
        continue
    }
    Write-Host "  Downloading: $mod" -ForegroundColor Green
    try {
        Invoke-WebRequest -Uri "$releaseBase/$mod" -OutFile $dest -UseBasicParsing
        Write-Host "  Done!" -ForegroundColor Green
    } catch {
        Write-Host "  [ERROR] Failed to download ${mod}: $_" -ForegroundColor Red
        Start-Sleep 10; exit 1
    }
}

Write-Host ""
Write-Host " =====================================================" -ForegroundColor Green
Write-Host "   Done! Launch TLauncher, pick Fabric 1.20.1, play!" -ForegroundColor Green
Write-Host " =====================================================" -ForegroundColor Green
Write-Host ""
Write-Host " NOTE: Does NOT work with Sodium or Iris!" -ForegroundColor Yellow
Write-Host ""
Start-Sleep 5
