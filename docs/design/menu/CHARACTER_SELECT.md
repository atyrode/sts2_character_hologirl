# Character Select

## Confirmed Asset References

Recovered local STS2 references from `/home/alex/games/slay-the-spire-2/SlayTheSpire2.pck` on 2026-05-14.

Character button portraits:

- Official `char_select_*` portraits are `132x195`.
- They use tight head/shoulder crops, clear silhouettes, saturated flat backgrounds, hard edge definition, matte brush texture, and low detail.
- Each portrait reads through one strong head shape: Ironclad helm, Silent skull mask, Defect orb head, Regent horn, Necrobinder skull.

Large character-select backgrounds:

- Official backgrounds are Godot `PackedScene` character-select scenes loaded from each `CharacterModel.CharacterSelectBg`.
- Vanilla selection adds the instantiated scene to `NCharacterSelectScreen` node `AnimatedBg` (`_bgContainer`), after clearing the previous background.
- The base vanilla background behavior lives in `NCharacterSelectScreenBg`: it listens for window size changes and scales the root between about `1.1` and `1.2683` depending on aspect ratio.
- The recoverable background plates use wide compositions with large empty space for UI.
- Characters are staged on the right or as modular atlas pieces, with the center/left kept visually quieter.
- Recovered art suggests backgrounds are visually simpler than the current Hologirl stage painting: broad two-tone/low-color fields, large silhouette shapes, and restrained detail.

Vanilla code references checked locally on 2026-05-14:

- `MegaCrit.Sts2.Core.Nodes.Screens.CharacterSelect.NCharacterSelectScreen.SelectCharacter`
- `MegaCrit.Sts2.Core.Nodes.Screens.CharacterSelect.NCharacterSelectScreenBg`
- `MegaCrit.Sts2.Core.Nodes.Screens.CharacterSelect.NRegentCharacterSelectBg`
- `MegaCrit.Sts2.Core.Models.CharacterModel.CharacterSelectBg`
- `BaseLib.Patches.UI.CustomCharacterSelectEntryPatch.SelectCustomEntry`

## Hologirl Direction

BaseLib's `CustomCharacterSelectEntry` is mod-safe and adds its background scene to the same vanilla `AnimatedBg` container, but it is not the exact vanilla button path. Vanilla characters are normal `CharacterModel` buttons whose `CharacterSelectBg` points to a packed Godot scene. Prefer vanilla-feeling scene behavior and presentation; use the BaseLib entry path only where it avoids unsafe patches or packaging/tooling blockers.

Use `docs/design/STS_STYLE_RESEARCH.md` for the visual language. The strongest character-select rule is silhouette-first readability: Hologirl should read through big blue twin-tail masses, a simple body block, and a bold golden whip before any facial or costume detail.

Hologirl's background should:

- Put Hologirl on the right third.
- Leave large atmospheric negative space on the left/center for the vanilla UI.
- Keep her silhouette large and readable: blue/cyan hologram body, two long ponytails, simple idol outfit.
- Use gold only for projected effects: light-whip arc, stage light, sparse light sticks, tiny holographic particles.
- Keep the crowd/fans very low-detail and discreet if present at all. Avoid a fully illustrated stage scene for now.
- Prefer a simple broad two-tone background decoration, closer to vanilla/card art backgrounds, instead of a detailed environment.
- Stay hand-drawn, matte, graphic, and lower-detail than a polished anime illustration.
- Keep Hologirl near the boundary between the middle and right thirds, closer to camera than the first attempt, and holding/displaying the golden sparkly light-whip rather than attacking with it.

## Implemented Attempt

