# Livestream

## Gameplay

- Cost: 2
- Type: Power
- Rarity: Rare
- Gain `Livestream`.
- While `Livestream` is active, the listed trigger events generate `Fans` equal to the power amount.
- Card text intentionally stays short. The power hover text owns the trigger details so the card body does not become a rules paragraph.

Implemented Fan-gain triggers:

- Use a Potion.
- Fully block an enemy attack.
- Heal Hologirl.
- Apply a debuff to an enemy.
- Deal at least 18 unblocked damage with one hit.

Implemented cosmetic-only chat moments:

- Hologirl takes unblocked damage.
- Hologirl receives a debuff.
- A monster dies.
- Hologirl dies. This intentionally uses a larger, slower game-over burst and the overlay is not cleared by normal combat-end cleanup when Hologirl is dead, so the chat can keep reacting behind the loss screen.
- Hologirl starts or ends a turn.
- Hologirl gains `Singing`, using music/performance-specific reactions while Livestream is active.
- Hologirl gains `Fans`, using audience-growth reactions such as viewer count, follows, subscriptions, and gift-train-style chatter.
- Hologirl plays, draws, or exhausts a card. These are lower-frequency and dampened within a turn so routine card flow adds texture without overwhelming event-specific reactions.
- Hologirl plays an attack or a block card. These reactions are cosmetic only and do not imply that ordinary attacks or block cards generate `Fans`.
- Hologirl plays or draws a Rare, Curse, or Status card. These are cosmetic reactions only. No full-art-card trigger is currently wired because no stable full-art marker has been identified on the card model.
- Hologirl spends `Fans` or plays specific Hologirl draftable cards that have dedicated chat lines.

Upgrade direction: increase the `Livestream` power amount from 1 to 2, so each trigger generates more `Fans` rather than changing the trigger list.

`Livestream` no longer owns Shapeshift. Form entry should move to future cards or relic interactions that explicitly describe Shapeshift.

## Stream Overlay Direction

Target experience: playing `Livestream` should make the run feel like Hologirl is being watched by a live chat. The combat overlay should be transparent, sit over the game area, and show roughly five chat messages at once. New messages enter when a trigger or cosmetic chat event happens, then fade out after a short time.

First draft implementation:

- Built in C# as a cosmetic Godot `Control` created on the first `Livestream` hype event.
- Placed on a transparent background, left of Hologirl around head height.
- Shows up to five fading messages at once, with new messages entering from the bottom and older messages moving upward. Messages currently remain for about 10 seconds before fading.
- Playing `Livestream` emits a small staggered stream-start burst using greetings and "went live" chat lines, separate from later hype reactions.
- Each later event emits event-specific messages with human-style latency: the first reaction should generally arrive after about 1-2 seconds, with later reactions spread over several more seconds so chat feels typed by people rather than emitted as a scripted packet.
- Some larger reaction bursts can become partial pile-ons: a random subset of chatters repeats the same reflexive reaction family, such as laughing, confusion, panic, or hype, with casing, punctuation, and emote variations while the rest of the burst can still use normal event-specific lines.
- Reaction count scales with current `Fans`, with light random variance so bigger audiences feel more active. Higher Fan tiers also bias bursts toward pile-on/dogpile behavior, because a fast-moving chat should become less individually readable and more reflexive.
- While `Livestream` is active, ambient neutral chat appears between turns. More `Fans` make ambient chatter more frequent and sometimes add extra messages.
- While `Livestream` is active, idle chat can appear during quiet combat time. This uses a separate low-key message pool and resets after real reactions so it fills dead air instead of competing with action.
- Some chat lines can trigger a delayed reply from another chatter, formatted as `@username message`, so the overlay sometimes feels like chatters are responding to each other. Replies are strongly biased toward source messages that ask a question or use the word "chat"; non-prompt messages can still receive replies, but much less often.
- Rarely, a chatter reply can itself create a delayed mini pile-on where multiple chatters react to that one message with the same broad emotion, such as agreement, disagreement, confusion, laughter, or support.
- Ambient and idle messages are biased by Hologirl's current HP state. Stable HP favors relaxed or enthusiastic lines, tense HP introduces more concern and backseating, and critical HP increases anxious, mocking, and supportive chat.
- Rare copy-pasta-style messages can appear in neutral or idle chat as long-form jokes. These are deliberately uncommon so they read as occasional chat culture instead of constant noise.
- The catalog keeps a short recent-message memory so the same text is not immediately repeated by different usernames during long combats.
- Neutral chatter includes simple social messages such as laughter, agreement, questions, confusion, and lightweight backseat reactions.
- Hologirl-owned emote codes such as `HoloPog`, `HoloSweat`, `HoloSmirk`, and `HoloLUL` can appear as standalone/social lines or punctuate longer messages. The chat renderer swaps these codes for inline image tags when the matching asset exists.
- Chat rows estimate the space they need from message length and emote count, then lay out from the bottom with variable row height so multi-line messages and inline emotes are not clipped.
- Official Twitch emote image assets should not be bundled unless their licensing and trademark status is explicitly cleared. The shipped emotes should be original Hologirl-faced versions of familiar livestream-chat expression categories, not copies of official Twitch artwork.
- The overlay is cleared on combat victory/end. Runtime placement should prefer the player creature visual layer: the manager finds the leftmost visible `CreatureVisual` canvas item in the combat scene, treats it as the player visual, and parents chat to that visual's parent. This keeps chat with the character/combat art layer instead of a modal UI layer such as pause or rewards.
- Message pools currently include event-specific reactions, a larger stream-start greeting pool, a neutral pool, and a low-key idle pool.

