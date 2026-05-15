extends Control

const VIRTUAL_SIZE: Vector2 = Vector2(2564.0, 1204.0)
const DEFAULT_HOLOGIRL_POS: Vector2 = Vector2(842.0, 120.0)
const DEFAULT_HOLOGIRL_SIZE: Vector2 = Vector2(1180.0, 787.0)
const HOLOGIRL_TEXTURE: String = "res://Hologirl/images/charui/character_select_hologirl.png"
const SHOW_TUNING_PANEL: bool = true
const TUNING_PANEL_MARGIN: Vector2 = Vector2(24.0, 24.0)
const DEFAULT_HOLOGIRL_SCALE: float = 1.49
const DEFAULT_WHIP_DENSITY: float = 1.05
const DEFAULT_DRIFT_DENSITY: float = 0.29
const DEFAULT_WHIP_JITTER: float = 80.0
const BACKGROUND_VARIANT_NAMES: Array[String] = [
	"Blue Static Idol Flame",
	"Holo Nebula Spiral",
	"CRT Aurora",
	"Golden Fan Sparks",
	"Projection Pool",
	"Signal Flower",
	"Blue Idol Curtain",
	"Pixel Dust Comet",
	"Silent Broadcast Ocean",
	"Soft Cyan Eclipse",
]
const BACKGROUND_VARIANT_PATHS: Array[String] = [
	"res://Hologirl/images/charui/background_variants/bg_01_blue_static_idol_flame.png",
	"res://Hologirl/images/charui/background_variants/bg_02_holo_nebula_spiral.png",
	"res://Hologirl/images/charui/background_variants/bg_03_crt_aurora.png",
	"res://Hologirl/images/charui/background_variants/bg_04_golden_fan_sparks.png",
	"res://Hologirl/images/charui/background_variants/bg_05_projection_pool.png",
	"res://Hologirl/images/charui/background_variants/bg_06_signal_flower.png",
	"res://Hologirl/images/charui/background_variants/bg_07_blue_idol_curtain.png",
	"res://Hologirl/images/charui/background_variants/bg_08_pixel_dust_comet.png",
	"res://Hologirl/images/charui/background_variants/bg_09_silent_broadcast_ocean.png",
	"res://Hologirl/images/charui/background_variants/bg_10_soft_cyan_eclipse.png",
]

static var _saved_character_pos: Vector2 = DEFAULT_HOLOGIRL_POS
static var _saved_character_scale: float = DEFAULT_HOLOGIRL_SCALE
static var _saved_whip_density: float = DEFAULT_WHIP_DENSITY
static var _saved_drift_density: float = DEFAULT_DRIFT_DENSITY
static var _saved_whip_jitter: float = DEFAULT_WHIP_JITTER
static var _saved_background_variant: int = 0

var _canvas: Control
var _background: TextureRect
var _character: TextureRect
var _back_particle_layer: Control
var _front_particle_layer: Control
var _tuning_panel: PanelContainer
var _tuning_body: VBoxContainer
var _collapse_button: Button
var _tuning_values_label: Label
var _background_selector: OptionButton
var _tuning_sliders: Dictionary = {}
var _rng: RandomNumberGenerator = RandomNumberGenerator.new()
var _whip_emitters: Array[Vector2] = []
var _body_emitters: Array[Vector2] = []
var _spark_timer: float = 0.0
var _drift_timer: float = 0.0
var _glow_timer: float = 0.0
var _character_pos: Vector2 = DEFAULT_HOLOGIRL_POS
var _character_scale: float = DEFAULT_HOLOGIRL_SCALE
var _whip_density: float = DEFAULT_WHIP_DENSITY
var _drift_density: float = DEFAULT_DRIFT_DENSITY
var _glow_density: float = 0.10
var _whip_jitter: float = DEFAULT_WHIP_JITTER
var _background_variant: int = 0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	mouse_filter = Control.MOUSE_FILTER_PASS if SHOW_TUNING_PANEL else Control.MOUSE_FILTER_IGNORE
	clip_contents = not SHOW_TUNING_PANEL
	set_process(true)
	_rng.randomize()
	_restore_saved_tuning_values()
	_build_scene()
	_apply_layout()
	_spawn_selection_burst()
	_spark_timer = 0.02
	_drift_timer = 0.05
	_glow_timer = 0.08


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		_apply_layout()


