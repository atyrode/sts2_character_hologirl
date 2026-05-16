extends Control

const VIRTUAL_SIZE: Vector2 = Vector2(2564.0, 1204.0)
const DEFAULT_HOLOGIRL_POS: Vector2 = Vector2(937.0, 139.0)
const DEFAULT_HOLOGIRL_SIZE: Vector2 = Vector2(1180.0, 787.0)
const TUNING_PANEL_START_VISIBLE: bool = false
const TUNING_PANEL_MARGIN: Vector2 = Vector2(24.0, 24.0)
const DEFAULT_HOLOGIRL_SCALE: float = 1.33
const DEFAULT_WHIP_DENSITY: float = 1.53
const DEFAULT_DRIFT_DENSITY: float = 6.05
const DEFAULT_WHIP_JITTER: float = 80.0
const DEFAULT_HOLOGRAM_TINT: float = 0.62
const DEFAULT_TEAR_STRENGTH: float = 0.0
const DEFAULT_TEAR_FREQUENCY: float = 0.7
const DEFAULT_SHIMMER_STRENGTH: float = 0.72
const DEFAULT_SCANLINE_STRENGTH: float = 0.25
const DEFAULT_SCANLINE_SPEED: float = 1.08
const DEFAULT_SCANLINE_SPACING: float = 87.0
const DEFAULT_BODY_OPACITY: float = 0.83
const SELECT_SOUND_PATH: String = "res://Hologirl/audio/char_select/hologram.mp3"
const BACKGROUND_VARIANT_NAMES: Array[String] = [
	"Signal Bloom",
	"Stage Glow",
	"Holo Drift",
	"Ruby Broadcast",
	"Ember Signal",
	"Solar Idol",
	"Mint Stage",
	"Emerald Pulse",
	"Lagoon Signal",
	"Periwinkle Drift",
	"Violet Broadcast",
	"Fuchsia Stage",
]
const BACKGROUND_VARIANT_PATHS: Array[String] = [
	"res://Hologirl/images/charui/background_variants/bg_01_signal_bloom.png",
	"res://Hologirl/images/charui/background_variants/bg_02_stage_glow.png",
	"res://Hologirl/images/charui/background_variants/bg_03_holo_drift.png",
	"res://Hologirl/images/charui/background_variants/bg_04_ruby_broadcast.png",
	"res://Hologirl/images/charui/background_variants/bg_05_ember_signal.png",
	"res://Hologirl/images/charui/background_variants/bg_06_solar_idol.png",
	"res://Hologirl/images/charui/background_variants/bg_07_mint_stage.png",
	"res://Hologirl/images/charui/background_variants/bg_08_emerald_pulse.png",
	"res://Hologirl/images/charui/background_variants/bg_09_lagoon_signal.png",
	"res://Hologirl/images/charui/background_variants/bg_10_periwinkle_drift.png",
	"res://Hologirl/images/charui/background_variants/bg_11_violet_broadcast.png",
	"res://Hologirl/images/charui/background_variants/bg_12_fuchsia_stage.png",
]
const CHARACTER_VARIANT_NAMES: Array[String] = [
	"Current",
	"Vanilla Matte",
	"Chunky Vanilla",
	"Soft Vanilla",
	"White Gold Blue",
	"White Gold Pink",
	"White Gold Navy",
	"White Gold Rose",
	"White Gold Deep Blue",
	"Thin Outline Ready",
	"Thin Outline Compact",
	"Thin Outline Spire",
	"Thin Outline Calm",
	"Thin Outline Angular",
	"Humanoid Hologram A",
	"Humanoid Hologram B",
	"Humanoid Hologram C",
	"Humanoid Hologram D",
	"Humanoid Hologram E",
	"Linework No Ref 01",
	"Linework No Ref 02",
	"Linework No Ref 03",
	"Linework No Ref 04",
	"Linework No Ref 05",
	"Linework No Ref 06",
	"Linework No Ref 07",
	"Linework No Ref 08",
	"Linework No Ref 09",
	"Linework No Ref 10",
]
const CHARACTER_VARIANT_PATHS: Array[String] = [
	"res://Hologirl/images/charui/character_variants/character_01_current.png",
	"res://Hologirl/images/charui/character_variants/character_02_vanilla_matte.png",
	"res://Hologirl/images/charui/character_variants/character_03_chunky_vanilla.png",
	"res://Hologirl/images/charui/character_variants/character_04_soft_vanilla.png",
	"res://Hologirl/images/charui/character_variants/character_05_white_gold_blue.png",
	"res://Hologirl/images/charui/character_variants/character_06_white_gold_pink.png",
	"res://Hologirl/images/charui/character_variants/character_07_white_gold_navy.png",
	"res://Hologirl/images/charui/character_variants/character_08_white_gold_rose.png",
	"res://Hologirl/images/charui/character_variants/character_09_white_gold_deep_blue.png",
	"res://Hologirl/images/charui/character_variants/character_10_thin_outline_ready.png",
	"res://Hologirl/images/charui/character_variants/character_11_thin_outline_compact.png",
	"res://Hologirl/images/charui/character_variants/character_12_thin_outline_spire.png",
	"res://Hologirl/images/charui/character_variants/character_13_thin_outline_calm.png",
	"res://Hologirl/images/charui/character_variants/character_14_thin_outline_angular.png",
	"res://Hologirl/images/charui/character_variants/character_15_humanoid_hologram_a.png",
	"res://Hologirl/images/charui/character_variants/character_16_humanoid_hologram_b.png",
	"res://Hologirl/images/charui/character_variants/character_17_humanoid_hologram_c.png",
	"res://Hologirl/images/charui/character_variants/character_18_humanoid_hologram_d.png",
	"res://Hologirl/images/charui/character_variants/character_19_humanoid_hologram_e.png",
	"res://Hologirl/images/charui/character_variants/character_20_linework_no_ref_01.png",
	"res://Hologirl/images/charui/character_variants/character_21_linework_no_ref_02.png",
	"res://Hologirl/images/charui/character_variants/character_22_linework_no_ref_03.png",
	"res://Hologirl/images/charui/character_variants/character_23_linework_no_ref_04.png",
	"res://Hologirl/images/charui/character_variants/character_24_linework_no_ref_05.png",
	"res://Hologirl/images/charui/character_variants/character_25_linework_no_ref_06.png",
	"res://Hologirl/images/charui/character_variants/character_26_linework_no_ref_07.png",
	"res://Hologirl/images/charui/character_variants/character_27_linework_no_ref_08.png",
	"res://Hologirl/images/charui/character_variants/character_28_linework_no_ref_09.png",
	"res://Hologirl/images/charui/character_variants/character_29_linework_no_ref_10.png",
]
const CHARACTER_HOLOGRAM_TINTS: Array[float] = [
	0.0,
	0.0,
	0.0,
	0.0,
	0.18,
	0.16,
	0.16,
	0.15,
	0.18,
	0.18,
	0.18,
	0.18,
	0.18,
	0.18,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
]
const CHARACTER_TEAR_STRENGTHS: Array[float] = [
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
]
const CHARACTER_TEAR_FREQUENCIES: Array[float] = [
	24.0,
	24.0,
	24.0,
	24.0,
	24.0,
	24.0,
	24.0,
	24.0,
	24.0,
	24.0,
	24.0,
	24.0,
	24.0,
	24.0,
	4.0,
	4.0,
	4.0,
	4.0,
	4.0,
	4.0,
	4.0,
	4.0,
	4.0,
	4.0,
	4.0,
	4.0,
	4.0,
	4.0,
	4.0,
]
const CHARACTER_SHIMMER_STRENGTHS: Array[float] = [
	0.0,
	0.0,
	0.0,
	0.0,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
	0.04,
]
const CHARACTER_SCANLINE_STRENGTHS: Array[float] = [
	0.0,
	0.0,
	0.0,
	0.0,
	0.09,
	0.09,
	0.09,
	0.09,
	0.09,
	0.09,
	0.09,
	0.09,
	0.09,
	0.09,
	0.34,
	0.34,
	0.34,
	0.34,
	0.34,
	0.34,
	0.34,
	0.34,
	0.34,
	0.34,
	0.34,
	0.34,
	0.34,
	0.34,
	0.34,
]