The message system should be data-driven instead of scattering chat text through the power implementation. It should support:

- colored pseudonyms with mixed casing, numbers, ordinary names, and mod-flavored chat handles so the roster feels like a real stream instead of one generated naming pattern;
- neutral idle chatter;
- reaction messages tied to the exact trigger category;
- a long-term message library target around 10,000 unique lines, grown incrementally through specific pools rather than one generic bucket;
- specific variants when the source object is known, such as potion-name-aware messages;
- more event-specific trigger categories over time, such as exact card type, enemy action, lethal setup, low HP saves, relic triggers, power stacks, hand state, discard moments, shop choices, rest-site decisions, and boss/elite moments;
- one centralized audience profile for Fan thresholds and intensity. Individual trigger categories should express their own likelihood as a proportion of audience intensity instead of defining independent Fan breakpoints.
- short Twitch/chat-style slang and meme phrasing without turning every line into the same joke.
- custom emote art as a future asset direction if visual emotes become important. Text emote-code support is the default until image rights are clear.

Implemented emote assets:

- Source sheet archive: `docs/design/art_archive/ui/livestream_emotes/attempt-001/source-sheet.png`
- Transparent source archive: `docs/design/art_archive/ui/livestream_emotes/attempt-001/sheet-transparent.png`
- Shipped emote PNGs: `Hologirl/images/emotes/holo_*.png`

The overlay must remain cosmetic. Fan gain is deterministic from the listed Fan-gain triggers; random chat message selection should not affect gameplay.

Open overlay questions:

- Whether neutral chatter should tick on a timer, only on player actions, or both.
- Exact placement tuning after in-game testing so it does not obscure hand, enemy intents, or map/turn UI.

## Art Status

Implemented from the approved generated image:

`docs/design/art_archive/cards/livestream/attempt-005/result.png`

- Big portrait: `Hologirl/images/card_portraits/big/livestream.png`
- Small portrait: `Hologirl/images/card_portraits/livestream.png`

## Art Direction

Cozy intimate streamer-at-home scene, framed closer to the iconic lofi hip hop radio girl composition. The monitor/computer is on the left, Hologirl is on the right, seen in side profile facing left, and the crop lands around mid-torso instead of showing her full body. There is no concert crowd or fan background.

Hologirl remains blue/cyan with two readable ponytails. Gold/yellow is reserved for the monitor glow, projected UI accents, and tiny holographic effects.
