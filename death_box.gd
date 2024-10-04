extends Node2D

onready var witch = get_node("../witch")

export var move_speed = 50.0
var start_x_distance_from_witch
var x_buffer = 500.0

func _ready():
	start_x_distance_from_witch = witch.get_pos().x - get_pos().x
	set_process(true)

func _process(delta):
	if App_SceneLoader.current_stage_manager.game_is_in_play:
		var new_x_pos = get_pos().x + (move_speed * delta)
		
		if new_x_pos < witch.get_pos().x - (start_x_distance_from_witch + x_buffer):
			new_x_pos = witch.get_pos().x - (start_x_distance_from_witch + x_buffer)
		
		set_pos(Vector2(new_x_pos, witch.get_pos().y))
	if get_pos().x > witch.get_pos().x:
		witch.die()