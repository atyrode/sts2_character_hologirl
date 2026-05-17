# Hologirl Animation Source

This folder holds source material for the future side-facing Hologirl Spine model. Runtime assets should eventually live under `Hologirl/animation/binary/` and be loaded through `SpineSprite`; files here are authoring inputs and references.

Current direction:

- First create a side-facing combat reference that matches the character-select design.
- Then split or regenerate that design into separated transparent parts for rigging: torso, head, hair pieces, upper/lower arms, hands, legs, boots, whip pieces, and shadow.
- Keep source attempts archived by folder so visual decisions are traceable.
- Do not route gameplay scenes directly to files in this source folder.

The confirmed runtime pipeline is documented in `docs/design/SPINE_CHARACTER_PIPELINE.md`.
