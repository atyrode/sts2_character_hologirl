extends Node2D

@export var visual_path: NodePath = ^"Visuals"
@export var bob_pixels: float = 4.0
@export var bob_seconds: float = 2.4
@export var breathe_scale: float = 0.012

var _visual: Node2D
var _base_position: Vector2
var _base_scale: Vector2
var _time := 0.0


func _ready() -> void:
	_visual = get_node_or_null(visual_path) as Node2D
	if _visual == null:
		set_process(false)
		return

	_base_position = _visual.position
	_base_scale = _visual.scale


func _process(delta: float) -> void:
	if _visual == null:
		return

	_time += delta
	var phase: float = TAU * _time / max(0.1, bob_seconds)
	var lift: float = sin(phase) * bob_pixels
	var breathe: float = 1.0 + sin(phase + 0.7) * breathe_scale
	_visual.position = _base_position + Vector2(0.0, lift)
	_visual.scale = Vector2(_base_scale.x * breathe, _base_scale.y * (1.0 + (breathe - 1.0) * 0.45))
