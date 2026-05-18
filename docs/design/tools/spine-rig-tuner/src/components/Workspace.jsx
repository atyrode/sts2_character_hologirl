import { AssetEditorPanel } from "./panels/AssetEditorPanel.jsx";
import { AssetLibrary } from "./panels/AssetLibrary.jsx";
import { PosePanel } from "./panels/PosePanel.jsx";
import { SettingsPanel } from "./panels/SettingsPanel.jsx";
import { SourcePanel } from "./panels/SourcePanel.jsx";

export function Workspace() {
  return (
    <main>
      <SourcePanel />
      <div className="resizer" data-resizer="sourcePose" title="Drag to resize panels" />
      <PosePanel />
      <AssetLibrary />
      <div className="resizer" data-resizer="poseSide" title="Drag to resize panels" />
      <AssetEditorPanel />
      <SettingsPanel />
    </main>
  );
}
