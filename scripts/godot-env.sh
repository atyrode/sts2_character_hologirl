#!/usr/bin/env bash

shared_root="${HOLOGIRL_SHARED_ROOT:-/mnt/HC_Volume_105232828/shared}"

default_godot_bin="$shared_root/tools/godot/godot-4.5.1/Godot_v4.5.1-stable_mono_linux_x86_64/Godot_v4.5.1-stable_mono_linux.x86_64"
fallback_godot_bin="$HOME/.cache/hologirl-tools/godot-4.5.1/Godot_v4.5.1-stable_mono_linux_x86_64/Godot_v4.5.1-stable_mono_linux.x86_64"

if [[ -z "${GODOT_BIN:-}" ]]; then
  if [[ -x "$default_godot_bin" ]]; then
    export GODOT_BIN="$default_godot_bin"
  elif [[ -x "$fallback_godot_bin" ]]; then
    export GODOT_BIN="$fallback_godot_bin"
  fi
fi

if [[ -z "${DOTNET_ROOT:-}" ]]; then
  if [[ -x "$shared_root/tools/dotnet/dotnet" ]]; then
    export DOTNET_ROOT="$shared_root/tools/dotnet"
  elif [[ -x "$HOME/.dotnet/dotnet" ]]; then
    export DOTNET_ROOT="$HOME/.dotnet"
  fi
fi

if [[ -n "${DOTNET_ROOT:-}" ]]; then
  export PATH="$DOTNET_ROOT:$PATH"
fi

if [[ -z "${STS2_MODS_DIR:-}" && -d "$shared_root/games/slay-the-spire-2/mods" ]]; then
  export STS2_MODS_DIR="$shared_root/games/slay-the-spire-2/mods"
fi

if [[ -z "${FONTCONFIG_FILE:-}" || -z "${FONTCONFIG_PATH:-}" || ":${LD_LIBRARY_PATH:-}:" != *":/nix/store/"*fontconfig*"/lib:"* ]]; then
  shopt -s nullglob
  fontconfig_libs=(/nix/store/*-fontconfig-*-lib/lib/libfontconfig.so.1)
  fontconfig_files=(/nix/store/*-fontconfig-*/etc/fonts/fonts.conf)
  shopt -u nullglob

  if [[ ${#fontconfig_libs[@]} -gt 0 ]]; then
    fontconfig_lib_dir="$(dirname "${fontconfig_libs[0]}")"
    if [[ ":${LD_LIBRARY_PATH:-}:" != *":$fontconfig_lib_dir:"* ]]; then
      export LD_LIBRARY_PATH="$fontconfig_lib_dir${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    fi
  fi

  if [[ ${#fontconfig_files[@]} -gt 0 ]]; then
    export FONTCONFIG_FILE="${FONTCONFIG_FILE:-${fontconfig_files[0]}}"
    export FONTCONFIG_PATH="${FONTCONFIG_PATH:-$(dirname "${fontconfig_files[0]}")}"
  fi
fi
