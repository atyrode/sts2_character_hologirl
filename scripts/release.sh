#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
version="${1:-"$("$repo_root/scripts/mod-version.sh")"}"
tag="$version"
asset="$repo_root/dist/Hologirl-$version.zip"
title="Hologirl $version"
notes="${2:-"Playable Hologirl prototype $version."}"

"$repo_root/scripts/package.sh" "$version"

cd "$repo_root"

if gh release view "$tag" >/dev/null 2>&1; then
  gh release upload "$tag" "$asset" --clobber
  gh release edit "$tag" --latest --prerelease=false --title "$title" --notes "$notes"
else
  gh release create "$tag" "$asset" --latest --title "$title" --notes "$notes"
fi
