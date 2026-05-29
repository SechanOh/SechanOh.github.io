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
  @{ Pattern = '<link rel="icon" type="image/svg\+xml" href="figures/brand-mark\.svg">'; Message = "Brand mark must be used as the browser tab icon." },
  @{ Pattern = '<title>Sechan Oh Homepage</title>'; Message = "Browser tab title should be concise and homepage-oriented." },
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
  @{ Pattern = 'class="contact-panel"'; Message = "Contact section should keep its layout without boxed module styling." },
  @{ Pattern = 'ko:\s*\{'; Message = "Korean content block must be present for language switching." },
  @{ Pattern = 'class="nav-links"'; Message = "Navigation links must be grouped separately from controls." },
  @{ Pattern = 'class="nav-controls"'; Message = "Theme and language controls must be grouped at the far right." },
  @{ Pattern = 'class="profile-panel hero-profile"'; Message = "Profile panel must be placed before the hero copy." },
  @{ Pattern = 'class="profile-photo"'; Message = "Profile photo must exist in the profile panel." },
  @{ Pattern = 'class="profile-meta"'; Message = "Profile name and caption should live in the right profile module." },
  @{ Pattern = 'class="profile-signals-body"'; Message = "Signal capability text must sit below the profile identity row on mobile." },
  @{ Pattern = 'grid-template-areas:\s*"photo meta"\s*"photo signals"'; Message = "Desktop profile should use a composed photo/name/signals layout." },
  @{ Pattern = 'grid-area:\s*photo'; Message = "Profile photo should be explicitly placed in the desktop composition." },
  @{ Pattern = 'grid-area:\s*meta'; Message = "Profile identity should be explicitly placed in the desktop composition." },
  @{ Pattern = 'grid-area:\s*signals'; Message = "Profile signal text should be explicitly placed in the desktop composition." },
  @{ Pattern = 'class="hero-copy"'; Message = "Hero copy must be explicitly separated after the profile block." },
  @{ Pattern = '\.hero-copy\s*\{[^}]*width:\s*100%'; Message = "Hero copy should use the same available width as the module sections." },
  @{ Pattern = '\.hero-copy\s*\{[^}]*max-width:\s*none'; Message = "Hero copy should not feel narrower than other modules." },
  @{ Pattern = '\.section-title-group\s*\{[^}]*display:\s*grid'; Message = "Section kicker and title spacing should use one shared title group." },
  @{ Pattern = 'class="section-title-group"'; Message = "Work and Notes headings should use the shared title spacing group." },
  @{ Pattern = '\.module-card\s*\{[^}]*border:\s*1px solid var\(--line\)'; Message = "Homepage modules must share one bordered card design." },
  @{ Pattern = '\.module-card\s*\{[^}]*border-radius:\s*8px'; Message = "Homepage modules must share the same card radius." },
  @{ Pattern = '\.module-card\s*\{[^}]*background:\s*var\(--surface\)'; Message = "Homepage modules must share the same surface treatment." },
  @{ Pattern = 'position:\s*sticky'; Message = "Header must remain sticky while scrolling." },
  @{ Pattern = '\.section-head\s*\{[^}]*display:\s*grid'; Message = "Section headings should stack title and copy vertically." },
  @{ Pattern = 'prefers-color-scheme: dark'; Message = "Default theme must follow the system color scheme." },
  @{ Pattern = 'class="brand-link" href="/"'; Message = "Brand mark must link back to the homepage." },
  @{ Pattern = 'class="brand-glyph"'; Message = "Brand mark must include a designed glyph." },
  @{ Pattern = 'Last updated'; Message = "Homepage must visibly show a maintenance/update date." },
  @{ Pattern = 'May 29, 2026'; Message = "Homepage must show the current update date." },
  @{ Pattern = '--bg:\s*#e8eee2'; Message = "Light theme should use a warmer sage background, not plain white." },
  @{ Pattern = '--bg:\s*#07110d'; Message = "Dark theme should use an ink-green background, not pure black." },
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

if ($html -match 'max-width:\s*820px' -or $html -match 'max-width:\s*730px') {
  throw "Hero headline and summary should not keep narrow standalone max-widths."
}

if ($html -match '--bg:\s*#020403' -or $html -match '--bg:\s*#f2f4ee') {
  throw "Theme backgrounds should avoid near-black and near-white extremes."
}

if ($html -match 'Detection, estimation, filtering, tracking, and interpretation under ambiguity') {
  throw "Radar processing copy is too long for the mobile side-by-side profile panel."
}

if ($html -match '@media \(max-width: 560px\)[\s\S]*?\.profile-panel\s*\{[^}]*grid-template-columns:\s*1fr') {
  throw "Profile panel should remain left-right on mobile."
}

if ($html -match 'class="profile-photo module-card"' -or $html -match 'class="profile-signals module-card"') {
  throw "Profile identity and signal copy should not be boxed as module cards."
}

if ($html -match 'class="contact-panel module-card"') {
  throw "Contact section should not be boxed as a module card."
}

if ($html -notmatch '\.profile-signals-body\s*\{[^}]*grid-area:\s*signals') {
  throw "Desktop profile signal copy should align to the right of the photo."
}

if ($html -notmatch '@media \(max-width: 560px\)[\s\S]*?\.profile-signals-body\s*\{[^}]*grid-column:\s*1\s*/\s*-1') {
  throw "Mobile profile signal copy should sit below the photo and name row."
}

if ($html -notmatch '@media \(max-width: 560px\)[\s\S]*?\.profile-panel\s*\{[^}]*column-gap:\s*18px[^}]*row-gap:\s*22px') {
  throw "Mobile profile needs more space between photo/name and the signal copy."
}

if ($html -notmatch '@media \(max-width: 560px\)[\s\S]*?--portrait-size:\s*112px') {
  throw "Small mobile profile photo should be slightly larger."
}

if ($html -match 'Multi-modal reasoning across imperfect measurements, timing, and confidence') {
  throw "Sensor fusion copy is too long for the mobile side-by-side profile panel."
}

if ($html -match '\.brand-text\s*\{\s*display:\s*none') {
  throw "Brand text should remain visible on mobile."
}

if ($html -match '\.brand-text\s+span:last-child\s*\{[^}]*display:\s*none') {
  throw "Brand subtitle should remain visible on mobile."
}

if ($html -match '\.portrait-caption\s+span:last-child\s*\{[^}]*display:\s*none') {
  throw "Portrait caption subtitle should remain visible on mobile."
}

if ($html -match 'profile-signals-head') {
  throw "Profile signal panel should not repeat the name and perception systems label."
}

if ($html -match '<figure class="profile-photo">[\s\S]*?<figcaption') {
  throw "Profile caption should be positioned in the right module, not below the photo."
}

if ($html -match '\.section-head\s*\{[^}]*display:\s*flex') {
  throw "Section headings should not use side-by-side flex layout."
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
