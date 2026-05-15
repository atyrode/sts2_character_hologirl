extends Control

const VIRTUAL_SIZE: Vector2 = Vector2(2564.0, 1204.0)
const HOLOGIRL_POS: Vector2 = Vector2(1145.0, 305.0)
const HOLOGIRL_SIZE: Vector2 = Vector2(1180.0, 787.0)
const HOLOGIRL_TEXTURE: String = "res://Hologirl/images/charui/character_select_hologirl.png"

var _canvas: Control
var _back_particle_layer: Control
var _front_particle_layer: Control
var _rng: RandomNumberGenerator = RandomNumberGenerator.new()
var _whip_emitters: Array[Vector2] = []
var _body_emitters: Array[Vector2] = []
var _spark_timer: float = 0.0
var _drift_timer: float = 0.0
var _glow_timer: float = 0.0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	clip_contents = true
	set_process(true)
	_rng.randomize()
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
	_spark_timer -= delta
	_drift_timer -= delta
	_glow_timer -= delta

	while _spark_timer <= 0.0:
		_spawn_whip_spark(false)
		_spark_timer += _rng.randf_range(0.035, 0.070)

	while _drift_timer <= 0.0:
		_spawn_hologram_drift(false)
		_drift_timer += _rng.randf_range(0.11, 0.18)

	while _glow_timer <= 0.0:
		_spawn_background_glow(false)
		_glow_timer += _rng.randf_range(0.22, 0.38)


func _build_scene() -> void:
	_canvas = Control.new()
	_canvas.name = "VirtualCanvas"
	_canvas.size = VIRTUAL_SIZE
	_canvas.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_canvas.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(_canvas)

	var background: HologirlSimpleBackground = HologirlSimpleBackground.new()
	background.name = "SimpleBackground"
	background.size = VIRTUAL_SIZE
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_canvas.add_child(background)

	_back_particle_layer = _create_particle_layer("HologirlBackParticles")
	_canvas.add_child(_back_particle_layer)

	var character_texture: Texture2D = load(HOLOGIRL_TEXTURE)
	_build_emitters(character_texture)

	var character: TextureRect = TextureRect.new()
	character.name = "HologirlLayer"
	character.texture = character_texture
	character.position = HOLOGIRL_POS
	character.size = HOLOGIRL_SIZE
	character.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	character.stretch_mode = TextureRect.STRETCH_SCALE
	character.mouse_filter = Control.MOUSE_FILTER_IGNORE
	character.material = _create_chroma_key_material()
	_canvas.add_child(character)

	_front_particle_layer = _create_particle_layer("HologirlFrontParticles")
	_canvas.add_child(_front_particle_layer)


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
	for i in 26:
		_spawn_whip_spark(true)

	for i in 18:
		_spawn_hologram_drift(true)

	for i in 8:
		_spawn_background_glow(true)


func _spawn_whip_spark(burst: bool) -> void:
	var anchor: Vector2 = _sample_character_point(_whip_emitters)
	var jitter: Vector2 = Vector2(_rng.randf_range(-8.0, 8.0), _rng.randf_range(-8.0, 8.0))
	var lifetime: float = _rng.randf_range(0.55, 1.0 if burst else 0.78)
	var particle_size: Vector2 = Vector2(_rng.randf_range(9.0, 17.0), _rng.randf_range(9.0, 17.0))
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
	return HOLOGIRL_POS + normalized * HOLOGIRL_SIZE


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


class HologirlSimpleBackground:
	extends Control

	func _draw() -> void:
		var s: Vector2 = size
		draw_rect(Rect2(Vector2.ZERO, s), Color(0.20, 0.19, 0.30))
		draw_rect(Rect2(0.0, s.y * 0.56, s.x, s.y * 0.44), Color(0.13, 0.14, 0.22))
		draw_colored_polygon(
			[
				Vector2(s.x * 0.46, 0.0),
				Vector2(s.x, 0.0),
				Vector2(s.x, s.y),
				Vector2(s.x * 0.66, s.y),
			],
			Color(0.24, 0.28, 0.38)
		)
		draw_colored_polygon(
			[
				Vector2(s.x * 0.05, s.y),
				Vector2(s.x * 0.36, s.y * 0.16),
				Vector2(s.x * 0.54, s.y * 0.22),
				Vector2(s.x * 0.30, s.y),
			],
			Color(0.16, 0.13, 0.24, 0.72)
		)
		draw_line(Vector2(s.x * 0.10, s.y * 0.72), Vector2(s.x * 0.95, s.y * 0.40), Color(0.86, 0.63, 0.21, 0.16), 10.0)
		draw_line(Vector2(s.x * 0.12, s.y * 0.78), Vector2(s.x * 0.90, s.y * 0.49), Color(0.33, 0.86, 1.0, 0.18), 7.0)
		draw_line(Vector2(s.x * 0.18, s.y * 0.25), Vector2(s.x * 0.84, s.y * 0.15), Color(0.60, 0.37, 0.58, 0.20), 8.0)


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
