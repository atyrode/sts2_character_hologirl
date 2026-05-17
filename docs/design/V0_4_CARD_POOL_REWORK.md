# v0.4 Card Pool Rework

## Goal

`v0.4` should move Hologirl from a proof-of-function card pool to a small playable identity. The existing non-starter draftable cards currently mostly repeat starter effects at different rates. This pass should give every non-starter card a distinct purpose, update card text and docs, and replace placeholder/reused art with Hologirl-specific art in one coherent style.

## Confirmed Direction

- Reduce Livestream chat replies between chatters. Replies should feel occasional, not constant.
- Starter deck remains:
  - 4 `Strike`
  - 4 `Defend`
  - 1 `Concert!`
  - 1 temporary `Livestream` testing card until Livestream no longer needs immediate combat access.
- `Strike` art should use a red-leaning background.
- `Defend` art should use a bluer background.
- `Concert!` and `Livestream` art should be regenerated to use the current Hologirl character design, not the older design.
- Non-starter draftable cards need unique art in the same general style as the starter deck.
- Non-starter draftable cards need more interesting mechanics that advance Hologirl's identity instead of repeating `Strike`, `Defend`, `Concert!`, or `Livestream`.

## Mechanical Pillars

Near-term card designs should mostly interact with these existing systems:

- `Fans`: audience resource, currently a power.
- `Singing`: temporary preservation of Fans.
- `Livestream`: hype triggers that generate Fans and visual chat reactions.
- `Shapeshift`: form direction exists, but explicit form-entry cards still need careful design before expanding.
- `Prism Pendant`: form reward cards on Shapeshift.

Avoid adding a new global resource, new custom enum, or broad patch unless a card design cannot work within the current BaseLib/Core action model.

## Current Draftable Pool To Rework

Common:

- `Signal Jab`: small attack that gains extra `Fans` while `Singing`.
- `Fan Meetup`: defensive `Fans` card with a small `Livestream` bonus.
- `Broadcast Loop`: common passive `Fans` power with an immediate no-audience starter bonus.

Uncommon:

- `Lightwhip Flourish`: multi-hit attack with a modest `Fans` gain.
- `Glitch Waltz`: defensive `Singing` card that rewards already being `Singing`.
- `Encore Engine`: setup power that combines `Broadcast Loop` with immediate `Singing`.

Rare:

- `Radiant Whip`: large hit that converts current `Singing` into `Fans`.
- `Viral Moment`: `Fans` spike that adds `Singing` during `Livestream`.
- `Prime Time`: capstone power combining `Broadcast Loop` and `Livestream`.
- `Livestream` is already a real rare power and should remain the anchor card, though its art may be regenerated to match current Hologirl.

## Art Direction For This Pass

Use the starter-card style language recorded in `docs/design/ART_DIRECTION.md`:

- bold readable shape;
- low detail;
- matte texture;
- tight palette;
- one dominant object/action;
- no UI text, logos, card frame, or dense background.

Specific palette anchors:

- `Strike`: red/dark rose background, gold light-whip action, Hologirl as blue/cyan projection.
- `Defend`: blue/periwinkle background, gold holographic shield or barrier, Hologirl as blue/cyan projection.
- `Concert!`: current Hologirl design, performance/singing moment, not the older portrait.
- `Livestream`: current Hologirl design, streamer-at-monitor composition, not the older portrait.

Generated card art must ship at:

- `Hologirl/images/card_portraits/big/<card>.png` (`1000x760`)
- `Hologirl/images/card_portraits/<card>.png` (`250x190`)

Archive selected sources and rejected explorations under `docs/design/art_archive/cards/<card>/`.

## Work Plan

1. Reduce Livestream chat reply frequency.
2. Write one design doc per draftable card before code changes.
3. Rework card mechanics in small groups by rarity.
4. Update card localization and hover tips.
5. Generate/regenerate art after each card role is stable enough to keep.
6. Build and manually test card creation, reward generation, merchant generation, and at least one combat with several new cards.
7. Release as `v0.4.0` once the pool feels internally coherent.

## Side Quest: Card-Aware Livestream

Not required for the first `v0.4` release, but desirable as the card pool stabilizes: `Livestream` should eventually understand Hologirl's individual cards and emit card-specific chat lines when they are played or when their signature effects happen.

Examples:

- `Concert!`: chat reacts to Hologirl starting a performance or maintaining `Singing`.
- `Livestream`: chat reacts to the stream going live and the overlay starting.
- `Signal Jab`: chat reacts to a small clean poke that earns audience.
- `Fan Meetup`: chat reacts to fan gathering, follows, viewer count, and subs.
- `Broadcast Loop`: chat reacts to automation, schedule loops, and passive audience growth.
- `Glitch Waltz`: chat reacts to defensive dancing, glitch timing, or preserving Fans.
- Future form cards: chat reacts to the specific form/persona instead of generic Shapeshift.

This should be data-driven through the Livestream chat catalog rather than hard-coded text in individual cards. If the trigger needs source-card information, prefer adding a small source-aware hook at the Livestream power boundary instead of scattering direct overlay calls across every card.

## v0.4.1 Correction

The first v0.4 draft made the pool more distinct but still over-indexed on gaining `Fans`, `Singing`, or `Livestream` without enough payoff. v0.4.1 shifts the pool toward active Fan spending:

- `Fans` now decay by half at end of turn unless `Singing`, instead of losing only one. This makes `Singing` a preservation tool for large audiences.
- Common cards can build a small audience when empty, then spend it for better damage or block once online.
- Uncommon and rare cards spend `Fans` for multi-hit scaling, draw, energy, block, and burst damage.
- `Prime Time` is no longer a second Livestream source; it is a Fan-spending tempo payoff so `Livestream` remains the signature rare power.
- `Viral Moment` requires the full Fan threshold before it spends, so partial audiences are not silently lost.
- `Shapeshift`, Idol Forms, and zero-cost form reward cards remain documented prototype content, not part of the active v0.4.1 balance target.
- Card-specific Livestream reactions are part of the shipped pass, but the long-term goal remains to move source-aware chat behavior toward a central Livestream boundary as APIs settle.

## Open Questions

- Whether `v0.4` should add explicit Shapeshift entry cards or keep Shapeshift mostly deferred.
- Whether any card should consume Fans yet, or whether this pass should focus on gaining/preserving/scaling Fans.
- Whether `Broadcast Loop` should remain a power or become a skill if too many early powers crowd the pool.
