# Hologirl Spine Rig Tuner

The tuner is a nested Vite app so web tooling stays inside this folder instead of the mod root. Run it with:

```sh
cd docs/design/tools/spine-rig-tuner
npm install
npm run dev
```

Build/check the tuner with:

```sh
cd docs/design/tools/spine-rig-tuner
npm run build
```

`index.html` is now the Vite entry point. The first migration keeps the existing canvas-heavy behavior in `src/tuner.js` and page shell in `src/App.jsx`; future UI work should continue breaking that logic into focused React components.

The dev server maps the repository art archive into the app at `/art_archive/` through `vite.config.js`, so source sheets load from the repo while the tuner code remains nested in this folder.

Workflow:

1. Pick a source sheet. `Sheet M` through `Sheet R` are the depth-focused variants: M/N for granular body pieces, O for clothing layers, P for hair layers, Q for a cleaner minimal set, and R for stricter clothing/body separation. `Sheet S` through `Sheet AD` are essential separated variants based on the current reduced part list. `Sheet J` through `Sheet L` focus on linework, ponytails, and hand+whip grips. `Sheet G` through `Sheet I` are magenta-key hologram-style variants made to reduce green-key artifacts and gemstone texture.
2. Drag on the source image to draw a crop rectangle or click polygon points.
3. Choose the semantic part slot and click `Create Part` or `Create Overlay`. This creates a reusable asset in the bottom Asset Library.
4. Alternatively, use `Extract Sheet` with Alpha Preview on to automatically split the transparent sheet into connected cutout assets. Auto-extracted assets are named `auto_001`, `auto_002`, etc. and should be renamed/assigned semantic slots as needed.
5. Drag an asset from the Asset Library onto Pose Preview to place it in the assembled pose.
6. Select a library asset to rename it, adjust its crop, erase or restore stray alpha pixels, or trim it to visible pixels in the `Asset Editor` panel.
7. Select placed parts in the list or on the pose canvas.
8. Adjust x, y, rotation, scale, horizontal/vertical flip, z-order, opacity, brightness, and pivot.
9. Export JSON and send it back for conversion into the Spine skeleton.

The tool intentionally keeps the semantic mapping operator-driven because generated rig sheets can include ambiguous or duplicate pieces.

Overlap workflow:

- Use full limb pieces that extend past the visible edge of clothing. For example, `upper_leg_near_under_skirt` should slide under skirt pieces instead of ending exactly at the skirt hem.
- Use polygon masks for precise front overlays. For example, crop a curved `skirt_front_near` shape and place it above the leg, while `skirt_back` stays below the leg.
- Use z-order for depth: back clothing and far hair low, body and limbs in the middle, front trims/cuffs/collar/skirt overlays high.
- Pivot controls set the rotation point for animation. They do not create depth by themselves; depth comes from splitting artwork into back pieces, full under-pieces, and front overlays.

Tool controls:

- The top meta bar is grouped by sheet selection, repo/browser saves, JSON import/export, and panel visibility toggles, including a dedicated `Editor` panel for selected library assets.
- Source crop tools are grouped by crop mode, part creation, and crop clearing.
- `Extract Sheet` scans the currently loaded transparent sheet and creates one library asset per connected opaque island. It is a convenience pass, not semantic labeling; small touching pieces may need manual cleanup.
- The Asset Library is an independent full-width bottom row. It stores cropped assets separately from placed pose parts and remains usable even when Source, Pose, or Settings are hidden.
- Click an asset to select it. Use its trash button, Delete, or Backspace to remove it from the library. Deleting a library asset does not delete placed pose parts already made from it.
- The `Asset Editor` panel edits reusable library assets before placement. Use crop fields for small bounds changes, paint the preview in erase/restore mode for stray pixels, Undo/Redo for alpha/crop edits, `Trim Visible` to tighten the crop to the remaining alpha, and `Reset Alpha` to discard brush edits.
- The Asset Library is a horizontal tray. Mouse wheel scrolling over it moves left/right, and cards scale to the available tray height to avoid vertical scrolling.
- Source, Pose, Asset Library, and Settings can be collapsed with their chevron buttons or the top `Panels` toggles. Collapsed panels leave the workspace entirely; use the top toggles to bring them back.
- The workspace uses explicit grid areas for Source, Pose, Settings, and Assets so each panel keeps its own layout slot across visibility combinations.
- Alpha preview and reset pose live in the pose preview toolbar because they affect the assembled pose view.
- Ctrl + mouse wheel zooms the source and pose canvases independently.
- Drag the vertical dividers to resize the source, pose, and control panels.
- Ctrl+C and Ctrl+V copy and paste the selected part when focus is not inside a form field.
- Delete or Backspace removes the selected placed part, or the selected library asset, when focus is not inside a form field.
- Right-click the source canvas to clear the current rectangle or polygon crop.
- `Close Polygon` finalizes the current polygon bounds before creating a part. Creating a part also works once the polygon has at least three points, but closing it makes the active crop explicit.
- Lock prevents a part from moving or being transformed until unlocked.
- The eye control in the parts list hides or shows a part without deleting it.
- Flip X and Flip Y mirror the selected placed part in the pose preview without modifying the underlying library asset.
- Opacity and brightness can be adjusted per part to test depth, such as making the far ponytail darker.
- Hover any numeric selected-part field and use the mouse wheel to nudge it. Shift scrolls faster; Ctrl scrolls more finely.
- Repo saves live in `docs/design/tools/spine-rig-tuner/saves/`. The tool can read committed saves from `saves/index.json` when served over HTTP. Click `Repo Folder` and choose that `saves/` folder to let Save/Delete write JSON files directly into the repo working tree through the browser file picker.
- Named browser saves remain available as fallback local browser storage. If the save-name field is empty, the tool generates a sheet/timestamp name. Export JSON remains the portable handoff format.
- Right-side panels can be collapsed by clicking their header.
