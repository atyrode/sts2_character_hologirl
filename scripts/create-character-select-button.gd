extends SceneTree

const OUTPUT_SIZE: Vector2i = Vector2i(132, 195)
const BACKGROUND_PATH: String = "res://Hologirl/images/charui/background_variants/bg_10_periwinkle_drift.png"
const CHARACTER_PATH: String = "res://Hologirl/images/charui/character_variants/character_03_chunky_vanilla.png"
const RUNTIME_OUTPUT_PATH: String = "res://Hologirl/images/charui/char_select_char_name.png"
const ARCHIVE_OUTPUT_PATH: String = "res://docs/design/art_archive/menu/character_select_button/attempt-002/result.png"
const PREVIEW_OUTPUT_PATH: String = "res://docs/design/art_archive/menu/character_select_button/left-shift-preview.png"
const PREVIEW_ATTEMPTS: Array[Dictionary] = [
	{"attempt": "attempt-003", "offset": Vector2i(-6, 2), "crop_bias": 0.40},
	{"attempt": "attempt-004", "offset": Vector2i(-14, 2), "crop_bias": 0.35},
	{"attempt": "attempt-005", "offset": Vector2i(-22, 2), "crop_bias": 0.30},
	{"attempt": "attempt-006", "offset": Vector2i(-21, 5), "crop_bias": 0.35, "target_h": 207},
	{"attempt": "attempt-007", "offset": Vector2i(-24, 7), "crop_bias": 0.34, "target_h": 216},
	{"attempt": "attempt-008", "offset": Vector2i(-28, 9), "crop_bias": 0.33, "target_h": 224},
	{"attempt": "attempt-009", "offset": Vector2i(-17, 5), "crop_bias": 0.35, "target_h": 207},
	{"attempt": "attempt-010", "offset": Vector2i(-13, 5), "crop_bias": 0.35, "target_h": 207},
	{"attempt": "attempt-011", "offset": Vector2i(-9, 5), "crop_bias": 0.35, "target_h": 207},
]


func _init() -> void:
	var background := _load_image(BACKGROUND_PATH)
	var character := _load_image(CHARACTER_PATH)
	if background == null or character == null:
		quit(1)
		return

	var runtime_portrait := _make_portrait(background, character, 0.35, Vector2i(-9, 5), 207)
	for path in [RUNTIME_OUTPUT_PATH, ARCHIVE_OUTPUT_PATH]:
		var error := runtime_portrait.save_png(path)
		if error != OK:
			push_error("Could not save character-select button to %s: %s" % [path, error])
			quit(1)
			return

	var previews: Array[Image] = []
	for variant in PREVIEW_ATTEMPTS:
		var portrait := _make_portrait(background, character, variant["crop_bias"], variant["offset"], variant.get("target_h", 190))
		var archive_path := "res://docs/design/art_archive/menu/character_select_button/%s/result.png" % variant["attempt"]
		var archive_error := portrait.save_png(archive_path)
		if archive_error != OK:
			push_error("Could not save character-select button preview to %s: %s" % [archive_path, archive_error])
			quit(1)
			return
		previews.append(portrait)

	var comparison := _make_preview_strip(previews)
	var preview_error := comparison.save_png(PREVIEW_OUTPUT_PATH)
	if preview_error != OK:
		push_error("Could not save character-select button preview strip: %s" % preview_error)
		quit(1)
		return

	print("Created Hologirl character-select button from Chunky Vanilla over Periwinkle Drift, plus left-shift previews.")
	quit(0)


func _load_image(path: String) -> Image:
	var image := Image.new()
	var error := image.load(path)
	if error != OK:
		push_error("Could not load %s: %s" % [path, error])
		return null

	image.convert(Image.FORMAT_RGBA8)
	return image


func _make_background(source: Image) -> Image:
	var scaled := source.duplicate()
	var scale := maxf(float(OUTPUT_SIZE.x) / source.get_width(), float(OUTPUT_SIZE.y) / source.get_height())
	var scaled_size := Vector2i(ceili(source.get_width() * scale), ceili(source.get_height() * scale))
	scaled.resize(scaled_size.x, scaled_size.y, Image.INTERPOLATE_LANCZOS)

	var crop_x := clampi(roundi((scaled_size.x - OUTPUT_SIZE.x) * 0.58), 0, max(0, scaled_size.x - OUTPUT_SIZE.x))
	var crop_y := clampi(roundi((scaled_size.y - OUTPUT_SIZE.y) * 0.50), 0, max(0, scaled_size.y - OUTPUT_SIZE.y))
	var output := Image.create(OUTPUT_SIZE.x, OUTPUT_SIZE.y, false, Image.FORMAT_RGBA8)
	output.blit_rect(scaled, Rect2i(Vector2i(crop_x, crop_y), OUTPUT_SIZE), Vector2i.ZERO)
	return output


