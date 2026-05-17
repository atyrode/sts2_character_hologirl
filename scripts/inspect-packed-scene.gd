extends SceneTree

func _initialize() -> void:
	var args := OS.get_cmdline_user_args()
	if args.size() < 2:
		print("Usage: godot --headless --script scripts/inspect-packed-scene.gd -- <pack-path> <scene-path>")
		quit(2)
		return

	var pack_path := args[0]
	var scene_path := args[1]
	if not ProjectSettings.load_resource_pack(pack_path):
		push_error("Failed to load pack: " + pack_path)
		quit(1)
		return

	var scene := load(scene_path)
	if scene == null:
		push_error("Failed to load scene: " + scene_path)
		quit(1)
		return

	var root: Node = scene.instantiate()
	print(scene_path)
	_print_node(root, 0)
	root.free()
	quit(0)

func _print_node(node: Node, depth: int) -> void:
	var indent := ""
	for i in depth:
		indent += "  "

	var script_path := ""
	var script: Variant = node.get_script()
	if script != null and script is Resource:
		script_path = " script=" + script.resource_path

	print("%s%s <%s>%s" % [indent, node.name, node.get_class(), script_path])
	for child in node.get_children():
		_print_node(child, depth + 1)
