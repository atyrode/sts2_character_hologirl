# Design Direction

Detailed design notes now live under `docs/design/`.

- `docs/design/ART_DIRECTION.md` is the source of truth for AI art style and color rules.
- `docs/design/ASSET_PIPELINE.md` documents card portrait sizes and naming.
- `docs/design/GAMEPLAY_IDENTITY.md` documents the current combat fantasy and starter kit.
- `docs/design/TERMINOLOGY.md` documents `Fans`, `Singing`, `Shapeshift`, `Idol Form`, and `Prism Pendant`.
- `docs/design/cards/`, `docs/design/forms/`, `docs/design/effects/`, and `docs/design/relics/` hold per-item notes.

The notes below are retained as a working overview until each section is fully migrated.

## Combat Fantasy

Hologirl is a ghostly hologram performer who builds an audience, then uses that audience's support to sustain temporary idol transformations.

The baseline form is the original Hologirl: a simple, ghostly hologram girl. Her distinctive resource is `Fans`, representing the crowd forming around her. Visually, the long-term goal is to show fans stacking discreetly on the far left/back of the combat scene, like a crowd forming behind the action.

## Core Mechanical Idea

Hologirl can shift from her base hologram form into idol-inspired stances/forms:

- Ceres Fauna
- Amelia Watson
- Gawr Gura
- Ouro Kronii

The stance loop:

- Gain `Fans`.
- Use `Livestream` to turn explicit combat triggers into more `Fans`.
- Spend or preserve audience momentum through cards.
- Shapeshift and Idol Forms are deferred prototype ideas, not active shipped mechanics.

The exact benefits of having more fans are still being refined. v0.4.1 spends Fans directly, but v0.4.2 should test more distinctive Livestream decisions rather than only bigger numbers.

## Starter Kit Direction

Initial starter deck direction:

- 4 `Strike` cards.
- 4 `Defend` cards.
- 2 `Concert!`

## Weapon Direction

Hologirl's baseline weapon should be a light-whip: a flexible lash made from faint yellow holographic light.

Starter card art should stay simple and iconic. `Strike` should mostly show the weapon in motion, with Hologirl only as a small or blurred supporting detail if needed. The composition should read as a basic attack at card size: a clean arc of yellow light cutting through the air, minimal background, strong silhouette, and restrained effects.

The same weapon can support future animation: idle state with the light-whip loosely trailing or resting on the ground, attack state with a fast snapping lash.

## Runtime Character Visual

For v0.4.3, Hologirl starts with a Hologirl-owned pure Godot runtime visual instead of routing combat, merchant, and rest-site scenes through Ironclad. The first pass uses a full-body transparent sprite with a grounded golden light-whip and a simple idle bob/breathing script.

This is a pragmatic first rig, not the final animation target. Vanilla-quality STS2 characters use Spine-backed Godot scenes; Hologirl can move to Spine or a better separated-parts rig later after the scene contract and art direction are stable.

## AI Card Art Direction

When generating placeholder or production card art with AI, use the recovered STS2 starter cards as the style target rather than broad fantasy concept art.

The current accepted starter-card direction came from comparing recovered local STS2 Strike references:

- `strike_ironclad`: one huge flat sword shape over a red/orange field.
- `strike_defect`: cropped chunky fist, broad impact shape, very low detail.
- `strike_silent`: one diagonal dagger shape, hard black silhouette and simple red background.
- `strike_regent`: glowing weapon shapes on a pink/purple field, still very icon-like.
- `strike_necrobinder`: one scythe shape and one large cyan impact field.

The useful lesson is not to ask for "beautiful fantasy card art." Ask for an icon-like card portrait with one dominant object/action, broad flat shapes, and almost no scene.

Baseline prompt grammar:

- Simple STS2-inspired card portrait.
- Generate or prepare art for the documented template formats before adding it to the mod:
  - big card portrait: `1000x760`
  - small card portrait: `250x190`
