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

## Reusable Prompt Pattern

Simple STS2-inspired card portrait, one bold readable [attack/defense/skill] image. [One dominant object/action] across an elegant desaturated pink and deep plum background. The subject is the main shape: thick, smooth, graphic, hard-edged, with minimal glow, one or two white-hot highlight cuts, and a few tiny restrained sparkles implying magic or holographic technology. Flat chunky shapes, low color count, abrupt silhouettes, smooth matte shading, broad background shadow shapes, iconic card readability. No text, no card frame, no UI, no logo.

## Negative Prompt Pattern

Detailed fantasy illustration, photorealism, anime screenshot, glossy mobile-game rendering, complex background, cinematic close-up, many colors, realistic object render, dense particle effects, elaborate costume, readable text, card frame, UI, logo.

## Workflow Rule

Before generating or adding card art, check `docs/design/ASSET_PIPELINE.md` and the specific card document. Generated art must be usable at `1000x760` for big portraits and `250x190` for small portraits.
