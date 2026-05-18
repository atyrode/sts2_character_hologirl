import { PartInspector } from "./part-inspector/PartInspector.jsx";

export function SettingsPanel() {
  return (
    <aside className="side-panel" id="sidePanel">
      <div className="toolbar">
        <div className="toolbar-group">
          <strong>Settings</strong>
        </div>
      </div>

      <PartInspector />
      <textarea id="jsonBox" className="hidden-json-buffer" spellCheck={false} tabIndex={-1} aria-hidden="true" />

      <div className="placed-parts-panel">
        <div className="fixed-panel-title parts-title">Placed Parts</div>
        <div className="parts" id="partsList" />
      </div>
    </aside>
  );
}
