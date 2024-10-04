extends Control

onready var anim = get_node("AnimationPlayer")

var anim_stage = 0
# 1 = display is over and fade to black next
# 2 = fade to black is over and load next_stage
# 3 = fade to black is over and load skip_stage

export var path_to_next_stage = ""
export var path_to_skip_stage = "Stages/title"

func _ready():
	anim.play("logo_anim")
	set_process_input(true)

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		anim_stage = 3
		anim.play("fade_to_black_fast")

func _on_AnimationPlayer_finished():
	anim_stage += 1
	if anim_stage == 1:
		anim.play("fade_to_black")
	elif anim_stage == 2:
		App_SceneLoader.load_scene(path_to_next_stage + ".tscn")
	else:
		if anim.get_current_animation() != "fade_to_black_fast":
			anim.play("fade_to_black_fast")
		else:
			App_SceneLoader.load_scene(path_to_skip_stage + ".tscn")

