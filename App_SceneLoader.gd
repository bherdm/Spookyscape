extends Node

var current_stage_manager

func load_scene(path_to_next_scene):
	get_tree().change_scene("res://" + path_to_next_scene)