# Slay the Spire Style Research

## Sources

- Mega Crit / Steam community announcement, `Marlowe Dobbe x Mega Crit`, 2024-10-02:
  `https://store.steampowered.com/news/posts/?appids=646570&enddate=1733946743&feed=steam_community_announcements`
- PCGamesN summary of the same Mega Crit art-direction update, 2024-10-03:
  `https://www.pcgamesn.com/slay-the-spire-2/art-direction`
- Reddit community discussion, useful only as player perception, not source of truth:
  `https://www.reddit.com/r/slaythespire/comments/1fypb9e/what_are_your_thoughts_on_the_artstyle_of_sts2/`
- Local recovered STS2 assets from `/home/alex/games/slay-the-spire-2/SlayTheSpire2.pck`, especially:
  - `/tmp/sts2-character-select-recovered/images/packed/character_select/char_select_*.png`
  - `/tmp/sts2-character-select-recovered/animations/character_select/**`

## Confirmed STS2 Direction

Mega Crit describes the sequel's visual changes as:

- More playful while retaining dark themes.
- More crisp, with creatures, items, cards, and backgrounds less painterly.
- Livelier through more animations and transitions.
- More cinematic with more whole-screen art.
- More colorful, partly for screen legibility.

Marlowe Dobbe describes the target as still recognizable as Slay the Spire, with the team dissecting STS1's creepy-but-fun energy. The official notes call out weird-enough monsters, hidden faces, playfulness, creativity, expressiveness, and clear concise small drawings.

Interpretation for Hologirl: STS2 is not asking for high-rendered fantasy key art. It is STS1's rough, strange, immediately readable language made cleaner, brighter, more animated, and more screen-filling.

## STS1 Baseline

STS1 remains important because STS2 is explicitly keeping the world recognizable. STS1's charm comes from:

- Simple hand-drawn readability.
- Rough, sometimes awkward silhouettes.
- Strange, creepy, playful creature design.
- Low animation complexity.
- Broad, readable value blocks over polished anatomy or rendering.

For Hologirl, STS1 is useful as a brake against polished anime. If a result looks like a high-quality VTuber key visual, it has drifted away from the Spire language even if it is beautiful.

## Character Select Asset Analysis

Official STS2 character-select button portraits are `132x195`. They have a stronger lesson than the full splash atlases because the intended read is compressed.

Observed traits:

- Huge head/upper-body silhouette fills the frame.
- One dominant identity shape: Ironclad horn/helm, Silent skull mask, Defect round head/orb, Regent horn, Necrobinder skull.
- Very small number of shape groups.
- Thick dark contour shadows and hard edge separation.
- Flat saturated background color.
- Limited facial detail. Faces are graphic icons, not rendered portraits.
- Surfaces use a few broad shadow/highlight planes, not smooth blended realism.
- Many forms use selective hard shadow planes that behave like partial cel shading: abrupt shadow cuts on cheeks, cloth, horns, skulls, and hair masses. This is not full anime cel shading across every surface; it is targeted value-blocking for readability.
- The art is allowed to be weird, lumpy, asymmetrical, and mask-like.

Large character-select assets use layered atlases and backgrounds, not a single fully-rendered illustration. The backgrounds are simple broad plates, while the character reads through modular shape layers.

## Prompt Rules For Hologirl Cutouts

Use these rules for character-select layer generation:

- Preserve composition and identity: blue/cyan hologram twin-tail girl plus golden light-whip.
- Make the silhouette iconic before making the face pretty.
- Use chunky, uneven, graphic shapes.
- Use 3-5 large value/color planes per body part.
- Use selective cel-shaded shadow cuts only where they clarify form; avoid fully cel-shading every surface.
- Prefer dark cyan edge cuts and hard shadow shapes over soft shading.
- Simplify face to a few graphic marks; avoid anime eye rendering.
- Simplify outfit to readable blocks: collar, torso, skirt, gloves, boots. Avoid tiny costume detail.
- Treat hair as two big readable mass shapes with internal cuts, not many flowing strands.
- Treat the whip as one bold golden graphic ribbon with sparse square sparks.
- Use matte texture and brush/grain, not glow-heavy polish.

Avoid:

- Photorealism, glossy fantasy splash rendering, smooth airbrush gradients.
- Clean anime key art, VTuber model-sheet polish, detailed eyes, tiny costume trim.
- Detailed attractive face rendering as the focal point.
- Complex glow fields, dense particles, many small highlights.
- Perfectly elegant proportions that erase the odd handmade Spire feeling.

## Hologirl Attempt Notes

- `attempt-001`: good design and pose, but too polished/anime-clean and too highly rendered.
- `attempt-002`: better simplified shapes, still too cute/clean; face and body remain closer to anime key art than STS2.
- `attempt-003`: stronger STS language with thick contours, simplified face, bigger icon silhouette, but slightly too rough.
- `attempt-004`: stronger action pose and hologram drift, but the whip geometry was impossible and the image remained too distant/detailed.
- `attempt-005`: closer and more dominant, with improved whip geometry, but still too clean/anime and not expressionless enough for base Hologirl.
- `attempt-006`: new base-form target: expressionless combat-hologram girl, eyes-only face, rougher crayon texture, selective hard shadow planes, and stronger blank-projection identity.
- Next target: combine `attempt-006`'s expressionless base-hologram identity with controlled whip geometry and enough rough crayon texture to avoid clean anime polish.
