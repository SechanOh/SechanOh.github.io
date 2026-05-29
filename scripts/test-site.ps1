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
  @{ Pattern = 'data-theme-option="dark"'; Message = "index.html must include the dark theme option." },
  @{ Pattern = 'data-theme-option="light"'; Message = "index.html must include the light theme option." },
  @{ Pattern = 'prefers-color-scheme: dark'; Message = "Default theme must follow the system color scheme." },
  @{ Pattern = 'class="brand-link" href="/"'; Message = "Brand mark must link back to the homepage." },
  @{ Pattern = 'class="brand-glyph"'; Message = "Brand mark must include a designed glyph." },
  @{ Pattern = 'Last updated'; Message = "Homepage must visibly show a maintenance/update date." },
  @{ Pattern = 'May 29, 2026'; Message = "Homepage must show the current update date." },
  @{ Pattern = 'border-radius: 50%'; Message = "Profile photo must be displayed in a circular frame." },
  @{ Pattern = '--portrait-size'; Message = "Profile photo size must be controlled and smaller than the prior card." },
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

if ($html -match 'data-theme-option="system"') {
  throw "Theme toggle should expose only dark and light controls."
}

if ($html -match '\.portrait-frame::after') {
  throw "Profile photo must not use a gradient overlay."
}

Write-Output "Site checks passed."
