# Liber Temporis — Fourth Book Grimoire

A single-file Christian Kabbalist ritual timing application. Runs entirely in the browser with no backend, no tracking, no external dependencies beyond Google Fonts.

## Features

- **Planetary Hours** — traditional unequal-hour calculation for any latitude
- **Moon** — phase, sign, mansion (all 28), Gabriel card, Void of Course indicator, element teaching, lunar archangel
- **72 Names of God** — full Shemhamphorasch with Psalm citations, extended data (decans, Qliphoth, soul faculties, divine name zones), live accessibility scoring
- **Beings Catalogue** — Goetia (72), Olympic Spirits (7), Planetary Angels, Angelic Orders (9, ascending ladder), Elemental Spirits, Cardinal Kings; live active/aligned badges; planetary hierarchy view; Goetic↔Olympic linking
- **Election Finder** — 8 working types, 7-day optimal window search, invocation guidance, active Shem angel per window
- **Correspondence Web** — live Now tab pattern recognition across planetary, lunar, and angelic channels
- **Four Worlds Lens** — Kabbalistic ontological analysis for any Sephirah
- **Gematria** — Hebrew Mispar Gadol (with finals), Latin (Agrippa), Greek Isopsephy, equivalence database
- **Study** — 22 Hebrew letters (Sefer Yetzirah), 10 Sephiroth, Colour Scales of the Four Worlds
- **Settings** — persistent location, accent colour, font size, tab visibility, 12/24h time, notifications

## Traditions & Source Texts

- Agrippa, *De Occulta Philosophia* (Three Books of Occult Philosophy)
- Picatrix (*Ghāyat al-Ḥakīm*, The Goal of the Wise)
- *Sefer Yetzirah* (Book of Formation)
- *Zohar* (Book of Splendour)
- *Key of Solomon* (Clavicula Salomonis)
- *Arbatel of Magic*
- *Lemegeton Clavicula Salomonis* (Lesser Key of Solomon)

## Installation

### As a web app (PWA)
1. Serve the directory from any static host (GitHub Pages, Netlify, etc.)
2. Open in mobile browser → "Add to Home Screen"
3. Runs offline after first load

### Local use
```bash
# Any static server works:
python3 -m http.server 8080
# then open http://localhost:8080
```

Or simply open `index.html` directly in a browser. Most features work without a server; notifications and service worker require HTTPS or localhost.

### GitHub Pages
1. Fork or upload this repository
2. Go to Settings → Pages → Source: main branch / root
3. App available at `https://[username].github.io/[repo-name]`

## Icon Files

Two icon files are referenced in the manifest and used for PWA install and notifications:
- `icon-192.png` — 192×192 PNG
- `icon-512.png` — 512×512 PNG

Add your own icons or generate from any 512×512 image using [realfavicongenerator.net](https://realfavicongenerator.net).

## Architecture

Single-file vanilla JavaScript (`index.html`). No build process, no npm, no frameworks. All astronomical calculations run client-side using traditional methods:

- Planetary hours: unequal hours (seasonal hours) from sunrise/sunset, latitude-dependent
- Lunar position: low-precision ecliptic calculation (~±1°) adequate for sign and mansion
- Moon phase: synodic cycle from known New Moon epoch

## Version

`v2.6` — Settings & UI system  
Previous: v2.5.1 (Elect rebuild + 72 Names live scoring), v2.5 (Moon + Beings expansion), v2.4 (Study tab), v2.3 (Correspondence Web + Four Worlds), v2.2 (Shem72 extended data), v2.1 (bidirectional navigation), v2.0 (Gematria + Shem72)

## License

For personal and devotional use. Source texts are in the public domain. Application code may be freely adapted for non-commercial use with attribution.
