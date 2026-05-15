extends SceneTree

func _init() -> void:
	var scene: PackedScene = load("res://Hologirl/scenes/character_select/hologirl_character_select_bg.tscn")
	if scene == null:
		push_error("Could not load Hologirl character-select background scene.")
		quit(1)
		return

	var node: Control = scene.instantiate()
	node.size = Vector2(1920.0, 1080.0)
	root.add_child(node)

	await process_frame
	await create_timer(0.25).timeout

	var particles := node.find_child("HologirlParticles", true, false)
	if particles == null or particles.get_child_count() == 0:
		push_error("Hologirl character-select particles did not spawn.")
		quit(1)
		return

	print("Hologirl character-select scene smoke passed.")
	quit(0)
