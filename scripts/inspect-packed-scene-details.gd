extends SceneTree

func _initialize() -> void:
	var args := OS.get_cmdline_user_args()
	if args.size() < 2:
		push_error("Usage: godot --headless --script scripts/inspect-packed-scene-details.gd -- <pck> <scene-path>")
		quit(2)
		return

	var pck_path: String = args[0]
	var scene_path: String = args[1]
	if not ProjectSettings.load_resource_pack(pck_path):
		push_error("Failed to load pack: %s" % pck_path)
		quit(1)
		return

	var scene := load(scene_path) as PackedScene
	if scene == null:
		push_error("Failed to load scene: %s" % scene_path)
		quit(1)
		return

	print(scene_path)
	var state := scene.get_state()
	for node_index in range(state.get_node_count()):
		var node_path := str(state.get_node_path(node_index))
		var node_name := str(state.get_node_name(node_index))
		var node_type := str(state.get_node_type(node_index))
		print("%s <%s> path=%s" % [node_name, node_type, node_path])
		for property_index in range(state.get_node_property_count(node_index)):
			var property_name := str(state.get_node_property_name(node_index, property_index))
			if _should_print_property(property_name):
				var value = state.get_node_property_value(node_index, property_index)
				print("  %s = %s" % [property_name, var_to_str(value)])

	quit()

func _should_print_property(property_name: String) -> bool:
	return property_name in [
		"position",
		"scale",
		"offset_left",
		"offset_top",
		"offset_right",
		"offset_bottom",
		"script",
		"skeleton_data_res",
		"preview_skin",
		"initial_skin",
		"autoplay",
		"default_mix",
	]
