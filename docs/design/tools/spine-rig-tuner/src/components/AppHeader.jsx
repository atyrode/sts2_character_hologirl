import {
  Download,
  FolderOpen,
  FolderSync,
  Save,
  Trash2,
  Upload,
  XCircle
} from "lucide-react";
import { IconButton } from "./IconButton.jsx";
import { SHEET_OPTIONS } from "./sheetOptions.js";

function PanelToggle({ target, children }) {
  return (
    <button className="panel-toggle" data-panel-toggle={target} data-panel-label={children}>
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
        <IconButton className="primary" id="saveProject" icon={Save} label="Save project" />
        <IconButton id="loadProject" icon={FolderOpen} label="Load selected project" />
        <IconButton className="danger" id="deleteProject" icon={Trash2} label="Delete selected project" />
        <IconButton id="connectSaveFolder" icon={FolderSync} label="Connect repo saves folder" />
        <IconButton id="refreshRepoSaves" icon={FolderSync} label="Refresh saved projects" />
      </div>

      <div className="toolbar-group">
        <span className="toolbar-group-label">JSON</span>
        <IconButton className="primary" id="exportJson" icon={Download} label="Export JSON" />
        <IconButton id="importJson" icon={Upload} label="Import JSON" />
        <IconButton className="danger" id="clearSaved" icon={XCircle} label="Clear autosave" />
      </div>

      <div className="toolbar-group">
        <span className="toolbar-group-label">Show / Hide</span>
        <PanelToggle target="sourceSection">Source</PanelToggle>
        <PanelToggle target="poseSection">Pose</PanelToggle>
        <PanelToggle target="assetEditorPanel">Editor</PanelToggle>
        <PanelToggle target="assetLibrary">Assets</PanelToggle>
      </div>

      <span className="status" id="status">Loading...</span>
    </header>
  );
}
