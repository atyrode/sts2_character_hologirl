# Character Select

## Confirmed Asset References

Recovered local STS2 references from `/home/alex/games/slay-the-spire-2/SlayTheSpire2.pck` on 2026-05-14.

Character button portraits:

- Official `char_select_*` portraits are `132x195`.
- They use tight head/shoulder crops, clear silhouettes, saturated flat backgrounds, hard edge definition, matte brush texture, and low detail.
- Each portrait reads through one strong head shape: Ironclad helm, Silent skull mask, Defect orb head, Regent horn, Necrobinder skull.

Large character-select backgrounds:

- Official backgrounds are Godot character-select scenes, generally using Spine atlases plus simple wide background plates.
- The recoverable background plates use wide `2048x1024` style compositions with large empty space for UI.
- Characters are staged on the right or as modular atlas pieces, with the center/left kept visually quieter.

## Hologirl Direction

Use a C# `CustomCharacterSelectEntry` first. BaseLib supports custom character-select entries that can build a Godot `Control` scene in code, which avoids global patches and avoids requiring a full Godot export for a `.tscn` file.

Use `docs/design/STS_STYLE_RESEARCH.md` for the visual language. The strongest character-select rule is silhouette-first readability: Hologirl should read through big blue twin-tail masses, a simple body block, and a bold golden whip before any facial or costume detail.

Hologirl's background should:

- Put Hologirl on the right third.
- Leave large atmospheric negative space on the left/center for the vanilla UI.
- Keep her silhouette large and readable: blue/cyan hologram body, two long ponytails, simple idol outfit.
- Use gold only for projected effects: light-whip arc, stage light, sparse light sticks, tiny holographic particles.
- Keep the crowd/fans very low-detail and discreet, mostly dark silhouettes.
- Stay hand-drawn, matte, graphic, and lower-detail than a polished anime illustration.
- Keep Hologirl near the boundary between the middle and right thirds, closer to camera than the first attempt, and holding/displaying the golden sparkly light-whip rather than attacking with it.

## Implemented Attempt

- Background archive: `docs/design/art_archive/menu/character_select_background/attempt-001/`
- Runtime background image: `Hologirl/images/charui/character_select_bg.png`
- Foreground cutout archive: `docs/design/art_archive/menu/character_select_layers/hologirl_cutout/attempt-007/`
- Runtime foreground cutout: `Hologirl/images/charui/character_select_hologirl.png`
- Runtime scene builder: `HologirlCode/Character/HologirlCharacterSelectEntry.cs`
- Button portrait archive: `docs/design/art_archive/menu/character_select_button/attempt-001/`
- Runtime button portrait: `Hologirl/images/charui/char_select_char_name.png`
- Runtime effects: `HologirlCode/Character/HologirlCharacterSelectEntry.cs` builds a layered `Control` scene with a code-drawn effects layer. Golden whip sparks use short-lived emitter particles; blue hologram drift uses short horizontal particles around the body.
- Runtime framing: the character-select scene uses a fixed `2564x1204` virtual canvas, matching the proportions of recoverable vanilla background plates. The canvas is scaled as one composition instead of positioning Hologirl directly from the viewport size.
- Hologirl's character layer is intentionally right-biased with large empty space preserved for the vanilla UI. Do not size or position it from `GetViewportRect()`; use the background container/canvas size instead.
- The scene root uses a negative absolute z-index defensively so BaseLib's custom background cannot draw above the vanilla UI. If Hologirl appears over UI again, investigate BaseLib's actual node insertion order before adding more visual layers.
- Particle effects must be initialized with non-zero virtual-canvas bounds before any burst is emitted; otherwise the first particles spawn at `(0, 0)` or outside the visible composition.

## Open Questions

- Whether the C#-built layered scene is enough, or whether we should later build a Spine/Godot animated scene with proper articulated body, whip, crowd, and glow motion.
- Whether BaseLib exposes enough of the vanilla character-select container for a closer one-to-one clone of the game's internal scene setup.
- Whether the locked character-select portrait should get a separate desaturated/locked treatment.
- If character-select behavior remains off, check Nexus Mods and linked GitHub repos for current playable character implementations before inventing more custom layout logic. `Manosaba` is a known Nexus character mod with character-select/BaseLib discussion in its posts.
