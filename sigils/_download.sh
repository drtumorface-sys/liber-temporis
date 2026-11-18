#!/usr/bin/env bash
# Download all 72 Lemegeton sigils from Wikimedia Commons via thumbnail endpoint
# (Wikimedia's rate limiter requires thumbnail access for bulk download)
set -e
cd "$(dirname "$0")"

declare -A SIGILS=(
  [01]="a/ae/01-Bael_seal.png"
  [02]="6/6d/02-Agares_seal.png"
  [03]="0/08/03-Vassago_seal.png"
  [04]="c/c8/04-Samigina_seal.png"
  [05]="e/ef/05-Marbas_seal.png"
  [06]="9/90/06-Valefor_seal.png"
  [07]="c/c0/07-Amon_seal.png"
  [08]="d/da/08-Barbatos_seal.png"
  [09]="f/fb/09-Paimon_seal01.png"
  [10]="d/d2/10-Buer_seal.png"
  [11]="5/5f/11-Gusion_seal.png"
  [12]="f/ff/12-Sitri_seal.png"
  [13]="2/23/13-Beleth_seal01.png"
  [14]="f/fc/14-Leraie_seal.png"
  [15]="5/5c/15-Eligos_seal.png"
  [16]="8/88/16-Zepar_seal.png"
  [17]="5/5c/17-Botis_seal.png"
  [18]="1/13/18-Bathin_seal01.png"
  [19]="f/f6/19-Sallos_seal.png"
  [20]="1/1d/20-Purson_seal.png"
  [21]="0/07/21-Marax_seal.png"
  [22]="b/bd/22-Ipos_seal.png"
  [23]="4/48/23-Aim_seal.png"
  [24]="f/f0/24-Naberius_seal.png"
  [25]="9/97/25-Glasya-Labolas_seal.png"
  [26]="c/c6/26-Bune_seal01.png"
  [27]="4/4e/27-Ronove_seal.png"
  [28]="c/c3/28-Berith_seal.png"
  [29]="7/72/Astaroth_Seal.svg"
  [30]="6/6d/30-Forneus_seal.png"
  [31]="d/d7/31-Foras_seal.png"
  [32]="7/7b/32-Asmoday_seal.png"
  [33]="9/93/33-Gaap_seal.png"
  [34]="c/cd/34-Furfur_seal.png"
  [35]="f/fd/35-Marchosias_seal.png"
  [36]="c/c7/36-Stolas_seal.png"
  [37]="c/c0/37-Phenex_seal.png"
  [38]="1/10/38-Halphus_seal.png"
  [39]="4/4d/39-Malphas.png"
  [40]="a/a8/40-Raum_seal.png"
  [41]="f/f4/41-Focalor_seal.png"
  [42]="9/92/42-Vepar_seal01.png"
  [43]="8/81/43-Sabnock_seal.png"
  [44]="c/c7/44-Shax_seal.png"
  [45]="4/4d/45-Vine_seal.png"
  [46]="3/35/46-Bifrons_seal.png"
  [47]="5/59/47-Vual_seal01.png"
  [48]="0/0f/48-Haagenti_seal.png"
  [49]="e/ef/49-Crocell_seal.png"
  [50]="e/e4/50-Furcas_seal.png"
  [51]="f/ff/51-Balam_seal.png"
  [52]="a/a3/52-Alloces_seal.png"
  [53]="2/20/53-Camio_seal.png"
  [54]="d/d4/54-Murmur_seal.png"
  [55]="6/62/55-Orobas_seal.png"
  [56]="f/ff/56-Gremory_seal.png"
  [57]="7/75/57-Ose_seal.png"
  [58]="8/8c/58-Amy_seal.png"
  [59]="2/28/59-Orias_seal.png"
  [60]="1/10/60-Vapula_seal.png"
  [61]="7/74/61-Zagan_seal.png"
  [62]="0/0e/62-Valac_seal.png"
  [63]="0/06/63-Andras_seal.png"
  [64]="7/7d/64-Haures_seal.png"
  [65]="b/b8/65-Andrealphus_seal.png"
  [66]="2/24/66-Cimeies_seal.png"
  [67]="5/58/67-Amdusias_seal.png"
  [68]="9/9e/68-Belial_seal.png"
  [69]="1/11/Decarabia_seal.png"
  [70]="4/42/70-Seere_seal01.png"
  [71]="9/98/71-Dantalion_seal.png"
  [72]="6/6e/72-Andromalius_seal.png"
)

