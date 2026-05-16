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
- `HologirlCode/Character/HologirlCharacterSelectEntry.cs`: BaseLib character-select entry that builds Hologirl's static selection background in C#.
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
- Hologirl's in-run F3 debug panel lives under `HologirlCode/Debug/` and is injected after `NRun._Ready`. It delegates execution to the game's `DevConsole.ProcessCommand` path so room, fight, and event jumps use the same backend as the built-in console.
- `harsh2204/STS2-Buu`: working playable character mod reference.
  https://github.com/harsh2204/STS2-Buu
- Nexus Mods `The Hermit`: working playable character mod, with notes that STS2 beta updates can break mod APIs.
  https://www.nexusmods.com/slaythespire2/mods/320
- Nexus Mods STS2 mod index: use this as a live discovery source for current libraries, compatibility notes, and popular working mods when BaseLib/template behavior is unclear.
  https://www.nexusmods.com/games/slaythespire2/mods
- Nexus Mods `BaseLib`: live user-facing distribution page for BaseLib and version requirements used by other mods.
  https://www.nexusmods.com/slaythespire2/mods/103
- Nexus Mods `StartingDeckSelect`: example of a current BaseLib-dependent mod with explicit game/BaseLib version notes and multiplayer compatibility notes.
  https://www.nexusmods.com/slaythespire2/mods/515
- Nexus Mods `Manosaba`: character-select posts are useful when investigating custom character-select behavior and BaseLib updates.
  https://www.nexusmods.com/slaythespire2/mods/353

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

`Hologirl.json` declares `BaseLib` in `dependencies` using the string-list schema expected by the user's current game build. It currently declares minimum game version `0.103.2` because that is the user's local test build. If the game log reports that Hologirl cannot load `BaseLib, Version=3.1.3.0`, update BaseLib to `v3.1.3` or newer before testing Hologirl.

## Character Template Shape

The current character template provides:

- A `CustomCharacterModel` subclass for the character. Hologirl intentionally does not inherit BaseLib's `PlaceholderCharacterModel`.
- Hologirl currently routes missing in-run surfaces through explicit Ironclad asset paths for combat visuals, card trail, transition material, transition sound, energy counter, rest/merchant animations, hand textures, fallback icon scene/outline texture, attack/cast/death sounds, and temporary Architect attack VFX. This is deliberate scaffolding while Hologirl-owned run assets are not designed yet, not passive placeholder inheritance.
- A starting deck.
- starting relics.
- card, relic, and potion pools.
- character UI asset paths.
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
- STS2 is installed at `/mnt/HC_Volume_105232828/shared/games/slay-the-spire-2`.
- Game assembly path: `/mnt/HC_Volume_105232828/shared/games/slay-the-spire-2/data_sts2_linuxbsd_x86_64/sts2.dll`.
- The game targets `net9.0` with `Microsoft.NETCore.App` `9.0.7`.
- .NET SDK `9.0.314` is installed in `/mnt/HC_Volume_105232828/shared/tools/dotnet`.
- BaseLib `v3.1.3` is installed in `/mnt/HC_Volume_105232828/shared/games/slay-the-spire-2/mods/BaseLib`.
- `Hologirl` builds successfully and installs into `/mnt/HC_Volume_105232828/shared/games/slay-the-spire-2/mods/Hologirl`.
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
- `scripts/package.sh` uses the quick PCK packer by default. Set `HOLOGIRL_PCK_EXPORTER=godot` to overwrite the PCK through Godot's headless `--export-pack` path before zipping.
- `scripts/godot-env.sh` centralizes local Godot, `.NET`, STS2 mods, and fontconfig environment setup. It prefers the shared `/mnt/HC_Volume_105232828/shared` toolchain and still allows `GODOT_BIN`, `DOTNET_ROOT`, `STS2_MODS_DIR`, and `HOLOGIRL_SHARED_ROOT` overrides.
- `scripts/export-pck-godot.sh` is the direct Godot/MegaDot PCK export helper.
- `scripts/godot-smoke-character-select.sh` runs the character-select scene smoke check through the same normalized Godot environment.
- `scripts/release.sh` packages and publishes a normal GitHub release, not a prerelease, because the current mod-manager path expects normal releases.
- `scripts/release.sh` uses `docs/releases/<version>.md` as the GitHub release changelog when that file exists.
- `Hologirl.json` stores the plain semantic version without a leading `v`. GitHub release tags and release-note filenames keep the `v` prefix, and `scripts/release.sh` normalizes either input form to the tagged form.

The quick PCK packer supports simple assets such as PNG and JSON, but skips Godot scene files like `.tscn`. Use the Godot/MegaDot export path when shipping vanilla-style character-select scenes, `GpuParticles2D`, or other resources that require Godot import metadata.

The shared toolchain has official Godot `4.5.1.stable.mono` installed at `/mnt/HC_Volume_105232828/shared/tools/godot/godot-4.5.1/Godot_v4.5.1-stable_mono_linux_x86_64/Godot_v4.5.1-stable_mono_linux.x86_64`. `scripts/godot-env.sh` also wires available Nix fontconfig files so headless Godot runs do not emit the previous missing `libfontconfig.so.1` warnings on this machine.

Vanilla character select loads `CharacterModel.CharacterSelectBg` as a `PackedScene` and adds it to `NCharacterSelectScreen`'s `AnimatedBg` container. BaseLib patches `CustomCharacterModel.CustomCharacterSelectBg` into that getter, which is the preferred path for Hologirl's character-select scene.

Do not use BaseLib's separate `CustomCharacterSelectEntry.CreateCharacterSelectScene()` for Hologirl's visual background. That path can place the custom scene above vanilla UI depending on BaseLib node ordering. Hologirl currently uses `res://Hologirl/scenes/character_select/hologirl_character_select_bg.tscn`, exported through the Godot PCK path.

## Compatibility Practices

Hologirl should be conservative around shared game state and other mods.

- Use mod-scoped ids and localization keys.
- Prefer BaseLib's local content model APIs over global patches.
- Avoid custom enum/keyword registration for glossary terms unless a real keyword behavior is needed. For now, `Shapeshift` is represented through a Hologirl-local tooltip power rather than a global `CardKeyword`.
- Keep relic-specific behavior attached to the relic conceptually and in code. For example, `Livestream` shapeshifts, while `Prism Pendant` is responsible for adding the form-specific 0-cost card.
- Before adding patches, global description overrides, custom piles, or other shared systems, document the collision risk and test with BaseLib plus at least one other character mod where possible.
