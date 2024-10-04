extends Area2D

func _on_Enemy_Preview_Catcher_body_enter( body ):
	if body.has_method("crossed_screen"):
		body.crossed_screen()