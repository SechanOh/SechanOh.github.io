# SechanOh.github.io

This repository is the GitHub Pages source for Sechan Oh's personal homepage:

https://sechanoh.github.io/

Treat this README as the canonical project context. Future Codex sessions should be able to continue the project from this file alone, without relying on prior chat history.

## Project Intent

This is a personal branding homepage for Sechan Oh, a radar signal processing and sensor fusion engineer. The site should feel atmospheric, technical, confident, and polished. It should communicate perception systems, radar processing, sensor fusion, signal timing, confidence handling, and engineering judgment under uncertainty.

The homepage is not a generic portfolio template. It should feel like a personal brand system for an engineer working with noisy measurements, real-world constraints, and decision-making systems.

Primary positioning:

- Name: Sechan Oh
- Field: radar signal processing and sensor fusion
- Brand language: signal systems, perception systems, engineering signal from uncertainty
- Tone: technical, restrained, premium, modern, not flashy or gimmicky
- Default experience: responsive, mobile-friendly, system-theme-aware

## Non-Negotiable Product Requirements

Preserve these requirements unless the owner explicitly changes direction:

- The site must work as a static GitHub Pages site from the repository root.
- `index.html` is the deployed homepage entry point.
- The default color mode must follow the user's system setting.
- The UI must provide one dark/light toggle, not two separate theme buttons.
- The UI must provide one EN/KO language toggle, not two separate language buttons.
- The language toggle should display only the current language code, for example `EN` or `KO`, not both at once.
- The header must stay sticky while scrolling.
- Anchor navigation must account for the sticky header so section titles are not hidden.
- The top navigation must keep Work, Notes, Contact, theme, and language controls aligned like a menu on mobile.
- The far-right header controls should be theme first, language second.
- The profile image must be circular.
- The profile image must not have a gradient overlay or color/contrast filter.
- The profile image should use `object-fit: contain` and prioritize the face/hair with `object-position: center top`.
- The browser tab icon must use `figures/brand-mark.svg`.
- The header brand must be text, not the favicon SVG mark.
- The browser title should remain concise: `Sechan Oh Homepage`.
- The homepage must visibly show a last-updated date.
- Background colors must not be near-black or near-white; both light and dark themes should have a distinctive, slightly witty palette.
- The system-light media overlay must use the light background palette by default.
- The system-dark media overlay and explicit dark theme must use the dark background palette.
- Small text must stay readable; the current minimum readable token is `--min-readable: 13px`.
- Work and Notes content should use consistent bordered module cards.
- The profile identity/signals area should not be boxed as module cards.
- The Contact section should not be boxed as a module card.
- The homepage should support an optional muted autoplay YouTube background video.

## Repository Layout

```text
.
|-- index.html
|-- content/
|   `-- site-config.js
|-- figures/
|   |-- brand-mark.svg
|   `-- SechanOh_picture.jpg
|-- scripts/
|   `-- test-site.ps1
|-- docs/
|   `-- github-issues-workflow.md
|-- .github/
|   `-- ISSUE_TEMPLATE/
|       |-- config.yml
|       `-- homepage-request.yml
|-- brainstorm-preview.html
|-- .gitignore
`-- README.md
```

## Runtime Architecture

This is a plain static site. There is no bundler, framework, package manager, or build step.

`index.html` contains:

- document metadata and favicon reference
- all CSS in a `<style>` block
- the deployed HTML structure
- the translation dictionary
- theme toggle logic
- language toggle logic
- configurable asset/media loading

`content/site-config.js` defines `window.siteContent`, which is loaded by `index.html` before the inline page script reads it.

Current config shape:

```js
window.siteContent = {
  brandName: "Sechan Oh",
  brandSubtitle: "signal systems",
  profileImage: "figures/SechanOh_picture.jpg",
  brandMark: "figures/brand-mark.svg",
  youtubeId: "REPLACE_WITH_YOUTUBE_ID",
  workVisual: "",
  lastUpdatedLabel: "May 29, 2026",
  lastUpdatedDate: "2026-05-29"
};
```

Important behavior:

- `profileImage` controls the portrait image source.
- `brandMark` is intended as the editable brand mark path, but the favicon link in `index.html` must also continue to point at `figures/brand-mark.svg`.
- `youtubeId` should contain only the YouTube video ID. If it is `REPLACE_WITH_YOUTUBE_ID`, no iframe is added.
- When a valid `youtubeId` exists, the page creates a YouTube iframe with `autoplay=1` and `mute=1`.
- `lastUpdatedLabel` is visible text.
- `lastUpdatedDate` is the machine-readable `<time datetime>`.

## Page Structure

The deployed page structure in `index.html` is:

- `div.media-backdrop#hero-media`: fixed background layer and optional YouTube iframe host
- `div.shell`: page layout wrapper
- `header`: sticky top navigation
- `main`
- `section.hero-stack`: intro area
- `aside.profile-panel.hero-profile`: portrait, name/caption, radar/fusion capability text
- `div.hero-divider`: plain separator between profile and headline
- `div.hero-copy`: headline, summary, CTAs
- `section.content-sections`
- `section.section-band#work`: selected work
- `section.section-band#writing`: notes
- `section.section-band#contact`: contact
- `footer`: brand system note and last-updated date

