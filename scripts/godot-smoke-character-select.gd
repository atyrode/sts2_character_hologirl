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

	var back_particles := node.find_child("HologirlBackParticles", true, false)
	var front_particles := node.find_child("HologirlFrontParticles", true, false)
	var particle_count := 0
	if back_particles != null:
		particle_count += back_particles.get_child_count()
	if front_particles != null:
		particle_count += front_particles.get_child_count()

	if particle_count == 0:
		push_error("Hologirl character-select particles did not spawn.")
		quit(1)
		return

	var tuning_panel := node.find_child("HologirlTuningPanel", true, false)
	if tuning_panel == null:
		push_error("Hologirl character-select tuning panel did not spawn.")
		quit(1)
		return

	var background := node.find_child("SimpleBackground", true, false)
	if background == null or background.texture == null:
		push_error("Hologirl character-select generated background texture did not load.")
		quit(1)
		return

	var collapse_button := node.find_child("Collapse", true, false)
	if collapse_button == null:
		push_error("Hologirl character-select collapse button did not spawn.")
		quit(1)
		return

	node._character_pos = Vector2(1010.0, 260.0)
	node._character_scale = 0.88
	node._whip_density = 0.33
	node._drift_density = 1.25
	node._whip_jitter = 3.5
	node._background_variant = 2
	node._character_variant = 2
	node._save_tuning_values()
	node.queue_free()

	var restored_node: Control = scene.instantiate()
	restored_node.size = Vector2(1920.0, 1080.0)
	root.add_child(restored_node)
	await process_frame

	if restored_node._character_pos != Vector2(1010.0, 260.0):
		push_error("Hologirl character-select tuner did not restore saved position.")
		quit(1)
		return

	if not is_equal_approx(restored_node._character_scale, 0.88):
		push_error("Hologirl character-select tuner did not restore saved scale.")
		quit(1)
		return

	if not is_equal_approx(restored_node._whip_density, 0.33) or not is_equal_approx(restored_node._drift_density, 1.25) or not is_equal_approx(restored_node._whip_jitter, 3.5):
		push_error("Hologirl character-select tuner did not restore saved particle values.")
		quit(1)
		return

	if restored_node._background_variant != 2:
		push_error("Hologirl character-select tuner did not restore saved background variant.")
		quit(1)
		return

	if restored_node._character_variant != 2:
		push_error("Hologirl character-select tuner did not restore saved character variant.")
		quit(1)
		return

	print("Hologirl character-select scene smoke passed.")
	quit(0)
