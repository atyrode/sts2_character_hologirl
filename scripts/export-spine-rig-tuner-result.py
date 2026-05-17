#!/usr/bin/env python3
"""Export the Spine rig tuner result into Hologirl runtime rig assets."""

from __future__ import annotations

import argparse
import json
import math
import re
from pathlib import Path

from PIL import Image, ImageChops, ImageDraw


CANVAS_CENTER = (450.0, 450.0)


def slug(value: str) -> str:
    value = re.sub(r"[^a-zA-Z0-9_]+", "_", value.strip().lower())
    value = re.sub(r"_+", "_", value).strip("_")
    return value or "part"


def apply_row_span_alpha(image: Image.Image, spans: list[list[int]]) -> Image.Image:
    mask = Image.new("L", image.size, 0)
    draw = ImageDraw.Draw(mask)
    for row, start, end in spans:
        y = row - 1
        x0 = start - 1
        x1 = end - 1
        if 0 <= y < image.height and x1 >= 0 and x0 < image.width:
            draw.line((max(0, x0), y, min(image.width - 1, x1), y), fill=255)

    rgba = image.convert("RGBA")
    r, g, b, a = rgba.split()
    rgba.putalpha(ImageChops.multiply(a, mask))
    return rgba


def apply_polygon_mask(image: Image.Image, mask_data: dict | list | None) -> Image.Image:
    if not mask_data:
        return image

    if isinstance(mask_data, list):
        points = mask_data
    elif mask_data.get("type") == "polygon":
        points = mask_data.get("points") or []
    else:
        return image

    if len(points) < 3:
        return image

    mask = Image.new("L", image.size, 0)
    draw = ImageDraw.Draw(mask)
    draw.polygon([(float(p["x"]), float(p["y"])) for p in points], fill=255)

    rgba = image.convert("RGBA")
    r, g, b, a = rgba.split()
    rgba.putalpha(ImageChops.multiply(a, mask))
    return rgba


def extract_part(sheet: Image.Image, part: dict) -> Image.Image:
    crop = part["crop"]
    image = sheet.crop((crop["x"], crop["y"], crop["x"] + crop["w"], crop["y"] + crop["h"]))

    alpha_mask = part.get("alphaMask")
    if alpha_mask and alpha_mask.get("type") == "rowSpans":
        image = apply_row_span_alpha(image, alpha_mask.get("spans") or [])

    return apply_polygon_mask(image, part.get("mask"))


def attachment_offset(part: dict) -> tuple[float, float]:
    crop = part["crop"]
    pivot_x = float(part.get("pivotX", crop["w"] / 2.0))
    pivot_y = float(part.get("pivotY", crop["h"] / 2.0))
    return crop["w"] / 2.0 - pivot_x, pivot_y - crop["h"] / 2.0


def bone_position(part: dict) -> tuple[float, float]:
    return float(part["x"]) - CANVAS_CENTER[0], CANVAS_CENTER[1] - float(part["y"])