func _process(delta: float) -> void:
	_apply_tuning_panel_layout()

	_spark_timer -= delta
	_drift_timer -= delta
	_glow_timer -= delta

	if _whip_density > 0.0:
		while _spark_timer <= 0.0:
			_spawn_whip_spark(false)
			_spark_timer += _rng.randf_range(0.070, 0.130) / _whip_density
	else:
		_spark_timer = 0.25

	if _drift_density > 0.0:
		while _drift_timer <= 0.0:
			_spawn_hologram_drift(false)
			_drift_timer += _rng.randf_range(0.13, 0.22) / _drift_density
	else:
		_drift_timer = 0.25

	if _glow_density > 0.0:
		while _glow_timer <= 0.0:
			_spawn_background_glow(false)
			_glow_timer += _rng.randf_range(0.35, 0.65) / _glow_density
	else:
		_glow_timer = 0.50


func _build_scene() -> void:
	_canvas = Control.new()
	_canvas.name = "VirtualCanvas"
	_canvas.size = VIRTUAL_SIZE
	_canvas.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_canvas.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(_canvas)

	_background = TextureRect.new()
	_background.name = "SimpleBackground"
	_background.size = VIRTUAL_SIZE
	_background.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_background.stretch_mode = TextureRect.STRETCH_SCALE
	_background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_canvas.add_child(_background)
	_apply_background_variant()

	_back_particle_layer = _create_particle_layer("HologirlBackParticles")
	_canvas.add_child(_back_particle_layer)

	var character_texture: Texture2D = load(HOLOGIRL_TEXTURE)
	_build_emitters(character_texture)

	_character = TextureRect.new()
	_character.name = "HologirlLayer"
	_character.texture = character_texture
	_character.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_character.stretch_mode = TextureRect.STRETCH_SCALE
	_character.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_character.material = _create_chroma_key_material()
	_canvas.add_child(_character)
	_apply_character_tuning()

	_front_particle_layer = _create_particle_layer("HologirlFrontParticles")
	_canvas.add_child(_front_particle_layer)

	if SHOW_TUNING_PANEL:
		_tuning_panel = _build_tuning_panel()
		add_child(_tuning_panel)


func _create_particle_layer(layer_name: String) -> Control:
	var layer: Control = Control.new()
	layer.name = layer_name
	layer.size = VIRTUAL_SIZE
	layer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	layer.process_mode = Node.PROCESS_MODE_ALWAYS
	return layer


func _build_emitters(texture: Texture2D) -> void:
	_whip_emitters.clear()
	_body_emitters.clear()

	if texture == null:
		_add_fallback_emitters()
		return

	var image: Image = texture.get_image()
	if image == null:
		_add_fallback_emitters()
		return

	var image_size: Vector2 = Vector2(image.get_width(), image.get_height())
	for y in range(0, image.get_height(), 8):
		for x in range(0, image.get_width(), 8):
			var color: Color = image.get_pixel(x, y)
			if _is_green_key(color):
				continue

			var normalized: Vector2 = Vector2(float(x) / image_size.x, float(y) / image_size.y)
			if _is_whip_gold(color):
				_whip_emitters.append(normalized)
			elif _is_hologram_blue(color):
				_body_emitters.append(normalized)

	if _whip_emitters.is_empty() or _body_emitters.is_empty():
		_add_fallback_emitters()


func _is_green_key(color: Color) -> bool:
	return color.g > 0.75 and color.r < 0.20 and color.b < 0.25


func _is_whip_gold(color: Color) -> bool:
	return color.r > 0.68 and color.g > 0.42 and color.b < 0.32 and color.r > color.b * 1.8


func _is_hologram_blue(color: Color) -> bool:
	return color.b > 0.42 and color.g > 0.30 and color.r < 0.48 and color.b > color.r * 1.35


