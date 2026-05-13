# Development Checklist

This is the living to-do list for the `hologirl` character project. Check items off as they are completed and add new items when requirements become clearer.

## 1. Project Inputs

- [x] Link GitHub repository.
- [x] Add persistent agent workflow instructions in `AGENTS.md`.
- [x] Add documentation structure.
- [ ] Confirm final project target and runtime.
- [ ] Confirm whether this is a 2D, 3D, realtime, rendered, or hybrid character.
- [ ] Gather approved references.
- [ ] Confirm asset licensing and attribution requirements.
- [ ] Confirm canonical source asset formats.
- [ ] Confirm generated/export formats.

## 2. Project Foundation

- [ ] Decide whether the repo needs Git LFS.
- [ ] Add `.gitignore` once toolchain/generated outputs are known.
- [ ] Add dependency/tooling files if a runtime or asset pipeline is chosen.
- [ ] Add baseline validation commands.
- [ ] Add CI if validation should run in GitHub Actions.
- [ ] Document local setup in `README.md`.

## 3. Asset Structure

- [ ] Define source asset directory.
- [ ] Define reference asset directory.
- [ ] Define export/generated asset directory.
- [ ] Document which files are canonical.
- [ ] Document which files are generated and safe to recreate.
- [ ] Add naming conventions for character assets.

## 4. Character Design

- [ ] Define character silhouette.
- [ ] Define color palette.
- [ ] Define material/rendering direction.
- [ ] Define expression range.
- [ ] Define motion language.
- [ ] Define outfit/accessory constraints.
- [ ] Record approved and rejected variants in `docs/DESIGN.md`.

## 5. Runtime Or Delivery

- [ ] Choose runtime, renderer, or delivery format.
- [ ] Add local run command if applicable.
- [ ] Add build/export command if applicable.
- [ ] Document integration points.
- [ ] Add smoke test or validation path.

## 6. Quality Checks

- [ ] Verify repo setup from a fresh clone.
- [ ] Validate source assets open in the chosen tools.
- [ ] Validate generated exports load in the target runtime.
- [ ] Check performance constraints if realtime.
- [ ] Check visual consistency against approved references.
- [ ] Check accessibility/usability requirements if the character appears in an interactive UI.

## 7. Release

- [ ] Define release artifact.
- [ ] Document release process.
- [ ] Tag a first usable version.
- [ ] Record known limitations.
