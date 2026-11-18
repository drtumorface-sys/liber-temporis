#!/usr/bin/env python3
"""Crop the 6 Ambelain plates into 72 individual sigil images."""
from PIL import Image, ImageOps
import os

# Plate -> starting sigil number
PLATES = {
    'plate_249.jpg': 1,   # Fig 19: sigils 1-12
    'plate_256.jpg': 13,  # Fig 20: sigils 13-24
    'plate_262.jpg': 25,  # Fig 21: sigils 25-36
    'plate_270.jpg': 37,  # Fig 22: sigils 37-48
    'plate_278.jpg': 49,  # Fig 23: sigils 49-60
    'plate_283.jpg': 61,  # Fig 24: sigils 61-72
}

def find_sigil_box(img):
    """Auto-detect the bordered sigil column. Ambelain's plate has a heavy black
    rectangular border around the 12 sigils. We find the topmost + bottommost
    long horizontal black lines (the top and bottom borders of the outer box)."""
    W, H = img.size
    gray = img.convert('L')
    px = gray.load()

    # Start with a rough x-range from calibration
    x_probe_l = int(W * 0.30)
    x_probe_r = int(W * 0.78)
    probe_w = x_probe_r - x_probe_l

    # Find top border: scan from top down, look for a row where >70% of pixels in [x_probe_l..x_probe_r] are dark
    y_top = None
    for y in range(int(H * 0.03), int(H * 0.20)):
        dark = sum(1 for x in range(x_probe_l, x_probe_r) if px[x, y] < 80)
        if dark > probe_w * 0.70:
            y_top = y
            break
    # Find bottom border: scan from bottom up
    y_bot = None
    for y in range(int(H * 0.97), int(H * 0.80), -1):
        dark = sum(1 for x in range(x_probe_l, x_probe_r) if px[x, y] < 80)
        if dark > probe_w * 0.70:
            y_bot = y
            break

    if y_top is None or y_bot is None:
        # Fallback to fractional defaults
        y_top = int(H * 0.076)
        y_bot = int(H * 0.905)

    # Auto-detect left/right borders too - vertical dark lines
    y_mid_lo = y_top + (y_bot - y_top) // 4
    y_mid_hi = y_top + 3 * (y_bot - y_top) // 4
    band_h = y_mid_hi - y_mid_lo
    x_left = None
    for x in range(int(W * 0.15), int(W * 0.55)):
        dark = sum(1 for y in range(y_mid_lo, y_mid_hi) if px[x, y] < 80)
        if dark > band_h * 0.80:
            x_left = x
            break
    x_right = None
    for x in range(int(W * 0.92), int(W * 0.55), -1):
        dark = sum(1 for y in range(y_mid_lo, y_mid_hi) if px[x, y] < 80)
        if dark > band_h * 0.80:
            x_right = x
            break
    if x_left is None:
        x_left = int(W * 0.290)
    if x_right is None:
        x_right = int(W * 0.790)

    # Inset a few pixels inside the border to skip the border line itself
    return (x_left + 4, y_top + 4, x_right - 4, y_bot - 4)

def process_plate(path, start_n, out_dir):
    print(f"\n{path} -> sigils {start_n}-{start_n+11}")
    img = Image.open(path)
    bbox = find_sigil_box(img)
    if not bbox:
        print(f"  ! could not find bounding box")
        return 0
    x1, y1, x2, y2 = bbox
    print(f"  box: x=({x1},{x2}) y=({y1},{y2}) size={x2-x1}x{y2-y1}")
    strip_h = (y2 - y1) / 12
    saved = 0
    for i in range(12):
        n = start_n + i
        # Crop each row (with small inset to avoid the black borders)
        top = int(y1 + i * strip_h) + 2
        bot = int(y1 + (i+1) * strip_h) - 2
        left = x1 + 2
        right = x2 - 2
        sig = img.crop((left, top, right, bot))
        # Optionally add a small margin, then save at reasonable size
        # Keep as grayscale PNG for smaller files
        sig = sig.convert('L')
        # Resize to a reasonable target (max ~500px wide)
        w, h = sig.size
        if w > 500:
            scale = 500 / w
            sig = sig.resize((int(w*scale), int(h*scale)), Image.LANCZOS)
        out_path = os.path.join(out_dir, f"{n:02d}.png")
        sig.save(out_path, 'PNG', optimize=True)
        saved += 1
    print(f"  saved {saved} sigils")
    return saved

if __name__ == '__main__':
    here = os.path.dirname(os.path.abspath(__file__))
    total = 0
    for plate, start in PLATES.items():
        path = os.path.join(here, plate)
        if not os.path.exists(path):
            print(f"MISSING: {path}")
            continue
        total += process_plate(path, start, here)
    print(f"\nTotal: {total} sigils saved")