func _make_portrait(background: Image, character: Image, crop_bias: float, offset: Vector2i, target_h: int = 190) -> Image:
	var portrait := _make_background(background)
	var character_crop := _make_character_crop(character, crop_bias, target_h)
	_blend_clipped(portrait, character_crop, offset)
	return portrait


func _make_character_crop(source: Image, crop_bias: float, target_h: int) -> Image:
	var bounds := _find_subject_bounds(source)
	if bounds.size == Vector2i.ZERO:
		push_error("Could not find non-keyed character pixels.")
		return Image.create(1, 1, false, Image.FORMAT_RGBA8)

	var center_x := bounds.position.x + bounds.size.x * 0.5
	var crop_w := roundi(bounds.size.x * 0.62)
	var crop_h := roundi(bounds.size.y * 0.58)
	var crop_x := clampi(roundi(center_x - crop_w * crop_bias), 0, max(0, source.get_width() - crop_w))
	var crop_y := clampi(bounds.position.y, 0, max(0, source.get_height() - crop_h))
	var crop_rect := Rect2i(Vector2i(crop_x, crop_y), Vector2i(crop_w, crop_h))

	var cropped := Image.create(crop_rect.size.x, crop_rect.size.y, false, Image.FORMAT_RGBA8)
	cropped.blit_rect(source, crop_rect, Vector2i.ZERO)
	_apply_chroma_alpha(cropped)

	var target_w := roundi(cropped.get_width() * float(target_h) / cropped.get_height())
	cropped.resize(target_w, target_h, Image.INTERPOLATE_LANCZOS)
	return cropped


func _blend_clipped(target: Image, source: Image, destination: Vector2i) -> void:
	var source_start := Vector2i(maxi(0, -destination.x), maxi(0, -destination.y))
	var target_start := Vector2i(maxi(0, destination.x), maxi(0, destination.y))
	var width := mini(source.get_width() - source_start.x, target.get_width() - target_start.x)
	var height := mini(source.get_height() - source_start.y, target.get_height() - target_start.y)
	if width <= 0 or height <= 0:
		return

	target.blend_rect(source, Rect2i(source_start, Vector2i(width, height)), target_start)


func _make_preview_strip(previews: Array[Image]) -> Image:
	var gap := 8
	var output := Image.create(OUTPUT_SIZE.x * previews.size() + gap * (previews.size() - 1), OUTPUT_SIZE.y, false, Image.FORMAT_RGBA8)
	output.fill(Color(0.08, 0.07, 0.10, 1.0))

	var x := 0
	for preview in previews:
		output.blit_rect(preview, Rect2i(Vector2i.ZERO, preview.get_size()), Vector2i(x, 0))
		x += OUTPUT_SIZE.x + gap

	return output


func _find_subject_bounds(image: Image) -> Rect2i:
	var min_x := image.get_width()
	var min_y := image.get_height()
	var max_x := -1
	var max_y := -1

	for y in image.get_height():
		for x in image.get_width():
			if _is_key_green(image.get_pixel(x, y)):
				continue

			min_x = mini(min_x, x)
			min_y = mini(min_y, y)
			max_x = maxi(max_x, x)
			max_y = maxi(max_y, y)

	if max_x < min_x or max_y < min_y:
		return Rect2i()

	return Rect2i(Vector2i(min_x, min_y), Vector2i(max_x - min_x + 1, max_y - min_y + 1))


func _apply_chroma_alpha(image: Image) -> void:
	for y in image.get_height():
		for x in image.get_width():
			var color := image.get_pixel(x, y)
			if _is_key_green(color):
				color.a = 0.0
			image.set_pixel(x, y, color)


func _is_key_green(color: Color) -> bool:
	return color.g > 0.75 and color.r < 0.20 and color.b < 0.25