Navigation targets:

- Work -> `#work`
- Notes -> `#writing`
- Contact -> `#contact`

## Header Rules

The header is a sticky menu bar:

- It uses `position: sticky`.
- It links the brand text back to `/`.
- It groups normal links in `.nav-links`.
- It groups theme/language controls in `.nav-controls`.
- The brand text is `.brand-name` and is wired with `data-i18n="brandName"`.
- The header should not display the SVG favicon/brand mark as a glyph.
- The header background should remain visually aligned with the page background while keeping the bottom border line.
- Header horizontal padding is percentage-based outside narrow mobile: currently `padding: 22px 3%`.
- At very narrow mobile width, header horizontal padding is removed so the menu has enough room.

## Theme System

Theme is controlled by CSS custom properties and one JavaScript toggle.

Current light palette:

- `--bg: #e5edd6`
- `--surface: rgba(249, 255, 239, .82)`
- `--surface-strong: rgba(249, 255, 239, .94)`
- `--text: #122316`
- `--muted: #586a54`
- `--signal: #087f52`

Current dark palette:

- `--bg: #091813`
- `--surface: rgba(12, 30, 22, .78)`
- `--surface-strong: rgba(15, 38, 27, .92)`
- `--text: #f1fff4`
- `--muted: #a2baa6`
- `--signal: #6df0a7`

Default behavior:

- Without `data-theme`, the page follows `prefers-color-scheme`.
- The explicit light theme uses `[data-theme="light"]`.
- The explicit dark theme uses `[data-theme="dark"]`.
- The theme preference is stored in `localStorage` under `theme-preference`.
- The toggle is `.theme-toggle.single-toggle`.
- The orb is `.toggle-orb.theme-orb`.

Be careful with `.media-backdrop::after`: it must use a light overlay by default so system-light users do not inherit a dark overlay.

## Language System

Language switching is implemented in `index.html` with:

- `const translations = { en: { ... }, ko: { ... } }`
- `data-i18n` attributes on visible text nodes
- `setLanguage(lang)`
- `.language-toggle.single-toggle`
- `.language-code`

Current behavior:

- The page loads in English by default.
- Clicking the language toggle switches between English and Korean.
- The toggle text changes to the current language code.
- `document.documentElement.lang` is updated.
- `document.title` is updated from the translation dictionary.

Expected behavior:

- English mode should show English UI text.
- Korean mode should translate all visible UI text, including the header brand, navigation labels, profile caption, work cards, notes, contact section, footer labels, and browser title.
- Korean mode should not leave English UI labels in visible places unless they are intentional technical terms.

If editing Korean text from PowerShell, be aware that terminal output may display UTF-8 Korean as mojibake. Do not trust garbled console output as proof that the file is corrupted. Inspect with a UTF-8-aware editor or use git diff carefully.

## Hero and Profile Layout

The hero must keep the profile first and the headline below it.

Current profile expectations:

- `.profile-panel.hero-profile` appears before `.hero-copy`.
- `.profile-photo` contains the circular portrait.
- `.profile-meta` contains the name and `perception systems` caption.
- `.profile-signals-body` contains the radar and sensor fusion descriptions.
- Desktop profile layout uses named grid areas:
  - `"photo meta"`
  - `"photo signals"`
- Mobile layout should keep the photo and name/caption side-by-side.
- Mobile signal copy should sit below the photo/name row.
- Mobile spacing should leave enough room between the photo, name/caption, and signal text.
- The profile photo and profile signal text should not be wrapped in `.module-card`.

Current visible identity copy in English:

- Profile caption: `perception systems`
- Radar title: `Radar processing`
- Radar body: `I turn raw radar returns into stable detections, tracks, and interpretable motion cues.`
- Fusion title: `Sensor fusion`
- Fusion body: `I align imperfect sensors into one confidence-aware view of the scene.`

The main hero copy is separated from the profile area by `.hero-divider`, which should be a plain one-pixel line using `var(--line)`.

Current hero copy:

- Headline: `Engineering signal from uncertainty.`
- Summary: `I design perception systems that turn radar returns, sensor streams, and noisy environments into decisions that hold up in the real world.`

The hero copy should use the full available module width:

- `.hero-copy` should have `width: 100%`.
- `.hero-copy` should have `max-width: none`.

## Content Modules

The site uses a consistent module language.

Use `.module-card` for repeated Work and Notes items. It should keep:

- `border: 1px solid var(--line)`
- `border-radius: 8px`
- `background: var(--surface)`

Do not use nested cards. Do not box the profile identity/signals area or the contact panel as module cards.

Section headings should stack vertically:

- `.section-head` should use grid layout.
- `.section-title-group` should use a shared grid layout for kicker/title spacing.
- Section intro paragraphs should not have a narrow max-width; they should use the full available content width.