func _add_fallback_emitters() -> void:
	if _whip_emitters.is_empty():
		_whip_emitters = [
			Vector2(0.50, 0.50),
			Vector2(0.58, 0.41),
			Vector2(0.66, 0.32),
			Vector2(0.76, 0.28),
			Vector2(0.84, 0.33),
			Vector2(0.86, 0.46),
			Vector2(0.78, 0.61),
			Vector2(0.67, 0.72),
		]

	if _body_emitters.is_empty():
		_body_emitters = [
			Vector2(0.26, 0.28),
			Vector2(0.48, 0.28),
			Vector2(0.54, 0.52),
			Vector2(0.42, 0.68),
			Vector2(0.78, 0.54),
			Vector2(0.20, 0.62),
		]


func _apply_layout() -> void:
	if _canvas == null:
		return

	var bounds: Vector2 = size
	if bounds.x <= 0.0 or bounds.y <= 0.0:
		bounds = get_viewport_rect().size

	var scale_value: float = max(bounds.x / VIRTUAL_SIZE.x, bounds.y / VIRTUAL_SIZE.y)
	_canvas.scale = Vector2.ONE * scale_value
	_canvas.position = (bounds - VIRTUAL_SIZE * scale_value) * 0.5
	_apply_tuning_panel_layout()


func _create_chroma_key_material() -> ShaderMaterial:
	var shader: Shader = Shader.new()
	shader.code = """
shader_type canvas_item;
uniform vec4 key_color : source_color = vec4(0.0, 1.0, 0.0, 1.0);
uniform float threshold = 0.46;
uniform float softness = 0.08;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	float keyed = smoothstep(threshold, threshold + softness, distance(tex.rgb, key_color.rgb));
	tex.a *= keyed;
	COLOR = tex;
}
"""

	var material: ShaderMaterial = ShaderMaterial.new()
	material.shader = shader
	return material


func _spawn_selection_burst() -> void:
	for i in 10:
		_spawn_whip_spark(true)

	for i in 12:
		_spawn_hologram_drift(true)

	for i in 2:
		_spawn_background_glow(true)


func _spawn_whip_spark(burst: bool) -> void:
	var anchor: Vector2 = _sample_character_point(_whip_emitters)
	var jitter: Vector2 = Vector2(_rng.randf_range(-_whip_jitter, _whip_jitter), _rng.randf_range(-_whip_jitter, _whip_jitter))
	var lifetime: float = _rng.randf_range(0.55, 1.0 if burst else 0.78)
	var particle_size: Vector2 = Vector2(_rng.randf_range(7.0, 13.0), _rng.randf_range(7.0, 13.0))
	var velocity: Vector2 = Vector2(_rng.randf_range(-14.0, 20.0), _rng.randf_range(-30.0, -8.0))
	var color: Color = Color(1.0, 0.82, 0.22, _rng.randf_range(0.72, 1.0))
	_spawn_particle(anchor + jitter, velocity, particle_size, lifetime, color, true, _front_particle_layer)


func _spawn_hologram_drift(burst: bool) -> void:
	var position: Vector2 = _sample_character_point(_body_emitters)
	var particle_size: Vector2 = Vector2(_rng.randf_range(46.0, 120.0), _rng.randf_range(5.0, 12.0))
	var velocity: Vector2 = Vector2(_rng.randf_range(-42.0, 38.0), _rng.randf_range(-8.0, 8.0))
	var lifetime: float = _rng.randf_range(0.55, 1.10 if burst else 0.82)
	var color: Color = Color(0.20, 0.86, 1.0, _rng.randf_range(0.20, 0.44))
	var layer: Control = _front_particle_layer if _rng.randf() > 0.45 else _back_particle_layer
	_spawn_particle(position, velocity, particle_size, lifetime, color, false, layer)


func _spawn_background_glow(burst: bool) -> void:
	var position: Vector2 = _sample_character_point(_whip_emitters)
	var particle_size: Vector2 = Vector2(_rng.randf_range(14.0, 26.0), _rng.randf_range(14.0, 26.0))
	var velocity: Vector2 = Vector2(_rng.randf_range(-18.0, 20.0), _rng.randf_range(-46.0, -16.0))
	var lifetime: float = _rng.randf_range(0.95, 1.45 if burst else 1.20)
	var color: Color = Color(1.0, 0.70, 0.18, _rng.randf_range(0.26, 0.44))
	_spawn_particle(position, velocity, particle_size, lifetime, color, true, _back_particle_layer)


