#!/usr/bin/env python3
"""Split a chroma-keyed PNG rig sheet into cropped transparent layer PNGs.

This intentionally avoids external image dependencies so it can run on the VPS
while we are still experimenting with Hologirl puppet sheets.
"""

from __future__ import annotations

import argparse
from collections import deque
from pathlib import Path
import struct
import zlib


PNG_SIGNATURE = b"\x89PNG\r\n\x1a\n"


def _read_png(path: Path) -> tuple[int, int, list[tuple[int, int, int, int]]]:
    data = path.read_bytes()
    if not data.startswith(PNG_SIGNATURE):
        raise SystemExit(f"{path} is not a PNG file")

    offset = len(PNG_SIGNATURE)
    width = 0
    height = 0
    color_type = -1
    bit_depth = -1
    compressed = bytearray()

    while offset < len(data):
        length = struct.unpack(">I", data[offset : offset + 4])[0]
        chunk_type = data[offset + 4 : offset + 8]
        chunk_data = data[offset + 8 : offset + 8 + length]
        offset += 12 + length

        if chunk_type == b"IHDR":
            width, height, bit_depth, color_type, _, _, _ = struct.unpack(">IIBBBBB", chunk_data)
        elif chunk_type == b"IDAT":
            compressed.extend(chunk_data)
        elif chunk_type == b"IEND":
            break

    if bit_depth != 8 or color_type not in {2, 6}:
        raise SystemExit("Only 8-bit RGB/RGBA PNGs are supported")

    channels = 4 if color_type == 6 else 3
    stride = width * channels
    raw = zlib.decompress(bytes(compressed))
    rows: list[bytearray] = []
    pos = 0
    previous = bytearray(stride)

    for _y in range(height):
        filter_type = raw[pos]
        pos += 1
        scanline = bytearray(raw[pos : pos + stride])
        pos += stride
        recon = bytearray(stride)

        for i, value in enumerate(scanline):
            left = recon[i - channels] if i >= channels else 0
            up = previous[i]
            upper_left = previous[i - channels] if i >= channels else 0
            if filter_type == 0:
                predictor = 0
            elif filter_type == 1:
                predictor = left
            elif filter_type == 2:
                predictor = up
            elif filter_type == 3:
                predictor = (left + up) // 2
            elif filter_type == 4:
                predictor = _paeth(left, up, upper_left)
            else:
                raise SystemExit(f"Unsupported PNG filter: {filter_type}")
            recon[i] = (value + predictor) & 0xFF

        rows.append(recon)
        previous = recon

    pixels: list[tuple[int, int, int, int]] = []
    for row in rows:
        for x in range(width):
            i = x * channels
            red = row[i]
            green = row[i + 1]
            blue = row[i + 2]
            alpha = row[i + 3] if channels == 4 else 255
            pixels.append((red, green, blue, alpha))

    return width, height, pixels


def _paeth(left: int, up: int, upper_left: int) -> int:
    p = left + up - upper_left
    pa = abs(p - left)
    pb = abs(p - up)
    pc = abs(p - upper_left)
    if pa <= pb and pa <= pc:
        return left
    if pb <= pc:
        return up
    return upper_left


def _write_png(path: Path, width: int, height: int, pixels: list[tuple[int, int, int, int]]) -> None:
    raw = bytearray()
    for y in range(height):
        raw.append(0)
        for x in range(width):
            raw.extend(pixels[y * width + x])

    def chunk(kind: bytes, payload: bytes) -> bytes:
        return (
            struct.pack(">I", len(payload))
            + kind
            + payload
            + struct.pack(">I", zlib.crc32(kind + payload) & 0xFFFFFFFF)
        )

    png = bytearray(PNG_SIGNATURE)
    png.extend(chunk(b"IHDR", struct.pack(">IIBBBBB", width, height, 8, 6, 0, 0, 0)))
    png.extend(chunk(b"IDAT", zlib.compress(bytes(raw), 9)))
    png.extend(chunk(b"IEND", b""))
    path.write_bytes(png)


def _is_keyed(pixel: tuple[int, int, int, int]) -> bool:
    red, green, blue, alpha = pixel
    if alpha < 8:
        return True
    return green > 120 and green > red + 24 and green > blue + 24


def _components(width: int, height: int, mask: list[bool], min_pixels: int) -> list[list[int]]:
    seen = [False] * (width * height)
    result: list[list[int]] = []
    for start, occupied in enumerate(mask):
        if not occupied or seen[start]:
            continue

        queue: deque[int] = deque([start])
        seen[start] = True
        component: list[int] = []
        while queue:
            index = queue.popleft()
            component.append(index)
            x = index % width
            y = index // width
            for ny in range(max(0, y - 1), min(height, y + 2)):
                for nx in range(max(0, x - 1), min(width, x + 2)):
                    neighbor = ny * width + nx
                    if mask[neighbor] and not seen[neighbor]:
                        seen[neighbor] = True
                        queue.append(neighbor)

        if len(component) >= min_pixels:
            result.append(component)

    result.sort(key=len, reverse=True)
    return result


def _transparent_pixels(width: int, height: int) -> list[tuple[int, int, int, int]]:
    return [(0, 0, 0, 0)] * (width * height)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("input", type=Path)
    parser.add_argument("output_dir", type=Path)
    parser.add_argument("--min-pixels", type=int, default=900)
    parser.add_argument("--padding", type=int, default=12)
    args = parser.parse_args()

    width, height, pixels = _read_png(args.input)
    alpha_pixels = [(r, g, b, 0 if _is_keyed((r, g, b, a)) else a) for r, g, b, a in pixels]
    mask = [pixel[3] > 0 for pixel in alpha_pixels]

    args.output_dir.mkdir(parents=True, exist_ok=True)
    _write_png(args.output_dir / "sheet-transparent.png", width, height, alpha_pixels)

    manifest_lines = ["# Split Layers", ""]
    for idx, component in enumerate(_components(width, height, mask, args.min_pixels), start=1):
        xs = [point % width for point in component]
        ys = [point // width for point in component]
        left = max(0, min(xs) - args.padding)
        top = max(0, min(ys) - args.padding)
        right = min(width - 1, max(xs) + args.padding)
        bottom = min(height - 1, max(ys) + args.padding)
        crop_width = right - left + 1
        crop_height = bottom - top + 1
        crop = _transparent_pixels(crop_width, crop_height)
        component_set = set(component)

        for y in range(top, bottom + 1):
            for x in range(left, right + 1):
                source_index = y * width + x
                if source_index in component_set:
                    crop[(y - top) * crop_width + (x - left)] = alpha_pixels[source_index]

        filename = f"layer_{idx:02d}.png"
        _write_png(args.output_dir / filename, crop_width, crop_height, crop)
        manifest_lines.append(f"- `{filename}`: source rect x={left}, y={top}, w={crop_width}, h={crop_height}, pixels={len(component)}")

    (args.output_dir / "manifest.md").write_text("\n".join(manifest_lines) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
