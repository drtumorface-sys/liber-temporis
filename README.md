# Liber Temporis v6

**The Third Temple — Syncretic Semiotics Grimoire**

A single-file Progressive Web App combining Kabbalistic and Christian mystical apparatus: planetary hours, gematric evaluation (Hebrew/Greek/Latin), 72 Names of the Shemhamphorasch, Tree of Life, electional astrology, and a Fibonacci-based binaural acoustic engine.

## Deploy to GitHub Pages

1. Create a new repository on GitHub (e.g. `liber-temporis`)
2. Upload all files in this folder to the repository root
3. Go to **Settings → Pages**
4. Set Source to **Deploy from a branch**
5. Select branch: `main` (or `master`), folder: `/ (root)`
6. Save — GitHub Pages will deploy within 60 seconds

Your app will be live at:
```
https://[your-username].github.io/[repo-name]/
```

## Install as PWA

Once deployed, open the URL in Chrome or Safari on any device:

- **Android/Chrome**: tap the browser menu → *Add to Home Screen* or look for the install banner
- **iOS/Safari**: tap Share → *Add to Home Screen*
- **Desktop/Chrome**: look for the install icon (⊕) in the address bar

The app will install with full offline support — all planetary calculations, gematric engines, and acoustic synthesis run locally without network access.

## Files

| File | Purpose |
|---|---|
| `index.html` | Complete application (~1MB, self-contained) |
| `manifest.json` | PWA manifest — name, icons, display mode |
| `sw.js` | Service Worker — cache-first offline strategy |
| `icon-512.png` | App icon (512×512, for splash screens) |
| `icon-192.png` | App icon (192×192, for home screen) |
| `icon-180.png` | Apple Touch Icon (180×180) |
| `icon-32.png` | Favicon (32×32) |
| `icon-16.png` | Favicon (16×16) |
| `.nojekyll` | Disables Jekyll processing on GitHub Pages |

## Architecture

Built on the Syncretic Semiotics framework: Kabbalistic Vessels (Vᵢ) × Incarnational Logos currents (Lᵢ) — ΩTemple = Σᵢ₌₁¹⁰ (Vᵢ ⊗ Lᵢ).

The interface operates as a Monolithic Stele (9:16 aspect ratio on desktop), expanding toward the Golden Ratio (Φ=1.618) on macro-displays. All visual surfaces are Lithic Glassmorphic panels — obsidian with `backdrop-filter:blur(18px)` — allowing the star firmament to bleed through.