- One bold readable object or action shape.
- Flat chunky shapes, abrupt silhouettes, smooth matte shading.
- Low color count, usually 2-4 major color groups.
- Broad background shadow shapes, not a detailed scene.
- Hard graphic edges, minimal glow, very sparse sparkles only where they clarify magic/technology.
- Main subject first, Hologirl second; starter cards should rarely show a full character.
- Elegant desaturated pink or red-pink backgrounds are preferred for Hologirl starter cards.
- Base Hologirl herself should read as blue/cyan hologram light that complements the chosen desaturated pink backgrounds, not gold.
- Base Hologirl's silhouette has two long ponytails/twintails, Hatsune Miku-like in broad read, and this should remain recognizable whenever her head/hair is visible.
- Yellow/gold is reserved for things Hologirl creates or projects: her light-whip, shield constructs, stage spotlights, light sticks, and other holographic tools/effects.

Card art workflow rule:

- Before generating a card, check this section and the specific prompt direction below.
- Before adding art to the mod, verify the source can be cropped or resized cleanly to `1000x760`; portrait/tall generations should be regenerated in landscape format instead of blindly cropped.
- Add both `Hologirl/images/card_portraits/big/<card_id>.png` at `1000x760` and `Hologirl/images/card_portraits/<card_id>.png` at `250x190`.

Avoid:

- Detailed fantasy illustration.
- Photorealism.
- Anime screenshot styling.
- Glossy mobile-game rendering.
- Complex backgrounds.
- Particle-heavy effects.
- Many colors.
- Cinematic close-ups that obscure the icon-like read.

Final reusable prompt pattern:

> Simple STS2-inspired card portrait, one bold readable [attack/defense/skill] image. [One dominant object/action] across an elegant desaturated pink background. The subject is the main shape: thick, smooth, graphic, hard-edged, with minimal glow, one or two white-hot highlight cuts, and a few tiny restrained sparkles implying magic or holographic technology. No full character; at most a tiny cropped dark hand, wrist, handle, or silhouette detail at one edge. Flat chunky shapes, low color count, abrupt silhouettes, smooth matte shading, broad background shadow shapes, iconic starter-card readability. No scene, no detailed costume, no particle cloud, no text, no card frame, no UI, no logo.

Negative prompt pattern:

> detailed fantasy illustration, photorealism, anime screenshot, glossy mobile-game rendering, complex background, cinematic close-up, many colors, realistic object render, dense particle effects, full character portrait, elaborate costume

`Strike` prompt direction:

> Simple STS2-inspired card portrait, one bold readable starter attack image. A faint yellow holographic light-whip slashes diagonally across an elegant desaturated pink background. The whip is the main subject: a thick smooth curved band of warm yellow light with a few angular breaks, hard graphic edges, minimal glow, one or two white-hot highlight cuts, and a few tiny restrained sparkles implying magic or holographic technology. No full character; only a tiny cropped dark hand or simple handle implied at one edge. Flat chunky shapes, low color count, abrupt silhouettes, smooth matte shading, broad background shadow shapes, iconic starter attack readability. No scene, no detailed costume, no text, no card frame, no UI, no logo.

`Defend` prompt direction:

> Simple STS2-inspired card portrait, one bold readable starter defense image. A faint yellow holographic shield flashes into existence at a diagonal angle, made of one large chunky translucent shield shape with two or three angular pane divisions. The shield is the main subject, pale yellow with small cyan edge accents, hard graphic edges, minimal glow, and a few tiny restrained sparkles implying magic or holographic technology. A tiny cropped dark hand or wrist is barely implied behind it, no full character. Elegant desaturated pink background with broad flat shadow shapes. Flat chunky shapes, low color count, abrupt silhouettes, smooth matte shading, iconic starter defense readability. No scene, no detailed costume, no text, no card frame, no UI, no logo.

`Concert!` prompt direction:

> Simple STS2-inspired card portrait in a wide landscape card-art composition, one bold readable skill image. View from behind a small blue/cyan hologram idol girl silhouette standing on a stage, facing a dark crowd. A warm pale-yellow spotlight shines down on her and creates one clear cone of light. In front of her, beyond the stage edge, the crowd is represented as broad dark rounded silhouettes with many tiny simple light sticks glowing pale yellow and a few soft cyan accents. Elegant desaturated pink and deep plum background, broad flat shadow shapes, low color count, hard graphic edges, smooth matte shading, minimal glow, very sparse sparkles implying holographic performance technology. Iconic concert readability at small card size. No detailed faces, no detailed audience, no full scene complexity, no text, no card frame, no UI, no logo.

