# Reconstruye el historial en commits incrementales (30+).
$ErrorActionPreference = "Stop"
Set-Location (Split-Path $PSScriptRoot -Parent)

$heroBackup = Join-Path $env:TEMP "sentinella-hero-backup.jpeg"
Copy-Item "assets\hero-dashboard.jpeg" $heroBackup -Force

$indexLines = Get-Content "index.html"
$cssLines = Get-Content "styles.css"
$jsLines = Get-Content "script.js"
$readmeLines = Get-Content "README.md"
$privacyLines = Get-Content "privacy.html"
$termsLines = Get-Content "terms.html"

function Write-Lines($path, $lines) {
    $dir = Split-Path $path -Parent
    if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    $utf8 = New-Object System.Text.UTF8Encoding $false
    if ($lines.Count -eq 0) {
        [System.IO.File]::WriteAllText($path, "", $utf8)
        return
    }
    [System.IO.File]::WriteAllLines($path, [string[]]$lines, $utf8)
}

function Slice($lines, $start, $end) {
    if ($end -lt $start) { return @() }
    return $lines[($start - 1)..($end - 1)]
}

function Invoke-Git {
    param([Parameter(ValueFromRemainingArguments = $true)][string[]]$GitArgs)
    $prev = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    & git.exe @GitArgs 2>&1 | Out-Null
    $ErrorActionPreference = $prev
    if ($LASTEXITCODE -ne 0) { throw "git $($GitArgs -join ' ') failed with $LASTEXITCODE" }
}

function Commit($msg) {
    Invoke-Git add -A
    Invoke-Git commit "-m" $msg
}

Invoke-Git checkout --orphan chicamax-upc-main
Remove-Item -Recurse -Force index.html, styles.css, script.js, README.md, privacy.html, terms.html, assets -ErrorAction SilentlyContinue

# README (3)
Write-Lines "README.md" (Slice $readmeLines 1 4)
Commit "docs: readme titulo e introduccion del sitio estatico"

Write-Lines "README.md" (Slice $readmeLines 1 14)
Commit "docs: readme tabla de archivos del proyecto"

Write-Lines "README.md" $readmeLines
Commit "docs: readme vista local despliegue e imagenes"

# index.html (9)
$htmlAcc = @()
$htmlAcc += Slice $indexLines 1 17
Write-Lines "index.html" $htmlAcc
Commit "feat: html head meta seo y fuentes"

$htmlAcc += Slice $indexLines 18 48
Write-Lines "index.html" $htmlAcc
Commit "feat: html header navegacion y selector de idioma"

$htmlAcc += Slice $indexLines 49 80
Write-Lines "index.html" $htmlAcc
Commit "feat: html seccion hero con imagen dashboard"

$htmlAcc += Slice $indexLines 81 107
Write-Lines "index.html" $htmlAcc
Commit "feat: html seccion metricas estadisticas"

$htmlAcc += Slice $indexLines 108 149
Write-Lines "index.html" $htmlAcc
Commit "feat: html seccion capacidades centrales"

$htmlAcc += Slice $indexLines 150 202
Write-Lines "index.html" $htmlAcc
Commit "feat: html seccion flujo de implementacion y roles"

$htmlAcc += Slice $indexLines 203 245
Write-Lines "index.html" $htmlAcc
Commit "feat: html seccion precios y testimonios"

$htmlAcc += Slice $indexLines 246 275
Write-Lines "index.html" $htmlAcc
Commit "feat: html formulario de contacto"

$htmlAcc += Slice $indexLines 276 295
Write-Lines "index.html" $htmlAcc
Commit "feat: html footer enlaces legales y script"

# styles.css (17)
$cssAcc = @()
$cssAcc += Slice $cssLines 1 111
Write-Lines "styles.css" $cssAcc
Commit "style: variables globales tipografia y layout base"

$cssAcc += Slice $cssLines 112 231
Write-Lines "styles.css" $cssAcc
Commit "style: header fijo y barra de marca"

