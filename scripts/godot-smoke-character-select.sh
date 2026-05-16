#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$repo_root/scripts/godot-env.sh"

if [[ -z "${GODOT_BIN:-}" ]]; then
  echo "GODOT_BIN must point to a Godot/MegaDot 4.5.1 Mono executable." >&2
  exit 1
fi

if [[ ! -x "$GODOT_BIN" ]]; then
  echo "GODOT_BIN is not executable: $GODOT_BIN" >&2
  exit 1
fi

cd "$repo_root"

# This GDScript smoke test does not need the mod DLL. Clearing Godot's C#
# cache prevents the editor from trying to load game-referenced assemblies.
rm -rf .godot/mono

"$GODOT_BIN" --headless --path . "$@" --script scripts/godot-smoke-character-select.gd
