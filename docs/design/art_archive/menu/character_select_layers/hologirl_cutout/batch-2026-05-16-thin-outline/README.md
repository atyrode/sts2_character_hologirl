# Character Cutout Batch: Thin Outline

Generated on 2026-05-16 as runtime tuner variants.

Goal: keep the white/gold Hologirl direction, but reduce the heavy black contour so the cutout is closer to vanilla character-select art. The intended outline language is selective: dark lines act more like shadow planes, occlusion cuts, and underside accents, while lit edges may use an incomplete pale cyan/white rim.

Runtime copies:

- `variant-001` -> `Hologirl/images/charui/character_variants/character_10_thin_outline_ready.png`
- `variant-002` -> `Hologirl/images/charui/character_variants/character_11_thin_outline_compact.png`
- `variant-003` -> `Hologirl/images/charui/character_variants/character_12_thin_outline_spire.png`
- `variant-004` -> `Hologirl/images/charui/character_variants/character_13_thin_outline_calm.png`
- `variant-005` -> `Hologirl/images/charui/character_variants/character_14_thin_outline_angular.png`

Selection status: available in the character-select F3 tuner.

Validated tuner defaults to evaluate these with:

`x=842.0 y=120.0 scale=1.51 whip_density=5.0 drift_density=1.3 gold_jitter=80.0 holo_tint=0.18 tear=0.0 tear_speed=0.0 shimmer=0.04 scanline=0.09 scan_speed=-0.22 scan_spacing=44.0 background=Periwinkle Drift character=White Gold Blue`

## Prompt Direction

- Use a flat `#00ff00` chroma-key background for runtime shader removal.
- Keep Hologirl blue-tinted and holographic, with two readable twintails.
- Keep white/gold outfit accents and the golden light-whip.
- Avoid baked scanlines and tearing; those are procedural shader effects.
- Avoid a continuous black sticker outline. Use dark linework selectively as shadow and separation.
