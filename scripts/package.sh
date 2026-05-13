#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
version="${1:-"$("$repo_root/scripts/mod-version.sh")"}"
mods_dir="${STS2_MODS_DIR:-/home/alex/games/slay-the-spire-2/mods}"
mod_dir="$mods_dir/Hologirl"
dist_dir="$repo_root/dist"
asset="$dist_dir/Hologirl-$version.zip"

mkdir -p "$dist_dir"

"$repo_root/scripts/build.sh"

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
