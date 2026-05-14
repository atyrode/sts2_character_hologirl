# Character Select Hologirl Cutout Attempt 005

- Generated: 2026-05-14 20:39:24.173124628 UTC
- Source: `ig_0ed26d6a4f622866016a0632a306908191ba3314bfde0eb892.png`
- Result: `result.png`
- Transparent result: `result-transparent.png`
- Alpha preview: `result-transparent-preview.png`
- Prompt: `prompt.md`
- Prompt status: exact.
- Selection status: preview only, not implemented.

## Notes

Generated after feedback on `attempt-004`: closer crop, Hologirl should occupy roughly 80% of the character-select composition, simpler details, and a physically plausible continuous whip arc.

Generated on a flat green chroma-key background and processed locally with `scripts/remove-chroma-key.sh`. The remover auto-sampled the key as `#08eb1b`; output stats were `transparent=55953 partial=617278 opaque=899633`, and the alpha preview reported `transparent=123436 partial=549795 opaque=899633`. The larger partial-alpha count suggests the chroma key was less flat or the subject had more green-adjacent antialiasing than earlier attempts, so the cutout edge needs closer review.