- Current released implementation is considered a failed prototype for character-select parity. Do not keep iterating on it by tiny release tweaks.
- Background archive: `docs/design/art_archive/menu/character_select_background/attempt-001/`
- Runtime background image: `Hologirl/images/charui/character_select_bg.png`
- Foreground cutout archive: `docs/design/art_archive/menu/character_select_layers/hologirl_cutout/attempt-007/`
- Runtime foreground cutout: `Hologirl/images/charui/character_select_hologirl.png`
- Runtime scene builder: `HologirlCode/Character/HologirlCharacterSelectEntry.cs`
- Button portrait archive: `docs/design/art_archive/menu/character_select_button/attempt-001/`
- Runtime button portrait: `Hologirl/images/charui/char_select_char_name.png`
- Runtime effects: `HologirlCode/Character/HologirlCharacterSelectEntry.cs` builds a layered `Control` scene with a code-drawn effects layer. Golden whip sparks use short-lived emitter particles; blue hologram drift uses short horizontal particles around the body.
- The current runtime pass uses a code-drawn simple two-tone background and chroma-keys the green source background from `character_select_hologirl.png`. Replace this with a true transparent layer when the next cutout is generated/exported.
- Runtime framing: the character-select scene uses a fixed `2564x1204` virtual canvas, matching the proportions of recoverable vanilla background plates. The canvas is scaled as one composition instead of positioning Hologirl directly from the viewport size.
- Hologirl's character layer is intentionally right-biased with large empty space preserved for the vanilla UI. Do not size or position it from `GetViewportRect()`; use the background container/canvas size instead.
- The scene root uses a negative absolute z-index defensively so BaseLib's custom background cannot draw above the vanilla UI. If Hologirl appears over UI again, investigate BaseLib's actual node insertion order before adding more visual layers.
- Particle effects must be initialized with non-zero virtual-canvas bounds before any burst is emitted; otherwise the first particles spawn at `(0, 0)` or outside the visible composition.
- Full Godot/MegaDot PCK export is now available on the VPS for real packed scenes. Prefer a `.tscn`/`PackedScene` implementation for the next character-select pass instead of more code-built layout patches.
- As of `v0.2.19`, Hologirl uses `CustomCharacterSelectBg` to load `res://Hologirl/scenes/character_select/hologirl_character_select_bg.tscn` through the vanilla background loader. Do not restore the old `CustomCharacterSelectEntry.CreateCharacterSelectScene()` visual path; it can draw over vanilla UI depending on BaseLib node ordering.
- Particle emitters should be tied to image content, not hand-estimated screen coordinates. The current scene samples gold pixels from the whip and blue pixels from the hologram body, then maps those normalized image points into the displayed character rectangle.
- Background palette direction: muted indigo/blue-violet base, darker lower band, limited dusty violet structure, cyan hologram accent, and gold projected-light accent. Avoid making the scene dominantly pink so it does not collapse into Necrobinder's color space.
- `v0.2.21` intentionally ships a temporary in-game `HologirlTuningPanel` on the character-select background. It is a calibration tool for choosing Hologirl's X/Y/scale, whip particle density, drift density, and gold jitter inside the real game layout. Remove or hide this panel once the final values are confirmed.
- Default particle direction after `v0.2.21`: fewer gold sparkles, smaller sparkles, lower background glow density, and tighter gold jitter. Keep whip sparks cute and crisp rather than smoky.
- `v0.2.22` moves the temporary tuning panel out of the virtual art canvas and anchors it to the visible scene bounds. Calibration UI should never be positioned in the cropped/scaled character art coordinate system.
- `v0.2.23` makes the temporary tuning panel counter-transform itself from viewport coordinates back into the character-select scene root. The root is not clipped while the tuner is enabled, because parent scene offsets can require negative local positions for an onscreen overlay.

## Open Questions

- Whether the vanilla-visible custom model path has any mod-list or random-character side effects with other character mods. Prefer testing this path before revisiting custom-entry buttons.
- Whether to keep using official Godot `4.5.1.stable.mono` for exports or replace it with MegaDot if a MegaDot-specific editor feature becomes necessary.
- Whether a C#-built scene can emulate `NCharacterSelectScreenBg` closely enough without fighting BaseLib's lifecycle. If yes, it should use the same root scaling rule and a much simpler visual background.
- Whether the locked character-select portrait should get a separate desaturated/locked treatment.
- If character-select behavior remains off, check Nexus Mods and linked GitHub repos for current playable character implementations before inventing more custom layout logic. `Manosaba` is a known Nexus character mod with character-select/BaseLib discussion in its posts.