# Validate a file: must be a real PNG/SVG, not Wikimedia's HTML error response.
# Check by reading magic bytes directly (most reliable across platforms).
is_valid() {
  local f="$1"
  [ -s "$f" ] || return 1
  # Reject if file is small (Wikimedia error pages are ~2KB)
  local sz=$(stat -c%s "$f" 2>/dev/null || stat -f%z "$f")
  [ "$sz" -lt 1500 ] && return 1
  # Read first 8 bytes as hex
  local magic=$(xxd -l 8 -p "$f" 2>/dev/null || od -An -N8 -tx1 "$f" | tr -d ' \n')
  # PNG magic: 89504e47
  case "$magic" in
    89504e47*) return 0 ;;  # PNG
    3c3f786d6c*) return 0 ;; # XML declaration (SVG)
    3c737667*) return 0 ;;   # <svg
  esac
  # Fallback: file command check (looser)
  local ftype=$(file -b "$f" 2>/dev/null)
  case "$ftype" in
    "PNG image"*) return 0 ;;
    "SVG Scalable"*) return 0 ;;
    "XML"*|"ASCII"*"XML"*) return 0 ;;
  esac
  return 1
}

attempt_download() {
  local n="$1" path="$2"
  local fname="${path##*/}"
  local prefix="${path%/*}"
  local ext="${path##*.}"
  local out_ext="$ext"
  [ "$ext" = "svg" ] && out_ext="png"
  local out="${n}.${out_ext}"
  # Try multiple thumbnail sizes (largest first) — not every sigil has every size pre-rendered
  for sz in 500 400 320 250 200 160 120; do
    local url
    if [ "$ext" = "svg" ]; then
      url="https://upload.wikimedia.org/wikipedia/commons/thumb/${prefix}/${fname}/${sz}px-${fname}.png"
    else
      url="https://upload.wikimedia.org/wikipedia/commons/thumb/${prefix}/${fname}/${sz}px-${fname}"
    fi
    curl -s -L -A "Mozilla/5.0 (Liber Temporis vault — offline study cache)" --max-time 30 -o "$out" "$url"
    if is_valid "$out"; then
      return 0
    fi
    rm -f "$out"
    sleep 0.5
  done
  return 1
}

for n in $(printf '%s\n' "${!SIGILS[@]}" | sort -n); do
  path="${SIGILS[$n]}"
  # Skip if a valid file already exists for this number
  existing=""
  for ext in png svg jpg; do
    candidate="${n}.${ext}"
    if [ -f "$candidate" ] && is_valid "$candidate"; then
      existing="$candidate"
      break
    fi
  done
  if [ -n "$existing" ]; then
    echo "[$n] keep $existing"
    continue
  fi

  # Try up to 3 times with backoff
  success=0
  for attempt in 1 2 3; do
    echo "[$n] download attempt $attempt: $path"
    if attempt_download "$n" "$path"; then
      success=1
      echo "  ok"
      break
    fi
    sleep $((attempt * 3))
  done

  if [ $success -eq 0 ]; then
    echo "  FAILED after 3 attempts: $n ($path)"
  fi

  # Throttle between requests to avoid rate limit
  sleep 2
done

echo "--- final status ---"
good=0; bad=0
for n in $(seq -f "%02g" 1 72); do
  found=0
  for ext in png svg jpg; do
    if [ -f "${n}.${ext}" ] && is_valid "${n}.${ext}"; then
      good=$((good+1))
      found=1
      break
    fi
  done
  if [ $found -eq 0 ]; then
    bad=$((bad+1))
    echo "  missing: $n"
  fi
done
echo "good: $good / 72"
echo "bad: $bad / 72"