$cssAcc += Slice $cssLines 232 285
Write-Lines "styles.css" $cssAcc
Commit "style: menu movil y toggle hamburguesa"

$cssAcc += Slice $cssLines 286 350
Write-Lines "styles.css" $cssAcc
Commit "style: botones primarios secundarios y pills"

$cssAcc += Slice $cssLines 351 438
Write-Lines "styles.css" $cssAcc
Commit "style: hero split con imagen monitor"

$cssAcc += Slice $cssLines 439 492
Write-Lines "styles.css" $cssAcc
Commit "style: tarjetas de metricas stats"

$cssAcc += Slice $cssLines 493 599
Write-Lines "styles.css" $cssAcc
Commit "style: grid de capacidades features"

$cssAcc += Slice $cssLines 600 700
Write-Lines "styles.css" $cssAcc
Commit "style: seccion como funciona pasos"

$cssAcc += Slice $cssLines 701 822
Write-Lines "styles.css" $cssAcc
Commit "style: planes pricing cards"

$cssAcc += Slice $cssLines 823 853
Write-Lines "styles.css" $cssAcc
Commit "style: bloque cta final"

$cssAcc += Slice $cssLines 854 950
Write-Lines "styles.css" $cssAcc
Commit "style: footer oscuro base"

$cssAcc += Slice $cssLines 951 1129
Write-Lines "styles.css" $cssAcc
Commit "style: paginas legales privacy y terms"

$cssAcc += Slice $cssLines 1130 1157
Write-Lines "styles.css" $cssAcc
Commit "style: animacion reveal al scroll"

$cssAcc += Slice $cssLines 1158 1295
Write-Lines "styles.css" $cssAcc
Commit "style: flujo beneficios y roles operacion"

$cssAcc += Slice $cssLines 1296 1397
Write-Lines "styles.css" $cssAcc
Commit "style: precios destacados y testimonios"

$cssAcc += Slice $cssLines 1398 1485
Write-Lines "styles.css" $cssAcc
Commit "style: formulario contacto y feedback"

$cssAcc += Slice $cssLines 1486 $cssLines.Count
Write-Lines "styles.css" $cssAcc
Commit "style: footer tres columnas responsive"

# script.js (8)
$jsAcc = @()
$jsAcc += Slice $jsLines 1 118
Write-Lines "script.js" $jsAcc
Commit "feat: i18n catalogo ingles EN"

$jsAcc += Slice $jsLines 1 232
Write-Lines "script.js" $jsAcc
Commit "feat: i18n catalogo espanol ES"

$jsAcc += Slice $jsLines 1 290
Write-Lines "script.js" $jsAcc
Commit "feat: applyTranslations preferencia idioma y meta"

$jsAcc += Slice $jsLines 1 306
Write-Lines "script.js" $jsAcc
Commit "feat: conmutador EN ES en navbar"

$jsAcc += Slice $jsLines 1 335
Write-Lines "script.js" $jsAcc
Commit "feat: menu movil responsive y cierre al navegar"

$jsAcc += Slice $jsLines 1 364
Write-Lines "script.js" $jsAcc
Commit "feat: formulario contacto validacion mailto"

$jsAcc += Slice $jsLines 1 384
Write-Lines "script.js" $jsAcc
Commit "feat: intersection observer reveal scroll"

$jsAcc = $jsLines
Write-Lines "script.js" $jsAcc
Commit "chore: utilidad debounce para resize menu"

# assets + legal (3)
New-Item -ItemType Directory -Path assets -Force | Out-Null
Copy-Item $heroBackup "assets\hero-dashboard.jpeg" -Force
Commit "assets: imagen hero dashboard monitor operaciones"

Write-Lines "privacy.html" $privacyLines
Commit "feat: pagina politica de privacidad bilingue"

Write-Lines "terms.html" $termsLines
Commit "feat: pagina terminos del servicio"

Write-Host "Total commits:"
git rev-list --count HEAD
