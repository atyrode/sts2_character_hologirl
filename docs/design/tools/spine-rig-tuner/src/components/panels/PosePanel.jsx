import { SettingsPanel } from "./SettingsPanel.jsx";

export function PosePanel() {
  return (
    <section className="workspace-section pose-section" id="poseSection">
      <div className="toolbar">
        <div className="toolbar-group">
          <strong>Pose Preview</strong>
          <span className="hint">Drag assembled rig pieces here.</span>
        </div>
      </div>

      <div className="pose-body">
        <div className="canvas-wrap">
          <canvas id="poseCanvas" width="900" height="900" />
        </div>
        <SettingsPanel />
      </div>
    </section>
  );
}
