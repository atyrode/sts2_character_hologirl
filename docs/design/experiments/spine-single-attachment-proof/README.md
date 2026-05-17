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

Second attempt:

- Extracted STS2's `addons/spine/spine_godot_extension.gdextension` from the packed game assets with `scripts/extract-pck-path.gd`.
- Created a local ignored `addons/spine/` folder for importer experiments.
- Symlinked the locally installed STS2 runtime library as the expected Linux editor/debug/release Spine extension names.
- Godot saw the descriptor, but still did not register loaders for `.atlas` or `.json`.

Third attempt:

- Downloaded the official public `spine-godot` extension package for Spine branch `4.2` and Godot `4.5.1-stable`.
- Installed it locally under ignored `addons/spine/`.
- Confirmed with `scripts/check-spine-extension.gd` that Godot recognized the Spine classes.
- Renamed the proof skeleton copy to `.spine-json`, because plain `.json` is handled as ordinary Godot JSON and not as a Spine skeleton file.
- Added temporary `.atlas.import` and `.spine-json.import` remaps and copied the generated targets manually as `.spatlas` and `.spjson`.
- The proof then loaded as `SpineAtlasResource`, `SpineSkeletonFileResource`, `SpineSkeletonDataResource`, and `PackedScene`.

Conclusion:

- Do not route gameplay to this proof.
- The repo's current headless export environment does not turn raw `.atlas` plus `.json` Spine source files into usable Spine resources by itself.
- The headless project can load Spine resources when a local-only spine-godot extension is present and the assets have the same `.import` remaps and generated `.spatlas/.spskel` or `.spjson` targets used by working mods.
- The next viable path is producing a real Hologirl `.skel`/`.atlas` export and generating or copying the matching import remaps.
- The final goal remains separated body-part art and a real Spine rig.