`Livestream` prompt direction:

> Simple STS2-inspired card portrait in a wide landscape card-art composition, one bold readable skill image. Cozy intimate streamer-at-home scene: Hologirl is medium-large in frame, seen in clean side profile at her desk, wearing a headset and facing a computer monitor that is also shown from the side so their angles match. The image should feel like a close, comfortable look into her room while she streams to her fans, not a concert or crowd scene. Keep Hologirl as blue/cyan hologram light with her established twin-ponytail silhouette readable where visible. The desk, chair, and monitor are simplified chunky shapes, close to the camera, minimal and icon-like. Gold/yellow is reserved for the monitor glow, projected UI accents, and tiny holographic effects. Elegant desaturated pink and deep plum room/background, broad flat shadow shapes, low color count, hard graphic edges, smooth matte shading, minimal glow, very sparse sparkles implying holographic technology. Horizontal `1000x760` style card portrait composition. No crowd, no fans in the background, no light-stick audience, no detailed face, no detailed room clutter, no text, no readable UI, no card frame, no logo.

### Concert!

Initial concept:

- Cost: 1
- Gain 3 `Fans`.
- Gain `Singing` for 2 turns.

`Singing` means Hologirl does not lose fans while singing.

### Livestream

Initial concept:

- Cost: 2
- Rare Power.
- Gain `Livestream`.
- While active, using a Potion, fully blocking an attack, healing, applying a debuff, or dealing a large unblocked hit generates `Fans`.

Longer-term visual direction: render a transparent live-stream chat overlay in combat, with colored pseudonyms and action-specific chat reactions. See `docs/design/cards/draftable/LIVESTREAM.md` for the confirmed design notes and open UI questions.

## Starting Relic Direction

The starting relic is currently a placeholder and should be revisited.

Current concept:

- Theme: hologram projection, live-audience focus, or a future rebuilt Shapeshift system.
- The old form-specific 0-cost reward-card behavior is removed from the active source set.
- The relic text should not advertise disabled Shapeshift behavior.

The exact relic name, stats, icon, and form-card behavior are undecided.

## Term Dictionary

- `Fans`: Hologirl's audience resource. Fans decay by half at end of turn unless Hologirl is Singing.
- `Singing`: temporary protection from normal Fan decay.
- `Livestream`: Hologirl's signature power. It starts the chat overlay and gains Fans from explicitly listed combat events.
- `Shapeshift`: deferred prototype mechanic, not part of the active card pool.
- `Idol Form`: deferred prototype form concept.
- `Prism Pendant`: starter relic placeholder. Its old form reward cards are removed until the relic is redesigned.

## Mod Compatibility Policy

Hologirl should aim to be highly compatible with other mods.

- Prefer local card, power, relic, and character behavior over global hooks or patches.
- Avoid custom enum entries, shared keyword registration, global description overrides, and broad Harmony patches unless there is a concrete need and the collision risk is documented.
- Prefix all custom ids, localization keys, assets, and generated concepts with the mod namespace already used by the template (`HOLOGIRL` / `Hologirl`).
- Keep manifest fields compatible with the user's current game build and mod manager. In particular, `dependencies` currently uses the string-list schema expected by STS2 `v0.103.2`.
- If a future feature needs global behavior, document why it is needed, what it touches, and how it avoids colliding with other mods before implementing it.

## Open Questions

- What should `Fans` do besides simple number scaling?
- Should Fan decay stay half-per-turn once more interesting Livestream mechanics exist?
- How should fan loss be shown clearly enough that the player can predict it?
- Does `Singing` only preserve Fans, or should it affect Livestream/chat requests?
- Is Shapeshift random among all forms, random among unlocked/available forms, or influenced by cards?
- What does each idol form do mechanically?
- Should forms behave like STS stances, Defect-style orb slots, powers, or a custom player state?
- Should `Chat Request` and `Clip` become real mechanics for v0.4.2?
- How much Hololive-specific naming/art should remain in a public release?
