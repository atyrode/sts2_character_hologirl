# Character Select Button: Linework No Ref 02 Review

Generated on 2026-05-16 with `scripts/create-linework-character-select-button-review.gd`.

Purpose: compare deterministic size and placement options for the character-select button before replacing the runtime icon.

Source assets:

- Background: `Hologirl/images/charui/background_variants/bg_10_periwinkle_drift.png`
- Character cutout: `Hologirl/images/charui/character_variants/character_21_linework_no_ref_02.png`
- Output size: `132x195`

Variants:

- `variant-001/result.png`: face centered less zoom, full PNG target height `390`, offset `(-229, -23)`.
- `variant-002/result.png`: face higher less zoom, full PNG target height `410`, offset `(-239, -34)`.
- `variant-003/result.png`: variant 5 less zoom, full PNG target height `430`, offset `(-250, -43)`.
- `variant-004/result.png`: slightly right less zoom, full PNG target height `430`, offset `(-239, -40)`.
- `variant-005/result.png`: safest top less zoom, full PNG target height `375`, offset `(-221, -13)`.

Current generator uses the full uncropped character PNG with chroma-key alpha, then scales and positions that complete image inside the `132x195` button frame. It does not crop the source before scaling.

Selection status: `variant-002` selected and copied to `Hologirl/images/charui/char_select_char_name.png`.
