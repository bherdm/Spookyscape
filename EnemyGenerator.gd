extends PathFollow2D

var ghost = load("res://Ghost.tscn")

func _ready():
	set_process(true)

func _process(delta):
	set_offset(get_offset() + 800 * delta)



func _on_Timer_timeout():
	if App_SceneLoader.current_stage_manager.game_is_in_play:
		var new_ghost = ghost.instance()
		get_parent().get_parent().get_parent().add_child(new_ghost)
		new_ghost.set_global_pos(get_global_pos())
