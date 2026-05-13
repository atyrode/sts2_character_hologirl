# Architecture Notes

## Current Research Snapshot

Date: 2026-05-13.

Slay the Spire 2 modding currently appears to use:

- C# gameplay code.
- Godot/Megadot asset packaging through `.pck` files.
- A mod manifest JSON file beside the compiled DLL.
- BaseLib as the community library for content registration and modding support.
- Alchyr's `ModTemplate-StS2` templates as the current recommended starting point.

This is not the same stack as Slay the Spire 1 Java mods.

## Current Repository Shape

- `Hologirl.csproj`: C#/Godot STS2 mod project generated from `Alchyr.Sts2.Templates` version `2.4.3`.
- `Hologirl.json`: mod manifest.
- `HologirlCode/`: gameplay code.
- `Hologirl/`: mod assets and localization packed into `Hologirl.pck`.
- `HologirlCode/Cards/Basic/HoloStrike.cs`: first custom card.
- `HologirlCode/Character/Hologirl.cs`: character model and starting deck.
- `global.json`: pins the .NET SDK line to 9.0.
- `Directory.Build.props`: ignored local file for machine-specific paths such as `Sts2Path`.

## Confirmed Sources

- `Alchyr/ModTemplate-StS2`: character, content, and blank mod templates.
  https://github.com/Alchyr/ModTemplate-StS2
- `Alchyr/BaseLib-StS2`: shared STS2 modding library. Latest release checked: `v3.1.3`, published 2026-05-13.
  https://github.com/Alchyr/BaseLib-StS2
- Mod template setup wiki:
  https://github.com/Alchyr/ModTemplate-StS2/wiki/Setup
- Mod template basics wiki:
  https://github.com/Alchyr/ModTemplate-StS2/wiki/Modding-Basics
- Mod template testing wiki:
  https://github.com/Alchyr/ModTemplate-StS2/wiki/Testing-and-Debugging
- `harsh2204/STS2-Buu`: working playable character mod reference.
  https://github.com/harsh2204/STS2-Buu
- Nexus Mods `The Hermit`: working playable character mod, with notes that STS2 beta updates can break mod APIs.
  https://www.nexusmods.com/slaythespire2/mods/320

## Minimum Mod Shape

From the current character template and working character mods, a distributable mod folder appears to contain:

- `<ModId>.dll`
- `<ModId>.pck`
- `<ModId>.json`

The manifest includes fields like:

- `id`
- `name`
- `author`
- `description`
- `version`
- `has_pck`
- `has_dll`
- `dependencies`
- `affects_gameplay`

BaseLib must be installed in the game's `mods/BaseLib/` folder before BaseLib-dependent mods load.

`Hologirl.json` pins this dependency as `BaseLib` minimum version `3.1.3`. If the game log reports that Hologirl cannot load `BaseLib, Version=3.1.3.0`, update BaseLib to `v3.1.3` or newer before testing Hologirl.

## Character Template Shape

The current character template provides:

- A `PlaceholderCharacterModel` subclass for the character.
- A starting deck.
- starting relics.
- card, relic, and potion pools.
- placeholder character UI asset paths.
- a base custom card class marked with the character card pool.
- localization files under `localization/eng/`.

Working card examples use `CustomCardModel` through a mod-specific base card class. A basic attack example from `STS2-Buu` uses:

- `CardType.Attack`
- `CardRarity.Basic`
- `TargetType.AnyEnemy`
- `DamageVar`
- `DamageCmd.Attack(...).FromCard(this).Targeting(cardPlay.Target).Execute(choiceContext)`

## Local Environment Status

- OS checked: Ubuntu 24.04.3 LTS.
- STS2 is installed at `/home/alex/games/slay-the-spire-2`.
- Game assembly path: `/home/alex/games/slay-the-spire-2/data_sts2_linuxbsd_x86_64/sts2.dll`.
- The game targets `net9.0` with `Microsoft.NETCore.App` `9.0.7`.
- .NET SDK `9.0.314` is installed in `/home/alex/.dotnet`.
- BaseLib `v3.1.3` is installed in `/home/alex/games/slay-the-spire-2/mods/BaseLib`.
- `Hologirl` builds successfully and installs into `/home/alex/games/slay-the-spire-2/mods/Hologirl`.
- Normal game launch fails on the VPS because no X11/Wayland display server is available.
- `--headless` launch reaches game startup, but Steamworks fails because no Steam client is running. This blocks actual run/card gameplay testing on the VPS.

Build/install is validated on the VPS. Gameplay validation should happen on a machine with a normal Steam client and display session unless a reliable STS2 headless test path is found.

## Build And Release Scripts

Use the repo scripts for the repeated path:

```bash
scripts/build.sh
scripts/package.sh
scripts/release.sh
```

- `scripts/build.sh` runs `dotnet build Hologirl.csproj`. The project's MSBuild targets copy the DLL, PDB, manifest, and generated PCK into the local STS2 mod folder.
- `scripts/package.sh` builds first, then writes `dist/Hologirl-<version>.zip` from `Hologirl.dll`, `Hologirl.pck`, and `Hologirl.json`.
- `scripts/release.sh` packages and publishes a normal GitHub release, not a prerelease, because the current mod-manager path expects normal releases.