def build_spine_json(parts: list[dict], image_names: dict[int, str]) -> dict:
    slots: list[dict] = []
    bones: list[dict] = [{"name": "root"}]
    attachments: dict[str, dict] = {}

    xs: list[float] = []
    ys: list[float] = []

    for index, part in enumerate(parts):
        name = image_names[index]
        crop = part["crop"]
        x, y = bone_position(part)
        scale = float(part.get("scale", 1.0))
        rotation = -float(part.get("rotation", 0.0))
        visible = bool(part.get("visible", True))
        opacity = float(part.get("opacity", 1.0))
        brightness = float(part.get("brightness", 1.0))

        bone: dict = {
            "name": name,
            "parent": "root",
            "x": round(x, 3),
            "y": round(y, 3),
        }
        if abs(rotation) > 0.0001:
            bone["rotation"] = round(rotation, 3)
        if abs(scale - 1.0) > 0.0001:
            bone["scaleX"] = round(scale, 4)
            bone["scaleY"] = round(scale, 4)
        bones.append(bone)

        slot: dict = {"name": name, "bone": name, "attachment": name if visible else None}
        if opacity < 0.999 or abs(brightness - 1.0) > 0.001:
            value = max(0, min(255, round(255 * brightness)))
            alpha = max(0, min(255, round(255 * opacity)))
            slot["color"] = f"{value:02x}{value:02x}{value:02x}{alpha:02x}"
        slots.append(slot)

        offset_x, offset_y = attachment_offset(part)
        attachments[name] = {
            name: {
                "type": "region",
                "path": name,
                "x": round(offset_x, 3),
                "y": round(offset_y, 3),
                "width": crop["w"],
                "height": crop["h"],
            }
        }

        radius = math.hypot(crop["w"], crop["h"]) * scale / 2.0
        xs.extend([x - radius, x + radius])
        ys.extend([y - radius, y + radius])

    animations = {
        "idle": {
            "bones": {
                "root": {
                    "translate": [
                        {"time": 0.0, "x": 0, "y": 0},
                        {"time": 0.8, "x": 0, "y": 4},
                        {"time": 1.6, "x": 0, "y": 0},
                    ]
                }
            }
        }
    }

    for name in image_names.values():
        if "hair" in name or "ponytail" in name:
            animations["idle"]["bones"][name] = {
                "rotate": [
                    {"time": 0.0, "angle": -1.5},
                    {"time": 0.8, "angle": 1.5},
                    {"time": 1.6, "angle": -1.5},
                ]
            }
        elif "torso" in name or "head" in name:
            animations["idle"]["bones"][name] = {
                "rotate": [
                    {"time": 0.0, "angle": -0.8},
                    {"time": 0.8, "angle": 0.8},
                    {"time": 1.6, "angle": -0.8},
                ]
            }

    min_x = min(xs) if xs else -300
    max_x = max(xs) if xs else 300
    min_y = min(ys) if ys else -300
    max_y = max(ys) if ys else 300

    return {
        "skeleton": {
            "spine": "4.2.00",
            "x": round(min_x),
            "y": round(min_y),
            "width": round(max_x - min_x),
            "height": round(max_y - min_y),
            "images": "./images/",
            "audio": "./audio/",
        },
        "bones": bones,
        "slots": slots,
        "skins": [{"name": "default", "attachments": attachments}],
        "animations": animations,
    }


def write_atlas(parts: list[dict], image_names: dict[int, str], atlas_path: Path) -> None:
    blocks: list[str] = []
    for index, part in enumerate(parts):
        name = image_names[index]
        crop = part["crop"]
        width = crop["w"]
        height = crop["h"]
        blocks.append(
            "\n".join(
                [
                    f"images/{name}.png",
                    f"size: {width},{height}",
                    "format: RGBA8888",
                    "filter: Linear,Linear",
                    "repeat: none",
                    name,
                    "  rotate: false",
                    "  xy: 0, 0",
                    f"  size: {width}, {height}",
                    f"  orig: {width}, {height}",
                    "  offset: 0, 0",
                    "  index: -1",
                ]
            )
        )
    atlas_path.write_text("\n\n".join(blocks) + "\n", encoding="utf-8")


def godot_float(value: float) -> str:
    return f"{value:.6f}".rstrip("0").rstrip(".") or "0"


