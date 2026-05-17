# v0.4.3 Runtime Character First Pass

Generated on 2026-05-17 as the first Hologirl-owned in-run character visual.

## Source

- `source-keyed.png`: generated full-body Hologirl combat/rest/merchant pose on flat green chroma key.
- Runtime transparent PNG: `Hologirl/images/character/hologirl_runtime.png`

## Direction

The asset intentionally matches the approved character-select persona: blue/cyan hologram body, two large twin ponytails, white/gold idol armor, glowing rectangular eyes, and a golden light-whip.

This is not a final Spine rig. Vanilla STS2 characters use Spine-backed Godot scenes for full-quality animation, but v0.4.3 starts with a Hologirl-owned pure Godot scene so the mod no longer routes combat/rest/merchant visuals through Ironclad. The scene adds a small idle bob/breathing transform in GDScript. A future pass can replace the internals with a proper Spine or manually layered rig while keeping the same `CustomCharacterModel` routing points.
