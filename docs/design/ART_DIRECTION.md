# Art Direction

Hologirl card art should target a simple Slay the Spire 2-inspired starter-card read: bold shapes, low detail, matte texture, and instant recognition at small card size.

Use `docs/design/STS_STYLE_RESEARCH.md` as the shared reference for Slay the Spire style language, especially when generating character-select layers.

## High-Level Rules

- Use one dominant object, action, or silhouette per card.
- Prefer flat chunky shapes, hard graphic edges, abrupt silhouettes, broad shadow shapes, and smooth matte shading.
- Use selective hard shadow planes, almost like partial cel shading, where they clarify form. Do not turn the whole image into clean anime cel shading.
- Keep the palette tight, usually 2-4 major color groups.
- Use elegant desaturated pink and deep plum backgrounds for the base starter-card family unless a card document says otherwise.
- Hologirl herself is blue/cyan hologram light.
- Yellow/gold is reserved for Hologirl-created or projected elements: light-whip, shields, spotlights, light sticks, monitor glow, projected UI, and holographic effects.
- Use tiny restrained sparkles only when they clarify magic or holographic technology.
- Avoid detailed fantasy illustration, photorealism, anime screenshot styling, glossy mobile-game rendering, dense particles, complex backgrounds, text, card frames, UI, and logos.

## Base Hologirl Visual Identity

Hologirl should read as a blue/cyan hologram girl with two long ponytails/twintails. When her head or hair is visible, the two-ponytail silhouette must remain clear.

Starter cards should usually prioritize the tool or action over a full character portrait. Hologirl can appear as a small silhouette, cropped hand, or supporting detail when the card needs her.

## Character Select Background Anchor

`Signal Bloom` from character-select background attempt 029 is the validated style anchor for Hologirl's menu background language. It matches the vanilla character-select vibe because it uses a bright single-hue field, two close value variants, broad cropped hand-painted motifs, very sparse highlight marks, and no clean geometric construction.

The reusable background prompt recipe is:

Slay the Spire 2-inspired character-select background plate, wide horizontal game UI background, no character. Bright solid accent field with only two close same-hue variants. Large hand-painted broadcast-wave, stage-light, signal, or hologram-drift silhouettes enter from offscreen and are cropped by the image edges. Leave center-left readable for UI. Use broad uneven brush edges, asymmetrical composition, simple graphic readability, matte flat color masses, and sparse highlights. Avoid clean SVG geometry, perfect arcs, centered icons, repeated patterns, detailed scenes, texture-heavy painting, realistic lighting, smoky effects, glossy glow, many colors, UI text, logos, and characters.

Signal Bloom itself is not automatically the final palette. Its cyan is a strong style proof, but it can blend into Hologirl's blue body and overlap Defect's accent identity. Use the same motif language to test warmer or off-cyan accent candidates.

## UI Asset Direction

Near-term non-portrait assets still need a dedicated pass:

- Card frame/color treatment should move away from template defaults toward Hologirl's chosen periwinkle/accent direction.
- Energy symbol direction is selected: a simple periwinkle hexagonal orb/gem, derived from `docs/design/art_archive/ui/energy_symbol/batch-2026-05-15-simple-vanilla/variant-005/`. It should stay closer to vanilla STS2 resource gems than to a detailed hologram logo.
- Remaining placeholder UI assets need review: character icon, map marker, locked portrait, energy text, relic placeholder, power placeholder, and mod image.

Use the same compatibility rule as code: prefer local asset replacement over broad UI patching. If card color changes require hooks or shared UI changes, document that risk before implementation.

## Reusable Prompt Pattern

Simple STS2-inspired card portrait, one bold readable [attack/defense/skill] image. [One dominant object/action] across an elegant desaturated pink and deep plum background. The subject is the main shape: thick, smooth, graphic, hard-edged, with minimal glow, one or two white-hot highlight cuts, and a few tiny restrained sparkles implying magic or holographic technology. Flat chunky shapes, low color count, abrupt silhouettes, smooth matte shading, broad background shadow shapes, iconic card readability. No text, no card frame, no UI, no logo.

## Negative Prompt Pattern

Detailed fantasy illustration, photorealism, anime screenshot, glossy mobile-game rendering, complex background, cinematic close-up, many colors, realistic object render, dense particle effects, elaborate costume, readable text, card frame, UI, logo.

## Workflow Rule

Before generating or adding card art, check `docs/design/ASSET_PIPELINE.md` and the specific card document. Generated art must be usable at `1000x760` for big portraits and `250x190` for small portraits.
