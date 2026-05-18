export function PosePanel() {
  return (
    <section className="workspace-section pose-section" id="poseSection">
      <div className="toolbar">
        <div className="toolbar-group">
          <button className="collapse-button" data-collapse-target="poseSection" title="Collapse pose panel">▾</button>
          <strong>Pose Preview</strong>
          <span className="hint">Drag assembled rig pieces here.</span>
        </div>

        <div className="toolbar-group">
          <span className="toolbar-group-label">View</span>
          <button id="toggleAlpha">Alpha Preview: On</button>
          <button id="resetView">Reset Pose</button>
        </div>
      </div>

      <div className="canvas-wrap">
        <canvas id="poseCanvas" width="900" height="900" />
      </div>
    </section>
  );
}
