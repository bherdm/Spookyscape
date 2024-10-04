extends Panel

onready var fly_again_button = get_node("CenterContainer/VBoxContainer/HBoxContainer/Again_Button")
onready var score_label = get_node("CenterContainer/VBoxContainer/Score_Label")
onready var combo_label = get_node("CenterContainer/VBoxContainer/Combo_Label")

func game_over(score):
	score_label.set_text(str(score))
	combo_label.set_text("Best Combo: " + str(App_SceneLoader.current_stage_manager.best_combo))
	fly_again_button.grab_focus()