static var _saved_character_pos: Vector2 = DEFAULT_HOLOGIRL_POS
static var _saved_character_scale: float = DEFAULT_HOLOGIRL_SCALE
static var _saved_whip_density: float = DEFAULT_WHIP_DENSITY
static var _saved_drift_density: float = DEFAULT_DRIFT_DENSITY
static var _saved_whip_jitter: float = DEFAULT_WHIP_JITTER
static var _saved_hologram_tint: float = DEFAULT_HOLOGRAM_TINT
static var _saved_tear_strength: float = DEFAULT_TEAR_STRENGTH
static var _saved_tear_frequency: float = DEFAULT_TEAR_FREQUENCY
static var _saved_shimmer_strength: float = DEFAULT_SHIMMER_STRENGTH
static var _saved_scanline_strength: float = DEFAULT_SCANLINE_STRENGTH
static var _saved_scanline_speed: float = DEFAULT_SCANLINE_SPEED
static var _saved_scanline_spacing: float = DEFAULT_SCANLINE_SPACING
static var _saved_body_opacity: float = DEFAULT_BODY_OPACITY
static var _saved_background_variant: int = 9
static var _saved_character_variant: int = 20
static var _saved_tuning_panel_visible: bool = TUNING_PANEL_START_VISIBLE

var _canvas: Control
var _background: TextureRect
var _character: TextureRect
var _back_particle_layer: Control
var _front_particle_layer: Control
var _tuning_panel: PanelContainer
var _tuning_body: VBoxContainer
var _collapse_button: Button
var _background_selector: OptionButton
var _character_selector: OptionButton
var _tuning_sliders: Dictionary = {}
var _tuning_panel_visible: bool = TUNING_PANEL_START_VISIBLE
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
var _hologram_tint: float = DEFAULT_HOLOGRAM_TINT
var _tear_strength: float = DEFAULT_TEAR_STRENGTH
var _tear_frequency: float = DEFAULT_TEAR_FREQUENCY
var _shimmer_strength: float = DEFAULT_SHIMMER_STRENGTH
var _scanline_strength: float = DEFAULT_SCANLINE_STRENGTH
var _scanline_speed: float = DEFAULT_SCANLINE_SPEED
var _scanline_spacing: float = DEFAULT_SCANLINE_SPACING
var _body_opacity: float = DEFAULT_BODY_OPACITY
var _background_variant: int = 9
var _character_variant: int = 20

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	clip_contents = not _tuning_panel_visible
	set_process(true)
	set_process_unhandled_input(true)
	_rng.randomize()
	_restore_saved_tuning_values()
	_build_scene()
	_apply_layout()
	_spawn_selection_burst()
	_play_select_sound()
	_spark_timer = 0.02
	_drift_timer = 0.05
	_glow_timer = 0.08


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		_apply_layout()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_F3:
		_toggle_tuning_panel_visible()
		get_viewport().set_input_as_handled()


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

	var character_texture: Texture2D = _load_character_texture()
	_build_emitters(character_texture)

	_character = TextureRect.new()
	_character.name = "HologirlLayer"
	_character.texture = character_texture
	_character.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_character.stretch_mode = TextureRect.STRETCH_SCALE
	_character.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_character.material = _create_chroma_key_material()
	_canvas.add_child(_character)
	_apply_character_effect_profile()

	_apply_character_tuning()

	_front_particle_layer = _create_particle_layer("HologirlFrontParticles")
	_canvas.add_child(_front_particle_layer)

	_tuning_panel = _build_tuning_panel()
	_tuning_panel.visible = _tuning_panel_visible
	add_child(_tuning_panel)


