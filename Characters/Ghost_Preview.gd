extends Node2D

var ghost_scene = load("res://Characters/Ghost_Purple.tscn")
var my_ghost

func _ready():
	move_speed = App_SceneLoader.current_stage_manager.enemy_move_speed
	set_fixed_process(true)

#Need to move for a particular amount of time, speed needs to increase with player speed

var move_speed = 2400
var player_buffer = 600

func _fixed_process(delta):
	set_pos(Vector2(get_pos().x + move_speed * delta, get_pos().y))
#	if get_pos().x >= App_SceneLoader.current_stage_manager.witch.get_pos().x + player_buffer:
#		crossed_screen()

func crossed_screen():
	my_ghost = ghost_scene.instance()
	get_parent().add_child(my_ghost)
	my_ghost.set_pos(get_pos())
	queue_free()

func _on_Timer_timeout():
	crossed_screen()
