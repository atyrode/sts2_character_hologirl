# Spine Character Pipeline

This document records the confirmed path toward a vanilla-style Hologirl combat character model. It is intentionally grounded in local STS2 assets, a current working STS2 character mod, and official Spine/Godot documentation rather than STS1-era assumptions.

## Confirmed Runtime Target

Confirmed locally from the packed Slay the Spire 2 assets and from the public `STS2-Buu` character mod on 2026-05-17:

- Vanilla combat characters use Godot scenes whose root is a `Node2D`.
- The scene has a child named `Visuals`.
- For vanilla characters, `Visuals` is a `SpineSprite`, not a normal PNG sprite.
- The combat scene also needs `Bounds` as a `Control`, plus `CenterPos` and `IntentPos` as `Marker2D` nodes. BaseLib auto-conversion fails if `Bounds` is authored as a `Marker2D`.
- Vanilla character animation assets live as Spine exports: `.png`, `.atlas`, `.skel`, and a Godot `SpineSkeletonDataResource` `.tres`.
- A current public STS2 character mod follows the same structure:
  - `animation/binary/<character>.png`
  - `animation/binary/<character>.atlas`
  - `animation/binary/<character>.skel`
  - `animation/<character>_skel_data.tres`
  - `animation/<character>_node.tscn` with a root `SpineSprite`
  - combat visual scene instancing that `SpineSprite` under `Visuals`

Official Spine documentation for `spine-godot` confirms the same runtime model: Godot uses Spine resources and nodes, with skeleton data backed by an atlas plus a skeleton file. Official Spine documentation also confirms Spine can export binary skeleton data and atlas data through the editor/export pipeline.

Sources:

- `https://esotericsoftware.com/spine-godot`
- `https://esotericsoftware.com/spine-export`
- `https://esotericsoftware.com/spine-command-line-interface`
- `https://github.com/harsh2204/STS2-Buu`

## Hologirl Art Direction For Combat

Hologirl's combat model must be side-facing, not front-facing. The character stands on the left and faces monsters, so a camera-facing pose reads incorrectly next to vanilla characters.

The first target pose should be:

- Three-quarter side view facing right.
- White/gold outfit and Hologirl color identity preserved from the character-select art.
- Whip visible in-hand, with the rest grounded or trailing so it can be animated subtly.
- Simple silhouette and readable separated parts. Vanilla in-combat characters are not highly detailed portraits; the model needs clear body-part shapes that survive motion and scale.

## Preferred Asset Layout

Use this layout when the real Spine model lands:

```text
Hologirl/
  animation/
    hologirl_skel_data.tres
    hologirl_node.tscn
    source/
      README.md
      hologirl.spine              # Optional; not required in the shipped mod if licensing/export workflow says not to ship it.
      parts/                      # Optional source body-part PNGs.
    binary/
      hologirl.png
      hologirl.atlas
      hologirl.skel
      hologirl.png.import
      hologirl.atlas.import
      hologirl.skel.import
```

The runtime combat scene should keep the same external contract:

```text
Hologirl/scenes/creature_visuals/hologirl.tscn
  Node2D root
    Visuals -> instance of res://Hologirl/animation/hologirl_node.tscn
    Bounds -> Control
    CenterPos -> Marker2D
    IntentPos -> Marker2D
```

This lets `CustomCharacterModel.CustomVisualPath` keep pointing at Hologirl's own combat scene while the internals move from the temporary PNG rig to `SpineSprite`.

## Animation Names

Use vanilla-like, simple animation names first:

- `idle`
- `attack`
- `defend`
- `hit`
- `dead`

Optional later animations:

- `cast` or `power`
- `victory`
- `merchant_idle`
- `rest_idle`

If the runtime character animator only calls a smaller set, unused animations are harmless source assets, but missing expected animations may make the model static or fall back poorly.

## Recommended Groundwork Path

1. Generate or draw a clean side-facing Hologirl reference that matches the current character-select design.
2. Create separated transparent body-part art from that reference: torso, head, hair/twintail parts, upper/lower arms, hands, legs, whip segments, and shadow. First source sheet archived at `docs/design/art_archive/character/spine/attempt-002-body-parts-source/`.
3. Locate or install a Spine editor/CLI capable of exporting `.skel`, `.atlas`, and packed PNG.
4. Build a minimal Spine skeleton with those parts and only an `idle` animation first.
5. Export into `Hologirl/animation/binary/`.
6. Let Godot import the `.skel` and `.atlas`, generating the `.import` files.
7. Create `hologirl_skel_data.tres` and `hologirl_node.tscn`.
8. Replace the temporary PNG `Visuals` internals with the `SpineSprite` scene.
9. Build/package and test in combat before adding attack, defend, hit, death, merchant, or rest animations.

## What Codex Can Do

Codex can handle:

- Generate side-facing concept/reference art and separated transparent body-part PNGs.
- Create the repo folder structure.
- Create or update `.tres` and `.tscn` files once exported Spine assets exist.
- Compare Hologirl scene metrics against vanilla character metrics.
- Build, package, release, and document the pipeline.
- Write validation scripts that inspect scene node contracts.