func _create_particle_layer(layer_name: String) -> Control:
	var layer: Control = Control.new()
	layer.name = layer_name
	layer.size = VIRTUAL_SIZE
	layer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	layer.process_mode = Node.PROCESS_MODE_ALWAYS
	return layer


func _load_character_texture() -> Texture2D:
	var index: int = clampi(_character_variant, 0, CHARACTER_VARIANT_PATHS.size() - 1)
	return load(CHARACTER_VARIANT_PATHS[index])


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
uniform float hologram_tint = 0.0;
uniform float tear_strength = 0.0;
uniform float tear_frequency = 4.0;
uniform float shimmer_strength = 0.0;
uniform float scanline_strength = 0.0;
uniform float scanline_speed = 0.65;
uniform float scanline_spacing = 56.0;
uniform float body_opacity = 1.0;
uniform vec3 hologram_color = vec3(0.18, 0.82, 1.0);

void fragment() {
	vec2 uv = UV;
	float tear_cycle = max(tear_frequency, 0.25);
	float tear_phase = fract(TIME / tear_cycle);
	float tear_gate = 1.0 - smoothstep(0.045, 0.085, tear_phase);
	float tear_band = tear_gate * step(0.91, fract(sin(floor(UV.y * 24.0) + floor(TIME / tear_cycle) * 4.7) * 43758.5453));
	float tear_wave = sin(UV.y * 80.0 + TIME * 7.0);
	uv.x += tear_strength * tear_band * tear_wave;

	vec4 tex = texture(TEXTURE, uv);
	float keyed = smoothstep(threshold, threshold + softness, distance(tex.rgb, key_color.rgb));
	float shimmer = 1.0 + shimmer_strength * (0.035 * sin(TIME * 4.3 + UV.y * 70.0) + 0.018 * sin(TIME * 2.1 + UV.x * 38.0));
	tex.rgb *= shimmer;
	tex.rgb = mix(tex.rgb, tex.rgb * vec3(0.82, 0.95, 1.10) + hologram_color * 0.035, hologram_tint);
	float scanline_phase = fract(UV.y * scanline_spacing + TIME * scanline_speed);
	float scanline_band = smoothstep(0.02, 0.08, scanline_phase) * (1.0 - smoothstep(0.16, 0.30, scanline_phase));
	tex.rgb += hologram_color * scanline_band * scanline_strength * 0.22;
	tex.a *= 1.0 - scanline_band * scanline_strength * 0.18;
	float gold_preserve = step(0.62, tex.r) * step(0.36, tex.g) * step(tex.b, 0.36) * step(tex.b * 1.55, tex.r);
	tex.a *= mix(body_opacity, 1.0, gold_preserve);
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


func _play_select_sound() -> void:
	var stream := load(SELECT_SOUND_PATH)
	if not stream is AudioStream:
		return

	var player := AudioStreamPlayer.new()
	player.name = "HologirlSelectSound"
	player.stream = stream
	player.finished.connect(player.queue_free)
	add_child(player)
	player.play()


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
	_character.pivot_offset = _character.size * 0.5
	_update_tuning_values_label()


func _build_tuning_panel() -> PanelContainer:
	var panel: PanelContainer = PanelContainer.new()
	panel.name = "HologirlTuningPanel"
	panel.custom_minimum_size = Vector2(500.0, 430.0)
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

	_tuning_body.add_child(_create_tuning_slider("X", "x", -500.0, 2600.0, _character_pos.x, 1.0))
	_tuning_body.add_child(_create_tuning_slider("Y", "y", -700.0, 1200.0, _character_pos.y, 1.0))
	_tuning_body.add_child(_create_tuning_slider("Scale", "scale", 0.10, 3.50, _character_scale, 0.01))
	_tuning_body.add_child(_create_tuning_slider("Whip density", "whip_density", 0.0, 10.0, _whip_density, 0.01))
	_tuning_body.add_child(_create_tuning_slider("Drift density", "drift_density", 0.0, 10.0, _drift_density, 0.01))
	_tuning_body.add_child(_create_tuning_slider("Gold jitter", "whip_jitter", 0.0, 160.0, _whip_jitter, 0.5))
	_tuning_body.add_child(_create_tuning_slider("Holo tint", "hologram_tint", 0.0, 1.5, _hologram_tint, 0.01))
	_tuning_body.add_child(_create_tuning_slider("Tear", "tear_strength", 0.0, 0.030, _tear_strength, 0.0001))
	_tuning_body.add_child(_create_tuning_slider("Tear freq", "tear_frequency", 0.25, 5.0, _tear_frequency, 0.05))
	_tuning_body.add_child(_create_tuning_slider("Shimmer", "shimmer_strength", 0.0, 1.5, _shimmer_strength, 0.01))
	_tuning_body.add_child(_create_tuning_slider("Scanline", "scanline_strength", 0.0, 1.5, _scanline_strength, 0.01))
	_tuning_body.add_child(_create_tuning_slider("Scan speed", "scanline_speed", -5.0, 5.0, _scanline_speed, 0.01))
	_tuning_body.add_child(_create_tuning_slider("Scan spacing", "scanline_spacing", 4.0, 180.0, _scanline_spacing, 1.0))
	_tuning_body.add_child(_create_tuning_slider("Body opacity", "body_opacity", 0.25, 1.25, _body_opacity, 0.01))
	_tuning_body.add_child(_create_background_selector())
	_tuning_body.add_child(_create_character_selector())

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

	_apply_tuning_panel_layout()
	return panel


func _apply_tuning_panel_layout() -> void:
	if _tuning_panel == null:
		return
	if not _tuning_panel_visible:
		_tuning_panel.visible = false
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
	_tuning_panel.custom_minimum_size = panel_screen_size
	_tuning_panel.visible = true
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
		"hologram_tint":
			_hologram_tint = value
			_apply_character_effect_profile()
		"tear_strength":
			_tear_strength = value
			_apply_character_effect_profile()
		"tear_frequency":
			_tear_frequency = value
			_apply_character_effect_profile()
		"shimmer_strength":
			_shimmer_strength = value
			_apply_character_effect_profile()
		"scanline_strength":
			_scanline_strength = value
			_apply_character_effect_profile()
		"scanline_speed":
			_scanline_speed = value
			_apply_character_effect_profile()
		"scanline_spacing":
			_scanline_spacing = value
			_apply_character_effect_profile()
		"body_opacity":
			_body_opacity = value
			_apply_character_effect_profile()

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


func _create_character_selector() -> HBoxContainer:
	var row: HBoxContainer = HBoxContainer.new()
	row.custom_minimum_size = Vector2(0.0, 34.0)

	var name_label: Label = Label.new()
	name_label.text = "Character"
	name_label.custom_minimum_size = Vector2(120.0, 0.0)
	row.add_child(name_label)

	_character_selector = OptionButton.new()
	_character_selector.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_character_selector.mouse_filter = Control.MOUSE_FILTER_STOP
	for i in CHARACTER_VARIANT_NAMES.size():
		_character_selector.add_item(CHARACTER_VARIANT_NAMES[i], i)
	_character_selector.select(clampi(_character_variant, 0, CHARACTER_VARIANT_NAMES.size() - 1))
	_character_selector.item_selected.connect(_on_character_variant_selected)
	row.add_child(_character_selector)
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


func _on_character_variant_selected(index: int) -> void:
	_character_variant = clampi(index, 0, CHARACTER_VARIANT_NAMES.size() - 1)
	_apply_character_profile_defaults(_character_variant)
	_update_effect_sliders()
	_apply_character_variant()
	_update_tuning_values_label()
	_save_tuning_values()


func _apply_character_variant() -> void:
	if _character == null:
		return

	var character_texture: Texture2D = _load_character_texture()
	_character.texture = character_texture
	_apply_character_effect_profile()
	_build_emitters(character_texture)
	_clear_particle_layer(_back_particle_layer)
	_clear_particle_layer(_front_particle_layer)
	_apply_character_tuning()
	_spawn_selection_burst()


func _apply_character_effect_profile() -> void:
	if _character == null or _character.material == null:
		return

	var material := _character.material as ShaderMaterial
	if material == null:
		return

	material.set_shader_parameter("hologram_tint", _hologram_tint)
	material.set_shader_parameter("tear_strength", _tear_strength)
	material.set_shader_parameter("tear_frequency", _tear_frequency)
	material.set_shader_parameter("shimmer_strength", _shimmer_strength)
	material.set_shader_parameter("scanline_strength", _scanline_strength)
	material.set_shader_parameter("scanline_speed", _scanline_speed)
	material.set_shader_parameter("scanline_spacing", _scanline_spacing)
	material.set_shader_parameter("body_opacity", _body_opacity)


func _apply_character_profile_defaults(index: int) -> void:
	index = clampi(index, 0, CHARACTER_VARIANT_PATHS.size() - 1)
	_hologram_tint = CHARACTER_HOLOGRAM_TINTS[index]
	_tear_strength = CHARACTER_TEAR_STRENGTHS[index]
	_tear_frequency = CHARACTER_TEAR_FREQUENCIES[index]
	_shimmer_strength = CHARACTER_SHIMMER_STRENGTHS[index]
	_scanline_strength = CHARACTER_SCANLINE_STRENGTHS[index]
	_scanline_speed = DEFAULT_SCANLINE_SPEED if index >= 4 else 0.0
	_scanline_spacing = DEFAULT_SCANLINE_SPACING
	if CHARACTER_VARIANT_NAMES[index] == "Linework No Ref 02":
		_hologram_tint = DEFAULT_HOLOGRAM_TINT
		_tear_strength = DEFAULT_TEAR_STRENGTH
		_tear_frequency = DEFAULT_TEAR_FREQUENCY
		_shimmer_strength = DEFAULT_SHIMMER_STRENGTH
		_scanline_strength = DEFAULT_SCANLINE_STRENGTH
		_scanline_speed = DEFAULT_SCANLINE_SPEED
		_scanline_spacing = DEFAULT_SCANLINE_SPACING
		_body_opacity = DEFAULT_BODY_OPACITY


func _update_effect_sliders() -> void:
	_set_slider_value("hologram_tint", _hologram_tint)
	_set_slider_value("tear_strength", _tear_strength)
	_set_slider_value("tear_frequency", _tear_frequency)
	_set_slider_value("shimmer_strength", _shimmer_strength)
	_set_slider_value("scanline_strength", _scanline_strength)
	_set_slider_value("scanline_speed", _scanline_speed)
	_set_slider_value("scanline_spacing", _scanline_spacing)
	_set_slider_value("body_opacity", _body_opacity)


func _clear_particle_layer(layer: Control) -> void:
	if layer == null:
		return

	for child in layer.get_children():
		child.queue_free()


func _toggle_tuning_panel_visible() -> void:
	_tuning_panel_visible = not _tuning_panel_visible
	mouse_filter = Control.MOUSE_FILTER_PASS if _tuning_panel_visible else Control.MOUSE_FILTER_IGNORE
	clip_contents = not _tuning_panel_visible
	if _tuning_panel != null:
		_tuning_panel.visible = _tuning_panel_visible
	_apply_tuning_panel_layout()
	_save_tuning_values()


func _toggle_tuning_panel_collapsed() -> void:
	if _tuning_body == null:
		return

	_tuning_body.visible = not _tuning_body.visible
	if _collapse_button != null:
		_collapse_button.text = "Collapse" if _tuning_body.visible else "Expand"
	_apply_tuning_panel_layout()


func _current_tuning_panel_height() -> float:
	return 870.0 if _tuning_body == null or _tuning_body.visible else 56.0


func _reset_tuning_values() -> void:
	_character_pos = DEFAULT_HOLOGIRL_POS
	_character_scale = DEFAULT_HOLOGIRL_SCALE
	_whip_density = DEFAULT_WHIP_DENSITY
	_drift_density = DEFAULT_DRIFT_DENSITY
	_whip_jitter = DEFAULT_WHIP_JITTER
	_hologram_tint = DEFAULT_HOLOGRAM_TINT
	_tear_strength = DEFAULT_TEAR_STRENGTH
	_tear_frequency = DEFAULT_TEAR_FREQUENCY
	_shimmer_strength = DEFAULT_SHIMMER_STRENGTH
	_scanline_strength = DEFAULT_SCANLINE_STRENGTH
	_scanline_speed = DEFAULT_SCANLINE_SPEED
	_scanline_spacing = DEFAULT_SCANLINE_SPACING
	_body_opacity = DEFAULT_BODY_OPACITY
	_background_variant = 9
	_character_variant = 20
	_set_slider_value("x", _character_pos.x)
	_set_slider_value("y", _character_pos.y)
	_set_slider_value("scale", _character_scale)
	_set_slider_value("whip_density", _whip_density)
	_set_slider_value("drift_density", _drift_density)
	_set_slider_value("whip_jitter", _whip_jitter)
	_set_slider_value("hologram_tint", _hologram_tint)
	_set_slider_value("tear_strength", _tear_strength)
	_set_slider_value("tear_frequency", _tear_frequency)
	_set_slider_value("shimmer_strength", _shimmer_strength)
	_set_slider_value("scanline_strength", _scanline_strength)
	_set_slider_value("scanline_speed", _scanline_speed)
	_set_slider_value("scanline_spacing", _scanline_spacing)
	_set_slider_value("body_opacity", _body_opacity)
	if _background_selector != null:
		_background_selector.select(_background_variant)
	if _character_selector != null:
		_character_selector.select(_character_variant)
	if _background != null:
		_apply_background_variant()
	if _character != null:
		_apply_character_variant()
	_apply_character_tuning()
	_save_tuning_values()


func _restore_saved_tuning_values() -> void:
	_character_pos = _saved_character_pos
	_character_scale = _saved_character_scale
	_whip_density = _saved_whip_density
	_drift_density = _saved_drift_density
	_whip_jitter = _saved_whip_jitter
	_hologram_tint = _saved_hologram_tint
	_tear_strength = _saved_tear_strength
	_tear_frequency = _saved_tear_frequency
	_shimmer_strength = _saved_shimmer_strength
	_scanline_strength = _saved_scanline_strength
	_scanline_speed = _saved_scanline_speed
	_scanline_spacing = _saved_scanline_spacing
	_body_opacity = _saved_body_opacity
	_background_variant = clampi(_saved_background_variant, 0, BACKGROUND_VARIANT_NAMES.size() - 1)
	_character_variant = clampi(_saved_character_variant, 0, CHARACTER_VARIANT_NAMES.size() - 1)
	_tuning_panel_visible = _saved_tuning_panel_visible
	mouse_filter = Control.MOUSE_FILTER_PASS if _tuning_panel_visible else Control.MOUSE_FILTER_IGNORE
	clip_contents = not _tuning_panel_visible


func _save_tuning_values() -> void:
	_saved_character_pos = _character_pos
	_saved_character_scale = _character_scale
	_saved_whip_density = _whip_density
	_saved_drift_density = _drift_density
	_saved_whip_jitter = _whip_jitter
	_saved_hologram_tint = _hologram_tint
	_saved_tear_strength = _tear_strength
	_saved_tear_frequency = _tear_frequency
	_saved_shimmer_strength = _shimmer_strength
	_saved_scanline_strength = _scanline_strength
	_saved_scanline_speed = _scanline_speed
	_saved_scanline_spacing = _scanline_spacing
	_saved_body_opacity = _body_opacity
	_saved_background_variant = _background_variant
	_saved_character_variant = _character_variant
	_saved_tuning_panel_visible = _tuning_panel_visible


func _set_slider_value(key: String, value: float) -> void:
	if _tuning_sliders.has(key):
		_tuning_sliders[key].value = value


func _print_tuning_values() -> void:
	var values: String = _tuning_values_text()
	DisplayServer.clipboard_set(values)
	print(values)


func _update_tuning_values_label() -> void:
	pass


func _tuning_values_text() -> String:
	return "x=%s y=%s scale=%s whip_density=%s drift_density=%s gold_jitter=%s holo_tint=%s tear=%s tear_frequency=%s shimmer=%s scanline=%s scan_speed=%s scan_spacing=%s body_opacity=%s background=%s character=%s" % [
		_format_tuning_number(_character_pos.x),
		_format_tuning_number(_character_pos.y),
		_format_tuning_number(_character_scale),
		_format_tuning_number(_whip_density),
		_format_tuning_number(_drift_density),
		_format_tuning_number(_whip_jitter),
		_format_tuning_number(_hologram_tint),
		_format_tuning_number(_tear_strength),
		_format_tuning_number(_tear_frequency),
		_format_tuning_number(_shimmer_strength),
		_format_tuning_number(_scanline_strength),
		_format_tuning_number(_scanline_speed),
		_format_tuning_number(_scanline_spacing),
		_format_tuning_number(_body_opacity),
		BACKGROUND_VARIANT_NAMES[clampi(_background_variant, 0, BACKGROUND_VARIANT_NAMES.size() - 1)],
		CHARACTER_VARIANT_NAMES[clampi(_character_variant, 0, CHARACTER_VARIANT_NAMES.size() - 1)],
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
