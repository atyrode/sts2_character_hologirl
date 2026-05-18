export function PartInspector() {
  return (
    <div className="panel">
      <h2>Selected Part</h2>
      <div className="part-editor">
        <IdentitySection />
        <TransformSection />
        <PivotSection />
        <RenderSection />
        <div className="button-row">
          <button id="duplicatePart" type="button">Duplicate</button>
          <button className="danger" id="deletePart" type="button">Delete</button>
        </div>
      </div>
    </div>
  );
}

function IdentitySection() {
  return (
    <div className="control-section">
      <div className="control-section-title">Identity</div>
      <div className="identity-grid">
        <label>Name<input id="selectedNameInput" type="text" /></label>
        <label>Slot<select id="selectedSlotInput" /></label>
      </div>
    </div>
  );
}

function TransformSection() {
  return (
    <div className="control-section">
      <div className="control-section-title">Transform</div>
      <div className="number-grid">
        <label>X <input id="xInput" type="number" step="1" /></label>
        <label>Y <input id="yInput" type="number" step="1" /></label>
        <label>Rot <input id="rotInput" type="number" step="1" /></label>
        <label>Scale <input id="scaleInput" type="number" step="0.01" /></label>
        <label>Z <input id="zInput" type="number" step="1" /></label>
      </div>
      <div className="button-row">
        <button className="tool-button" id="flipXButton" type="button" title="Mirror selected part horizontally">Flip X</button>
        <button className="tool-button" id="flipYButton" type="button" title="Mirror selected part vertically">Flip Y</button>
      </div>
    </div>
  );
}

function PivotSection() {
  return (
    <div className="control-section">
      <div className="control-section-title">Pivot</div>
      <div className="number-grid two">
        <label>Pivot X <input id="pivotXInput" type="number" step="1" /></label>
        <label>Pivot Y <input id="pivotYInput" type="number" step="1" /></label>
      </div>
    </div>
  );
}

function RenderSection() {
  return (
    <div className="control-section">
      <div className="control-section-title">Render</div>
      <div className="number-grid two">
        <label>Opacity <input id="opacityInput" type="number" min="0" max="1" step="0.05" /></label>
        <label>Bright <input id="brightnessInput" type="number" min="0" max="2" step="0.05" /></label>
      </div>
      <div className="button-row">
        <button className="tool-button" id="visibleButton" type="button">Visible</button>
        <button className="tool-button" id="lockedButton" type="button">Unlocked</button>
      </div>
    </div>
  );
}
