# Liber Temporis

**A Christian Kabbalist ritual timing application built as a single-file Progressive Web App.**

Liber Temporis renders the invisible architecture of time legible. It computes planetary hours, lunar positions, Sephirothic resonances, the 72 Names of God, and 360 degree-level Sabatons in real time, presenting them as a unified field of correspondences that the practitioner can read at a glance.

## Install

**Android / Chrome:** Visit the site → tap the browser menu → "Add to Home Screen" or "Install app"

**iOS / Safari:** Visit the site → tap Share → "Add to Home Screen"

The app works fully offline after first load. All computation runs on-device.

## Features

- **Planetary Hours** — Traditional unequal-hour method computed from solar declination
- **360° Sabaton System** — Degree-level oracle compositing Decan, Mansion, Shem angel, letter path, and Sephirothic resonance
- **Golden Spiral Notifications** — Observations spaced by 137.5° (the golden angle), never repeating, never crowding
- **72 Names of God** — Boustrophedon derivation from Exodus 14:19–21 with full Psalm and ritual correspondences
- **Gematria Engine** — Hebrew (Mispar Gadol), Latin (Agrippa), Greek (Isopsephy) with ATBaSh, AIQ Beker, Notariqon, Compare, and Reverse Lookup
- **Christian Kabbalistic Lens** — Toggle transforms every tab: Sephiroth reveal Trinitarian identities, the Tree becomes the Body of Christ, planetary hours map to Gifts of the Spirit
- **Interactive Tree of Life** — SVG Tree with tappable Sephiroth, paths, Da'ath, Ein Sof veils
- **Election Finder** — Scored ritual timing windows across 8 working categories
- **Beings Database** — 72 Goetia, 7 Olympic Spirits, 4 Elemental Spirits, 9 Angelic Orders, 7 Planetary Angels

## Architecture

One HTML file (~720KB). No frameworks. No build step. No external API calls. No server. No telemetry. Everything runs client-side.

## Notifications (Android PWA)

The notification system uses `ServiceWorkerRegistration.showNotification()` for proper Android PWA support. Three notification types:

- **Planetary Hour Change** — Alert when the hour ruler shifts
- **Void of Course Moon** — Alert when the Moon enters void state  
- **Golden Spiral** — Contemplative observations at golden-angle intervals from sunrise

Enable in Settings → Notifications. The app must be installed as a PWA and notification permission must be granted.

## Hosting

Deploy the contents of this repository to any static hosting:

```bash
# GitHub Pages — push to main branch, enable Pages in Settings
# Or any static server:
npx serve .
```

## Files

```
index.html      — The entire application
manifest.json   — PWA manifest
sw.js           — Service worker (offline caching + notification click handling)
icon-192.png    — App icon 192×192
icon-512.png    — App icon 512×512
.nojekyll       — GitHub Pages config (no Jekyll processing)
README.md       — This file
```

## Source Authorities

Agrippa, Picatrix, Sefer Yetzirah, Zohar, Key of Solomon, Lemegeton, Arbatel, Reuchlin, Pseudo-Dionysius, Teresa of Ávila, John of the Cross, Athanasius Kircher.

---

*The sky does not compete for your attention. It simply is, and you look up when you are moved to look up.*