Codex cannot reliably author a professional Spine rig entirely from scratch unless a usable Spine editor/CLI or compatible exporter is available on the machine. The current machine does not expose `Spine` or `spine` on `PATH`.

## Operator-Needed Work

To use the exact same technology as vanilla, the operator likely needs to provide one of:

- A licensed Spine editor installation and its CLI path.
- Exported `hologirl.png`, `hologirl.atlas`, and `hologirl.skel` files from Spine.
- Approval for a lower-fidelity experimental path using generated Spine JSON, if we decide the risk is acceptable.

The licensed-editor path is the safest because it matches the standard Spine workflow and avoids maintaining a fragile hand-authored skeleton file format.

## Reusing Another Skeleton

Reusing another character's skeleton is a possible fallback, but it is not the preferred groundwork path.

It can work if Hologirl's replacement art matches the source skeleton's:

- Slot names.
- Attachment names.
- Pivot points.
- Bone proportions.
- Draw order.
- Expected animations.

The risk is that the model looks like a costume stretched over another character's anatomy. It is most useful as a fast prototype to prove the Godot/Spine import chain, not as the final Hologirl model unless the borrowed skeleton is very close to the desired pose and proportions.

If used, do it as an explicit prototype branch or archived experiment, not as hidden production behavior.

## Open Questions

- Does the installed STS2/Godot export pipeline accept `.spine-json` with the same reliability as `.skel`, or should Hologirl only ship binary `.skel` like vanilla? A first raw `.atlas` plus `.json` proof failed in the current headless export environment; see `docs/design/experiments/spine-single-attachment-proof/`.
- Which animation names are actually invoked by STS2's current player visual controller?
- Can rest-site and merchant scenes reuse the same `SpineSprite` resource with different animation starts, or do they need separate scenes for reliable playback?
- Should Hologirl source `.spine` files be committed, archived outside the mod package, or excluded from the shipped release once the licensing/export workflow is confirmed?

## Importer Investigation - 2026-05-17

STS2's packed assets include `res://addons/spine/spine_godot_extension.gdextension`, but the native editor/importer libraries referenced by that descriptor are not present inside the extracted PCK paths checked so far.

The local STS2 install exposes `libspine_godot.linux.template_release.x86_64.so`, which is enough evidence that the game runtime uses the Spine Godot extension. It was not enough to make the mod's headless export project import raw Spine resources:

- Copying the `.gdextension` descriptor into a local ignored `addons/spine/` folder did make Godot see the extension descriptor.
- Symlinking the available template release library as the expected editor/debug/release library names still did not register the Spine importers.
- The export still logged `No loader found for resource` for the proof `.atlas` and `.json` resources.

Confirmed next steps:

- Find or build the matching `spine-godot` editor extension/import plugin for the Godot version used by STS2.
- Once the importer exists locally, test whether committed `.skel`, `.atlas`, `.png`, `.import`, `.tres`, and `.tscn` files export cleanly in this repo.
- If the editor importer remains unavailable, the operator will need to provide Spine-exported binary assets from an environment where the plugin is installed.

Follow-up result:

- Official public `spine-godot` artifacts exist for Spine branch `4.2` and Godot `4.5.1-stable` at `https://spine-godot.s3.amazonaws.com/4.2/4.5.1-stable/spine-godot-extension-4.2-4.5.1-stable.zip`.
- Installing that package locally under ignored `addons/spine/` makes the headless Godot project recognize `SpineSprite`, `SpineSkeletonDataResource`, `SpineSkeletonFileResource`, and `SpineAtlasResource`.
- On a clean local addon install, run a headless editor scan once so Godot writes `.godot/extension_list.cfg`; otherwise `--script` runs may not load the GDExtension and will report the Spine classes as missing.
- The local addon is an export/editor aid only. `export_presets.cfg` excludes `addons/*` so Hologirl does not ship another Spine extension inside its PCK. Remove it before normal package/release runs unless actively testing Spine, because the GDExtension crashed headless Godot on shutdown after export on this machine.
- Raw `.atlas` and `.spine-json` files are not enough by themselves. They need Godot `.import` remaps to generated `.spatlas` and `.spjson` files, matching the layout used by `STS2-Buu` and official `spine-godot` examples. JSON skeletons must use `importer="spine.json"`; `importer="spine.skel"` is only for binary `.skel`.
- A temporary proof loaded successfully after manually providing `.atlas.import`, `.spine-json.import`, copied `.spatlas/.spjson` generated targets, `SpineSkeletonDataResource`, and a `SpineSprite` scene.
- A multipart proof with separate rough body-part attachments now loads through the same path. It proves that a self-authored `.spine-json` skeleton is viable for early iteration, but it is not production-ready animation.

Practical implication:

- The final Hologirl model can use the vanilla `SpineSprite` path without waiting for a full local Spine Editor install, but source assets still need to be exported from Spine-compatible data. Binary `.skel` remains preferred over JSON because vanilla and the current working STS2 character reference both use `.skel`.
