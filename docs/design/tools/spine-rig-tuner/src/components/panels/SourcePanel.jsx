import { Check, Scissors, Sparkles, WandSparkles, X } from "lucide-react";
import { IconButton } from "../IconButton.jsx";

export function SourcePanel() {
  return (
    <section className="workspace-section source-section" id="sourceSection">
      <div className="toolbar compact">
        <div className="toolbar-group">
          <span className="toolbar-group-label">Crop</span>
          <select id="selectionMode" title="Selection mode">
            <option value="rect">Rectangle</option>
            <option value="polygon">Polygon mask</option>
          </select>
          <IconButton id="finishPolygon" icon={Check} label="Close polygon" title="Finalize the current polygon shape before creating an asset" />
          <IconButton id="clearCrop" icon={X} label="Clear crop" />
        </div>

        <div className="toolbar-group">
          <span className="toolbar-group-label">Asset</span>
          <IconButton className="primary" id="createPart" icon={Scissors} label="Create asset" />
          <IconButton id="createOverlay" icon={Sparkles} label="Create overlay asset" />
          <IconButton id="extractSheetAssets" icon={WandSparkles} label="Extract sheet" title="Automatically split the transparent sheet into connected cutout assets" />
        </div>
      </div>

      <div className="canvas-wrap">
        <canvas id="sourceCanvas" />
      </div>
    </section>
  );
}
