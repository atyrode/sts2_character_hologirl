# STS2 Library And Tooling Reference

Last checked: 2026-05-16.

This document tracks current Slay the Spire 2 reusable libraries, framework-like tools, and high-signal reference projects so Hologirl does not reimplement systems that already exist. STS2 modding is still moving quickly; verify versions and API shape again before adding or changing a dependency.

## Dependency Policy

- Keep Hologirl's shipped dependencies limited to libraries that directly support player-facing mod behavior.
- Prefer maintained library APIs over global patches for shared concerns such as content registration, settings UI, persistence, audio routing, localization, and diagnostics.
- Treat development tools as development tools. Do not make Hologirl depend on them at runtime unless the shipped mod intentionally needs that dependency.
- Prefer source/docs from active GitHub repositories, current Nexus pages, and working mods over old STS1 patterns.

## BaseLib-StS2

Sources:

- GitHub: https://github.com/Alchyr/BaseLib-StS2
- Latest GitHub release checked: `v3.1.3`, published 2026-05-13.
- Nexus page: https://www.nexusmods.com/slaythespire2/mods/103

Role:

BaseLib is the standard foundation library for most STS2 content mods. Hologirl already depends on it.

Useful surfaces:

- `CustomCharacterModel`, `CustomCardModel`, `CustomRelicModel`, `CustomPowerModel`, `CustomPotionModel`, and related content model bases.
- Character card, relic, and potion pool integration.
- Character-select integration through custom character model properties.
- Custom target type support, calculated card variables, card reward serialization, custom rest-site option support, Godot animation support, and diagnostics from recent releases.

Use in Hologirl:

- Continue using BaseLib for the core character/card/relic/potion model path.
- Prefer BaseLib's local model APIs before adding global Harmony patches.
- When BaseLib offers a targeted content API, do not hand-roll the same registration or serialization logic.

## STS2-RitsuLib

Sources:

- GitHub: https://github.com/BAKAOLC/STS2-RitsuLib
- Documentation: https://sts2-ritsulib.ritsukage.com/
- Latest GitHub release checked: `v0.2.32`, published 2026-05-16.

Role:

RitsuLib is a broad authoring/runtime utility library that sits beside BaseLib. It is not a replacement for BaseLib; its README describes it as APIs for content registration, model identity, lifecycle hooks, persistence, settings UI, localization, audio, UI extensions, and compatibility helpers.

Useful surfaces:

- Content registration through attributes such as `RegisterCard`, `RegisterRelic`, `RegisterPotion`, `RegisterCharacter`, `RegisterPower`, `RegisterAct`, `RegisterMonster`, `RegisterGlobalEncounter`, event/ancient registration, daily modifier registration, and shared pool registration.
- Content-pack registration through `RitsuLibFramework.CreateContentPack(modId)` when a batch registration is clearer than attributes.
- Character scaffolding through `ModCharacterTemplate<TCardPool, TRelicPool, TPotionPool>`, additive starter registration, unlock/epoch helpers, card-library placement rules, vanilla character-select visibility controls, and character asset profiles.
- Asset profiles and fallbacks for cards, relics, powers, orbs, potions, acts, monsters, encounters, events, rest-site options, epochs, and characters. Character profiles include scene, UI, and audio path groups, plus an explicit `PlaceholderCharacterId` fallback mechanism for partial profiles.
- Player-facing settings pages through `RitsuLibFramework.RegisterModSettings(modId, configure)`. Built-in controls include toggles, integer and float sliders, choice/enum controls, color controls, string fields, key bindings, buttons, editable lists, read-only headers/paragraphs/info cards/images/hotkey summaries, nested pages, and custom Godot controls.
- JSON-backed mod data and migrations through `RitsuLibFramework.GetDataStore(modId)` and `BeginModDataRegistration(modId)`.
- Lifecycle events through `RitsuLibFramework.SubscribeLifecycle<TEvent>(...)`.
- Harmony patching helpers through `RitsuLibFramework.CreatePatcher(modId, patcherName)` and patch diagnostics.
- Localization helpers, keyword support, SmartFormat extension registration, and compatibility behavior for missing localization keys.
- Audio through `GameAudioService.Shared`, `AudioSource`, playback options, handles for loops/music, FMOD bank/GUID mapping helpers, routing channels/tags, automatic scope lifetimes, and cooldowns.
- Runtime UI helpers such as hotkey registration, top-bar buttons, card piles, shell themes, toast UI, and Godot node factory helpers.
- Diagnostics such as registration conflict detection, Harmony patch dumps, card/compendium PNG export helpers, self-check bundles, and console autocomplete improvements.

