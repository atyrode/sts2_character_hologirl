extends SceneTree


func _init() -> void:
	var classes := [
		"SpineSprite",
		"SpineSkeletonDataResource",
		"SpineSkeletonFileResource",
		"SpineAtlasResource",
		"SpineAtlasResourceFormatLoader",
		"SpineSkeletonFileResourceFormatLoader",
	]

	for type_name in classes:
		print("%s=%s" % [type_name, ClassDB.class_exists(type_name)])

	var args := OS.get_cmdline_user_args()
	for path in args:
		var res := ResourceLoader.load(path)
		print("load %s -> %s" % [path, "<null>" if res == null else res.get_class()])

	quit(0)
