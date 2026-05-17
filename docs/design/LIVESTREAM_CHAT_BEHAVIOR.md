# Livestream Chat Behavior

This documents the intended small-scale behavior of the Livestream overlay so future edits preserve the feel instead of only preserving the code.

## Design Intent

Livestream chat is a cosmetic-plus-feedback layer for the `Livestream` power. It should feel like a real Twitch-style chat reacting to combat, but it is not meant to be a literal viewer simulator.

The main goals are:

- Make Hologirl feel like she is being watched live.
- Let combat events generate contextual reactions.
- Let fan count make chat feel more populated over time.
- Keep low-fan chat readable and intimate.
- Let high-fan chat become louder, more dogpile-heavy, and less individually readable.

## Fan Scaling

Fan amount controls intensity, not exact viewer count.

- Low fans should produce sparse messages with longer gaps.
- Mid fans should start showing more ambient chatter and occasional multi-message reactions.
- High fans should produce frequent chat, more repeated/emote-family reactions, and more dogpile behavior.
- Fan scaling should affect message count, idle delay, reaction chance, pile-on chance, and recurring chatter count from a single audience profile concept.

The implementation owner is `LivestreamAudienceProfile`. New frequency thresholds should be added there first instead of scattering raw fan checks across powers and UI code.

## Recurring Chatters

Recurring chatters are a flavor layer, not the whole chat.

- Normal messages should still mostly come from the full username pool.
- A fan-scaled side pool of recurring users may appear repeatedly.
- Recurring users are shown with a `*` prefix before their name, representing a subscriber/member-style status.
- The recurring side pool grows with fan amount.
- At low fans, one or two recurring names may show up, but they must not dominate every message.
- The same username should not post unrelated punchlines back-to-back when avoidable.

This is why `LivestreamChatCatalog` keeps both a full chatter pool and a fan-scaled recurring pool. Do not replace all chat generation with only the recurring pool.

## Message Timing

Reactions should not feel like a script firing all messages at once.

- Combat-triggered reactions should usually arrive after a short human delay.
- Multi-message reactions should be spread by loose randomized gaps.
- Start-stream greetings should trickle during the opening window.
- Generic cosmetic chatter should be suppressed briefly at stream start so the opening does not immediately feel off-topic.
- Idle messages should appear only after quiet time and should scale down at low fans.

## Message Content

Message pools should include more than short jokes.

Keep a mix of:

- short emote-style reactions
- questions
- observations
- actual advice or technical questions
- supportive messages
- mockery or haters
- anxious messages when Hologirl is low on HP
- occasional multilingual recognizable phrases
- rare copypasta-style messages
- replies to chat messages, especially messages with `?` or the word `chat`

When adding new event types, add both normal event messages and pile-on families when the event is likely to trigger repeated reactions.

## Overlay Layout

The overlay should read as part of the combat scene, not global UI.

- It should sit around Hologirl's head level, left of the character.
- It should be under menus, potion UI, and pause/reward screens when those screens cover the character.
- It may remain visible behind the death screen and reward screen for comedic effect.
- Rows should expand only when the rendered message actually needs the height; avoid empty second rows.

## Known Technical Owners

- `HologirlCode/Powers/LivestreamPower.cs`: combat event hooks and fan gain behavior.
- `HologirlCode/UI/Livestream/LivestreamAudienceProfile.cs`: fan-scaled frequency, count, and recurring-chatter thresholds.
- `HologirlCode/UI/Livestream/LivestreamChatCatalog.cs`: usernames, message pools, recurring chatter selection, replies, and emote decoration.
- `HologirlCode/UI/Livestream/LivestreamChatOverlay.cs`: timing, layout, fading, queueing, and Godot UI rendering.
- `HologirlCode/UI/Livestream/LivestreamChatOverlayManager.cs`: scene-tree placement.
