# Sheet AE Reference-Led Prompt

Generated after loading these local references into the conversation:

- `Hologirl/images/charui/character_select_hologirl.png`
- `docs/design/art_archive/character/spine/attempt-003-rig-sheets/sheet-a-broad.png`

Prompt:

```text
Use case: stylized-concept
Asset type: Slay the Spire 2 Hologirl separated rig source sheet for manual cutout and animation.

Input images: Image 1 is the approved Hologirl character-select cutout and is the exact character/costume identity reference. Image 2 is Sheet A and is the exact style and body-part-sheet layout reference. Use both strongly. This must look like the same Hologirl as Image 1, drawn in the same style as Image 2, not a redesign.

Primary request: Create one new separated body-part sheet that feels like Sheet A was corrected and expanded, not replaced. Keep the same matte cel-shaded blue hologram texture, white-and-gold costume, gold whip, no-mouth face, rectangular glowing eyes, twin ponytails, chunky painted Slay-the-Spire-like shapes, and green/chroma-key sheet logic. The result should be ready for manual cutout/rigging.

Composition: one orthographic rig asset sheet on a perfectly flat solid #ff00ff chroma-key background. No shadows, no floor, no labels, no text. Arrange pieces in tidy rows with generous padding. Every part must be a separate visual island with no touching pixels or accidental connector pixels.

View: all pieces coherent 3/4 right-facing, similar to Image 1's combat-ready angle. Avoid full front-facing and avoid pure side profile. Do not mix views across limbs.

Required separate islands: front ponytail, back ponytail, head with hair bangs, optional neck, blue torso/body under-piece, hollow torso outfit shell with pendant, lower-body/pelvis connector, belt with centered blue gem and gold diamond accents, simple skirt front flap, skirt left side flap, skirt right side flap, two shoulder pad/shoulder trim pieces, left arm, right arm, two gold bracelets, two hollow white cuffs with gold lining, relaxed/open hand, hand gripping whip handle, open-ended whip handle ready to connect to whip, one golden light-whip, left leg, right leg, two hollow white-and-gold boots.

On-model outfit requirements from Image 1: sleeveless white torso armor/dress with angular gold collar and shoulder trim, small pendant on chest, gold belt with blue diamond center gem, skirt made of simple angular flaps rather than a complex dress, white cuff on both arms between gold rings, gold bracelets/circlets, white boots with gold trim. Do not invent a different idol outfit.

Rigging/depth requirement: clothing pieces should be hollow shell/overlay pieces where they cover blue body parts. Do not bake blue hologram skin inside the torso outfit, cuff openings, skirt openings, or boots. Body pieces should extend slightly underneath clothing for overlap and animation. No ball joints, no visible mechanical joint circles.

Style lock from Sheet A: matte hand-painted cel shading, broad faceted planes but not gemstone, subtle paper/painterly grain, chunky clean silhouettes, selective very thin dark cyan/black linework around important shadow seams and costume edges, restrained glow only in eyes and whip. Maintain the same color balance as the references: cyan body/hair, white cloth, warm gold trim/whip.

Avoid: drastic redesign, different costume, mouth, nose, robot, doll, ball joints, socket knees, mechanical connectors, glossy gemstone hair, glass/crystal body, heavy bloom, shiny anime model sheet, too many tiny details, random extra accessories, labels, text, UI, shadows, connected pieces, blue skin painted inside hollow clothing.
```

Post-processing:

- Copied from Codex image cache to `sheet-ae-reference-led.png`.
- Removed magenta chroma key with `remove_chroma_key.py`.
- Command options: `--auto-key border --soft-matte --transparent-threshold 12 --opaque-threshold 220 --despill --edge-contract 1`.
- Detected key color: `#f802fa`.