func _sample_character_point(points: Array[Vector2]) -> Vector2:
	if points.is_empty():
		_add_fallback_emitters()

	var normalized: Vector2 = points[_rng.randi_range(0, points.size() - 1)]
	return _character_pos + normalized * _current_character_size()


func _spawn_particle(position: Vector2, velocity: Vector2, particle_size: Vector2, lifetime: float, color: Color, sparkle: bool, layer: Control) -> void:
	var particle: HologirlParticle = HologirlParticle.new()
	particle.particle_color = color
	particle.sparkle = sparkle
	particle.size = particle_size
	particle.position = position - particle_size * 0.5
	particle.pivot_offset = particle_size * 0.5
	particle.mouse_filter = Control.MOUSE_FILTER_IGNORE
	particle.process_mode = Node.PROCESS_MODE_ALWAYS
	if sparkle:
		particle.rotation = _rng.randf_range(-PI, PI)
	layer.add_child(particle)

	var tween: Tween = particle.create_tween()
	tween.set_parallel(true)
	tween.tween_property(particle, "position", particle.position + velocity * lifetime, lifetime)
	tween.tween_property(particle, "modulate:a", 0.0, lifetime)
	tween.tween_property(particle, "scale", Vector2.ONE * (1.75 if sparkle else 1.10), lifetime)
	tween.tween_callback(particle.queue_free).set_delay(lifetime)


func _current_character_size() -> Vector2:
	return DEFAULT_HOLOGIRL_SIZE * _character_scale


func _apply_character_tuning() -> void:
	if _character == null:
		return

	_character.position = _character_pos
	_character.size = _current_character_size()
	_update_tuning_values_label()


func _build_tuning_panel() -> PanelContainer:
	var panel: PanelContainer = PanelContainer.new()
	panel.name = "HologirlTuningPanel"
	panel.custom_minimum_size = Vector2(500.0, 390.0)
	panel.mouse_filter = Control.MOUSE_FILTER_STOP
	panel.process_mode = Node.PROCESS_MODE_ALWAYS
	panel.z_index = 1000

	var margin: MarginContainer = MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 12)
	margin.add_theme_constant_override("margin_top", 10)
	margin.add_theme_constant_override("margin_right", 12)
	margin.add_theme_constant_override("margin_bottom", 10)
	panel.add_child(margin)

	var layout: VBoxContainer = VBoxContainer.new()
	layout.mouse_filter = Control.MOUSE_FILTER_PASS
	margin.add_child(layout)

	var header: HBoxContainer = HBoxContainer.new()
	layout.add_child(header)

	var title: Label = Label.new()
	title.text = "Hologirl Character Select Tuner"
	title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_child(title)

	_collapse_button = Button.new()
	_collapse_button.name = "Collapse"
	_collapse_button.text = "Collapse"
	_collapse_button.pressed.connect(_toggle_tuning_panel_collapsed)
	header.add_child(_collapse_button)

	_tuning_body = VBoxContainer.new()
	_tuning_body.mouse_filter = Control.MOUSE_FILTER_PASS
	layout.add_child(_tuning_body)

	_tuning_values_label = Label.new()
	_tuning_values_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_tuning_body.add_child(_tuning_values_label)

	_tuning_body.add_child(_create_tuning_slider("X", "x", 0.0, 2200.0, _character_pos.x, 1.0))
	_tuning_body.add_child(_create_tuning_slider("Y", "y", -400.0, 900.0, _character_pos.y, 1.0))
	_tuning_body.add_child(_create_tuning_slider("Scale", "scale", 0.25, 2.50, _character_scale, 0.01))
	_tuning_body.add_child(_create_tuning_slider("Whip density", "whip_density", 0.0, 5.0, _whip_density, 0.01))
	_tuning_body.add_child(_create_tuning_slider("Drift density", "drift_density", 0.0, 5.0, _drift_density, 0.01))
	_tuning_body.add_child(_create_tuning_slider("Gold jitter", "whip_jitter", 0.0, 80.0, _whip_jitter, 0.5))
	_tuning_body.add_child(_create_background_selector())

	var button_row: HBoxContainer = HBoxContainer.new()
	_tuning_body.add_child(button_row)

	var print_button: Button = Button.new()
	print_button.text = "Print / Copy Values"
	print_button.pressed.connect(_print_tuning_values)
	button_row.add_child(print_button)

	var reset_button: Button = Button.new()
	reset_button.text = "Reset"
	reset_button.pressed.connect(_reset_tuning_values)
	button_row.add_child(reset_button)

	_update_tuning_values_label()
	_apply_tuning_panel_layout()
	return panel


