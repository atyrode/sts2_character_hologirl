extends Control

const VIRTUAL_SIZE: Vector2 = Vector2(2564.0, 1204.0)
const HOLOGIRL_POS: Vector2 = Vector2(1220.0, 348.0)
const HOLOGIRL_SIZE: Vector2 = Vector2(1180.0, 787.0)
const HOLOGIRL_TEXTURE: String = "res://Hologirl/images/charui/character_select_hologirl.png"

var _canvas: Control
var _particle_layer: Control
var _rng: RandomNumberGenerator = RandomNumberGenerator.new()
var _spark_timer: float = 0.0
var _drift_timer: float = 0.0

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	clip_contents = true
	_rng.randomize()
	_build_scene()
	_apply_layout()
	_spawn_selection_burst()


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		_apply_layout()


func _process(delta: float) -> void:
	_spark_timer -= delta
	_drift_timer -= delta

	while _spark_timer <= 0.0:
		_spawn_whip_spark(false)
		_spark_timer += 0.045

	while _drift_timer <= 0.0:
		_spawn_hologram_drift(false)
		_drift_timer += 0.13


func _build_scene() -> void:
	_canvas = Control.new()
	_canvas.name = "VirtualCanvas"
	_canvas.size = VIRTUAL_SIZE
	_canvas.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_canvas)

	var background: HologirlSimpleBackground = HologirlSimpleBackground.new()
	background.name = "SimpleBackground"
	background.size = VIRTUAL_SIZE
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_canvas.add_child(background)

	var character: TextureRect = TextureRect.new()
	character.name = "HologirlLayer"
	character.texture = load(HOLOGIRL_TEXTURE)
	character.position = HOLOGIRL_POS
	character.size = HOLOGIRL_SIZE
	character.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	character.stretch_mode = TextureRect.STRETCH_SCALE
	character.mouse_filter = Control.MOUSE_FILTER_IGNORE
	character.material = _create_chroma_key_material()
	_canvas.add_child(character)

	_particle_layer = Control.new()
	_particle_layer.name = "HologirlParticles"
	_particle_layer.size = VIRTUAL_SIZE
	_particle_layer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_canvas.add_child(_particle_layer)


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


func _spawn_whip_spark(burst: bool) -> void:
	var points: Array[Vector2] = [
		Vector2(0.50, 0.50),
		Vector2(0.58, 0.41),
		Vector2(0.66, 0.32),
		Vector2(0.76, 0.28),
		Vector2(0.84, 0.33),
		Vector2(0.86, 0.46),
		Vector2(0.78, 0.61),
		Vector2(0.67, 0.72),
	]

	var anchor: Vector2 = HOLOGIRL_POS + points[_rng.randi_range(0, points.size() - 1)] * HOLOGIRL_SIZE
	var jitter: Vector2 = Vector2(_rng.randf_range(-20.0, 20.0), _rng.randf_range(-18.0, 18.0))
	var lifetime: float = _rng.randf_range(0.75, 1.25 if burst else 0.95)
	var particle_size: Vector2 = Vector2(_rng.randf_range(10.0, 22.0), _rng.randf_range(10.0, 22.0))
	var velocity: Vector2 = Vector2(_rng.randf_range(-22.0, 36.0), _rng.randf_range(-42.0, -10.0))
	var color: Color = Color(1.0, 0.75, 0.13, _rng.randf_range(0.70, 1.0))
	_spawn_particle(anchor + jitter, velocity, particle_size, lifetime, color, true)


func _spawn_hologram_drift(burst: bool) -> void:
	var position: Vector2 = HOLOGIRL_POS + Vector2(
		_rng.randf_range(0.08, 0.92) * HOLOGIRL_SIZE.x,
		_rng.randf_range(0.08, 0.86) * HOLOGIRL_SIZE.y
	)
	var particle_size: Vector2 = Vector2(_rng.randf_range(46.0, 120.0), _rng.randf_range(5.0, 12.0))
	var velocity: Vector2 = Vector2(_rng.randf_range(-56.0, 48.0), _rng.randf_range(-10.0, 10.0))
	var lifetime: float = _rng.randf_range(0.65, 1.20 if burst else 0.90)
	var color: Color = Color(0.20, 0.86, 1.0, _rng.randf_range(0.24, 0.50))
	_spawn_particle(position, velocity, particle_size, lifetime, color, false)


func _spawn_particle(position: Vector2, velocity: Vector2, particle_size: Vector2, lifetime: float, color: Color, sparkle: bool) -> void:
	var particle: ColorRect = ColorRect.new()
	particle.color = color
	particle.size = particle_size
	particle.position = position - particle_size * 0.5
	particle.pivot_offset = particle_size * 0.5
	particle.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if sparkle:
		particle.rotation = _rng.randf_range(-PI, PI)
	_particle_layer.add_child(particle)

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
		draw_rect(Rect2(Vector2.ZERO, s), Color(0.29, 0.18, 0.31))
		draw_rect(Rect2(0.0, s.y * 0.55, s.x, s.y * 0.45), Color(0.19, 0.13, 0.23))
		draw_colored_polygon(
			[
				Vector2(s.x * 0.44, 0.0),
				Vector2(s.x, 0.0),
				Vector2(s.x, s.y),
				Vector2(s.x * 0.62, s.y),
			],
			Color(0.36, 0.20, 0.34)
		)
		draw_colored_polygon(
			[
				Vector2(s.x * 0.05, s.y),
				Vector2(s.x * 0.38, s.y * 0.18),
				Vector2(s.x * 0.52, s.y * 0.24),
				Vector2(s.x * 0.28, s.y),
			],
			Color(0.21, 0.15, 0.27, 0.65)
		)
		draw_line(Vector2(s.x * 0.08, s.y * 0.72), Vector2(s.x * 0.95, s.y * 0.42), Color(0.86, 0.63, 0.21, 0.18), 10.0)
		draw_line(Vector2(s.x * 0.12, s.y * 0.78), Vector2(s.x * 0.90, s.y * 0.50), Color(0.33, 0.86, 1.0, 0.14), 7.0)
