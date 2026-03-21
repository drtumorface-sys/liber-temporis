# Liber Temporis

**A Christian Kabbalist ritual timing application built as a single-file Progressive Web App.**

Liber Temporis renders the invisible architecture of time legible. It computes planetary hours, lunar positions, Sephirothic resonances, the 72 Names of God, and 360 degree-level Sabians in real time, presenting them as a unified field of correspondences that the practitioner can read at a glance.

The application is a single HTML file (~748KB, ~6,640 lines, 137 functions) containing all computation, data, and rendering. No frameworks. No build step. No external API calls. Everything runs client-side from the astronomical epoch calculations to the gematria engine to the golden spiral notification scheduler to the Living Firmament.

---

## Table of Contents

1. [Design Philosophy](#design-philosophy)
2. [The Living Firmament](#the-living-firmament)
3. [Architecture](#architecture)
4. [The 360 Sabian System](#the-360-sabaton-system)
5. [The Golden Spiral Notification Engine](#the-golden-spiral-notification-engine)
6. [Astronomical Engine](#astronomical-engine)
7. [Data Layers](#data-layers)
8. [Tab System](#tab-system)
9. [The Christian Kabbalistic Lens](#the-christian-kabbalistic-lens)
10. [Gematria Engine](#gematria-engine)
11. [Election & Future Projection System](#election--future-projection-system)
12. [Rendering Architecture](#rendering-architecture)
13. [The Middle Pillar](#the-middle-pillar)
14. [CSS Strategy](#css-strategy)
15. [PWA & Notifications](#pwa--notifications)
16. [Source Authorities](#source-authorities)

---

## Design Philosophy

### Against the Attention Economy

Most applications are designed to maximise engagement — time-on-app, session frequency, notification tap-through rate. The prevailing architecture of consumer software treats human attention as a resource to be extracted.

Liber Temporis is designed on a different principle. The sky does not compete for your attention. It does not send push notifications when Mercury enters a new Decan. It does not gamify your planetary hour tracking streak. It simply *is*, and you look up when you are moved to look up.

The application's notification system is built on the golden angle (137.5°) rather than fixed intervals, ensuring that observations are distributed across the day in a pattern that never repeats and never crowds — the same geometry that sunflower seeds use to fill a disc without waste. The application speaks when the sky has something to say, and stays silent when it doesn't. This is not a design concession. It is the central architectural decision.

### The Ontology of Light

Information in this system is not stored — it is *emitted*. Every data node possesses a temperature, a luminosity, and a distance from the observer. This is the philosophical core of the Living Firmament: the interface itself is governed by the same celestial mechanics that the data describes. The app does not merely *tell* you it is the Saturn hour. The firmament behind every card deepens to indigo, the gold accent cools to amber, and the beings aligned with Saturn burn against the darkness with complementary halos. The practitioner does not read the celestial weather — they inhabit it.

### Single-File Discipline

The entire application ships as one HTML file. This is not laziness but a deliberate constraint:

- **No build step** means the application can be understood by reading it.
- **No dependencies** means the application will still work in twenty years.
- **No network** means the application works in airplane mode, in a forest, in a church.
- **No server** means there is no data collection, no analytics, no telemetry.

### Symbolic Coherence

Every technical decision mirrors a symbolic principle from the traditions it serves:

- The **10 Sephiroth** structure the data model.
- The **22 Hebrew letters** structure the correspondence engine.
- The **4 Worlds** (Atziluth, Briah, Yetzirah, Assiah) structure the depth layers.
- The **360 degrees** of the zodiac structure the Sabian oracle system.
- The **137.5° golden angle** structures the notification timing.
- The **7 planetary signatures** structure the Living Firmament.

---

## The Living Firmament

### The Spectral Taxonomy

The Firmament is an opt-in atmospheric system (Settings → Appearance → Living Firmament) that transforms the app's visual ground from a static dark void into a breathing sky governed by real-time celestial state. Seven distinct planetary signatures drive it:

| Planet | Signature RGB | Character | Traditional Quality |
|--------|--------------|-----------|-------------------|
| Saturn | `(80,60,160)` | Deep indigo-violet | Cold-dry, contracted |
| Moon | `(140,165,210)` | Silver-blue | Cold-moist, reflective |
| Mercury | `(80,180,170)` | Teal-green | Quicksilver, mutable |
| Sun | `(220,175,60)` | Warm gold | Solar baseline |
| Venus | `(200,110,130)` | Rose-copper | Warm-moist, beautiful |
| Mars | `(200,50,50)` | Deep crimson | Hot-dry, fierce |
| Jupiter | `(70,100,200)` | Royal blue | Hot-moist, expansive |

These are not Planckian blackbody colours (which produce a narrow near-white band for all temperatures above 3000K). They are hand-tuned chromatic identities rooted in the tradition's own correspondence tables.

### The Three Modifiers

The base planetary colour is shifted by three astronomical factors computed in real time:

1. **Elemental Tint** — The Moon's sign element pushes the hue: Fire warms (+30R, -15B), Water deepens blue (-10R, +25B), Air cools (-10R, +15B), Earth browns (+10R, -8B).

2. **Lunar Phase** — New Moon desaturates (pulls toward grey). Full Moon saturates (pushes channels apart from the mean). Linear interpolation by illumination percentage.

3. **Diurnal Position** — Night multiplies the colour down (×0.70), deepening it. Noon multiplies up (×1.15), opening it. Sinusoidal curve from sunrise through noon to sunset.

### Parallax Depth Field

Four CSS layers replace the flat starfield:

| Layer | Parallax | Role |
|-------|----------|------|
| `firm-L0` | 0.00 | Fixed stars — does not scroll |
| `firm-L1` | 0.02–0.06 | Deep field — barely shifts |
| `firm-L2` | 0.08–0.18 | Middle field — moderate drift |
| `firm-L3` | 0.25–0.55 | Near dust — tracks scroll closely |

The coefficients are not static. `updateFirmament()` rescales them based on celestial temperature: hot hours spread the layers apart (open, vast), cold hours compress them (dense, intimate). Stars are placed by a seeded PRNG for deterministic, non-flickering positions. Star colour, count, and brightness shift with the planetary signature.

### Gilding

The gold accent (`--gold`) shifts 15% toward the planetary signature colour. During a Saturn hour, gold becomes warmer amber. During a Jupiter hour, it cools toward silver-gold. Every title, active pill, and navigation highlight responds.

### Complementary Haloing

`complementaryHex()` rotates any colour 180° on the HSL wheel. `firmGild()` uses this to produce the complement of the current celestial colour, then applies it as a `box-shadow` glow to active and aligned beings (Goetia, Olympic Spirits, Planetary Angels, Angelic Orders). The result: during a warm Saturn hour, aligned beings burn with a cool blue corona. During a cool Jupiter hour, they glow with warm amber. The hotter the alignment score, the brighter the halo.

### Adaptive Readability

The dim text colour (`#606078`) — used for ~390 inline occurrences of secondary text — already failed WCAG 4.5:1 contrast on the base dark background. The Firmament's tinted backgrounds made this worse. Two systems fix it:

**Option A — Adaptive Brightness.** `applyFirmamentTint()` computes the actual WCAG luminance of the tinted background using sRGB linearization, solves for the minimum foreground luminance that achieves 4.5:1, and boosts the dim colour by `sqrt(minFgLum/dimLum)`. Every firmament state passes WCAG AA.

**Option D — Planckian Tint.** After the brightness boost, the dim colour shifts 12% toward the planetary signature. Warm sky, warm dim text. Cool sky, cool dim text. Hue-consistent surfaces improve perceived legibility beyond what raw contrast numbers show.

A CSS attribute selector `body.firmament-on [style*="color:#606078"]` catches all 390 inline references with `!important`, ensuring coverage without touching render functions.

### Interstellar Extinction (Reddening)

The `reddeningFilter(hoursAge)` function applies CSS `sepia()`, `hue-rotate()`, and `brightness()` to compendium entries based on time since last observation:

```
E(B-V) = 0.003 × hours_since_observed
A_v = 3.1 × E(B-V)
```

A word calculated 12 hours ago has barely perceptible warmth. A week ago: visible amber tint. A month: deep red-orange and dim. Nothing goes below 35% opacity. Data doesn't disappear — it dims and reddens, simulating interstellar dust accumulation over time.

---

## Architecture

### File Structure

```
index.html       # The entire application (~748KB)
manifest.json    # PWA manifest (standalone, portrait, dark)
sw.js            # Service worker v5.5.2 (caching + notifications)
icon-192.png     # App icon 192×192
icon-512.png     # App icon 512×512
.nojekyll        # GitHub Pages config
README.md        # This document
```

### Internal Structure

```
<head>
  Meta tags, PWA configuration, Google Fonts preconnect
  <style> — All CSS (~4KB), 38+ utility classes, firmament overrides
</head>
<body>
  #stars          — Classic animated starfield (visible when firmament OFF)
  #firmament      — 4-layer parallax starfield (visible when firmament ON)
    #firm-L0..L3  — Depth layers with independent scroll rates
  #firm-tint      — Atmospheric radial gradient overlay (mix-blend-mode: screen)
  #app            — Main application container
  Overlay containers (Four Worlds, Settings, Bible, Search, Projection)
  <nav>           — Fixed bottom navigation bar

  <script>
    §1  ENGINE              — Astronomical calculations
    §2  PLANETARY DATA      — 7 planets with full correspondence tables
    §3  SPIRIT DATA         — 72 Goetia, 7 Olympic, 4 Elemental, 4 Kings
    §4  ANGELIC DATA        — 9 Orders, 7 Planetary Angels
    §5  ELECTIONS           — 8 working categories with full ritual guides
    §6  GEMATRIA DATA       — Hebrew/Latin/Greek value tables, 100+ notable terms
    §7  SCRIPTURE NUMS      — 37 sacred number references (Bible/Torah)
    §8  GEMATRIA COMPENDIUM — localStorage-persisted cross-reference system
    §9  CHRISTIAN KABBALAH  — Trinity, Pentagrammaton, 10 deep Sephirah essays
    §10 SABATON ENGINE      — 360° oracle with Phase Houses
    §11 72 NAMES (SHEM)     — Boustrophedon from Exodus 14:19–21
    §12 LETTERS             — 22 Hebrew letters
    §13 SEPHIROTH           — Full 10-Sephirah data with Four Worlds
    §14 BEHENIAN STARS      — 15 fixed stars with precessed longitudes
    §15 ZODIAC DEEP         — 12 signs as living letters
    §16 CONFIG & STATE      — CFG (persisted), S (session), render loop
    §17 GOLDEN SPIRAL       — 137.5° notification engine
    §18 FIRMAMENT ENGINE    — Planetary signatures, parallax, tinting, gilding,
                              complementary halos, adaptive readability, reddening
    §19 NOTIFICATION SYS    — PWA-safe showNotif(), SW showNotification
    §20 SETTINGS UI         — renderSettings() with firmament controls
    §21 RENDER FUNCTIONS    — 13 tab renderers + correspondence web + gem modes
    §22 INIT SEQUENCE       — Stars, render, tick, scroll listener, SW register
  </script>
</body>
```

### State Management

**`CFG`** — Persisted to `localStorage` as `ltcfg`:
```
lat, southern, tf24, fontSize, accent, reducedMotion, firmament,
hideTabs, electThreshold, notifyHour, notifyVOC, notifyGolden,
defaultTab, savedWorking
```

**`S`** — Session state, reset on reload:
```
tab, detail, detailType, filter, planetF, mansion,
gemInput, gemSys, gemMode, gemHist, gemInputB, gemNotarIn,
shemView, shemTriad, fwOpen, fwSeph, settingsOpen,
studySub, studyLetter, studySeph, studyColSeph,
treeNode, treePath, treeEin,
christianLens, ckabSection, bibleOpen, searchOpen,
projOpen, firmProjectH, ...
```

Single `render()` function rebuilds `#app` innerHTML from `S`. No virtual DOM. No diffing. The render function is the single source of truth.

---

## The Middle Pillar

The Middle Pillar (Kether → Da'ath → Tiphareth → Yesod → Malkuth) is the axis of the Tree of Life and the path of ascent. In the application, it receives distinct visual treatment:

**Tree SVG** — An SVG filter (`ainGlow`) applies Gaussian blur for golden radiance. The three Ain veils (Ain, Ain Soph, Ain Soph Aur) are gold-tinted rather than white, with Ain Soph Aur — the Limitless Light — brightest. The EQUILIBRIUM pillar label renders in full gold with the glow filter. The pillar line runs gold at 1.5px width. Middle Pillar Sephiroth (1, 6, 9, 10) receive an outer glow ring even when not selected. Da'ath's stroke and fill are golden, with its own glow ring.

**10 Numbers List** — Middle Pillar rows have a 2px golden left border. The "Equilibrium" pillar label renders in muted gold while "Mercy" and "Severity" remain grey.

**All Sephirothic Orbs** — 9 orbs across the app (44×44px in lists, 80×80px in detail views) use `radial-gradient` fill and `box-shadow` glow in their canonical colour. Every Sephirah is an emanation — it emits light.

---

## Gematria Engine

Six modes spanning three scripts (Hebrew Mispar Gadol, Latin Agrippa, Greek Isopsephy):

| Mode | Function |
|------|----------|
| **Calculate** | Compute gematria value with letter breakdown, equivalences, Sephirothic resonance |
| **Reverse Lookup** | Find all sacred terms sharing a value, with scripture references and compendium cross-refs |
| **ATBaSh** | Hebrew substitution cipher (א↔ת, ב↔ש) with comparative analysis |
| **AIQ Beker** | 9-chamber Pythagorean reduction with interactive tappable grid, silver-lining sums |
| **Compare** | Two-word offset calculator with field-targeting keyboard, letter breakdowns, sum/offset |
| **Notariqon** | First/last letter extraction and expansion, 8 famous examples |

Each mode has a Hebrew/Greek/Latin system selector, script keyboard with transliteration, and flicker-free partial DOM updates via targeted `innerHTML` swaps (Layer 1a–1d in `_scheduleGemRender`).

The **Gematria Compendium** persists to `localStorage` (`lt_gem_compendium`), auto-saving every calculated word with value, script, timestamp, and hit count. Entries redden over time when the Firmament is active.

---

## PWA & Notifications

### Android PWA Notifications

All notification paths use `showNotif(body, silent)`, which:
1. Checks for an active Service Worker controller
2. If present: uses `navigator.serviceWorker.ready.then(reg => reg.showNotification(...))` — the **only** method that works in Android standalone PWA mode
3. Falls back to `new Notification()` for desktop browsers

The service worker handles `notificationclick` (focus/open the app), `push` (future server-sent), and `periodicsync` (background ticking).

### Deployment

Push all files to a GitHub repo. Enable Pages in Settings → Deploy from branch → main → / (root).

```bash
# The app will be live at:
https://yourusername.github.io/reponame/
```

---

## Source Authorities

- **Agrippa**, *De Occulta Philosophia* (1531) — planetary correspondences, Decan faces, fixed stars
- **Picatrix** (*Ghāyat al-Ḥakīm*, ~1000 CE) — Decan imagery, Mansion operations
- **Sefer Yetzirah** (~200–600 CE) — 22 letter paths, Mother/Double/Simple
- **Zohar** (~1280 CE) — Sephirothic structure, Four Worlds
- **Key of Solomon** (~14th–15th c.) — planetary hour system
- **Lemegeton Clavicula Salomonis** (~17th c.) — 72 Goetia
- **Arbatel of Magic** (1575) — 7 Olympic Spirits
- **Reuchlin**, *De Verbo Mirifico* (1494) — Pentagrammaton (YHShVH)
- **Pseudo-Dionysius**, *Celestial Hierarchy* (~5th c.) — 9 Angelic Orders
- **Teresa of Ávila**, *Interior Castle* (1577) — Seven Mansions
- **John of the Cross**, *Ascent of Mount Carmel* (~1578) — Dark night, Middle Pillar
- **Athanasius Kircher**, *Oedipus Aegyptiacus* (1652) — Christian Kabbalistic synthesis

---

## The 137.5° Audit

The codebase is validated by a golden-spiral audit: 55 checks distributed across 13 spirals at 137.5° intervals, covering syntax, firmament engine, parallax layers, atmospheric tint, complementary gilding, reddening, Sephirothic radiance, Middle Pillar, gematria systems, PWA infrastructure, Liber Lucis header, navigation, and dead code elimination. Current status: **55/55**.

```
137 functions. 748KB. 6,637 lines. Zero dependencies. Zero dead code.
```

---

*Liber Temporis v5.5.2 — The Book of Time*

*The sky does not compete for your attention. It simply is, and you look up when you are moved to look up.*