Use in Hologirl:

- Strong candidate when we need player-facing options, persistent user settings, runtime hotkeys, reusable debug/dev UI plumbing, structured mod data, custom audio routing, character asset fallback profiles, or unlock/timeline scaffolding.
- Strong candidate if we want Hologirl's currently hand-written placeholder asset routing to become an explicit asset profile/fallback policy instead of scattered overrides.
- Do not add RitsuLib just because DevMode uses it. Add it only if Hologirl directly benefits from its runtime APIs.

Manifest notes:

- RitsuLib's current docs use dependency object form for game API `0.105.x` and newer:
  `{"id":"STS2-RitsuLib"}`.
- Older API branches use the legacy string form: `"STS2-RitsuLib"`.
- Hologirl currently targets the user's local `0.103.2` test build, so the legacy string form would be the safer format if we adopted it before moving to a newer API branch.

## DevMode

Sources:

- GitHub: https://github.com/WRXinYue/STS2-DevMode
- Current manifest checked locally declares dependency `STS2-RitsuLib`.

Role:

DevMode is an in-game development tool, not a general modding framework. Its docs describe it as a vertical rail of panels attached to the main menu and in-run UI for inspecting and modifying game state without restarting.

Useful surfaces:

- Built-in panels for cards, relics, enemies, powers, potions, events, rooms, console, presets, hooks, scripts, logs, Harmony analysis, frameworks, save/load, and settings.
- `DevPanelRegistry` for other mods to add tabs into DevMode's rail when they intentionally integrate with it.
- Proven UI attachment pattern: patch `NGlobalUi._Ready`, attach the panel to global UI, and use an always-present process/input node instead of relying on a run-scene-only node.

Use in Hologirl:

- Best first choice for manual testing workflows like jumping to rooms, fights, shops, events, and adding/removing content during a run.
- If Hologirl needs custom dev-only tools, prefer either DevMode integration or a separate dev-only package/branch over shipping a permanent player-facing debug dependency.
- Do not make Hologirl hard-depend on DevMode for normal play.

## ModConfig-STS2

Sources:

- GitHub: https://github.com/xhyrzldf/ModConfig-STS2
- Nexus page: https://www.nexusmods.com/slaythespire2/mods/27
- Latest GitHub release checked: `v0.2.2`, published 2026-04-18.

Role:

ModConfig is a focused mod configuration framework. It injects a `Mods` tab into the game's settings screen and lets mods register configuration entries. Its author-facing integration is intentionally zero-dependency: mods call it by reflection, so the mod can still run when ModConfig is not installed.

Useful surfaces:

- Settings UI controls: toggle, slider, dropdown, key binding, text input, button, color picker, header, and separator.
- Per-mod persisted values under `user://ModConfig/<modId>.json`.
- Optional integration pattern through a bridge file instead of a compile-time DLL reference.
- Bilingual label/description support in the provided examples.

Use in Hologirl:

- Consider only if we want optional settings UI without adding a hard runtime dependency.
- Prefer RitsuLib settings if Hologirl already adopts RitsuLib for broader runtime infrastructure.
- Do not use both RitsuLib settings and ModConfig for the same shipped setting surface unless there is a clear compatibility reason.

## ModTemplate-StS2

Sources:

