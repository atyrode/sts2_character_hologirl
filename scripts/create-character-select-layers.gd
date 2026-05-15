extends SceneTree

const SOURCE_PATH: String = "res://Hologirl/images/charui/character_variants/character_03_chunky_vanilla.png"
const OUTPUT_DIR: String = "res://Hologirl/images/charui/character_layers"
const ARCHIVE_DIR: String = "res://docs/design/art_archive/menu/character_select_layers/chunky_layered_attempt-001"

const LAYER_SPECS: Dictionary = {
	"base": 0,
	"whip": 1,
	"ponytails": 2,
	"arm": 3,
}


func _init() -> void:
	var source := Image.new()
	var error := source.load(SOURCE_PATH)
	if error != OK:
		push_error("Could not load %s: %s" % [SOURCE_PATH, error])
		quit(1)
		return

	source.convert(Image.FORMAT_RGBA8)
	var masks := _build_masks(source)
	var outputs := {
		"base": _make_layer(source, masks, LAYER_SPECS["base"]),
		"whip": _make_layer(source, masks, LAYER_SPECS["whip"]),
		"ponytails": _make_layer(source, masks, LAYER_SPECS["ponytails"]),
		"arm": _make_layer(source, masks, LAYER_SPECS["arm"]),
	}

	for name in outputs.keys():
		var runtime_path := "%s/chunky_%s.png" % [OUTPUT_DIR, name]
		var archive_path := "%s/chunky_%s.png" % [ARCHIVE_DIR, name]
		for path in [runtime_path, archive_path]:
			var save_error: Error = outputs[name].save_png(path)
			if save_error != OK:
				push_error("Could not save %s: %s" % [path, save_error])
				quit(1)
				return

	print("Created layered Chunky Vanilla character-select assets.")
	quit(0)


func _build_masks(source: Image) -> Array[int]:
	var masks: Array[int] = []
	masks.resize(source.get_width() * source.get_height())
	masks.fill(LAYER_SPECS["base"])

	for y in source.get_height():
		for x in source.get_width():
			var color := source.get_pixel(x, y)
			var index := y * source.get_width() + x
			if _is_key_green(color):
				masks[index] = -1
			elif _is_whip_gold(color):
				masks[index] = LAYER_SPECS["whip"]
			elif _is_ponytail_pixel(color, x, y, source.get_width(), source.get_height()):
				masks[index] = LAYER_SPECS["ponytails"]
			elif _is_arm_pixel(color, x, y, source.get_width(), source.get_height()):
				masks[index] = LAYER_SPECS["arm"]

	return masks


func _make_layer(source: Image, masks: Array[int], layer_id: int) -> Image:
	var output := Image.create(source.get_width(), source.get_height(), false, Image.FORMAT_RGBA8)
	output.fill(Color(0.0, 0.0, 0.0, 0.0))

	for y in source.get_height():
		for x in source.get_width():
			var index := y * source.get_width() + x
			var color := source.get_pixel(x, y)
			if layer_id == LAYER_SPECS["base"]:
				if masks[index] >= 0 and masks[index] != LAYER_SPECS["whip"] and masks[index] != LAYER_SPECS["ponytails"] and masks[index] != LAYER_SPECS["arm"]:
					color.a = 1.0
					output.set_pixel(x, y, color)
			elif masks[index] == layer_id:
				color.a = 1.0
				output.set_pixel(x, y, color)

	return output


func _is_key_green(color: Color) -> bool:
	return color.g > 0.75 and color.r < 0.20 and color.b < 0.25


func _is_whip_gold(color: Color) -> bool:
	return color.r > 0.68 and color.g > 0.42 and color.b < 0.32 and color.r > color.b * 1.8


func _is_hologram_blue(color: Color) -> bool:
	return color.b > 0.42 and color.g > 0.30 and color.r < 0.48 and color.b > color.r * 1.35


func _is_ponytail_pixel(color: Color, x: int, y: int, width: int, height: int) -> bool:
	if not _is_hologram_blue(color):
		return false

	var uv := Vector2(float(x) / width, float(y) / height)
	return (
		(uv.x > 0.05 and uv.x < 0.34 and uv.y > 0.08 and uv.y < 0.70) or
		(uv.x > 0.64 and uv.x < 0.96 and uv.y > 0.09 and uv.y < 0.66)
	)


func _is_arm_pixel(color: Color, x: int, y: int, width: int, height: int) -> bool:
	if not _is_hologram_blue(color):
		return false

	var uv := Vector2(float(x) / width, float(y) / height)
	return uv.x > 0.58 and uv.x < 0.98 and uv.y > 0.46 and uv.y < 0.82
