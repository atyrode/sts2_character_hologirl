import { PartInspector } from "./part-inspector/PartInspector.jsx";

export function SettingsPanel() {
  return (
    <aside className="side-panel" id="sidePanel">
      <div className="toolbar">
        <div className="toolbar-group">
          <button className="collapse-button" data-collapse-target="sidePanel" title="Collapse settings panel">▾</button>
          <strong>Settings</strong>
        </div>
      </div>

      <PartInspector />

      <div className="panel">
        <h2>Project JSON</h2>
        <textarea id="jsonBox" spellCheck={false} />
      </div>

      <div className="parts" id="partsList" />
    </aside>
  );
}
