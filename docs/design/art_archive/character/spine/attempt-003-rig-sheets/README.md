# Hologirl Spine Rig Sheets - Attempt 003

This folder archives two candidate Hologirl multipart source sheets for the next Spine model pass.

- `sheet-a-broad.png`: broader sheet with more duplicate/variant pieces. Better for choice, worse for direct extraction.
- `sheet-a-broad-transparent.png`: chroma-key removed version with soft matte, despill, and 1px edge contraction.
- `sheet-b-strict.png`: stricter one-piece-per-slot sheet. More consistent, but with fewer alternative hands/parts.
- `sheet-b-strict-transparent.png`: chroma-key removed version with soft matte, despill, and 1px edge contraction.
- `sheet-c-no-ball-joints.png`: stricter follow-up that explicitly tries to avoid exposed puppet/ball-joint construction.
- `sheet-c-no-ball-joints-transparent.png`: chroma-key removed version with soft matte, despill, and 1px edge contraction.
- `sheet-d-scratch.png`: scratch restart sheet prompted to ignore prior rig-sheet construction.
- `sheet-d-scratch-transparent.png`: chroma-key removed version with soft matte, despill, and 1px edge contraction.
- `sheet-e-overlap-rig.png`: separated rig sheet prompted for animation overlap, with full under-skirt/under-cuff/under-collar pieces plus front overlay pieces.
- `sheet-e-overlap-rig-transparent.png`: chroma-key removed version with soft matte, despill, and 1px edge contraction.
- `sheet-f-overlap-rig-3q.png`: follow-up separated rig sheet that keeps the overlap approach while making the head and other pieces more consistently 3/4 side-facing.
- `sheet-f-overlap-rig-3q-transparent.png`: chroma-key removed version with soft matte, despill, and 1px edge contraction.
- `sheet-g-hologram-magenta.png`, `sheet-h-hologram-magenta.png`, and `sheet-i-hologram-magenta.png`: magenta-key overlap rig variants that push Hologirl toward softer projected hologram styling and away from gemstone/crystal faceting.
- `sheet-g-hologram-magenta-transparent.png`, `sheet-h-hologram-magenta-transparent.png`, and `sheet-i-hologram-magenta-transparent.png`: chroma-key removed versions of the magenta-key variants.
- `sheet-j-linework-grip-ponytails.png`, `sheet-k-linework-grip-ponytails.png`, and `sheet-l-linework-grip-ponytails.png`: variants focused on thin linework, explicit near/far ponytails with gold circlets, and combined hand+whip-handle grip pieces.
- `sheet-j-linework-grip-ponytails-transparent.png`, `sheet-k-linework-grip-ponytails-transparent.png`, and `sheet-l-linework-grip-ponytails-transparent.png`: chroma-key removed versions of the linework/grip/ponytail variants.
- `sheet-m-granular-body.png` and `sheet-n-granular-body.png`: variants focused on more distinct body, clothing, belt, skirt, shoulder, sleeve, and hair pieces instead of duplicate limb options.
- `sheet-m-granular-body-transparent.png` and `sheet-n-granular-body-transparent.png`: chroma-key removed versions of the granular body variants.
- `sheet-o-clothing-depth.png`: variant focused on clothing and trim layers for front/back depth.
- `sheet-p-hair-depth.png`: variant focused on head, bangs, hair cap, and near/far ponytail layering.
- `sheet-q-clean-minimal-depth.png`: variant focused on one clean unique piece per needed layer for easier manual assembly.
- `sheet-r-separated-clothes.png`: follow-up variant focused on separating blue hologram body/skin pieces from standalone clothing shell pieces. Clothing openings intentionally remain magenta/empty so body parts can slide underneath instead of being baked into the outfit art.
- `sheet-s-essential-separated.png` through `sheet-ad-essential-separated.png`: candidate variants based on the operator's essential part list: front/back ponytails, head, body torso, hollow torso outfit with pendant, skirt/belt with matching gem, two arms, two hollow cuffs, relaxed and whip-grip hands, gold whip, two legs, and two hollow white/gold boots.
- `sheet-ae-reference-led.png`: rejected/diagnostic reference-led candidate generated after reloading the approved character-select cutout and Sheet A into context. It improved the separated clothing workflow but still drifted off-model and is not exposed in the tuner.
- `sheet-o-clothing-depth-transparent.png`, `sheet-p-hair-depth-transparent.png`, `sheet-q-clean-minimal-depth-transparent.png`, `sheet-r-separated-clothes-transparent.png`, the `sheet-s` through `sheet-ad` transparent files, and `sheet-ae-reference-led-transparent.png`: chroma-key removed versions of the O/P/Q/R, essential separated, and reference-led variants.
- `full-body-a.png` and `full-body-b.png`: coherent side-facing full-body references for manual cuts and visual identity comparison.
- `full-body-a-transparent.png` and `full-body-b-transparent.png`: chroma-key removed versions of the full-body references.

