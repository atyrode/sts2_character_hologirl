import { ChevronDown } from "lucide-react";
import { IconButton } from "../IconButton.jsx";

export function AssetLibrary() {
  return (
    <div className="asset-library" id="assetLibrary">
      <div className="toolbar">
        <div className="toolbar-group">
          <IconButton className="collapse-button" data-collapse-target="assetLibrary" icon={ChevronDown} label="Collapse asset library" />
          <strong>Asset Library</strong>
          <span className="hint">Crop assets appear here. Drag one onto Pose Preview to place it.</span>
        </div>
      </div>
      <div className="asset-library-body" id="assetList" />
    </div>
  );
}
