import { ChevronDown } from "lucide-react";
import { IconButton } from "../IconButton.jsx";
import { PartInspector } from "./part-inspector/PartInspector.jsx";

export function SettingsPanel() {
  return (
    <aside className="side-panel" id="sidePanel">
      <div className="toolbar">
        <div className="toolbar-group">
          <IconButton className="collapse-button" data-collapse-target="sidePanel" icon={ChevronDown} label="Collapse settings panel" />
          <strong>Settings</strong>
        </div>
      </div>

      <PartInspector />

      <div className="panel collapsed">
        <h2>Advanced JSON</h2>
        <textarea id="jsonBox" spellCheck={false} />
      </div>

      <div className="parts" id="partsList" />
    </aside>
  );
}