Current Work section:

- Kicker: `Selected work`
- Title: `Systems built around signal, timing, and confidence.`
- Intro: `The work I want this homepage to represent: engineering that respects noisy data, physical constraints, and decisions that need to survive outside a clean demo.`
- Cards:
  - `Signal chain design`
  - `Fusion architecture`
  - `Perception validation`

Current Notes section:

- Kicker: `Notes`
- Title: `Technical notes worth expanding.`
- Intro: `These are placeholders for the kind of writing that should live here: short, technical, and grounded in engineering judgment.`
- Notes:
  - `Tracking under uncertainty`
  - `When sensors disagree`

Current Contact section:

- Kicker: `Contact`
- Title: `Open to technical conversations.`
- Body: `Reach out for radar signal processing, sensor fusion, perception systems, or research-minded engineering conversations.`
- Links:
  - GitHub: `https://github.com/SechanOh`
  - Email: currently `mailto:` and should be filled when the owner provides an address.

## Assets

All directly referenced visual assets live in `figures/`.

`figures/SechanOh_picture.jpg`:

- Used as the profile portrait.
- Displayed in a circular frame.
- Should stay easy to replace.

`figures/brand-mark.svg`:

- Used as the browser tab favicon.
- Should be easy for the owner to replace.
- Must preserve the original aspect ratio.
- The SVG root should include `preserveAspectRatio="xMidYMid meet"`.

When the owner says they updated the SVG or profile photo, inspect the file and preserve the new artwork. Do not overwrite asset changes unless explicitly asked.

## Testing

Run this after every meaningful change:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\test-site.ps1
```

Also run:

```powershell
git diff --check
```

The test script verifies the site's structural contract, including:

- required files exist
- `index.html` references the profile photo, brand mark, favicon, and config file
- browser title is `Sechan Oh Homepage`
- theme and language controls are single toggles
- language switching is wired through `data-i18n`
- Work, Notes, and Contact targets exist
- profile layout rules are preserved across desktop and mobile
- hero/profile divider is a plain separator
- modules share the same card treatment
- sticky header and anchor offsets are preserved
- default theme follows system color scheme
- light/dark backgrounds avoid near-black and near-white extremes
- system-light overlay uses the light palette
- system-dark and explicit dark overlays use the dark palette
- profile photo stays circular, contained, unfiltered, and without gradient overlay
- YouTube background requests autoplay and muted playback
- Korean translation coverage exists
- the brand SVG preserves aspect ratio
- GitHub Issue template and workflow docs exist

If a test fails, prefer updating the implementation to keep the contract. Only update the test when the owner intentionally changes the contract.

## GitHub Issues Workflow

The repository includes a GitHub Issue template for homepage requests:

- `.github/ISSUE_TEMPLATE/homepage-request.yml`
- `.github/ISSUE_TEMPLATE/config.yml`

The workflow document is:

- `docs/github-issues-workflow.md`

Use issues when the owner wants to request changes from mobile or track homepage changes. Each issue should include:

- request type
- requested change
- acceptance criteria
- mobile behavior when relevant

## Deployment and Git Workflow

The deployed branch is `main` on the GitHub Pages repository.

Expected workflow for Codex:

1. Inspect current files and `git status --short`.
2. Make the smallest coherent change.
3. Run `powershell -ExecutionPolicy Bypass -File scripts\test-site.ps1`.
4. Run `git diff --check`.
5. Commit with a concise message.
6. Push to `main`.
7. Report the commit hash and verification result.

The owner previously asked Codex to manage commit and push automatically for this repository. Continue doing that for completed homepage changes unless the owner says not to.

## Design Guardrails for Future Changes

When improving the homepage, keep these design choices intact:

- Favor a premium engineering identity over a generic portfolio.
- Keep the layout dense enough to feel professional, not like a marketing landing page.
- Mobile must be first-class, not an afterthought.
- Avoid huge hero text inside compact modules.
- Avoid decorative gradient blobs, generic SVG illustrations, and one-note palettes.
- Use real assets from `figures/` or replaceable media hooks from `content/site-config.js`.
- Keep the UI modular and consistent.
- Keep text readable on mobile.
- Avoid visible instructional text that explains how to use the site.
- Preserve the sticky menu behavior.
- Preserve the simple single toggles.
- Preserve the clear Work / Notes / Contact information architecture.

## Known Utility Files

`brainstorm-preview.html` is an old design exploration file. It is not the deployed GitHub Pages entry point. Use it only as historical reference.

`.superpowers/` is ignored by git through `.gitignore`.

## Quick Recovery Context

If all prior conversation context is gone, the safest interpretation is:

This is Sechan Oh's static personal homepage for radar signal processing and sensor fusion. The owner cares strongly about mobile layout, polished personal branding, dark/light theme behavior, Korean/English language switching, replaceable media assets, a circular unfiltered profile photo, a sticky top menu, and consistent module design. Any future change should preserve the tested contract in `scripts/test-site.ps1`, update `README.md` if the project contract changes, then commit and push to `main`.
