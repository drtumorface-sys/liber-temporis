# Liber Temporis v6

> *The Third Temple — Syncretic Semiotics Grimoire*

**ΩTemple = Σᵢ₌₁¹⁰ (Vᵢ ⊗ Lᵢ)**

A single-file Progressive Web App fusing the Hebrew metaphysical scaffold (Sephirotic Vessels) with the kinetic descent of the Christian Logos. Operates strictly within Syncretic Semiotics — neither tradition overwrites the other; they form an orthogonal matrix. Runs fully offline. Installs as a native app on any device.

---


```
https://syncreticsemiotics.github.io/liber-temporis/
```

Deploys within 60–120 seconds. Subsequent pushes deploy automatically.

---

## Install as a PWA

| Platform | Method |
|---|---|
| **Android / Chrome** | Browser menu → *Add to Home Screen*, or accept the install banner |
| **iOS / Safari** | **Share** → *Add to Home Screen* |
| **Desktop / Chrome · Edge** | Install icon (⊕) in the address bar |

After installation the app runs fully offline. All calculations — planetary hours, gematria, acoustic synthesis — execute locally with no network dependency after first load.

---

## What It Does

Liber Temporis is an operative grimoire and timing apparatus synchronized to astronomical time in real-time.

### Operative Tabs

| Tab | Function |
|---|---|
| **◉ Now** | Active planetary hour, lunar sign, Shem angel, operative recommendation, Sabian symbols, fixed stars |
| **✦ Matrix** | Syncretic Celestial Matrix — full ecliptic convergence: solar Shem (λ☉/5°), lunar mansion (λ☽), planetary hour, phase house, Sabian diptych, active intelligences, ECAT affinities |
| **⏣ Timing** | Complete 24-hour Chaldean planetary hour sequence, canonical hours, election windows |
| **☽ Moon** | Lunar phase, sign, mansion, VOC status, Behenian fixed stars, monthly projection |
| **⛧ Beings** | Goetic 72, Olympic Spirits, Angelic orders — scored against current hour and sign |
| **✡ 72 Names** | Shem HaMephorash — all 72 angels, psalms, domains, Sephirotic triad groupings |
| **⊕ Elect** | Electional astrology — 8 operative categories scored against planetary hour × lunar phase × VOC |
| **א Gematria** | Hebrew · Greek · Latin gematria, resonance lookup, cipher watermark, compendium |
| **◎ Study** | Sefer Yetzirah letters, Sephiroth, Qliphoth, Four Worlds, Liturgical calendar |
| **✦ Tree** | Interactive Tree of Life — 10 Sephiroth, 22 paths, Da'ath, pillar labels |
| **◈ Ref** | Planetary correspondences, theology, grimoire lexicon, ✝ CKab |

### The ✞ Liber Crucis Lens

Toggle **✞ Liber Crucis** in the header to activate the Christian Kabbalistic lens. Every tab transforms: Sephiroth reveal Trinitarian identities, the Tree becomes the Body of Christ, tabs adopt liturgical nomenclature, the Celestial Matrix surfaces sacramental correspondences. Toggle **☉ Liber Lucis** to return to the classical Hermetic mode.

### Acoustic Engine

The **Gematria → Freq** sub-tab generates a Fibonacci-structured binaural acoustic matrix. A computed gematric sum (Σg) drives the entrainment bandwidth (Δf = 4 + (Σg mod 8)), which splits into left-channel mercy frequency (fL = f₀ − Δf/2) and right-channel severity frequency (fR = f₀ + Δf/2). A 104-step Fibonacci polyrhythm cycle (lcm(13,8)) governs pulse timing across 13 mercy and 8 severity nodes. All synthesis runs on the Web Audio API — no external dependencies.

---

## Technical Architecture

### Single-File PWA

The entire application — 10,842 lines, ~1MB — is a self-contained `index.html`. No build step, no bundler, no npm. Fonts are the only external resource; they are cached by the Service Worker after first load and served offline thereafter.

### Rendering Engine

