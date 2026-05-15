@tool
extends Node2D

const LAYER_DIR := "res://docs/design/art_archive/menu/character_select_layers/layered_puppet_attempt-002/layers"

const PARTS := [
	{"file": "layer_08.png", "name": "Whip", "pos": Vector2(545, 155), "pivot": Vector2(40, 535), "z": -3, "amp": 0.018, "phase": 0.2},
	{"file": "layer_13.png", "name": "BackLegL", "pos": Vector2(405, 540), "pivot": Vector2(56, 20), "z": -2, "amp": 0.004, "phase": 0.8},
	{"file": "layer_14.png", "name": "BackLegR", "pos": Vector2(510, 540), "pivot": Vector2(62, 20), "z": -2, "amp": 0.004, "phase": 1.4},
	{"file": "layer_01.png", "name": "PonytailL", "pos": Vector2(240, 90), "pivot": Vector2(250, 72), "z": -1, "amp": 0.025, "phase": 0.0},
	{"file": "layer_02.png", "name": "PonytailR", "pos": Vector2(690, 96), "pivot": Vector2(20, 70), "z": -1, "amp": 0.025, "phase": 1.1},
	{"file": "layer_04.png", "name": "Skirt", "pos": Vector2(380, 390), "pivot": Vector2(180, 35), "z": 0, "amp": 0.003, "phase": 2.0},
	{"file": "layer_05.png", "name": "Torso", "pos": Vector2(445, 230), "pivot": Vector2(128, 190), "z": 1, "amp": 0.006, "phase": 0.5},
	{"file": "layer_03.png", "name": "Head", "pos": Vector2(425, 52), "pivot": Vector2(154, 250), "z": 2, "amp": 0.008, "phase": 1.8},
	{"file": "layer_10.png", "name": "ArmL", "pos": Vector2(280, 270), "pivot": Vector2(162, 36), "z": 3, "amp": 0.012, "phase": 1.0},
	{"file": "layer_07.png", "name": "ArmRWhipHandle", "pos": Vector2(640, 328), "pivot": Vector2(40, 52), "z": 3, "amp": 0.018, "phase": 2.4},
	{"file": "layer_06.png", "name": "ArmLHand", "pos": Vector2(185, 325), "pivot": Vector2(230, 45), "z": 4, "amp": 0.012, "phase": 2.8},
	{"file": "layer_11.png", "name": "BootL", "pos": Vector2(330, 765), "pivot": Vector2(104, 30), "z": 4, "amp": 0.0, "phase": 0.0},
	{"file": "layer_12.png", "name": "BootR", "pos": Vector2(545, 760), "pivot": Vector2(100, 30), "z": 4, "amp": 0.0, "phase": 0.0},
]

var _parts: Array[Node2D] = []


func _ready() -> void:
	for child in get_children():
		child.queue_free()

	_parts.clear()
	for part in PARTS:
		var holder := Node2D.new()
		holder.name = part["name"]
		holder.position = part["pos"]
		holder.z_index = part["z"]
		add_child(holder)

		var sprite := Sprite2D.new()
		sprite.texture = _load_png_texture("%s/%s" % [LAYER_DIR, part["file"]])
		sprite.centered = false
		sprite.position = -part["pivot"]
		holder.add_child(sprite)

		_parts.append(holder)

	set_process(true)


func _process(_delta: float) -> void:
	var t := Time.get_ticks_msec() / 1000.0
	for index in _parts.size():
		var holder := _parts[index]
		var part = PARTS[index]
		holder.rotation = sin(t * 0.85 + part["phase"]) * part["amp"]


func _load_png_texture(path: String) -> Texture2D:
	var image := Image.new()
	if image.load(path) != OK:
		return null
	return ImageTexture.create_from_image(image)
