extends SceneTree


func _init() -> void:
	var args := OS.get_cmdline_user_args()
	if args.size() != 3:
		push_error("Usage: godot --headless --script scripts/extract-pck-path.gd -- <pck> <res_path_without_res_prefix> <output_dir>")
		quit(2)
		return

	var pck_path := args[0]
	var source_path := args[1].trim_prefix("res://")
	var output_dir := args[2]

	if not ProjectSettings.load_resource_pack(pck_path):
		push_error("Failed to load PCK: %s" % pck_path)
		quit(1)
		return

	var source_res := "res://%s" % source_path
	var err := _extract(source_res, output_dir.path_join(source_path.get_file()) if not source_path.ends_with("/") else output_dir)
	quit(0 if err == OK else 1)


func _extract(source_res: String, output_path: String) -> Error:
	var dir := DirAccess.open(source_res)
	if dir != null:
		DirAccess.make_dir_recursive_absolute(output_path)
		dir.list_dir_begin()
		while true:
			var name := dir.get_next()
			if name.is_empty():
				break
			if name == "." or name == "..":
				continue
			var child_source := source_res.path_join(name)
			var child_output := output_path.path_join(name)
			var err := _extract(child_source, child_output)
			if err != OK:
				return err
		return OK

	if not FileAccess.file_exists(source_res):
		push_error("Source path not found in mounted PCK: %s" % source_res)
		return ERR_DOES_NOT_EXIST

	var bytes := FileAccess.get_file_as_bytes(source_res)
	if bytes.is_empty() and FileAccess.get_open_error() != OK:
		push_error("Failed to read: %s" % source_res)
		return FileAccess.get_open_error()

	DirAccess.make_dir_recursive_absolute(output_path.get_base_dir())
	var out := FileAccess.open(output_path, FileAccess.WRITE)
	if out == null:
		push_error("Failed to write: %s" % output_path)
		return FileAccess.get_open_error()
	out.store_buffer(bytes)
	return OK
