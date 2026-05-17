# v0.4.2 Mechanic Rethink

## Problem With v0.4.1

The v0.4.1 pool is functional but too repetitive. Most draftable cards either gain `Fans`, gain `Singing`, gain `Livestream`, or spend `Fans` for larger numbers. That gives Hologirl a resource, but it does not yet create a distinctive character rhythm.

The obsolete form reward cards also stayed in active code longer than they should have. Those 0-cost Shapeshift token cards are removed from the active source set for the next pass. `Shapeshift`, Idol Forms, and `Prism Pendant` can return later only if they are rebuilt as a complete mechanic, not as leftover placeholder behavior.

## Target Experience

Hologirl should feel like a performer reacting to a live audience, not like a generic resource-spend character.

Combat should ask questions like:

- Do I spend audience momentum now, or preserve it with `Singing` for a bigger moment?
- Do I set up a future viral turn, or take the safe block/damage line?
- Is this card useful because of how it uses the current Fan/Singing state, not just because it says "gain Fans"?

## Proposed Core Loop

Keep the existing concepts, but give each a sharper job:

- `Fans`: volatile audience size. Still decays unless protected, but should not be the only payoff currency.
- `Singing`: audience preservation and performance mode. It should help hold momentum and improve cards that care about rhythm or sustained turns.
- `Livestream`: mechanically simple Fan generation from explicit combat events. The large chat overlay is a fun presentation gimmick and should not imply an extra decision subsystem by itself.
- `Chat Request`: parked future idea. Chat could occasionally ask for a kind of play, and satisfying it could create a small bonus such as extra `Fans`, draw, Energy, Block, or a stronger chat burst. Do not implement this yet unless the current request and reward can be surfaced clearly enough that the player understands why the bonus happened.
- `Clip`: possible future mechanic if the pool still needs a second axis. Clips would represent replayable highlights and could be cashed out by rare cards for burst, draw, energy, or Fan growth.

`Chat Request` and `Clip` are only proposals, not confirmed implementation. Before coding either, verify the cleanest BaseLib/Core representation for custom powers with internal state and card-play hooks. A first implementation should be deliberately small, because unclear hidden bonuses would undermine the core readability of the character.

## Existing Card Rework Direction

No new cards are needed for the first pass. Rework the existing pool into different jobs.

- `Signal Jab`: cheap attack that can bridge between low-Fan setup and high-Fan payoff without just being Strike+.
- `Fan Meetup`: defensive audience card. It should reward defensive planning or Fan thresholds instead of only gaining block per Fan.
- `Broadcast Loop`: passive audience infrastructure. It should remain simple if Livestream is already active, but maybe interact with Fan decay or the first Fan spend each turn.
- `Lightwhip Flourish`: multi-hit style card. Could scale from current Fan tiers, hand state, or repeated attacks, instead of only spending Fans for hits.
- `Glitch Waltz`: defensive rhythm card. Could preserve Fans with `Singing` and reward alternating card types or playing after an attack.
- `Encore Engine`: sustained-performance power. Could repeat or improve the first Fan spend each turn, or preserve a small amount of Fans after decay.
- `Radiant Whip`: burst cashout. Should spend `Clips` or audience momentum for a memorable damage payoff, not just spend all Fans.
- `Viral Moment`: payoff for staged momentum. Could convert a Fan threshold, Singing, or future Clips into draw/energy and trigger a large chat burst.
- `Prime Time`: capstone turn card. Should turn audience momentum into a memorable defensive/tempo turn without becoming a second Livestream.
- `Livestream`: remains the rare anchor. It starts the chat overlay and makes explicitly listed combat events generate Fans. It should not become a complex prompt/request system for now.

## Removal Decision

The following active token cards are removed from source for the next pass:

- `AmeliaClue`
- `FaunaBloom`
- `GuraChomp`
- `KroniiTick`

Their old design docs are removed from the active `docs/design/cards/` tree. If forms return later, they need a new design document and a complete implementation plan.

## Implementation Notes To Verify

- If `Chat Request`, `Clip`, or another second-axis mechanic is added, confirm whether a custom power can safely hold non-serialized internal state or whether it needs explicit save/restore handling.
- Keep Livestream chat catalog data-driven. Card-specific reaction text should live in the catalog, not as hard-coded strings in card models.
- Avoid adding more cards until the mechanic loop has enough distinction with the current pool.
