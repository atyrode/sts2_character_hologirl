# v0.4.3 Visual Targets

## Combat Energy Counter

Hologirl currently has custom card-text and pool energy icons through:

- `Hologirl/images/charui/big_energy.png`
- `Hologirl/images/charui/text_energy.png`

The large in-combat energy counter above the draw pile is separate. It used to route through:

- `CustomEnergyCounterPath => res://scenes/combat/energy_counters/ironclad_energy_counter.tscn`

BaseLib `CustomCharacterModel.CustomEnergyCounterPath` is the intended replacement point. BaseLib documents it as a pure Godot scene that is converted into `NEnergyCounter` at runtime, with standard nodes such as `Control`, `Label`, `TextureRect`, `Node2D`, and `GPUParticles2D` converted as needed.

Hologirl now owns a first-pass energy counter scene under `Hologirl/scenes/combat/energy_counters/hologirl_energy_counter.tscn`, using the existing Hologirl energy symbol as its central read. This replaces only `CustomEnergyCounterPath`; card/pool energy icon paths remain owned by the card, relic, and potion pools.

## Combat Character Visual

Hologirl used explicit Ironclad in-run routing while Hologirl-owned run assets did not exist. The old combat entry was:

- `CustomVisualPath => res://scenes/creature_visuals/ironclad.tscn`

Vanilla combat characters are Godot scenes converted to `NCreatureVisuals`. The current Ironclad scene root is a `Node2D` with `Visuals`, `Bounds`, `CenterPos`, and `IntentPos` children. The `Visuals` child is a Spine sprite backed by `animations/characters/ironclad/ironclad.skel` and `.atlas`, so vanilla-quality animation uses Spine through Godot.

BaseLib gives a lower-risk path for Hologirl: `CustomVisualPath` can point to a pure Godot scene and BaseLib will generate `NCreatureVisuals` from it. The v0.4.3 first pass uses this path instead of waiting for a full Spine pipeline.

### Vanilla Scene Findings

Confirmed locally from the packed `SlayTheSpire2.pck` on 2026-05-17 using `scripts/inspect-packed-scene.gd` and `scripts/inspect-packed-scene-details.gd`.

The three inspected vanilla combat scenes share the same contract:

- Root node: `Node2D`.
- `Visuals`: `SpineSprite`, not a normal PNG sprite. This is why vanilla characters have separated-body animation and a true idle pose.
- `Bounds`: `Control`. This is not optional for BaseLib auto-conversion; using `Marker2D` caused `Node factory for NCreatureVisuals does not support conversion of Marker2D 'Bounds' to Control`.
- `CenterPos`: `Marker2D`.
- `IntentPos`: `Marker2D`.

Observed layout values:

| Character | Visuals position | Visuals scale | Bounds left/right | Bounds top | CenterPos | IntentPos |
| --- | --- | --- | --- | --- | --- | --- |
| Ironclad | `(5, -22)` | `(0.28, 0.28)` | `-121 / 121` | `-280` | `(0, -165)` | `(20, -351)` |
| Silent | `(16, -21)` | `(0.29, 0.29)` | `-122 / 122` | `-244` | `(0, -146)` | `(0, -302)` |
| Defect | `(1, -31)` | `(0.125, 0.125)` | `-125 / 125` | `-260` | `(3, -181)` | `(-2, -362)` |

Hologirl v0.4.4 first-pass layout is much taller:

- `Visuals` position: `(0, -120)`.
- `Visuals` scale: `(0.36, 0.36)`.
- `Sprite` position: `(0, -520)`.
- `Bounds`: `-155 / 155`, top `-540`, bottom `35`.
- `CenterPos`: `(0, -260)`.
- `IntentPos`: `(0, -520)`.

This explains the current in-combat feedback: Hologirl is too large and offset relative to the health bar and vanilla intent marker band. Before polishing animation, the next visual pass should first bring Hologirl's bounds and marker positions close to the vanilla range, then iterate on the animation technique.

### Animation Path Options

Confirmed:

