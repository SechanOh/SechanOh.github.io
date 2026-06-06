# SechanOh.github.io

Personal GitHub Pages homepage for Sechan Oh:

https://sechanoh.github.io/

This README is the short project map and editable page spec. If this README changes, Codex should treat the changed values as the desired homepage state and sync `index.html`, `content/site-config.js`, and assets as needed.

## Files

```text
.
|-- index.html                    # Actual GitHub Pages homepage
|-- content/site-config.js         # Easy-to-edit asset/media/date config
|-- figures/brand-mark.svg         # Favicon / brand mark
|-- figures/SechanOh_picture.jpg   # Profile photo
|-- scripts/test-site.ps1          # Site contract checks
|-- docs/github-issues-workflow.md # Mobile / GitHub Issues request notes
|-- brainstorm-preview.html        # Old design reference, not deployed
`-- README.md                      # This project map and page spec
```

## Page Structure

```text
Header
|-- Brand link: Sechan Oh
|-- Nav: Work / Notes / Contact
|-- Controls: theme toggle, language toggle

Hero
|-- Profile photo
|-- Name and profile caption
|-- Radar processing text
|-- Sensor fusion text
|-- Divider line
|-- Headline, summary, CTA buttons

Main content
|-- Work cards
|-- Notes cards
|-- Contact block

Footer
|-- Brand-system note
`-- Last updated date
```

## Page Spec

Edit this section when the visible homepage content should change. Codex should sync these values into the site.

| Area | Current value |
| --- | --- |
| Site URL | `https://sechanoh.github.io/` |
| Browser title | `Sechan Oh Homepage` |
| Browser description | `Sechan Oh - Radar Signal Processing and Sensor Fusion Engineer.` |
| Header brand | `Sechan Oh` |
| Header nav | `Work`, `Notes`, `Contact` |
| Profile image | `figures/SechanOh_picture.jpg` |
| Favicon / brand mark | `figures/brand-mark.svg` |
| Profile caption | `perception systems` |
| Radar title | `Radar processing` |
| Radar copy | `I turn raw radar returns into stable detections, tracks, and interpretable motion cues.` |
| Sensor fusion title | `Sensor fusion` |
| Sensor fusion copy | `I align imperfect sensors into one confidence-aware view of the scene.` |
| Hero headline | `Engineering signal from uncertainty.` |
| Hero summary | `I design perception systems that turn radar returns, sensor streams, and noisy environments into decisions that hold up in the real world.` |
| Work title | `Systems built around signal, timing, and confidence.` |
| Work intro | `The work I want this homepage to represent: engineering that respects noisy data, physical constraints, and decisions that need to survive outside a clean demo.` |
| Work card 1 | `Signal chain design` |
| Work card 2 | `Fusion architecture` |
| Work card 3 | `Perception validation` |
| Notes title | `Technical notes worth expanding.` |
| Notes intro | `These are placeholders for the kind of writing that should live here: short, technical, and grounded in engineering judgment.` |
| Note 1 | `Tracking under uncertainty` |
| Note 2 | `When sensors disagree` |
| Contact title | `Open to technical conversations.` |
| Contact copy | `Reach out for radar signal processing, sensor fusion, perception systems, or research-minded engineering conversations.` |
| GitHub link | `https://github.com/SechanOh` |
| Email link | `mailto:` |
| YouTube background video | `REPLACE_WITH_YOUTUBE_ID` |
| Last updated label | `May 29, 2026` |
| Last updated date | `2026-05-29` |

## Design Rules

- Static site only. No build step, framework, package manager, or server requirement.
- Default theme follows the system setting.
- Header stays sticky while scrolling.
- Theme control is one dark/light toggle.
- Language control is one EN/KO toggle showing only the current language code.
- Profile photo stays circular, unfiltered, and without gradient overlay.
- Work and Notes use consistent module cards.
- Profile and Contact are not boxed as module cards.
- Mobile layout must stay comfortable, readable, and menu-like.
- Background colors should avoid pure black and pure white.
- YouTube background, when configured, must autoplay muted.

## Editing Map

Use this map when syncing README changes into the site.

| Change in README | Update this file |
| --- | --- |
| Text, layout, sections, theme, language | `index.html` |
| Profile image path, brand mark path, YouTube ID, update date | `content/site-config.js` |
| Profile photo image | `figures/SechanOh_picture.jpg` |
| Favicon / brand mark artwork | `figures/brand-mark.svg` |
| Project structure or rules | `README.md` |
| Site contract changes | `scripts/test-site.ps1` |

## Codex Sync Checklist

When the owner edits README or asks for a homepage change:

1. Read `README.md` first.
2. Compare the `Page Spec` against `index.html` and `content/site-config.js`.
3. Update the site to match the README.
4. Keep changes small and consistent with the design rules.
5. Run:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\test-site.ps1
git diff --check
```

6. Commit and push to `main` unless the owner says not to.

## Current Identity

This homepage represents Sechan Oh as a radar signal processing and sensor fusion engineer. The visual direction should feel technical, atmospheric, polished, and personal-brand focused.
