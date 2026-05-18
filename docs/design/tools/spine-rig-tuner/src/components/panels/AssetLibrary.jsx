export function AssetLibrary() {
  return (
    <div className="asset-library" id="assetLibrary">
      <div className="toolbar">
        <div className="toolbar-group">
          <strong>Asset Library</strong>
          <span className="hint">Crop assets appear here. Drag one onto Pose Preview to place it.</span>
        </div>
      </div>
      <div className="asset-library-body" id="assetList" />
    </div>
  );
}
