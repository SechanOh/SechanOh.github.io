$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$indexPath = Join-Path $root "index.html"
$photoPath = Join-Path $root "figures\SechanOh_picture.jpg"
$brandMarkPath = Join-Path $root "figures\brand-mark.svg"
$contentPath = Join-Path $root "content\site-config.js"
$issueTemplatePath = Join-Path $root ".github\ISSUE_TEMPLATE\homepage-request.yml"
$issueConfigPath = Join-Path $root ".github\ISSUE_TEMPLATE\config.yml"
$issueWorkflowPath = Join-Path $root "docs\github-issues-workflow.md"

if (-not (Test-Path $indexPath)) {
  throw "index.html is required for the GitHub Pages root."
}

if (-not (Test-Path $photoPath)) {
  throw "Profile photo figures\SechanOh_picture.jpg is missing."
}

if (-not (Test-Path $brandMarkPath)) {
  throw "Brand mark figures\brand-mark.svg is missing."
}

if (-not (Test-Path $contentPath)) {
  throw "Editable content config content\site-config.js is missing."
}

if (-not (Test-Path $issueTemplatePath)) {
  throw "GitHub Issues homepage request template is missing."
}

if (-not (Test-Path $issueConfigPath)) {
  throw "GitHub Issues template config is missing."
}

if (-not (Test-Path $issueWorkflowPath)) {
  throw "GitHub Issues workflow documentation is missing."
}

$html = Get-Content -Raw -Path $indexPath
$content = Get-Content -Raw -Path $contentPath
$issueTemplate = Get-Content -Raw -Path $issueTemplatePath
$issueWorkflow = Get-Content -Raw -Path $issueWorkflowPath

