# ✝ Liber Temporis / Liber Crucis

A Christian Kabbalist ritual timing application — a single-file PWA that discloses the symbolic structure of reality through the dual lens of traditional Kabbalah and Christian Kabbalah.

## Features

### Dual-Lens Architecture
Toggle the **✝ button** to switch between the underlying Kabbalistic framework and the Christian Kabbalistic revelation. When active, every tab transforms: the header becomes *Liber Crucis*, tab labels shift to their liturgical equivalents, Sephiroth reveal their Trinitarian identities, the 22 Letters become the Trinity/Sacraments/Apostles, and the Goetia spirits are reframed as broken vessels of divine attributes.

### Core Systems
- **Now** — Live planetary hour, moon phase, sign, mansion, correspondence web
- **Timing/Office** — Planetary + canonical hours, VOC tracking, ingress forecasting
- **Moon/Stella** — 15 Behenian fixed stars with live conjunction detection, sign deep-dive (Letter/Tribe/Apostle), Mazzaroth panel, constellation scripture
- **Beings/Orders** — 72 Goetia spirits, 7 Olympic spirits, 7 Archangels, 9 Angelic Orders, 4 Elemental Kings, ritual implements guide. Tier system (I–IV) with approach/dismissal protocols
- **72 Names** — Full Shemhamphorasch with Exodus source view, Psalm keys, decan mapping, divine name vibration, invocation structure. 1:1 indexed to Goetia counterparts
- **Elections** — 8 operation categories with scored timing windows
- **Gematria** — Calculate, Compare/Offset, Reverse, Notariqon, ATBaSh, AIQ Beker. Active Now panel, quick presets, Christological resonance priority under ✝ lens
- **Study/Doctrina** — 22 Letters (Trinity/Sacraments/Apostles under ✝), 10 Sephiroth (full Trinitarian transformation under ✝), Colour Scales with liturgical vestment correspondences
- **Tree** — Interactive SVG Tree of Life with all 10 Sephiroth, 22 paths, Da'ath, Ein Soph veils. Body-of-Christ mapping under ✝ lens
- **CKab** — Dedicated Christian Kabbalah tab: Trinity & Tree, Pentagrammaton, Christological Numbers, Three Pillars, Sacraments, 7 Gifts, Mystics Guide, Liturgical Year, Sources
- **Ref** — Four sub-tabs: Planets (full correspondence dictionary), Theology (8 doctrinal fault lines), Glossary (12 key terms with gematria), Sources (historical figures + mystics)

### Gematria Defense System
Every Goetia spirit has a bespoke numerical defense computed from the offset between YHShVH (326) and the spirit's Shem correspondent. The system produces: seed defense letter, seal letter, Ana B'Koach line, and a 5-step Summary Execution (Ground → Invoke → Apply → Command → Seal). Tier IV spirits receive the full adversary-shattering protocol.

### Scripture Integration
14 embedded chapters (247 verses): Psalms 8, 19, 23, 24, 33, 45, 91, 103, 116, 139, 150 + Genesis 49 + Job 38 + John 1. Scripture Viewer overlay accessible from any tab. Companion Bible JSON loader for full text.

### Projection System
Every being card (Goetia, Olympic, Shem angel) has a **NEXT ▸** button that opens a 7-day projection overlay showing scored future windows with **Projected Active** / **Projected Aligned** badges, timestamps, and contributing factors.

### Global Search
The **⊕** button searches across all 9 data domains: Goetia, Shem angels, Planets, Archangels, Sephiroth, Glossary, Theology, Letters, and Behenian Stars. Results navigate directly to the relevant card.

## Installation

### As a PWA (recommended)
1. Open `index.html` in a mobile browser
2. Tap "Add to Home Screen" (iOS) or the install prompt (Android/Chrome)
3. The app works offline after first load

### As a local file
Simply open `index.html` in any modern browser. No build step, no dependencies, no server required.

### Companion Bible File
For full Bible text beyond the embedded chapters, load a JSON file through the Scripture Viewer:
```json
{"Ps":{"1":["Blessed is the man...","..."],...},"Gen":{"1":["In the beginning...","..."],...}}
```

## Architecture

Single-file HTML application. No framework, no build system, no external dependencies beyond Google Fonts (Cinzel + EB Garamond). All state managed through a central `S` object driving a `render()` function. Settings persisted via localStorage. ~5,300 lines of vanilla JavaScript.

### Key Design Principle
The Christian Kabbalistic lens functions as a **revelatory overlay** — when active, it transforms content by revealing hidden Christian meaning already latent within each card, rather than generating separate standalone content. As Christ reveals hidden meaning in God's Word, the toggle reveals meaning already present in the existing structure.

## Sources

- **Agrippa**, *De Occulta Philosophia* (1531)
- **Pico della Mirandola**, *Conclusiones* (1486), *Heptaplus* (1489)
- **Reuchlin**, *De Verbo Mirifico* (1494), *De Arte Cabalistica* (1517)
- **Kircher**, *Oedipus Aegyptiacus* (1652)
- **Vaughan**, *Anthroposophia Theomagica* (1650)
- *Sefer Yetzirah*, *Zohar*, *Bahir*
- *Lemegeton Clavicula Salomonis* (Lesser Key of Solomon)
- *Arbatel of Magic*
- *Picatrix* (Ghāyat al-Ḥakīm)
- **Pseudo-Dionysius**, *The Celestial Hierarchy*

## License

This is a devotional and educational tool. Use with discernment.