- Vanilla-quality animation uses Spine assets through Godot `SpineSprite`.
- A single PNG with a bob script is not equivalent to vanilla. It can move, but it cannot produce the separated-part idle motion seen on vanilla characters.
- BaseLib can convert a pure Godot scene if the node contract matches what `NCreatureVisuals` expects.

Pragmatic staged path:

1. Calibrate the current PNG scene to vanilla bounds/markers so health bar, intent, and body placement are correct.
2. Split Hologirl into layered transparent body-part PNGs if we want a repo-native rig without Spine. Animate those with Godot `Node2D` transforms for head, torso, arms, hair, and whip. This will be less powerful than Spine but much closer to vanilla idle motion than one full-body PNG.
3. Move to a real Spine export when side-facing body-part art and a Spine editor/export path are available. The confirmed target pipeline is documented in `docs/design/SPINE_CHARACTER_PIPELINE.md`.
4. Once the combat rig is stable, reuse or adapt it for merchant/rest scenes instead of making unrelated poses first.

Implemented staging:

1. First pass: `Hologirl/scenes/creature_visuals/hologirl.tscn`, a Hologirl-owned Godot `Node2D` creature scene with `Visuals`, a `Control` `Bounds` child, and `Marker2D` `CenterPos` and `IntentPos` children. `Bounds` must stay a `Control`; BaseLib's `NCreatureVisuals` auto-converter fails if it is authored as `Marker2D`.
2. Shared runtime art: `Hologirl/images/character/hologirl_runtime.png`, generated as a full-body transparent sprite with the white/gold outfit and grounded light-whip.
3. Simple idle motion: `Hologirl/scenes/character/hologirl_runtime_visual.gd` adds a small breathing/body bob transform.
4. Rest and merchant scenes route through the same runtime sprite at `Hologirl/scenes/rest_site/characters/hologirl_rest_site.tscn` and `Hologirl/scenes/merchant/characters/hologirl_merchant.tscn`.
5. Keep the vanilla Spine route as the preferred final upgrade. The current PNG rig is only a temporary owned-asset bridge until Hologirl has side-facing Spine assets.

v0.4.6 combat calibration:

- `Visuals` position: `(0, -22)`.
- `Visuals` scale: `(0.2, 0.2)`.
- `Sprite` position: `(0, -533)`.
- `Bounds`: `-120 / 120`, top `-285`, bottom `25`.
- `CenterPos`: `(0, -160)`.
- `IntentPos`: `(10, -340)`.

This intentionally puts the temporary PNG model into the same vertical band as the inspected vanilla characters. It does not solve the final front-facing pose problem; that belongs to the side-facing Spine source-art pass.

v0.4.7 bridge art:

- `Hologirl/images/character/hologirl_runtime.png` now uses the accepted first side-facing Hologirl combat reference.
- Source copy: `docs/design/art_archive/character/spine/attempt-001-side-facing-reference/reference-chroma.png`.
- The scene contract and calibration values stay unchanged because the new image keeps the same 1024x1536 canvas.
- This is still a full-image bridge, not a separated-parts rig.

Open validation:

- Confirm BaseLib preserves the GDScript idle animation when converting these pure Godot scenes into `NCreatureVisuals`, `NRestSiteCharacter`, and `NMerchantCharacter`.
- Tune scale and marker positions in actual combat, merchant, and rest-site rooms.
- Add a dedicated death animation or death pose once the runtime scene contract for death playback is confirmed.

## Card Art Pass

The v0.4.1 card art pass made the pool more coherent but overused full Hologirl portraits. For v0.4.2, card art should follow vanilla composition logic:

- Start from the card name and mechanic.
- Use the full character only when the card fantasy needs her whole body.
- Prefer objects, weapons, light-whip segments, projected UI, audience/light-stick motifs, hands, arms, faces, or impact shapes when those read better.
- Preserve Hologirl's identity when she appears: blue/cyan hologram body language, rectangular glowing eyes, two-twintail silhouette, white/gold outfit pieces, and gold projected effects.