$requirements = @(
  @{ Pattern = 'figures/SechanOh_picture\.jpg'; Message = "index.html must reference the profile photo." },
  @{ Pattern = 'figures/brand-mark\.svg'; Message = "index.html must reference the editable brand mark asset." },
  @{ Pattern = 'content/site-config\.js'; Message = "index.html must load the editable content config." },
  @{ Pattern = 'class="theme-toggle single-toggle"'; Message = "Theme must use one toggle control." },
  @{ Pattern = 'aria-label="Toggle color theme"'; Message = "Theme toggle must be a single accessible control." },
  @{ Pattern = 'class="toggle-orb theme-orb"'; Message = "Theme toggle must use one small circular orb." },
  @{ Pattern = 'class="language-toggle single-toggle"'; Message = "Language must use one toggle control." },
  @{ Pattern = 'aria-label="Toggle language"'; Message = "Language toggle must be a single accessible control." },
  @{ Pattern = 'data-lang-current="en"'; Message = "Homepage must track current language state." },
  @{ Pattern = 'class="language-code"'; Message = "Language toggle should show only the current language inside the orb." },
  @{ Pattern = 'class="hero-stack"'; Message = "Hero content must stack profile above the main statement." },
  @{ Pattern = 'const translations ='; Message = "Homepage must include a translation dictionary." },
  @{ Pattern = 'data-i18n='; Message = "Homepage text must be wired for language switching." },
  @{ Pattern = 'id="work"'; Message = "Work navigation target section must exist." },
  @{ Pattern = 'id="writing"'; Message = "Notes navigation target section must exist." },
  @{ Pattern = 'id="contact"'; Message = "Contact navigation target section must exist." },
  @{ Pattern = 'Signal chain design'; Message = "Work section should include substantial radar/sensor content." },
  @{ Pattern = 'Tracking under uncertainty'; Message = "Notes section should include a technical note entry." },
  @{ Pattern = 'Open to technical conversations'; Message = "Contact section should include a clear contact prompt." },
  @{ Pattern = 'ko:\s*\{'; Message = "Korean content block must be present for language switching." },
  @{ Pattern = 'class="nav-links"'; Message = "Navigation links must be grouped separately from controls." },
  @{ Pattern = 'class="nav-controls"'; Message = "Theme and language controls must be grouped at the far right." },
  @{ Pattern = 'class="profile-panel hero-profile"'; Message = "Profile panel must be placed before the hero copy." },
  @{ Pattern = 'class="profile-photo"'; Message = "Profile photo must be the left side of the profile panel." },
  @{ Pattern = 'class="profile-signals"'; Message = "Signal capabilities must be the right side of the profile panel." },
  @{ Pattern = 'class="hero-copy"'; Message = "Hero copy must be explicitly separated after the profile block." },
  @{ Pattern = 'prefers-color-scheme: dark'; Message = "Default theme must follow the system color scheme." },
  @{ Pattern = 'class="brand-link" href="/"'; Message = "Brand mark must link back to the homepage." },
  @{ Pattern = 'class="brand-glyph"'; Message = "Brand mark must include a designed glyph." },
  @{ Pattern = 'Last updated'; Message = "Homepage must visibly show a maintenance/update date." },
  @{ Pattern = 'May 29, 2026'; Message = "Homepage must show the current update date." },
  @{ Pattern = 'border-radius: 50%'; Message = "Profile photo must be displayed in a circular frame." },
  @{ Pattern = '--portrait-size'; Message = "Profile photo size must be controlled and smaller than the prior card." },
  @{ Pattern = 'object-fit: contain'; Message = "Profile photo should be contained so it is less cropped." },
  @{ Pattern = 'object-position: center top'; Message = "Profile crop should prioritize the face and hair." },
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

if ($html -match 'data-theme-option="dark"' -or $html -match 'data-theme-option="light"') {
  throw "Theme control should be one toggle, not two theme buttons."
}

if ($html -match 'data-lang-option="en"' -or $html -match 'data-lang-option="ko"') {
  throw "Language control should be one toggle, not two language buttons."
}

if ($html -match 'content:\s*"EN"' -or $html -match 'content:\s*"KO"') {
  throw "Language toggle should not show both EN and KO labels."
}

if ($html -match 'mediaConfig\.youtubeId<br>replace YouTube ID later') {
  throw "Placeholder media slots should be replaced by real homepage sections."
}

if ($html -match 'Detection, estimation, filtering, tracking, and interpretation under ambiguity') {
  throw "Radar processing copy is too long for the mobile side-by-side profile panel."
}

if ($html -match 'Multi-modal reasoning across imperfect measurements, timing, and confidence') {
  throw "Sensor fusion copy is too long for the mobile side-by-side profile panel."
}

if ($html -match '@media \(max-width: 880px\)[\s\S]*?\.profile-panel\s*\{[^}]*grid-template-columns:\s*1fr') {
  throw "Profile panel should remain side-by-side on mobile."
}

if ($html -match '\.brand-text\s*\{\s*display:\s*none') {
  throw "Brand text should remain visible on mobile."
}

if ($html -match '\.portrait-frame::after') {
  throw "Profile photo must not use a gradient overlay."
}

if ($html -match 'filter:\s*saturate') {
  throw "Profile photo must not use color/contrast filters."
}

foreach ($pattern in @('brandName', 'brandSubtitle', 'profileImage', 'youtubeId', 'lastUpdatedLabel')) {
  if ($content -notmatch $pattern) {
    throw "content\site-config.js must expose $pattern for easy editing."
  }
}

foreach ($pattern in @('Homepage change request', 'request_type', 'Mobile context', 'Acceptance criteria', 'codex-homepage')) {
  if ($issueTemplate -notmatch $pattern) {
    throw "homepage-request.yml must include $pattern."
  }
}

foreach ($pattern in @('GitHub Issues', 'Codex', 'mobile', 'acceptance criteria')) {
  if ($issueWorkflow -notmatch $pattern) {
    throw "GitHub Issues workflow documentation must mention $pattern."
  }
}

Write-Output "Site checks passed."
