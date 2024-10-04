extends Node2D

var explosion = load("res://Characters/explosion.tscn")
var my_explosion
var dying = false

func _ready():
	set_fixed_process(true)
	create_explosion()

var move_speed = -20
export var death_time = 0.35
var player_left_buffer = 500

func _fixed_process(delta):
	set_pos(Vector2(get_pos().x + move_speed * delta, get_pos().y))
	if get_pos().x <= App_SceneLoader.current_stage_manager.witch.get_pos().x - player_left_buffer:
		exit_ghost()
	if move_speed > 0: #if dying
		death_time -= delta
	if death_time <= 0.0:
		die()

func whacked():
	App_SceneLoader.current_stage_manager.enemy_hit()
	dying = true
	move_speed = 1200 + (App_SceneLoader.current_stage_manager.score * App_SceneLoader.current_stage_manager.score_to_speed_inc)

func create_explosion():
	my_explosion = explosion.instance()

func exit_ghost():
	#App_SceneLoader.current_stage_manager.remove_enemy()
	queue_free()

func die():
	get_parent().add_child(my_explosion)
	my_explosion.set_pos(get_pos())
	my_explosion.emit_explosion()
	#App_SceneLoader.current_stage_manager.remove_enemy()
	queue_free()