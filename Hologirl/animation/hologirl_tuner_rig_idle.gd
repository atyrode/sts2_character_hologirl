extends Node2D

@export var cycle_seconds: float = 2.7
@export var torso_degrees: float = 1.0
@export var head_degrees: float = 1.5
@export var hair_degrees: float = 2.4
@export var arm_degrees: float = 1.8
@export var hand_degrees: float = 2.2
@export var vertical_pixels: float = 4.0

var _time := 0.0
var _base := {}


func _ready() -> void:
	for child in get_children():
		if child is Node2D:
			_base[child.name] = {
				"position": child.position,
				"rotation": child.rotation,
				"scale": child.scale,
			}


func _process(delta: float) -> void:
	_time += delta
	var phase: float = TAU * _time / max(0.1, cycle_seconds)
	var breathe: float = sin(phase)
	var drift: float = sin(phase + 0.55)
	var lag: float = sin(phase - 0.7)

	_apply("rig_10_torso_upper", breathe, torso_degrees, Vector2(0.0, -vertical_pixels * 0.35))
	_apply("rig_11_head", drift, head_degrees, Vector2(0.0, -vertical_pixels * 0.25))
	_apply("rig_02_hair_ponytail_far", lag, -hair_degrees, Vector2(-1.0, vertical_pixels * 0.4))
	_apply("rig_08_hair_ponytail_near", lag, -hair_degrees * 1.15, Vector2(-1.2, vertical_pixels * 0.45))
	_apply("rig_06_upper_arm_far", drift, -arm_degrees * 0.55, Vector2(0.8, vertical_pixels * 0.15))
	_apply("rig_07_forearm_far", breathe, arm_degrees, Vector2(1.0, vertical_pixels * 0.3))
	_apply("rig_12_hand_far", breathe, hand_degrees, Vector2(1.4, vertical_pixels * 0.35))
	_apply("rig_13_upper_arm_near", drift, arm_degrees * 0.7, Vector2(-0.8, vertical_pixels * 0.18))
	_apply("rig_14_hand_near", breathe, -hand_degrees, Vector2(-1.1, vertical_pixels * 0.3))
	_apply("rig_09_skirt_front_center", breathe, 0.45, Vector2(0.0, vertical_pixels * 0.18))
	_apply("rig_03_lower_leg_near", breathe, 0.35, Vector2(0.0, vertical_pixels * 0.08))
	_apply("rig_05_lower_leg_far", -breathe, 0.3, Vector2(0.0, vertical_pixels * 0.08))


func _apply(node_name: StringName, amount: float, degrees: float, offset: Vector2) -> void:
	var node := get_node_or_null(NodePath(node_name)) as Node2D
	if node == null or not _base.has(node_name):
		return

	var base_data: Dictionary = _base[node_name]
	node.rotation = base_data["rotation"] + deg_to_rad(degrees) * amount
	node.position = base_data["position"] + offset * amount
