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
- `HologirlCode/Cards/`: Hologirl's card models.
- `HologirlCode/Powers/`: Hologirl's local gameplay powers, including `Fans`, `Singing`, and form powers.
- `HologirlCode/Relics/`: Hologirl relic models.
- `HologirlCode/Character/Hologirl.cs`: character model, starting deck, starting relics, and explicit temporary Ironclad run-asset fallbacks.
- `Hologirl/scenes/character_select/hologirl_character_select_bg.tscn`: vanilla-style BaseLib character-select background scene.
- `global.json`: pins the .NET SDK line to 9.0.
- `Directory.Build.props`: ignored local file for machine-specific paths such as `Sts2Path`.
- `docs/modding/LIBRARY_REFERENCE.md`: current STS2 library/tooling reference for BaseLib, RitsuLib, ModConfig, DevMode, and reusable implementation sources.

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
- Hologirl does not ship an in-run debug panel. Use DevMode for room, fight, event, inventory, console, and state-inspection workflows during development.
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
- Hologirl owns first-pass in-run Godot scenes for combat visuals, the combat energy counter, rest-site character visuals, and merchant character visuals. Missing secondary surfaces still route through explicit Ironclad asset paths for card trail, transition material, transition sound, multiplayer hand textures, fallback icon scene/outline texture, attack/cast/death sounds, and temporary Architect attack VFX. This is deliberate scaffolding while Hologirl-owned replacements are not designed yet, not passive placeholder inheritance.
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
- `scripts/package.sh` builds first, exports a fresh Godot PCK by default, then writes `dist/Hologirl-<version>.zip` from `Hologirl.dll`, `Hologirl.pck`, and `Hologirl.json`.
- `scripts/package.sh` uses Godot's headless `--export-pack` path by default because Hologirl ships `.tscn` scenes and Godot-imported resources. Set `HOLOGIRL_PCK_EXPORTER=quick` only for emergency simple-asset-only packages.
- `scripts/godot-env.sh` centralizes local Godot, `.NET`, STS2 mods, and fontconfig environment setup. It prefers the shared `/mnt/HC_Volume_105232828/shared` toolchain and still allows `GODOT_BIN`, `DOTNET_ROOT`, `STS2_MODS_DIR`, and `HOLOGIRL_SHARED_ROOT` overrides.
- `scripts/export-pck-godot.sh` is the direct Godot/MegaDot PCK export helper.
- `scripts/extract-pck-path.gd` is a Godot helper for extracting a specific file or folder from the local STS2 PCK when verifying vanilla asset structure or extension files.
- `scripts/check-spine-extension.gd` is a diagnostic helper for confirming whether the local Godot project can see Spine resource classes and load specific Spine resources.
- `scripts/export-spine-rig-tuner-result.py` promotes `docs/design/tools/spine-rig-tuner/result.json` into runtime rig assets. It cuts masked part PNGs from sheet F, refreshes the experimental Spine JSON/atlas source files, and generates the pure Godot layered rig scene currently used by combat.
- `scripts/godot-smoke-character-select.sh` runs the character-select scene smoke check through the same normalized Godot environment.
- `scripts/release.sh` packages and publishes a normal GitHub release, not a prerelease, because the current mod-manager path expects normal releases.
- `scripts/release.sh` uses `docs/releases/<version>.md` as the GitHub release changelog when that file exists.
- `scripts/release.sh` must only publish committed source from `main` after it has been pushed to `origin/main`. The script enforces this by fetching `origin/main`, rejecting dirty working trees, and rejecting local `main` when it differs from `origin/main`. Do not release from uncommitted work; package-only local tests should use `scripts/package.sh`.
- `Hologirl.json` stores the plain semantic version without a leading `v`. GitHub release tags and release-note filenames keep the `v` prefix, and `scripts/release.sh` normalizes either input form to the tagged form.

The quick PCK packer supports simple assets such as PNG and JSON, but skips Godot scene files like `.tscn`. Do not use the quick path for releases that ship localization/assets alongside vanilla-style character-select scenes, `GpuParticles2D`, or other resources that require Godot import metadata; it can leave the installed PCK stale while the DLL is fresh.

The shared toolchain has official Godot `4.5.1.stable.mono` installed at `/mnt/HC_Volume_105232828/shared/tools/godot/godot-4.5.1/Godot_v4.5.1-stable_mono_linux_x86_64/Godot_v4.5.1-stable_mono_linux.x86_64`. `scripts/godot-env.sh` also wires available Nix fontconfig files so headless Godot runs do not emit the previous missing `libfontconfig.so.1` warnings on this machine.

Spine experiments may require a local-only `addons/spine/` folder so headless Godot can parse `SpineSprite` scenes and Spine resource classes. That folder is ignored by git and excluded from PCK export; Hologirl must not ship a bundled Spine extension because STS2 already owns the runtime extension in-game. Remove the local addon before ordinary package/release runs unless actively testing Spine imports, because the upstream GDExtension can crash headless Godot on shutdown after export on this machine.

The combat visual can also use a pure Godot layered rig as an iteration bridge. `Hologirl/scenes/creature_visuals/hologirl.tscn` keeps the required `Visuals`, `Bounds`, `CenterPos`, and `IntentPos` contract, but its `Visuals` instance currently points to `Hologirl/animation/hologirl_tuner_rig_node.tscn` so in-game testing does not depend on Spine importer availability. `Hologirl/animation/hologirl_tuner_rig_idle.gd` adds part-level idle movement on top of the wrapper scene's whole-body bob.

Vanilla character select loads `CharacterModel.CharacterSelectBg` as a `PackedScene` and adds it to `NCharacterSelectScreen`'s `AnimatedBg` container. BaseLib patches `CustomCharacterModel.CustomCharacterSelectBg` into that getter, which is the preferred path for Hologirl's character-select scene.

Do not use BaseLib's separate `CustomCharacterSelectEntry.CreateCharacterSelectScene()` for Hologirl's visual background. That path can place the custom scene above vanilla UI depending on BaseLib node ordering. Hologirl currently uses `res://Hologirl/scenes/character_select/hologirl_character_select_bg.tscn`, exported through the Godot PCK path.

## Compatibility Practices

Hologirl should be conservative around shared game state and other mods.

- Before implementing reusable infrastructure, check `docs/modding/LIBRARY_REFERENCE.md` and current upstream sources for BaseLib, RitsuLib, ModConfig, DevMode, and other active library/tooling options. Do not reimplement settings UI, persistence, audio routing, lifecycle hooks, asset fallback profiles, diagnostics, hotkeys, debug panels, content registration, or shared UI systems without first documenting why the existing libraries are not a fit.
- Use mod-scoped ids and localization keys.
- Prefer BaseLib's local content model APIs over global patches.
- Avoid custom enum/keyword registration for glossary terms unless a real keyword behavior is needed. For now, `Shapeshift` is represented through a Hologirl-local tooltip power rather than a global `CardKeyword`.
- Keep relic-specific behavior attached to the relic conceptually and in code. The old `Prism Pendant` form-card reward path is disabled while Shapeshift is out of the active card implementation.
- Before adding patches, global description overrides, custom piles, or other shared systems, document the collision risk and test with BaseLib plus at least one other character mod where possible.
