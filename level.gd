extends Node2D

onready var score_label = get_node("CanvasLayer/HUD/L_Score")
onready var witch = get_node("witch")
onready var GameOverPanel = get_node("CanvasLayer/GameOverPanel")
onready var HUDPanel = get_node("CanvasLayer/HUD")
onready var parallax_fog_canvases = [get_node("ParallaxFogForeground"),get_node("ParallaxFogBackground")]
onready var anim = get_node("AnimationPlayer")
onready var DeathWall = get_node("DeathWall")
onready var EnemySpawner = get_node("EnemySpawner")
onready var enemy_label = get_node("CanvasLayer/HUD/L_Enemy")
var enemies = 0

func new_enemy():
	enemies += 1
	enemy_label.set_text(str(enemies))
func remove_enemy():
	enemies -= 1
	enemy_label.set_text(str(enemies))


var score = 0.0
var score_to_speed_inc = 2.0
export var fog_fade_start = 200
export var fog_fade_end = -1500.0
var enemy_move_speed = 2400
export var game_is_in_play = true

var combo_tolerance_sec = 2.0
var combo_sec = 0.0
var current_combo = 0
var best_combo = 0

func enemy_hit():
	combo_sec = combo_tolerance_sec
	current_combo += 1
	enemy_label.set_text(str(current_combo))

func combo_process(delta):
	combo_sec -= delta
	if combo_sec <= 0.0:
		combo_sec = 0.0
		
		if current_combo > best_combo:
			best_combo = current_combo
		current_combo = 0
	
	var percent_time_remaining = extended_func.inverse_lerp(combo_tolerance_sec, 0.0, combo_sec)
	var new_opacity = lerp(1.0, 0.0, percent_time_remaining)
	enemy_label.set_opacity(new_opacity)

func _ready():
	App_SceneLoader.current_stage_manager = self
	set_fog_transparency(1.0)
	set_process(true)
	anim.play("fade_from_black")

func _process(delta):
	var rounded_pos = round(witch.get_global_pos().x/500.0)
	
	if rounded_pos > score:
		score = rounded_pos
		witch.max_thrust = witch.max_thrust + score_to_speed_inc
		DeathWall.move_speed = DeathWall.move_speed + score_to_speed_inc
		EnemySpawner.move_speed = EnemySpawner.move_speed + score_to_speed_inc
	
	score_label.set_text(str(score))
	
	if witch.get_global_pos().y < fog_fade_start:
		lerp_fog_transparency()
	combo_process(delta)

func inverse_lerp(a,b,value):
	if a != b:
		return (value -a)/(b-a)
	else:
		return 0.0

func lerp_fog_transparency():
	var progress_through_fog_zone = inverse_lerp(fog_fade_end, fog_fade_start, witch.get_global_pos().y)
	progress_through_fog_zone = clamp(progress_through_fog_zone, 0.0, 1.0)
	set_fog_transparency(progress_through_fog_zone)

func set_fog_transparency(new_opacity):
	for canvas in parallax_fog_canvases:
		for layer in canvas.get_children():
			layer.set_opacity(new_opacity)

func game_over():
	if game_is_in_play:
		game_is_in_play = false
		HUDPanel.hide()
		GameOverPanel.show()
		GameOverPanel.game_over(score)

export var path_to_next_scene = "level"

func back_to_title():
	anim.play("fade_to_black")
	path_to_next_scene = "Stages/title"
	

func restart_game():
	anim.play("fade_to_black")

func _on_AnimationPlayer_finished():
	if anim.get_current_animation() == "fade_to_black":
		#get_tree().reload_current_scene()
		App_SceneLoader.load_scene(path_to_next_scene + ".tscn")


func _on_Title_Button_button_down():
	back_to_title()
