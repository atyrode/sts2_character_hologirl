# Energy Symbol Batch: Simple Vanilla Direction

Generated on 2026-05-15 as individual imagegen calls, not as one contact sheet.

## Vanilla Energy Symbol Analysis

Local source inspected: extracted STS2 assets under `/tmp/sts2_extract_probe`.

Confirmed references:

- Card-text energy icons live at `images/packed/sprite_fonts/*_energy_icon.png`.
- The visible vanilla examples available from the extracted PNGs are 24x24.
- Larger combat energy counters live under `images/ui/combat/energy_counters/<character>/` as 256x256 layered PNGs.

Observed style:

- The tiny energy icon is a resource gem/orb, not a full emblem.
- Shape identity matters more than internal detail.
- The palette is narrow: one dominant character hue, one darker shadow, one lighter highlight, and a dark outline.
- The outline is chunky and slightly uneven.
- Highlights are broad and readable, not many tiny sparkles.
- The larger counter art can have multiple layers, but the base read is still a flat, bold silhouette.

## Prompt Direction

For Hologirl, the energy symbol should be closer to a simple periwinkle orb/gem than a hologram logo. Hologram identity should be restrained: a cyan shine, a small broken edge, a subtle cut corner, or a tiny gold accent only if it still reads at 24x24.

Avoid:

- Sheets or grouped variants.
- Card frames.
- Complex prism facets.
- Character silhouettes.
- Projector beams.
- Many sparkles.
- Large gold rings or full light-whip shapes.
- Glossy mobile-game orb rendering.

## Variants

- `variant-001`: rounded octagonal periwinkle gem with tiny gold glint.
- `variant-002`: simple round periwinkle orb with one broken hologram chip.
- `variant-003`: soft diamond-gem orb inside rough circular outline.
- `variant-004`: round orb with subtle stepped hologram edge.
- `variant-005`: minimal hexagonal periwinkle orb, no gold. Selected and implemented as the runtime energy symbol in `Hologirl/images/charui/big_energy.png` and `Hologirl/images/charui/text_energy.png`.
- `variant-006`: round orb with small internal crescent shine, no gold.
- `variant-007`: asymmetrical octagonal orb with diagonal cyan reflection.
- `variant-008`: orb with tiny internal gold light-whip crescent.
- `variant-009`: rounded-square clipped-corner gem, no gold.
- `variant-010`: teardrop/seed-shaped hologram orb, no gold.
- `variant-011`: rough circle with darker crescent shadow, no gold.
- `variant-012`: orb with small flat-top cut and bottom shadow band, no gold.
