#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
dotnet_bin="${DOTNET:-}"

if [[ -z "$dotnet_bin" ]]; then
  if [[ -x "/mnt/HC_Volume_105232828/shared/tools/dotnet/dotnet" ]]; then
    dotnet_bin="/mnt/HC_Volume_105232828/shared/tools/dotnet/dotnet"
  elif [[ -x "$HOME/.dotnet/dotnet" ]]; then
    dotnet_bin="$HOME/.dotnet/dotnet"
  else
    dotnet_bin="dotnet"
  fi
fi

cd "$repo_root"
"$dotnet_bin" build Hologirl.csproj "$@"
