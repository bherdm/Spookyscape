extends Node2D

onready var anim = get_node("AnimationPlayer")

export var path_to_game_scene = "level"

func _ready():
	anim.play("move_witch")
	set_fixed_process(true)


func _on_Fly_Button_button_down():
	anim.play("fade_out_and_to_black")



func _on_AnimationPlayer_finished():
	if anim.get_current_animation() == "fade_out_and_to_black":
		App_SceneLoader.load_scene(path_to_game_scene + ".tscn")

func _on_About_Button_button_down():
	about_scroll.get_v_scroll().set_value(0)
	anim.play("Fade_to_About")


func _on_Back_Button_button_down():
	anim.play("Fade_From_About")

onready var about_scroll = get_node("CanvasLayer/About_Container/About_CenterContainer/RichTextLabel")
export var scroll_speed = 3
func _fixed_process(delta):
	if Input.is_action_pressed("ui_up"):
		about_scroll.get_v_scroll().set_value(about_scroll.get_v_scroll().get_value() - scroll_speed)
	if Input.is_action_pressed("ui_down"):
		about_scroll.get_v_scroll().set_value(about_scroll.get_v_scroll().get_value() + scroll_speed)

func _on_Quit_Button_button_down():
	get_tree().quit()