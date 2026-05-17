#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
version="${1:-"$("$repo_root/scripts/mod-version.sh")"}"
tag="$version"
if [[ "$tag" != v* ]]; then
  tag="v$tag"
fi
asset="$repo_root/dist/Hologirl-$tag.zip"
title="Hologirl $tag"
notes_file="$repo_root/docs/releases/$tag.md"
notes="${2:-""}"

cd "$repo_root"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Release must run from a git work tree." >&2
  exit 1
fi

current_branch="$(git branch --show-current)"
if [[ "$current_branch" != "main" ]]; then
  echo "Release must run from main. Current branch: ${current_branch:-detached HEAD}" >&2
  exit 1
fi

git fetch origin main --quiet

if [[ -n "$(git status --porcelain=v1)" ]]; then
  echo "Release blocked: working tree has uncommitted changes." >&2
  echo "Commit the exact release source first, then push main, then rerun release." >&2
  git status --short
  exit 1
fi

local_head="$(git rev-parse HEAD)"
remote_head="$(git rev-parse origin/main)"
if [[ "$local_head" != "$remote_head" ]]; then
  echo "Release blocked: local main is not exactly origin/main." >&2
  echo "Push or pull main first so the GitHub release points at committed source." >&2
  git status --short --branch
  exit 1
fi

"$repo_root/scripts/package.sh" "$tag"

if gh release view "$tag" >/dev/null 2>&1; then
  gh release upload "$tag" "$asset" --clobber
  if [[ -f "$notes_file" ]]; then
    gh release edit "$tag" --latest --prerelease=false --title "$title" --notes-file "$notes_file"
  else
    if [[ -z "$notes" ]]; then
      notes="Playable Hologirl mod $tag."
    fi
    gh release edit "$tag" --latest --prerelease=false --title "$title" --notes "$notes"
  fi
else
  if [[ -f "$notes_file" ]]; then
    gh release create "$tag" "$asset" --latest --title "$title" --notes-file "$notes_file"
  else
    if [[ -z "$notes" ]]; then
      notes="Playable Hologirl mod $tag."
    fi
    gh release create "$tag" "$asset" --latest --title "$title" --notes "$notes"
  fi
fi
