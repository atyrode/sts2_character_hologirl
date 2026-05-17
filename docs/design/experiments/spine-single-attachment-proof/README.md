# Hologirl Spine Proof - Single Attachment

This folder archives an experiment to verify whether Hologirl can load a self-authored Spine skeleton through Godot's `SpineSprite` path before a full Spine Editor rig exists.

Proof shape:

- `hologirl_spine_proof.png`: not archived here; it was a copy of `Hologirl/images/character/hologirl_runtime.png`.
- `hologirl_spine_proof.atlas`: minimal Spine atlas text for that attachment.
- `hologirl_spine_proof.json`: minimal Spine JSON skeleton with one attachment and a simple `idle` animation.
- `hologirl_spine_proof_skel_data.tres`: Godot `SpineSkeletonDataResource`.
- `hologirl_spine_proof_node.tscn`: `SpineSprite` scene for import/instancing tests.

Result on 2026-05-17:

- `scripts/package.sh` completed, but Godot logged `No loader found for resource` for `hologirl_spine_proof.atlas` as `SpineAtlasResource`.
- Godot also logged `No loader found for resource` for `hologirl_spine_proof.json` as `SpineSkeletonFileResource`.
- `SpineSkeletonDataResource` could not be instantiated in the headless export project.
- Only the PNG was imported normally.

Conclusion:

- Do not route gameplay to this proof.
- The repo's current headless export environment does not turn raw `.atlas` plus `.json` Spine source files into usable Spine resources by itself.
- The next viable path is either a real Spine/Godot import workflow that produces `.skel`/`.atlas.import` resources like vanilla/current working mods, or locating the exact importer/plugin setup those mods used.
- The final goal remains separated body-part art and a real Spine rig.
