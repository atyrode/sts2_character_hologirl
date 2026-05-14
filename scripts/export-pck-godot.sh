#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
godot_bin="${GODOT_BIN:-}"
mods_dir="${STS2_MODS_DIR:-/home/alex/games/slay-the-spire-2/mods}"
output="${1:-"$mods_dir/Hologirl/Hologirl.pck"}"
dotnet_root="${DOTNET_ROOT:-/home/alex/.dotnet}"

if [[ -z "$godot_bin" ]]; then
  echo "GODOT_BIN must point to a Godot/MegaDot 4.5.1 Mono executable." >&2
  exit 1
fi

if [[ ! -x "$godot_bin" ]]; then
  echo "GODOT_BIN is not executable: $godot_bin" >&2
  exit 1
fi

mkdir -p "$(dirname "$output")"

export DOTNET_ROOT="$dotnet_root"
export PATH="$DOTNET_ROOT:$PATH"

cd "$repo_root"

# The DLL is built and packaged separately. Removing Godot's generated C# cache
# prevents the editor from loading stale mod assemblies while exporting assets.
rm -rf .godot/mono

"$godot_bin" --headless --export-pack BasicExport "$output"
