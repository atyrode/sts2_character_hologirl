import { FlipHorizontal, FlipVertical } from "lucide-react";
import { IconButton } from "../../IconButton.jsx";

export function PartInspector() {
  return (
    <div className="panel selected-part-panel">
      <div className="fixed-panel-title">Selected Part</div>
      <div className="part-editor">
        <TransformSection />
        <PivotSection />
        <RenderSection />
      </div>
    </div>
  );
}

function TransformSection() {
  return (
    <div className="control-section">
      <div className="control-section-title">Transform</div>
      <div className="number-grid transform-grid">
        <label>X <input id="xInput" type="number" step="1" /></label>
        <label>Y <input id="yInput" type="number" step="1" /></label>
        <label>Z <input id="zInput" type="number" step="1" /></label>
        <label className="new-grid-row">Rot <input id="rotInput" type="number" step="1" /></label>
        <label>Scale <input id="scaleInput" type="number" step="0.01" /></label>
        <div className="grid-button-cell">
          <IconButton className="tool-button" id="flipXButton" icon={FlipHorizontal} label="Flip selected part horizontally" />
        </div>
        <div className="grid-button-cell">
          <IconButton className="tool-button" id="flipYButton" icon={FlipVertical} label="Flip selected part vertically" />
        </div>
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
    </div>
  );
}
