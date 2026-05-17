# Attempt 002 - Body Parts Source Sheet

Generated on 2026-05-17 as the first source-art pass for a real Spine-style Hologirl rig.

Files:

- `body-parts-chroma.png`: original generated sheet on flat magenta chroma key.
- `body-parts-transparent.png`: ImageMagick chroma-key removal output with transparent corners.
- `parts-candidates/`: first mechanical crops from the transparent sheet, named by intended rig part.
- `parts-candidates-overview.png`: quick review montage of those crops.
- `prompt.md`: prompt used for the generated sheet.

Use this as rigging source/reference, not as shipped runtime art. The sheet is useful because it separates the head, hair, torso, limbs, hands, boots, whip, and shadow into non-overlapping parts. It is still not a finished rig: individual parts need to be extracted into separate transparent PNGs, assigned pivots, and exported through Spine-compatible `.skel/.atlas` assets before it can replace the temporary full-body runtime PNG.

The candidate crops are intentionally rough. Some edges still have magenta fringe from chroma-key removal, and the whip candidates are long curved pieces rather than final bone-length segments. Clean them before final atlas packing.
