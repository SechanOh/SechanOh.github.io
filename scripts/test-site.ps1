$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$indexPath = Join-Path $root "index.html"
$photoPath = Join-Path $root "figures\SechanOh_picture.jpg"

if (-not (Test-Path $indexPath)) {
  throw "index.html is required for the GitHub Pages root."
}

if (-not (Test-Path $photoPath)) {
  throw "Profile photo figures\SechanOh_picture.jpg is missing."
}

$html = Get-Content -Raw -Path $indexPath

$requirements = @(
  @{ Pattern = 'figures/SechanOh_picture\.jpg'; Message = "index.html must reference the profile photo." },
  @{ Pattern = 'data-theme-option="system"'; Message = "index.html must include the system theme option." },
  @{ Pattern = 'data-theme-option="dark"'; Message = "index.html must include the dark theme option." },
  @{ Pattern = 'data-theme-option="light"'; Message = "index.html must include the light theme option." },
  @{ Pattern = 'autoplay=1'; Message = "YouTube background must request autoplay." },
  @{ Pattern = 'mute=1'; Message = "YouTube background must default to muted." },
  @{ Pattern = 'youtubeId'; Message = "Media replacement should be controlled through a YouTube id config." },
  @{ Pattern = 'Radar Signal Processing'; Message = "Homepage must present the radar signal processing identity." },
  @{ Pattern = 'Sensor Fusion'; Message = "Homepage must present the sensor fusion identity." }
)

foreach ($requirement in $requirements) {
  if ($html -notmatch $requirement.Pattern) {
    throw $requirement.Message
  }
}

Write-Output "Site checks passed."
