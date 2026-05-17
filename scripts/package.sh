#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
version="${1:-"$("$repo_root/scripts/mod-version.sh")"}"
mods_dir="${STS2_MODS_DIR:-/mnt/HC_Volume_105232828/shared/games/slay-the-spire-2/mods}"
mod_dir="$mods_dir/Hologirl"
dist_dir="$repo_root/dist"
asset="$dist_dir/Hologirl-$version.zip"

mkdir -p "$dist_dir"

"$repo_root/scripts/build.sh"

pck_exporter="${HOLOGIRL_PCK_EXPORTER:-godot}"

case "$pck_exporter" in
  quick)
    ;;
  godot)
    "$repo_root/scripts/export-pck-godot.sh" "$mod_dir/Hologirl.pck"
    ;;
  *)
    echo "Unknown HOLOGIRL_PCK_EXPORTER value: $pck_exporter" >&2
    echo "Expected 'quick' or 'godot'." >&2
    exit 1
    ;;
esac

for file in Hologirl.dll Hologirl.pck Hologirl.json; do
  if [[ ! -f "$mod_dir/$file" ]]; then
    echo "Missing build output: $mod_dir/$file" >&2
    exit 1
  fi
done

python3 - "$asset" "$mod_dir" <<'PY'
import pathlib
import sys
import zipfile

asset = pathlib.Path(sys.argv[1])
mod_dir = pathlib.Path(sys.argv[2])
files = ["Hologirl.dll", "Hologirl.pck", "Hologirl.json"]

with zipfile.ZipFile(asset, "w", zipfile.ZIP_DEFLATED) as archive:
    for name in files:
        archive.write(mod_dir / name, f"Hologirl/{name}")

print(asset)
PY
