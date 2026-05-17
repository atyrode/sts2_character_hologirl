# Hologirl Spine Proof - Multipart Idle

This folder archives the first hand-authored multipart Spine proof for Hologirl.

Goal:

- Use the extracted body-part candidate PNGs as separate Spine attachments.
- Keep the proof source-controlled and isolated from runtime until it is proven stable.
- Validate whether we can author a simple `.spine-json` skeleton ourselves before requiring Spine Editor or another DCC tool.

Contents:

- `images/`: rough extracted body-part candidate PNGs copied from the art archive.
- `hologirl_multipart.atlas`: one-page-per-image Spine atlas text.
- `hologirl_multipart.spine-json`: hand-authored skeleton with separate slots for the head, hair, torso, arms, legs, whip, and shadow.
- `hologirl_multipart_skel_data.tres`: Godot `SpineSkeletonDataResource` that points at the atlas and skeleton source.
- `hologirl_multipart_node.tscn`: minimal `SpineSprite` scene for loader tests.

Result on 2026-05-17:

- The hand-authored multipart `.spine-json` is valid JSON.
- With the official local-only `spine-godot` addon installed under ignored `addons/spine/`, Godot did not initially register the Spine classes until the editor scan generated `.godot/extension_list.cfg`.
- After that scan, `scripts/check-spine-extension.gd` confirmed `SpineSprite`, `SpineSkeletonDataResource`, `SpineSkeletonFileResource`, and `SpineAtlasResource`.
- The atlas, skeleton file, skeleton data resource, and `SpineSprite` scene all loaded successfully.

Current status:

- This is a proof rig, not final animation work.
- The art crops still have rough edges and magenta fringe from the extraction source.
- The skeleton positions are approximate; their purpose is to test the pipeline and expose how far a self-authored rig can go.
- The local `spine-godot` addon is still required for headless loader verification, and must remain untracked.

The next pass should improve pivots and attachment ordering before wiring any Spine scene into Hologirl's runtime combat visual.