- **State machine**: All UI driven by a single `S` state object. `render()` batches concurrent calls into one RAF frame. `_doRender()` performs a synchronous HTML string build and a single `app.innerHTML` write per cycle — no virtual DOM, no diffing.
- **Master oscillator**: `_ltMasterTick()` — a single `requestAnimationFrame` loop driving 1-second countdown, 30-second auto-refresh, Fibonacci polyrhythm, and parallax via accumulator sub-clocks.
- **Perceptual gate**: RAF self-terminates when `document.hidden` (tab backgrounded). Resyncs on visibility restore. `AudioContext` suspends and resumes with it — zero battery spend when unobserved.
- **Spatial culling**: `IntersectionObserver` on `#nem-freq-panel` halts the Fibonacci encoder when the waveform is off-screen.
- **Battery API**: `navigator.getBattery()` auto-enables Endurance Mode at ≤20% charge, removing all `backdrop-filter`, noise, and the starfield — flat opaque panels only.

### Boot Sequence

```
① Inline <style> paints obsidian firmament gradient — zero white flash
② Synchronous <link rel="stylesheet"> registers @font-face in CSSOM
③ JS executes: FS constants → CFG defaults → loadCFG() → S state → render()
④ document.fonts.ready resolves — Cinzel + EB Garamond confirmed cached
⑤ Double-RAF: opacity 0 → 1 over 0.38s — stele materialises from the void
```

### Celestial Calculations (all local, no API)

| System | Method |
|---|---|
| Planetary hours | Unequal-hour (Chaldean sequence from sunrise/sunset) |
| Solar longitude | Simplified VSOP — accurate to ~1° |
| Lunar longitude | Synodic cycle + perturbation term — accurate to ~1° |
| Shem HaMephorash | `⌊λ☉ / 5°⌋ mod 72` → angel index |
| Lunar Mansions | 28 stations × 12.857° — binary search on `s` field |
| Sabian Symbols | 360-entry array indexed by `⌊λ⌋` |
| Behenian Stars | 15 fixed stars, orb filtering via great-circle distance |
| VOC Moon | Last-aspect detection within current sign |
| Phase House | Sun–Moon separation / 30° → 12 houses |

### Shem HaMephorash Coverage

All 72 angels assigned to the 7 classical planets — zero gaps, zero duplicates:

| Planet | Angels | Includes |
|---|---|---|
| Sun | 10 | Vehuiah (1), … |
| Moon | 10 | … Mumiah (72) — terminal completion |
| Mars | 11 | … Haiaiel (71) — divine armor |
| Mercury | 10 | … |
| Jupiter | 11 | Jeliel (2), … — sovereign authority |
| Venus | 10 | … |
| Saturn | 10 | … |

### Lithic Glassmorphism

```css
/* Card substrate */
background: rgba(11,11,22,0.52);
backdrop-filter: blur(18px) saturate(1.55) brightness(1.04);

/* Noise texture (::after) */
background-image: url("data:image/svg+xml,<feTurbulence...>");
mix-blend-mode: overlay;
opacity: 0.04;

/* Stele geometry */
max-width: min(100vw, 56.25vh);           /* 9:16 on desktop */
max-width: min(92vw, calc(100dvh * 1.618)); /* Φ on large displays */
```

---

## File Manifest

| File | Purpose |
|---|---|
| `index.html` | Complete self-contained application (~1MB) |
| `manifest.json` | PWA manifest — name, icons, shortcuts, categories |
| `sw.js` | Service Worker — cache-first, update detection, SKIP_WAITING |
| `icon-512.png` | App icon 512×512 — splash screens, maskable |
| `icon-192.png` | App icon 192×192 — home screen |
| `icon-180.png` | Apple Touch Icon |
| `icon-32.png` | Favicon 32×32 |
| `icon-16.png` | Favicon 16×16 |
| `icon-*.svg` | Vector icon sources (Ω sigil, obsidian/gold palette) |
| `.nojekyll` | Disables Jekyll processing on GitHub Pages |
| `_config.yml` | GitHub Pages static file configuration |

---

## Source Authorities

Agrippa, *De Occulta Philosophia* (1531) · Picatrix, *Ghāyat al-Ḥakīm* (c. 1000 CE) · Sefer Yetzirah · Zohar · Key of Solomon · Arbatel of Magic · Lemegeton Clavicula Salomonis · Pseudo-Dionysius, *Celestial Hierarchy* · Sabian Symbols (Jones, 1925) · Pico della Mirandola, *Conclusiones* · Johannes Reuchlin, *De Arte Cabalistica*

---

*© SyncreticSemiotics. All rights reserved.*
