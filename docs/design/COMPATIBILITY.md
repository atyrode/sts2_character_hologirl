# Mod Compatibility

Hologirl should aim to be highly compatible with other mods.

- Prefer local card, power, relic, and character behavior over global hooks or patches.
- Prefix custom ids, localization keys, assets, and generated concepts with the mod namespace already used by the template: `HOLOGIRL` / `Hologirl`.
- Avoid custom enum entries, shared keyword registration, global description overrides, and broad Harmony patches unless there is a concrete need and the collision risk is documented.
- Keep manifest fields compatible with the user's current game build and mod manager. `dependencies` currently uses the string-list schema expected by STS2 `v0.103.2`.
- If a future feature needs global behavior, document why it is needed, what it touches, and how it avoids colliding with other mods before implementing it.