- GitHub: https://github.com/Alchyr/ModTemplate-StS2
- Setup wiki: https://github.com/Alchyr/ModTemplate-StS2/wiki/Setup
- Modding basics: https://github.com/Alchyr/ModTemplate-StS2/wiki/Modding-Basics
- Testing/debugging: https://github.com/Alchyr/ModTemplate-StS2/wiki/Testing-and-Debugging

Role:

ModTemplate is not a runtime library. It is the current template/reference path for STS2 C#/Godot mod shape, build setup, manifest layout, and common project patterns.

Use in Hologirl:

- Continue using it as a reference for idiomatic project shape and build behavior.
- Re-check it when the STS2 API or BaseLib template conventions change.

## Other Current Tools And References

These are useful references, but they are not general-purpose libraries for Hologirl to depend on.

- Slay the Spire 2 Modding Tutorials: https://glitchedreme.github.io/SlayTheSpire2ModdingTutorials/index.html
  Community tutorial site covering setup, BaseLib usage, content patterns, migration notes, and art replacement.
- STS2-ModAnalyzers-RitsuLib: https://github.com/BAKAOLC/STS2-ModAnalyzers-RitsuLib
  Optional analyzer companion for RitsuLib-style mods.
- STS2-Buu: https://github.com/harsh2204/STS2-Buu
  Working playable character reference.
- The Hermit on Nexus: https://www.nexusmods.com/slaythespire2/mods/320
  Working playable character reference with useful compatibility/version notes.
- Nexus STS2 mod index: https://www.nexusmods.com/games/slaythespire2/mods
  Live discovery source for current library dependencies, popular working mods, and compatibility reports.

## Current Conclusion

The maintained reusable library layer currently worth tracking is BaseLib plus RitsuLib. DevMode is the most relevant reusable development tool, and it itself depends on RitsuLib. For Hologirl, the immediate rule is:

- use BaseLib for the core playable character content path;
- consider RitsuLib when we need reusable settings, persistence, audio, lifecycle, asset profile/fallback, diagnostics, or UI infrastructure;
- use DevMode for broad manual testing instead of rebuilding a full debug suite inside Hologirl.

## Hologirl Library-Fit Audit

Last checked: 2026-05-16.

- In-run debug/testing UI: removed from Hologirl. DevMode covers the intended workflow better and avoids shipping custom debug-panel patches.
- Harmony patching: no current Hologirl runtime patches remain. Keep `Harmony.PatchAll()` and direct `0Harmony` references out of the project until there is a concrete patch with a documented compatibility reason.
- Character-select tuner: still a temporary art-calibration tool inside the character-select scene. It is acceptable while tuning art because it is scene-local and not player-facing settings infrastructure. Remove it once final values are locked; if it becomes a real user option, move it to ModConfig or RitsuLib settings instead of expanding the custom panel.
- Explicit Ironclad fallback asset routes: still deliberate scaffolding on `CustomCharacterModel`. RitsuLib's `CharacterAssetProfile` and `PlaceholderCharacterId` are a possible future replacement if Hologirl adopts RitsuLib for broader runtime infrastructure. Do not add RitsuLib solely for this while the current fallback list is small and documented.
- Content registration: current BaseLib model attributes and pool classes are appropriate. RitsuLib attribute/content-pack registration is a reasonable alternative only if we adopt RitsuLib for other reasons; migrating just for registration would add dependency surface without a clear payoff.
- Merchant/reward card generation: keep this as normal BaseLib/content-pool work. If these systems fail, first verify Hologirl has valid non-`Basic` draftable cards for normal rarities and card types before considering patches or new libraries.
- Gameplay logic for `Fans`, `Singing`, `Shapeshift`, form powers, `Livestream`, and `Prism Pendant`: keep local. These are Hologirl-specific mechanics, not reusable infrastructure.
- Local asset path helpers: keep local for now. RitsuLib asset profiles may replace some path overrides later, but only as part of a larger asset-profile migration.
