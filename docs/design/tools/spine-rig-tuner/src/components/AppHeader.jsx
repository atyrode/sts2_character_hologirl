import { SHEET_OPTIONS } from "./sheetOptions.js";

function PanelToggle({ target, children }) {
  return (
    <button className="panel-toggle" data-panel-toggle={target}>
      {children}
    </button>
  );
}

export function AppHeader() {
  return (
    <header>
      <h1>Hologirl Spine Rig Tuner</h1>

      <div className="toolbar-group">
        <span className="toolbar-group-label">Sheet</span>
        <select id="sheetSelect" title="Source sheet">
          {SHEET_OPTIONS.map(([value, label]) => (
            <option key={value} value={value}>
              {label}
            </option>
          ))}
        </select>
      </div>

      <div className="toolbar-group">
        <span className="toolbar-group-label">Saves</span>
        <input id="saveNameInput" type="text" placeholder="save name: auto if empty" />
        <select id="saveSelect" title="Saved project" />
        <button className="primary" id="saveProject">Save</button>
        <button id="loadProject">Load</button>
        <button className="danger" id="deleteProject">Delete</button>
        <button id="connectSaveFolder">Repo Folder</button>
        <button id="refreshRepoSaves">Refresh</button>
      </div>

      <div className="toolbar-group">
        <span className="toolbar-group-label">JSON</span>
        <button className="primary" id="exportJson">Export</button>
        <button id="importJson">Import</button>
        <button className="danger" id="clearSaved">Clear Autosave</button>
      </div>

      <div className="toolbar-group">
        <span className="toolbar-group-label">Panels</span>
        <PanelToggle target="sourceSection">Source</PanelToggle>
        <PanelToggle target="poseSection">Pose</PanelToggle>
        <PanelToggle target="assetEditorPanel">Editor</PanelToggle>
        <PanelToggle target="assetLibrary">Assets</PanelToggle>
        <PanelToggle target="sidePanel">Settings</PanelToggle>
      </div>

      <span className="status" id="status">Loading...</span>
    </header>
  );
}
