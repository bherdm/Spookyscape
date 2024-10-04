extends Area2D

func _on_Enemy_Catcher_body_enter( body ):
	if body.has_method("exit_ghost"):
a		body.exit_ghost()