func _apply_tuning_panel_layout() -> void:
	if _tuning_panel == null:
		return

	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	if viewport_size.x <= 0.0 or viewport_size.y <= 0.0:
		viewport_size = get_viewport_rect().size

	var root_transform: Transform2D = get_global_transform_with_canvas()
	var root_scale: Vector2 = root_transform.get_scale()
	if absf(root_scale.x) < 0.001:
		root_scale.x = 1.0
	if absf(root_scale.y) < 0.001:
		root_scale.y = 1.0

	var panel_screen_size: Vector2 = Vector2(
		min(500.0, max(320.0, viewport_size.x - TUNING_PANEL_MARGIN.x * 2.0)),
		min(_current_tuning_panel_height(), max(56.0, viewport_size.y - TUNING_PANEL_MARGIN.y * 2.0))
	)
	_tuning_panel.position = root_transform.affine_inverse() * TUNING_PANEL_MARGIN
	_tuning_panel.scale = Vector2(1.0 / absf(root_scale.x), 1.0 / absf(root_scale.y))
	_tuning_panel.size = panel_screen_size


func _create_tuning_slider(label_text: String, key: String, min_value: float, max_value: float, value: float, step: float) -> HBoxContainer:
	var row: HBoxContainer = HBoxContainer.new()
	row.custom_minimum_size = Vector2(0.0, 34.0)

	var name_label: Label = Label.new()
	name_label.text = label_text
	name_label.custom_minimum_size = Vector2(120.0, 0.0)
	row.add_child(name_label)

	var slider: HSlider = HSlider.new()
	slider.min_value = min_value
	slider.max_value = max_value
	slider.step = step
	slider.value = value
	slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	slider.mouse_filter = Control.MOUSE_FILTER_STOP
	row.add_child(slider)
	_tuning_sliders[key] = slider

	var value_label: Label = Label.new()
	value_label.text = _format_tuning_number(value)
	value_label.custom_minimum_size = Vector2(58.0, 0.0)
	row.add_child(value_label)

	slider.value_changed.connect(_on_tuning_slider_changed.bind(key, value_label))
	return row


func _on_tuning_slider_changed(value: float, key: String, value_label: Label) -> void:
	match key:
		"x":
			_character_pos.x = value
		"y":
			_character_pos.y = value
		"scale":
			_character_scale = value
		"whip_density":
			_whip_density = value
		"drift_density":
			_drift_density = value
		"whip_jitter":
			_whip_jitter = value

	value_label.text = _format_tuning_number(value)
	_apply_character_tuning()
	_save_tuning_values()


func _create_background_selector() -> HBoxContainer:
	var row: HBoxContainer = HBoxContainer.new()
	row.custom_minimum_size = Vector2(0.0, 34.0)

	var name_label: Label = Label.new()
	name_label.text = "Background"
	name_label.custom_minimum_size = Vector2(120.0, 0.0)
	row.add_child(name_label)

	_background_selector = OptionButton.new()
	_background_selector.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_background_selector.mouse_filter = Control.MOUSE_FILTER_STOP
	for i in BACKGROUND_VARIANT_NAMES.size():
		_background_selector.add_item(BACKGROUND_VARIANT_NAMES[i], i)
	_background_selector.select(clampi(_background_variant, 0, BACKGROUND_VARIANT_NAMES.size() - 1))
	_background_selector.item_selected.connect(_on_background_variant_selected)
	row.add_child(_background_selector)
	return row


func _on_background_variant_selected(index: int) -> void:
	_background_variant = clampi(index, 0, BACKGROUND_VARIANT_NAMES.size() - 1)
	_apply_background_variant()
	_update_tuning_values_label()
	_save_tuning_values()