def write_godot_layered_scene(parts: list[dict], image_names: dict[int, str], scene_path: Path) -> None:
    transformed_bounds: list[tuple[float, float]] = []
    for part in parts:
        crop = part["crop"]
        x = float(part["x"]) - CANVAS_CENTER[0]
        y = float(part["y"]) - CANVAS_CENTER[1]
        rotation = math.radians(float(part.get("rotation", 0.0)))
        scale = float(part.get("scale", 1.0))
        pivot_x = float(part.get("pivotX", crop["w"] / 2.0))
        pivot_y = float(part.get("pivotY", crop["h"] / 2.0))
        cos_r = math.cos(rotation)
        sin_r = math.sin(rotation)
        for corner_x, corner_y in ((0, 0), (crop["w"], 0), (crop["w"], crop["h"]), (0, crop["h"])):
            local_x = (corner_x - pivot_x) * scale
            local_y = (corner_y - pivot_y) * scale
            transformed_bounds.append(
                (
                    x + local_x * cos_r - local_y * sin_r,
                    y + local_x * sin_r + local_y * cos_r,
                )
            )

    min_x = min(point[0] for point in transformed_bounds)
    max_x = max(point[0] for point in transformed_bounds)
    max_y = max(point[1] for point in transformed_bounds)
    scene_offset_x = -((min_x + max_x) / 2.0)
    scene_offset_y = -max_y

    lines: list[str] = [
        f'[gd_scene load_steps={len(parts) + 1} format=3 uid="uid://hologirltunerrignode"]',
        "",
    ]

    for index, part in enumerate(parts):
        name = image_names[index]
        lines.append(
            f'[ext_resource type="Texture2D" path="res://Hologirl/animation/binary/images/{name}.png" id="{index + 1}_{name}"]'
        )

    lines.extend(["", '[node name="HologirlTunerRigNode" type="Node2D"]'])

    for index, part in enumerate(parts):
        name = image_names[index]
        crop = part["crop"]
        x = float(part["x"]) - CANVAS_CENTER[0] + scene_offset_x
        y = float(part["y"]) - CANVAS_CENTER[1] + scene_offset_y
        rotation = math.radians(float(part.get("rotation", 0.0)))
        scale = float(part.get("scale", 1.0))
        pivot_x = float(part.get("pivotX", crop["w"] / 2.0))
        pivot_y = float(part.get("pivotY", crop["h"] / 2.0))
        opacity = float(part.get("opacity", 1.0))
        brightness = float(part.get("brightness", 1.0))
        visible = bool(part.get("visible", True))
        z = int(round(float(part.get("z", 0.0))))

        lines.extend(
            [
                "",
                f'[node name="{name}" type="Node2D" parent="."]',
                f"position = Vector2({godot_float(x)}, {godot_float(y)})",
            ]
        )
        if abs(rotation) > 0.000001:
            lines.append(f"rotation = {godot_float(rotation)}")
        if abs(scale - 1.0) > 0.000001:
            lines.append(f"scale = Vector2({godot_float(scale)}, {godot_float(scale)})")
        if not visible:
            lines.append("visible = false")
        lines.append(f"z_index = {z}")

        lines.extend(
            [
                "",
                f'[node name="Sprite" type="Sprite2D" parent="{name}"]',
                "centered = false",
                f"position = Vector2({godot_float(-pivot_x)}, {godot_float(-pivot_y)})",
                f'texture = ExtResource("{index + 1}_{name}")',
            ]
        )
        if opacity < 0.999 or abs(brightness - 1.0) > 0.001:
            lines.append(
                "modulate = Color("
                f"{godot_float(brightness)}, {godot_float(brightness)}, {godot_float(brightness)}, {godot_float(opacity)}"
                ")"
            )

    scene_path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def export(args: argparse.Namespace) -> None:
    data = json.loads(args.result_json.read_text(encoding="utf-8"))
    sheet = Image.open(args.sheet_png).convert("RGBA")
    parts = [part for part in data.get("parts", []) if part.get("crop") and "x" in part and "y" in part]
    parts.sort(key=lambda part: (float(part.get("z", 0.0)), data.get("parts", []).index(part)))

    args.images_dir.mkdir(parents=True, exist_ok=True)

    image_names: dict[int, str] = {}
    seen: set[str] = set()
    for index, part in enumerate(parts):
        base = f"rig_{index + 1:02d}_{slug(str(part.get('slot') or part.get('name') or 'part'))}"
        name = base
        suffix = 2
        while name in seen:
            name = f"{base}_{suffix}"
            suffix += 1
        seen.add(name)
        image_names[index] = name

        image = extract_part(sheet, part)
        image.save(args.images_dir / f"{name}.png")

    write_atlas(parts, image_names, args.atlas_path)
    spine_json = build_spine_json(parts, image_names)
    args.spine_json_path.write_text(json.dumps(spine_json, indent=2) + "\n", encoding="utf-8")
    write_godot_layered_scene(parts, image_names, args.godot_scene_path)

    print(f"Exported {len(parts)} rig parts")
    print(args.atlas_path)
    print(args.spine_json_path)
    print(args.godot_scene_path)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--result-json",
        type=Path,
        default=Path("docs/design/tools/spine-rig-tuner/result.json"),
    )
    parser.add_argument(
        "--sheet-png",
        type=Path,
        default=Path("docs/design/art_archive/character/spine/attempt-003-rig-sheets/sheet-f-overlap-rig-3q-transparent.png"),
    )
    parser.add_argument(
        "--atlas-path",
        type=Path,
        default=Path("Hologirl/animation/binary/hologirl_multipart.atlas"),
    )
    parser.add_argument(
        "--spine-json-path",
        type=Path,
        default=Path("Hologirl/animation/binary/hologirl_multipart.spine-json"),
    )
    parser.add_argument(
        "--images-dir",
        type=Path,
        default=Path("Hologirl/animation/binary/images"),
    )
    parser.add_argument(
        "--godot-scene-path",
        type=Path,
        default=Path("Hologirl/animation/hologirl_tuner_rig_node.tscn"),
    )
    export(parser.parse_args())


if __name__ == "__main__":
    main()
