import { ChevronDown, Crop, Redo2, RotateCcw, Trash2, Undo2 } from "lucide-react";
import { IconButton } from "../IconButton.jsx";

export function AssetEditorPanel() {
  return (
    <aside className="asset-editor-panel collapsed" id="assetEditorPanel">
      <div className="toolbar">
        <div className="toolbar-group">
          <IconButton className="collapse-button" data-collapse-target="assetEditorPanel" icon={ChevronDown} label="Collapse asset editor panel" />
          <strong>Asset Editor</strong>
          <span className="hint">Select a library asset to edit its crop and alpha.</span>
        </div>
      </div>

      <div className="panel">
        <h2>Selected Asset</h2>
        <div className="grid">
          <label>Slot<select id="assetSlotInput" /></label>
          <label>Name<input id="assetNameInput" type="text" /></label>
          <label>Crop X <input id="assetCropXInput" type="number" step="1" /></label>
          <label>Crop Y <input id="assetCropYInput" type="number" step="1" /></label>
          <label>Crop W <input id="assetCropWInput" type="number" step="1" min="1" /></label>
          <label>Crop H <input id="assetCropHInput" type="number" step="1" min="1" /></label>
          <label>Brush<input id="assetBrushInput" type="number" step="1" min="1" max="80" defaultValue="8" /></label>
          <label>
            Mode
            <select id="assetBrushModeInput">
              <option value="erase">erase</option>
              <option value="restore">restore</option>
            </select>
          </label>
        </div>

        <canvas className="asset-editor-preview" id="assetEditorCanvas" width="320" height="220" />

        <div className="panel-actions">
          <IconButton id="undoAssetEdit" icon={Undo2} label="Undo asset edit" />
          <IconButton id="redoAssetEdit" icon={Redo2} label="Redo asset edit" />
          <IconButton id="trimAsset" icon={Crop} label="Trim visible pixels" />
          <IconButton id="resetAssetMask" icon={RotateCcw} label="Reset alpha edits" />
          <IconButton className="danger" id="deleteAssetPanel" icon={Trash2} label="Delete asset" />
        </div>

        <p className="hint">Select an asset in the Asset Library. Paint on the preview to erase stray pixels or restore pixels from the source crop.</p>
      </div>
    </aside>
  );
}
