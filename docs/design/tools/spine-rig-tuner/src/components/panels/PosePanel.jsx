import { ChevronDown, Image, RotateCcw } from "lucide-react";
import { IconButton } from "../IconButton.jsx";

export function PosePanel() {
  return (
    <section className="workspace-section pose-section" id="poseSection">
      <div className="toolbar">
        <div className="toolbar-group">
          <IconButton className="collapse-button" data-collapse-target="poseSection" icon={ChevronDown} label="Collapse pose panel" />
          <strong>Pose Preview</strong>
          <span className="hint">Drag assembled rig pieces here.</span>
        </div>

        <div className="toolbar-group">
          <span className="toolbar-group-label">View</span>
          <IconButton id="toggleAlpha" icon={Image} label="Toggle alpha preview" />
          <IconButton id="resetView" icon={RotateCcw} label="Reset pose" />
        </div>
      </div>

      <div className="canvas-wrap">
        <canvas id="poseCanvas" width="900" height="900" />
      </div>
    </section>
  );
}
