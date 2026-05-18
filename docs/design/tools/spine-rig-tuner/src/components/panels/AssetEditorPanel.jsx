import { Crop, PackagePlus, Redo2, RotateCcw, Trash2, Undo2 } from "lucide-react";
import { IconButton } from "../IconButton.jsx";

export function AssetEditorPanel() {
  return (
    <aside className="asset-editor-panel collapsed" id="assetEditorPanel">
      <div className="toolbar">
        <div className="toolbar-group">
          <strong>Asset Editor</strong>
          <span className="hint">Edit the selected placed part, or a selected library asset.</span>
        </div>
      </div>

      <div className="panel">
        <h2>Selected Cutout</h2>
        <div className="grid asset-details-grid">
          <label>Slot<select id="assetSlotInput" /></label>
          <label>Name<input id="assetNameInput" type="text" /></label>
          <label>Crop X <input id="assetCropXInput" type="number" step="1" /></label>
          <label>Crop Y <input id="assetCropYInput" type="number" step="1" /></label>
          <label>Crop W <input id="assetCropWInput" type="number" step="1" min="1" /></label>
          <label>Crop H <input id="assetCropHInput" type="number" step="1" min="1" /></label>
        </div>

        <canvas className="asset-editor-preview" id="assetEditorCanvas" width="320" height="220" />

        <div className="grid asset-brush-grid">
          <label>Brush<input id="assetBrushInput" type="number" step="1" min="1" max="80" defaultValue="8" /></label>
          <label>
            Mode
            <select id="assetBrushModeInput">
              <option value="erase">erase</option>
              <option value="restore">restore</option>
            </select>
          </label>
        </div>

        <div className="panel-actions">
          <IconButton id="undoAssetEdit" icon={Undo2} label="Undo asset edit" />
          <IconButton id="redoAssetEdit" icon={Redo2} label="Redo asset edit" />
          <IconButton id="trimAsset" icon={Crop} label="Trim visible pixels" />
          <IconButton id="resetAssetMask" icon={RotateCcw} label="Reset alpha edits" />
          <IconButton id="promotePartAsset" icon={PackagePlus} label="Save selected placed part as a library asset" />
          <IconButton className="danger" id="deleteAssetPanel" icon={Trash2} label="Delete selected cutout" />
        </div>

        <p className="hint">Select a placed part to edit only that pose instance. Select a library asset to edit the reusable source asset.</p>
      </div>
    </aside>
  );
}
