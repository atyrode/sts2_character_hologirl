export function SourcePanel() {
  return (
    <section className="workspace-section source-section" id="sourceSection">
      <div className="toolbar compact">
        <div className="toolbar-group">
          <button className="collapse-button" data-collapse-target="sourceSection" title="Collapse source panel">▾</button>
          <span className="toolbar-group-label">Crop</span>
          <select id="selectionMode" title="Selection mode">
            <option value="rect">Rectangle</option>
            <option value="polygon">Polygon mask</option>
          </select>
          <button id="finishPolygon" title="Finalize the current polygon shape before creating a part">Close Polygon</button>
          <button id="clearCrop">Clear Crop</button>
        </div>

        <div className="toolbar-group">
          <span className="toolbar-group-label">Part</span>
          <select id="slotSelect" title="Part slot" />
          <input id="partName" type="text" placeholder="part name (auto from slot)" />
          <button className="primary" id="createPart">Create Part</button>
          <button id="createOverlay">Create Overlay</button>
          <button id="extractSheetAssets" title="Automatically split the transparent sheet into connected cutout assets">Extract Sheet</button>
        </div>
      </div>

      <div className="canvas-wrap">
        <canvas id="sourceCanvas" />
      </div>
    </section>
  );
}
