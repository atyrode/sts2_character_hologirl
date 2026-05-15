# Layered Puppet Attempt 002

Generated on 2026-05-15 as a cleaner rig-sheet attempt after `layered_puppet_attempt-001`.

This attempt is designed for automatic connected-component splitting: the source sheet uses a green chroma-key background and separates the body parts with padding.

The generated split layers are under `layers/`. They are an experiment only and are not wired into runtime assets.

Validation:

- `scripts/split-chroma-layer-sheet.py` extracted `19` transparent connected-component PNGs from `result.png`.
- `preview/layered_puppet_attempt_002_preview.tscn` assembles the main parts into a rough puppet with tiny rotation animation.
- `scripts/godot-smoke-layered-puppet-preview.gd` loads the preview scene and verifies each assembled part has a texture.

Assessment:

- This is closer to a viable path than cutting up finished character art after the fact.
- It still needs manual art direction before becoming runtime quality: the assembled pose is approximate, pivots are guessed, some part proportions do not match a final full-body pose, and the hand/handle/whip relationship needs cleaner separation.
