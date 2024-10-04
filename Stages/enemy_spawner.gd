extends Position2D

onready var anim = get_node("AnimationPlayer")

var ghost_preview_scene = load("res://Characters/Ghost_Preview.tscn")

var next_distance_to_spawn = 500
var spawn_gaps = 2000
var animations
var move_speed = 150.0
var spawning = false
var witch_x_buffer = 25

func _ready():
	set_process(true)
	animations = anim.get_animation_list()

func _process(delta):
	if (spawning):
		set_pos(Vector2(get_pos().x + (move_speed *delta), get_pos().y))
	else:
		set_pos(Vector2(App_SceneLoader.current_stage_manager.witch.get_pos().x - witch_x_buffer, get_pos().y))

func spawn_enemies():
	var random_index = randi() % animations.size()
	var random_anim = animations[random_index]
	App_SceneLoader.current_stage_manager.enemy_move_speed = App_SceneLoader.current_stage_manager.enemy_move_speed + (App_SceneLoader.current_stage_manager.score * App_SceneLoader.current_stage_manager.score_to_speed_inc)
	spawning = true
	anim.play(random_anim)
	
	
	
	
	
#	for child in get_children():
#		if child.is_type("Position2D"):
#			var new_ghost_preview = ghost_preview_scene.instance()
#			get_parent().get_parent().add_child(new_ghost_preview)
#			new_ghost_preview.set_global_pos(child.get_global_pos())
#			print("ghost_preview spawned!")
	pass

func _on_Timer_timeout():
	if App_SceneLoader.current_stage_manager.witch.get_pos().x >= next_distance_to_spawn + (App_SceneLoader.current_stage_manager.score * 32):
		next_distance_to_spawn += spawn_gaps
		spawn_enemies()


func _on_AnimationPlayer_finished():
	spawning = false
