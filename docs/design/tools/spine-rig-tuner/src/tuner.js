export function initSpineRigTuner() {
    const artArchivePrefix = "../../art_archive/";
    const artArchiveBase = import.meta.env.DEV ? "/art_archive/" : artArchivePrefix;

    function resolveToolAsset(path) {
      return path.replace(artArchivePrefix, artArchiveBase);
    }

const sheets = {
      a: {
        name: "sheet-a-broad",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-a-broad.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-a-broad-transparent.png"
      },
      b: {
        name: "sheet-b-strict",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-b-strict.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-b-strict-transparent.png"
      },
      c: {
        name: "sheet-c-no-ball-joints",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-c-no-ball-joints.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-c-no-ball-joints-transparent.png"
      },
      d: {
        name: "sheet-d-scratch",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-d-scratch.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-d-scratch-transparent.png"
      },
      e: {
        name: "sheet-e-overlap-rig",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-e-overlap-rig.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-e-overlap-rig-transparent.png"
      },
      f: {
        name: "sheet-f-overlap-rig-3q",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-f-overlap-rig-3q.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-f-overlap-rig-3q-transparent.png"
      },
      g: {
        name: "sheet-g-hologram-magenta",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-g-hologram-magenta.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-g-hologram-magenta-transparent.png"
      },
      h: {
        name: "sheet-h-hologram-magenta",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-h-hologram-magenta.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-h-hologram-magenta-transparent.png"
      },
      i: {
        name: "sheet-i-hologram-magenta",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-i-hologram-magenta.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-i-hologram-magenta-transparent.png"
      },
      j: {
        name: "sheet-j-linework-grip-ponytails",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-j-linework-grip-ponytails.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-j-linework-grip-ponytails-transparent.png"
      },
      k: {
        name: "sheet-k-linework-grip-ponytails",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-k-linework-grip-ponytails.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-k-linework-grip-ponytails-transparent.png"
      },
      l: {
        name: "sheet-l-linework-grip-ponytails",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-l-linework-grip-ponytails.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-l-linework-grip-ponytails-transparent.png"
      },
      m: {
        name: "sheet-m-granular-body",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-m-granular-body.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-m-granular-body-transparent.png"
      },
      n: {
        name: "sheet-n-granular-body",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-n-granular-body.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-n-granular-body-transparent.png"
      },
      o: {
        name: "sheet-o-clothing-depth",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-o-clothing-depth.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-o-clothing-depth-transparent.png"
      },
      p: {
        name: "sheet-p-hair-depth",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-p-hair-depth.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-p-hair-depth-transparent.png"
      },
      q: {
        name: "sheet-q-clean-minimal-depth",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-q-clean-minimal-depth.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-q-clean-minimal-depth-transparent.png"
      },
      r: {
        name: "sheet-r-separated-clothes",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-r-separated-clothes.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-r-separated-clothes-transparent.png"
      },
      s: {
        name: "sheet-s-essential-separated",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-s-essential-separated.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-s-essential-separated-transparent.png"
      },
      t: {
        name: "sheet-t-essential-separated",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-t-essential-separated.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-t-essential-separated-transparent.png"
      },
      u: {
        name: "sheet-u-essential-separated",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-u-essential-separated.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-u-essential-separated-transparent.png"
      },
      v: {
        name: "sheet-v-essential-separated",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-v-essential-separated.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-v-essential-separated-transparent.png"
      },
      w: {
        name: "sheet-w-essential-separated",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-w-essential-separated.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-w-essential-separated-transparent.png"
      },
      x: {
        name: "sheet-x-essential-separated",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-x-essential-separated.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-x-essential-separated-transparent.png"
      },
      y: {
        name: "sheet-y-essential-separated",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-y-essential-separated.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-y-essential-separated-transparent.png"
      },
      z: {
        name: "sheet-z-essential-separated",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-z-essential-separated.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-z-essential-separated-transparent.png"
      },
      aa: {
        name: "sheet-aa-essential-separated",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-aa-essential-separated.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-aa-essential-separated-transparent.png"
      },
      ab: {
        name: "sheet-ab-essential-separated",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-ab-essential-separated.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-ab-essential-separated-transparent.png"
      },
      ac: {
        name: "sheet-ac-essential-separated",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-ac-essential-separated.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-ac-essential-separated-transparent.png"
      },
      ad: {
        name: "sheet-ad-essential-separated",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-ad-essential-separated.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/sheet-ad-essential-separated-transparent.png"
      },
      fullA: {
        name: "full-body-a",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/full-body-a.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/full-body-a-transparent.png"
      },
      fullB: {
        name: "full-body-b",
        chroma: "../../art_archive/character/spine/attempt-003-rig-sheets/full-body-b.png",
        alpha: "../../art_archive/character/spine/attempt-003-rig-sheets/full-body-b-transparent.png"
      }
    };

    const slots = [
      "head", "face_overlay", "neck_under", "hair_bangs", "hair_back",
      "hair_ponytail_near", "hair_ponytail_far",
      "torso_core", "torso_upper", "torso_lower", "torso_back", "torso_front_overlay",
      "shoulder_pad_near", "shoulder_pad_far", "collar_back", "collar_front", "chest_trim_front",
      "belt_back", "belt_front", "pelvis_core", "skirt_back", "skirt_under_layer",
      "skirt_front_center", "skirt_front_near", "skirt_front_far", "skirt_side_near", "skirt_side_far",
      "upper_arm_near", "elbow_under_near", "forearm_near", "hand_near", "sleeve_back_near", "sleeve_cuff_front_near",
      "upper_arm_far", "elbow_under_far", "forearm_far", "hand_far", "sleeve_back_far", "sleeve_cuff_front_far",
      "upper_leg_near_under_skirt", "lower_leg_near", "boot_near", "boot_cuff_front_near",
      "upper_leg_far_under_skirt", "lower_leg_far", "boot_far", "boot_cuff_front_far",
      "whip_handle", "hand_whip_grip_near", "hand_whip_grip_far", "whip_curve", "shadow", "overlay_extra", "extra"
    ];

    const sourceCanvas = document.getElementById("sourceCanvas");
    const sourceCtx = sourceCanvas.getContext("2d");
    const poseCanvas = document.getElementById("poseCanvas");
    const poseCtx = poseCanvas.getContext("2d");
    const sheetSelect = document.getElementById("sheetSelect");
    const statusEl = document.getElementById("status");
    const partsList = document.getElementById("partsList");
    const assetList = document.getElementById("assetList");
    const jsonBox = document.getElementById("jsonBox");
    const saveNameInput = document.getElementById("saveNameInput");
    const saveSelect = document.getElementById("saveSelect");
    const assetEditorCanvas = document.getElementById("assetEditorCanvas");
    const assetEditorCtx = assetEditorCanvas.getContext("2d");
    const assetInputs = {
      slot: document.getElementById("assetSlotInput"),
      name: document.getElementById("assetNameInput"),
      cropX: document.getElementById("assetCropXInput"),
      cropY: document.getElementById("assetCropYInput"),
      cropW: document.getElementById("assetCropWInput"),
      cropH: document.getElementById("assetCropHInput"),
      brush: document.getElementById("assetBrushInput"),
      brushMode: document.getElementById("assetBrushModeInput")
    };

    const inputs = {
      x: document.getElementById("xInput"),
      y: document.getElementById("yInput"),
      rotation: document.getElementById("rotInput"),
      scale: document.getElementById("scaleInput"),
      pivotX: document.getElementById("pivotXInput"),
      pivotY: document.getElementById("pivotYInput"),
      z: document.getElementById("zInput"),
      opacity: document.getElementById("opacityInput"),
      brightness: document.getElementById("brightnessInput")
    };

    const partButtons = {
      flipX: document.getElementById("flipXButton"),
      flipY: document.getElementById("flipYButton"),
      visible: document.getElementById("visibleButton"),
      locked: document.getElementById("lockedButton")
    };

    let sourceImage = new Image();
    let alphaPreview = true;
    let activeSheet = "a";
    let crop = null;
    let cropDrag = null;
    let selectionMode = "rect";
    let polygonPoints = [];
    let polygonClickStart = null;
    let assets = [];
    let parts = [];
    let selectedId = null;
    let selectedPartIds = new Set();
    let selectedAssetId = null;
    let poseDrag = null;
    let poseSelectionDrag = null;
    let sourceZoom = 1;
    let poseZoom = 1;
    let copiedPart = null;
    let assetEditDrag = false;
    let assetEditorView = null;
    let assetUndoStack = [];
    let assetRedoStack = [];
    let assetHistoryId = null;
    const partImages = new Map();
    const assetImages = new Map();
    let idCounter = 0;
    let autosaveTimer = null;
    const storageKey = "hologirl-spine-rig-tuner-v1";
    const savesIndexKey = "hologirl-spine-rig-tuner-saves-v1";
    const savePrefix = "hologirl-spine-rig-tuner-save-v1:";
    const repoSavesIndexPath = "saves/index.json";
    let repoSaveEntries = [];
    let saveDirectoryHandle = null;
    let renderedSaveEntries = [];
    let poseFramePending = false;
    let normalizePanelLayout = null;

    slots.forEach(slot => {
      const option = document.createElement("option");
      option.value = slot;
      option.textContent = slot;
      assetInputs.slot.append(option.cloneNode(true));
    });

    function setStatus(text) {
      statusEl.classList.remove("saved");
      statusEl.textContent = text;
    }

    function setSavedStatus(text) {
      statusEl.classList.add("saved");
      statusEl.textContent = text;
    }

    function makeId() {
      if (globalThis.crypto && typeof globalThis.crypto.randomUUID === "function") {
        return globalThis.crypto.randomUUID();
      }
      idCounter += 1;
      return `part-${Date.now()}-${idCounter}`;
    }

    function iconSvg(name) {
      const icons = {
        eye: '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7-10-7-10-7Z"/><circle cx="12" cy="12" r="3"/></svg>',
        eyeOff: '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="m2 2 20 20"/><path d="M6.7 6.7C3.7 8.6 2 12 2 12s3.5 7 10 7c1.8 0 3.3-.5 4.6-1.2"/><path d="M19.4 15.4C21.1 13.8 22 12 22 12s-3.5-7-10-7c-.9 0-1.8.1-2.6.4"/><path d="M9.9 9.9a3 3 0 0 0 4.2 4.2"/></svg>',
        lock: '<svg viewBox="0 0 24 24" aria-hidden="true"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>',
        unlock: '<svg viewBox="0 0 24 24" aria-hidden="true"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 9.5-2.2"/></svg>',
        trash: '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M3 6h18"/><path d="M8 6V4h8v2"/><path d="M19 6l-1 16H6L5 6"/><path d="M10 11v6"/><path d="M14 11v6"/></svg>'
      };
      return icons[name] || "";
    }

    function loadSheet() {
      const sheet = sheets[activeSheet];
      sourceImage = new Image();
      sourceImage.onload = () => {
        sourceCanvas.width = sourceImage.naturalWidth;
        sourceCanvas.height = sourceImage.naturalHeight;
        applyCanvasZoom(sourceCanvas, sourceZoom);
        applyCanvasZoom(poseCanvas, poseZoom);
        crop = null;
        rebuildAssetImages();
        rebuildPartImages();
        drawSource();
        renderAssetLibrary();
        drawAssetEditor();
        drawPose();
        setStatus(`${sheet.name} loaded (${sourceImage.naturalWidth}x${sourceImage.naturalHeight})`);
      };
      sourceImage.onerror = () => {
        sourceCanvas.width = 900;
        sourceCanvas.height = 900;
        applyCanvasZoom(sourceCanvas, sourceZoom);
        applyCanvasZoom(poseCanvas, poseZoom);
        crop = null;
        drawSource();
        drawPose();
        setStatus(`Could not load ${sheet.name}. Check tuner asset path.`);
      };
      sourceImage.src = resolveToolAsset(alphaPreview ? sheet.alpha : sheet.chroma);
    }

    function applyCanvasZoom(canvas, zoom) {
      canvas.style.width = `${canvas.width * zoom}px`;
      canvas.style.height = `${canvas.height * zoom}px`;
    }

    function setupCanvasZoom(canvas, getZoom, setZoom) {
      canvas.parentElement.addEventListener("wheel", event => {
        if (!event.ctrlKey) return;
        event.preventDefault();
        const wrap = canvas.parentElement;
        const before = canvasPoint(event, canvas);
        const nextZoom = Math.max(0.2, Math.min(5, getZoom() * (event.deltaY < 0 ? 1.12 : 0.88)));
        setZoom(nextZoom);
        applyCanvasZoom(canvas, nextZoom);
        const afterX = before.x * nextZoom;
        const afterY = before.y * nextZoom;
        wrap.scrollLeft = afterX - (event.clientX - wrap.getBoundingClientRect().left);
        wrap.scrollTop = afterY - (event.clientY - wrap.getBoundingClientRect().top);
      }, { passive: false });
    }

    function setupMiddleMousePan(canvas) {
      const wrap = canvas.parentElement;
      wrap.addEventListener("pointerdown", event => {
        if (event.button !== 1) return;
        event.preventDefault();
        const startX = event.clientX;
        const startY = event.clientY;
        const startScrollLeft = wrap.scrollLeft;
        const startScrollTop = wrap.scrollTop;
        wrap.classList.add("panning");
        wrap.setPointerCapture(event.pointerId);

        function move(moveEvent) {
          wrap.scrollLeft = startScrollLeft - (moveEvent.clientX - startX);
          wrap.scrollTop = startScrollTop - (moveEvent.clientY - startY);
        }

        function up() {
          wrap.classList.remove("panning");
          wrap.removeEventListener("pointermove", move);
          wrap.removeEventListener("pointerup", up);
          wrap.removeEventListener("pointercancel", up);
        }

        wrap.addEventListener("pointermove", move);
        wrap.addEventListener("pointerup", up);
        wrap.addEventListener("pointercancel", up);
      });

      wrap.addEventListener("auxclick", event => {
        if (event.button === 1) event.preventDefault();
      });
    }

    function drawSource() {
      sourceCtx.clearRect(0, 0, sourceCanvas.width, sourceCanvas.height);
      if (sourceImage.complete && sourceImage.naturalWidth > 0) {
        sourceCtx.drawImage(sourceImage, 0, 0);
      } else {
        sourceCtx.save();
        sourceCtx.fillStyle = "#20232b";
        sourceCtx.fillRect(0, 0, sourceCanvas.width, sourceCanvas.height);
        sourceCtx.strokeStyle = "#363b47";
        sourceCtx.lineWidth = 1;
        for (let x = 0; x < sourceCanvas.width; x += 50) {
          sourceCtx.beginPath();
          sourceCtx.moveTo(x, 0);
          sourceCtx.lineTo(x, sourceCanvas.height);
          sourceCtx.stroke();
        }
        for (let y = 0; y < sourceCanvas.height; y += 50) {
          sourceCtx.beginPath();
          sourceCtx.moveTo(0, y);
          sourceCtx.lineTo(sourceCanvas.width, y);
          sourceCtx.stroke();
        }
        sourceCtx.restore();
      }
      if (crop) {
        sourceCtx.save();
        sourceCtx.strokeStyle = "#ffffff";
        sourceCtx.lineWidth = 3;
        sourceCtx.setLineDash([10, 6]);
        sourceCtx.strokeRect(crop.x, crop.y, crop.w, crop.h);
        sourceCtx.fillStyle = "rgba(144,168,255,.16)";
        sourceCtx.fillRect(crop.x, crop.y, crop.w, crop.h);
        sourceCtx.restore();
      }
      if (polygonPoints.length > 0) {
        sourceCtx.save();
        sourceCtx.strokeStyle = "#ffcf66";
        sourceCtx.fillStyle = "rgba(255,207,102,.16)";
        sourceCtx.lineWidth = 3;
        sourceCtx.beginPath();
        polygonPoints.forEach((point, index) => {
          if (index === 0) sourceCtx.moveTo(point.x, point.y);
          else sourceCtx.lineTo(point.x, point.y);
        });
        if (polygonPoints.length >= 3) sourceCtx.closePath();
        if (polygonPoints.length >= 3) sourceCtx.fill();
        sourceCtx.stroke();
        polygonPoints.forEach(point => {
          sourceCtx.beginPath();
          sourceCtx.arc(point.x, point.y, 5, 0, Math.PI * 2);
          sourceCtx.fill();
        });
        sourceCtx.restore();
      }
    }

    function drawPose() {
      poseFramePending = false;
      poseCtx.clearRect(0, 0, poseCanvas.width, poseCanvas.height);
      poseCtx.save();
      poseCtx.fillStyle = "#20232b";
      poseCtx.fillRect(0, 0, poseCanvas.width, poseCanvas.height);
      poseCtx.strokeStyle = "#363b47";
      poseCtx.lineWidth = 1;
      for (let x = 0; x < poseCanvas.width; x += 50) {
        poseCtx.beginPath();
        poseCtx.moveTo(x, 0);
        poseCtx.lineTo(x, poseCanvas.height);
        poseCtx.stroke();
      }
      for (let y = 0; y < poseCanvas.height; y += 50) {
        poseCtx.beginPath();
        poseCtx.moveTo(0, y);
        poseCtx.lineTo(poseCanvas.width, y);
        poseCtx.stroke();
      }
      poseCtx.strokeStyle = "#5a6172";
      poseCtx.beginPath();
      poseCtx.moveTo(poseCanvas.width / 2, 0);
      poseCtx.lineTo(poseCanvas.width / 2, poseCanvas.height);
      poseCtx.moveTo(0, poseCanvas.height / 2);
      poseCtx.lineTo(poseCanvas.width, poseCanvas.height / 2);
      poseCtx.stroke();
      poseCtx.restore();

      [...parts]
        .filter(part => part.visible)
        .sort((a, b) => a.z - b.z)
        .forEach(drawPart);

      if (poseSelectionDrag?.rect) {
        const rect = poseSelectionDrag.rect;
        poseCtx.save();
        poseCtx.strokeStyle = "#90a8ff";
        poseCtx.fillStyle = "rgba(144,168,255,.14)";
        poseCtx.setLineDash([8, 5]);
        poseCtx.lineWidth = 2;
        poseCtx.fillRect(rect.x, rect.y, rect.w, rect.h);
        poseCtx.strokeRect(rect.x, rect.y, rect.w, rect.h);
        poseCtx.restore();
      }
    }

    function requestPoseDraw() {
      if (poseFramePending) return;
      poseFramePending = true;
      requestAnimationFrame(drawPose);
    }

    function drawPart(part) {
      poseCtx.save();
      poseCtx.translate(part.x, part.y);
      poseCtx.rotate(part.rotation * Math.PI / 180);
      const scaleX = (part.flipX ? -1 : 1) * part.scale;
      const scaleY = (part.flipY ? -1 : 1) * part.scale;
      poseCtx.scale(scaleX, scaleY);
      poseCtx.globalAlpha = part.opacity ?? 1;
      poseCtx.filter = `brightness(${part.brightness ?? 1})`;
      const image = partImages.get(part.id);
      if (image) {
        poseCtx.drawImage(image, -part.pivotX, -part.pivotY);
      } else {
        poseCtx.drawImage(
          sourceImage,
          part.crop.x, part.crop.y, part.crop.w, part.crop.h,
          -part.pivotX, -part.pivotY, part.crop.w, part.crop.h
        );
      }
      poseCtx.globalAlpha = 1;
      poseCtx.filter = "none";
      if (selectedPartIds.has(part.id)) {
        poseCtx.strokeStyle = part.id === selectedId ? "#90a8ff" : "#8ee6b2";
        poseCtx.lineWidth = 3 / Math.max(0.01, Math.abs(part.scale));
        poseCtx.strokeRect(-part.pivotX, -part.pivotY, part.crop.w, part.crop.h);
        poseCtx.fillStyle = "#ffcf66";
        poseCtx.beginPath();
        poseCtx.arc(0, 0, 6 / Math.max(0.01, part.scale), 0, Math.PI * 2);
        poseCtx.fill();
      }
      poseCtx.restore();
    }

    function rebuildPartImages() {
      partImages.clear();
      parts.forEach(rebuildPartImage);
    }

    function rebuildAssetImages() {
      assetImages.clear();
      assets.forEach(rebuildAssetImage);
    }

    function buildCutoutImage(item) {
      if (!sourceImage.complete || !item.crop) return null;
      const canvas = document.createElement("canvas");
      canvas.width = item.crop.w;
      canvas.height = item.crop.h;
      const ctx = canvas.getContext("2d");
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      ctx.drawImage(
        sourceImage,
        item.crop.x, item.crop.y, item.crop.w, item.crop.h,
        0, 0, item.crop.w, item.crop.h
      );
      if (item.mask && item.mask.length >= 3) {
        ctx.globalCompositeOperation = "destination-in";
        ctx.beginPath();
        item.mask.forEach((point, index) => {
          if (index === 0) ctx.moveTo(point.x, point.y);
          else ctx.lineTo(point.x, point.y);
        });
        ctx.closePath();
        ctx.fill();
        ctx.globalCompositeOperation = "source-over";
      }
      if (item.alphaMask?.type === "rowSpans") {
        ctx.globalCompositeOperation = "destination-in";
        ctx.fillStyle = "#fff";
        if (item.alphaMask.spans?.length) {
          ctx.beginPath();
          item.alphaMask.spans.forEach(([y, x1, x2]) => {
            ctx.rect(x1, y, x2 - x1 + 1, 1);
          });
          ctx.fill();
        } else {
          ctx.clearRect(0, 0, canvas.width, canvas.height);
        }
        ctx.globalCompositeOperation = "source-over";
      }
      return canvas;
    }

    function rebuildAssetImage(asset) {
      const canvas = buildCutoutImage(asset);
      if (canvas) assetImages.set(asset.id, canvas);
    }

    function rebuildPartImage(part) {
      const canvas = buildCutoutImage(part);
      if (canvas) partImages.set(part.id, canvas);
    }

    function selectedPart() {
      return parts.find(part => part.id === selectedId) || null;
    }

    function selectedAsset() {
      return assets.find(asset => asset.id === selectedAssetId) || null;
    }

    function clampAssetCrop(asset) {
      if (!asset?.crop || !sourceCanvas.width || !sourceCanvas.height) return;
      asset.crop.x = Math.max(0, Math.min(sourceCanvas.width - 1, Math.round(Number(asset.crop.x) || 0)));
      asset.crop.y = Math.max(0, Math.min(sourceCanvas.height - 1, Math.round(Number(asset.crop.y) || 0)));
      asset.crop.w = Math.max(1, Math.min(sourceCanvas.width - asset.crop.x, Math.round(Number(asset.crop.w) || 1)));
      asset.crop.h = Math.max(1, Math.min(sourceCanvas.height - asset.crop.y, Math.round(Number(asset.crop.h) || 1)));
    }

    function pointInPolygon(x, y, points) {
      let inside = false;
      for (let i = 0, j = points.length - 1; i < points.length; j = i, i += 1) {
        const xi = points[i].x;
        const yi = points[i].y;
        const xj = points[j].x;
        const yj = points[j].y;
        const intersects = ((yi > y) !== (yj > y))
          && x < ((xj - xi) * (y - yi)) / ((yj - yi) || 0.000001) + xi;
        if (intersects) inside = !inside;
      }
      return inside;
    }

    function baseVisibilityMap(asset) {
      clampAssetCrop(asset);
      const width = asset.crop.w;
      const height = asset.crop.h;
      const visible = new Uint8Array(width * height);
      if (!sourceImage.complete || width <= 0 || height <= 0) return visible;

      const canvas = document.createElement("canvas");
      canvas.width = width;
      canvas.height = height;
      const ctx = canvas.getContext("2d", { willReadFrequently: true });
      ctx.drawImage(sourceImage, asset.crop.x, asset.crop.y, width, height, 0, 0, width, height);
      const pixels = ctx.getImageData(0, 0, width, height).data;
      for (let index = 0; index < visible.length; index += 1) {
        const x = index % width;
        const y = Math.floor(index / width);
        const insideMask = !asset.mask?.length || pointInPolygon(x + 0.5, y + 0.5, asset.mask);
        visible[index] = insideMask && pixels[index * 4 + 3] > 24 ? 1 : 0;
      }
      return visible;
    }

    function currentVisibilityMap(asset) {
      const width = asset.crop.w;
      const height = asset.crop.h;
      if (asset.alphaMask?.type !== "rowSpans") return baseVisibilityMap(asset);
      const visible = new Uint8Array(width * height);
      asset.alphaMask.spans?.forEach(([y, x1, x2]) => {
        if (y < 0 || y >= height) return;
        const start = Math.max(0, x1);
        const end = Math.min(width - 1, x2);
        for (let x = start; x <= end; x += 1) {
          visible[y * width + x] = 1;
        }
      });
      return visible;
    }

    function visibilityToRowSpans(visible, width, height) {
      const spans = [];
      for (let y = 0; y < height; y += 1) {
        let start = -1;
        for (let x = 0; x < width; x += 1) {
          const value = visible[y * width + x];
          if (value && start < 0) start = x;
          if ((!value || x === width - 1) && start >= 0) {
            spans.push([y, start, value && x === width - 1 ? x : x - 1]);
            start = -1;
          }
        }
      }
      return { type: "rowSpans", spans };
    }

    function cloneAssetEditState(asset) {
      return {
        crop: { ...asset.crop },
        mask: asset.mask ? JSON.parse(JSON.stringify(asset.mask)) : null,
        alphaMask: asset.alphaMask ? JSON.parse(JSON.stringify(asset.alphaMask)) : null
      };
    }

    function restoreAssetEditState(asset, state) {
      asset.crop = { ...state.crop };
      asset.mask = state.mask ? JSON.parse(JSON.stringify(state.mask)) : null;
      asset.alphaMask = state.alphaMask ? JSON.parse(JSON.stringify(state.alphaMask)) : null;
      rebuildAssetImage(asset);
      renderAssetLibrary();
      drawAssetEditor();
      scheduleAutosave();
    }

    function resetAssetHistory(assetId = selectedAssetId) {
      assetHistoryId = assetId || null;
      assetUndoStack = [];
      assetRedoStack = [];
      updateAssetHistoryButtons();
    }

    function pushAssetUndo(asset) {
      if (!asset) return;
      if (assetHistoryId !== asset.id) resetAssetHistory(asset.id);
      assetUndoStack.push(cloneAssetEditState(asset));
      if (assetUndoStack.length > 60) assetUndoStack.shift();
      assetRedoStack = [];
      updateAssetHistoryButtons();
    }

    function undoAssetEdit() {
      const asset = selectedAsset();
      if (!asset || !assetUndoStack.length) return;
      assetRedoStack.push(cloneAssetEditState(asset));
      restoreAssetEditState(asset, assetUndoStack.pop());
      updateAssetHistoryButtons();
      setStatus(`Undid edit on ${asset.name}.`);
    }

    function redoAssetEdit() {
      const asset = selectedAsset();
      if (!asset || !assetRedoStack.length) return;
      assetUndoStack.push(cloneAssetEditState(asset));
      restoreAssetEditState(asset, assetRedoStack.pop());
      updateAssetHistoryButtons();
      setStatus(`Redid edit on ${asset.name}.`);
    }

    function updateAssetHistoryButtons() {
      const undoButton = document.getElementById("undoAssetEdit");
      const redoButton = document.getElementById("redoAssetEdit");
      if (!undoButton || !redoButton) return;
      const hasAsset = Boolean(selectedAsset());
      undoButton.disabled = !hasAsset || assetUndoStack.length === 0;
      redoButton.disabled = !hasAsset || assetRedoStack.length === 0;
    }

    function assetEditorPoint(event) {
      if (!assetEditorView) return null;
      const rect = assetEditorCanvas.getBoundingClientRect();
      const canvasX = (event.clientX - rect.left) * assetEditorCanvas.width / rect.width;
      const canvasY = (event.clientY - rect.top) * assetEditorCanvas.height / rect.height;
      return {
        x: Math.floor((canvasX - assetEditorView.x) / assetEditorView.scale),
        y: Math.floor((canvasY - assetEditorView.y) / assetEditorView.scale)
      };
    }

    function paintAssetMask(point) {
      const asset = selectedAsset();
      if (!asset || !point) return;
      clampAssetCrop(asset);
      if (point.x < 0 || point.y < 0 || point.x >= asset.crop.w || point.y >= asset.crop.h) return;

      const base = baseVisibilityMap(asset);
      const visible = currentVisibilityMap(asset);
      const radius = Math.max(1, Number(assetInputs.brush.value) || 1);
      const radiusSq = radius * radius;
      const restore = assetInputs.brushMode.value === "restore";
      for (let y = Math.max(0, point.y - radius); y <= Math.min(asset.crop.h - 1, point.y + radius); y += 1) {
        for (let x = Math.max(0, point.x - radius); x <= Math.min(asset.crop.w - 1, point.x + radius); x += 1) {
          const dx = x - point.x;
          const dy = y - point.y;
          if (dx * dx + dy * dy > radiusSq) continue;
          const index = y * asset.crop.w + x;
          visible[index] = restore ? base[index] : 0;
        }
      }

      asset.alphaMask = visibilityToRowSpans(visible, asset.crop.w, asset.crop.h);
      rebuildAssetImage(asset);
      renderAssetLibrary();
      drawAssetEditor();
      scheduleAutosave();
    }

    function drawAssetEditor() {
      assetEditorCtx.clearRect(0, 0, assetEditorCanvas.width, assetEditorCanvas.height);
      const asset = selectedAsset();
      Object.values(assetInputs).forEach(input => input.disabled = !asset);
      assetEditorView = null;
      updateAssetHistoryButtons();
      if (!asset) {
        assetEditorCtx.fillStyle = "#aab0c0";
        assetEditorCtx.textAlign = "center";
        assetEditorCtx.fillText("Select an asset to edit", assetEditorCanvas.width / 2, assetEditorCanvas.height / 2);
        return;
      }

      clampAssetCrop(asset);
      assetInputs.slot.value = asset.slot;
      assetInputs.name.value = asset.name;
      assetInputs.cropX.value = asset.crop.x;
      assetInputs.cropY.value = asset.crop.y;
      assetInputs.cropW.value = asset.crop.w;
      assetInputs.cropH.value = asset.crop.h;

      const image = assetImages.get(asset.id) || buildCutoutImage(asset);
      if (!image) return;
      const padding = 12;
      const scale = Math.min(
        (assetEditorCanvas.width - padding * 2) / image.width,
        (assetEditorCanvas.height - padding * 2) / image.height,
        4
      );
      const width = image.width * scale;
      const height = image.height * scale;
      const x = (assetEditorCanvas.width - width) / 2;
      const y = (assetEditorCanvas.height - height) / 2;
      assetEditorView = { x, y, scale };
      assetEditorCtx.imageSmoothingEnabled = scale < 2;
      assetEditorCtx.drawImage(image, x, y, width, height);
      assetEditorCtx.strokeStyle = "#90a8ff";
      assetEditorCtx.lineWidth = 1;
      assetEditorCtx.strokeRect(x, y, width, height);
    }

    function setSelectedParts(ids, primaryId = ids[0] || null) {
      selectedPartIds = new Set(ids);
      selectedId = primaryId && selectedPartIds.has(primaryId) ? primaryId : ids[0] || null;
      selectedAssetId = null;
      syncInputs();
      renderPartsList();
      drawPose();
    }

    function clearPoseSelection() {
      selectedId = null;
      selectedPartIds = new Set();
      selectedAssetId = null;
      syncInputs();
      renderPartsList();
      drawPose();
    }

    function selectAsset(assetId) {
      selectedAssetId = assetId;
      selectedId = null;
      selectedPartIds = new Set();
      resetAssetHistory(assetId);
      setPanelCollapsed("assetEditorPanel", false);
      syncInputs();
      renderAssetLibrary();
      renderPartsList();
      drawPose();
    }

    function markAssetSelected(assetId) {
      selectedAssetId = assetId;
      selectedId = null;
      selectedPartIds = new Set();
      resetAssetHistory(assetId);
      syncInputs();
      renderPartsList();
      drawPose();
      assetList.querySelectorAll(".asset-card").forEach(card => {
        card.classList.toggle("selected", card.dataset.assetId === assetId);
      });
    }

    function syncPartButtons(part) {
      Object.values(partButtons).forEach(button => button.disabled = !part);
      if (!part) return;
      partButtons.flipX.classList.toggle("is-active", Boolean(part.flipX));
      partButtons.flipY.classList.toggle("is-active", Boolean(part.flipY));
      partButtons.visible.classList.toggle("is-active", part.visible !== false);
      partButtons.locked.classList.toggle("is-active", Boolean(part.locked));
      partButtons.visible.title = part.visible === false ? "Show selected part" : "Hide selected part";
      partButtons.visible.setAttribute("aria-label", partButtons.visible.title);
      partButtons.locked.title = part.locked ? "Unlock selected part" : "Lock selected part";
      partButtons.locked.setAttribute("aria-label", partButtons.locked.title);
    }

    function updateAlphaPreviewButton() {
      const button = document.getElementById("toggleAlpha");
      button.classList.toggle("is-active", alphaPreview);
      button.title = `${alphaPreview ? "Hide" : "Show"} transparent source sheets in pose preview`;
      button.setAttribute("aria-label", `Alpha preview ${alphaPreview ? "on" : "off"}`);
      button.setAttribute("aria-pressed", String(alphaPreview));
    }

    function syncInputs() {
      drawAssetEditor();
      const part = selectedPart();
      Object.values(inputs).forEach(input => input.disabled = !part);
      syncPartButtons(part);
      if (!part) return;
      inputs.x.value = Math.round(part.x);
      inputs.y.value = Math.round(part.y);
      inputs.rotation.value = Number(part.rotation.toFixed(2));
      inputs.scale.value = Number(part.scale.toFixed(3));
      inputs.pivotX.value = Math.round(part.pivotX);
      inputs.pivotY.value = Math.round(part.pivotY);
      inputs.z.value = part.z;
      inputs.opacity.value = part.opacity ?? 1;
      inputs.brightness.value = part.brightness ?? 1;
      ["x", "y", "rotation", "scale", "pivotX", "pivotY"].forEach(key => {
        inputs[key].disabled = Boolean(part.locked);
      });
    }

    function syncPositionInputs() {
      const part = selectedPart();
      if (!part) return;
      inputs.x.value = Math.round(part.x);
      inputs.y.value = Math.round(part.y);
    }

    function renderPartsList() {
      partsList.innerHTML = "";
      [...parts].sort((a, b) => b.z - a.z).forEach(part => {
        const row = document.createElement("div");
        row.className = `part-row${selectedPartIds.has(part.id) ? " selected" : ""}${part.locked ? " locked" : ""}`;
        row.innerHTML = `<span>${part.locked ? "[locked] " : ""}${part.visible ? "" : "[hidden] "}${part.name}<br><small>${part.slot}</small></span><span>z ${part.z}</span>`;
        const visibilityButton = document.createElement("button");
        visibilityButton.type = "button";
        visibilityButton.className = "icon-button";
        visibilityButton.title = part.visible ? "Hide part" : "Show part";
        visibilityButton.setAttribute("aria-label", part.visible ? "Hide part" : "Show part");
        visibilityButton.innerHTML = iconSvg(part.visible ? "eye" : "eyeOff");
        visibilityButton.onclick = event => {
          event.stopPropagation();
          part.visible = !part.visible;
          setSelectedParts([part.id], part.id);
          scheduleAutosave();
        };
        const lockButton = document.createElement("button");
        lockButton.type = "button";
        lockButton.className = "icon-button";
        lockButton.title = part.locked ? "Unlock part" : "Lock part";
        lockButton.setAttribute("aria-label", part.locked ? "Unlock part" : "Lock part");
        lockButton.innerHTML = iconSvg(part.locked ? "lock" : "unlock");
        lockButton.onclick = event => {
          event.stopPropagation();
          part.locked = !part.locked;
          setSelectedParts([part.id], part.id);
          scheduleAutosave();
        };
        row.append(visibilityButton);
        row.append(lockButton);
        row.onclick = () => setSelectedParts([part.id], part.id);
        partsList.append(row);
      });
    }

    function renderAssetLibrary() {
      assetList.innerHTML = "";
      assets.forEach(asset => {
        const card = document.createElement("div");
        card.className = `asset-card${asset.id === selectedAssetId ? " selected" : ""}`;
        card.draggable = true;
        card.dataset.assetId = asset.id;
        const header = document.createElement("div");
        header.className = "asset-card-header";
        header.innerHTML = `<span><small title="${asset.name}">${asset.name}</small><small>${asset.slot}</small></span>`;
        const deleteButton = document.createElement("button");
        deleteButton.type = "button";
        deleteButton.className = "icon-button";
        deleteButton.title = "Delete asset";
        deleteButton.setAttribute("aria-label", "Delete asset");
        deleteButton.innerHTML = iconSvg("trash");
        deleteButton.onclick = event => {
          event.stopPropagation();
          deleteAsset(asset.id);
        };
        header.append(deleteButton);
        const thumb = document.createElement("canvas");
        thumb.width = 110;
        thumb.height = 72;
        const thumbCtx = thumb.getContext("2d");
        const image = assetImages.get(asset.id);
        if (image) {
          const scale = Math.min(thumb.width / image.width, thumb.height / image.height, 1);
          const w = image.width * scale;
          const h = image.height * scale;
          thumbCtx.drawImage(image, (thumb.width - w) / 2, (thumb.height - h) / 2, w, h);
        }
        card.append(thumb);
        card.append(header);
        card.addEventListener("click", () => selectAsset(asset.id));
        card.addEventListener("dragstart", event => {
          markAssetSelected(asset.id);
          event.dataTransfer.setData("text/plain", asset.id);
          event.dataTransfer.effectAllowed = "copy";
          event.dataTransfer.setDragImage(thumb, thumb.width / 2, thumb.height / 2);
        });
        assetList.append(card);
      });
    }

    function setupWheelInputs() {
      Object.entries(inputs).forEach(([key, input]) => {
        if (input.type !== "number") return;
        input.addEventListener("wheel", event => {
          event.preventDefault();
          const part = selectedPart();
          if (!part || input.disabled) return;
          const baseStep = Number(input.step) || 1;
          const multiplier = event.shiftKey ? 10 : event.ctrlKey || event.metaKey ? 0.1 : 1;
          const delta = (event.deltaY < 0 ? 1 : -1) * baseStep * multiplier;
          const min = input.min === "" ? -Infinity : Number(input.min);
          const max = input.max === "" ? Infinity : Number(input.max);
          const next = Math.max(min, Math.min(max, Number(input.value || 0) + delta));
          input.value = Number(next.toFixed(3));
          input.dispatchEvent(new Event("input", { bubbles: true }));
        }, { passive: false });
      });
    }

    function setupAssetLibraryWheel() {
      assetList.addEventListener("wheel", event => {
        if (event.ctrlKey || event.metaKey) return;
        const horizontal = Math.abs(event.deltaX) > Math.abs(event.deltaY);
        const delta = horizontal ? event.deltaX : event.deltaY;
        if (delta === 0) return;
        event.preventDefault();
        assetList.scrollLeft += delta;
      }, { passive: false });
    }

    function projectPayload() {
      return {
        tool: "hologirl-spine-rig-tuner",
        version: 1,
        sheet: sheets[activeSheet].name,
        alphaPreview,
        canvas: { width: poseCanvas.width, height: poseCanvas.height },
        assets: assets.map(({ id, ...asset }) => asset),
        parts: parts.map(({ id, ...part }) => part)
      };
    }

    function scheduleAutosave() {
      window.clearTimeout(autosaveTimer);
      autosaveTimer = window.setTimeout(() => {
        try {
          localStorage.setItem(storageKey, JSON.stringify(projectPayload()));
          setSavedStatus("Autosaved locally.");
        } catch (error) {
          setStatus(`Autosave failed: ${error.message}`);
        }
      }, 250);
    }

    function loadSavedProject() {
      const raw = localStorage.getItem(storageKey);
      if (!raw) return false;
      try {
        const payload = JSON.parse(raw);
        applyProjectPayload(payload);
        return true;
      } catch (error) {
        setStatus(`Saved project load failed: ${error.message}`);
        return false;
      }
    }

    function applyProjectPayload(payload) {
      const sheetKey = Object.entries(sheets).find(([, sheet]) => sheet.name === payload.sheet)?.[0];
      if (sheetKey) {
        activeSheet = sheetKey;
        sheetSelect.value = sheetKey;
      }
      alphaPreview = payload.alphaPreview !== false;
      updateAlphaPreviewButton();
      assets = (payload.assets || []).map(asset => ({ id: makeId(), ...asset }));
      parts = (payload.parts || []).map(part => ({
        id: makeId(),
        visible: true,
        locked: false,
        opacity: 1,
        brightness: 1,
        flipX: false,
        flipY: false,
        ...part
      }));
      selectedId = parts[0]?.id || null;
      selectedPartIds = selectedId ? new Set([selectedId]) : new Set();
      selectedAssetId = null;
      resetAssetHistory(null);
      rebuildAssetImages();
      rebuildPartImages();
    }

    function savedNames() {
      try {
        return JSON.parse(localStorage.getItem(savesIndexKey) || "[]");
      } catch {
        return [];
      }
    }

    function setSavedNames(names) {
      localStorage.setItem(savesIndexKey, JSON.stringify([...new Set(names)].sort()));
    }

    function safeSaveFileName(name) {
      return `${name.trim().toLowerCase().replace(/[^a-z0-9_-]+/g, "_").replace(/^_+|_+$/g, "") || "spine-rig-save"}.json`;
    }

    function browserSaveEntries() {
      return savedNames().map(name => ({ source: "browser", name }));
    }

    function repoSaveOptions() {
      return repoSaveEntries.map(entry => ({
        source: "repo",
        name: entry.name,
        file: entry.file,
        updatedAt: entry.updatedAt || ""
      }));
    }

    function saveIndexPayload(entries = repoSaveEntries) {
      return {
        tool: "hologirl-spine-rig-tuner-saves",
        version: 1,
        saves: entries
          .map(({ name, file, updatedAt, sheet }) => ({ name, file, updatedAt, sheet }))
          .sort((a, b) => a.name.localeCompare(b.name))
      };
    }

    async function readTextFile(fileHandle) {
      const file = await fileHandle.getFile();
      return file.text();
    }

    async function writeTextFile(directoryHandle, fileName, text) {
      const fileHandle = await directoryHandle.getFileHandle(fileName, { create: true });
      const writable = await fileHandle.createWritable();
      await writable.write(text);
      await writable.close();
    }

    async function loadRepoSavesFromDirectory() {
      if (!saveDirectoryHandle) return false;
      try {
        const indexHandle = await saveDirectoryHandle.getFileHandle("index.json", { create: true });
        const raw = await readTextFile(indexHandle);
        if (!raw.trim()) {
          repoSaveEntries = [];
          await writeTextFile(saveDirectoryHandle, "index.json", JSON.stringify(saveIndexPayload(), null, 2) + "\n");
        } else {
          const payload = JSON.parse(raw);
          repoSaveEntries = Array.isArray(payload.saves) ? payload.saves : [];
        }
        renderSaveList();
        return true;
      } catch (error) {
        setStatus(`Repo save folder load failed: ${error.message}`);
        return false;
      }
    }

    async function loadRepoSavesFromServer() {
      try {
        const response = await fetch(`${repoSavesIndexPath}?t=${Date.now()}`, { cache: "no-store" });
        if (!response.ok) return false;
        const payload = await response.json();
        repoSaveEntries = Array.isArray(payload.saves) ? payload.saves : [];
        renderSaveList();
        return true;
      } catch {
        return false;
      }
    }

    function renderSaveList() {
      renderedSaveEntries = [...repoSaveOptions(), ...browserSaveEntries()];
      saveSelect.innerHTML = "";
      if (renderedSaveEntries.length === 0) {
        const option = document.createElement("option");
        option.value = "";
        option.textContent = "No named saves";
        saveSelect.append(option);
        if (!saveNameInput.value.trim()) saveNameInput.value = defaultSaveName();
        return;
      }
      renderedSaveEntries.forEach((entry, index) => {
        const option = document.createElement("option");
        option.value = String(index);
        option.textContent = `${entry.name} (${entry.source})`;
        saveSelect.append(option);
      });
      if (!saveNameInput.value.trim()) saveNameInput.value = renderedSaveEntries[0].name;
    }

    function defaultSaveName() {
      const sheetName = sheets[activeSheet]?.name || "sheet";
      const stamp = new Date().toISOString().slice(0, 16).replace("T", "-").replace(":", "");
      return `${sheetName}-${stamp}`;
    }

    function selectedSaveEntry() {
      return renderedSaveEntries[Number(saveSelect.value)] || null;
    }

    async function saveProjectToRepoFolder() {
      if (!saveDirectoryHandle) {
        setStatus("Choose the repo saves folder first.");
        return false;
      }
      const name = saveNameInput.value.trim() || defaultSaveName();
      saveNameInput.value = name;
      const payload = projectPayload();
      const existing = repoSaveEntries.find(entry => entry.name === name);
      const usedFiles = new Set(repoSaveEntries.map(entry => entry.file));
      let file = existing?.file || safeSaveFileName(name);
      if (!existing) {
        const base = file.replace(/\.json$/i, "");
        let suffix = 2;
        while (usedFiles.has(file)) {
          file = `${base}-${suffix}.json`;
          suffix += 1;
        }
      }
      await writeTextFile(saveDirectoryHandle, file, JSON.stringify(payload, null, 2) + "\n");
      const entry = {
        name,
        file,
        sheet: payload.sheet,
        updatedAt: new Date().toISOString()
      };
      repoSaveEntries = [...repoSaveEntries.filter(candidate => candidate.name !== name), entry];
      await writeTextFile(saveDirectoryHandle, "index.json", JSON.stringify(saveIndexPayload(), null, 2) + "\n");
      renderSaveList();
      saveSelect.value = String(renderedSaveEntries.findIndex(candidate => candidate.source === "repo" && candidate.name === name));
      setSavedStatus(`Saved repo project "${name}" to saves/${file}.`);
      return true;
    }

    function saveProjectToBrowser() {
      const name = saveNameInput.value.trim() || defaultSaveName();
      saveNameInput.value = name;
      localStorage.setItem(`${savePrefix}${name}`, JSON.stringify(projectPayload()));
      setSavedNames([...savedNames(), name]);
      renderSaveList();
      saveSelect.value = String(renderedSaveEntries.findIndex(entry => entry.source === "browser" && entry.name === name));
      setSavedStatus(`Saved browser project "${name}".`);
    }

    async function saveProject() {
      if (saveDirectoryHandle) {
        try {
          await saveProjectToRepoFolder();
        } catch (error) {
          setStatus(`Repo save failed: ${error.message}`);
        }
        return;
      }
      saveProjectToBrowser();
    }

    async function loadProjectFromRepo(entry) {
      let raw = "";
      if (saveDirectoryHandle) {
        const fileHandle = await saveDirectoryHandle.getFileHandle(entry.file);
        raw = await readTextFile(fileHandle);
      } else {
        const response = await fetch(`saves/${entry.file}?t=${Date.now()}`, { cache: "no-store" });
        if (!response.ok) throw new Error(`HTTP ${response.status}`);
        raw = await response.text();
      }
      applyProjectPayload(JSON.parse(raw));
    }

    async function loadProject() {
      const entry = selectedSaveEntry();
      if (!entry) {
        setStatus("No named save selected.");
        return;
      }
      try {
        if (entry.source === "repo") {
          await loadProjectFromRepo(entry);
        } else {
          const raw = localStorage.getItem(`${savePrefix}${entry.name}`);
          if (!raw) {
            setStatus(`Save "${entry.name}" was not found.`);
            renderSaveList();
            return;
          }
          applyProjectPayload(JSON.parse(raw));
        }
        saveNameInput.value = entry.name;
        syncInputs();
        renderPartsList();
        loadSheet();
        scheduleAutosave();
        setSavedStatus(`Loaded ${entry.source} project "${entry.name}".`);
      } catch (error) {
        setStatus(`Load failed: ${error.message}`);
      }
    }

    async function deleteProject() {
      const entry = selectedSaveEntry();
      if (!entry) return;
      if (entry.source === "repo") {
        if (!saveDirectoryHandle) {
          setStatus("Connect the repo saves folder before deleting repo saves.");
          return;
        }
        try {
          if (typeof saveDirectoryHandle.removeEntry === "function") {
            await saveDirectoryHandle.removeEntry(entry.file);
          }
          repoSaveEntries = repoSaveEntries.filter(candidate => candidate.name !== entry.name);
          await writeTextFile(saveDirectoryHandle, "index.json", JSON.stringify(saveIndexPayload(), null, 2) + "\n");
          renderSaveList();
          setStatus(`Deleted repo project "${entry.name}".`);
        } catch (error) {
          setStatus(`Repo delete failed: ${error.message}`);
        }
        return;
      }
      localStorage.removeItem(`${savePrefix}${entry.name}`);
      setSavedNames(savedNames().filter(savedName => savedName !== entry.name));
      renderSaveList();
      setStatus(`Deleted browser project "${entry.name}".`);
    }

    async function connectRepoSaveFolder() {
      if (!window.showDirectoryPicker) {
        setStatus("Repo folder saves need a browser with File System Access support. Use Chrome/Edge, or Export JSON manually.");
        return;
      }
      try {
        saveDirectoryHandle = await window.showDirectoryPicker({
          id: "hologirl-spine-rig-tuner-saves",
          mode: "readwrite"
        });
        await loadRepoSavesFromDirectory();
        setSavedStatus("Connected repo saves folder. Save now writes JSON files there.");
      } catch (error) {
        if (error.name !== "AbortError") setStatus(`Repo folder connection failed: ${error.message}`);
      }
    }

    async function refreshRepoSaves() {
      if (saveDirectoryHandle) {
        await loadRepoSavesFromDirectory();
      } else {
        await loadRepoSavesFromServer();
      }
      setSavedStatus("Refreshed repo save list.");
    }

    function setupPanelResizers() {
      const main = document.querySelector("main");
      let available = Math.max(900, main.clientWidth - 21);
      let sideWidth = Math.min(360, Math.max(280, available * 0.24));
      let editorWidth = Math.min(380, Math.max(320, available * 0.22));
      let sourceWidth = (available - sideWidth - editorWidth) / 2;
      let poseWidth = available - sideWidth - editorWidth - sourceWidth;

      function applyColumns() {
        const sourceVisible = !document.getElementById("sourceSection").classList.contains("collapsed");
        const poseVisible = !document.getElementById("poseSection").classList.contains("collapsed");
        const editorVisible = !document.getElementById("assetEditorPanel").classList.contains("collapsed");
        const sideVisible = !document.getElementById("sidePanel").classList.contains("collapsed");
        const visiblePanels = [
          sourceVisible && "source",
          poseVisible && "pose",
          editorVisible && "editor",
          sideVisible && "side"
        ].filter(Boolean);
        const gutterCount = [
          sourceVisible && poseVisible,
          poseVisible && (editorVisible || sideVisible),
          editorVisible && sideVisible
        ].filter(Boolean).length;

        available = Math.max(0, main.clientWidth - gutterCount * 7);
        sourceWidth = Math.max(260, sourceWidth);
        poseWidth = Math.max(260, poseWidth);
        editorWidth = Math.max(300, editorWidth);
        sideWidth = Math.max(280, sideWidth);

        const widths = {
          source: sourceWidth,
          pose: poseWidth,
          editor: editorWidth,
          side: sideWidth
        };
        const minimums = {
          source: 260,
          pose: 260,
          editor: 300,
          side: 280
        };
        const visibleTotal = visiblePanels.reduce((sum, key) => sum + widths[key], 0);
        if (visiblePanels.length && visibleTotal !== available) {
          const scale = available / visibleTotal;
          visiblePanels.forEach(key => {
            widths[key] = Math.max(minimums[key], widths[key] * scale);
          });

          let overflow = visiblePanels.reduce((sum, key) => sum + widths[key], 0) - available;
          for (let index = visiblePanels.length - 1; overflow > 0 && index >= 0; index -= 1) {
            const key = visiblePanels[index];
            const reduction = Math.min(overflow, widths[key] - minimums[key]);
            widths[key] -= reduction;
            overflow -= reduction;
          }
        }

        sourceWidth = widths.source;
        poseWidth = widths.pose;
        editorWidth = widths.editor;
        sideWidth = widths.side;
        main.style.setProperty("--source-width", `${sourceWidth}px`);
        main.style.setProperty("--pose-width", `${poseWidth}px`);
        main.style.setProperty("--editor-width", `${editorWidth}px`);
        main.style.setProperty("--side-width", `${sideWidth}px`);
        applyPanelLayout();
      }

      document.querySelectorAll("[data-resizer]").forEach(handle => {
        handle.addEventListener("pointerdown", event => {
          const mode = handle.dataset.resizer;
          const startX = event.clientX;
          const startSource = sourceWidth;
          const startPose = poseWidth;
          const startEditor = editorWidth;
          const startSide = sideWidth;
          handle.classList.add("dragging");
          handle.setPointerCapture(event.pointerId);

          function move(moveEvent) {
            const dx = moveEvent.clientX - startX;
            if (mode === "sourcePose") {
              sourceWidth = startSource + dx;
              poseWidth = startPose - dx;
            } else if (mode === "poseSide") {
              poseWidth = startPose + dx;
              if (document.getElementById("assetEditorPanel").classList.contains("collapsed")) {
                sideWidth = startSide - dx;
                editorWidth = startEditor;
              } else {
                editorWidth = startEditor - dx;
                sideWidth = startSide;
              }
            } else if (mode === "editorSide") {
              editorWidth = startEditor + dx;
              sideWidth = startSide - dx;
            }
            applyColumns();
          }

          function up() {
            handle.classList.remove("dragging");
            handle.removeEventListener("pointermove", move);
            handle.removeEventListener("pointerup", up);
          }

          handle.addEventListener("pointermove", move);
          handle.addEventListener("pointerup", up);
        });
      });

      normalizePanelLayout = applyColumns;
      applyColumns();
    }

    function normalizeRect(a, b) {
      const x = Math.min(a.x, b.x);
      const y = Math.min(a.y, b.y);
      return {
        x: Math.round(x),
        y: Math.round(y),
        w: Math.round(Math.abs(a.x - b.x)),
        h: Math.round(Math.abs(a.y - b.y))
      };
    }

    function canvasPoint(event, canvas) {
      const rect = canvas.getBoundingClientRect();
      return {
        x: (event.clientX - rect.left) * canvas.width / rect.width,
        y: (event.clientY - rect.top) * canvas.height / rect.height
      };
    }

    sourceCanvas.addEventListener("pointerdown", event => {
      if (event.button !== 0) return;
      if (selectionMode === "polygon") {
        event.preventDefault();
        const point = canvasPoint(event, sourceCanvas);
        polygonPoints.push({ x: Math.round(point.x), y: Math.round(point.y) });
        crop = polygonBounds(polygonPoints);
        drawSource();
        setStatus(polygonPoints.length >= 3
          ? "Polygon ready. Add more points or create an asset."
          : "Polygon point added. Add at least three points.");
        return;
      }
      cropDrag = canvasPoint(event, sourceCanvas);
      crop = { x: cropDrag.x, y: cropDrag.y, w: 0, h: 0 };
      sourceCanvas.setPointerCapture(event.pointerId);
    });

    sourceCanvas.addEventListener("pointermove", event => {
      if (selectionMode === "polygon") return;
      if (!cropDrag) return;
      crop = normalizeRect(cropDrag, canvasPoint(event, sourceCanvas));
      drawSource();
    });

    sourceCanvas.addEventListener("pointerup", event => {
      if (selectionMode === "polygon") {
        polygonClickStart = null;
        return;
      }
      if (!cropDrag) return;
      crop = normalizeRect(cropDrag, canvasPoint(event, sourceCanvas));
      cropDrag = null;
      drawSource();
      setStatus("Crop selected. Create an asset, then set its name and slot in the Asset Editor.");
    });

    sourceCanvas.addEventListener("contextmenu", event => {
      event.preventDefault();
      crop = null;
      cropDrag = null;
      polygonClickStart = null;
      polygonPoints = [];
      drawSource();
      setStatus("Source crop selection cleared.");
    });

    function polygonBounds(points) {
      if (points.length === 0) return null;
      const xs = points.map(point => point.x);
      const ys = points.map(point => point.y);
      const x = Math.min(...xs);
      const y = Math.min(...ys);
      return {
        x,
        y,
        w: Math.max(1, Math.max(...xs) - x + 1),
        h: Math.max(1, Math.max(...ys) - y + 1)
      };
    }

    function currentMaskForCrop() {
      if (selectionMode !== "polygon" || polygonPoints.length < 3) return null;
      crop = crop || polygonBounds(polygonPoints);
      if (!crop) return null;
      return polygonPoints.map(point => ({
        x: Math.round(point.x - crop.x),
        y: Math.round(point.y - crop.y)
      }));
    }

    poseCanvas.addEventListener("pointerdown", event => {
      if (event.button !== 0) return;
      const point = canvasPoint(event, poseCanvas);
      const hit = [...parts]
        .filter(part => part.visible && !part.locked)
        .sort((a, b) => b.z - a.z)
        .find(part => pointHitsPart(point, part));
      if (!hit) {
        poseSelectionDrag = { start: point, rect: { x: point.x, y: point.y, w: 0, h: 0 } };
        poseCanvas.setPointerCapture(event.pointerId);
        clearPoseSelection();
        return;
      }
      if (!selectedPartIds.has(hit.id)) {
        setSelectedParts([hit.id], hit.id);
      } else {
        selectedId = hit.id;
        syncInputs();
        renderPartsList();
        drawPose();
      }
      const movingIds = [...selectedPartIds].filter(id => !parts.find(part => part.id === id)?.locked);
      poseDrag = {
        id: hit.id,
        start: point,
        original: new Map(movingIds.map(id => {
          const part = parts.find(candidate => candidate.id === id);
          return [id, { x: part.x, y: part.y }];
        }))
      };
      poseCanvas.classList.add("dragging");
      poseCanvas.setPointerCapture(event.pointerId);
    });

    poseCanvas.addEventListener("pointermove", event => {
      const point = canvasPoint(event, poseCanvas);
      if (poseSelectionDrag) {
        poseSelectionDrag.rect = normalizeRect(poseSelectionDrag.start, point);
        requestPoseDraw();
        return;
      }
      if (!poseDrag) return;
      const dx = point.x - poseDrag.start.x;
      const dy = point.y - poseDrag.start.y;
      poseDrag.original.forEach((original, id) => {
        const part = parts.find(candidate => candidate.id === id);
        if (!part) return;
        part.x = original.x + dx;
        part.y = original.y + dy;
      });
      syncPositionInputs();
      requestPoseDraw();
    });

    poseCanvas.addEventListener("pointerup", event => {
      if (poseSelectionDrag) {
        const rect = poseSelectionDrag.rect;
        const moved = rect.w > 4 || rect.h > 4;
        poseSelectionDrag = null;
        if (moved) {
          const ids = [...parts]
            .filter(part => part.visible && !part.locked && rectIntersectsPartBounds(rect, part))
            .map(part => part.id);
          if (ids.length) {
            setSelectedParts(ids, ids[0]);
            setStatus(`Selected ${ids.length} part${ids.length === 1 ? "" : "s"}.`);
          } else {
            clearPoseSelection();
            setStatus("No pose parts selected.");
          }
        } else {
          clearPoseSelection();
          setStatus("Pose selection cleared.");
        }
      } else if (poseDrag) {
        scheduleAutosave();
      }
      poseDrag = null;
      poseCanvas.classList.remove("dragging");
    });

    poseCanvas.addEventListener("dragover", event => {
      event.preventDefault();
      event.dataTransfer.dropEffect = "copy";
    });

    poseCanvas.addEventListener("drop", event => {
      event.preventDefault();
      const assetId = event.dataTransfer.getData("text/plain");
      const asset = assets.find(candidate => candidate.id === assetId);
      if (!asset) return;
      createPartFromAsset(asset, canvasPoint(event, poseCanvas));
    });

    function pointHitsPart(point, part) {
      const dx = point.x - part.x;
      const dy = point.y - part.y;
      const radians = -part.rotation * Math.PI / 180;
      const scaleX = (part.flipX ? -1 : 1) * part.scale;
      const scaleY = (part.flipY ? -1 : 1) * part.scale;
      const localX = (dx * Math.cos(radians) - dy * Math.sin(radians)) / scaleX + part.pivotX;
      const localY = (dx * Math.sin(radians) + dy * Math.cos(radians)) / scaleY + part.pivotY;
      return localX >= 0 && localY >= 0 && localX <= part.crop.w && localY <= part.crop.h;
    }

    function partBounds(part) {
      const radians = part.rotation * Math.PI / 180;
      const scaleX = (part.flipX ? -1 : 1) * part.scale;
      const scaleY = (part.flipY ? -1 : 1) * part.scale;
      const corners = [
        { x: -part.pivotX, y: -part.pivotY },
        { x: part.crop.w - part.pivotX, y: -part.pivotY },
        { x: part.crop.w - part.pivotX, y: part.crop.h - part.pivotY },
        { x: -part.pivotX, y: part.crop.h - part.pivotY }
      ].map(point => ({
        x: part.x + point.x * scaleX * Math.cos(radians) - point.y * scaleY * Math.sin(radians),
        y: part.y + point.x * scaleX * Math.sin(radians) + point.y * scaleY * Math.cos(radians)
      }));
      const xs = corners.map(point => point.x);
      const ys = corners.map(point => point.y);
      return {
        x: Math.min(...xs),
        y: Math.min(...ys),
        w: Math.max(...xs) - Math.min(...xs),
        h: Math.max(...ys) - Math.min(...ys)
      };
    }

    function rectIntersectsPartBounds(rect, part) {
      const bounds = partBounds(part);
      return rect.x <= bounds.x + bounds.w
        && rect.x + rect.w >= bounds.x
        && rect.y <= bounds.y + bounds.h
        && rect.y + rect.h >= bounds.y;
    }

    function clonePart(part) {
      const copy = JSON.parse(JSON.stringify(part));
      copy.id = makeId();
      copy.name = `${copy.name}_copy`;
      copy.locked = false;
      copy.visible = true;
      copy.x += 24;
      copy.y += 24;
      copy.z = Math.max(-1, ...parts.map(existing => existing.z)) + 1;
      return copy;
    }

    function copySelectedPart() {
      const part = selectedPart();
      if (!part) return;
      copiedPart = JSON.parse(JSON.stringify(part));
      setStatus(`Copied ${part.name}.`);
    }

    function pasteCopiedPart() {
      if (!copiedPart) return;
      const copy = clonePart(copiedPart);
      parts.push(copy);
      rebuildPartImage(copy);
      selectedId = copy.id;
      selectedAssetId = null;
      syncInputs();
      renderPartsList();
      drawPose();
      scheduleAutosave();
      setStatus(`Pasted ${copy.name}.`);
    }

    function createPartFromAsset(asset, point) {
      const part = {
        id: makeId(),
        sheet: asset.sheet,
        slot: asset.slot,
        name: asset.name,
        crop: { ...asset.crop },
        mask: asset.mask ? JSON.parse(JSON.stringify(asset.mask)) : null,
        alphaMask: asset.alphaMask ? JSON.parse(JSON.stringify(asset.alphaMask)) : null,
        x: point.x,
        y: point.y,
        rotation: 0,
        scale: 1,
        pivotX: Math.round(asset.crop.w / 2),
        pivotY: Math.round(asset.crop.h / 2),
        z: parts.length,
        visible: true,
        locked: false,
        opacity: 1,
        brightness: 1,
        flipX: false,
        flipY: false
      };
      parts.push(part);
      rebuildPartImage(part);
      selectedId = part.id;
      selectedAssetId = null;
      syncInputs();
      renderPartsList();
      drawPose();
      scheduleAutosave();
      setStatus(`Placed ${part.name}.`);
    }

    function createPartFromCrop(forceOverlay) {
      if (!crop || crop.w < 4 || crop.h < 4) {
        setStatus(selectionMode === "polygon" ? "Click at least three polygon points first." : "Draw a crop rectangle first.");
        return;
      }
      if (selectionMode === "polygon" && polygonPoints.length < 3) {
        setStatus("Polygon needs at least three points.");
        return;
      }
      const slot = forceOverlay ? "overlay_extra" : "extra";
      const asset = {
        id: makeId(),
        sheet: sheets[activeSheet].name,
        slot,
        name: `${slot}_${String(assets.length + 1).padStart(3, "0")}`,
        crop: { ...crop },
        mask: currentMaskForCrop()
      };
      assets.push(asset);
      rebuildAssetImage(asset);
      selectedAssetId = asset.id;
      selectedId = null;
      crop = null;
      polygonPoints = [];
      drawSource();
      setPanelCollapsed("assetEditorPanel", false);
      renderAssetLibrary();
      drawAssetEditor();
      setStatus(`Created asset ${asset.name}. Set its name/slot in Asset Editor, then drag it onto Pose Preview.`);
      scheduleAutosave();
    }

    function extractSheetAssets() {
      if (!sourceImage.complete || !sourceCanvas.width || !sourceCanvas.height) {
        setStatus("Wait for the sheet to finish loading before extracting assets.");
        return;
      }
      if (!alphaPreview) {
        setStatus("Turn Alpha Preview on before extracting. Chroma sheets still have an opaque background.");
        return;
      }

      const width = sourceCanvas.width;
      const height = sourceCanvas.height;
      const scanCanvas = document.createElement("canvas");
      scanCanvas.width = width;
      scanCanvas.height = height;
      const scanCtx = scanCanvas.getContext("2d", { willReadFrequently: true });
      scanCtx.drawImage(sourceImage, 0, 0);
      const pixels = scanCtx.getImageData(0, 0, width, height).data;
      const visited = new Uint8Array(width * height);
      const alphaThreshold = 24;
      const minPixels = 80;
      const minSize = 8;
      const created = [];
      let transparentPixels = 0;

      for (let i = 3; i < pixels.length; i += 4) {
        if (pixels[i] <= alphaThreshold) transparentPixels += 1;
      }

      if (transparentPixels < width * height * 0.01) {
        setStatus("Extract Sheet needs a transparent sheet. The current image looks opaque; check Alpha Preview and sheet loading.");
        return;
      }

      function isOpaque(index) {
        return pixels[index * 4 + 3] > alphaThreshold;
      }

      for (let start = 0; start < visited.length; start += 1) {
        if (visited[start] || !isOpaque(start)) {
          visited[start] = 1;
          continue;
        }

        const stack = [start];
        visited[start] = 1;
        let count = 0;
        let minX = width;
        let minY = height;
        let maxX = 0;
        let maxY = 0;
        const component = [];

        while (stack.length) {
          const index = stack.pop();
          const x = index % width;
          const y = Math.floor(index / width);
          component.push(index);
          count += 1;
          minX = Math.min(minX, x);
          minY = Math.min(minY, y);
          maxX = Math.max(maxX, x);
          maxY = Math.max(maxY, y);

          const neighbors = [
            x > 0 ? index - 1 : -1,
            x < width - 1 ? index + 1 : -1,
            y > 0 ? index - width : -1,
            y < height - 1 ? index + width : -1
          ];
          neighbors.forEach(next => {
            if (next < 0 || visited[next] || !isOpaque(next)) {
              if (next >= 0) visited[next] = 1;
              return;
            }
            visited[next] = 1;
            stack.push(next);
          });
        }

        const cropWidth = maxX - minX + 1;
        const cropHeight = maxY - minY + 1;
        if (count < minPixels || cropWidth < minSize || cropHeight < minSize) continue;
        const cropX = Math.max(0, minX - 1);
        const cropY = Math.max(0, minY - 1);
        const paddedWidth = Math.min(width - cropX, cropWidth + 2);
        const paddedHeight = Math.min(height - cropY, cropHeight + 2);
        const rows = new Map();
        component.forEach(index => {
          const x = index % width;
          const y = Math.floor(index / width);
          const localY = y - cropY;
          const localX = x - cropX;
          if (!rows.has(localY)) rows.set(localY, []);
          rows.get(localY).push(localX);
        });
        const spans = [];
        [...rows.entries()].sort((a, b) => a[0] - b[0]).forEach(([y, xs]) => {
          xs.sort((a, b) => a - b);
          let spanStart = xs[0];
          let previous = xs[0];
          for (let i = 1; i < xs.length; i += 1) {
            const x = xs[i];
            if (x === previous + 1) {
              previous = x;
              continue;
            }
            spans.push([y, spanStart, previous]);
            spanStart = x;
            previous = x;
          }
          spans.push([y, spanStart, previous]);
        });

        created.push({
          id: makeId(),
          sheet: sheets[activeSheet].name,
          slot: "extra",
          name: `auto_${String(created.length + 1).padStart(3, "0")}`,
          crop: {
            x: cropX,
            y: cropY,
            w: paddedWidth,
            h: paddedHeight
          },
          mask: null,
          alphaMask: { type: "rowSpans", spans }
        });
      }

      if (!created.length) {
        setStatus("No opaque sheet islands found. Turn Alpha Preview on and use a transparent sheet.");
        return;
      }

      assets.push(...created);
      created.forEach(rebuildAssetImage);
      selectedAssetId = created[0].id;
      selectedId = null;
      renderAssetLibrary();
      syncInputs();
      scheduleAutosave();
      setStatus(`Extracted ${created.length} assets from ${sheets[activeSheet].name}. Rename and assign slots as needed.`);
    }

    document.getElementById("createPart").onclick = () => createPartFromCrop(false);
    document.getElementById("createOverlay").onclick = () => createPartFromCrop(true);
    document.getElementById("extractSheetAssets").onclick = extractSheetAssets;

    document.getElementById("clearCrop").onclick = () => {
      crop = null;
      cropDrag = null;
      polygonClickStart = null;
      polygonPoints = [];
      drawSource();
    };

    document.getElementById("duplicatePart").onclick = () => {
      const part = selectedPart();
      if (!part) return;
      const copy = clonePart(part);
      parts.push(copy);
      rebuildPartImage(copy);
      selectedId = copy.id;
      selectedAssetId = null;
      syncInputs();
      renderPartsList();
      drawPose();
      scheduleAutosave();
    };

    function deleteSelectedPart() {
      if (!selectedId) return;
      parts = parts.filter(part => part.id !== selectedId);
      selectedId = parts[0]?.id || null;
      selectedAssetId = null;
      syncInputs();
      renderPartsList();
      drawPose();
      scheduleAutosave();
    }

    document.getElementById("deletePart").onclick = deleteSelectedPart;

    function deleteAsset(assetId = selectedAssetId) {
      if (!assetId) return;
      const asset = assets.find(candidate => candidate.id === assetId);
      assets = assets.filter(candidate => candidate.id !== assetId);
      assetImages.delete(assetId);
      if (selectedAssetId === assetId) selectedAssetId = assets[0]?.id || null;
      resetAssetHistory(selectedAssetId);
      renderAssetLibrary();
      syncInputs();
      scheduleAutosave();
      setStatus(asset ? `Deleted asset ${asset.name}. Placed pose parts are unchanged.` : "Deleted asset.");
    }

    function updateSelectedAssetImage(asset, message) {
      clampAssetCrop(asset);
      rebuildAssetImage(asset);
      renderAssetLibrary();
      drawAssetEditor();
      scheduleAutosave();
      if (message) setStatus(message);
    }

    Object.entries(assetInputs).forEach(([key, input]) => {
      if (key === "brush" || key === "brushMode") return;
      input.addEventListener("input", () => {
        const asset = selectedAsset();
        if (!asset) return;
        if (key === "slot") {
          asset.slot = input.value;
          if (!asset.name || slots.includes(asset.name)) asset.name = input.value;
          assetInputs.name.value = asset.name;
        } else if (key === "name") {
          asset.name = input.value.trim() || asset.slot;
        } else {
          pushAssetUndo(asset);
          const cropKey = { cropX: "x", cropY: "y", cropW: "w", cropH: "h" }[key];
          asset.crop[cropKey] = Number(input.value);
          asset.mask = null;
          asset.alphaMask = null;
        }
        updateSelectedAssetImage(asset);
      });
    });

    assetEditorCanvas.addEventListener("pointerdown", event => {
      const asset = selectedAsset();
      if (event.button !== 0 || !asset) return;
      event.preventDefault();
      pushAssetUndo(asset);
      assetEditDrag = true;
      assetEditorCanvas.setPointerCapture(event.pointerId);
      paintAssetMask(assetEditorPoint(event));
    });

    assetEditorCanvas.addEventListener("pointermove", event => {
      if (!assetEditDrag) return;
      paintAssetMask(assetEditorPoint(event));
    });

    assetEditorCanvas.addEventListener("pointerup", () => {
      assetEditDrag = false;
    });

    assetEditorCanvas.addEventListener("pointercancel", () => {
      assetEditDrag = false;
    });

    document.getElementById("trimAsset").onclick = () => {
      const asset = selectedAsset();
      if (!asset) return;
      clampAssetCrop(asset);
      const visible = currentVisibilityMap(asset);
      let minX = asset.crop.w;
      let minY = asset.crop.h;
      let maxX = -1;
      let maxY = -1;
      for (let y = 0; y < asset.crop.h; y += 1) {
        for (let x = 0; x < asset.crop.w; x += 1) {
          if (!visible[y * asset.crop.w + x]) continue;
          minX = Math.min(minX, x);
          minY = Math.min(minY, y);
          maxX = Math.max(maxX, x);
          maxY = Math.max(maxY, y);
        }
      }
      if (maxX < minX || maxY < minY) {
        setStatus("Asset has no visible pixels to trim.");
        return;
      }

      pushAssetUndo(asset);
      const nextW = maxX - minX + 1;
      const nextH = maxY - minY + 1;
      const trimmed = new Uint8Array(nextW * nextH);
      for (let y = 0; y < nextH; y += 1) {
        for (let x = 0; x < nextW; x += 1) {
          trimmed[y * nextW + x] = visible[(y + minY) * asset.crop.w + x + minX];
        }
      }
      asset.crop.x += minX;
      asset.crop.y += minY;
      asset.crop.w = nextW;
      asset.crop.h = nextH;
      asset.mask = null;
      asset.alphaMask = visibilityToRowSpans(trimmed, nextW, nextH);
      updateSelectedAssetImage(asset, `Trimmed asset ${asset.name}.`);
    };

    document.getElementById("resetAssetMask").onclick = () => {
      const asset = selectedAsset();
      if (!asset) return;
      pushAssetUndo(asset);
      asset.mask = null;
      asset.alphaMask = null;
      updateSelectedAssetImage(asset, `Reset alpha edits for ${asset.name}.`);
    };

    document.getElementById("deleteAssetPanel").onclick = () => deleteAsset();
    document.getElementById("undoAssetEdit").onclick = undoAssetEdit;
    document.getElementById("redoAssetEdit").onclick = redoAssetEdit;

    Object.entries(inputs).forEach(([key, input]) => {
      input.addEventListener("input", () => {
        const part = selectedPart();
        if (!part) return;
        if (key === "z") {
          part.z = Number(input.value);
        } else if (key === "opacity" || key === "brightness") {
          part[key] = Number(input.value);
        } else if (key === "pivotX" || key === "pivotY") {
          const previous = part[key];
          const next = Number(input.value);
          const delta = next - previous;
          const radians = part.rotation * Math.PI / 180;
          const scaleX = (part.flipX ? -1 : 1) * part.scale;
          const scaleY = (part.flipY ? -1 : 1) * part.scale;
          if (key === "pivotX") {
            part.x += Math.cos(radians) * delta * scaleX;
            part.y += Math.sin(radians) * delta * scaleX;
          } else {
            part.x += -Math.sin(radians) * delta * scaleY;
            part.y += Math.cos(radians) * delta * scaleY;
          }
          part[key] = next;
        } else {
          part[key] = Number(input.value);
        }
        renderPartsList();
        syncPartButtons(part);
        drawPose();
        scheduleAutosave();
      });
    });

    function updateSelectedPartButtonState(key, value) {
      const part = selectedPart();
      if (!part) return;
      part[key] = value;
      syncInputs();
      renderPartsList();
      drawPose();
      scheduleAutosave();
    }

    partButtons.flipX.onclick = () => {
      const part = selectedPart();
      if (!part) return;
      updateSelectedPartButtonState("flipX", !part.flipX);
    };
    partButtons.flipY.onclick = () => {
      const part = selectedPart();
      if (!part) return;
      updateSelectedPartButtonState("flipY", !part.flipY);
    };
    partButtons.visible.onclick = () => {
      const part = selectedPart();
      if (!part) return;
      updateSelectedPartButtonState("visible", part.visible === false);
    };
    partButtons.locked.onclick = () => {
      const part = selectedPart();
      if (!part) return;
      updateSelectedPartButtonState("locked", !part.locked);
    };

    sheetSelect.onchange = () => {
      activeSheet = sheetSelect.value;
      assets = [];
      parts = [];
      selectedId = null;
      selectedAssetId = null;
      syncInputs();
      renderAssetLibrary();
      renderPartsList();
      loadSheet();
      scheduleAutosave();
    };

    document.getElementById("toggleAlpha").onclick = event => {
      alphaPreview = !alphaPreview;
      updateAlphaPreviewButton();
      loadSheet();
      scheduleAutosave();
    };

    document.getElementById("resetView").onclick = () => {
      parts.forEach((part, index) => {
        if (part.locked) return;
        part.x = poseCanvas.width / 2;
        part.y = poseCanvas.height / 2;
        part.rotation = 0;
        part.scale = 1;
        part.z = index;
      });
      syncInputs();
      renderPartsList();
      drawPose();
      scheduleAutosave();
    };

    document.getElementById("exportJson").onclick = () => {
      const payload = projectPayload();
      jsonBox.value = JSON.stringify(payload, null, 2);
      jsonBox.select();
    };

    document.getElementById("importJson").onclick = () => {
      try {
        const payload = JSON.parse(jsonBox.value);
        applyProjectPayload(payload);
        loadSheet();
        syncInputs();
        renderPartsList();
        drawPose();
        scheduleAutosave();
      } catch (error) {
        setStatus(`Import failed: ${error.message}`);
      }
    };

    document.getElementById("clearSaved").onclick = () => {
      localStorage.removeItem(storageKey);
      setStatus("Saved browser project cleared. Current canvas is unchanged.");
    };

    document.getElementById("saveProject").onclick = saveProject;
    document.getElementById("loadProject").onclick = loadProject;
    document.getElementById("deleteProject").onclick = deleteProject;
    document.getElementById("connectSaveFolder").onclick = connectRepoSaveFolder;
    document.getElementById("refreshRepoSaves").onclick = refreshRepoSaves;
    saveSelect.onchange = () => {
      const entry = selectedSaveEntry();
      if (entry) saveNameInput.value = entry.name;
    };

    document.getElementById("selectionMode").onchange = event => {
      selectionMode = event.target.value;
      crop = null;
      cropDrag = null;
      polygonClickStart = null;
      polygonPoints = [];
      drawSource();
      setStatus(selectionMode === "polygon"
        ? "Polygon mode: click around a precise shape, then Create Part or Create Overlay."
        : "Rectangle mode: drag a crop rectangle.");
    };

    document.getElementById("finishPolygon").onclick = () => {
      if (polygonPoints.length < 3) {
        setStatus("Polygon needs at least three points.");
        return;
      }
      crop = polygonBounds(polygonPoints);
      drawSource();
      setStatus("Polygon ready. Click Create Part or Create Overlay.");
    };

    document.querySelectorAll(".panel h2").forEach(header => {
      header.addEventListener("click", () => {
        header.parentElement.classList.toggle("collapsed");
      });
    });

    function applyPanelLayout() {
      const main = document.querySelector("main");
      const sourceCollapsed = document.getElementById("sourceSection").classList.contains("collapsed");
      const poseCollapsed = document.getElementById("poseSection").classList.contains("collapsed");
      const editorCollapsed = document.getElementById("assetEditorPanel").classList.contains("collapsed");
      const assetsCollapsed = document.getElementById("assetLibrary").classList.contains("collapsed");
      const sideCollapsed = document.getElementById("sidePanel").classList.contains("collapsed");
      const visibleTopPanels = [
        !sourceCollapsed && "source",
        !poseCollapsed && "pose",
        !editorCollapsed && "editor",
        !sideCollapsed && "side"
      ].filter(Boolean);

      main.classList.toggle("source-collapsed", sourceCollapsed);
      main.classList.toggle("pose-collapsed", poseCollapsed);
      main.classList.toggle("editor-collapsed", editorCollapsed);
      main.classList.toggle("assets-collapsed", assetsCollapsed);
      main.classList.toggle("side-collapsed", sideCollapsed);

      const columns = [];
      const areas = [];
      function addArea(area, track) {
        areas.push(area);
        columns.push(track);
      }

      if (!sourceCollapsed) {
        addArea("source", visibleTopPanels.length === 1 ? "minmax(260px, 1fr)" : "var(--source-width, minmax(260px, 1fr))");
      }
      if (!sourceCollapsed && !poseCollapsed) {
        addArea("sourcePose", "7px");
      }
      if (!poseCollapsed) {
        addArea("pose", visibleTopPanels.length === 1 ? "minmax(260px, 1fr)" : "var(--pose-width, minmax(260px, 1fr))");
      }
      if (!poseCollapsed && (!editorCollapsed || !sideCollapsed)) {
        addArea("poseSide", "7px");
      }
      if (!editorCollapsed) {
        const editorTrack = visibleTopPanels.length === 1
          ? "minmax(280px, 1fr)"
          : "var(--editor-width, minmax(300px, 420px))";
        addArea("editor", editorTrack);
      }
      if (!editorCollapsed && !sideCollapsed) {
        addArea("editorSide", "7px");
      }
      if (!sideCollapsed) {
        const sideTrack = visibleTopPanels.length === 1
          ? "minmax(280px, 1fr)"
          : "var(--side-width, minmax(280px, 360px))";
        addArea("side", sideTrack);
      }
      if (!areas.length) {
        addArea(".", "1fr");
      }

      main.style.gridTemplateColumns = columns.join(" ");
      main.style.gridTemplateAreas = `"${areas.join(" ")}" "${areas.map(() => assetsCollapsed ? "." : "asset").join(" ")}"`;
      main.style.setProperty("--asset-height", assetsCollapsed ? "0px" : "170px");

      document.querySelectorAll("[data-collapse-target]").forEach(button => {
        const target = document.getElementById(button.dataset.collapseTarget);
        const collapsed = target?.classList.contains("collapsed") ?? false;
        button.classList.toggle("is-collapsed", collapsed);
        button.setAttribute("aria-expanded", String(!collapsed));
        button.title = collapsed ? "Expand panel" : "Collapse panel";
      });

      document.querySelectorAll("[data-panel-toggle]").forEach(button => {
        const target = document.getElementById(button.dataset.panelToggle);
        const collapsed = target?.classList.contains("collapsed") ?? false;
        button.classList.toggle("is-collapsed", collapsed);
        button.setAttribute("aria-pressed", String(!collapsed));
      });
    }

    function setPanelCollapsed(targetId, collapsed) {
      const target = document.getElementById(targetId);
      if (!target) return;
      target.classList.toggle("collapsed", collapsed);
      if (normalizePanelLayout) normalizePanelLayout();
      else applyPanelLayout();
      drawSource();
      drawAssetEditor();
      drawPose();
    }

    document.querySelectorAll("[data-collapse-target]").forEach(button => {
      button.addEventListener("click", () => {
        const target = document.getElementById(button.dataset.collapseTarget);
        if (!target) return;
        setPanelCollapsed(target.id, !target.classList.contains("collapsed"));
      });
    });

    document.querySelectorAll("[data-panel-toggle]").forEach(button => {
      button.addEventListener("click", () => {
        const target = document.getElementById(button.dataset.panelToggle);
        if (!target) return;
        setPanelCollapsed(target.id, !target.classList.contains("collapsed"));
      });
    });

    window.addEventListener("keydown", event => {
      const tag = document.activeElement?.tagName;
      if (tag === "INPUT" || tag === "TEXTAREA" || tag === "SELECT") return;
      const key = event.key.toLowerCase();
      if ((key === "delete" || key === "backspace") && selectedId) {
        event.preventDefault();
        deleteSelectedPart();
        return;
      }
      if ((key === "delete" || key === "backspace") && selectedAssetId) {
        event.preventDefault();
        deleteAsset();
        return;
      }
      if (!event.ctrlKey && !event.metaKey) return;
      if (selectedAssetId && key === "z") {
        event.preventDefault();
        if (event.shiftKey) redoAssetEdit();
        else undoAssetEdit();
      } else if (selectedAssetId && key === "y") {
        event.preventDefault();
        redoAssetEdit();
      } else if (key === "c") {
        event.preventDefault();
        copySelectedPart();
      } else if (key === "v") {
        event.preventDefault();
        pasteCopiedPart();
      }
    });

    setupCanvasZoom(sourceCanvas, () => sourceZoom, value => { sourceZoom = value; });
    setupCanvasZoom(poseCanvas, () => poseZoom, value => { poseZoom = value; });
    setupMiddleMousePan(sourceCanvas);
    setupMiddleMousePan(poseCanvas);
    setupPanelResizers();
    window.addEventListener("resize", () => {
      if (normalizePanelLayout) normalizePanelLayout();
      drawAssetEditor();
      drawPose();
    });
    setupWheelInputs();
    setupAssetLibraryWheel();
    applyPanelLayout();
    updateAlphaPreviewButton();
    renderSaveList();
    loadRepoSavesFromServer();
    loadSavedProject();
    syncInputs();
    renderAssetLibrary();
    renderPartsList();
    loadSheet();
}