Design intent:

- Hologirl identity should stay anchored to the approved character-select design: blue hologram body, light-blue twin ponytails, white/gold outfit, and gold whip.
- The HTML rig tuner maps art regions to semantic parts. The sheet itself does not need to decide which part is which permanently.
- Every generated rig sheet that is kept here should archive its prompt or prompt delta. See `docs/design/PROMPT_LIBRARY.md`.
- Chroma removal should prefer `remove_chroma_key.py` with soft matte, despill, and edge contraction to reduce green edge pixels.
- Magenta chroma-key variants exist because green-key removal and spill can leave visible edge artifacts on gold/white costume details.
- Visible ball/socket joints are unwanted. Hologirl should read as a continuous hologram character whose seams are hidden under cuffs, rings, sleeves, boots, skirt panels, or overlay masks.
- Runtime animation parts need hidden overlap. Limbs, neck, and hair should extend underneath clothing or adjacent pieces so small rotations do not reveal empty gaps.
- Depth should be solved by splitting pieces into back layers, full under-pieces, and front overlay masks. Example: `skirt_back` below leg, `upper_leg_near_under_skirt` in the middle, and `skirt_front_near` above the leg.
- Current preferred exploration direction is fewer duplicate options and more distinct semantic cutouts: torso halves, shoulder pads, belt front/back, skirt side panels, sleeve backs, cuff overlays, near/far ponytails, and combined hand+whip-handle grip pieces.
- When creating rig sheets for animation, clothing should usually be treated as shell/overlay art and should not contain baked-in blue body parts. Body pieces should sit underneath clothing shells so the tuner can solve depth with z-order and masks.
- Current essential separated variants intentionally prioritize a small, clear rigging set over exhaustive options. Extra clothing splits can still be made manually in the tuner when a shell needs a front/back overlay.

Current Hologirl rig part spec:

- All pieces should be 3/4 right-facing, matching the vanilla combat stance direction more than a front-facing portrait.
- Head: same no-mouth/no-nose face language as the chosen character-select cutout, with glowing rectangular eyes and the same haircut.
- Hair: two separate light-blue ponytails, one front and one back, with gold hair circlets aligned to the character-select design.
- Torso/body: blue hologram body piece plus a standalone torso outfit shell. The outfit needs the pendant seen in the chosen character-select cutout.
- Midsection: a lower-body/pelvis connector piece between torso, skirt, and legs so the rig does not have an empty waist gap.
- Skirt and belt: simpler than many generated variants. It should be one front flap and one side flap on each side, with a belt gem matching the pendant.
- Shoulders: shoulder pads that connect visually to the torso outfit; they can be separate pieces or attached when that makes rigging cleaner.
- Arms: two blue hologram arms, plus gold bracelets intended to sit around the arms.
- Cuffs: two white cuffs with gold lining, one for each arm, as hollow clothing shells.
- Hands: two hands. One should grip the whip handle, with one side of the handle open-ended so the whip can connect cleanly; the other can be relaxed/open.
- Weapon: one golden light-whip, separated from the body unless part of the hand-and-handle grip piece.
- Legs: two blue hologram legs.
- Boots: two white-and-gold boots matching the cuff language, as hollow clothing shells.
- Clothing pieces should usually have transparent/chroma-key openings instead of baked-in blue skin so body parts can slide underneath.
- Pieces should be truly separated islands for auto-extraction. Do not connect adjacent arms, clothes, or accessories by stray pixels.

Current sheet style lock:

- Prefer the earlier Sheet A / first-pass look: matte painted and cel-shaded, hand-drawn, broad color/value planes, simple readable shapes, and very thin selective dark linework.
- Keep hologram effects subtle. Hologirl should not become glossy, gemstone-like, robot-like, or ball-jointed.
- Avoid exposed mechanical joint circles, shiny puppet construction, heavy bloom, and clean anime model-sheet polish.

Sheet F has been promoted to the current combat test rig after the operator exported placement data from the rig tuner to `docs/design/tools/spine-rig-tuner/result.json`. Runtime assets are generated with `scripts/export-spine-rig-tuner-result.py`; continue treating the other sheets as archive candidates only.
