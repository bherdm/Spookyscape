extends Position2D

var ghost_preview_scene = load("res://Characters/Ghost_Preview.tscn")

func e():
	var new_ghost_preview = ghost_preview_scene.instance()
	App_SceneLoader.current_stage_manager.add_child(new_ghost_preview)
	new_ghost_preview.set_global_pos(get_global_pos())
	#App_SceneLoader.current_stage_manager.new_enemy()
	print("ghost_preview spawned!")
