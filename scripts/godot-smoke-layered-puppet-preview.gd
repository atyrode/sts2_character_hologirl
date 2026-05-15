extends SceneTree

func _init() -> void:
	var scene: PackedScene = load("res://docs/design/art_archive/menu/character_select_layers/layered_puppet_attempt-002/preview/layered_puppet_attempt_002_preview.tscn")
	if scene == null:
		push_error("Could not load layered puppet attempt 002 preview scene.")
		quit(1)
		return

	var node := scene.instantiate()
	root.add_child(node)
	await process_frame

	if node.get_child_count() < 10:
		push_error("Layered puppet preview did not build enough parts.")
		quit(1)
		return

	for holder in node.get_children():
		if holder.get_child_count() == 0:
			push_error("Layered puppet preview part has no sprite: %s" % holder.name)
			quit(1)
			return
		var sprite := holder.get_child(0) as Sprite2D
		if sprite == null or sprite.texture == null:
			push_error("Layered puppet preview part has no texture: %s" % holder.name)
			quit(1)
			return

	print("Layered puppet attempt 002 preview smoke passed.")
	quit(0)
