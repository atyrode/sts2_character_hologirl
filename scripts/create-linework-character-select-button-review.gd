extends SceneTree

const OUTPUT_SIZE: Vector2i = Vector2i(132, 195)
const BACKGROUND_PATH: String = "res://Hologirl/images/charui/character_select_bg.png"
const CHARACTER_PATH: String = "res://Hologirl/images/charui/character_select_hologirl.png"
const OUTPUT_ROOT: String = "res://docs/design/art_archive/menu/character_select_button/linework-no-ref-02-review"
const PREVIEW_OUTPUT_PATH: String = OUTPUT_ROOT + "/preview-strip.png"
const VARIANTS: Array[Dictionary] = [
	{"name": "variant-001", "label": "face centered less zoom", "offset": Vector2i(-229, -23), "target_h": 390},
	{"name": "variant-002", "label": "face higher less zoom", "offset": Vector2i(-239, -34), "target_h": 410},
	{"name": "variant-003", "label": "variant 5 less zoom", "offset": Vector2i(-250, -43), "target_h": 430},
	{"name": "variant-004", "label": "slightly right less zoom", "offset": Vector2i(-239, -40), "target_h": 430},
	{"name": "variant-005", "label": "safest top less zoom", "offset": Vector2i(-221, -13), "target_h": 375},
]


func _init() -> void:
	var background := _load_image(BACKGROUND_PATH)
	var character := _load_image(CHARACTER_PATH)
	if background == null or character == null:
		quit(1)
		return

	var previews: Array[Image] = []
	for variant in VARIANTS:
		var portrait := _make_portrait(background, character, variant)
		var output_path: String = "%s/%s/result.png" % [OUTPUT_ROOT, variant["name"]]
		var error := portrait.save_png(output_path)
		if error != OK:
			push_error("Could not save character-select button variant to %s: %s" % [output_path, error])
			quit(1)
			return
		previews.append(portrait)

	var comparison := _make_preview_strip(previews)
	var preview_error := comparison.save_png(PREVIEW_OUTPUT_PATH)
	if preview_error != OK:
		push_error("Could not save character-select button preview strip: %s" % preview_error)
		quit(1)
		return

	print("Created Linework No Ref 02 character-select button review variants.")
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


func _make_portrait(background: Image, character: Image, variant: Dictionary) -> Image:
	var portrait := _make_background(background)
	var character_layer := _make_character_layer(character, variant["target_h"])
	_blend_clipped(portrait, character_layer, variant["offset"])
	return portrait


func _make_character_layer(source: Image, target_h: int) -> Image:
	var bounds := _find_subject_bounds(source)
	if bounds.size == Vector2i.ZERO:
		push_error("Could not find non-keyed character pixels.")
		return Image.create(1, 1, false, Image.FORMAT_RGBA8)

	var layer := source.duplicate()
	_apply_chroma_alpha(layer)

	var target_w := roundi(layer.get_width() * float(target_h) / layer.get_height())
	layer.resize(target_w, target_h, Image.INTERPOLATE_LANCZOS)
	return layer


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
