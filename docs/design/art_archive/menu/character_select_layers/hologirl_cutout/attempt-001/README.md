# Character Select Hologirl Cutout Attempt 001

- Generated: 2026-05-14 19:39:09.683120754 UTC
- Source: `ig_0ed26d6a4f622866016a06249987ac8191badf3669b1313463.png`
- Result: `result.png`
- Transparent result: `result-transparent.png`
- Alpha preview: `result-transparent-preview.png`
- Prompt: `prompt.md`
- Prompt status: exact.
- Selection status: preview only, not implemented.

## Notes

Generated on a flat green chroma-key background and processed locally with `scripts/remove-chroma-key.sh`. The remover auto-sampled the key as `#0cf309`; output stats were `transparent=911769 partial=24492 opaque=636267`, and the alpha preview reported `transparent=911941 partial=24320 opaque=636267`.

This validates the basic cutout pipeline for a future layered character-select scene. Visual direction is not final: the result is cleaner/anime-leaning than the target STS2 style, but it is useful for testing alpha extraction and layer composition.