func _apply_background_variant() -> void:
	if _background == null:
		return

	var index: int = clampi(_background_variant, 0, BACKGROUND_VARIANT_PATHS.size() - 1)
	_background.texture = load(BACKGROUND_VARIANT_PATHS[index])


func _toggle_tuning_panel_collapsed() -> void:
	if _tuning_body == null:
		return

	_tuning_body.visible = not _tuning_body.visible
	if _collapse_button != null:
		_collapse_button.text = "Collapse" if _tuning_body.visible else "Expand"
	_apply_tuning_panel_layout()


func _current_tuning_panel_height() -> float:
	return 390.0 if _tuning_body == null or _tuning_body.visible else 56.0


func _reset_tuning_values() -> void:
	_character_pos = DEFAULT_HOLOGIRL_POS
	_character_scale = DEFAULT_HOLOGIRL_SCALE
	_whip_density = DEFAULT_WHIP_DENSITY
	_drift_density = DEFAULT_DRIFT_DENSITY
	_whip_jitter = DEFAULT_WHIP_JITTER
	_background_variant = 0
	_set_slider_value("x", _character_pos.x)
	_set_slider_value("y", _character_pos.y)
	_set_slider_value("scale", _character_scale)
	_set_slider_value("whip_density", _whip_density)
	_set_slider_value("drift_density", _drift_density)
	_set_slider_value("whip_jitter", _whip_jitter)
	if _background_selector != null:
		_background_selector.select(_background_variant)
	if _background != null:
		_apply_background_variant()
	_apply_character_tuning()
	_save_tuning_values()


func _restore_saved_tuning_values() -> void:
	_character_pos = _saved_character_pos
	_character_scale = _saved_character_scale
	_whip_density = _saved_whip_density
	_drift_density = _saved_drift_density
	_whip_jitter = _saved_whip_jitter
	_background_variant = clampi(_saved_background_variant, 0, BACKGROUND_VARIANT_NAMES.size() - 1)


func _save_tuning_values() -> void:
	_saved_character_pos = _character_pos
	_saved_character_scale = _character_scale
	_saved_whip_density = _whip_density
	_saved_drift_density = _drift_density
	_saved_whip_jitter = _whip_jitter
	_saved_background_variant = _background_variant


func _set_slider_value(key: String, value: float) -> void:
	if _tuning_sliders.has(key):
		_tuning_sliders[key].value = value


func _print_tuning_values() -> void:
	var values: String = _tuning_values_text()
	DisplayServer.clipboard_set(values)
	print(values)


func _update_tuning_values_label() -> void:
	if _tuning_values_label != null:
		_tuning_values_label.text = _tuning_values_text()


func _tuning_values_text() -> String:
	return "x=%s y=%s scale=%s whip_density=%s drift_density=%s gold_jitter=%s background=%s" % [
		_format_tuning_number(_character_pos.x),
		_format_tuning_number(_character_pos.y),
		_format_tuning_number(_character_scale),
		_format_tuning_number(_whip_density),
		_format_tuning_number(_drift_density),
		_format_tuning_number(_whip_jitter),
		BACKGROUND_VARIANT_NAMES[clampi(_background_variant, 0, BACKGROUND_VARIANT_NAMES.size() - 1)],
	]


func _format_tuning_number(value: float) -> String:
	return str(snappedf(value, 0.01))


class HologirlParticle:
	extends Control

	var particle_color: Color = Color.WHITE
	var sparkle: bool = false

	func _draw() -> void:
		var center: Vector2 = size * 0.5
		if sparkle:
			draw_colored_polygon(
				[
					Vector2(center.x, 0.0),
					Vector2(size.x, center.y),
					Vector2(center.x, size.y),
					Vector2(0.0, center.y),
				],
				particle_color
			)
			draw_line(Vector2(center.x, -size.y * 0.35), Vector2(center.x, size.y * 1.35), Color(particle_color.r, particle_color.g, particle_color.b, particle_color.a * 0.55), 2.0)
			draw_line(Vector2(-size.x * 0.35, center.y), Vector2(size.x * 1.35, center.y), Color(particle_color.r, particle_color.g, particle_color.b, particle_color.a * 0.55), 2.0)
		else:
			draw_rect(Rect2(Vector2.ZERO, size), particle_color)
